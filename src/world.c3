module moecs;

import moecs::block;
// import std::io;

<* World type, main container of the sapce. The world is built of blocks. *>
struct World {
	<* Registered components. *>
	Components components;
	<* Blocks for entities with quick lifetime. *>
	QuickBlocks quicks;
	<* Blocks for entities with dynamic lifetime. *>
	DynamicBlocks dynamics;
	<* Blocks for entities with static lifetime. *>
	StaticBlocks statics;
}

<* Gets world blocks count for specific (default: all) lifetimes.
   @param lifetime : "Blocks lifetime flag."
*>
fn usz World.size(&self, char lifetime = 0b00000111) {
	usz size;

	if (lifetime & Lifetime.QUICK)   size += self.quicks.size;
	if (lifetime & Lifetime.DYNAMIC) size += self.dynamics.size;
	if (lifetime & Lifetime.STATIC)  size += self.statics.size;
	
	return size;
}

<* Gets world blocks count for specific lifetimes (comma-separated arguments). *>
macro usz World.size_of(&self, ...) {
	char $lifetime;
	
	$for var $i = 0; $i < $vacount; $i++:
		$if @typeid($vaexpr[$i]) == Lifetime.typeid:
			$lifetime |= $vaexpr[$i];
		$endif
	$endfor

	return self.size($lifetime);
}

<* Initializes the world. *>
fn void World.init(&self) {
	self.components.init(mem);
	self.quicks.init(mem);
	self.dynamics.init(mem);
	self.statics.init(mem);

	// self.new(QUICK);
	// self.new(DYNAMIC);
	// self.new(STATIC);
}

<* Spawns new entity into the world.
   @return "Pointer to new entity."
   @param lifetime : "Entity lifetime (default: Lifetime.DYNAMIC)."
*>
fn Entity* World.spawn(&self, Lifetime lifetime = DYNAMIC) {
	return null;
}

<* Creates new empty block in the world.
   @return "Pointer to newly created block interface."
   @param lifetime : "Block lifetime."
*>
fn BlockGene World.new(&self, Lifetime lifetime) @local {
	BlockGene block;

	switch (lifetime) {
		case QUICK:
			self.quicks.push({ .lifetime = QUICK });
			block = self.quicks.get_ref(self.quicks.size - 1);
		case DYNAMIC:
			self.dynamics.push({ .lifetime = DYNAMIC });
			block = self.dynamics.get_ref(self.dynamics.size - 1);
		case STATIC:
			self.statics.push({ .lifetime = STATIC });
			block = self.statics.get_ref(self.statics.size - 1);
	}

	block.init();

	return block;
}
