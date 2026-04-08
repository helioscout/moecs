package moecs

import "core:mem"
import "core:slice"
import str "core:strings"
import sa "core:container/small_array"
import "core:fmt"

/* World type, main container of the sapce. The world is built of blocks. */
World :: struct {
	/* Query match approach. */
	approach : Approach,
	/* Registered component types. */
	components : Components,
	/* Registered tag types. */
	tags : Tags,
	/* Registered resource types. */
	resources : Resources,
	/* All mounted systems. */
	systems : [dynamic]^System,
	/* Systems split by phase for running in the pipeline. */
	schedule : Schedule,
	/* Archetypes collection of the world. */
	archetypes : [dynamic]^Archetype,
	/* Blocks for entities with dynamic lifetime. */
	dynamics : [dynamic]^Block,
	/* Blocks for entities with static lifetime. */
	statics : [dynamic]^Block,
	/* Events observers for the world. */
	observers : Observers,
	/* Indicates that the world is running. */
	running : bool,
	/* Indicates that START phase has already executed. */
	started : bool,
	/* Indicates that the world is in performing stage (runs deferred actions). */
	performing : bool,
	/* Deferred actions for the world. */
	deferred : Deferred,
	/* Enables/disables using observers for the world.
	   Disabled by default for performance reason.*/
	observable : bool
}

/* Initializes the world.
   `world` : Pointer to the world. */
@(private="package")
world_init :: proc(world: ^World) {
	/* By default all observers are turned on. */
	world.observers.turning.spawned = true
	world.observers.turning.despawned = true
	world.observers.turning.added_event = true
	world.observers.turning.removed_event = true
	world.observers.turning.set_event = true
	world.observers.turning.tagged_event = true
	world.observers.turning.untagged_event = true

	marker_set_all(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, &world.observers.turning.added)
	marker_set_all(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, &world.observers.turning.removed)
	marker_set_all(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, &world.observers.turning.set)
	marker_set_all(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, &world.observers.turning.tagged)
	marker_set_all(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, &world.observers.turning.untagged)
}

/* Registers element type for the world.
   `world`   : Pointer to the world.
   `element` : World element kind.
   `$Type`   : Element (component/tag/resource) type. */
register :: proc(world: ^World, element: Element, $Type: typeid) {
	if world.running do return

	#partial switch element {
		case .COMPONENT:
			components_add(&world.components, Type, { type = Type, size = size_of(Type),
				idx = world.components.count })
		case .TAG:
			tags_add(&world.tags, Type, { type = Type, idx = world.tags.count })
		case .RESOURCE:
			resources_add(&world.resources, Type, { type = Type, size = size_of(Type),
				idx = world.resources.count })
	}
}

/* Mounts new system to the world.
   `world`      : Pointer to the world.
   `name`       : Name of the system. It must be unique. Used for getting the system from the world.
   `query`      : Components and tags list that should match while the system query.
				  You can also separate types using `components` and `tags` params of this proc.
				  Using both approaches simultaneously, or crossing or duplicating types in different params is safe.
   `components` : Components list that should match while the system query.
   `tags`       : Tags list that should match while the system query.
   `without`    : Components and tags list that should not be added to the entity, so system query
				  will match entities only without them, even if these components and tags were
				  included into main query list.
   `phase`      : System running phase, order in the pipeline. By default equals UPDATE.
   `lifetime`   : Entities lifetime flag to optimize queries and do not process lifetimes
				  that you want to avoid for current system. Not used in ARCHETYPE approach.
   `callback`   : Callback function that will be invoked each step of the world progress. */
