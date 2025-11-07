module moecs;

import std::io;

<* Base component subtype, must be inlined into each declared component struct. *>
struct Component (Printable) {
	<* The index of the block that contains the chunk with the component. *>
	usz block_idx;
	<* The index of the component in the chunk. *>
	usz chunk_idx;
}

fn usz? Component.to_format(&self, Formatter* f) @dynamic {
	return f.printf("block index: %d, chunk index: %d", self.block_idx, self.chunk_idx);
}
