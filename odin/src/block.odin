package moecs

import "core:mem"
import "base:runtime"
import sa "core:container/small_array"
import "core:fmt"

/* Block type, building block of the world. */
@(private="package")
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
	deleted : sa.Small_Array(DYNAMIC_CHUNK_SIZE, int),
	/* Occupied (used) rows in the quick lifetime block. */
	occupied : [QUICK_CHUNK_SIZE]u8,
	/* Current inserting index in the block (last inserted index + 1).
	   If it equals ChunkSize than new block should be inserted to the world. */
	idx : int,
	/* Block chunk size dependent on lifetime. */
	size : int
}

/* Initializes the block. */
@(private="package")
block_init :: proc(block: ^Block) {
	resize(&block.entities, block.size)

	for type, &component in block.world.components {
		/* Allocate memory for components chunks.					 */
		/* It should be later casted to corresponding array pointer. */
		ptr, err := mem.alloc(component.size * block.size)

		if err != .None do panic(fmt.tprintf("Chunk memory allocation error: %v", err))

		block.chunks[type] = ptr
	}
}

/* Checks for existence of free rows (places to insert new entities/components).
   For quick lifetime blocks it equals to totally free block (block_is_free()).
   `block` : Reference to the block. */
@(private="package")
block_has_free_rows :: proc(block: ^Block) -> bool {
	switch block.lifetime {
		case .QUICK:   return marker_is_all_unset(block.occupied[:])
		case .DYNAMIC: return block.idx < DYNAMIC_CHUNK_SIZE || sa.len(block.deleted) > 0
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
		case .DYNAMIC: return block.idx == DYNAMIC_CHUNK_SIZE && sa.len(block.deleted) == 0
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
		case .DYNAMIC: return block.idx == 0 || sa.len(block.deleted) == block.idx - 1
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

/* Deletes entity from the block.
   `block` : Reference to the block.
   `idx`   : Entity index. */
@(private="package")
block_delete :: proc(block: ^Block, idx: int) {
	switch block.lifetime {
		case .QUICK:   marker_unset(block.occupied[:], idx)
		case .DYNAMIC: sa.append(&block.deleted, idx)
		case .STATIC:  panic("Static entities can't be deleted.")
	}
}

/* Flush all chunks from the buffers into this block.
   Only quick lifetime block can absorb chunks from the buffer.*/
@(private="package")
block_absorb :: proc(block: ^Block) {
	/* block.world.idx - count of buffered entities.      */
	/* Copy buffered entities to the block's collection. */
	copy(block.entities[0:block.world.idx], block.world.buffer[0:block.world.idx])

	/* Copy components from buffers to block chunks. */
	for type, &component in block.world.components {
		mem.copy(block.chunks[type], component.buffer, component.size * block.world.idx)
	}

	/* Step through all copied entities. */
	for i in 0..<block.world.idx {
		block.entities[i].state -= { .BUFFERED }	/* Unset entity BUFFERED state.          */
		marker_set(block.occupied[:], i)			/* Set occupied marker for entity index. */
	}

	/* If buffer is not full, we need unset occupied marker for its rest. */
	if block.world.idx < block.size {
		for i in block.world.idx..<block.size {		/* block.size here will be */
			marker_unset(block.occupied[:], i)		/* QUICK_CHUNK_SIZE btw.   */
		}
	}
	
	block.idx = block.world.idx
}

/* Returns index of the first free to insert (last deleted) row in the block.
   `block`   : Reference to the block.
   `returns` : Index of the row to insert. */
@(private="file")
block_pop_free_index :: proc(block: ^Block) -> int {
	idx: int = ---

	switch block.lifetime {
		/* Quick blocks can be only completely filled and reused when they are totally free. */
		case .QUICK: idx = 0
		case .DYNAMIC:
			if sa.len(block.deleted) == 0 {
				idx = block.idx
				block.idx += 1
			} else {
				idx = sa.pop_back(&block.deleted)
			}
		case .STATIC:
			idx = block.idx
			block.idx += 1
	}

	return idx
}