mount :: proc(world: ^World, name: string = "", query: []typeid = nil, components: []typeid = nil,
	tags: []typeid = nil, without: []typeid = nil, phase: Phase = .UPDATE, lifetime: bit_set[Lifetime; u8] = {},
	callback: SystemCallback) {
	named := len(name) > 0
	
	if named && has_system(world, name) do panic("System with such name has already been mounted.")
	if !named && phase == .MANUAL do panic("Systems with MANUAL phase must have a name.")
	if callback == nil do panic("Callback must be provided.")
	if !world.running do panic("Run the world first.")

	system : ^System = new(System)
	system^ = { name = name, state = { .ENABLED }, callback = callback,
				lifetime = card(lifetime) == 0 ? { .DYNAMIC, .STATIC } : lifetime, phase = phase }

	_components := slice.clone_to_dynamic(components)
	_tags       := slice.clone_to_dynamic(tags)

	if len(query) > 0 {
		for type in query {
			if components_has(&world.components, type) do append(&_components, type)
			if tags_has(&world.tags, type) do append(&_tags, type)
		}
	}

	if len(_components) == 0 && len(_tags) == 0 && len(without) == 0 {
		/* Task is a system without query it will just run with nil entities list. */
		system.state += { .IS_TASK }
	} else {
		if len(_components) > 0 {
			for type in _components {
				if idx, ok := component_index(&world.components, type); ok {
					marker_set(COMPONENTS_MARKER_SIZE, &system.components, idx)
				}
			}

			system.state += { .HAS_COMPONENTS }
		}

		if len(_tags) > 0 {
			for type in _tags {
				if idx, ok := tag_index(&world.tags, type); ok {
					marker_set(TAGS_MARKER_SIZE, &system.tags, idx)
				}
			}

			system.state += { .HAS_TAGS }
		}

		if len(without) > 0 {
			has_components, has_tags: bool

			for type in without {
				if idx, ok := component_index(&world.components, type); ok {
					marker_set(COMPONENTS_MARKER_SIZE, &system.without_components, idx)
					has_components = true
				} else if idx, ok := tag_index(&world.tags, type); ok {
					marker_set(TAGS_MARKER_SIZE, &system.without_tags, idx)
					has_tags = true
				}
			}

			if has_components do system.state += { .HAS_WITHOUT_COMPONENTS }
			if has_tags do system.state += { .HAS_WITHOUT_TAGS }
		}
	}

	#partial switch phase {
		case .START: append(&world.schedule.start, system)
		case .PRE_UPDATE: append(&world.schedule.pre_update, system)
		case .UPDATE: append(&world.schedule.update, system)
		case .POST_UPDATE: append(&world.schedule.post_update, system)
	}
	
	append(&world.systems, system)

	delete(_components)
	delete(_tags)
}

/* Unmounts the system from the world.
   `world` : Pointer to the world.
   `name`  : System name. */
unmount :: proc(world: ^World, name: string) {
	system: ^System = remove_system(world, &world.systems, name)

	if system != nil {
		remove_system(world, &world.schedule.start, name)
		remove_system(world, &world.schedule.pre_update, name)
		remove_system(world, &world.schedule.update, name)
		remove_system(world, &world.schedule.post_update, name)

		free_system(system)
		free(system)
	}
}

/* Sets observer for specified event and type(s).
   `world`    : Pointer to the world.
   `event`    : Event type.
   `callback` : Observer callback procedure.
   `types`    : Event target component/tag types. */
observe :: proc(world: ^World, event: Event, callback: ObserverCallback, types: []typeid = nil) #no_bounds_check {
	if callback == nil do panic("Callback must be provided.")
	if !world.running do panic("Run the world first.")

	if event == .SPAWNED {
		world.observers.spawned = callback
		world.observers.setting.spawned = true
	} else if event == .DESPAWNED {
		world.observers.despawned = callback
		world.observers.setting.despawned = true
	} else {
		for type in types {
			#partial switch event {
				case .ADDED:
					if idx, ok := component_index(&world.components, type); ok {
						world.observers.added[idx] = callback
						marker_set(COMPONENTS_MARKER_SIZE, &world.observers.setting.added, idx)
					}
					
				case .REMOVED:
					if idx, ok := component_index(&world.components, type); ok {
						world.observers.removed[idx] = callback
						marker_set(COMPONENTS_MARKER_SIZE, &world.observers.setting.removed, idx)
					}
					
				case .SET:
					if idx, ok := component_index(&world.components, type); ok {
						world.observers.set[idx] = callback
						marker_set(COMPONENTS_MARKER_SIZE, &world.observers.setting.set, idx)
					}

				case .TAGGED:
					if idx, ok := tag_index(&world.tags, type); ok {
						world.observers.tagged[idx] = callback
						marker_set(TAGS_MARKER_SIZE, &world.observers.setting.tagged, idx)
					}
					
				case .UNTAGGED:
					if idx, ok := tag_index(&world.tags, type); ok {
						world.observers.untagged[idx] = callback
						marker_set(TAGS_MARKER_SIZE, &world.observers.setting.untagged, idx)
					}
			}
		}
	}
}

