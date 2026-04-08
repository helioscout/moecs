package moecs

/* Observers set/unset state. */
@(private="package")
ObserversSetting :: struct {
	/* Entity spawned event is set/unset. */
	spawned : bool,
	/* Entity despawned event is set/unset. */
	despawned : bool,
	/* Marker for component added events set/unset state. */
	added : [COMPONENTS_MARKER_SIZE]uint,
	/* Marker for component removed events set/unset state. */
	removed : [COMPONENTS_MARKER_SIZE]uint,
	/* Marker for component value set/change events set/unset state. */
	set : [COMPONENTS_MARKER_SIZE]uint,
	/* Marker for tag added events set/unset state. */
	tagged : [TAGS_MARKER_SIZE]uint,
	/* Marker for tag removed events set/unset state. */
	untagged : [TAGS_MARKER_SIZE]uint
}

/* Observers turned on/off state. */
@(private="package")
ObserversTurning :: struct {
	/* Entity spawned event turned on/off. */
	spawned : bool,
	/* Entity despawned event turned on/off. */
	despawned : bool,
	/* Marker for component added events turned on/off. */
	added : [COMPONENTS_MARKER_SIZE]uint,
	/* Marker for component removed events turned on/off. */
	removed : [COMPONENTS_MARKER_SIZE]uint,
	/* Marker for component value set/change events turned on/off. */
	set : [COMPONENTS_MARKER_SIZE]uint,
	/* Marker for tag added events turned on/off. */
	tagged : [TAGS_MARKER_SIZE]uint,
	/* Marker for tag removed events turned on/off. */
	untagged : [TAGS_MARKER_SIZE]uint,
	/* Added event turned on/off. */
	added_event: bool,
	/* Removed event turned on/off. */
	removed_event: bool,
	/* Set event turned on/off. */
	set_event: bool,
	/* Tagged event turned on/off. */
	tagged_event: bool,
	/* Untagged event turned on/off. */
	untagged_event: bool
}

/* Events observers. */
@(private="package")
Observers :: struct {
	/* Callback for entity spawned event. */
	spawned : ObserverCallback,
	/* Callback for entity despawned event. */
	despawned : ObserverCallback,
	/* Callbacks for component added events. */
	added : [MAX_COMPONENTS_COUNT]ObserverCallback,
	/* Callbacks for component removed events. */
	removed : [MAX_COMPONENTS_COUNT]ObserverCallback,
	/* Callbacks for component value set/change events. */
	set : [MAX_COMPONENTS_COUNT]ObserverCallback,
	/* Callbacks for tag added (entity tagged) events. */
	tagged : [MAX_TAGS_COUNT]ObserverCallback,
	/* Callbacks for tag removed (entity untagged) events. */
	untagged : [MAX_TAGS_COUNT]ObserverCallback,
	/* Observers set/unset states. */
	setting : ObserversSetting,
	/* Observers turned on/off states. */
	turning : ObserversTurning
}

/* Throws spawned event (callback) if it was set and turned on.
   `world`  : Pointer to the wortld.
   `entity` : Pointer to the spawned entity. */
@(private="package")
spawned_event :: #force_inline proc(world: ^World, entity: ^Entity) {
	if world.observers.setting.spawned && world.observers.turning.spawned {
		world.observers.spawned(world, entity, .SPAWNED, nil, nil)
	}
}

/* Throws despawned event (callback) if it was set and turned on.
   `world`  : Pointer to the wortld.
   `entity` : Pointer to the spawned entity. */
@(private="package")
despawned_event :: #force_inline proc(world: ^World, entity: ^Entity) {
	if world.observers.setting.despawned && world.observers.turning.despawned {
		world.observers.despawned(world, entity, .DESPAWNED, nil, nil)
	}
}

/* Throws added event (callback) if it was set and turned on.
   `world`     : Pointer to the world.
   `entity`    : Pointer to the entity.
   `type`      : Component type.
   `idx`       : Index of the component in the bitset.
   `component` : Pointer to the component instance which was added. */
@(private="package")
added_event :: #force_inline proc(world: ^World, entity: ^Entity, type: typeid, idx: int,
	component: rawptr) #no_bounds_check {
	if marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.setting.added, idx) &&
	   marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.turning.added, idx) &&
	   world.observers.turning.added_event {
		world.observers.added[idx](world, entity, .ADDED, type, component)
	}
}

/* Throws removed event (callback) if it was set and turned on.
   `world`     : Pointer to the world.
   `entity`    : Pointer to the entity.
   `type`      : Component type.
   `idx`       : Index of the component in the bitset.
   `component` : Pointer to the component instance which was removed. */
