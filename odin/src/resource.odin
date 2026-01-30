package moecs

import "core:slice"

/* Resource element type description. */
@(private="package")
Resource :: struct {
	/* Type id of the resource type. */
	type : typeid,
	/* Index of the resource. */
	idx : int,
	/* Type size for allocations. */
	size : int,
	/* Resource offset (position) in the storage. */
	offset : int
}

/* Registered resource types collection for each world. */
@(private="package")
Resources :: struct {
	/* Registered ids of resource types converted from typeids. */
	ids : [MAX_RESOURCES_COUNT]u64,
	/* Instances of concrete resource type. */
	types : [MAX_RESOURCES_COUNT]Resource,
	/* Resource types count (last index + 1). */
	count : int,
	/* Total size in bytes of all resources. */
	size : int,
	/* Resources storage in the memory. */
	storage : rawptr
}

/* Gets index of resource type.
   `resources` : Resource types collection.
   `type`      : Resource type. */
@(private="package")
resource_index :: #force_inline proc(resources: ^Resources, type: typeid) -> (int, bool) #optional_ok {
	id: u64 = transmute(u64)type

	for i := 0; i < resources.count; i += 1 {
		if resources.ids[i] == id do return i, true
	}

	return -1, false
}

/* Adds new resource type into collection.
   `resources` : Resource types collection.
   `type`      : Resource type.
   `resource`  : Instance of the resource type. */
@(private="package")
resources_add :: proc(resources: ^Resources, type: typeid, resource: Resource) {
	if resources_has(resources, type) do panic("Resource already registered.")
	if resources.count == MAX_RESOURCES_COUNT do panic("The maximum count of resources has been reached.")

	resources.ids[resources.count] = transmute(u64)type
	resources.types[resources.count] = resource
	resources.size += resource.size

	resources.count += 1
}

/* Gets reference to the resource type.
   `resources` : Resource types collection.
   `type`      : Resource type. */
@(private="package")
resources_get :: #force_inline proc(resources: ^Resources, type: typeid) -> (^Resource, bool) #optional_ok {
	if idx, ok := resource_index(resources, type); ok {
		return &resources.types[idx], true
	} else {
		return nil, false
	}
} 

/* Checks if the collection has specified resource type.
   `resources` : Resource types collection.
   `type`      : Resource type.
   `returns`   : True if type was found, otherwise - false. */
@(private="package")
resources_has :: #force_inline proc(resources: ^Resources, type: typeid) -> bool {
	_, ok := resource_index(resources, type)
	return ok
}

/* Adjust resource types for efficient access, sort, calculate offsets.
   `resources` : Resource types collection. */
@(private="package")
resources_adjust :: proc(resources: ^Resources) {
	types: []Resource = slice.clone(resources.types[:resources.count])

	slice.sort(resources.ids[:resources.count])

	for resource in types {
		idx := resource_index(resources, resource.type)
		resources.types[idx] = resource
		resources.types[idx].idx = idx
	}

	resources.types[0].offset = 0

	for i in 1..<resources.count {
		resources.types[i].offset = resources.types[i - 1].offset + resources.types[i - 1].size
	}
}
