module moecs;

import std::collections::map;
import std::collections::list;
import std::collections::bitset;
import std::collections::elastic_array;

/* Size (items count) of the one components chunk or entities collection for each block. */
<* Quick lifetime chunk size. *>
const usz QUICK_CHUNK_SIZE   = 100;
<* Dynamic lifetime chunk size. *>
const usz DYNAMIC_CHUNK_SIZE = 500;
<* Static lifetime chunk size. *>
const usz STATIC_CHUNK_SIZE  = 300;

<* Maximum components count available for adding to entity. *>
const usz MAX_COMPONENTS_COUNT = 128;
<* Maximum tags count available for adding to entity. *>
const usz MAX_TAGS_COUNT = 128;

<* Quick (lifetime) block. *>
alias QuickBlock = Block { QUICK_CHUNK_SIZE };
<* Dynamic (lifetime) block. *>
alias DynamicBlock = Block { DYNAMIC_CHUNK_SIZE };
<* Static (lifetime) block. *>
alias StaticBlock = Block { STATIC_CHUNK_SIZE };

<* Quick (lifetime) blocks collection for each world. *>
alias QuickBlocks = List { QuickBlock };
<* Dynamic (lifetime) blocks collection for each world. *>
alias DynamicBlocks = List { DynamicBlock };
<* Static (lifetime) blocks collection for each world. *>
alias StaticBlocks = List { StaticBlock };

<* Component chunks collection for each block, key by component struct type.
   Chunk is represented as an array of component struct values ($Type[(QUICK|DYNAMIC|STATIC)_CHUNK_SIZE]).
   But is created as a pointer to allocated memory block. *>
alias Chunks = HashMap { typeid, char* };

<* Worlds collection in the space. *>
alias Worlds = List { World };

<* Registered components collection for each world. *>
alias Components = HashMap { typeid, Component };

<* Registered tags collection for each world. *>
alias Tags = HashMap { typeid, Tag };

<* Registered resources collection (with values) for each world. *>
alias Resources = HashMap { typeid, Resource };

<* Marker of added/existed components for the entity. *>
alias ComponentsMarker = BitSet { MAX_COMPONENTS_COUNT };
<* Marker of added/existed tags for the entity. *>
alias TagsMarker = BitSet { MAX_TAGS_COUNT };

<* Pointers to component values when retrieving/getting all. *>
alias ComponentPointers = ElasticArray { any, MAX_COMPONENTS_COUNT };

<* List of entities for system query result. *>
alias Entities = List { Entity* };

<* Systems collection in the world. *>
alias Systems = List { System };

<* Entities/blocks lifetime. *>
enum Lifetime : const inline char {
   <* Entities that exist for a very short period of time (a few dozen frames).
      Such blocks will use occupied (used) marker bitset to define that block is free to insert.
      Insertion should be performed as memory copy operation of whole chunk from static/stack memory,
      buffers where chunks would be filled enough during entites (components) adding. *>
   QUICK   = 0b00000001,
   <* Entities whose lifespan is not defined or determined in advance (from one frame to app exit).
      Such blocks will reuse freed after deletion rows to insert new entities. *>
   DYNAMIC = 0b00000010,
   <* Immortal entities that will exist until the end of the application.
      Such blocks are simply created when necessary, since entities cannot be despawn. *>
   STATIC  = 0b00000100
}

<* Kinds of elements that the world can consist of. *>
enum Element {
   <* Component element type (Position, Mass, Velocity).
      Must be defined as a struct or typedef custom typs. *>
   COMPONENT,
   <* Tag element type for marking entities with some kind of characteristic.
      Must be defined as a typedef with a simple fundamental underlying type (typedef Tag = int). *>
   TAG,
   <* Resource element type for storing data in the world that has only one instance, singleton.
      Must be defined as a struct or typedef custom typs. *>
   RESOURCE,
   <* System element type for running actions at each step of the world progress. *>
   SYSTEM
}

<* The state flags for an element (entity or system). *>
enum ElementState : const inline char {
   <* Entity is stored in quick lifetime buffer. *>
   BUFFERED       = 0b00000001,
   <* Entity has been deleted. *>
   DELETED        = 0b00000010,
   <* System is enabled. *>
   ENABLED        = 0b00000100,
   <* System has tags in the match query. *>
   HAS_TAGS       = 0b00001000,
   <* System has components in the match query. *>
   HAS_COMPONENTS = 0b00010000
}

<* Predicate function for match blocks using their intefraces. *>
alias BlockGeneMatch = fn bool (BlockGene block);

<* Callback function for the system. *>
alias SystemCallback = fn void (Entities entities);

<* Entities iterator. *>
struct EntitiesIterator {
	<* Current entity index. *>
	usz idx;
	<* Current entity pointer. *>
	Entity* entity;
}
