package moecs

import "core:fmt"
import "core:mem"
import "core:slice"

/* Entity type. */
Entity :: struct {
	/* Entity state. */
	state : bit_set[ElementState; u16],
	/* Components marker, each set bit specifies that the component exists in the entity. */
	components : [COMPONENTS_MARKER_SIZE]uint,
	/* Tags marker, each set bit specifies that the tag exists in the entity. */
	tags : [TAGS_MARKER_SIZE]uint,
	/* Relations marker, each set bit specifies that the relation exists in the entity. */
	relations: [RELATIONS_MARKER_SIZE]uint,
	/* One-to-many relation marker, each bit specifies that the entity relation has
	   several target entities (several parents, children and so on). */
	many: [RELATIONS_MARKER_SIZE]uint,
	/* Reference to the parent block. */
	block : ^Block,
	/* The index of the entity in the collection (chunk index for its components). */
	chunk_idx : int,
	/* Archetype reference which entity belongs to. Is nil for entities without components/tags. */
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
	world : = entity.block.world

	if c, ok := components_get(&world.components, Type); ok {
		ptr := mem.ptr_offset(cast(^u8)entity.block.chunks, world.chunk_size * entity.chunk_idx + c.offset)
		cell: ^Type = cast(^Type)ptr
		cell^ = component^													/* Storing value in the chunk. */

		marker_set(COMPONENTS_MARKER_SIZE, &entity.components, c.idx)		/* Setting marker bit.         */

		if perform do archetyping(entity)
		if world.observable do added_event(world, entity, Type, c.idx, cell)
	}
}

/* Sets previously added component value in the entity by its type and instance (initializer).
   `entity`    : Pointer to the entity.
   `$Type`     : Component type.
   `component` : Reference to the component instance." */
set_component :: proc(entity: ^Entity, $Type: typeid, component: ^Type) #no_bounds_check {
	world : = entity.block.world

	if c, ok := components_get(&world.components, Type); ok {
		ptr := mem.ptr_offset(cast(^u8)entity.block.chunks, world.chunk_size * entity.chunk_idx + c.offset)
		cell: ^Type = cast(^Type)ptr
		cell^ = component^

		if world.observable do set_event(world, entity, Type, c.idx, cell)
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
				entity.block.world.chunk_size * entity.chunk_idx + c.offset)
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
				entity.block.world.chunk_size * entity.chunk_idx + c.offset)
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
	world : = entity.block.world

	if idx, ok := component_index(&world.components, type); ok {
		marker_unset(COMPONENTS_MARKER_SIZE, &entity.components, idx)

		if perform do archetyping(entity)

		if world.observable {
			ptr := mem.ptr_offset(cast(^u8)entity.block.chunks,
				world.chunk_size * entity.chunk_idx + world.components.types[idx].offset)
			removed_event(world, entity, type, idx, ptr)
		}
	}
}

/* Removes components from entity of all passed types.
   `entity` : Pointer to the entity.
   `types`  : Companent types. */
remove_components :: proc(entity: ^Entity, types: ..typeid) {
	for type in types do remove_component(entity, type, false)

	archetyping(entity)
}

/* Checks if the entity has a component.
   `entity`  : Pointer to the entity.
   `type`    : Component type.
   `returns` : True if entity has a component, otherwise - false. */
has_component :: #force_inline proc(entity: ^Entity, type: typeid) -> bool {
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
has_components :: #force_inline proc(entity: ^Entity, types: ..typeid) -> bool {
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
	world : = entity.block.world

	if idx, ok := tag_index(&world.tags, type); ok {
		marker_set(TAGS_MARKER_SIZE, &entity.tags, idx)

		if perform do archetyping(entity)
		if world.observable do tagged_event(world, entity, type, idx)
	}
}

