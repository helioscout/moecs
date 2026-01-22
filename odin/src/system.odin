package moecs

/* System type. */
System :: struct {
	/* Name of the system. It must be unique. Used for getting the system from the world. */
	name : string,
	/* System state. Uses:
	   ENABLED:        If system is enabled it will run in each step of the world progress,
	                   disable it to pause execution for some reason.
	   HAS_TAGS:       Query tags has been registered. For optimization if wasn't.
	   HAS_COMPONENTS: Query component has been registered. For optimization if wasn't. */
	state : bit_set[ElementState; u8],
	/* Components marker, each set bit specifies component in the system match query. */
	components : [COMPONENTS_MARKER_SIZE]uint,
	/* Tags marker, each set bit specifies tag in the system match query. */
	tags : [TAGS_MARKER_SIZE]uint,
	/* Entities lifetime flag to optimize queries and do not process lifetimes
	   that you want to avoid for current system. Not used in ARCHETYPE approach. */
	lifetime : bit_set[Lifetime; u8],
	/* Matched entities list (query result) for current system run. Not used in ARCHETYPE approach. */
	entities : [dynamic]^Entity,
	/* Callback function that will be invoked each step of the world progress.
	   Disable system to pause invokation. */
	callback : SystemCallback
}

/* System definition, for mounting. */
SystemDefinition :: struct {
	/* Name of the system. It must be unique. Used for getting the system from the world. */
	name : string,
	/* Components list that should match while the system query. */
	components : []typeid,
	/* Tags list that should match while the system query. */
	tags : []typeid,
	/* Entities lifetime flag to optimize queries and do not process lifetimes
	   that you want to avoid for current system. */
	lifetime : bit_set[Lifetime; u8],
	/* Callback function that will be invoked each step of the world progress. */
	callback : SystemCallback
}

/* Checks if the system is enabled.
   `system`  : Pointer to the system.
   `returns` : True if system is enabled, otherwise - false. */
enabled :: #force_inline proc(system: ^System) -> bool {
	return .ENABLED in system.state
}

/* Enables the system.
   `system` : Pointer to the system. */
enable :: #force_inline proc(system: ^System) {
	system.state += { .ENABLED }
}

/* Disables the system.
   `system` : Pointer to the system. */
disable :: #force_inline proc(system: ^System) {
	system.state -= { .ENABLED }
}
