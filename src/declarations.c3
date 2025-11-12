module moecs;

import std::collections::map;
import std::collections::list;

/* Size (items count) of the one components chunk or entities collection for each block. */
<* Quick lifetime chunk size. *>
const usz QUICK_CHUNK_SIZE   = 100;
<* Dynamic lifetime chunk size. *>
const usz DYNAMIC_CHUNK_SIZE = 500;
<* Static lifetime chunk size. *>
const usz STATIC_CHUNK_SIZE  = 300;

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
   Chunk is represented as an array of component struct values ($Type[(QUICK|DYNAMIC|STATIC)_CHUNK_SIZE]). *>
alias Chunks = HashMap { typeid, any };

<* Worlds collection in the space. *>
alias Worlds = List { World };

<* Registered components collection for each world. *>
alias Components = HashMap { typeid, Component };

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
