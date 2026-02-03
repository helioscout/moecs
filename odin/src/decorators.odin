#+private
package moecs

import "core:mem"

/* Adds 2 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_2_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)

	archetyping(entity)
}

/* Adds 3 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_3_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)

	archetyping(entity)
}

/* Adds 4 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_4_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)

	archetyping(entity)
}

/* Adds 5 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_5_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)

	archetyping(entity)
}

/* Adds 6 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_6_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)

	archetyping(entity)
}

/* Adds 7 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_7_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)

	archetyping(entity)
}

/* Adds 8 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_8_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)
	add_component(entity, Type8, component8, false)

	archetyping(entity)
}

/* Adds 9 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_9_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)
	add_component(entity, Type8, component8, false)
	add_component(entity, Type9, component9, false)

	archetyping(entity)
}

/* Adds 10 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_10_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)
	add_component(entity, Type8, component8, false)
	add_component(entity, Type9, component9, false)
	add_component(entity, Type10, component10, false)

	archetyping(entity)
}

/* Adds 11 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_11_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)
	add_component(entity, Type8, component8, false)
	add_component(entity, Type9, component9, false)
	add_component(entity, Type10, component10, false)
	add_component(entity, Type11, component11, false)

	archetyping(entity)
}

/* Adds 12 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_12_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)
	add_component(entity, Type8, component8, false)
	add_component(entity, Type9, component9, false)
	add_component(entity, Type10, component10, false)
	add_component(entity, Type11, component11, false)
	add_component(entity, Type12, component12, false)

	archetyping(entity)
}

/* Adds 13 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_13_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13) {
	add_component(entity, Type1, component1, false)
	add_component(entity, Type2, component2, false)
	add_component(entity, Type3, component3, false)
	add_component(entity, Type4, component4, false)
	add_component(entity, Type5, component5, false)
	add_component(entity, Type6, component6, false)
	add_component(entity, Type7, component7, false)
	add_component(entity, Type8, component8, false)
	add_component(entity, Type9, component9, false)
	add_component(entity, Type10, component10, false)
	add_component(entity, Type11, component11, false)
	add_component(entity, Type12, component12, false)
	add_component(entity, Type13, component13, false)

	archetyping(entity)
}

/* Sets 2 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_2_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
}

/* Sets 3 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_3_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
}

/* Sets 4 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_4_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
}

/* Sets 5 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_5_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5) {
	// id1: u64 = transmute(u64)typeid_of(Type1)
	// id2: u64 = transmute(u64)typeid_of(Type2)
	// id3: u64 = transmute(u64)typeid_of(Type3)
	// id4: u64 = transmute(u64)typeid_of(Type4)
	// id5: u64 = transmute(u64)typeid_of(Type5)

	// world: ^World = entity.block.world
	// buffer: [16384]u8 = ---
	// storage: ^u8 = cast(^u8)entity.block.chunks
	// chunk_offset := world.components.size * entity.chunk_idx
	
	// mem.copy_non_overlapping(&buffer, mem.ptr_offset(storage, chunk_offset), world.components.size)

	// for i := 0; i < world.components.count; i += 1 {
	// 	id := world.components.ids[i]
	// 	offset := world.components.types[i].offset

	// 	if id == id1 {
	// 		mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component1, size_of(Type1))
	// 	} else if id == id2 {
	// 		mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component2, size_of(Type2))
	// 	} else if id == id3 {
	// 		mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component3, size_of(Type3))
	// 	} else if id == id4 {
	// 		mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component4, size_of(Type4))
	// 	} else if id == id5 {
	// 		mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component5, size_of(Type5))
	// 	}
	// }

	// mem.copy_non_overlapping(mem.ptr_offset(storage, chunk_offset), &buffer, world.components.size)
	
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
}

/* Sets 6 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_6_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
}

/* Sets 7 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_7_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7) {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)

	world: ^World = entity.block.world
	buffer: [16384]u8 = ---
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx
	
	mem.copy_non_overlapping(&buffer, mem.ptr_offset(storage, chunk_offset), world.components.size)

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component1, size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component2, size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component3, size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component4, size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component5, size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component6, size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(mem.ptr_offset(cast(^u8)&buffer, offset), component7, size_of(Type7))
		}
	}

	mem.copy_non_overlapping(mem.ptr_offset(storage, chunk_offset), &buffer, world.components.size)

	// set_component(entity, Type1, component1)
	// set_component(entity, Type2, component2)
	// set_component(entity, Type3, component3)
	// set_component(entity, Type4, component4)
	// set_component(entity, Type5, component5)
	// set_component(entity, Type6, component6)
	// set_component(entity, Type7, component7)
}

/* Sets 8 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_8_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
	set_component(entity, Type8, component8)
}

/* Sets 9 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_9_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
	set_component(entity, Type8, component8)
	set_component(entity, Type9, component9)
}

/* Sets 10 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_10_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
	set_component(entity, Type8, component8)
	set_component(entity, Type9, component9)
	set_component(entity, Type10, component10)
}

/* Sets 11 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_11_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
	set_component(entity, Type8, component8)
	set_component(entity, Type9, component9)
	set_component(entity, Type10, component10)
	set_component(entity, Type11, component11)
}

/* Sets 12 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_12_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
	set_component(entity, Type8, component8)
	set_component(entity, Type9, component9)
	set_component(entity, Type10, component10)
	set_component(entity, Type11, component11)
	set_component(entity, Type12, component12)
}

/* Sets 13 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_13_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13) {
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
	set_component(entity, Type8, component8)
	set_component(entity, Type9, component9)
	set_component(entity, Type10, component10)
	set_component(entity, Type11, component11)
	set_component(entity, Type12, component12)
	set_component(entity, Type13, component13)
}

/* Sets 2 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_2_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
}

/* Sets 3 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_3_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
}

/* Sets 4 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_4_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
}

/* Sets 5 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_5_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
}

/* Sets 6 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_6_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
}

/* Sets 7 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_7_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
}

/* Sets 8 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_8_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7, $Type8: typeid, resource8: ^Type8) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
	set_resource(world, Type8, resource8)
}

/* Sets 9 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_9_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7, $Type8: typeid, resource8: ^Type8,
	$Type9: typeid, resource9: ^Type9) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
	set_resource(world, Type8, resource8)
	set_resource(world, Type9, resource9)
}

/* Sets 10 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_10_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7, $Type8: typeid, resource8: ^Type8,
	$Type9: typeid, resource9: ^Type9, $Type10: typeid, resource10: ^Type10) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
	set_resource(world, Type8, resource8)
	set_resource(world, Type9, resource9)
	set_resource(world, Type10, resource10)
}

/* Sets 11 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_11_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7, $Type8: typeid, resource8: ^Type8,
	$Type9: typeid, resource9: ^Type9, $Type10: typeid, resource10: ^Type10,
	$Type11: typeid, resource11: ^Type11) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
	set_resource(world, Type8, resource8)
	set_resource(world, Type9, resource9)
	set_resource(world, Type10, resource10)
	set_resource(world, Type11, resource11)
}

/* Sets 12 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_12_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7, $Type8: typeid, resource8: ^Type8,
	$Type9: typeid, resource9: ^Type9, $Type10: typeid, resource10: ^Type10,
	$Type11: typeid, resource11: ^Type11, $Type12: typeid, resource12: ^Type12) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
	set_resource(world, Type8, resource8)
	set_resource(world, Type9, resource9)
	set_resource(world, Type10, resource10)
	set_resource(world, Type11, resource11)
	set_resource(world, Type12, resource12)
}

/* Sets 13 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : Reference to N-th resource value (will be copied into storage). */
set_13_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: ^Type1, $Type2: typeid, resource2: ^Type2,
	$Type3: typeid, resource3: ^Type3, $Type4: typeid, resource4: ^Type4,
	$Type5: typeid, resource5: ^Type5, $Type6: typeid, resource6: ^Type6,
	$Type7: typeid, resource7: ^Type7, $Type8: typeid, resource8: ^Type8,
	$Type9: typeid, resource9: ^Type9, $Type10: typeid, resource10: ^Type10,
	$Type11: typeid, resource11: ^Type11, $Type12: typeid, resource12: ^Type12,
	$Type13: typeid, resource13: ^Type13) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
	set_resource(world, Type6, resource6)
	set_resource(world, Type7, resource7)
	set_resource(world, Type8, resource8)
	set_resource(world, Type9, resource9)
	set_resource(world, Type10, resource10)
	set_resource(world, Type11, resource11)
	set_resource(world, Type12, resource12)
	set_resource(world, Type13, resource13)
}

