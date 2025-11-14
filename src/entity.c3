module moecs;

<* Entity type. *>
struct Entity {
	<* Reference to the parent block interface.
	   If null than entity is in the quick lifetime buffer, not a real block. *>
	BlockGene block;
	<* The index of the entity in the collection (chunk index for its components). *>
	usz chunk_idx;
}
