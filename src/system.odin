package moecs

/* System type. */
System :: struct {
	/* Name of the system. It must be unique. Used for getting the system from the world. */
	name : string,
	/* System state. Uses:
	   ENABLED:        If system is enabled it will run in each step of the world progress,
	                   disable it to pause execution for some reason.
	   HAS_TAGS:       Query tags has been registered. For optimization if wasn't.
	   HAS_COMPONENTS: Query components has been registered. For optimization if wasn't.
	   HAS_WITHOUT_TAGS:       Query excluding tags has been registered. For optimization if wasn't.
	   HAS_WITHOUT_COMPONENTS: Query excluding components has been registered. For optimization if wasn't. */
	state : bit_set[ElementState; u16],
	/* Components marker, each set bit specifies component in the system match query. */
	components : [COMPONENTS_MARKER_SIZE]uint,
	/* Tags marker, each set bit specifies tag in the system match query. */
	tags : [TAGS_MARKER_SIZE]uint,
	/* Excluding components marker, each set bit specifies component in the system match query. */
	without_components : [COMPONENTS_MARKER_SIZE]uint,
	/* Excluding tags marker, each set bit specifies tag in the system match query. */
	without_tags : [TAGS_MARKER_SIZE]uint,
	/* System running phase, order in the pipeline. By default equals UPDATE. */
	phase : Phase,
	/* Entities lifetime flag to optimize queries and do not process lifetimes
	   that you want to avoid for current system. Not used in ARCHETYPE approach. */
	lifetime : bit_set[Lifetime; u8],
	/* Matched entities list (query result) for current system run. Not used in ARCHETYPE approach. */
	entities : [dynamic]^Entity,
	/* Callback function that will be invoked each step of the world progress.
	   Disable system to pause invokation. */
	callback : SystemCallback
}

/* Checks if the system is enabled.
   `system`  : Pointer to the system.
   `returns` : True if system is enabled, otherwise - false. */
@(private="package")
system_enabled :: #force_inline proc(system: ^System) -> bool {
	return .ENABLED in system.state
}

/* Enables the system.
   `system` : Pointer to the system. */
@(private="package")
enable_system :: #force_inline proc(system: ^System) {
	system.state += { .ENABLED }
}

/* Disables the system.
   `system` : Pointer to the system. */
@(private="package")
disable_system :: #force_inline proc(system: ^System) {
	system.state -= { .ENABLED }
}

/* Checks if the system is a task.
   `system`  : Pointer to the system.
   `returns` : True if system is a task, otherwise - false. */
@(private="package")
is_task :: #force_inline proc(system: ^System) -> bool {
	return .IS_TASK in system.state
}

/* Free all system resources.
   `system` : Pointer to the system. */
@(private="package")
free_system :: #force_inline proc(system: ^System) {
	delete(system.entities)
}