@(private="package")
removed_event :: #force_inline proc(world: ^World, entity: ^Entity, type: typeid, idx: int,
	component: rawptr) #no_bounds_check {
	if marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.setting.removed, idx) &&
	   marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.turning.removed, idx) &&
	   world.observers.turning.removed_event {
		world.observers.removed[idx](world, entity, .REMOVED, type, component)
	}
}

/* Throws set event (callback) if it was set and turned on.
   `world`     : Pointer to the world.
   `entity`    : Pointer to the entity.
   `type`      : Component type.
   `idx`       : Index of the component in the bitset.
   `component` : Pointer to the component instance which was set. */
@(private="package")
set_event :: #force_inline proc(world: ^World, entity: ^Entity, type: typeid, idx: int,
	component: rawptr) #no_bounds_check {
	if marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.setting.set, idx) &&
	   marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.turning.set, idx) &&
	   world.observers.turning.set_event {
		world.observers.set[idx](world, entity, .SET, type, component)
	}
}

/* Throws tagged event (callback) if it was set and turned on.
   `world`     : Pointer to the world.
   `entity`    : Pointer to the entity.
   `type`      : Tag type.
   `idx`       : Index of the tag in the bitset. */
@(private="package")
tagged_event :: #force_inline proc(world: ^World, entity: ^Entity, type: typeid, idx: int) #no_bounds_check {
	if marker_is_set(TAGS_MARKER_SIZE, world.observers.setting.tagged, idx) &&
	   marker_is_set(TAGS_MARKER_SIZE, world.observers.turning.tagged, idx) &&
	   world.observers.turning.tagged_event {
		world.observers.tagged[idx](world, entity, .TAGGED, type, nil)
	}
}

/* Throws untagged event (callback) if it was set and turned on.
   `world`     : Pointer to the world.
   `entity`    : Pointer to the entity.
   `type`      : Tag type.
   `idx`       : Index of the tag in the bitset. */
@(private="package")
untagged_event :: #force_inline proc(world: ^World, entity: ^Entity, type: typeid, idx: int) #no_bounds_check {
	if marker_is_set(TAGS_MARKER_SIZE, world.observers.setting.untagged, idx) &&
	   marker_is_set(TAGS_MARKER_SIZE, world.observers.turning.untagged, idx) &&
	   world.observers.turning.untagged_event {
		world.observers.untagged[idx](world, entity, .UNTAGGED, type, nil)
	}
}

/* Turn on all observers for specific event.
   `world` : Pointer to the world.
   `event` : Event type. */
@(private="package")
turn_on_event :: proc(world: ^World, event: Event) {
	switch event {
		case .SPAWNED:   world.observers.turning.spawned = true
		case .DESPAWNED: world.observers.turning.despawned = true
		case .ADDED:     world.observers.turning.added_event = true
		case .REMOVED:   world.observers.turning.removed_event = true
		case .SET:       world.observers.turning.set_event = true
		case .TAGGED:    world.observers.turning.tagged_event = true
		case .UNTAGGED:  world.observers.turning.untagged_event = true
	}
}

/* Turn on observer for specific event and type.
   `world` : Pointer to the world.
   `event` : Event type.
   `type`  : Event target component/tag type. */
@(private="package")
turn_on_for_type :: proc(world: ^World, event: Event, type: typeid) {
	#partial switch event {
		case .ADDED:
			if idx, ok := component_index(&world.components, type); ok {
				marker_set(COMPONENTS_MARKER_SIZE, &world.observers.turning.added, idx)
			}

		case .REMOVED:
			if idx, ok := component_index(&world.components, type); ok {
				marker_set(COMPONENTS_MARKER_SIZE, &world.observers.turning.removed, idx)
			}

		case .SET:
			if idx, ok := component_index(&world.components, type); ok {
				marker_set(COMPONENTS_MARKER_SIZE, &world.observers.turning.set, idx)
			}

		case .TAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				marker_set(TAGS_MARKER_SIZE, &world.observers.turning.tagged, idx)
			}
			
		case .UNTAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				marker_set(TAGS_MARKER_SIZE, &world.observers.turning.untagged, idx)
			}
	}
}

/* Turn off all observers for specific event.
   `world` : Pointer to the world.
   `event` : Event type. */
