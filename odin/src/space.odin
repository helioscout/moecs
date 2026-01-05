package moecs

/* The space consists of worlds. */
@(private) worlds : Worlds

/* Gets worlds count. */
size :: proc() -> int {
	return len(worlds)
}

/* Creates new world.
   `buffer` : Pointer to buffer for quick lifetime entities.
              Ensure that you don't use same buffers for different worlds.
   `-->`    : Pointer to newly created world. */
new_world :: proc(buffer : ^[QUICK_CHUNK_SIZE]Entity = nil) -> ^World {
	world : ^World = new(World)
	world^ = { use_quicks = buffer != nil, buffer = buffer }
	
	init_world(world)
	
	return world
}
