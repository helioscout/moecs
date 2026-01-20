package main

import "core:fmt"
import "core:time"
import "core:os"
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

count : uint = 0

// test :: proc(block: ecs.Block($ChunkSize)) {
// 	fmt.println(len(block.entities))
// }

MAX_COUNT :: 130
BITS_COUNT : uint : size_of(uint) * 8
MARKER_SIZE : uint : (uint(MAX_COUNT) + BITS_COUNT - 1) / BITS_COUNT

marker_print :: proc(marker: [MARKER_SIZE]uint) {
	fmt.println("--- marker ---")
	
	for i in 0..<len(marker) {
		fmt.printfln("| word %v: %b", i, marker[i])
	}

	fmt.println("--------------")
}

system1 :: proc(entities: []^ecs.Entity) {
	
}

system2 :: proc(entities: []^ecs.Entity) {
	
}

system3 :: proc(entities: []^ecs.Entity) {
	// for entity in entities {
	// 	pos, center := ecs.get(entity, Position, Center)

	// 	fmt.println(pos, center)
	// }
}

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

	ecs.mount(world, { tags = { Tag1 }, callback = system1 })
	ecs.mount(world, { tags = { Tag2 }, callback = system1 })
	ecs.mount(world, { components = { Position, Center }, callback = system1 })
	ecs.mount(world, { components = { Position, Center }, tags = { Tag1, Tag2 }, callback = system3})
	ecs.mount(world, { name = "s1", components = { Position }, tags = { Tag1 }, callback = system2 })
	ecs.mount(world, { name = "s2", components = { Position, Center, VecType }, tags = { Tag1 }, callback = system2 })

	ecs.run(world)

	// ecs.unmount(world, "s2")
	// fmt.println(ecs.get(world, "s2"))

	// fmt.printfln("marker: %b", max(uint) >> (64 - 3 % 64))
	// fmt.println(3 % 64)
	// fmt.println(3 / 64)
	// fmt.printfln("Entity size: %v", size_of(ecs.Entity))

	// marker: [MARKER_SIZE]uint

	// marker_print(marker)
	// fmt.printfln("is all unset: %v", ecs.marker_is_all_unset(MAX_COUNT, MARKER_SIZE, marker))
	// ecs.marker_set(MARKER_SIZE, &marker, 7)
	// ecs.marker_set(MARKER_SIZE, &marker, 63)
	// ecs.marker_set(MARKER_SIZE, &marker, 129)
	// marker_print(marker)
	// fmt.printfln("is 5-th bit set: %v", ecs.marker_is_set(MARKER_SIZE, marker, 4))
	// fmt.printfln("is 64-th bit set: %v", ecs.marker_is_set(MARKER_SIZE, marker, 63))
	// fmt.printfln("is 129-th bit set: %v", ecs.marker_is_set(MARKER_SIZE, marker, 128))
	// fmt.printfln("is 130-th bit set: %v", ecs.marker_is_set(MARKER_SIZE, marker, 129))

	// for i in 0..<130 do ecs.marker_set(MARKER_SIZE, &marker, i)
	
	// marker_print(marker)
	// fmt.printfln("is all set: %v", ecs.marker_is_all_set(MAX_COUNT, MARKER_SIZE, marker))
	// ecs.marker_unset(MARKER_SIZE, &marker, 7)
	// ecs.marker_unset(MARKER_SIZE, &marker, 63)
	// ecs.marker_unset(MARKER_SIZE, &marker, 129)
	// marker_print(marker)

	// marker1: [MARKER_SIZE]uint = { max(uint), max(uint), max(uint) }
	// marker2 := ecs.marker_clone(MARKER_SIZE, marker1)

	// ecs.marker_unset(MARKER_SIZE, &marker2, 123)

	// marker_print(ecs.marker_xor(MARKER_SIZE, marker, marker1))
	// fmt.printfln("is equals: %v", ecs.marker_equals(MAX_COUNT, MARKER_SIZE, marker1, marker2))
	// fmt.printfln("is subset: %v", ecs.marker_is_subset(MAX_COUNT, MARKER_SIZE, marker1, marker2))
	// marker_print(marker1)
	// marker_print(marker2)
		
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

	for i in 0..<ecs.QUICK_CHUNK_SIZE * 1000 + 3 {
		ecs.add(ecs.spawn(world, .QUICK),
			Position, &Position { x = f64(i) + 10, y = f64(i) + 10 },
			Center, &Center { cx = i + 20, cy = i + 20 })
		// ecs.spawn(world, .QUICK)
	}

	fmt.println(len(world.quicks))

	ecs.each(world, callback = proc(entity: ^ecs.Entity, lifetime: ecs.Lifetime, world: ^ecs.World) {
		pos, center := ecs.get(entity, Position, Center)
		// fmt.println(pos, center)

		// if pos, ok := ecs.get(entity, Position); ok {
		// 	fmt.println(pos)
		// }

		// if center, ok := ecs.get(entity, Center); ok {
		// 	fmt.println(center)
		// }
	});

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

	_time = time.now()
	fmt.printfln("-- spawning quicks ( %v )", ecs.QUICK_CHUNK_SIZE * 1000 + 3)

	for i in 0..<ecs.QUICK_CHUNK_SIZE * 1000 + 3 {
		ecs.add(ecs.spawn(world, .QUICK),
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 })
		// ecs.spawn(world, .QUICK)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	_time = time.now()
	fmt.printfln("-- spawning dynamics ( %v )", ecs.DYNAMIC_CHUNK_SIZE * 1000 + 3)

	for i in 0..<ecs.DYNAMIC_CHUNK_SIZE * 1000 + 3 {
		e := ecs.spawn(world, .DYNAMIC)

		ecs.add(e,
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 })
		
		if i >= 100 && i < 105 {
			ecs.tag(e, Tag1, Tag2)
		}
		// ecs.spawn(world, .DYNAMIC)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	_time = time.now()
	fmt.printfln("-- spawning statics ( %v )", ecs.STATIC_CHUNK_SIZE * 1000 + 3)

	for i in 0..<ecs.STATIC_CHUNK_SIZE * 1000 + 3 {
		ecs.add(ecs.spawn(world, .STATIC),
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 })
		// ecs.spawn(world, .STATIC)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	// buffer: [10]byte
	// os.read(os.stdin, buffer[:])

	_time = time.now()
	fmt.println("--- iterating ---")

	ecs.each(world, callback = proc(entity: ^ecs.Entity, lifetime: ecs.Lifetime, world: ^ecs.World) {
		pos, center := ecs.get(entity, Position, Center)
		count += 1
		// fmt.println(pos, center)
	});

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v, count: %v", _duration, count)

	_time = time.now()
	fmt.println("--- progress 100 times ---")

	for i in 0..<100 {
		ecs.progress(world)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	buffer: [10]byte
	os.read(os.stdin, buffer[:])
}
