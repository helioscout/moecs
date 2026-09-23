package moecs

/* The space consists of worlds. */
@(private) worlds : [dynamic]^World

/* Gets worlds count. */
size :: proc() -> int {
	return len(worlds)
}

/* Initializes the space (ecs). */
init :: proc() {
}

/* Free all worlds of the space. */
destroy :: proc() {
	for world in worlds {
		free_world(world)
		free(world)
	}

	delete(worlds)
}

/* Creates new world.
   `returns`    : Pointer to newly created world.
   `observable` : Use observers for the world. */
world :: proc(observable: bool = false) -> ^World {
	world : ^World = new(World)
	world^ = { observable = observable }
	
	append(&worlds, world)
	world_init(world)
	
	return world
}
