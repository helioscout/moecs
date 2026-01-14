package moecs

/* Component elment type description. */
@(private="package")
Component :: struct {
	/* Type id of the component type. */
	type : typeid,
	/* Index of the component in the bitset (entity's components marker). */
	idx : int,
	/* Type size for allocations. */
	size : int,
	/* Pointer to buffer for quick lifetime chunk, must be provided from the main app. */
	buffer : rawptr
}