/* Tags entity with all passed tag types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
set_tags :: proc(entity: ^Entity, types: ..typeid) {
	world : = entity.block.world

	for type in types {
		if idx, ok := tag_index(&world.tags, type); ok {
			marker_set(TAGS_MARKER_SIZE, &entity.tags, idx)

			if world.observable do tagged_event(world, entity, type, idx)
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
	world : = entity.block.world

	if idx, ok := tag_index(&world.tags, type); ok {
		marker_unset(TAGS_MARKER_SIZE, &entity.tags, idx)
		
		if perform do archetyping(entity)
		if world.observable do untagged_event(world, entity, type, idx)
	}
}

/* Removes tags from entity of all passed types.
   `entity`  : Pointer to the entity.
   `types`   : Tag types. */
unset_tags :: proc(entity: ^Entity, types: ..typeid) {
	world : = entity.block.world

	for type in types {
		if idx, ok := tag_index(&world.tags, type); ok {
			marker_unset(TAGS_MARKER_SIZE, &entity.tags, idx)
			
			if world.observable do untagged_event(world, entity, type, idx)
		}
	}

	archetyping(entity)
}

/* Checks if the entity is tagged with specified tag type.
   `entity`  : Pointer to the entity.
   `type`    : Tag type.
   `returns` : True if the entity has tag, otherwise - false. */
has_tag :: #force_inline proc(entity: ^Entity, type: typeid) -> bool {
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
has_tags :: #force_inline proc(entity: ^Entity, types: ..typeid) -> bool {
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

/* Relate the entity with the target one using relation type.
   `entity` : Pointer to the entity.
   `$Type`  : Relation type.
   'target' : Pointer to relationship target entity. */
@(private="package")
relate_by_type :: #force_inline proc(entity: ^Entity, $Type: typeid, target: ^Entity) {
	relate_by_value(entity, Type {}, target)
}

/* Relate the entity with the target one using relation instance (relationship data).
   It's safe to relate with same target entity several times, in this case relation data
   will be overwritten with no changes to target entities list.
   `entity`   : Pointer to the entity.
   `relation` : Relation instance (relationship data).
   'target'   : Pointer to relationship target entity. */
@(private="package")
relate_by_value :: proc(entity: ^Entity, relation: $Type, target: ^Entity) {
	if entity == target do return
	
	type := typeid_of(Type)
	world := entity.block.world

	if r, ok := relations_get(&world.relations, type); ok {
		related := marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, r.idx)	/* Already related by Type */
		many    := marker_is_set(RELATIONS_MARKER_SIZE, entity.many, r.idx)			/* to many entities.       */
		chunk_offset := world.chunk_size * entity.chunk_idx
		ptr_target   := mem.ptr_offset(cast(^u8)entity.block.chunks, chunk_offset + r.target_offset)
		ptr_relation := cast(^Type)mem.ptr_offset(cast(^u8)entity.block.chunks, chunk_offset + r.offset)
		/* Store relation value in the chunk (or replace previous one). */
		ptr_relation^ = relation

		if related {
			/* If already related then target will be a pointer to a dynamic array of pointers to entities. */
			t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target

			if many {
				/* If already has many targets then we just append to existing dynamic array,
				   if the target entity has not been added before. */
				if !slice.contains(t^[:], target) do append(t^, target)
			} else {
				existing: ^Entity = (cast(^^Entity)ptr_target)^
				/* If entity was related with current target before, we do nothing. */
				if existing == target do return
				
				/* We use arena allocator for dynamic arrays here. */
				entities := new([dynamic]^Entity, world.allocator)
				entities^ = make([dynamic]^Entity, 0, 7, world.allocator)
				/* If already related to one entity we copy it's pointer to newly created
				   dynamic array and store a pointer to that array in the chunk. */
				append(entities, existing, target)
				t^ = entities

				marker_set(RELATIONS_MARKER_SIZE, &entity.many, r.idx)
			}
		} else {
			/* If had no relations before we store pointer to target entity in the chunk. */
			t: ^^Entity = cast(^^Entity)ptr_target
			t^ = target

			marker_set(RELATIONS_MARKER_SIZE, &entity.relations, r.idx)
			archetyping(entity)
		}

		if world.observable do related_event(world, entity, type, r.idx, target, ptr_relation)

		switch type {
			case ParentOf: if !is_child_of(target, entity)  do relate_by_type(target, ChildOf, entity)
			case ChildOf:  if !is_parent_of(target, entity) do relate_by_type(target, ParentOf, entity)
		}

		if r.idx != world.relations.idx_relation_of do relate_by_type(target, RelationOf, entity)
	}
}

