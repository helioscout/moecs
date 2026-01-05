package moecs

World :: struct {
	/* Registered component types. */
	components : Components,
	/* Registered tag types. */
	tags : Tags,
	/* Registered resource types with its instances (values).
	   Collection of all world resources. */
	resources : Resources,
	/* Defines that world uses quick lifetime (default: true).
	   If at least one component is registered without a buffer it will be set to false.
	   If disabled than all attempts to create quick lifetime entites will fail. */
	use_quicks : bool,
	/* Buffer for quick life time entities, must be provided from the main app. */
	buffer : ^[QUICK_CHUNK_SIZE]Entity,
	/* Current inserting index in the quick lifetime buffer (last inserted index + 1). */
	idx : uint,
	/* Indicates that the world is running. */
	running : bool
}

/* Initializes the world.
   `world` : Pointer to the world. */
@(private="package")
init_world :: proc(world: ^World) {
	
}
