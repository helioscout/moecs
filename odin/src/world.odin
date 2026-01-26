package moecs

import "core:slice"
import str "core:strings"
import sa "core:container/small_array"
import "core:fmt"

World :: struct {
	/* Query match approach. */
	approach : Approach,
	/* Registered component types. */
	components : Components,
	/* Registered tag types. */
	tags : Tags,
	/* Registered resource types with its instances (values).
	   Collection of all world resources. */
	resources : Resources,
	/* Mounted systems. */
	systems : [dynamic]^System,
	/* Archetypes collection of the world. */
	archetypes : [dynamic]^Archetype,
	/* Blocks for entities with quick lifetime. */
	quicks : [dynamic]^Block,
	/* Blocks for entities with dynamic lifetime. */
	dynamics : [dynamic]^Block,
	/* Blocks for entities with static lifetime. */
	statics : [dynamic]^Block,
	/* Defines that world uses quick lifetime (default: true).
	   If at least one component is registered without a buffer it will be set to false.
	   If disabled than all attempts to create quick lifetime entites will fail. */
	use_quicks : bool,
	/* Buffer for quick life time entities, must be provided from the main app. */
	buffer : ^[QUICK_CHUNK_SIZE]Entity,
	/* Deleted (freed) rows in the quick lifetime buffer. */
	deleted: sa.Small_Array(QUICK_CHUNK_SIZE, int),
	/* Current inserting index in the quick lifetime buffer (last inserted index + 1). */
	idx : int,
	/* Indicates that the world is running. */
	running : bool,
	/* Indicates that the world is in performing stage (runs deffered actions). */
	performing : bool,
	/* Deffered actions for the world. */
	deffered : Deffered
}

/* Initializes the world.
   `world` : Pointer to the world. */
@(private="package")
world_init :: proc(world: ^World) {
}

/* Registers element type for the world.
   `world`   : Pointer to the world.
   `element` : World element kind.
   `$Type`   : Element (component/tag/resource) type.
   `buffer`  : Pointer to buffer for quick lifetime chunk. Ensure that you don't use same buffers for different worlds.*/
register :: proc(world: ^World, element: Element, $Type: typeid, buffer : rawptr = nil) {
	if world.running do return

	#partial switch element {
		case .COMPONENT:
			components_add(&world.components, Type, { type = Type, size = size_of(Type), buffer = buffer,
				idx = world.components.count })
			if buffer == nil do world.use_quicks = false
		case .TAG:
			tags_add(&world.tags, Type, { type = Type, idx = world.tags.count })
		case .RESOURCE:
			world.resources[Type] = { type = Type, value = new(Type) }
	}
}

/* Mounts new system to the world.
   `world`      : Pointer to the world.
   `definition` : System definition. */
mount :: proc(world: ^World, definition: SystemDefinition) {
	if len(definition.name) > 0 && has_system(world, definition.name) do panic("System with such name has already been mounted.")
	if len(definition.components) == 0 && len(definition.tags) == 0 do panic("Components or tags must be specified.")
	if definition.callback == nil do panic("Callback must be provided.")
	if world.running do panic("You can't change already running world.")

	system : ^System = new(System)

	system^ = { name = definition.name, state = { .ENABLED }, callback = definition.callback,
				lifetime = card(definition.lifetime) == 0 ? { .QUICK, .DYNAMIC, .STATIC } : definition.lifetime }

	if len(definition.components) > 0 {
		for type in definition.components {
			if idx, ok := component_index(&world.components, type); ok {
				marker_set(COMPONENTS_MARKER_SIZE, &system.components, idx)
			}
		}

		system.state += { .HAS_COMPONENTS }
	}

	if len(definition.tags) > 0 {
		for type in definition.tags {
			if idx, ok := tag_index(&world.tags, type); ok {
				marker_set(TAGS_MARKER_SIZE, &system.tags, idx)
			}
		}

		system.state += { .HAS_TAGS }
	}

	append(&world.systems, system)
}

/* Unmounts the system from the world.
   `world` : Pointer to the world.
   `name`  : System name. */