/* Set entity's ParentOf relation with any number of targets (children).
   `entity`   : Pointer to the (parent) entity.
   `entities` : Variadic param of one or more child entities. */
@(private="package")
parent_of_by_type :: #force_inline proc(entity: ^Entity, entities: ..^Entity) {
	for child in entities do relate_by_type(entity, ParentOf, child)
}

/* Set entity's ParentOf relation with any number of targets (children)
   using relation instance (relationship data).
   `entity`   : Pointer to the (parent) entity.
   `relation` : ParentOf relation instance (relationship data).
   `entities` : Variadic param of one or more child entities. */
@(private="package")
parent_of_by_value :: #force_inline proc(entity: ^Entity, relation: ParentOf, entities: ..^Entity) {
	for child in entities do relate_by_value(entity, relation, child)
}

/* Set entity's ChildOf relation with any number of targets (parents).
   `entity`   : Pointer to the (child) entity.
   `entities` : Variadic param of one or more parent entities. */
@(private="package")
child_of_by_type :: #force_inline proc(entity: ^Entity, entities: ..^Entity) {
	for parent in entities do relate_by_type(entity, ChildOf, parent)
}

/* Set entity's ChildOf relation with any number of targets (parents)
   using relation instance (relationship data).
   `entity`   : Pointer to the (child) entity.
   `relation` : ChildOf relation instance (relationship data).
   `entities` : Variadic param of one or more parent entities. */
@(private="package")
child_of_by_value :: #force_inline proc(entity: ^Entity, relation: ChildOf, entities: ..^Entity) {
	for parent in entities do relate_by_value(entity, relation, parent)
}

/* Checks if the entity has ChildOf relation with (is a child of) another one.
   `entity` : Pointer to the (child) entity.
   `parent` : Pointer to the parent entity. */
is_child_of :: proc(entity: ^Entity, parent: ^Entity) -> bool #no_bounds_check {
	if entity == parent do return false
	
	world := entity.block.world
	idx := world.relations.idx_child_of

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
		ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
			world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

		if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
			target: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
			return slice.contains(target^[:], parent)
		} else {
			target: ^^Entity = cast(^^Entity)ptr_target
			return target^ == parent
		}
	}

	return false
}

/* Checks if the entity has ParentOf relation with (is a parent of) another one.
   `entity` : Pointer to the (parent) entity.
   `child`  : Pointer to the child entity. */
is_parent_of :: proc(entity: ^Entity, child: ^Entity) -> bool #no_bounds_check {
	if entity == child do return false
	
	world := entity.block.world
	idx := world.relations.idx_parent_of

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
		ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
			world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

		if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
			target: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
			return slice.contains(target^[:], child)
		} else {
			target: ^^Entity = cast(^^Entity)ptr_target
			return target^ == child
		}
	}

	return false
}

/* Checks if the entity has ChildOf relation to some other.
   `entity` : Pointer to the entity. */
is_child :: #force_inline proc(entity: ^Entity) -> bool {
	return marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, entity.block.world.relations.idx_child_of)
}

/* Checks if the entity has ParentOf relation to some other.
   `entity` : Pointer to the entity. */
is_parent :: #force_inline proc(entity: ^Entity) -> bool {
	return marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, entity.block.world.relations.idx_parent_of)
}

/* Checks if the entity has relation of specified type,
   and, if provided, with every of listed target entities.
   `entity`  : Pointer to the entity.
   `$Type`   : Relation type.
   `targets` : Variadic param of one or more target entities. */
