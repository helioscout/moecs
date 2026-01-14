package moecs

@(private="package")
Resource :: struct {
	/* Type id of the resource type. */
	type : typeid,
	/* Pointer to the resource instance. */
	value : rawptr
}
