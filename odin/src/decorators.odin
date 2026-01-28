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

/* Adds 14 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_14_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14) {
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
	add_component(entity, Type14, component14, false)

	archetyping(entity)
}

/* Adds 15 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_15_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)

	archetyping(entity)
}

/* Adds 16 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_16_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)
	add_component(entity, Type16, component16, false)

	archetyping(entity)
}

/* Adds 17 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_17_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)
	add_component(entity, Type16, component16, false)
	add_component(entity, Type17, component17, false)

	archetyping(entity)
}

/* Adds 18 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_18_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)
	add_component(entity, Type16, component16, false)
	add_component(entity, Type17, component17, false)
	add_component(entity, Type18, component18, false)

	archetyping(entity)
}

/* Adds 19 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_19_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18,
	$Type19: typeid, component19: ^Type19) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)
	add_component(entity, Type16, component16, false)
	add_component(entity, Type17, component17, false)
	add_component(entity, Type18, component18, false)
	add_component(entity, Type19, component19, false)

	archetyping(entity)
}

/* Adds 20 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_20_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18,
	$Type19: typeid, component19: ^Type19, $Type20: typeid, component20: ^Type20) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)
	add_component(entity, Type16, component16, false)
	add_component(entity, Type17, component17, false)
	add_component(entity, Type18, component18, false)
	add_component(entity, Type19, component19, false)
	add_component(entity, Type20, component20, false)

	archetyping(entity)
}

/* Adds 21 components to the entity by type and instance (initializer).
   If entity already has a component it will be replaced by new one.
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance. */
add_21_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18,
	$Type19: typeid, component19: ^Type19, $Type20: typeid, component20: ^Type20,
	$Type21: typeid, component21: ^Type21) {
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
	add_component(entity, Type14, component14, false)
	add_component(entity, Type15, component15, false)
	add_component(entity, Type16, component16, false)
	add_component(entity, Type17, component17, false)
	add_component(entity, Type18, component18, false)
	add_component(entity, Type19, component19, false)
	add_component(entity, Type20, component20, false)
	add_component(entity, Type21, component21, false)

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
	set_component(entity, Type1, component1)
	set_component(entity, Type2, component2)
	set_component(entity, Type3, component3)
	set_component(entity, Type4, component4)
	set_component(entity, Type5, component5)
	set_component(entity, Type6, component6)
	set_component(entity, Type7, component7)
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

/* Sets 14 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_14_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14) {
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
	set_component(entity, Type14, component14)
}

/* Sets 15 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_15_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
}

/* Sets 16 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_16_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
	set_component(entity, Type16, component16)
}

/* Sets 17 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_17_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
	set_component(entity, Type16, component16)
	set_component(entity, Type17, component17)
}

/* Sets 18 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_18_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
	set_component(entity, Type16, component16)
	set_component(entity, Type17, component17)
	set_component(entity, Type18, component18)
}

/* Sets 19 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_19_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18,
	$Type19: typeid, component19: ^Type19) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
	set_component(entity, Type16, component16)
	set_component(entity, Type17, component17)
	set_component(entity, Type18, component18)
	set_component(entity, Type19, component19)
}

/* Sets 20 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_20_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18,
	$Type19: typeid, component19: ^Type19, $Type20: typeid, component20: ^Type20) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
	set_component(entity, Type16, component16)
	set_component(entity, Type17, component17)
	set_component(entity, Type18, component18)
	set_component(entity, Type19, component19)
	set_component(entity, Type20, component20)
}

/* Sets 21 components values in the entity by their types and instances (initializers).
   `entity`     : Pointer to the entity.
   `$TypeN`     : N-th component type.
   `componentN` : Reference to the N-th component instance." */
set_21_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, component1: ^Type1, $Type2: typeid, component2: ^Type2,
	$Type3: typeid, component3: ^Type3, $Type4: typeid, component4: ^Type4,
	$Type5: typeid, component5: ^Type5, $Type6: typeid, component6: ^Type6,
	$Type7: typeid, component7: ^Type7, $Type8: typeid, component8: ^Type8,
	$Type9: typeid, component9: ^Type9, $Type10: typeid, component10: ^Type10,
	$Type11: typeid, component11: ^Type11, $Type12: typeid, component12: ^Type12,
	$Type13: typeid, component13: ^Type13, $Type14: typeid, component14: ^Type14,
	$Type15: typeid, component15: ^Type15, $Type16: typeid, component16: ^Type16,
	$Type17: typeid, component17: ^Type17, $Type18: typeid, component18: ^Type18,
	$Type19: typeid, component19: ^Type19, $Type20: typeid, component20: ^Type20,
	$Type21: typeid, component21: ^Type21) {
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
	set_component(entity, Type14, component14)
	set_component(entity, Type15, component15)
	set_component(entity, Type16, component16)
	set_component(entity, Type17, component17)
	set_component(entity, Type18, component18)
	set_component(entity, Type19, component19)
	set_component(entity, Type20, component20)
	set_component(entity, Type21, component21)
}

