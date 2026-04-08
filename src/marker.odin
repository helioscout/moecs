#+private
package moecs

/* Bits enumeration starts from 0. */

/* Checks if all bits in the marker are set to 1.
   `$count` : Whole marker bits count.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array). */
marker_is_all_set :: #force_inline proc($count: int, $size: uint, marker: [size]uint) -> bool #no_bounds_check {
	for i : uint = 0; i < size - 1; i += 1 {
		if marker[i] ~ max(uint) != 0 do return false
	}

	remaining := uint(count) == MARKER_BITS_COUNT ? max(uint) : max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)
	
	return marker[size - 1] & remaining == remaining
}

/* Checks if all bits in the marker are set to 0.
   `$count` : Whole marker bits count.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array). */
marker_is_all_unset :: #force_inline proc($count: int, $size: uint, marker: [size]uint) -> bool #no_bounds_check {
	for i : uint = 0; i < size - 1; i += 1 {
		if marker[i] > 0 do return false
	}

	remaining := uint(count) == MARKER_BITS_COUNT ? max(uint) : max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)

	return marker[size - 1] & remaining == 0
}

/* Checks if any of bits in the marker are set to 1.
   `$count` : Whole marker bits count.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array). */
marker_is_any_set :: #force_inline proc($count: int, $size: uint, marker: [size]uint) -> bool #no_bounds_check {
	for i : uint = 0; i < size - 1; i += 1 {
		if marker[i] > 0 do return true
	}

	remaining := uint(count) == MARKER_BITS_COUNT ? max(uint) : max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)

	return marker[size - 1] & remaining > 0
}

/* Checks if all the bits of two markers are equal.
   `$count`  : Whole marker bits count.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array). */
marker_equals :: #force_inline proc($count: int, $size: uint, marker1: [size]uint, marker2: [size]uint) -> bool #no_bounds_check {
	for i : uint = 0; i < size - 1; i += 1 {
		if marker1[i] != marker2[i] do return false
	}

	remaining := uint(count) == MARKER_BITS_COUNT ? max(uint) : max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)

	return marker1[size - 1] & remaining == marker2[size - 1] & remaining
}

/* Clones marker.
   `$size`   : Marker (array) size.
   `marker`  : Bitset (marker array).
   `returns` : New marker. */
marker_clone :: #force_inline proc($size: uint, marker: [size]uint) -> [size]uint #no_bounds_check {
	clone: [size]uint = ---

	for i in 0..<size do clone[i] = marker[i]

	return clone
}

/* Set all marker's bits to 0.
   `$size`   : Marker (array) size.
   `marker`  : Pointer to bitset (marker array). */
marker_clear :: #force_inline proc($size: uint, marker: ^[size]uint) #no_bounds_check {
	for i in 0..<size do marker[i] = 0
}

/* Checks if all bits of one marker (subset) included into other marker.
   `$count` : Whole marker bits count.
   `$size`  : Markers (arrays) size.
   `marker` : Bitset that should include a subset.
   `subset` : Bitset that should be included into marker. */
marker_is_subset :: #force_inline proc($count: int, $size: uint, marker: [size]uint, subset: [size]uint) -> bool {
	return marker_equals(count, size, marker_and(size, marker, subset), subset)
}

/* Sets marker's bit to 1.
   `$size`  : Marker (array) size.
   `marker` : Pointer to bitset (marker array).
   `idx`    : Bit index. */
marker_set :: #force_inline proc($size: uint, marker: ^[size]uint, #any_int idx: uint) #no_bounds_check {
	marker[idx / MARKER_BITS_COUNT] |= 1 << (idx % MARKER_BITS_COUNT)
}

/* Unsets marker's bit (set to 0).
   `$size`  : Marker (array) size.
   `marker` : Pointer to bitset (marker array).
   `idx`    : Bit index. */
marker_unset :: #force_inline proc($size: uint, marker: ^[size]uint, #any_int idx: uint) #no_bounds_check {
	marker[idx / MARKER_BITS_COUNT] &~= 1 << (idx % MARKER_BITS_COUNT)
}

/* Check if marker's bit at index idx is set to 1.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array).
   `idx`    : Bit index. */
marker_is_set :: #force_inline proc($size: uint, marker: [size]uint, #any_int idx: uint) -> bool #no_bounds_check {
	return marker[idx / MARKER_BITS_COUNT] & (1 << (idx % MARKER_BITS_COUNT)) != 0
}

/* Sets all marker's bits to 1.
   `$count` : Whole marker bits count.
   `$size`  : Marker (array) size.
   `marker` : Pointer to bitset (marker array). */
marker_set_all :: #force_inline proc($count: int, $size: uint, marker: ^[size]uint) #no_bounds_check {
	for i : uint = 0; i < size - 1; i += 1 {
		marker[i] = max(uint)
	}

	marker[size - 1] = uint(count) == MARKER_BITS_COUNT ? max(uint) : max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)
}

/* Perform bitwise AND over all bits of two markers.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array).
   `returns` : New marker. */
marker_and :: #force_inline proc($size: uint, marker1: [size]uint, marker2: [size]uint) -> [size]uint #no_bounds_check {
	marker: [size]uint = ---

	for i in 0..<size do marker[i] = marker1[i] & marker2[i]
	
	return marker
}

/* Perform bitwise OR over all bits of two markers.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array).
   `returns` : New marker. */
marker_or :: #force_inline proc($size: uint, marker1: [size]uint, marker2: [size]uint) -> [size]uint #no_bounds_check {
	marker: [size]uint = ---

	for i in 0..<size do marker[i] = marker1[i] | marker2[i]
	
	return marker
}

/* Perform bitwise XOR over all bits of two markers.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array).
   `returns` : New marker. */
marker_xor :: #force_inline proc($size: uint, marker1: [size]uint, marker2: [size]uint) -> [size]uint #no_bounds_check {
	marker: [size]uint = ---

	for i in 0..<size do marker[i] = marker1[i] ~ marker2[i]
	
	return marker
}