/* Gets 2 references to the 2 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_2_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid) ->
	(c1: ^Type1, c2: ^Type2) {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}

	return
}

/* Gets 2 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_2_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid) ->
	(Type1, Type2) {
	c1: Type1 = ---
	c2: Type2 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		}
	}

	return c1, c2
}

/* Gets 3 references to the 3 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_3_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}

	return
}

/* Gets 3 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_3_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid) ->
	(Type1, Type2, Type3) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		}
	}

	return c1, c2, c3
}

/* Gets 4 references to the 4 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_4_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}

	return
}

/* Gets 4 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_4_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid) ->
	(Type1, Type2, Type3, Type4) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		}
	}

	return c1, c2, c3, c4
}

/* Gets 5 references to the 5 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_5_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 5 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_5_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid) ->
	(Type1, Type2, Type3, Type4, Type5) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		}
	}
	
	return c1, c2, c3, c4,c5
}

/* Gets 6 references to the 6 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_6_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 6 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_6_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		}
	}
	
	return c1, c2, c3, c4, c5, c6
}

/* Gets 7 references to the 7 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_7_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}

	return
}

/* Gets 7 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_7_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		}
	}

	return c1, c2, c3, c4, c5, c6, c7
}

/* Gets 8 references to the 8 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_8_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c8 = cast(^Type8)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 8 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_8_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---
	c8: Type8 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c8, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type8))
		}
	}
	
	return c1, c2, c3, c4, c5, c6, c7, c8
}

/* Gets 9 references to the 9 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_9_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c8 = cast(^Type8)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c9 = cast(^Type9)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}

	return
}

/* Gets 9 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_9_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---
	c8: Type8 = ---
	c9: Type9 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c8, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type8))
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c9, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type9))
		}
	}

	return c1, c2, c3, c4, c5, c6, c7, c8, c9
}

/* Gets 10 references to the 10 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_10_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c8 = cast(^Type8)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c9 = cast(^Type9)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c10 = cast(^Type10)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 10 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_10_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---
	c8: Type8 = ---
	c9: Type9 = ---
	c10: Type10 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c8, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type8))
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c9, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type9))
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c10, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type10))
		}
	}
	
	return c1, c2, c3, c4, c5, c6, c7, c8, c9, c10
}

/* Gets 11 references to the 11 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_11_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c8 = cast(^Type8)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c9 = cast(^Type9)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c10 = cast(^Type10)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c11 = cast(^Type11)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 11 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_11_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10, Type11) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---
	c8: Type8 = ---
	c9: Type9 = ---
	c10: Type10 = ---
	c11: Type11 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c8, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type8))
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c9, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type9))
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c10, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type10))
		} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c11, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type11))
		}
	}
	
	return c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11
}

/* Gets 12 references to the 12 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_12_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c8 = cast(^Type8)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c9 = cast(^Type9)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c10 = cast(^Type10)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c11 = cast(^Type11)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id12 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c12 = cast(^Type12)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 12 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_12_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10, Type11, Type12) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---
	c8: Type8 = ---
	c9: Type9 = ---
	c10: Type10 = ---
	c11: Type11 = ---
	c12: Type12 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c8, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type8))
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c9, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type9))
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c10, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type10))
		} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c11, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type11))
		} else if id == id12 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c12, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type12))
		}
	}
	
	return c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12
}

/* Gets 13 references to the 13 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_13_components_mut :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)
	id13: u64 = transmute(u64)typeid_of(Type13)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c1 = cast(^Type1)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c2 = cast(^Type2)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c3 = cast(^Type3)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c4 = cast(^Type4)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c5 = cast(^Type5)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c6 = cast(^Type6)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c7 = cast(^Type7)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c8 = cast(^Type8)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c9 = cast(^Type9)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c10 = cast(^Type10)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c11 = cast(^Type11)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id12 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c12 = cast(^Type12)mem.ptr_offset(storage, chunk_offset + offset)
		} else if id == id13 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			c13 = cast(^Type13)mem.ptr_offset(storage, chunk_offset + offset)
		}
	}
	
	return
}

/* Gets 13 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_13_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10, Type11, Type12,
	Type13) #no_bounds_check {
	c1: Type1 = ---
	c2: Type2 = ---
	c3: Type3 = ---
	c4: Type4 = ---
	c5: Type5 = ---
	c6: Type6 = ---
	c7: Type7 = ---
	c8: Type8 = ---
	c9: Type9 = ---
	c10: Type10 = ---
	c11: Type11 = ---
	c12: Type12 = ---
	c13: Type13 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)
	id13: u64 = transmute(u64)typeid_of(Type13)

	world: ^World = entity.block.world
	storage: ^u8 = cast(^u8)entity.block.chunks
	chunk_offset := world.components.size * entity.chunk_idx

	for i := 0; i < world.components.count; i += 1 {
		id := world.components.ids[i]
		offset := world.components.types[i].offset

		if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c1, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type1))
		} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c2, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type2))
		} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c3, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type3))
		} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c4, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type4))
		} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c5, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type5))
		} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c6, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type6))
		} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c7, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type7))
		} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c8, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type8))
		} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c9, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type9))
		} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c10, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type10))
		} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c11, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type11))
		} else if id == id12 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c12, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type12))
		} else if id == id13 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
			mem.copy_non_overlapping(&c13, mem.ptr_offset(storage, chunk_offset + offset), size_of(Type13))
		}
	}
	
	return c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13
}

/* Gets 2 references to 2 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_2_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid) ->
	(r1: ^Type1, r2: ^Type2) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 2 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_2_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid) ->
	(Type1, Type2) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		}
	}

	return r1, r2
}

/* Gets 3 references to 3 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_3_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 3 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_3_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid) ->
	(Type1, Type2, Type3) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		}
	}

	return r1, r2, r3
}

/* Gets 4 references to 4 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_4_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 4 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_4_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid) ->
	(Type1, Type2, Type3, Type4) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		}
	}

	return r1, r2, r3, r4
}

/* Gets 5 references to 5 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_5_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 5 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_5_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid) ->
	(Type1, Type2, Type3, Type4, Type5) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		}
	}

	return r1, r2, r3, r4, r5
}

/* Gets 6 references to 6 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_6_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 6 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_6_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		}
	}

	return r1, r2, r3, r4, r5, r6
}

/* Gets 7 references to 7 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_7_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 7 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_7_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7
}

/* Gets 8 references to 8 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_8_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		} else if id == id8 {
			r8 = cast(^Type8)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 8 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_8_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	r8: Type8 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		} else if id == id8 {
			mem.copy_non_overlapping(&r8, mem.ptr_offset(storage, offset), size_of(Type8))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7, r8
}

/* Gets 9 references to 9 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_9_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		} else if id == id8 {
			r8 = cast(^Type8)mem.ptr_offset(storage, offset)
		} else if id == id9 {
			r9 = cast(^Type9)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 9 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_9_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	r8: Type8 = ---
	r9: Type9 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		} else if id == id8 {
			mem.copy_non_overlapping(&r8, mem.ptr_offset(storage, offset), size_of(Type8))
		} else if id == id9 {
			mem.copy_non_overlapping(&r9, mem.ptr_offset(storage, offset), size_of(Type9))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7, r8, r9
}

/* Gets 10 references to 10 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_10_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		} else if id == id8 {
			r8 = cast(^Type8)mem.ptr_offset(storage, offset)
		} else if id == id9 {
			r9 = cast(^Type9)mem.ptr_offset(storage, offset)
		} else if id == id10 {
			r10 = cast(^Type10)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 10 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_10_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	r8: Type8 = ---
	r9: Type9 = ---
	r10: Type10 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		} else if id == id8 {
			mem.copy_non_overlapping(&r8, mem.ptr_offset(storage, offset), size_of(Type8))
		} else if id == id9 {
			mem.copy_non_overlapping(&r9, mem.ptr_offset(storage, offset), size_of(Type9))
		} else if id == id10 {
			mem.copy_non_overlapping(&r10, mem.ptr_offset(storage, offset), size_of(Type10))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7, r8, r9, r10
}

/* Gets 11 references to 11 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_11_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		} else if id == id8 {
			r8 = cast(^Type8)mem.ptr_offset(storage, offset)
		} else if id == id9 {
			r9 = cast(^Type9)mem.ptr_offset(storage, offset)
		} else if id == id10 {
			r10 = cast(^Type10)mem.ptr_offset(storage, offset)
		} else if id == id11 {
			r11 = cast(^Type11)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 11 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_11_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10, Type11) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	r8: Type8 = ---
	r9: Type9 = ---
	r10: Type10 = ---
	r11: Type11 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		} else if id == id8 {
			mem.copy_non_overlapping(&r8, mem.ptr_offset(storage, offset), size_of(Type8))
		} else if id == id9 {
			mem.copy_non_overlapping(&r9, mem.ptr_offset(storage, offset), size_of(Type9))
		} else if id == id10 {
			mem.copy_non_overlapping(&r10, mem.ptr_offset(storage, offset), size_of(Type10))
		} else if id == id11 {
			mem.copy_non_overlapping(&r11, mem.ptr_offset(storage, offset), size_of(Type11))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11
}

/* Gets 12 references to 12 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_12_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		} else if id == id8 {
			r8 = cast(^Type8)mem.ptr_offset(storage, offset)
		} else if id == id9 {
			r9 = cast(^Type9)mem.ptr_offset(storage, offset)
		} else if id == id10 {
			r10 = cast(^Type10)mem.ptr_offset(storage, offset)
		} else if id == id11 {
			r11 = cast(^Type11)mem.ptr_offset(storage, offset)
		} else if id == id12 {
			r12 = cast(^Type12)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 12 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_12_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10, Type11, Type12) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	r8: Type8 = ---
	r9: Type9 = ---
	r10: Type10 = ---
	r11: Type11 = ---
	r12: Type12 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		} else if id == id8 {
			mem.copy_non_overlapping(&r8, mem.ptr_offset(storage, offset), size_of(Type8))
		} else if id == id9 {
			mem.copy_non_overlapping(&r9, mem.ptr_offset(storage, offset), size_of(Type9))
		} else if id == id10 {
			mem.copy_non_overlapping(&r10, mem.ptr_offset(storage, offset), size_of(Type10))
		} else if id == id11 {
			mem.copy_non_overlapping(&r11, mem.ptr_offset(storage, offset), size_of(Type11))
		} else if id == id12 {
			mem.copy_non_overlapping(&r12, mem.ptr_offset(storage, offset), size_of(Type12))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12
}

/* Gets 13 references to 13 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_13_resources_mut :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13) #no_bounds_check {
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)
	id13: u64 = transmute(u64)typeid_of(Type13)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			r1 = cast(^Type1)mem.ptr_offset(storage, offset)
		} else if id == id2 {
			r2 = cast(^Type2)mem.ptr_offset(storage, offset)
		} else if id == id3 {
			r3 = cast(^Type3)mem.ptr_offset(storage, offset)
		} else if id == id4 {
			r4 = cast(^Type4)mem.ptr_offset(storage, offset)
		} else if id == id5 {
			r5 = cast(^Type5)mem.ptr_offset(storage, offset)
		} else if id == id6 {
			r6 = cast(^Type6)mem.ptr_offset(storage, offset)
		} else if id == id7 {
			r7 = cast(^Type7)mem.ptr_offset(storage, offset)
		} else if id == id8 {
			r8 = cast(^Type8)mem.ptr_offset(storage, offset)
		} else if id == id9 {
			r9 = cast(^Type9)mem.ptr_offset(storage, offset)
		} else if id == id10 {
			r10 = cast(^Type10)mem.ptr_offset(storage, offset)
		} else if id == id11 {
			r11 = cast(^Type11)mem.ptr_offset(storage, offset)
		} else if id == id12 {
			r12 = cast(^Type12)mem.ptr_offset(storage, offset)
		} else if id == id13 {
			r13 = cast(^Type13)mem.ptr_offset(storage, offset)
		}
	}

	return
}

/* Gets 13 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_13_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid) ->
	(Type1, Type2, Type3, Type4, Type5, Type6, Type7, Type8, Type9, Type10, Type11, Type12,
	Type13) #no_bounds_check {
	r1: Type1 = ---
	r2: Type2 = ---
	r3: Type3 = ---
	r4: Type4 = ---
	r5: Type5 = ---
	r6: Type6 = ---
	r7: Type7 = ---
	r8: Type8 = ---
	r9: Type9 = ---
	r10: Type10 = ---
	r11: Type11 = ---
	r12: Type12 = ---
	r13: Type13 = ---
	
	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)
	id10: u64 = transmute(u64)typeid_of(Type10)
	id11: u64 = transmute(u64)typeid_of(Type11)
	id12: u64 = transmute(u64)typeid_of(Type12)
	id13: u64 = transmute(u64)typeid_of(Type13)

	storage: ^u8 = cast(^u8)world.resources.storage

	for i := 0; i < world.resources.count; i += 1 {
		id := world.resources.ids[i]
		offset := world.resources.types[i].offset

		if id == id1 {
			mem.copy_non_overlapping(&r1, mem.ptr_offset(storage, offset), size_of(Type1))
		} else if id == id2 {
			mem.copy_non_overlapping(&r2, mem.ptr_offset(storage, offset), size_of(Type2))
		} else if id == id3 {
			mem.copy_non_overlapping(&r3, mem.ptr_offset(storage, offset), size_of(Type3))
		} else if id == id4 {
			mem.copy_non_overlapping(&r4, mem.ptr_offset(storage, offset), size_of(Type4))
		} else if id == id5 {
			mem.copy_non_overlapping(&r5, mem.ptr_offset(storage, offset), size_of(Type5))
		} else if id == id6 {
			mem.copy_non_overlapping(&r6, mem.ptr_offset(storage, offset), size_of(Type6))
		} else if id == id7 {
			mem.copy_non_overlapping(&r7, mem.ptr_offset(storage, offset), size_of(Type7))
		} else if id == id8 {
			mem.copy_non_overlapping(&r8, mem.ptr_offset(storage, offset), size_of(Type8))
		} else if id == id9 {
			mem.copy_non_overlapping(&r9, mem.ptr_offset(storage, offset), size_of(Type9))
		} else if id == id10 {
			mem.copy_non_overlapping(&r10, mem.ptr_offset(storage, offset), size_of(Type10))
		} else if id == id11 {
			mem.copy_non_overlapping(&r11, mem.ptr_offset(storage, offset), size_of(Type11))
		} else if id == id12 {
			mem.copy_non_overlapping(&r12, mem.ptr_offset(storage, offset), size_of(Type12))
		} else if id == id13 {
			mem.copy_non_overlapping(&r13, mem.ptr_offset(storage, offset), size_of(Type13))
		}
	}

	return r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13
}
