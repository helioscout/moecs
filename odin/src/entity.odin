package moecs

import "core:fmt"

/* Entity type. */
Entity :: struct {
	/* Entity state. */
	state : bit_set[ElementState; u8],
	/* Components marker, each set bit specifies that the component exists in the entity. */
	components : [MAX_COMPONENTS_COUNT]u8,
	/* Tags marker, each set bit specifies that the tag exists in the entity. */
	tags : [MAX_TAGS_COUNT]u8,
	/* Reference to the parent block interface. Use only if stae has not BUFFERED flag. */
	block : ^Block,
	/* Reference to the parent world.
	   If active (state has BUFFERED flag) than entity is in the quick lifetime buffer, not a real block. */
	world : ^World,
	/* The index of the entity in the collection (chunk index for its components). */
	chunk_idx : int
}

/* Adds component to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`    : Pointer to the entity.
   `$Type`     : Component type.
   `component` : Reference to the component instance. */
add :: proc(entity: ^Entity, $Type: typeid, component: ^Type) {
	if c, ok := &get_world(entity).components[Type]; ok {
		set_component(entity, Type, component)		/* Storing value in the chunk. */
		marker_set(entity.components[:], c.idx)		/* Setting marker bit.		   */
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
get_component :: proc(entity: ^Entity, $Type: typeid) -> (^Type, bool) {
	if component, ok := &get_world(entity).components[Type]; ok {
		if marker_is_set(entity.components[:], component.idx) {
			if .BUFFERED in entity.state {
				chunk: ^[QUICK_CHUNK_SIZE]Type = cast(^[QUICK_CHUNK_SIZE]Type)component.buffer
				return &chunk[entity.chunk_idx], true
			} else {
				#partial switch entity.block.lifetime {
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
remove :: proc(entity: ^Entity, type: typeid) {
	if component, ok := &get_world(entity).components[type]; ok {
		marker_unset(entity.components[:], component.idx)
	}
}

/* Removes components from entity of all passed types.
   `entity` : Pointer to the entity.
   `types`  : Companent types. */
remove_all :: proc(entity: ^Entity, types: ..typeid) {
	for type in types do remove(entity, type)
}

/* Gets parent world reference.
   `entity`  : Pointer to the entity.
   `returns` : Reference to the world. */
@(private="file")
get_world :: #force_inline proc(entity: ^Entity) -> ^World {
	return .BUFFERED in entity.state ? entity.world : entity.block.world
}
