package moecs

import "core:fmt"

World :: struct {
	/* Registered component types. */
	components : Components,
	/* Registered tag types. */
	tags : Tags,
	/* Registered resource types with its instances (values).
	   Collection of all world resources. */
	resources : Resources,
	/* Blocks for entities with quick lifetime. */
	quicks : [dynamic]Block,
	/* Blocks for entities with dynamic lifetime. */
	dynamics : [dynamic]Block,
	/* Blocks for entities with static lifetime. */
	statics : [dynamic]Block,
	/* Defines that world uses quick lifetime (default: true).
	   If at least one component is registered without a buffer it will be set to false.
	   If disabled than all attempts to create quick lifetime entites will fail. */
	use_quicks : bool,
	/* Buffer for quick life time entities, must be provided from the main app. */
	buffer : ^[QUICK_CHUNK_SIZE]Entity,
	/* Deleted (freed) rows in the quick lifetime buffer. */
	deleted: [dynamic]uint,
	/* Current inserting index in the quick lifetime buffer (last inserted index + 1). */
	idx : uint,
	/* Indicates that the world is running. */
	running : bool
}

/* Initializes the world.
   `world` : Pointer to the world. */
@(private="package")
world_init :: proc(world: ^World) {
}

/* Registers element type for the world.
   `world`   : Pointer to the world.
   `element` : World element kind.
   `$Type`   : Element (component/tag/resource) type.
   `buffer`  : Pointer to buffer for quick lifetime chunk. Ensure that you don't use same buffers for different worlds.*/
register :: proc(world: ^World, element: Element, $Type: typeid, buffer : rawptr = nil) {
	if world.running do return

	#partial switch element {
		case .COMPONENT:
			world.components[Type] = { type = Type, size = size_of(Type), buffer = buffer,
				idx = len(world.components) }
			if buffer == nil do world.use_quicks = false
		case .TAG:
			world.tags[Type] = { type = Type, idx = len(world.tags) }
		case .RESOURCE:
			world.resources[Type] = { type = Type, value = new(Type) }
	}
}

/* Runs the world, but at first constructs all neccessary data from registered elements.
   World must has at least one registered component, but can has no tags, resources.
   `world` : Pointer to the world. */
run :: proc(world: ^World) {
	if len(world.components) == 0 do panic("The world has no registered components.")
	if world.running do return

	world.running = true
}

/* Spawns new entity into the world.
   `world`    : Pointer to the world.
   `lifetime` : Entity lifetime (default: Lifetime.DYNAMIC).
   `returns`  : Pointer to new entity.
*/
spawn :: proc(world: ^World, lifetime: Lifetime = .DYNAMIC) -> ^Entity {
	entity: ^Entity = ---

	switch lifetime {
		case .QUICK: {
			if !world.use_quicks do panic("Quick lifetime was disabled, you should provide entity and components buffers.")

			if len(world.deleted) == 0 && world.idx == QUICK_CHUNK_SIZE {
			    /* If buffers are full we must flush them to free quick block. */
			    block_absorb(get_free_block(world, .QUICK))
				/* And reset current inserting index. */
				world.idx = 0
			}

			idx := pop_free_index(world)	/* Here we increase inserting index. */
			
			/* state has BUFFERED is a sign that entity is in the quick lifetime buffer, not a real block.		  */
			/* But chunk_idx will not change when flushed. We need assign world reference for access the buffer. */
			world.buffer[idx] = Entity { state = .BUFFERED, world = world, chunk_idx = idx }
			entity = &world.buffer[idx]
		}
			
		case .DYNAMIC: fallthrough
		case .STATIC: entity = block_insert(get_sparse_block(world, lifetime))
	}

	return entity
}

/* Creates new empty block in the world.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to newly created block. */
@(private="file")
new_block :: proc(world: ^World, lifetime: Lifetime) -> ^Block {
	block: ^Block = ---
	
	switch lifetime {
		case .QUICK:
			append(&world.quicks, Block { lifetime = .QUICK, world = world, size = QUICK_CHUNK_SIZE })
			block = &world.quicks[len(world.quicks) - 1]
		case .DYNAMIC:
			append(&world.dynamics, Block { lifetime = .DYNAMIC, world = world, size = DYNAMIC_CHUNK_SIZE })
			block = &world.dynamics[len(world.dynamics) - 1]
		case .STATIC:
			append(&world.statics, Block { lifetime = .STATIC, world = world, size = STATIC_CHUNK_SIZE })
			block = &world.statics[len(world.statics) - 1]
	}

	block_init(block)
	return block
}

/* Gets reference to the resource value by its type.
   `world`   : Pointer to the world.
   `$Type`   : Resource type.
   `returns` : Pointer to the resource. */
get_resource :: proc(world: ^World, $Type: typeid) -> ^Type {
	if Type in world.resources {
		return cast(^Type)world.resources[Type].value
	} else {
		return nil
	}
}

/* Sets resource value by its type.
   `world`    : Pointer to the world.
   `$Type`    : Resource type.
   `resource` : Resource value (will be copied into storage).
   `returns`  : True if resource type was found, otherwise - false. */
set_resource :: proc(world: ^World, $Type: typeid, resource: Type) -> bool {
	if Type in world.resources {
		(cast(^Type)world.resources[Type].value)^ = resource
		return true
	} else {
		return false
	}
}

/* Gets the reference to block that is available to insert new entities,
   has free rows or newly created one. Quick lifetime blocks can't be sparsed.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to available block. */
@(private="file")
get_sparse_block :: proc(world: ^World, lifetime: Lifetime) -> ^Block {
	blocks := get_blocks(world, lifetime)
	
	for &b in blocks^ {
		if block_has_free_rows(&b) do return &b
	}

	return new_block(world, lifetime)
}

/* Gets the reference to block that is totally free.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to free block. */
@(private="file")
get_free_block :: proc(world: ^World, lifetime: Lifetime) -> ^Block {
	blocks := get_blocks(world, lifetime)

	for &b in blocks^ {
		if block_is_free(&b) do return &b
	}

	return new_block(world, lifetime)
}

/* Gets blocks collection by its lifetime.
   `world`    : Pointer to the world.
   `lifetime` : Block lifetime.
   `returns`  : Pointer to free block. */
@(private="file")
get_blocks :: proc(world: ^World, lifetime: Lifetime) -> ^[dynamic]Block {
	switch lifetime {
		case .QUICK:   return &world.quicks
		case .DYNAMIC: return &world.dynamics
		case .STATIC:  return &world.statics
	}

	return nil
}

/* Returns index of the first free to insert (last deleted) row in the quick lifetime buffer.
   `world`   : Pointer to the world.
   `returns` : Index of the row to insert.
*/
@(private="file")
pop_free_index :: proc(world: ^World) -> uint {
	idx: uint = ---
	
	if len(world.deleted) == 0 {
		idx = world.idx
		world.idx += 1
	} else {
		idx = pop(&world.deleted)
	}

	return idx
}
