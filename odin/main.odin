package main

import "core:fmt"
import ecs "src"

Position :: struct {
	x, y : f64
}

Center :: struct {
	cx, cy : int
}

Resource1 :: struct {
	enabled : bool
}

Resource2 :: struct {
	enabled : bool,
	count : int
}

VecType :: distinct [2]f32

Tag1 :: distinct int
Tag2 :: distinct int

entities  : [ecs.QUICK_CHUNK_SIZE]ecs.Entity
positions : [ecs.QUICK_CHUNK_SIZE]Position
centers   : [ecs.QUICK_CHUNK_SIZE]Center
vectors   : [ecs.QUICK_CHUNK_SIZE]VecType

// test :: proc(block: ecs.Block($ChunkSize)) {
// 	fmt.println(len(block.entities))
// }

main :: proc() {
	ecs.init()
	
	world : ^ecs.World = ecs.new_world(&entities)

	ecs.register(world, .COMPONENT, Position, &positions)
	ecs.register(world, .COMPONENT, Center, &centers)
	ecs.register(world, .COMPONENT, VecType, &vectors)
	ecs.register(world, .RESOURCE, Resource1)
	ecs.register(world, .RESOURCE, Resource2)
	ecs.register(world, .TAG, Tag1)
	ecs.register(world, .TAG, Tag2)

	ecs.run(world)

	// resource1 : ^Resource1 = ecs.get_resource(world, Resource1)
	// resource1.enabled = true
	
	ecs.set_resource(world, Resource1, Resource1 { enabled = true })
	ecs.set_resource(world, Resource2, Resource2 { count = 10 })
	
	fmt.println(ecs.get_resource(world, Resource1))
	fmt.println(ecs.get_resource(world, Resource2))

	// block1: ecs.QuickBlock
	// block2: ecs.DynamicBlock
	// block3: ecs.StaticBlock

	// test(block1)
	// test(block2)
	// test(block3)

	e1 : ^ecs.Entity = ecs.spawn(world, .DYNAMIC)
	e2 : ^ecs.Entity = ecs.spawn(world, .DYNAMIC)
	e3 : ^ecs.Entity = ecs.spawn(world, .STATIC)

	e4 := ecs.spawn(world, .QUICK)
	e5 := ecs.spawn(world, .QUICK)
}