@(private="package")
turn_off_event :: proc(world: ^World, event: Event) {
	switch event {
		case .SPAWNED:   world.observers.turning.spawned = false
		case .DESPAWNED: world.observers.turning.despawned = false
		case .ADDED:     world.observers.turning.added_event = false
		case .REMOVED:   world.observers.turning.removed_event = false
		case .SET:       world.observers.turning.set_event = false
		case .TAGGED:    world.observers.turning.tagged_event = false
		case .UNTAGGED:  world.observers.turning.untagged_event = false
	}
}

/* Turn off observer for specific event and type.
   `world` : Pointer to the world.
   `event` : Event type.
   `type`  : Event target component/tag type. */
@(private="package")
turn_off_for_type :: proc(world: ^World, event: Event, type: typeid) {
	#partial switch event {
		case .ADDED:
			if idx, ok := component_index(&world.components, type); ok {
				marker_unset(COMPONENTS_MARKER_SIZE, &world.observers.turning.added, idx)
			}

		case .REMOVED:
			if idx, ok := component_index(&world.components, type); ok {
				marker_unset(COMPONENTS_MARKER_SIZE, &world.observers.turning.removed, idx)
			}

		case .SET:
			if idx, ok := component_index(&world.components, type); ok {
				marker_unset(COMPONENTS_MARKER_SIZE, &world.observers.turning.set, idx)
			}

		case .TAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				marker_unset(TAGS_MARKER_SIZE, &world.observers.turning.tagged, idx)
			}
			
		case .UNTAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				marker_unset(TAGS_MARKER_SIZE, &world.observers.turning.untagged, idx)
			}
	}
}

/* Checks if all observers for specific event are turned on.
   `world` : Pointer to the world.
   `event` : Event type. */
@(private="package")
turned_on_event :: proc(world: ^World, event: Event) -> bool {
	switch event {
		case .SPAWNED:   return world.observers.turning.spawned
		case .DESPAWNED: return world.observers.turning.despawned
		case .ADDED:     return world.observers.turning.added_event
		case .REMOVED:   return world.observers.turning.removed_event
		case .SET:       return world.observers.turning.set_event
		case .TAGGED:    return world.observers.turning.tagged_event
		case .UNTAGGED:  return world.observers.turning.untagged_event
	}

	return false
}

/* Checks if the observer for specific event and type is turned on.
   `world` : Pointer to the world.
   `event` : Event type.
   `type`  : Event target component/tag type. */
@(private="package")
turned_on_for_type :: proc(world: ^World, event: Event, type: typeid) -> bool {
	#partial switch event {
		case .ADDED:
			if idx, ok := component_index(&world.components, type); ok {
				return marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.turning.added, idx)
			}

		case .REMOVED:
			if idx, ok := component_index(&world.components, type); ok {
				return marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.turning.removed, idx)
			}

		case .SET:
			if idx, ok := component_index(&world.components, type); ok {
				return marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.turning.set, idx)
			}

		case .TAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				return marker_is_set(TAGS_MARKER_SIZE, world.observers.turning.tagged, idx)
			}
			
		case .UNTAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				return marker_is_set(TAGS_MARKER_SIZE, world.observers.turning.untagged, idx)
			}
	}

	return false
}

/* Checks if observer is set for specific event.
   `world` : Pointer to the world.
   `event` : Event type. */
@(private="package")
observable_event :: proc(world: ^World, event: Event) -> bool {
	#partial switch event {
		case .SPAWNED:   return world.observers.setting.spawned
		case .DESPAWNED: return world.observers.setting.despawned
	}

	panic("Use procedure with type parameter for this event type.")
}

/* Checks if observer is set for specific event and type.
   `world` : Pointer to the world.
   `event` : Event type.
   `type`  : Event target component/tag type. */
@(private="package")
observable_for_type :: proc(world: ^World, event: Event, type: typeid) -> bool {
	#partial switch event {
		case .ADDED:
			if idx, ok := component_index(&world.components, type); ok {
				return marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.setting.added, idx)
			}

		case .REMOVED:
			if idx, ok := component_index(&world.components, type); ok {
				return marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.setting.removed, idx)
			}

		case .SET:
			if idx, ok := component_index(&world.components, type); ok {
				return marker_is_set(COMPONENTS_MARKER_SIZE, world.observers.setting.set, idx)
			}

		case .TAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				return marker_is_set(TAGS_MARKER_SIZE, world.observers.setting.tagged, idx)
			}
			
		case .UNTAGGED:
			if idx, ok := tag_index(&world.tags, type); ok {
				return marker_is_set(TAGS_MARKER_SIZE, world.observers.setting.untagged, idx)
			}
	}

	return false
}