related :: proc(entity: ^Entity, $Type: typeid, targets: ..^Entity) -> bool {
	world := entity.block.world

	if len(targets) == 0 {
		if idx, ok := relation_index(&world.relations, Type); ok {
			return marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx)
		}

		return false
	}

	if idx, ok := relation_index(&world.relations, Type); ok {
		if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
			ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
				world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

			if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
				target: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target

				for t in targets {
					if !slice.contains(target^[:], t) do return false
				}
				
				return true
			} else {
				if len(targets) == 1 {
					target: ^^Entity = cast(^^Entity)ptr_target
					return target^ == targets[0]
				} else {
					return false
				}
			}
		}
	}

	return false
}

/* Checks if an entity has relationships with other entities (is their relations target).
   `entity` : Pointer to the entity. */
is_relation :: proc(entity: ^Entity) -> bool {
	return marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, entity.block.world.relations.idx_relation_of)
}

/* Checks if the entity has RelationOf relation with (is it's relation target) another one.
   `target` : Pointer to the (target) entity.
   `entity` : Pointer to the (related) entity. */
is_relation_of :: proc(target: ^Entity, entity: ^Entity) -> bool #no_bounds_check {
	if target == entity do return false
	
	world := target.block.world
	idx := world.relations.idx_relation_of

	if marker_is_set(RELATIONS_MARKER_SIZE, target.relations, idx) {
		ptr_target := mem.ptr_offset(cast(^u8)target.block.chunks,
			world.chunk_size * target.chunk_idx + world.relations.types[idx].target_offset)

		if marker_is_set(RELATIONS_MARKER_SIZE, target.many, idx) {
			t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
			return slice.contains(t^[:], entity)
		} else {
			t: ^^Entity = cast(^^Entity)ptr_target
			return t^ == entity
		}
	}

	return false
}

/* Removes all entity relations with all target entities by specified type.
   `entity` : Pointer to the entity.
   `$Type`  : Relation type. */
unrelate_by :: proc(entity: ^Entity, $Type: typeid) {
	type := typeid_of(Type)
	world := entity.block.world

	if idx, ok := relation_index(&world.relations, type); ok {
		if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
			ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
				world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

			if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
				t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target

				for e_ptr in t^ {
					if world.observable {
						ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
							world.chunk_size * entity.chunk_idx + world.relations.types[idx].offset)
						unrelated_event(world, entity, type, idx, e_ptr, ptr_relation)
					}
					
					unrelate_reverse(world, type, idx, entity, e_ptr)
				}

				// We haven't to free memory scince we use arena allocator.
				// Uncomment these 2 lines if you changed allocation for dynamic arrays.
				// delete(t^^)
				// free(t^)

				marker_unset(RELATIONS_MARKER_SIZE, &entity.many, idx)
			} else {
				t: ^^Entity = cast(^^Entity)ptr_target

				if world.observable {
					ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
						world.chunk_size * entity.chunk_idx + world.relations.types[idx].offset)
					unrelated_event(world, entity, type, idx, t^, ptr_relation)
				}

				unrelate_reverse(world, type, idx, entity, t^)
			}

			marker_unset(RELATIONS_MARKER_SIZE, &entity.relations, idx)
			archetyping(entity)
		}
	}
}

/* Removes all entity relations with all target entities by relation index.
   For using only while entity despawning. 
   `entity` : Pointer to the entity.
   `idx`    : Relation index. */