/* Unsets observer for specified event and type(s).
   `world`    : Pointer to the world.
   `event`    : Event type.
   `types`    : Event target component/tag types. */
unobserve :: proc(world: ^World, event: Event, types: []typeid = nil) {
	if !world.running do panic("Run the world first.")

	if event == .SPAWNED do world.observers.setting.spawned = false
	else if event == .DESPAWNED do world.observers.setting.despawned = false
	else {
		for type in types {
			#partial switch event {
				case .ADDED:
					if idx, ok := component_index(&world.components, type); ok {
						marker_unset(COMPONENTS_MARKER_SIZE, &world.observers.setting.added, idx)
					}
					
				case .REMOVED:
					if idx, ok := component_index(&world.components, type); ok {
						marker_unset(COMPONENTS_MARKER_SIZE, &world.observers.setting.removed, idx)
					}
					
				case .SET:
					if idx, ok := component_index(&world.components, type); ok {
						marker_unset(COMPONENTS_MARKER_SIZE, &world.observers.setting.set, idx)
					}

				case .TAGGED:
					if idx, ok := tag_index(&world.tags, type); ok {
						marker_unset(TAGS_MARKER_SIZE, &world.observers.setting.tagged, idx)
					}
					
				case .UNTAGGED:
					if idx, ok := tag_index(&world.tags, type); ok {
						marker_unset(TAGS_MARKER_SIZE, &world.observers.setting.untagged, idx)
					}
			}
		}
	}
}

/* Removes the system from collection.
   `world`   : Pointer to the world.
   `systems` : Collection with systems.
   `name`    : System name. */
@(private="file")
remove_system :: proc(world: ^World, systems: ^[dynamic]^System, name: string) -> ^System {
	for system, index in systems^ {
		if str.compare(system.name, name) == 0 {
			unordered_remove(systems, index)
			return system
		}
	}

	return nil
}

/* Runs the world, but at first constructs all necessary data from registered elements.
   World must has at least one registered component, but can has no tags, resources.
   `world` : Pointer to the world. */
run :: proc(world: ^World) {
	if world.components.count == 0 do panic("The world has no registered components.")
	if world.running do return

	components_adjust(&world.components)

	if world.components.size > STACK_BUFFER_SIZE do panic("Total components size must be less than STACK_BUFFER_SIZE.")

	if world.resources.count > 0 {
		resources_adjust(&world.resources)
		
		if world.resources.size > STACK_BUFFER_SIZE do panic("Total resources size must be less than STACK_BUFFER_SIZE.")

		ptr, err := mem.alloc(world.resources.size)
		if err != .None do panic(fmt.tprintf("Storage memory allocation error: %v", err))
		world.resources.storage = ptr
	}

	world.running = true
}

/* Spawns new entity into the world.
   `world`    : Pointer to the world.
   `lifetime` : Entity lifetime (default: Lifetime.DYNAMIC).
   `returns`  : Pointer to new entity.
*/
spawn :: proc(world: ^World, lifetime: Lifetime = .DYNAMIC) -> ^Entity {
	if !world.running do panic("Run the world first.")

	entity: ^Entity = block_insert(get_sparse_block(world, lifetime))

	if world.observable do spawned_event(world, entity)

	return entity
}

/* Despawns entity from the world.
   `world`  : Pointer to the world.
   `entity` : Reference to the entity. */
despawn_entity :: proc(world: ^World, entity: ^Entity) {
	if deleted(entity) do return
	
	if world.approach == .ARCHETYPE && world.running && !world.performing {
		append(&world.deferred.despawning, entity)
		entity.state += { .DESPAWNING }
	} else {
		block_delete(entity.block, entity.chunk_idx)
		entity.state += { .DELETED }

		if world.observable do despawned_event(world, entity)
	}
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

/* Gets reference (pointer) to the resource value by its type.
   `world`   : Pointer to the world.
   `$Type`   : Resource type.
   `returns` : Pointer to the resource and operation success. */
get_resource_mut :: #force_inline proc(world: ^World, $Type: typeid) -> (^Type, bool) #no_bounds_check #optional_ok {
	if r, ok := resources_get(&world.resources, Type); ok {
		ptr := mem.ptr_offset(cast(^u8)world.resources.storage, r.offset)
		return cast(^Type)ptr, true
	}

	return nil, false
}

