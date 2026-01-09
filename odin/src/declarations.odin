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

/* Component chunks collection for each block, key by component struct type.
   Chunk is represented as an array of component struct values ($Type[(QUICK|DYNAMIC|STATIC)_CHUNK_SIZE]).
   But is created as a pointer to allocated memory block. */
Chunks :: map[typeid]rawptr

/* Registered components collection for each world. */
Components :: map[typeid]Component

/* Registered tags collection for each world. */
Tags :: map[typeid]Tag

/* Registered resources collection (with values) for each world. */
Resources :: map[typeid]Resource

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
ElementState :: enum{
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

set :: proc {
	set_component,
	set_resource
}

get :: proc {
	get_component,
	get_resource
}
