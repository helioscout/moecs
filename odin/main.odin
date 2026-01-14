package main

import "core:fmt"
import "core:time"
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
	_time: time.Time = ---
	_duration: time.Duration = ---
	
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

	fmt.printfln("Entity size: %v", size_of(ecs.Entity))

	// resource1 : ^Resource1 = ecs.get_resource(world, Resource1)
	// resource1.enabled = true
	
	ecs.set(world,
		Resource1, Resource1 { enabled = true },
		Resource2, Resource2 { count = 10 })
	
	// if r, ok := ecs.get(world, Resource1); ok {
	// 	fmt.println(r)
	// }

	r1, r2 := ecs.get(world, Resource1, Resource2)

	fmt.println(r1)
	fmt.println(r2)

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

	ecs.add(e5, Position, &Position { x = 3, y = 4 })
	// ecs.add(e4, Position, &Position { x = 1, y = 2 })
	// ecs.add(e4, Center, &Center { cx = 1, cy = 2 })
	ecs.add(e2, Center, &Center { cx = 1, cy = 2 })
	ecs.add(e1, Center, &Center { cx = 3, cy = 4 })
	ecs.add(e3, VecType, &VecType { 10, 20 })

	ecs.add(e4,
		Position, &Position { x = 1, y = 2 },
		Center,   &Center   { cx = 1, cy = 2 })

	// ecs.remove(e4, Position, Center, int)
	// ecs.remove(e4, Position)

	if c, ok := ecs.get(e4, Position); ok {
		fmt.println(c)
	} else do fmt.println("Component not found.")
	
	if c, ok := ecs.get_component(e4, Center); ok {
		fmt.println(c)
	} else do fmt.println("Component not found.")

	ecs.set(e4, Position, &Position { x = 10, y = 20 },
				Center,   &Center { cx = 11, cy = 22 })

	pos, center := ecs.get(e4, Position, Center)

	fmt.println(pos)
	fmt.println(center)

	// c := ecs.get(e4, Position)

	fmt.println(ecs.has(e4, Position))
	fmt.println(ecs.has(e4, Position, Center))

	// ecs.tag(e1, Tag1)
	ecs.tag(e1, Tag1, Tag2)

	// ecs.untag(e1, Tag1)
	// ecs.untag(e1, Tag1, Tag2, int)

	fmt.println("-------------------------")

	fmt.println(ecs.tagged(e1, Tag1))
	fmt.println(ecs.tagged(e1, Tag1, Tag2, int))

	ecs.despawn(world, e1, e2, e4, e5)

	_time = time.now();
	fmt.printfln("-- spawning quicks ( %v )", ecs.QUICK_CHUNK_SIZE * 1000 + 3)

	for i in 0..<ecs.QUICK_CHUNK_SIZE * 1000 + 3 {
		ecs.add(ecs.spawn(world, .QUICK),
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 })
		// ecs.spawn(world, .QUICK)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	_time = time.now();
	fmt.printfln("-- spawning dynamics ( %v )", ecs.DYNAMIC_CHUNK_SIZE * 1000 + 3)

	for i in 0..<ecs.DYNAMIC_CHUNK_SIZE * 1000 + 3 {
		ecs.add(ecs.spawn(world, .DYNAMIC),
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 })
		// ecs.spawn(world, .DYNAMIC)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	_time = time.now();
	fmt.printfln("-- spawning statics ( %v )", ecs.STATIC_CHUNK_SIZE * 1000 + 3)

	for i in 0..<ecs.STATIC_CHUNK_SIZE * 1000 + 3 {
		ecs.add(ecs.spawn(world, .STATIC),
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 })
		// ecs.spawn(world, .STATIC)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)
}