/* Gets resource value by its type.
   `world`   : Pointer to the world.
   `$Type`   : Resource type.
   `returns` : Resource value and operation success. */
get_resource :: #force_inline proc(world: ^World, $Type: typeid) -> (Type, bool) #no_bounds_check #optional_ok {
	resource: Type = ---

	if r, ok := resources_get(&world.resources, Type); ok {
		ptr := mem.ptr_offset(cast(^u8)world.resources.storage, r.offset)
		mem.copy_non_overlapping(&resource, ptr, size_of(Type))
	}

	return resource, false
}

/* Sets resource value by its type.
   `world`    : Pointer to the world.
   `$Type`    : Resource type.
   `resource` : Reference to resource value (will be copied into storage). */
set_resource :: proc(world: ^World, $Type: typeid, resource: ^Type) #no_bounds_check {
	if !world.running do panic("Run the world first.")

	if r, ok := resources_get(&world.resources, Type); ok {
		ptr := mem.ptr_offset(cast(^u8)world.resources.storage, r.offset)
		cell: ^Type = cast(^Type)ptr
		cell^ = resource^
	}
}

/* Step through each entity reference in the world.
   `world`    : Pointer to the world.
   `lifetime` : Entities lifetime flag.
*/
each :: proc(world: ^World, lifetime: bit_set[Lifetime; u8] = { .DYNAMIC, .STATIC },
	callback: IteratorCallback) #no_bounds_check {
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

/* Progress one step of the world life. Runs all mounted systems for all phases.
   `world` : Pointer to the world. */
progress :: proc(world: ^World) {
	if !world.running do panic("Run the world first.")

	if world.approach == .ARCHETYPE {
		/* Run systems with START phase, we should do it only once. */
		if !world.started {
			step_archetype(world, &world.schedule.start)
			world.started = true
		}

		step_archetype(world, &world.schedule.pre_update)
		step_archetype(world, &world.schedule.update)
		step_archetype(world, &world.schedule.post_update)

		perform(world)
	} else if world.approach == .ITERATION {
		for system in world.systems {
			if !is_task(system) do clear(&system.entities)
		}
	
		each(world, callback = proc(entity: ^Entity, lifetime: Lifetime, world: ^World) {
			for system in world.systems {
				if system_enabled(system) && !is_task(system) && lifetime in system.lifetime {
					if (.HAS_TAGS not_in system.state ||
					    marker_is_subset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, entity.tags, system.tags)) &&
					   (.HAS_COMPONENTS not_in system.state ||
					    marker_is_subset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, entity.components, system.components)) &&
					   (.HAS_WITHOUT_TAGS not_in system.state ||
						marker_is_all_unset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE,
							marker_and(TAGS_MARKER_SIZE, entity.tags, system.without_tags))) &&
					   (.HAS_WITHOUT_COMPONENTS not_in system.state ||
						marker_is_all_unset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE,
							marker_and(COMPONENTS_MARKER_SIZE, entity.components, system.without_components))) {
						/* Add pointer to entity into system collection of entities for current system call. */
						append(&system.entities, entity)
					}
				}
			}
		})

		if !world.started {
			step_iteration(world, &world.schedule.start)
			world.started = true
		}

		step_iteration(world, &world.schedule.pre_update)
		step_iteration(world, &world.schedule.update)
		step_iteration(world, &world.schedule.post_update)
	}
}

/* Progress one step of the world life for one phase and ARCHETYPE approach.
   `world`   : Pointer to the world.
   `systems` : Collection of the systems of particular phase. */
