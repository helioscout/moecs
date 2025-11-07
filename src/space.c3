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
*>
fn World* new() {
	worlds.push({});

	World* world = worlds.get_ref(worlds.size - 1);
	world.init();

	return world;
}
