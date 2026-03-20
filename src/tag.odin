package moecs

/* Tag element type description. */
@(private="package")
Tag :: struct {
	/* Type id of the tag type. */
	type : typeid,
	/* Index of the tag in the bitset (entity's tags marker). */
	idx : int
}

/* Registered tag types collection for each world. */
@(private="package")
Tags :: struct {
	/* Registered ids of tag types converted from typeids.
	   Index in this array will be index in the merker (bitset). */
	ids : [MAX_TAGS_COUNT]u64,
	/* Instances of concrete tag type. */
	types : [MAX_TAGS_COUNT]Tag,
	/* Tag types count (last index + 1). */
	count : int
}

/* Gets index of tag type.
   `tags` : Tag types collection.
   `type` : Tag type. */
@(private="package")
tag_index :: #force_inline proc(tags: ^Tags, type: typeid) -> (int, bool) #optional_ok {
	id: u64 = transmute(u64)type

	for i := 0; i < tags.count; i += 1 {
		if tags.ids[i] == id do return i, true
	}

	return -1, false
}

/* Adds new tag type into collection.
   `tags` : Tag types collection.
   `type` : Tag type.
   `tag`  : Instance of the tag type. */
@(private="package")
tags_add :: proc(tags: ^Tags, type: typeid, tag: Tag) {
	if tags_has(tags, type) do panic("Tag already registered.")
	if tags.count == MAX_TAGS_COUNT do panic("The maximum count of tags has been reached.")

	tags.ids[tags.count] = transmute(u64)type
	tags.types[tags.count] = tag

	tags.count += 1
}

/* Gets reference to the tag type.
   `tags` : Tag types collection.
   `type` : Tag type. */
@(private="package")
tags_get :: #force_inline proc(tags: ^Tags, type: typeid) -> (^Tag, bool) #optional_ok {
	if idx, ok := tag_index(tags, type); ok {
		return &tags.types[idx], true
	} else {
		return nil, false
	}
} 

/* Checks if the collection has specified tag type.
   `tags`    : Tag types collection.
   `type`    : Tag type.
   `returns` : True if type was found, otherwise - false. */
@(private="package")
tags_has :: #force_inline proc(tags: ^Tags, type: typeid) -> bool {
	_, ok := tag_index(tags, type)
	return ok
}