unmount :: proc(world: ^World, name: string) {
	for system, index in world.systems {
		if str.compare(system.name, name) == 0 {
			delete(system.entities)
			unordered_remove(&world.systems, index)
			
			break
		}
	}
}

/* Runs the world, but at first constructs all neccessary data from registered elements.
   World must has at least one registered component, but can has no tags, resources.
   `world` : Pointer to the world. */
run :: proc(world: ^World) {
	if world.components.count == 0 do panic("The world has no registered components.")
	if world.running do return

	perform(world)

	world.running = true
}

/* Spawns new entity into the world.
   `world`    : Pointer to the world.
   `lifetime` : Entity lifetime (default: Lifetime.DYNAMIC).
   `returns`  : Pointer to new entity.
*/
spawn :: proc(world: ^World, lifetime: Lifetime = .DYNAMIC) -> ^Entity {
	entity: ^Entity = ---

	switch lifetime {
		case .QUICK: {
			if !world.use_quicks do panic("Quick lifetime was disabled, you should provide entity and components buffers.")

			if sa.len(world.deleted) == 0 && world.idx == QUICK_CHUNK_SIZE {
			    /* If buffers are full we must flush them to free quick block. */
			    block_absorb(get_free_block(world, .QUICK))
				/* And reset current inserting index. */
				world.idx = 0
			}

			idx := pop_free_index(world)	/* Here we increase inserting index. */
			
			/* state has BUFFERED is a sign that entity is in the quick lifetime buffer, not a real block.		  */
			/* But chunk_idx will not change when flushed. We need assign world reference for access the buffer. */
			world.buffer[idx] = Entity { state = { .BUFFERED }, world = world, chunk_idx = idx }
			entity = &world.buffer[idx]
		}
			
		case .DYNAMIC, .STATIC: entity = block_insert(get_sparse_block(world, lifetime))
	}

	return entity
}

/* Despawns entity from the world.
   `world`  : Pointer to the world.
   `entity` : Reference to the entity. */
despawn_entity :: proc(world: ^World, entity: ^Entity) {
	if deleted(entity) do return
	
	if world.approach == .ARCHETYPE && world.running && !world.performing {
		append(&world.deffered.despawning, entity)
	} else {
		if .BUFFERED in entity.state {
			sa.append(&world.deleted, entity.chunk_idx)
		} else {
			block_delete(entity.block, entity.chunk_idx)
		}
	}

	entity.state += { .DELETED }
}

/* Despawns entities from the world.
   `world`    : Pointer to the world.
   `entities` : References to the entities. */
despawn_entities :: #force_inline proc(world: ^World, entities: ..^Entity) {
	for entity in entities do despawn_entity(world, entity)
}

/* Creates new empty block in the world.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to newly created block. */
@(private="file")
new_block :: proc(world: ^World, lifetime: Lifetime) -> ^Block {
	block: ^Block = new(Block)
	
	switch lifetime {
		case .QUICK:
			block^ = { lifetime = .QUICK, world = world, size = QUICK_CHUNK_SIZE }
			append(&world.quicks, block)
		case .DYNAMIC:
			block^ = { lifetime = .DYNAMIC, world = world, size = DYNAMIC_CHUNK_SIZE }
			append(&world.dynamics, block)
		case .STATIC:
			block^ = { lifetime = .STATIC, world = world, size = STATIC_CHUNK_SIZE }
			append(&world.statics, block)
	}

	block_init(block)
	return block
}

/* Gets reference to the resource value by its type.
   `world`   : Pointer to the world.
   `$Type`   : Resource type.
   `returns` : Pointer to the resource and operation success. */
get_resource :: proc(world: ^World, $Type: typeid) -> (^Type, bool) #optional_ok {
	if resource, ok := world.resources[Type]; ok {
		return cast(^Type)resource.value, true
	}

	return nil, false
}

/* Sets resource value by its type.
   `world`    : Pointer to the world.
   `$Type`    : Resource type.
   `resource` : Resource value (will be copied into storage).
   `returns`  : True if resource type was found, otherwise - false. */