/* Sets 2 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_2_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
}

/* Sets 3 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_3_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
}

/* Sets 4 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_4_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
}

/* Sets 5 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_5_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5) {
	set_resource(world, Type1, resource1)
	set_resource(world, Type2, resource2)
	set_resource(world, Type3, resource3)
	set_resource(world, Type4, resource4)
	set_resource(world, Type5, resource5)
}

/* Sets 6 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_6_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_7_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_8_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_9_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_10_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_11_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_12_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12) {
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
   `resourceN` : N-th resource value (will be copied into storage). */
set_13_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13) {
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

/* Sets 14 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_14_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14) {
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
	set_resource(world, Type14, resource14)
}

/* Sets 15 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_15_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
}

/* Sets 16 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_16_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15, $Type16: typeid, resource16: Type16) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
	set_resource(world, Type16, resource16)
}

/* Sets 17 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_17_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15, $Type16: typeid, resource16: Type16,
	$Type17: typeid, resource17: Type17) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
	set_resource(world, Type16, resource16)
}

/* Sets 18 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_18_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15, $Type16: typeid, resource16: Type16,
	$Type17: typeid, resource17: Type17, $Type18: typeid, resource18: Type18) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
	set_resource(world, Type16, resource16)
	set_resource(world, Type17, resource17)
	set_resource(world, Type18, resource18)
}

/* Sets 19 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_19_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15, $Type16: typeid, resource16: Type16,
	$Type17: typeid, resource17: Type17, $Type18: typeid, resource18: Type18,
	$Type19: typeid, resource19: Type19) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
	set_resource(world, Type16, resource16)
	set_resource(world, Type17, resource17)
	set_resource(world, Type18, resource18)
	set_resource(world, Type19, resource19)
}

/* Sets 20 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_20_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15, $Type16: typeid, resource16: Type16,
	$Type17: typeid, resource17: Type17, $Type18: typeid, resource18: Type18,
	$Type19: typeid, resource19: Type19, $Type20: typeid, resource20: Type20) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
	set_resource(world, Type16, resource16)
	set_resource(world, Type17, resource17)
	set_resource(world, Type18, resource18)
	set_resource(world, Type19, resource19)
	set_resource(world, Type20, resource20)
}

/* Sets 21 resources values by their types.
   `world`     : Pointer to the world.
   `$TypeN`    : N-th resource type.
   `resourceN` : N-th resource value (will be copied into storage). */
set_21_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, resource1: Type1, $Type2: typeid, resource2: Type2,
	$Type3: typeid, resource3: Type3, $Type4: typeid, resource4: Type4,
	$Type5: typeid, resource5: Type5, $Type6: typeid, resource6: Type6,
	$Type7: typeid, resource7: Type7, $Type8: typeid, resource8: Type8,
	$Type9: typeid, resource9: Type9, $Type10: typeid, resource10: Type10,
	$Type11: typeid, resource11: Type11, $Type12: typeid, resource12: Type12,
	$Type13: typeid, resource13: Type13, $Type14: typeid, resource14: Type14,
	$Type15: typeid, resource15: Type15, $Type16: typeid, resource16: Type16,
	$Type17: typeid, resource17: Type17, $Type18: typeid, resource18: Type18,
	$Type19: typeid, resource19: Type19, $Type20: typeid, resource20: Type20,
	$Type21: typeid, resource21: Type21) {
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
	set_resource(world, Type14, resource14)
	set_resource(world, Type15, resource15)
	set_resource(world, Type16, resource16)
	set_resource(world, Type17, resource17)
	set_resource(world, Type18, resource18)
	set_resource(world, Type19, resource19)
	set_resource(world, Type20, resource20)
	set_resource(world, Type21, resource21)
}

