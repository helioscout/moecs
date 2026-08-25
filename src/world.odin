package moecs

import "core:mem"
import "core:slice"
import str "core:strings"
import vmem "core:mem/virtual"
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
	/* Registered relation types. */
	relations : Relations,
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
	observable : bool,
	/* Components + Relations chunk size in bytes. */
	chunk_size : int,
	/* Growing virtual memory arena. */
	arena : vmem.Arena,
	/* Arena allocator for dynamic arrays of relations targets. */
	allocator : mem.Allocator
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
	world.observers.turning.related_event = true
	world.observers.turning.unrelated_event = true

	marker_set_all(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, &world.observers.turning.added)
	marker_set_all(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, &world.observers.turning.removed)
	marker_set_all(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, &world.observers.turning.set)
	marker_set_all(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, &world.observers.turning.tagged)
	marker_set_all(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, &world.observers.turning.untagged)
	marker_set_all(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, &world.observers.turning.related)
	marker_set_all(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, &world.observers.turning.unrelated)

	/* Register builtin relations. */
	register(world, .RELATION, ChildOf)
	register(world, .RELATION, ParentOf)
	register(world, .RELATION, RelationOf)

	err := vmem.arena_init_growing(&world.arena)
	if err != .None do panic(fmt.tprintf(ERR_ARENA_INIT, err))
	world.allocator = vmem.arena_allocator(&world.arena)
}

/* Registers element type for the world.
   `world`   : Pointer to the world.
   `element` : World element kind.
   `$Type`   : Element (component/tag/resource) type. */
register :: proc(world: ^World, element: Element, $Type: typeid) {
	if world.running do return

	#partial switch element {
		case .COMPONENT:
			if tags_has(&world.tags, Type) || relations_has(&world.relations, Type) {
				panic(ERR_TYPE_ALREADY_REGISTERED)
			}
			
			components_add(&world.components, Type, { type = Type, size = size_of(Type),
				idx = world.components.count })
			
		case .TAG:
			if components_has(&world.components, Type) || relations_has(&world.relations, Type) {
				panic(ERR_TYPE_ALREADY_REGISTERED)
			}
			
			tags_add(&world.tags, Type, { type = Type, idx = world.tags.count })

		case .RESOURCE:
			resources_add(&world.resources, Type, { type = Type, size = size_of(Type),
				idx = world.resources.count })

		case .RELATION:
			if components_has(&world.components, Type) || tags_has(&world.tags, Type) {
				panic(ERR_TYPE_ALREADY_REGISTERED)
			}
			
			relations_add(&world.relations, Type, { type = Type, size = size_of(Type),
				idx = world.relations.count })
	}
}

/* Mounts new system to the world.
   `world`      : Pointer to the world.
   `name`       : Name of the system. It must be unique. Used for getting the system from the world.
   `query`      : Components, tags and relations list that should match while the system query.
				  You can also separate types using `components`, `tags` and `relations` params of this proc.
				  Using both approaches simultaneously, or crossing or duplicating types in different params is safe.
   `components` : Components list that should match while the system query.
   `tags`       : Tags list that should match while the system query.
   `relations`  : Relations list that should match while the system query.
   `without`    : Components, tags and relations list that should not be added to the entity, so system query
				  will match entities only without them, even if these components, tags or relations were
				  included into main query list.
   `phase`      : System running phase, order in the pipeline. By default equals UPDATE.
   `lifetime`   : Entities lifetime flag to optimize queries and do not process lifetimes
				  that you want to avoid for current system. Not used in ARCHETYPE approach.
   `callback`   : Callback function that will be invoked each step of the world progress. */
