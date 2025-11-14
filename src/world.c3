module moecs;

import moecs::block;
import std::io;

<* World type, main container of the sapce. The world is built of blocks. *>
struct World {
	<* Registered component types. *>
	Components components;
	<* Registered tag types. *>
	Tags tags;
	<* Registered resource types. *>
	Resources resources;
	<* Blocks for entities with quick lifetime. *>
	QuickBlocks quicks;
	<* Blocks for entities with dynamic lifetime. *>
	DynamicBlocks dynamics;
	<* Blocks for entities with static lifetime. *>
	StaticBlocks statics;
	<* Defines that world uses quick lifetime (default: true).
	   If at least one component is registered without a buffer it will be set to false.
	   If disabled than all attempts to create quick lifetime entites will fail. *>
	bool use_quicks;
	<* Buffer for quick life time entities, must be provided from the main app. *>
	Entity[QUICK_CHUNK_SIZE]* buffer;
	<* Current inserting index in the quick lifetime buffer (last inserted index + 1). *>
	usz idx;
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
fn void World.init(&self) @private {
	self.components.init(mem);
	self.tags.init(mem);
	self.resources.init(mem);

	self.quicks.init(mem);
	self.dynamics.init(mem);
	self.statics.init(mem);
}

<* Registers element type for the world.
   @param element : "World element kind."
   @param $Type : "Element (component/tag/resource) type."
   @param buffer : "Pointer to buffer for quick lifetime chunk. Ensure that you don't use same buffers for different worlds."
   @require $Type.kindof == TypeKind.STRUCT || $Type.kindof == TypeKind.DISTINCT : "Element type is not valid."
   @require !(element == COMPONENT && self.components.has_key($Type.typeid)) : "Component already registered."
   @require !(element == TAG && self.tags.has_key($Type.typeid)) : "Tag already registered."
   @require !(element == RESOURCE && self.resources.has_key($Type.typeid)) : "Resource already registered."
   @require !(element != COMPONENT && buffer != null) : "You do not need a bufer for different from component element type."
   @require !(buffer != null && buffer.type != $Type[QUICK_CHUNK_SIZE].typeid) : "Buffer must have a type of array $Type[QUICK_CHUNK_SIZE]."
   @return "Pointer to the world for chain calls."
*>
macro World* World.register(&self, Element element, $Type, any buffer = null) {
	switch (element) {
		case COMPONENT:
			self.components.set($Type.typeid, { .type = $Type.typeid, .buffer = buffer });
			/* We must disbale quick lifetime for this world when no buffer provided. */
			if (buffer == null) self.use_quicks = false;
		case TAG:
			self.tags.set($Type.typeid, { .type = $Type.typeid, .idx = self.tags.len() });
		case RESOURCE:
			self.resources.set($Type.typeid, { .type = $Type.typeid });
	}

	return self;
}

<* Runs the world, but at first constructs all neccessary data from registered elements.
   World must has at least one registered component, but can has no tags, resources.
   @require !self.components.is_empty() : "The world has no registered components."
*>
fn World* World.run(&self) {
	// self.new(QUICK);
	// self.new(DYNAMIC);
	// self.new(STATIC);

	return self;
}

<* Spawns new entity into the world.
   @param lifetime : "Entity lifetime (default: Lifetime.DYNAMIC)."
   @require !(lifetime == QUICK && !self.use_quicks) : "Quick lifetime was disabled, you should provide entity and components buffers."
   @return "Pointer to new entity."
*>
fn Entity* World.spawn(&self, Lifetime lifetime = DYNAMIC) {
	Entity* entity;

	switch (lifetime) {
		case QUICK: {
			if (self.idx == QUICK_CHUNK_SIZE) {
			    /* If buffers are full we must flush them to free quick block. */
				self.get_free_block(QUICK).absorb();
				/* And reset current inserting index. */
				self.idx = 0;
			}

			/* .block == null is a sign that entity is in the quick lifetime buffer, not a real block.			  */
			(*self.buffer)[self.idx] = { .chunk_idx = self.idx }; /* But .chunk_idx will not change when flushed. */
			entity = &(*self.buffer)[self.idx++];				  /* Here we increase inserting index.			  */
		}
		
		case DYNAMIC:
		case STATIC: entity = self.get_sparse_block(lifetime).insert();
	}

	return entity;
}

<* Creates new empty block in the world.
   @param lifetime : "Block lifetime."
   @return "Pointer to newly created block interface."
*>
fn BlockGene World.new(&self, Lifetime lifetime) @local {
	BlockGene block;

	switch (lifetime) {
		case QUICK:
			self.quicks.push({ .lifetime = QUICK, .world = self });
			block = self.quicks.get_ref(self.quicks.size - 1);
		case DYNAMIC:
			self.dynamics.push({ .lifetime = DYNAMIC, .world = self });
			block = self.dynamics.get_ref(self.dynamics.size - 1);
		case STATIC:
			self.statics.push({ .lifetime = STATIC, .world = self });
			block = self.statics.get_ref(self.statics.size - 1);
	}

	block.init();

	return block;
}

<* Gets the reference to block interface that is available to insert new entities,
   has free rows or newly created one.
   @param lifetime : "Block lifetime."
   @require lifetime != QUICK : "Quick lifetime blocks can't be sparsed."
   @return "Pointer to available block interface."
*>
fn BlockGene World.get_sparse_block(&self, Lifetime lifetime) @inline @local {
	return self.find_block(lifetime, fn (b) => b.has_free_rows()) ?? self.new(lifetime);
}

<* Gets the reference to block interface that is totally free block.
   @param lifetime : "Block lifetime."
   @return "Pointer to free block interface."
*>
fn BlockGene World.get_free_block(&self, Lifetime lifetime) @inline @local {
	return self.find_block(lifetime, fn (b) => b.free()) ?? self.new(lifetime);
}

<* Finds a block using match predicate function.
   @param lifetime : "Block lifetime."
   @param match : "Predicate function for match blocks using their intefraces."
   @return "Pointer to block interface."
   @return? NOT_FOUND : "Block was not found."
*>
fn BlockGene? World.find_block(&self, Lifetime lifetime, BlockGeneMatch match) @private {
	switch (lifetime) {
		case QUICK:
			foreach (&b : self.quicks) { if (match(b)) return b; }
		case DYNAMIC:
			foreach (&b : self.dynamics) { if (match(b)) return b; }
		case STATIC:
			foreach (&b : self.statics) { if (match(b)) return b; }
	}

	return NOT_FOUND?;
}