/* Gets 2 references to the 2 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_2_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid) ->
	(c1: ^Type1, c2: ^Type2) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	return
}

/* Gets 3 references to the 3 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_3_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}

	return
}

/* Gets 4 references to the 4 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_4_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}

	return
}

/* Gets 5 references to the 5 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_5_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 6 references to the 6 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_6_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 7 references to the 7 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_7_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 8 references to the 8 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_8_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c8 = mem.ptr_offset(cast(^Type8)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 9 references to the 9 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_9_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

	id1: u64 = transmute(u64)typeid_of(Type1)
	id2: u64 = transmute(u64)typeid_of(Type2)
	id3: u64 = transmute(u64)typeid_of(Type3)
	id4: u64 = transmute(u64)typeid_of(Type4)
	id5: u64 = transmute(u64)typeid_of(Type5)
	id6: u64 = transmute(u64)typeid_of(Type6)
	id7: u64 = transmute(u64)typeid_of(Type7)
	id8: u64 = transmute(u64)typeid_of(Type8)
	id9: u64 = transmute(u64)typeid_of(Type9)

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c8 = mem.ptr_offset(cast(^Type8)ptr, entity.chunk_idx)
			} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c9 = mem.ptr_offset(cast(^Type9)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 10 references to the 10 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_10_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

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

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c8 = mem.ptr_offset(cast(^Type8)ptr, entity.chunk_idx)
			} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c9 = mem.ptr_offset(cast(^Type9)ptr, entity.chunk_idx)
			} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c10 = mem.ptr_offset(cast(^Type10)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 11 references to the 11 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_11_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

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

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c8 = mem.ptr_offset(cast(^Type8)ptr, entity.chunk_idx)
			} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c9 = mem.ptr_offset(cast(^Type9)ptr, entity.chunk_idx)
			} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c10 = mem.ptr_offset(cast(^Type10)ptr, entity.chunk_idx)
			} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c11 = mem.ptr_offset(cast(^Type11)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 12 references to the 12 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_12_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

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

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c8 = mem.ptr_offset(cast(^Type8)ptr, entity.chunk_idx)
			} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c9 = mem.ptr_offset(cast(^Type9)ptr, entity.chunk_idx)
			} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c10 = mem.ptr_offset(cast(^Type10)ptr, entity.chunk_idx)
			} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c11 = mem.ptr_offset(cast(^Type11)ptr, entity.chunk_idx)
			} else if id == id12 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c12 = mem.ptr_offset(cast(^Type12)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 13 references to the 13 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_13_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13) #no_bounds_check {
	world: ^World = get_world(entity)
	buffered := .BUFFERED in entity.state

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

	if buffered || entity.block.lifetime == .QUICK {
		for i := 0; i < world.components.count; i += 1 {
			id := world.components.ids[i]
			ptr: rawptr = world.components.types[i].buffer if buffered else entity.block.chunks[i]

			if id == id1 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c1 = mem.ptr_offset(cast(^Type1)ptr, entity.chunk_idx)
			} else if id == id2 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c2 = mem.ptr_offset(cast(^Type2)ptr, entity.chunk_idx)
			} else if id == id3 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c3 = mem.ptr_offset(cast(^Type3)ptr, entity.chunk_idx)
			} else if id == id4 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c4 = mem.ptr_offset(cast(^Type4)ptr, entity.chunk_idx)
			} else if id == id5 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c5 = mem.ptr_offset(cast(^Type5)ptr, entity.chunk_idx)
			} else if id == id6 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c6 = mem.ptr_offset(cast(^Type6)ptr, entity.chunk_idx)
			} else if id == id7 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c7 = mem.ptr_offset(cast(^Type7)ptr, entity.chunk_idx)
			} else if id == id8 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c8 = mem.ptr_offset(cast(^Type8)ptr, entity.chunk_idx)
			} else if id == id9 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c9 = mem.ptr_offset(cast(^Type9)ptr, entity.chunk_idx)
			} else if id == id10 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c10 = mem.ptr_offset(cast(^Type10)ptr, entity.chunk_idx)
			} else if id == id11 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c11 = mem.ptr_offset(cast(^Type11)ptr, entity.chunk_idx)
			} else if id == id12 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c12 = mem.ptr_offset(cast(^Type12)ptr, entity.chunk_idx)
			} else if id == id13 && marker_is_set(COMPONENTS_MARKER_SIZE, entity.components, i) {
				c13 = mem.ptr_offset(cast(^Type13)ptr, entity.chunk_idx)
			}
		}
	} else {
		storage: ^u8 = cast(^u8)entity.block.storage
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
	}
	
	return
}

/* Gets 14 references to the 14 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_14_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	return
}

/* Gets 15 references to the 15 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_15_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	return
}

/* Gets 16 references to the 16 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_16_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15, c16: ^Type16) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	c16 = get_component(entity, Type16)
	return
}

/* Gets 17 references to the 17 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_17_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15, c16: ^Type16, c17: ^Type17) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	c16 = get_component(entity, Type16)
	c17 = get_component(entity, Type17)
	return
}

/* Gets 18 references to the 18 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_18_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15, c16: ^Type16, c17: ^Type17, c18: ^Type18) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	c16 = get_component(entity, Type16)
	c17 = get_component(entity, Type17)
	c18 = get_component(entity, Type18)
	return
}

/* Gets 19 references to the 19 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_19_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid,
	$Type19: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15, c16: ^Type16, c17: ^Type17, c18: ^Type18,
	c19: ^Type19) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	c16 = get_component(entity, Type16)
	c17 = get_component(entity, Type17)
	c18 = get_component(entity, Type18)
	c19 = get_component(entity, Type19)
	return
}

/* Gets 20 references to the 20 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_20_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid,
	$Type19: typeid, $Type20: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15, c16: ^Type16, c17: ^Type17, c18: ^Type18,
	c19: ^Type19, c20: ^Type20) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	c16 = get_component(entity, Type16)
	c17 = get_component(entity, Type17)
	c18 = get_component(entity, Type18)
	c19 = get_component(entity, Type19)
	c20 = get_component(entity, Type20)
	return
}

/* Gets 21 references to the 21 components values by their types.
   `entity`   : Pointer to the entity.
   `$TypeN`   : N-th component type. */
