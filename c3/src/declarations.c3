module moecs;

import std::collections::map;
import std::collections::list;
import std::collections::bitset;
import std::collections::elastic_array;

/* Size (items count) of the one components chunk or entities collection for each block.
   Bigger chunk size increase productivity of entities adding, less chunk size speed up
   reading component while world runing. */

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
alias QuickBlocks = List { QuickBlock* };
<* Dynamic (lifetime) blocks collection for each world. *>
alias DynamicBlocks = List { DynamicBlock* };
<* Static (lifetime) blocks collection for each world. *>
alias StaticBlocks = List { StaticBlock* };

<* Worlds collection in the space. *>
alias Worlds = List { World* };

<* Registered components collection for each world. *>
alias Components = Elements { Component, MAX_COMPONENTS_COUNT };

<* Registered tags collection for each world. *>
alias Tags = Elements { Tag, MAX_TAGS_COUNT };

<* Registered resources collection (with values) for each world. *>
alias Resources = HashMap { typeid, Resource };

<* Marker of added/existed components for the entity. *>
alias ComponentsMarker = BitSet { MAX_COMPONENTS_COUNT };
<* Marker of added/existed tags for the entity. *>
alias TagsMarker = BitSet { MAX_TAGS_COUNT };

<* Pointers to component values when retrieving/getting all. *>
alias ComponentPointers = ElasticArray { any, MAX_COMPONENTS_COUNT };

<* List of entities for system query result and other purposes. *>
alias Entities = List { Entity* };

<* Systems collection in the world. *>
alias Systems = List { System* };

<* Archetypes collection of the world. *>
alias Archetypes = List { Archetype* };

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
      Must be defined as a struct or typedef custom type. *>
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
   HAS_COMPONENTS = 0b00010000,
   <* Entity should be re-archetyped at deffered (perform) stage. *>
   ARCHETYPING    = 0b00100000
}

<* Predicate function for match blocks using their intefraces. *>
alias BlockGeneMatch = fn bool (BlockGene block);

<* Callback function for the system. *>
alias SystemCallback = fn void (Entities entities, World* world);

<* Entities iterator. *>
struct EntitiesIterator {
	<* Current entity index. *>
	usz idx;
	<* Current entity pointer. *>
	Entity* entity;
}

<* Query match approach of slection entities for the systems. *>
enum Approach : char {
	<* Using this approach at each progress step all world entites will be iterated
	   with applying match conditions to select them for each running system. *>
	ITERATION,
	<* Each entity belongs to some unique archetype that is combination of bit flags
	   that represent entity's components/tags configuration. At each world progress step
	   all archetypes will be iterated witch applying match condition of each system. *>
	ARCHETYPE
}

<* Deffered actions for the world. *>
struct Deffered {
	<* Despawning entities. We need to keep them in the archetypes till end of the current progress step,
	   otherwise iterators inside systems code can lead to bugs, as they iterate over collections of
	   the archetypes which we need to delete entities from. Entities will be marked as DELETED but
	   despawned (deleted from the block) at performing stage. Also, a new entity can be written in place
	   of a deleted entity, then bugs are inevitable since the reference to the deleted entity will
	   continue to be stored in the archetype collection. *>
	Entities despawning;
	<* When tags/components is being added/removed to the entity and world is already running,
	   entites should not be moved to other archetypes till end of the current progress step,
	   so this archetyping action is deffered to the perform stage. *>
	Entities archetyping;
}
