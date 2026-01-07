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

/* Creates new world.
   `buffer`  : Pointer to buffer for quick lifetime entities.
               Ensure that you don't use same buffers for different worlds.
   `returns` : Pointer to newly created world. */
new_world :: proc(buffer : ^[QUICK_CHUNK_SIZE]Entity = nil) -> ^World {
	world : ^World = new(World)
	world^ = { use_quicks = buffer != nil, buffer = buffer }
	
	append(&worlds, world)
	world_init(world)
	
	return world
}
