module moecs;

import std::collections::map;
import std::collections::list;

<* Size (items count) of the one components chunk or entities collection for each block. *>
const usz CHUNK_SIZE = 100;

<* Entities collection (chunk) for each block.
   The index of the entity corresponds to the index of its components in each chunk. *>
alias Entities = Entity[CHUNK_SIZE];

<* Component chunks collection for each block, key by component struct type.
   Chunk is represented as an array of component struct values ($Type[CHUNK_SIZE]). *>
alias Chunks = HashMap { typeid, any };

<* Blocks collection for each world. *>
alias Blocks = List { Block };

<* Worlds collection in the space. *>
alias Worlds = List { World };
