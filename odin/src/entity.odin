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
	/* Reference to the parent block. */
	block : ^Block,
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
	if idx, ok := component_index(&entity.block.world.components, Type); ok {
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
	if c, ok := components_get(&entity.block.world.components, Type); ok {
		ptr := mem.ptr_offset(cast(^u8)entity.block.chunks,
			entity.block.world.components.size * entity.chunk_idx + c.offset)
		cell: ^Type = cast(^Type)ptr
		cell^ = component^
	}
}

/* Gets reference to the component value by its type.
   `entity`  : Pointer to the entity.
   `$Type`   : Component type.
   `returns` : Pointer to the component and operation success. */
get_component_mut :: #force_inline proc(entity: ^Entity, $Type: typeid) -> (^Type, bool) #no_bounds_check #optional_ok {
	if c, ok := components_get(&entity.block.world.components, Type); ok {
		if marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, c.idx) {
			ptr := mem.ptr_offset(cast(^u8)entity.block.chunks,
				entity.block.world.components.size * entity.chunk_idx + c.offset)
			return cast(^Type)ptr, true
		}
	}

	return nil, false
}

/* Gets component value by its type.
   `entity`  : Pointer to the entity.
   `$Type`   : Component type.
   `returns` : Component value and operation success. */
get_component :: #force_inline proc(entity: ^Entity, $Type: typeid) -> (Type, bool) #no_bounds_check #optional_ok {
	component: Type = ---
	
	if c, ok := components_get(&entity.block.world.components, Type); ok {
		if marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, c.idx) {
			ptr := mem.ptr_offset(cast(^u8)entity.block.chunks,
				entity.block.world.components.size * entity.chunk_idx + c.offset)
			mem.copy_non_overlapping(&component, ptr, size_of(Type))

			return component, true
		}
	}

	return component, false
}

/* Removes component from entity by its type.
   `entity`  : Pointer to the entity.
   `type`    : Component type.
   `perform` : Perform archetyping of the entity.
			   You should not change this parameter (inner logic). */
remove_component :: proc(entity: ^Entity, type: typeid, perform: bool = true) {
	if idx, ok := component_index(&entity.block.world.components, type); ok {
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
	if idx, ok := component_index(&entity.block.world.components, type); ok {
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
	has := true

	for type in types {
		if idx, ok := component_index(&entity.block.world.components, type); ok {
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
	if idx, ok := tag_index(&entity.block.world.tags, type); ok {
		marker_set(TAGS_MARKER_SIZE, &entity.tags, idx)

		if perform do archetyping(entity)
	}
}

/* Tags entity with all passed tag types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
set_tags :: proc(entity: ^Entity, types: ..typeid) {
	for type in types {
		if idx, ok := tag_index(&entity.block.world.tags, type); ok {
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
	if idx, ok := tag_index(&entity.block.world.tags, type); ok {
		marker_unset(TAGS_MARKER_SIZE, &entity.tags, idx)
	}
	
	if perform do archetyping(entity)
}

/* Removes tags from entity of all passed types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
unset_tags :: proc(entity: ^Entity, types: ..typeid) {
	for type in types {
		if idx, ok := tag_index(&entity.block.world.tags, type); ok {
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
	if idx, ok := tag_index(&entity.block.world.tags, type); ok {
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
	has := true

	for type in types {
		if idx, ok := tag_index(&entity.block.world.tags, type); ok {
			has &&= marker_is_set(TAGS_MARKER_SIZE, entity.tags, idx)
		} else {
			has = false
		}
	}

	return has
}

/* Checks if the entity has been deleted.
   `entity`  : Pointer to the entity.
   `returns` : True if entity is deleted, otherwise - false. */
deleted :: #force_inline proc(entity: ^Entity) -> bool {
	return .DELETED in entity.state
}

/* Checks if the entity is being despawned at the perform stage.
   `entity`  : Pointer to the entity.
   `returns` : True if entity will be despawned, otherwise - false. */
despawning :: #force_inline proc(entity: ^Entity) -> bool {
	return .DESPAWNING in entity.state
}

/* Checks if the entity belongs to dynamic lifetime block.
   `entity`  : Pointer to the entity.
   `returns` : True if entity is dynamic, otherwise - false. */
is_dynamic :: #force_inline proc(entity: ^Entity) -> bool {
	return entity.block.lifetime == .DYNAMIC
}

/* Checks if the entity belongs to static lifetime block.
   `entity`  : Pointer to the entity.
   `returns` : True if entity is static, otherwise - false. */
is_static :: #force_inline proc(entity: ^Entity) -> bool {
	return entity.block.lifetime == .DYNAMIC
}

/* Bind the entity to appropriate archetype.
   `entity` : Pointer to the entity. */
@(private="package")
archetyping :: proc(entity: ^Entity) {
	world : = entity.block.world

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
