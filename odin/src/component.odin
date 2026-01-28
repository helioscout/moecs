package moecs

import "core:slice"

/* Component elment type description. */
@(private="package")
Component :: struct {
	/* Type id of the component type. */
	type : typeid,
	/* Index of the component in the bitset (entity's components marker). */
	idx : int,
	/* Type size for allocations. */
	size : int,
	/* Component offset (position) in the storage. */
	offset : int
}

/* Registered component types collection for each world. */
@(private="package")
Components :: struct {
	/* Registered ids of component types converted from typeids.
	   Index in this array will be index in the merker (bitset)
	   and the index of component's chunk in the block. */
	ids : [MAX_COMPONENTS_COUNT]u64,
	/* Instances of concrete component type. */
	types : [MAX_COMPONENTS_COUNT]Component,
	/* Component types count (last index + 1). */
	count : int,
	/* Total size in bytes of all components. */
	size : int
}

/* Gets index of component type.
   `components` : Component types collection.
   `type`       : Component type. */
@(private="package")
component_index :: proc(components: ^Components, type: typeid) -> (int, bool) #optional_ok {
	id: u64 = transmute(u64)type

	for i := 0; i < components.count; i += 1 {
		if components.ids[i] == id do return i, true
	}

	return -1, false
}

/* Adds new component type into collection.
   `components` : Component types collection.
   `type`       : Component type.
   `component`  : Instance of the component type. */
@(private="package")
components_add :: proc(components: ^Components, type: typeid, component: Component) {
	if components_has(components, type) do panic("Component already registered.")
	if components.count == MAX_COMPONENTS_COUNT do panic("The maximum count of components has been reached.")

	components.ids[components.count] = transmute(u64)type
	components.types[components.count] = component
	components.size += component.size

	components.count += 1
}

/* Gets reference to the component type.
   `components` : Component types collection.
   `type`       : Component type. */
@(private="package")
components_get :: proc(components: ^Components, type: typeid) -> (^Component, bool) #optional_ok {
	if idx, ok := component_index(components, type); ok {
		return &components.types[idx], true
	} else {
		return nil, false
	}
} 

/* Checks if the collection has specified component type.
   `components` : Component types collection.
   `type`       : Component type.
   `returns`    : True if type was found, otherwise - false. */
@(private="package")
components_has :: proc(components: ^Components, type: typeid) -> bool {
	_, ok := component_index(components, type)
	return ok
}

/* Adjust component types for efficient access, sort, calculate offsets.
   `components` : Component types collection. */
@(private="package")
components_adjust :: proc(components: ^Components) {
	types: []Component = slice.clone(components.types[:components.count])

	slice.sort(components.ids[:components.count])

	for component in types {
		idx := component_index(components, component.type)
		components.types[idx] = component
		components.types[idx].idx = idx
	}

	components.types[0].offset = 0

	for i in 1..<components.count {
		components.types[i].offset = components.types[i - 1].offset + components.types[i - 1].size
	}
}
