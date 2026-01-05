package moecs

/* Tag element type description. */
Tag :: struct {
	/* Type id of the tag type. */
	type : typeid,
	/* Index of the tag in the bitset (entity's tags marker). */
	idx : uint
}
