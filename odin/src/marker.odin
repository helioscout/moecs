#+private
package moecs

/* Checks if all bits in the marker are set to 1.
   `marker` : Slice to marker array. */
marker_is_all_set :: proc(marker: []u8) -> bool {
	for bit in marker {
		if bit == 0 do return false
	}

	return true
}

/* Checks if all bits in the marker are set to 0.
   `marker` : Slice to marker array. */
marker_is_all_unset :: proc(marker: []u8) -> bool {
	for bit in marker {
		if bit == 1 do return false
	}

	return true
}

/* Gets number of bits set to 1.
   `marker` : Slice to marker array. */
marker_cardinality :: proc(marker: []u8) -> int {
	count: int

	for bit in marker {
		count += int(bit)
	}

	return count
}

/* Sets marker's bit to 1.
   `marker` : Slice to marker array.
   `idx`    : Bit index. */
marker_set :: #force_inline proc(marker: []u8, idx: int) #no_bounds_check {
	marker[idx] = 1
}

/* Unsets marker's bit (set to 0).
   `marker` : Slice to marker array.
   `idx`    : Bit index. */
marker_unset :: #force_inline proc(marker: []u8, idx: int) #no_bounds_check {
	marker[idx] = 0
}

/* Check if marker's bit at index idx is set to 1.
   `marker` : Slice to marker array.
   `idx`    : Bit index. */
marker_is_set :: #force_inline proc(marker: []u8, idx: int) -> bool #no_bounds_check {
	return marker[idx] == 1
}