mount :: proc(world: ^World, name: string = "", query: []typeid = nil, components: []typeid = nil,
	tags: []typeid = nil, relations: []typeid = nil, without: []typeid = nil, phase: Phase = .UPDATE,
	lifetime: bit_set[Lifetime; u8] = {}, callback: SystemCallback) {
	named := len(name) > 0
	
	if named && has_system(world, name) do panic(ERR_SYSTEM_ALREADY_MOUNTED)
	if !named && phase == .MANUAL do panic(ERR_MANUAL_SYSTEM_NAME_NOT_PROVIDED)
	if callback == nil do panic(ERR_CALLBACK_NOT_PROVIDED)
	if !world.running do panic(ERR_WORLD_IS_NOT_RUNNING)

	system : ^System = new(System)
	system^ = { name = name, state = { .ENABLED }, callback = callback,
				lifetime = card(lifetime) == 0 ? { .DYNAMIC, .STATIC } : lifetime, phase = phase }

	_components := slice.clone_to_dynamic(components)
	_tags       := slice.clone_to_dynamic(tags)
	_relations  := slice.clone_to_dynamic(relations)

	if len(query) > 0 {
		for type in query {
			if components_has(&world.components, type) do append(&_components, type)
			else if tags_has(&world.tags, type) do append(&_tags, type)
			else if relations_has(&world.relations, type) do append(&_relations, type)
		}
	}

	if len(_components) == 0 && len(_tags) == 0 && len(_relations) == 0 && len(without) == 0 {
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

		if len(_relations) > 0 {
			for type in _relations {
				if idx, ok := relation_index(&world.relations, type); ok {
					marker_set(RELATIONS_MARKER_SIZE, &system.relations, idx)
				}
			}

			system.state += { .HAS_RELATIONS }
		}

		if len(without) > 0 {
			has_components, has_tags, has_relations: bool

			for type in without {
				if idx, ok := component_index(&world.components, type); ok {
					marker_set(COMPONENTS_MARKER_SIZE, &system.without_components, idx)
					has_components = true
				} else if idx, ok := tag_index(&world.tags, type); ok {
					marker_set(TAGS_MARKER_SIZE, &system.without_tags, idx)
					has_tags = true
				} else if idx, ok := relation_index(&world.relations, type); ok {
					marker_set(RELATIONS_MARKER_SIZE, &system.without_relations, idx)
					has_relations = true
				}
			}

			if has_components do system.state += { .HAS_WITHOUT_COMPONENTS }
			if has_tags do system.state += { .HAS_WITHOUT_TAGS }
			if has_relations do system.state += { .HAS_WITHOUT_RELATIONS }
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
	delete(_relations)
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
	if callback == nil do panic(ERR_CALLBACK_NOT_PROVIDED)
	if !world.running do panic(ERR_WORLD_IS_NOT_RUNNING)

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
					
				case .RELATED:
					if idx, ok := relation_index(&world.relations, type); ok {
						world.observers.related[idx] = callback
						marker_set(RELATIONS_MARKER_SIZE, &world.observers.setting.related, idx)
					}
					
				case .UNRELATED:
					if idx, ok := relation_index(&world.relations, type); ok {
						world.observers.unrelated[idx] = callback
						marker_set(RELATIONS_MARKER_SIZE, &world.observers.setting.unrelated, idx)
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
	if !world.running do panic(ERR_WORLD_IS_NOT_RUNNING)

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
					
				case .RELATED:
					if idx, ok := relation_index(&world.relations, type); ok {
						marker_unset(RELATIONS_MARKER_SIZE, &world.observers.setting.related, idx)
					}
					
				case .UNRELATED:
					if idx, ok := relation_index(&world.relations, type); ok {
						marker_unset(RELATIONS_MARKER_SIZE, &world.observers.setting.unrelated, idx)
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
	if world.components.count == 0 do panic(ERR_WORLD_HAS_NO_COMPONENTS)
	if world.running do return

	components_adjust(&world.components)

	if world.components.size > STACK_BUFFER_SIZE do panic(ERR_COMPONENTS_SIZE_INVALID)

	relations_adjust(world)

	world.chunk_size = world.components.size + world.relations.size
	
	if world.resources.count > 0 {
		resources_adjust(&world.resources)
		
		if world.resources.size > STACK_BUFFER_SIZE do panic(ERR_RESOURCES_SIZE_INVALID)

		ptr, err := mem.alloc(world.resources.size)
		if err != .None do panic(fmt.tprintf(ERR_STORAGE_ALLOCATION, err))
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
	if !world.running do panic(ERR_WORLD_IS_NOT_RUNNING)

	entity: ^Entity = block_insert(get_sparse_block(world, lifetime))

	if world.observable do spawned_event(world, entity)

	return entity
}

/* Despawns entity and all children from the world.
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

		if is_child(entity) {
			parents := slice.clone(get_parents(entity), context.temp_allocator)
			
			for parent in parents do unrelate_with(parent, ParentOf, entity)

			marker_unset(RELATIONS_MARKER_SIZE, &entity.relations, world.relations.idx_child_of)
		}

		if is_parent(entity) {
			children := slice.clone(get_children(entity), context.temp_allocator)

			for child in children {
				if marker_is_set(RELATIONS_MARKER_SIZE, child.many, world.relations.idx_child_of) {
					/* If child has many parent just unrelate with current one. */
					unrelate_with(child, ChildOf, entity)
				} else {
					/* If current entity is only parent then despawn child. */
					despawn_entity(world, child)
				}
			}

			marker_unset(RELATIONS_MARKER_SIZE, &entity.relations, world.relations.idx_parent_of)
		}

		if is_relation(entity) {
			relatives := slice.clone(get_relatives(entity), context.temp_allocator)
			
			for relative in relatives {
				for idx in 0..<world.relations.count {
					if idx == world.relations.idx_child_of  ||
					   idx == world.relations.idx_parent_of ||
					   idx == world.relations.idx_relation_of {
					   	continue
					}

				   unrelate_by_idx(relative, idx, entity)
				}
			}
			
			marker_unset(RELATIONS_MARKER_SIZE, &entity.relations, world.relations.idx_relation_of)
		}

		if marker_is_any_set(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, entity.relations) {
			for idx in 0..<world.relations.count {
				if idx == world.relations.idx_child_of  ||
				   idx == world.relations.idx_parent_of ||
				   idx == world.relations.idx_relation_of {
				   	continue
				}

				unrelate_all_by_idx(entity, idx)
			}
		}

		if world.observable do despawned_event(world, entity)
	}
}

