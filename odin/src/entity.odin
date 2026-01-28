package moecs

import "core:fmt"
import "core:mem"

/* Entity type. */
Entity :: struct {
	/* Entity state. */
	state : bit_set[ElementState; u8],
	/* Components marker, each set bit specifies that the component exists in the entity. */
	components : [COMPONENTS_MARKER_SIZE]uint,
	/* Tags marker, each set bit specifies that the tag exists in the entity. */
	tags : [TAGS_MARKER_SIZE]uint,
	using container: struct #raw_union {
		/* Reference to the parent block interface. Use only if stae has not BUFFERED flag. */
		block : ^Block,
		/* Reference to the parent world.
		   If active (state has BUFFERED flag) than entity is in the quick lifetime buffer, not a real block. */
		world : ^World,
	},
	/* The index of the entity in the collection (chunk index for its components). */
	chunk_idx : int,
	/* Archetype reference which entity belongs to. Is nill for entities without components/tags. */
	archetype : ^Archetype,
	/* Entity index in the archetype collection (for fast removing). */
	arch_idx : int
}

/* Adds component to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`    : Pointer to the entity.
   `$Type`     : Component type.
   `component` : Reference to the component instance.
   `perform`   : Perform archetyping of the entity.
				 You should not change this parameter (inner logic). */
add_component :: proc(entity: ^Entity, $Type: typeid, component: ^Type, perform: bool = true) {
	if idx, ok := component_index(&get_world(entity).components, Type); ok {
		set_component(entity, Type, component)					/* Storing value in the chunk. */
		marker_set(COMPONENTS_MARKER_SIZE, &entity.components, idx)		/* Setting marker bit. */

		if perform do archetyping(entity)
	}
}

/* Sets component value in the entity by its type and instance (initializer).
   `entity`    : Pointer to the entity.
   `$Type`     : Component type.
   `component` : Reference to the component instance." */
set_component :: proc(entity: ^Entity, $Type: typeid, component: ^Type) #no_bounds_check {
	world: ^World = get_world(entity)

	if c, ok := components_get(&world.components, Type); ok {
		buffered := .BUFFERED in entity.state

		if buffered || entity.block.lifetime == .QUICK {
			ptr: rawptr = c.buffer if buffered else entity.block.chunks[c.idx]
			cell: ^Type = mem.ptr_offset(cast(^Type)ptr, entity.chunk_idx)

			cell^ = component^
		} else {
			ptr := mem.ptr_offset(cast(^u8)entity.block.storage, world.components.size * entity.chunk_idx + c.offset)
			cell: ^Type = cast(^Type)ptr

			cell^ = component^
		}
	}
}

/* Gets reference to the component value by its type.
   `entity`  : Pointer to the entity.
   `$Type`   : Component type.
   `returns` : Pointer to the component and operation success. */
get_component :: #force_inline proc(entity: ^Entity, $Type: typeid) -> (^Type, bool) #no_bounds_check #optional_ok {
	world: ^World = get_world(entity)

	if c, ok := components_get(&world.components, Type); ok {
		if marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, c.idx) {
			buffered := .BUFFERED in entity.state

			if buffered || entity.block.lifetime == .QUICK {
				ptr: rawptr = c.buffer if buffered else entity.block.chunks[c.idx]
				return mem.ptr_offset(cast(^Type)ptr, entity.chunk_idx), true
			} else {
				ptr := mem.ptr_offset(cast(^u8)entity.block.storage, world.components.size * entity.chunk_idx + c.offset)
				return cast(^Type)ptr, true
			}
		}
	}

	return nil, false
}

/* Removes component from entity by its type.
   `entity`  : Pointer to the entity.
   `type`    : Component type.
   `perform` : Perform archetyping of the entity.
			   You should not change this parameter (inner logic). */
remove_component :: proc(entity: ^Entity, type: typeid, perform: bool = true) {
	if idx, ok := component_index(&get_world(entity).components, type); ok {
		marker_unset(COMPONENTS_MARKER_SIZE, &entity.components, idx)

		if perform do archetyping(entity)
	}
}

/* Removes components from entity of all passed types.
   `entity` : Pointer to the entity.
   `types`  : Companent types. */
remove_components :: proc(entity: ^Entity, types: ..typeid) {
	for type in types do remove_component(entity, type, false)

	archetyping(entity)
}

/* Checks if the enity has a component.
   `entity`  : Pointer to the entity.
   `type`    : Component type.
   `returns` : True if entity has a component, otherwise - false. */
has_component :: proc(entity: ^Entity, type: typeid) -> bool {
	if idx, ok := component_index(&get_world(entity).components, type); ok {
		return marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, idx)
	} else {
		return false
	}
}

