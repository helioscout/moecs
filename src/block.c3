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
	<* Block lifetime. *>
	Lifetime lifetime;
	<* Entities collection for the block. *>
	Entities* entities;
	<* Component chunks collection for the block. *>
	Chunks chunks;
	<* Deleted (freed) rows in the block. *>
	Indexes deleted;
	<* Occupied (used) rows in the quick lifetime block. *>
	Marker occupied;
	<* Current inserting index in the block (last inserted index + 1).
	   If it equals CHUNK_SIZE than new block should be inserted to the world. *>
	usz idx;
}

<* Initializes the block. *>
fn void Block.init(&self) @dynamic @private {
	self.entities = mem::alloc(Entities);
	self.chunks.init(mem);

	io::printfn("Initializing: %s", self.lifetime);
	io::printfn("Size of entities: %d", $sizeof(*self.entities));
}

<* Checks for existence of free rows (places to insert new entities/components.) *>
fn bool Block.has_free_rows(&self) @inline @dynamic @private {
	switch (self.lifetime) {
		case QUICK: return self.occupied.cardinality() == 0;
		case DYNAMIC:
		case STATIC: return self.idx < CHUNK_SIZE || self.deleted.size > 0;
	}

	return false;
}

<* Checks if all rows in the block are filled in. *>
fn bool Block.full(&self) @inline @dynamic @private {
	switch (self.lifetime) {
		case QUICK: return self.occupied.cardinality() > 0;
		case DYNAMIC:
		case STATIC: return self.idx == CHUNK_SIZE && self.deleted.size == 0;
	}

	return false;
}

<* Checks that no one row in the block are filled in, it's totally free. *>
fn bool Block.free(&self) @inline @dynamic @private {
	switch (self.lifetime) {
		case QUICK: return self.occupied.cardinality() == 0;
		case DYNAMIC:
		case STATIC: return self.idx == 0 || self.deleted.size == (self.idx - 1);
	}

	return false;
}
