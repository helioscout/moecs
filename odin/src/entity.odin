package moecs

/* Entity type. */
Entity :: struct {
	/* Entity state. */
	state : ElementState,
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
	chunk_idx : uint
}