/* Despawns entities from the world.
   `world`    : Pointer to the world.
   `entities` : References to the entities. */
despawn_entities :: #force_inline proc(world: ^World, entities: ..^Entity) {
	for entity in entities do despawn_entity(world, entity)
}

/* Despawns entities, even from different worlds.
   `entities` : Variadic param of pointers to the entities. */
@(private="package")
despawn_many :: #force_inline proc(entities: ..^Entity) {
	for entity in entities do despawn_entity(entity.block.world, entity)
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
	if !world.running do panic(ERR_WORLD_IS_NOT_RUNNING)

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
				if !slice.contains(block.deleted[:], idx) {
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
	if len(name) == 0 do panic(ERR_SYSTEN_NAME_NOT_PROVIDED)

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
	if len(name) == 0 do panic(ERR_SYSTEN_NAME_NOT_PROVIDED)

	for system in world.systems {
		if str.compare(system.name, name) == 0 do return system, true
	}

	return nil, false
}

/* Progress one step of the world life. Runs all mounted systems for all phases.
   `world` : Pointer to the world. */
progress :: proc(world: ^World) {
	if !world.running do panic(ERR_WORLD_IS_NOT_RUNNING)

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
					   (.HAS_RELATIONS not_in system.state ||
					    marker_is_subset(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, entity.relations, system.relations)) &&
					   (.HAS_WITHOUT_TAGS not_in system.state ||
						marker_is_all_unset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE,
							marker_and(TAGS_MARKER_SIZE, entity.tags, system.without_tags))) &&
					   (.HAS_WITHOUT_COMPONENTS not_in system.state ||
						marker_is_all_unset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE,
							marker_and(COMPONENTS_MARKER_SIZE, entity.components, system.without_components))) &&
					   (.HAS_WITHOUT_RELATIONS not_in system.state ||
						marker_is_all_unset(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE,
							marker_and(RELATIONS_MARKER_SIZE, entity.relations, system.without_relations))) {
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
					   (.HAS_RELATIONS not_in system.state ||
					    marker_is_subset(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, archetype.relations, system.relations)) &&
					   (.HAS_WITHOUT_TAGS not_in system.state ||
						marker_is_all_unset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE,
							marker_and(TAGS_MARKER_SIZE, archetype.tags, system.without_tags))) &&
					   (.HAS_WITHOUT_COMPONENTS not_in system.state ||
						marker_is_all_unset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE,
							marker_and(COMPONENTS_MARKER_SIZE, archetype.components, system.without_components))) &&
					   (.HAS_WITHOUT_RELATIONS not_in system.state ||
						marker_is_all_unset(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE,
							marker_and(RELATIONS_MARKER_SIZE, archetype.relations, system.without_relations))) {
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

	free_all(context.temp_allocator)

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
				    marker_is_subset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, archetype.components, system.components)) &&
				   (.HAS_RELATIONS not_in system.state ||
				    marker_is_subset(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, archetype.relations, system.relations)) &&
				   (.HAS_WITHOUT_TAGS not_in system.state ||
					marker_is_all_unset(MAX_TAGS_COUNT, TAGS_MARKER_SIZE,
						marker_and(TAGS_MARKER_SIZE, archetype.tags, system.without_tags))) &&
				   (.HAS_WITHOUT_COMPONENTS not_in system.state ||
					marker_is_all_unset(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE,
						marker_and(COMPONENTS_MARKER_SIZE, archetype.components, system.without_components))) &&
				   (.HAS_WITHOUT_RELATIONS not_in system.state ||
					marker_is_all_unset(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE,
						marker_and(RELATIONS_MARKER_SIZE, archetype.relations, system.without_relations))) {
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

	vmem.arena_destroy(&world.arena)
}

