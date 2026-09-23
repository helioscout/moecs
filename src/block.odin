package moecs

import "core:mem"
import "base:runtime"
import "core:slice"
import "core:fmt"

/* Block type, building block of the world. */
@(private="package")
Block :: struct {
	/* Reference to the parent world. */
	world : ^World,
	/* Entities collection (chunk) for the block.
	   The index of the entity corresponds to the index of its components in each chunk. */
	entities : []Entity,
	/* Component and relation chunks collection for the block.
	   Chunk is represented as a block in memory with sequentially recorded component's values.
	   And after them sequentially recorded relations with targets values.
	   The order (offset of each component/relation) is defined in Components/Relations collection.
	   A pointer to allocated memory block. */
	chunks : rawptr,
	/* Deleted (freed) row indexes in the block. */
	deleted : [dynamic; CHUNK_SIZE]int,
	/* Current inserting index in the block (last inserted index + 1).
	   If it equals chunk size than new block should be inserted to the world. */
	idx : int
}

/* Initializes the block and allocates memory for it's chunk and entities collection. */
@(private="package")
block_init :: proc(block: ^Block) {
	block.entities = make([]Entity, CHUNK_SIZE)

	ptr, err := mem.alloc(block.world.chunk_size * CHUNK_SIZE)
	if err != .None do panic(fmt.tprintf(ERR_STORAGE_ALLOCATION, err))
	block.chunks = ptr
}

/* Checks for existence of free rows (places to insert new entities/components/relations).
   `block` : Reference to the block. */
@(private="package")
block_has_free_rows :: #force_inline proc(block: ^Block) -> bool {
	/* There is free index to insert or free indexes after entity removing. */
	return block.idx < CHUNK_SIZE || len(block.deleted) > 0
}

/* Checks if all rows in the block are filled in.
   `block` : Reference to the block. */
@(private="package")
block_is_full :: #force_inline proc(block: ^Block) -> bool {
	/* There is no index to insert and no deleted entities in the block. */
	return block.idx == CHUNK_SIZE && len(block.deleted) == 0
}

/* Checks that no one row in the block are filled in, it's totally free.
   `block` : Reference to the block. */
@(private="package")
block_is_free :: #force_inline proc(block: ^Block) -> bool {
	/* No one index was used or all entities were deleted. */
	return block.idx == 0 || len(block.deleted) == block.idx
}

/* Inserts entity into the block.
   `block`   : Reference to the block.
   `returns` : Pointer to inserted entity. */
@(private="package")
block_insert :: proc(block: ^Block) -> ^Entity {
	idx := block_pop_free_index(block)

	block.entities[idx] = Entity { block = block, chunk_idx = idx }

	return &block.entities[idx]
}

/* Deletes entity from the block.
   `block` : Reference to the block.
   `idx`   : Entity index. */
@(private="package")
block_delete :: #force_inline proc(block: ^Block, idx: int) {
	/* Append entity index to deleted collection, makes it free to insert. */
	append(&block.deleted, idx)
}

/* Iterate to the next alive (not deleted) entity in the block.
   `block`   : Reference to the block.
   `iter`    : Entities iterator.
   `returns` : True if next entity found, otherwise - false. */
@(private="package")
block_iter :: #force_inline proc(block: ^Block, iter: ^EntitiesIterator) -> bool #no_bounds_check {
	/* Start from next possible entity index. */
	idx := iter.entity == nil ? 0 : iter.idx + 1

	for idx < block.idx {
		if slice.contains(block.deleted[:], idx) {
			idx += 1
		} else {
			iter.entity = &block.entities[idx] 
			iter.idx = idx
			
			return true
		}
	}

	return false
}

/* Returns index of the first free to insert (or last deleted) row in the block.
   `block`   : Reference to the block.
   `returns` : Index of the row to insert. */
@(private="file")
block_pop_free_index :: proc(block: ^Block) -> int {
	idx: int = ---

	if len(block.deleted) == 0 {
		idx = block.idx
		block.idx += 1
	} else {
		idx = pop(&block.deleted)
	}

	return idx
}

/* Free all block resources.
   `block`   : Reference to the block. */
@(private="package")
free_block :: proc(block: ^Block) {
	delete(block.entities)
	free(block.chunks)
}
