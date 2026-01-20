package moecs

/* Size (items count) of the one components chunk or entities collection for each block. */
/* Quick lifetime chunk size. */
QUICK_CHUNK_SIZE   : int : 100
/* Dynamic lifetime chunk size. */
DYNAMIC_CHUNK_SIZE : int : 500
/* Static lifetime chunk size. */
STATIC_CHUNK_SIZE  : int : 300

/* Maximum components count available for adding to entity. */
MAX_COMPONENTS_COUNT : int : 128
/* Maximum tags count available for adding to entity. */
MAX_TAGS_COUNT       : int : 128

/* Count of bits in one marker word (element of marker array). */
@(private) MARKER_BITS_COUNT : uint : size_of(uint) * 8
/* Size of components marker (array of bitset). */
@(private) COMPONENTS_MARKER_SIZE : uint : (uint(MAX_COMPONENTS_COUNT) + MARKER_BITS_COUNT - 1) / MARKER_BITS_COUNT
/* Size of tags marker (array of bitset). */
@(private) TAGS_MARKER_SIZE : uint : (uint(MAX_TAGS_COUNT) + MARKER_BITS_COUNT - 1) / MARKER_BITS_COUNT
/* Size of quick lifetime marker (array of bitset). */
@(private) QUICK_MARKER_SIZE : uint : (uint(QUICK_CHUNK_SIZE) + MARKER_BITS_COUNT - 1) / MARKER_BITS_COUNT

/* Component chunks collection for each block, key by component struct type.
   Chunk is represented as an array of component struct values ($Type[(QUICK|DYNAMIC|STATIC)_CHUNK_SIZE]).
   But is created as a pointer to allocated memory block. */
@(private) Chunks :: map[typeid]rawptr

/* Registered components collection for each world. */
@(private) Components :: map[typeid]Component

/* Registered tags collection for each world. */
@(private) Tags :: map[typeid]Tag

/* Registered resources collection (with values) for each world. */
@(private) Resources :: map[typeid]Resource

/* Entities/blocks lifetime. */
Lifetime :: enum u8 {
	/* Entities that exist for a very short period of time (a few dozen frames).
	   Such blocks will use occupied (used) marker bitset to define that block is free to insert.
	   Insertion should be performed as memory copy operation of whole chunk from static/stack memory,
	   buffers where chunks would be filled enough during entites (components) adding. */
	QUICK   = 0b00000001,
	/* Entities whose lifespan is not defined or determined in advance (from one frame to app exit).
	   Such blocks will reuse freed after deletion rows to insert new entities. */
	DYNAMIC = 0b00000010,
	/* Immortal entities that will exist until the end of the application.
	   Such blocks are simply created when necessary, since entities cannot be despawn. */
	STATIC  = 0b00000100
}

/* Kinds of elements that the world can consist of. */
Element :: enum {
	/* Component element type (Position, Mass, Velocity).
	   Must be defined as a struct or distinct custom type. */
	COMPONENT,
	/* Tag element type for marking entities with some kind of characteristic.
	   Must be defined as a typedef with a simple fundamental underlying type (typedef Tag = int). */
	TAG,
	/* Resource element type for storing data in the world that has only one instance, singleton.
	   Must be defined as a struct or typedef custom typs. */
	RESOURCE,
	/* System element type for running actions at each step of the world progress. */
	SYSTEM
}

/* The state flags for an element (entity or system). */
ElementState :: enum {
	/* Entity is stored in quick lifetime buffer. */
	BUFFERED,
	/* Entity has been deleted. */
	DELETED,
	/* System is enabled. */
	ENABLED,
	/* System has tags in the match query. */
	HAS_TAGS,
	/* System has components in the match query. */
	HAS_COMPONENTS
}

/* Entities iterator. */
@(private) EntitiesIterator :: struct {
	/* Current entity index. */
	idx : int,
	/* Current entity pointer. */
	entity : ^Entity
}

/* Callback procedure for entities iteration.
   `entity`   : Pointer to the current entity.
   `lifetime` : Current lifetime.
   `world`    : Pointer to the world. */
@(private) IteratorCallback :: proc(entity: ^Entity, lifetime: Lifetime, world: ^World)

/* Callback function for the system. */
SystemCallback :: proc(entities: []^Entity)

add :: proc {
	add_component,
	add_2_components,
	add_3_components,
	add_4_components,
	add_5_components,
	add_6_components,
	add_7_components,
	add_8_components,
	add_9_components,
	add_10_components,
	add_11_components,
	add_12_components,
	add_13_components,
	add_14_components,
	add_15_components,
	add_16_components,
	add_17_components,
	add_18_components,
	add_19_components,
	add_20_components,
	add_21_components
}

set :: proc {
	set_component,
	set_resource,
	set_2_components,
	set_3_components,
	set_4_components,
	set_5_components,
	set_6_components,
	set_7_components,
	set_8_components,
	set_9_components,
	set_10_components,
	set_11_components,
	set_12_components,
	set_13_components,
	set_14_components,
	set_15_components,
	set_16_components,
	set_17_components,
	set_18_components,
	set_19_components,
	set_20_components,
	set_21_components,
	set_2_resources,
	set_3_resources,
	set_4_resources,
	set_5_resources,
	set_6_resources,
	set_7_resources,
	set_8_resources,
	set_9_resources,
	set_10_resources,
	set_11_resources,
	set_12_resources,
	set_13_resources,
	set_14_resources,
	set_15_resources,
	set_16_resources,
	set_17_resources,
	set_18_resources,
	set_19_resources,
	set_20_resources,
	set_21_resources
}

get :: proc {
	get_component,
	get_resource,
	get_system,
	get_2_components,
	get_3_components,
	get_4_components,
	get_5_components,
	get_6_components,
	get_7_components,
	get_8_components,
	get_9_components,
	get_10_components,
	get_11_components,
	get_12_components,
	get_13_components,
	get_14_components,
	get_15_components,
	get_16_components,
	get_17_components,
	get_18_components,
	get_19_components,
	get_20_components,
	get_21_components,
	get_2_resources,
	get_3_resources,
	get_4_resources,
	get_5_resources,
	get_6_resources,
	get_7_resources,
	get_8_resources,
	get_9_resources,
	get_10_resources,
	get_11_resources,
	get_12_resources,
	get_13_resources,
	get_14_resources,
	get_15_resources,
	get_16_resources,
	get_17_resources,
	get_18_resources,
	get_19_resources,
	get_20_resources,
	get_21_resources
}

remove :: proc {
	remove_component,
	remove_components
}

has :: proc {
	has_component,
	has_components,
	has_system
}

tag :: proc {
	set_tag,
	set_tags
}

untag :: proc {
	unset_tag,
	unset_tags
}

tagged :: proc {
	has_tag,
	has_tags
}

despawn :: proc {
	despawn_entity,
	despawn_entities
}