@(private="file")
step_archetype :: #force_inline proc(world: ^World, systems: ^[dynamic]^System) {
	for system in systems^ {
		if system_enabled(system) {
			if is_task(system) {
				system.callback(nil, world)
			} else {
				for archetype in world.archetypes {
					if (.HAS_TAGS not_in system.state ||
					    marker_is_subset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, archetype.tags, system.tags)) &&
					   (.HAS_COMPONENTS not_in system.state ||
					    marker_is_subset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, archetype.components, system.components)) &&
					   (.HAS_WITHOUT_TAGS not_in system.state ||
						marker_is_all_unset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE,
							marker_and(TAGS_MARKER_SIZE, archetype.tags, system.without_tags))) &&
					   (.HAS_WITHOUT_COMPONENTS not_in system.state ||
						marker_is_all_unset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE,
							marker_and(COMPONENTS_MARKER_SIZE, archetype.components, system.without_components))) {
					   	/* Call system callback for matched archetype. */
						system.callback(&archetype.entities, world)
					}
				}
			}
		}
	}
}

/* Progress one step of the world life for one phase and ITERATION approach.
   `world`   : Pointer to the world.
   `systems` : Collection of the systems of particular phase. */
@(private="file")
step_iteration :: #force_inline proc(world: ^World, systems: ^[dynamic]^System) {
	for system in systems^ {
		if system_enabled(system) {
			system.callback(is_task(system) ? nil : &system.entities, world)
		}
	}
}

/* Perform deferred actions for the world.
   `world` : Pointer to the world. */
perform :: proc(world: ^World) {
	world.performing = true

	/* Perform deferred despawning. */
	for entity in world.deferred.despawning {
		despawn_entity(world, entity)
		archetype_remove(entity)
	}

	clear(&world.deferred.despawning)

	/* Perform deferred archetyping. */
	for entity in world.deferred.archetyping {
		if .ARCHETYPING in entity.state && !deleted(entity) {
			archetyping(entity)
			entity.state -= { .ARCHETYPING }
		}
	}

	clear(&world.deferred.archetyping)

	/* We need to delete empty archetypes. */
	archetypes := slice.filter(world.archetypes[:],
		proc(archetype: ^Archetype) -> bool { return len(archetype.entities) == 0 })

	for archetype in archetypes {
		delete_archetype(world, archetype)
	}

	delete(archetypes)

	world.performing = false
}

/* Execute system by its name.
   `world`   : Pointer to the world.
   `name`    : System name. */
execute :: proc(world: ^World, name: string) {
	if system, ok := get_system(world, name); ok {
		if is_task(system) {
			system.callback(nil, world)
		} else {
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
}

/* Checks if the system is enabled.
   `world` : Pointer to the world.
   `name`  : System name. */
enabled :: #force_inline proc(world: ^World, name: string) -> bool {
	if system, ok := get_system(world, name); ok {
		return system_enabled(system)
	}

	return false
}

/* Enables the system.
   `world` : Pointer to the world.
   `name`  : System name. */
enable :: #force_inline proc(world: ^World, name: string) {
	if system, ok := get_system(world, name); ok {
		enable_system(system)
	}
}

/* Disables the system.
   `world` : Pointer to the world.
   `name`  : System name. */
disable :: #force_inline proc(world: ^World, name: string) {
	if system, ok := get_system(world, name); ok {
		disable_system(system)
	}
}

/* Free all world resources.
   `world` : Pointer to the world. */
@(private="package")
free_world :: proc(world: ^World) {
	for system in world.systems {
		free_system(system)
		free(system)
	}
	
	for archetype in world.archetypes {
		free_archetype(archetype)
		free(archetype)
	}

	for block in world.dynamics {
		free_block(block)
		free(block)
	}
	
	for block in world.statics {
		free_block(block)
		free(block)
	}

	delete(world.systems)
	delete(world.archetypes)
	delete(world.dynamics)
	delete(world.statics)
	delete(world.schedule.start)
	delete(world.schedule.pre_update)
	delete(world.schedule.update)
	delete(world.schedule.post_update)
	delete(world.deferred.despawning)
	delete(world.deferred.archetyping)

	free(world.resources.storage)
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
		free_archetype(archetype)
		free(archetype)
	}
}

/* Gets the reference to block that is available to insert new entities,
   has free rows or newly created one.
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
@(cold)
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
   `returns`  : Pointer to blocks collection. */
@(private="file")
get_blocks :: #force_inline proc(world: ^World, lifetime: Lifetime) -> ^[dynamic]^Block {
	switch lifetime {
		case .DYNAMIC: return &world.dynamics
		case .STATIC:  return &world.statics
	}

	return nil
}
