module moecs;

// import std::io;

<* Block type, building block of the world. *>
struct Block {
	<* Entities collection for the block. *>
	Entities* entities;
	<* Component chunks collection for the block. *>
	Chunks chunks;
}

<* World type, main container of the sapce. *>
struct World {
	<* The world is built of blocks. *>
	Blocks blocks;
}

<* Gets world blocks count. *>
fn usz World.size(&self) {
	return self.blocks.size;
}

<* Initializes the world. *>
fn void World.init(&self) {
	self.blocks.init(mem);
	self.new_block();
}

<* Creates new empty block in the world.
   @return "Pointer to newly created block."
*>
fn Block* World.new_block(&self) @local {
	self.blocks.push({});

	Block* block = self.blocks.get_ref(self.blocks.size - 1);

	block.entities = mem::alloc(Entities);
	block.chunks.init(mem);

	return block;
}
