package moecs

import "core:slice"
import "core:mem"

/* Relation type that describes child->parent relationship. */
ChildOf :: struct {
	/* Custom data pointer for the relation. */
	data : rawptr
}

/* Relation type that describes parent->child relationship. */
ParentOf :: struct {
	/* Custom data pointer for the relation. */
	data : rawptr
}

/* Relation type that describes whether an entity has dependencies
   on relationships with other entities (is their relations target). */
RelationOf :: distinct u8

/* Relation element type description. */
@(private="package")
Relation :: struct {
	/* Type id of the relation type. */
	type : typeid,
	/* Index of the relation in the bitset (entity's relations marker). */
	idx : int,
	/* Type size for allocations. */
	size : int,
	/* Relation offset (position) in the storage. */
	offset : int,
	/* Relation target (entity or array of entities) offset (position) in the storage. */
	target_offset : int
}

/* Registered relation types collection for each world. */
@(private="package")
Relations :: struct {
	/* Registered ids of relation types converted from typeids.
	   Index in this array will be index in the merker (bitset)
	   and the index of relation's (component's) chunk in the block. */
	ids : [MAX_RELATIONS_COUNT]u64,
	/* Instances of concrete relation type. */
	types : [MAX_RELATIONS_COUNT]Relation,
	/* Relation types count (last index + 1). */
	count : int,
	/* Total size in bytes of all relations and targets. */
	size : int,
	/* Index of ChildOf relation in the merker. */
	idx_child_of : int,
	/* Index of ParentOf relation in the merker. */
	idx_parent_of : int,
	/* Index of RelationOf relation in the merker. */
	idx_relation_of : int
}

/* Gets index of relation type.
   `relations` : Relation types collection.
   `type`      : Relation type. */
@(private="package")
relation_index :: #force_inline proc(relations: ^Relations, type: typeid) -> (int, bool) #optional_ok {
	id: u64 = transmute(u64)type

	for i := 0; i < relations.count; i += 1 {
		if relations.ids[i] == id do return i, true
	}

	return -1, false
}

/* Adds new relation type into collection.
   `relations` : Relation types collection.
   `type`      : Relation type.
   `relation`  : Instance of the relation type. */
@(private="package")
relations_add :: proc(relations: ^Relations, type: typeid, relation: Relation) {
	if relations_has(relations, type) do panic("Relation already registered.")
	if relations.count == MAX_RELATIONS_COUNT do panic("The maximum count of relations has been reached.")

	relations.ids[relations.count] = transmute(u64)type
	relations.types[relations.count] = relation

	relations.count += 1
}

/* Gets reference to the relation type.
   `relations` : Relation types collection.
   `type`      : Relation type. */
@(private="package")
relations_get :: #force_inline proc(relations: ^Relations, type: typeid) -> (^Relation, bool) #optional_ok {
	if idx, ok := relation_index(relations, type); ok {
		return &relations.types[idx], true
	} else {
		return nil, false
	}
} 

/* Checks if the collection has specified relation type.
   `relations` : Relation types collection.
   `type`      : Relation type.
   `returns`   : True if type was found, otherwise - false. */
@(private="package")
relations_has :: #force_inline proc(relations: ^Relations, type: typeid) -> bool {
	_, ok := relation_index(relations, type)
	return ok
}

/* Adjust relation types for efficient access, sort, calculate offsets.
   `world` : Pointer to the world. */
@(private="package")
relations_adjust :: proc(world: ^World) {
	relations := &world.relations
	types: []Relation = slice.clone(relations.types[:relations.count])

	slice.sort(relations.ids[:relations.count])

	for relation in types {
		idx := relation_index(relations, relation.type)
		relations.types[idx] = relation
		relations.types[idx].idx = idx
	}

	/* Relations are sroted right after components. */
	relations.types[0].offset = world.components.size

	ptr_info := type_info_of(rawptr)
	offset : = world.components.size
	chunk_align := ptr_info.align

	for i in 0..<relations.count {
		info := type_info_of(relations.types[i].type)

		offset = mem.align_forward_int(offset, info.align)
		relations.types[i].offset = offset
		offset += info.size
		offset = mem.align_forward_int(offset, ptr_info.align)
		relations.types[i].target_offset = offset
		offset += ptr_info.size
		chunk_align = max(chunk_align, info.align)
	}

	/* Relations size without components size in the common chunk. */
	relations.size = mem.align_forward_int(offset, chunk_align) - world.components.size

	delete(types)

	/* To speed up checks for builtin relations we store their indexes. */
	relations.idx_child_of = relation_index(relations, ChildOf)
	relations.idx_parent_of = relation_index(relations, ParentOf)
	relations.idx_relation_of = relation_index(relations, RelationOf)
}