@(private="package")
unrelate_all_by_idx :: proc(entity: ^Entity, idx: int) {
	world := entity.block.world

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
		ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
			world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

		if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
			t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target

			for e_ptr in t^ {
				if world.observable {
					type := world.relations.types[idx]
					ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
						world.chunk_size * entity.chunk_idx + type.offset)
					unrelated_event(world, entity, type.type, idx, e_ptr, ptr_relation)
				}
				
				/* Since entity will be despawned target (e_ptr) entity will definitaly
				   have no one relation with it. */
				unrelate_with(e_ptr, RelationOf, entity)
			}

			// We haven't to free memory scince we use arena allocator.
			// Uncomment these 2 lines if you changed allocation for dynamic arrays.
			// delete(t^^)
			// free(t^)
		} else {
			t: ^^Entity = cast(^^Entity)ptr_target

			if world.observable {
				type := world.relations.types[idx]
				ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
					world.chunk_size * entity.chunk_idx + type.offset)
				unrelated_event(world, entity, type.type, idx, t^, ptr_relation)
			}

			unrelate_with(t^, RelationOf, entity)
		}

		/* Since entity will be despawned we should not unset any markers. */
	}
}

/* Removes entity relation with target entity by specified type.
   `entity` : Pointer to the entity.
   `$Type`  : Relation type.
   'target' : Pointer to relationship target entity. */
unrelate_with :: proc(entity: ^Entity, $Type: typeid, target: ^Entity) {
	if entity == target do return

	found := false
	type := typeid_of(Type)
	world := entity.block.world
	
	if idx, ok := relation_index(&world.relations, type); ok {
		if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
			ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
				world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

			if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
				t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
				
				if index, ok := slice.linear_search(t^[:], target); ok {
					unordered_remove(t^, index)

					if len(t^) == 1 {
						e_ptr: ^Entity = t^[0]
						
						// We haven't to free memory scince we use arena allocator.
						// Uncomment these 2 lines if you changed allocation for dynamic arrays.
						// delete(t^^)
						// free(t^)

						e: ^^Entity = cast(^^Entity)ptr_target
						e^ = e_ptr

						marker_unset(RELATIONS_MARKER_SIZE, &entity.many, idx)
					}
					
					if world.observable {
						ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
							world.chunk_size * entity.chunk_idx + world.relations.types[idx].offset)
						unrelated_event(world, entity, type, idx, target, ptr_relation)
					}
					
					found = true
				}
			} else {
				t: ^^Entity = cast(^^Entity)ptr_target

				if t^ == target {
					marker_unset(RELATIONS_MARKER_SIZE, &entity.relations, idx)
					archetyping(entity)

					if world.observable {
						ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
							world.chunk_size * entity.chunk_idx + world.relations.types[idx].offset)
						unrelated_event(world, entity, type, idx, target, ptr_relation)
					}
					
					found = true
				}
			}

			if found do unrelate_reverse(world, type, idx, entity, target)
		}
	}
}

/* Removes entity relation with target entity by relation index and ignoring reverse ones.
   `entity` : Pointer to the entity.
   `idx`    : Relation index.
   'target' : Pointer to relationship target entity. */
@(private="package")
unrelate_by_idx :: proc(entity: ^Entity, idx: int, target: ^Entity) {
	world := entity.block.world

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
		ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
			world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

		if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
			t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
			
			if index, ok := slice.linear_search(t^[:], target); ok {
				unordered_remove(t^, index)

				if len(t^) == 1 {
					e_ptr: ^Entity = t^[0]
					
					// We haven't to free memory scince we use arena allocator.
					// Uncomment these 2 lines if you changed allocation for dynamic arrays.
					// delete(t^^)
					// free(t^)

					e: ^^Entity = cast(^^Entity)ptr_target
					e^ = e_ptr

					marker_unset(RELATIONS_MARKER_SIZE, &entity.many, idx)
				}

				if world.observable {
					type := world.relations.types[idx]
					ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
						world.chunk_size * entity.chunk_idx + type.offset)
					unrelated_event(world, entity, type.type, idx, target, ptr_relation)
				}
			}
		} else {
			t: ^^Entity = cast(^^Entity)ptr_target

			if t^ == target {
				marker_unset(RELATIONS_MARKER_SIZE, &entity.relations, idx)
				archetyping(entity)
				
				if world.observable {
					type := world.relations.types[idx]
					ptr_relation := mem.ptr_offset(cast(^u8)entity.block.chunks,
						world.chunk_size * entity.chunk_idx + type.offset)
					unrelated_event(world, entity, type.type, idx, target, ptr_relation)
				}
			}
		}
	}
}