/* Checks if the entity has all components of passed types.
   `entity`  : Pointer to the entity.
   `types`   : Companent types.
   `returns` : True if entity has all components, otherwise - false. */
has_components :: proc(entity: ^Entity, types: ..typeid) -> bool {
	world: ^World = get_world(entity)
	has := true

	for type in types {
		if idx, ok := component_index(&world.components, type); ok {
			has &&= marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, idx)
		} else {
			has = false
		}
	}

	return has
}

/* Tags entity with specified tag type.
   `entity`  : Pointer to the entity.
   `type`    : Tag type.
   `perform` : Perform archetyping of the entity.
			   You should not change this parameter (inner logic). */
set_tag :: proc(entity: ^Entity, type: typeid, perform: bool = true) {
	if idx, ok := tag_index(&get_world(entity).tags, type); ok {
		marker_set(TAGS_MARKER_SIZE, &entity.tags, idx)

		if perform do archetyping(entity)
	}
}

/* Tags entity with all passed tag types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
set_tags :: proc(entity: ^Entity, types: ..typeid) {
	world: ^World = get_world(entity)

	for type in types {
		if idx, ok := tag_index(&world.tags, type); ok {
			marker_set(TAGS_MARKER_SIZE, &entity.tags, idx)
		}
	}
	
	archetyping(entity)
}

/* Removes tag from entity.
   `entity`  : Pointer to the entity.
   `type`    : Tag type.
   `perform` : Perform archetyping of the entity.
			   You should not change this parameter (inner logic). */
unset_tag :: proc(entity: ^Entity, type: typeid, perform: bool = true) {
	if idx, ok := tag_index(&get_world(entity).tags, type); ok {
		marker_unset(TAGS_MARKER_SIZE, &entity.tags, idx)
	}
	
	if perform do archetyping(entity)
}

/* Removes tags from entity of all passed types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
unset_tags :: proc(entity: ^Entity, types: ..typeid) {
	world: ^World = get_world(entity)

	for type in types {
		if idx, ok := tag_index(&world.tags, type); ok {
			marker_unset(TAGS_MARKER_SIZE, &entity.tags, idx)
		}
	}

	archetyping(entity)
}

/* Checks if the entity is tagged with specified tag type.
   `entity`  : Pointer to the entity.
   `type`    : Tag type.
   `returns` : True if the entity has tag, otherwise - false. */
has_tag :: proc(entity: ^Entity, type: typeid) -> bool {
	if idx, ok := tag_index(&get_world(entity).tags, type); ok {
		return marker_is_set(TAGS_MARKER_SIZE, entity.tags, idx)
	} else {
		return false
	}
}

/* Checks if the entity is tagged with all passed tag types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types.
   `returns` : True if entity is tagged with all types, otherwise - false. */
has_tags :: proc(entity: ^Entity, types: ..typeid) -> bool {
	world: ^World = get_world(entity)
	has := true

	for type in types {
		if idx, ok := tag_index(&world.tags, type); ok {
			has &&= marker_is_set(TAGS_MARKER_SIZE, entity.tags, idx)
		} else {
			has = false
		}
	}

	return has
}

/* Checks if the entity has been deleted.
   `returns` : True if entity is deleted, otherwise - false. */
deleted :: #force_inline proc(entity: ^Entity) -> bool {
	return .DELETED in entity.state
}

/* Checks if the entity is being despawned at the perform stage.
   `returns` : True if entity will be despawned, otherwise - false. */
despawning :: #force_inline proc(entity: ^Entity) -> bool {
	return .DESPAWNING in entity.state
}

/* Gets parent world reference.
   `entity`  : Pointer to the entity.
   `returns` : Reference to the world. */
@(private="package")
get_world :: #force_inline proc(entity: ^Entity) -> ^World {
	return .BUFFERED in entity.state ? entity.world : entity.block.world
}

/* Bind the entity to appropriate archetype.
   `entity` : Pointer to the entity. */
@(private="package")
archetyping :: proc(entity: ^Entity) {
	world : = get_world(entity)

	if world.approach != .ARCHETYPE do return

	if world.running && !world.performing {
		if .ARCHETYPING not_in entity.state {
			append(&world.deffered.archetyping, entity)
			entity.state += { .ARCHETYPING }
		}

		return
	}

	archetype_remove(entity)

	/* If entity has components or tags, bind archetype to it. */
	if marker_is_any_set(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, entity.components) ||
	   marker_is_any_set(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, entity.tags) {
		/* Find appropriate archetype or new one. */
		archetype := get_archetype(world, entity.components, entity.tags)

		append(&archetype.entities, entity)

		entity.archetype = archetype
		entity.arch_idx = len(archetype.entities) - 1
	}
}
