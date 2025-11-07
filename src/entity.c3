module moecs;

<* Entity type. *>
struct Entity {
	<* The index of the block that contains the collection with the entity. *>
	usz block_idx;
	<* The index of the component in the collection. *>
	usz chunk_idx;
}