/* Remove entity's reverese relations to target (dependency relations target -> entity).
   `world`  : Pointer to the world.
   `type`   : (Main) relation type.
   `idx`    : (Main) relation index.
   `entity` : Pointer to the entity (main relation owner).
   `target` : Pointer to the target entity (dependecy relations owner). */
@(private="file")
unrelate_reverse :: #force_inline proc(world: ^World, type: typeid, idx: int, entity: ^Entity, target: ^Entity) {
	switch type {
		case ParentOf: if is_child_of(target, entity)  do unrelate_with(target, ChildOf, entity)
		case ChildOf:  if is_parent_of(target, entity) do unrelate_with(target, ParentOf, entity)
	}

	/* Only if there is no other relations with target entity we remove reverse relation (link). */
	if idx != world.relations.idx_relation_of && relation_of_count(target, entity) == 0 {
		unrelate_with(target, RelationOf, entity)
	}
}

/* Count of dependencies on relationships with other entity,
   how much times target appears as relation target for an entity.
   `target` : Pointer to the (target) entity.
   `entity` : Pointer to the (related) entity. */
relation_of_count :: proc(target: ^Entity, entity: ^Entity) -> int {
	if target == entity do return 0

	count := 0
	world := entity.block.world
	
	for idx := 0; idx < world.relations.count; idx += 1 {
		if idx == world.relations.idx_relation_of do continue

		if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, idx) {
			ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
				world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

			if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
				t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
				if slice.contains(t^[:], target) do count += 1
			} else {
				t: ^^Entity = cast(^^Entity)ptr_target
				if t^ == target do count += 1
			}
		}
	}

	return count
}

/* Gets entity relation (one to one) of specified type.
   Even if a relation has many targets, only first will be returned.
   `entity` : Pointer to the entity.
   `$Type`  : Relation type. */
relation :: proc(entity: ^Entity, $Type: typeid) -> (relation: ^Type, target: ^Entity) {
	world := entity.block.world

	if r, ok := relations_get(&world.relations, Type); ok {
		if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, r.idx) {
			chunk_offset := world.chunk_size * entity.chunk_idx
			ptr_target   := mem.ptr_offset(cast(^u8)entity.block.chunks, chunk_offset + r.target_offset)
			relation     = cast(^Type)mem.ptr_offset(cast(^u8)entity.block.chunks, chunk_offset + r.offset)

			if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, r.idx) {
				t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
				target = t^[0]
			} else {
				t: ^^Entity = cast(^^Entity)ptr_target
				target = t^
			}
		}
	}
	
	return relation, target
}

/* Gets entity relations (one to many) of specified type.
   Even if a relation has one target, it will be wrapped into slice.
   `entity` : Pointer to the entity.
   `$Type`  : Relation type. */
relations :: proc(entity: ^Entity, $Type: typeid) -> (relation: ^Type, targets: []^Entity) {
	world := entity.block.world

	if r, ok := relations_get(&world.relations, Type); ok {
		if marker_is_set(RELATIONS_MARKER_SIZE, entity.relations, r.idx) {
			chunk_offset := world.chunk_size * entity.chunk_idx
			ptr_target   := mem.ptr_offset(cast(^u8)entity.block.chunks, chunk_offset + r.target_offset)
			relation     = cast(^Type)mem.ptr_offset(cast(^u8)entity.block.chunks, chunk_offset + r.offset)

			if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, r.idx) {
				t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
				targets = t^[:]
			} else {
				t: ^^Entity = cast(^^Entity)ptr_target
				targets = slice.from_ptr(t, 1)
			}
		}
	}
	
	return relation, targets
}

/* Gets parent entity. If entity has many parents, only first will be returned.
   `entity` : Pointer to the (child) entity. */
parent :: #force_inline proc(entity: ^Entity) -> ^Entity {
	_, parent := relation(entity, ChildOf)
	return parent
}

