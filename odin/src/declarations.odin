package moecs

/* Size (items count) of the one components chunk or entities collection for each block. */
/* Quick lifetime chunk size. */
QUICK_CHUNK_SIZE   : uint : 100
/* Dynamic lifetime chunk size. */
DYNAMIC_CHUNK_SIZE : uint : 500
/* Static lifetime chunk size. */
STATIC_CHUNK_SIZE  : uint : 300

/* Maximum components count available for adding to entity. */
MAX_COMPONENTS_COUNT : uint : 128
/* Maximum tags count available for adding to entity. */
MAX_TAGS_COUNT       : uint : 128

/* Worlds collection in the space. */
Worlds :: []^World

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
