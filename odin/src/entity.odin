package moecs

import "core:fmt"

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
	chunk_idx : int
}

/* Adds component to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`    : Pointer to the entity.
   `$Type`     : Component type.
   `component` : Reference to the component instance. */
add_component :: proc(entity: ^Entity, $Type: typeid, component: ^Type) {
	if c, ok := &get_world(entity).components[Type]; ok {
		set_component(entity, Type, component)										/* Storing value in the chunk. */
		marker_set(COMPONENTS_MARKER_SIZE, &entity.components, c.idx)	/* Setting marker bit. */
	}
}

/* Sets component value in the entity by its type and instance (initializer).
   `entity`    : Pointer to the entity.
   `$Type`     : Component type.
   `component` : Reference to the component instance." */
set_component :: proc(entity: ^Entity, $Type: typeid, component: ^Type) {
	if .BUFFERED in entity.state {
		if c, ok := &entity.world.components[Type]; ok {
			chunk: ^[QUICK_CHUNK_SIZE]Type = cast(^[QUICK_CHUNK_SIZE]Type)c.buffer
			chunk[entity.chunk_idx] = component^
		}
	} else {
		#partial switch entity.block.lifetime {
			case .QUICK:
				if ptr, ok := entity.block.chunks[Type]; ok {
					chunk: ^[QUICK_CHUNK_SIZE]Type = cast(^[QUICK_CHUNK_SIZE]Type)ptr
					chunk[entity.chunk_idx] = component^
				}

			case .DYNAMIC:
				if ptr, ok := entity.block.chunks[Type]; ok {
					chunk: ^[DYNAMIC_CHUNK_SIZE]Type = cast(^[DYNAMIC_CHUNK_SIZE]Type)ptr
					chunk[entity.chunk_idx] = component^
				}

			case .STATIC:
				if ptr, ok := entity.block.chunks[Type]; ok {
					chunk: ^[STATIC_CHUNK_SIZE]Type = cast(^[STATIC_CHUNK_SIZE]Type)ptr
					chunk[entity.chunk_idx] = component^
				}
		}
	}
}

/* Gets reference to the component value by its type.
   `entity`  : Pointer to the entity.
   `$Type`   : Component type.
   `returns` : Pointer to the component and operation success. */
get_component :: proc(entity: ^Entity, $Type: typeid) -> (^Type, bool) #optional_ok {
	if component, ok := &get_world(entity).components[Type]; ok {
		if marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, component.idx) {
			if .BUFFERED in entity.state {
				chunk: ^[QUICK_CHUNK_SIZE]Type = cast(^[QUICK_CHUNK_SIZE]Type)component.buffer
				return &chunk[entity.chunk_idx], true
			} else {
				#partial switch entity.block.lifetime {
					case .QUICK:
						if ptr, ok := entity.block.chunks[Type]; ok {
							chunk: ^[QUICK_CHUNK_SIZE]Type = cast(^[QUICK_CHUNK_SIZE]Type)ptr
							return &chunk[entity.chunk_idx], true
						}

					case .DYNAMIC:
						if ptr, ok := entity.block.chunks[Type]; ok {
							chunk: ^[DYNAMIC_CHUNK_SIZE]Type = cast(^[DYNAMIC_CHUNK_SIZE]Type)ptr
							return &chunk[entity.chunk_idx], true
						}

					case .STATIC:
						if ptr, ok := entity.block.chunks[Type]; ok {
							chunk: ^[STATIC_CHUNK_SIZE]Type = cast(^[STATIC_CHUNK_SIZE]Type)ptr
							return &chunk[entity.chunk_idx], true
						}
				}
			}
		}
	}

	return nil, false
}

/* Removes component from entity by its type.
   `entity` : Pointer to the entity.
   `type`   : Component type. */
remove_component :: proc(entity: ^Entity, type: typeid) {
	if component, ok := &get_world(entity).components[type]; ok {
		marker_unset(COMPONENTS_MARKER_SIZE, &entity.components, component.idx)
	}
}

/* Removes components from entity of all passed types.
   `entity` : Pointer to the entity.
   `types`  : Companent types. */
remove_components :: proc(entity: ^Entity, types: ..typeid) {
	for type in types do remove_component(entity, type)
}

/* Checks if the enity has a component.
   `entity`  : Pointer to the entity.
   `type`    : Component type.
   `returns` : True if entity has a component, otherwise - false. */
has_component :: proc(entity: ^Entity, type: typeid) -> bool {
	if component, ok := &get_world(entity).components[type]; ok {
		return marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, component.idx)
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
		if component, ok := &world.components[type]; ok {
			has &&= marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, component.idx)
		} else {
			has = false
		}
	}

	return has
}

/* Tags entity with specified tag type.
   `entity`  : Pointer to the entity.
   `type`    : Tag type. */
set_tag :: proc(entity: ^Entity, type: typeid) {
	if tag, ok := &get_world(entity).tags[type]; ok {
		marker_set(TAGS_MARKER_SIZE, &entity.tags, tag.idx)
	}
}

/* Tags entity with all passed tag types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
set_tags :: proc(entity: ^Entity, types: ..typeid) {
	world: ^World = get_world(entity)

	for type in types {
		if tag, ok := &world.tags[type]; ok {
			marker_set(TAGS_MARKER_SIZE, &entity.tags, tag.idx)
		}
	}
}

/* Removes tag from entity.
   `entity`  : Pointer to the entity.
   `type`    : Tag type. */
unset_tag :: proc(entity: ^Entity, type: typeid) {
	if tag, ok := &get_world(entity).tags[type]; ok {
		marker_unset(TAGS_MARKER_SIZE, &entity.tags, tag.idx)
	}
}

/* Removes tags from entity of all passed types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
unset_tags :: proc(entity: ^Entity, types: ..typeid) {
	world: ^World = get_world(entity)

	for type in types {
		if tag, ok := &world.tags[type]; ok {
			marker_unset(TAGS_MARKER_SIZE, &entity.tags, tag.idx)
		}
	}
}

/* Checks if the entity is tagged with specified tag type.
   `entity`  : Pointer to the entity.
   `type`    : Tag type.
   `returns` : True if the entity has tag, otherwise - false. */
has_tag :: proc(entity: ^Entity, type: typeid) -> bool {
	if tag, ok := &get_world(entity).tags[type]; ok {
		return marker_is_set(TAGS_MARKER_SIZE, entity.tags, tag.idx)
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
		if tag, ok := &world.tags[type]; ok {
			has &&= marker_is_set(TAGS_MARKER_SIZE, entity.tags, tag.idx)
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

/* Gets parent world reference.
   `entity`  : Pointer to the entity.
   `returns` : Reference to the world. */
@(private="file")
get_world :: #force_inline proc(entity: ^Entity) -> ^World {
	return .BUFFERED in entity.state ? entity.world : entity.block.world
}