/* Gets parent entities. If entity has one parent, it will be wrapped into slice.
   `entity` : Pointer to the (child) entity. */
parents :: #force_inline proc(entity: ^Entity) -> []^Entity {
	_, parents := relations(entity, ChildOf)
	return parents
}

/* Gets child entity. If entity has many children, only first will be returned.
   `entity` : Pointer to the (parent) entity. */
child :: #force_inline proc(entity: ^Entity) -> ^Entity {
	_, child := relation(entity, ParentOf)
	return child
}

/* Gets child entities. If entity has one child, it will be wrapped into slice.
   `entity` : Pointer to the (parent) entity. */
children :: #force_inline proc(entity: ^Entity) -> []^Entity {
	_, children := relations(entity, ParentOf)
	return children
}

/* Gets parent entities without relation checks.
   `entity` : Pointer to the entity. */
@(private="package")
get_parents :: proc(entity: ^Entity) -> []^Entity {
	world := entity.block.world
	idx := world.relations.idx_child_of
	ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
		world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
		t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
		return t^[:]
	} else {
		t: ^^Entity = cast(^^Entity)ptr_target
		return slice.from_ptr(t, 1)
	}
}

/* Gets child entities without relation checks.
   `entity` : Pointer to the entity. */
@(private="package")
get_children :: proc(entity: ^Entity) -> []^Entity {
	world := entity.block.world
	idx := world.relations.idx_parent_of
	ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
		world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
		t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
		return t^[:]
	} else {
		t: ^^Entity = cast(^^Entity)ptr_target
		return slice.from_ptr(t, 1)
	}
}

/* Gets relationships dependency entities for which current entity appears as a target.
   `entity` : Pointer to the entity. */
@(private="package")
get_relatives :: proc(entity: ^Entity) -> []^Entity {
	world := entity.block.world
	idx := world.relations.idx_relation_of
	ptr_target := mem.ptr_offset(cast(^u8)entity.block.chunks,
		world.chunk_size * entity.chunk_idx + world.relations.types[idx].target_offset)

	if marker_is_set(RELATIONS_MARKER_SIZE, entity.many, idx) {
		t: ^^[dynamic]^Entity = cast(^^[dynamic]^Entity)ptr_target
		return t^[:]
	} else {
		t: ^^Entity = cast(^^Entity)ptr_target
		return slice.from_ptr(t, 1)
	}
}

/* Checks if the entity has been fully deleted (despawned).
   `entity`  : Pointer to the entity.
   `returns` : True if entity is deleted, otherwise - false. */
deleted :: #force_inline proc(entity: ^Entity) -> bool {
	return .DELETED in entity.state
}

/* Checks if the entity is deferred for despawning at the perform stage.
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
	return entity.block.lifetime == .STATIC
}

/* Bind the entity to appropriate archetype.
   `entity` : Pointer to the entity. */
@(private="package")
archetyping :: proc(entity: ^Entity) {
	world : = entity.block.world

	if world.approach != .ARCHETYPE do return

	if world.running && !world.performing {
		if .ARCHETYPING not_in entity.state {
			append(&world.deferred.archetyping, entity)
			entity.state += { .ARCHETYPING }
		}

		return
	}

	archetype_remove(entity)

	/* If entity has components, or tags, or relations bind archetype to it. */
	if marker_is_any_set(MAX_COMPONENTS_COUNT, COMPONENTS_MARKER_SIZE, entity.components) ||
	   marker_is_any_set(MAX_TAGS_COUNT, TAGS_MARKER_SIZE, entity.tags) ||
	   marker_is_any_set(MAX_RELATIONS_COUNT, RELATIONS_MARKER_SIZE, entity.relations) {
		/* Find appropriate archetype or new one. */
		archetype := get_archetype(world, entity.components, entity.tags, entity.relations)

		append(&archetype.entities, entity)

		entity.archetype = archetype
		entity.arch_idx = len(archetype.entities) - 1
	}
}