set_resource :: proc(world: ^World, $Type: typeid, resource: Type) -> bool {
	if Type in world.resources {
		(cast(^Type)world.resources[Type].value)^ = resource
		return true
	} else {
		return false
	}
}

/* Step through each entity reference in the world.
   `world`    : Pointer to the world.
   `lifetime` : Entities lifetime flag.
*/
each :: proc(world: ^World, lifetime: bit_set[Lifetime; u8] = { .QUICK, .DYNAMIC, .STATIC },
	callback: IteratorCallback) #no_bounds_check {
	if .QUICK in lifetime && world.use_quicks {
		/* Iterate entities in the buffer. */
		for idx in 0..<world.idx {
			if !slice.contains(sa.slice(&world.deleted), idx) {		/* Omit deleted entities. */
				callback(&world.buffer[idx], .QUICK, world)
			}
		}

		for block in world.quicks {
			for idx in 0..<block.idx {
				if marker_is_set(QUICK_MARKER_SIZE, block.occupied, idx) {
					callback(&block.entities[idx], .QUICK, world)
				}
			}
		}
	}

	if .DYNAMIC in lifetime {
		for block in world.dynamics {
			for idx in 0..<block.idx {
				if !slice.contains(sa.slice(&block.deleted), idx) {
					callback(&block.entities[idx], .DYNAMIC, world)
				}
			}
		}
	}

	if .STATIC in lifetime {
		for block in world.statics {
			for idx in 0..<block.idx {
				callback(&block.entities[idx], .STATIC, world)
			}
		}
	}
}

/* Checks if system with specific name was mounted.
   `world`   : Pointer to the world.
   `name`    : System name.
   `returns` : True if system exists, otherwise - false. */
has_system :: #force_inline proc(world: ^World, name: string) -> bool  {
	if len(name) == 0 do panic("System name can't be empty.")

	for system in world.systems {
		if str.compare(system.name, name) == 0 do return true
	}

	return false
}

/* Gets reference to the system by its name.
   `world`   : Pointer to the world.
   `name`    : System name.
   `returns` : Pointer to the system and operation success. */
get_system :: #force_inline proc(world: ^World, name: string) -> (^System, bool) #optional_ok {
	if len(name) == 0 do panic("System name can't be empty.")

	for system in world.systems {
		if str.compare(system.name, name) == 0 do return system, true
	}

	return nil, false
}

/* Progress one step of the world life. Runs all mounted systems.
   `world` : Pointer to the world. */
progress :: proc(world: ^World) {
	if !world.running do panic("Run the world first.")
	
	if world.approach == .ARCHETYPE {
		for system in world.systems {
			if enabled(system) {
				for archetype in world.archetypes {
					if (.HAS_TAGS not_in system.state ||
					   marker_is_subset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, archetype.tags, system.tags)) &&
					   (.HAS_COMPONENTS not_in system.state ||
					   marker_is_subset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, archetype.components, system.components)) {
					   	/* Call system callback for matched archetype. */
						system.callback(&archetype.entities, world)
					}
				}
			}
		}

		perform(world)
	} else if world.approach == .ITERATION {
		for system in world.systems do clear(&system.entities)
	
		each(world, callback = proc(entity: ^Entity, lifetime: Lifetime, world: ^World) {
			for system in world.systems {
				if enabled(system) && lifetime in system.lifetime {
					if (.HAS_TAGS not_in system.state ||
					   marker_is_subset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, entity.tags, system.tags)) &&
					   (.HAS_COMPONENTS not_in system.state ||
					   marker_is_subset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, entity.components, system.components)) {
						/* Add pointer to entity into system collection of entities for current system call. */
						append(&system.entities, entity)
					}
				}
			}
		})

		for system in world.systems {
			if enabled(system) {
				system.callback(&system.entities, world)
			}
		}
	}
}

/* Perform deffered actions for the world.
   `world` : Pointer to the world. */