get_21_components :: #force_inline proc(entity: ^Entity,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid,
	$Type19: typeid, $Type20: typeid, $Type21: typeid) ->
	(c1: ^Type1, c2: ^Type2, c3: ^Type3, c4: ^Type4, c5: ^Type5, c6: ^Type6,
	c7: ^Type7, c8: ^Type8, c9: ^Type9, c10: ^Type10, c11: ^Type11, c12: ^Type12,
	c13: ^Type13, c14: ^Type14, c15: ^Type15, c16: ^Type16, c17: ^Type17, c18: ^Type18,
	c19: ^Type19, c20: ^Type20, c21: ^Type21) {
	c1 = get_component(entity, Type1)
	c2 = get_component(entity, Type2)
	c3 = get_component(entity, Type3)
	c4 = get_component(entity, Type4)
	c5 = get_component(entity, Type5)
	c6 = get_component(entity, Type6)
	c7 = get_component(entity, Type7)
	c8 = get_component(entity, Type8)
	c9 = get_component(entity, Type9)
	c10 = get_component(entity, Type10)
	c11 = get_component(entity, Type11)
	c12 = get_component(entity, Type12)
	c13 = get_component(entity, Type13)
	c14 = get_component(entity, Type14)
	c15 = get_component(entity, Type15)
	c16 = get_component(entity, Type16)
	c17 = get_component(entity, Type17)
	c18 = get_component(entity, Type18)
	c19 = get_component(entity, Type19)
	c20 = get_component(entity, Type20)
	c21 = get_component(entity, Type21)
	return
}