/* Creates new archetype.
   `world`      : Pointer to the world.
   `components` : Components bitset.
   `tags`       : Tags bitset.
   `relations`  : Relations bitset. */
@(private="file")
new_archetype :: proc(world: ^World, components: [COMPONENTS_MARKER_SIZE]uint,
	tags: [TAGS_MARKER_SIZE]uint, relations: [RELATIONS_MARKER_SIZE]uint) -> ^Archetype {
	archetype: ^Archetype = new(Archetype)

	archetype^ = { components = marker_clone(COMPONENTS_MARKER_SIZE, components),
				   tags = marker_clone(TAGS_MARKER_SIZE, tags),
				   relations = marker_clone(RELATIONS_MARKER_SIZE, relations) }

	append(&world.archetypes, archetype)

	return archetype
}

/* Gets archetype by query match bitsets.
   `world`      : Pointer to the world.
   `components` : Components bitset.
   `tags`       : Tags bitset.
   `relations`  : Relations bitset.
   `returns`    : Pointer to archetype. */
@(private="package")
get_archetype :: proc(world: ^World, components: [COMPONENTS_MARKER_SIZE]uint,
	tags: [TAGS_MARKER_SIZE]uint, relations: [RELATIONS_MARKER_SIZE]uint) -> ^Archetype {
	for archetype in world.archetypes {
		if marker_equals(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, archetype.components, components) &&
		   marker_equals(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, archetype.tags, tags) &&
		   marker_equals(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, archetype.relations, relations) {
			return archetype
		}
	}

	return new_archetype(world, components, tags, relations)
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
