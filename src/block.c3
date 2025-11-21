<* @require CHUNK_SIZE == moecs::QUICK_CHUNK_SIZE || CHUNK_SIZE == moecs::DYNAMIC_CHUNK_SIZE || CHUNK_SIZE == moecs::STATIC_CHUNK_SIZE : "Block chunk size must be one of three constants. " *>
module moecs::block { CHUNK_SIZE };

import std::collections::elastic_array;
import std::collections::bitset;
import std::io;

<* Entities collection (chunk) for the block.
   The index of the entity corresponds to the index of its components in each chunk. *>
alias Entities = Entity[CHUNK_SIZE];

<* Indexes type for deleted rows and other chunk sized data. *>
alias Indexes = ElasticArray { usz, CHUNK_SIZE };

<* Marker of used rows in quick lifetime chunks. *>
alias Marker = BitSet { CHUNK_SIZE };

<* Block type, building block of the world. *>
struct Block (BlockGene) {
	<* Reference to the parent world. *>
	World* world;
	<* Block lifetime. *>
	Lifetime lifetime;
	<* Entities collection for the block. *>
	Entities* entities;
	<* Component chunks collection for the block. *>
	Chunks chunks;
	<* Deleted (freed) rows in the dynamic lifetime block. *>
	Indexes deleted;
	<* Occupied (used) rows in the quick lifetime block. *>
	Marker occupied;
	<* Current inserting index in the block (last inserted index + 1).
	   If it equals CHUNK_SIZE than new block should be inserted to the world. *>
	usz idx;
}

<* Initializes the block.
   @require !self.chunks.is_initialized() : "Block was already initialized."
*>
fn void Block.init(&self) @dynamic @private {
	self.entities = mem::alloc(Entities);
	self.chunks.init(mem);

	self.world.components.@each_ref(; typeid type, Component* c) {
		/* Allocate memory for components chunks.					 */
		/* It should be later casted to corresponding array pointer. */
		self.chunks.set(type, malloc(c.size * CHUNK_SIZE));
	};
}

<* Gets world reference the block belongs to.
   @return "Reference to the world."
*>
fn World* Block.get_world(&self) @inline @dynamic @private {
	return self.world;
}

<* Gets the block's lifetime.
   @return "Block lifetime." *>
fn Lifetime Block.get_lifetime(&self) @inline @dynamic @private {
	return self.lifetime;
}

<* Gets component chunk of specified type.
   @param type : "Component type id."
   @return "Pointer to the component chunk."
*>
fn char*? Block.get_chunk(&self, typeid type) @inline @dynamic @private {
	return self.chunks.get(type);
}

<* Checks for existence of free rows (places to insert new entities/components).
   For quick lifetime blocks it equals to totally free block (self.free()).
*>
fn bool Block.has_free_rows(&self) @inline @dynamic @private {
	switch (self.lifetime) {
		case QUICK:   return self.occupied.cardinality() == 0;
		case DYNAMIC: return self.idx < CHUNK_SIZE || self.deleted.size > 0;
		case STATIC:  return self.idx < CHUNK_SIZE;
	}

	return false;
}

<* Checks if all rows in the block are filled in. *>
fn bool Block.full(&self) @inline @dynamic @private {
	switch (self.lifetime) {
		case QUICK:   return self.occupied.cardinality() > 0;
		case DYNAMIC: return self.idx == CHUNK_SIZE && self.deleted.size == 0;
		case STATIC:  return self.idx == CHUNK_SIZE;
	}

	return false;
}

<* Checks that no one row in the block are filled in, it's totally free. *>
fn bool Block.free(&self) @inline @dynamic @private {
	switch (self.lifetime) {
		case QUICK:   return self.occupied.cardinality() == 0;
		case DYNAMIC: return self.idx == 0 || self.deleted.size == (self.idx - 1);
		case STATIC:  return self.idx == 0;
	}

	return false;
}

<* Inserts entity into the block.
   @require self.lifetime != QUICK : "You can't insert into quick lifetime block, it's frozen after mem::copy."
   @return "Pointer to inserted entity."
*>
fn Entity* Block.insert(&self) @dynamic @private {
	usz idx = self.pop_free_index();

	(*self.entities)[idx] = { .block = self, .chunk_idx = idx };
	
	return &(*self.entities)[idx];
}

<* Flush all chunks from the buffers into this block.
   @require self.lifetime == QUICK : "Only quick lifetime block can absorb chunks from the buffer."
*>
fn void Block.absorb(&self) @dynamic @private {
	
}

<* Returns index of the first free to insert (last deleted) row in the block.
   @require !(self.deleted.is_empty() && self.idx == CHUNK_SIZE) : "The block is already full."
   @ensure return >= 0 && return < CHUNK_SIZE : "Index can't be less then 0 and grater then CHUNK_SIZE."
   @return "Index of the row to insert."
*>
fn usz Block.pop_free_index(&self) @inline @local {
	usz idx @noinit;
	
	switch (self.lifetime) {
		/* Quick blocks can be only completely filled and reused when they are totally free. */
		case QUICK: idx = 0;
		case DYNAMIC: idx = self.deleted.is_empty() ? self.idx++ : self.deleted.pop()!!;
		case STATIC: idx = self.idx++;
	}

	return idx;
}