/* Gets 2 references to 2 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_2_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid) ->
	(r1: ^Type1, r2: ^Type2) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	return
}

/* Gets 3 references to 3 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_3_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	return
}

/* Gets 4 references to 4 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_4_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	return
}

/* Gets 5 references to 5 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_5_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	return
}

/* Gets 6 references to 6 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_6_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	return
}

/* Gets 7 references to 7 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_7_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	return
}

/* Gets 8 references to 8 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_8_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	return
}

/* Gets 9 references to 9 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_9_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	return
}

/* Gets 10 references to 10 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_10_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	return
}

/* Gets 11 references to 11 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_11_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	return
}

/* Gets 12 references to 12 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_12_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	return
}

/* Gets 13 references to 13 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_13_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	return
}

/* Gets 14 references to 14 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_14_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	return
}

/* Gets 15 references to 15 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_15_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	return
}

/* Gets 16 references to 16 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_16_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15, r16: ^Type16) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	r16 = get_resource(world, Type16)
	return
}

/* Gets 17 references to 17 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_17_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15, r16: ^Type16, r17: ^Type17) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	r16 = get_resource(world, Type16)
	r17 = get_resource(world, Type17)
	return
}

/* Gets 18 references to 18 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_18_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15, r16: ^Type16, r17: ^Type17, r18: ^Type18) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	r16 = get_resource(world, Type16)
	r17 = get_resource(world, Type17)
	r18 = get_resource(world, Type18)
	return
}

/* Gets 19 references to 19 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_19_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid,
	$Type19: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15, r16: ^Type16, r17: ^Type17, r18: ^Type18,
	r19: ^Type19) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	r16 = get_resource(world, Type16)
	r17 = get_resource(world, Type17)
	r18 = get_resource(world, Type18)
	r19 = get_resource(world, Type19)
	return
}

/* Gets 20 references to 20 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_20_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid,
	$Type19: typeid, $Type20: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15, r16: ^Type16, r17: ^Type17, r18: ^Type18,
	r19: ^Type19, r20: ^Type20) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	r16 = get_resource(world, Type16)
	r17 = get_resource(world, Type17)
	r18 = get_resource(world, Type18)
	r19 = get_resource(world, Type19)
	r20 = get_resource(world, Type20)
	return
}

/* Gets 21 references to 21 resource values by their types.
   `world`  : Pointer to the world.
   `$TypeN` : N-th resource type. */
get_21_resources :: #force_inline proc(world: ^World,
	$Type1: typeid, $Type2: typeid, $Type3: typeid, $Type4: typeid, $Type5: typeid, $Type6: typeid,
	$Type7: typeid, $Type8: typeid, $Type9: typeid, $Type10: typeid, $Type11: typeid, $Type12: typeid,
	$Type13: typeid, $Type14: typeid, $Type15: typeid, $Type16: typeid, $Type17: typeid, $Type18: typeid,
	$Type19: typeid, $Type20: typeid, $Type21: typeid) ->
	(r1: ^Type1, r2: ^Type2, r3: ^Type3, r4: ^Type4, r5: ^Type5, r6: ^Type6,
	r7: ^Type7, r8: ^Type8, r9: ^Type9, r10: ^Type10, r11: ^Type11, r12: ^Type12,
	r13: ^Type13, r14: ^Type14, r15: ^Type15, r16: ^Type16, r17: ^Type17, r18: ^Type18,
	r19: ^Type19, r20: ^Type20, r21: ^Type21) {
	r1 = get_resource(world, Type1)
	r2 = get_resource(world, Type2)
	r3 = get_resource(world, Type3)
	r4 = get_resource(world, Type4)
	r5 = get_resource(world, Type5)
	r6 = get_resource(world, Type6)
	r7 = get_resource(world, Type7)
	r8 = get_resource(world, Type8)
	r9 = get_resource(world, Type9)
	r10 = get_resource(world, Type10)
	r11 = get_resource(world, Type11)
	r12 = get_resource(world, Type12)
	r13 = get_resource(world, Type13)
	r14 = get_resource(world, Type14)
	r15 = get_resource(world, Type15)
	r16 = get_resource(world, Type16)
	r17 = get_resource(world, Type17)
	r18 = get_resource(world, Type18)
	r19 = get_resource(world, Type19)
	r20 = get_resource(world, Type20)
	r21 = get_resource(world, Type21)
	return
}
