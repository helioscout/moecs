package moecs

import "core:mem"
import "base:runtime"
import "core:slice"
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
	entities : []Entity,
	/* Component chunks collection for the block.
	   Chunk is represented as a block in memory with sequentially recorded component's values.
	   The order (offset of each component) is defined in Components collection.
	   A pointer to allocated memory block. */
	chunks : rawptr,
	/* Deleted (freed) rows in the dynamic lifetime block. */
	deleted : sa.Small_Array(DYNAMIC_CHUNK_SIZE, int),
	/* Current inserting index in the block (last inserted index + 1).
	   If it equals chunk size than new block should be inserted to the world. */
	idx : int,
	/* Block chunk size dependent on lifetime. */
	size : int
}

/* Initializes the block. */
@(private="package")
block_init :: proc(block: ^Block) {
	block.entities = make([]Entity, block.size)

	ptr, err := mem.alloc(block.world.components.size * block.size)
	if err != .None do panic(fmt.tprintf("Storage memory allocation error: %v", err))
	block.chunks = ptr
}

/* Checks for existence of free rows (places to insert new entities/components).
   `block` : Reference to the block. */
@(private="package")
block_has_free_rows :: proc(block: ^Block) -> bool {
	switch block.lifetime {
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
		case .DYNAMIC: return block.idx == 0 || sa.len(block.deleted) == block.idx
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
		case .DYNAMIC: sa.append(&block.deleted, idx)
		case .STATIC:  panic("Static entities can't be deleted.")
	}
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
		if block.lifetime == .DYNAMIC && slice.contains(sa.slice(&block.deleted), idx) {
			idx += 1
		} else {
			iter.entity = &block.entities[idx] 
			iter.idx = idx
			
			return true
		}
	}

	return false
}

/* Returns index of the first free to insert (last deleted) row in the block.
   `block`   : Reference to the block.
   `returns` : Index of the row to insert. */
@(private="file")
block_pop_free_index :: proc(block: ^Block) -> int {
	idx: int = ---

	switch block.lifetime {
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
