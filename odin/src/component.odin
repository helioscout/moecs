package moecs

/* Component elment type description. */
Component :: struct {
	/* Type id of the component type. */
	type : typeid,
	/* Index of the component in the bitset (entity's components marker). */
	idx : uint,
	/* Type size for allocations. */
	size : uint,
	/* Pointer to buffer for quick lifetime chunk, must be provided from the main app. */
	buffer : any
}
