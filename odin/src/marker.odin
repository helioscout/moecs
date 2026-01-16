// #+private
package moecs

/* Bits enumeration starts from 0. */

/* Checks if all bits in the marker are set to 1.
   `$count` : Whole marker bits count.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array). */
marker_is_all_set :: #force_inline proc($count: int, $size: uint, marker: [size]uint) -> bool #no_bounds_check {
	for i in 0..<size - 1 {
		if marker[i] ~ max(uint) != 0 do return false
	}

	remaining := max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)
	
	if marker[size - 1] & remaining != remaining {
		return false
	} else {
		return true
	}
}

/* Checks if all bits in the marker are set to 0.
   `$count` : Whole marker bits count.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array). */
marker_is_all_unset :: #force_inline proc($count: int, $size: uint, marker: [size]uint) -> bool #no_bounds_check {
	for i in 0..<size - 1 {
		if marker[i] > 0 do return false
	}

	remaining := max(uint) >> (MARKER_BITS_COUNT - uint(count) % MARKER_BITS_COUNT)

	if marker[size - 1] & remaining != 0 {
		return false
	} else {
		return true
	}
}

/* Checks if any of bits in the marker are set to 1.
   `$size`  : Marker (array) size.
   `marker` : Bitset (marker array). */
marker_is_any_set :: #force_inline proc($size: uint, marker: [size]uint) -> bool #no_bounds_check {
	for i in 0..<size {
		if marker[i] > 0 do return true
	}

	return false
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
	return marker[idx / MARKER_BITS_COUNT] & (1 << (idx % MARKER_BITS_COUNT )) != 0
}

/* Perform bitwise AND over all bits of two markers.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array).
   `returns` : New marker. */
marker_and :: #force_inline proc($size: uint, marker1: [size]uint, marker2: [size]uint) -> [size]uint #no_bounds_check {
	marker: [size]uint

	for i in 0..<size do marker[i] = marker1[i] & marker2[i]
	
	return marker
}

/* Perform bitwise OR over all bits of two markers.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array).
   `returns` : New marker. */
marker_or :: #force_inline proc($size: uint, marker1: [size]uint, marker2: [size]uint) -> [size]uint #no_bounds_check {
	marker: [size]uint

	for i in 0..<size do marker[i] = marker1[i] | marker2[i]
	
	return marker
}

/* Perform bitwise XOR over all bits of two markers.
   `$size`   : Markers (arrays) size.
   `marker1` : First bitset (marker array).
   `marker2` : Second bitset (marker array).
   `returns` : New marker. */
marker_xor :: #force_inline proc($size: uint, marker1: [size]uint, marker2: [size]uint) -> [size]uint #no_bounds_check {
	marker: [size]uint

	for i in 0..<size do marker[i] = marker1[i] ~ marker2[i]
	
	return marker
}
