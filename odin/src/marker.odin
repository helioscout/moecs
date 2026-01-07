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
marker_cardinality :: proc(marker: []u8) -> uint {
	count: uint

	for bit in marker {
		count += uint(bit)
	}

	return count
}