perform :: proc(world: ^World) {
	world.performing = true

	/* Perform deffered despawning. */
	for entity in world.deffered.despawning {
		despawn_entity(world, entity)
		archetype_remove(entity)
	}

	clear(&world.deffered.despawning)

	/* Perform deffered archetyping. */
	for entity in world.deffered.archetyping {
		if .ARCHETYPING in entity.state && !deleted(entity) {
			archetyping(entity)
			entity.state -= { .ARCHETYPING }
		}
	}

	clear(&world.deffered.archetyping)

	/* We need to delete empty archetypes. */
	archetypes := slice.filter(world.archetypes[:],
		proc(archetype: ^Archetype) -> bool { return len(archetype.entities) == 0 })

	for archetype in archetypes {
		delete(archetype.entities)
		delete_archetype(world, archetype)
	}

	delete(archetypes)

	world.performing = false
}

/* Creates new archetype.
   `world`      : Pointer to the world.
   `components` : Components bitset.
   `tags`       : Tags bitset. */
@(private="file")
new_archetype :: proc(world: ^World, components: [COMPONENTS_MARKER_SIZE]uint,
	tags: [TAGS_MARKER_SIZE]uint) -> ^Archetype {
	archetype: ^Archetype = new(Archetype)

	archetype^ = { components = marker_clone(COMPONENTS_MARKER_SIZE, components),
				   tags = marker_clone(TAGS_MARKER_SIZE, tags) }

	append(&world.archetypes, archetype)

	return archetype
}

/* Gets archetype by query match bitsets.
   `world`      : Pointer to the world.
   `components` : Components bitset.
   `tags`       : Tags bitset.
   `returns`    : Pointer to archetype. */
@(private="package")
get_archetype :: proc(world: ^World, components: [COMPONENTS_MARKER_SIZE]uint,
	tags: [TAGS_MARKER_SIZE]uint) -> ^Archetype {
	for archetype in world.archetypes {
		if marker_equals(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, archetype.components, components) &&
		   marker_equals(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, archetype.tags, tags) {
			return archetype
		}
	}

	return new_archetype(world, components, tags)
}

/* Deletes archetype from the world.
   `world`     : Pointer to the world.
   `archetype` : Pointer to the archetype. */
@(private="package")
delete_archetype :: proc(world: ^World, archetype: ^Archetype) {
	if index, ok := slice.linear_search(world.archetypes[:], archetype); ok {
		unordered_remove(&world.archetypes, index)
	}
}

/* Gets the reference to block that is available to insert new entities,
   has free rows or newly created one. Quick lifetime blocks can't be sparsed.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to available block. */
@(private="file")
get_sparse_block :: proc(world: ^World, lifetime: Lifetime) -> ^Block {
	blocks := get_blocks(world, lifetime)
	
	for block in blocks^ {
		if block_has_free_rows(block) do return block
	}

	return new_block(world, lifetime)
}

/* Gets the reference to block that is totally free.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to free block. */
@(private="file")
get_free_block :: proc(world: ^World, lifetime: Lifetime) -> ^Block {
	blocks := get_blocks(world, lifetime)

	for block in blocks^ {
		if block_is_free(block) do return block
	}

	return new_block(world, lifetime)
}

/* Gets blocks collection by its lifetime.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to free block. */
@(private="file")
get_blocks :: proc(world: ^World, lifetime: Lifetime) -> ^[dynamic]^Block {
	switch lifetime {
		case .QUICK:   return &world.quicks
		case .DYNAMIC: return &world.dynamics
		case .STATIC:  return &world.statics
	}

	return nil
}

/* Returns index of the first free to insert (last deleted) row in the quick lifetime buffer.
   `world`   : Pointer to the world.
   `returns` : Index of the row to insert.
*/
@(private="file")
pop_free_index :: proc(world: ^World) -> int {
	idx: int = ---
	
	if sa.len(world.deleted) == 0 {
		idx = world.idx
		world.idx += 1
	} else {
		idx = sa.pop_back(&world.deleted)
	}

	return idx
}
