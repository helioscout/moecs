package moecs

import "core:fmt"

/* Block type, building block of the world. */
Block :: struct {
	/* Reference to the parent world. */
	world : ^World,
	/* Block lifetime. */
	lifetime : Lifetime,
	/* Entities collection (chunk) for the block.
	   The index of the entity corresponds to the index of its components in each chunk. */
	entities : [dynamic]Entity,
	/* Component chunks collection for the block. */
	chunks : Chunks,
	/* Deleted (freed) rows in the dynamic lifetime block. */
	deleted : [dynamic]uint,
	/* Occupied (used) rows in the quick lifetime block. */
	occupied : [QUICK_CHUNK_SIZE]u8,
	/* Current inserting index in the block (last inserted index + 1).
	   If it equals ChunkSize than new block should be inserted to the world. */
	idx : uint,
	/* Block chunk size dependent on lifetime. */
	size : uint
}

/* Initializes the block. */
@(private="package")
block_init :: proc(block: ^Block) {
	resize(&block.entities, block.size)
}

/* Checks for existence of free rows (places to insert new entities/components).
   For quick lifetime blocks it equals to totally free block (block_is_free()).
   `block` : Reference to the block. */
@(private="package")
block_has_free_rows :: proc(block: ^Block) -> bool {
	switch block.lifetime {
		case .QUICK:   return marker_is_all_unset(block.occupied[:])
		case .DYNAMIC: return block.idx < DYNAMIC_CHUNK_SIZE || len(block.deleted) > 0
		case .STATIC:  return block.idx < STATIC_CHUNK_SIZE
	}

	return false
}

/* Checks if all rows in the block are filled in.
   `block` : Reference to the block. */
@(private="package")
block_is_full :: proc(block: ^Block) -> bool {
	switch block.lifetime {
		/* Even if one row is occupied, quick lifetime block can't be used for insert. */
		case .QUICK:   return marker_cardinality(block.occupied[:]) > 0
		case .DYNAMIC: return block.idx == DYNAMIC_CHUNK_SIZE && len(block.deleted) == 0
		case .STATIC:  return block.idx == STATIC_CHUNK_SIZE
	}

	return false
}

/* Checks that no one row in the block are filled in, it's totally free.
   `block` : Reference to the block. */
@(private="package")
block_is_free :: proc(block: ^Block) -> bool {
	switch block.lifetime {
		case .QUICK:   return marker_is_all_unset(block.occupied[:])
		case .DYNAMIC: return block.idx == 0 || len(block.deleted) == int(block.idx - 1)
		case .STATIC:  return block.idx == 0
	}

	return false
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

/* Flush all chunks from the buffers into this block.*/
@(private="package")
block_absorb :: proc(block: ^Block) {
	/* self.world.idx - count of buffered entities.      */
	/* Copy buffered entities to the block's collection. */
	copy(block.entities[0:block.world.idx], block.world.buffer[0:block.world.idx])

	block.idx = block.world.idx
}

/* Returns index of the first free to insert (last deleted) row in the block.
   `block`   : Reference to the block.
   `returns` : Index of the row to insert. */
@(private="file")
block_pop_free_index :: proc(block: ^Block) -> uint {
	idx: uint = ---

	switch block.lifetime {
		/* Quick blocks can be only completely filled and reused when they are totally free. */
		case .QUICK: idx = 0
		case .DYNAMIC:
			if len(block.deleted) == 0 {
				idx = block.idx
				block.idx += 1
			} else {
				idx = pop(&block.deleted)
			}
		case .STATIC:
			idx = block.idx
			block.idx += 1
	}

	return idx
}
