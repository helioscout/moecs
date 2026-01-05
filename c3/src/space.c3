module moecs;

<* The space consists of worlds. *>
Worlds worlds;

<* Gets worlds count. *>
fn usz size() {
	return worlds.size;
}

<* Initializes the space (ecs). *>
fn void init() {
	worlds.init(mem);
}

<* Creates new world.
   @return "Pointer to newly created world."
   @param buffer : "Pointer to buffer for quick lifetime entities. Ensure that you don't use same buffers for different worlds."
*>
fn World* new(Entity[QUICK_CHUNK_SIZE]* buffer = null) {
	worlds.push({ .use_quicks = buffer != null, .buffer = buffer });

	World* world = worlds.get_ref(worlds.size - 1);
	world.init();

	return world;
}
