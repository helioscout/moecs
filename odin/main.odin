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

Health :: struct {
	hp: u8
}

Rotation :: struct {
	angle: int,
	rad: f32
}

Velocity :: distinct [1]f32

Resource1 :: struct {
	enabled : bool
}

Resource2 :: struct {
	enabled : bool,
	count : int
}

Resource3 :: struct {
	ptr : rawptr,
	data : [3]f32
}

Resource4 :: struct {
	pos : Position,
	hp : Health
}

Resource5 :: struct {
	arr : [10]int
}

VecType :: distinct [2]f32

Tag1 :: distinct int
Tag2 :: distinct int

count : uint = 0

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

system1 :: proc(entities: ^[dynamic]^ecs.Entity, world: ^ecs.World) {
	despawned := false
	count := 0
	
	for entity in entities {

		if count < 100 {
			ecs.add(entity, Position, &Position { x = 111, y = 222 })
			count += 1
		}
	// 	pos, center := ecs.get(entity, Position, Center)

	// 	if pos != nil do pos.x += 1
	// 	if center != nil do center.cx += 1
	// 	// fmt.println(pos, center)
		if !despawned && !ecs.is_static(entity) {
			ecs.despawn(world, entity)
			despawned = true
		}
	}
}

system2 :: proc(entities: ^[dynamic]^ecs.Entity, world: ^ecs.World) {
	for entity in entities {
		// res1 := ecs.get(world, Resource1)
		// res2 := ecs.get(world, Resource2)
		// res3 := ecs.get_resource(world, Resource3)
		// res4 := ecs.get_resource(world, Resource4)
		// res5 := ecs.get(world, Resource5)
		res1, res2, res3, res4, res5 := ecs.get(world, Resource1, Resource2, Resource3, Resource4, Resource5)
		// pos, center, vec, health, vel, rot := ecs.get(entity, Position, Center, VecType, Health, Velocity, Rotation)
		// pos, center, vec, health, vel := ecs.get(entity, Position, Center, VecType, Health, Velocity)
		// pos, center, vec, health := ecs.get(entity, Position, Center, VecType, Health)
		// pos, center, vec := ecs.get(entity, Position, Center, VecType)
		// pos, center := ecs.get(entity, Position, Center)
		// pos := ecs.get(entity, Position)

		// pos.x += 1
		// center.cx += 1
		// fmt.println(pos, center)
		res3.data[0] = 3
		res4.pos.x += 1

		// ecs.set(entity,
		// 	Position, &Position { x = 10, y = 10 },
		// 	Center, &Center { cx = 20, cy = 20 },
		// 	Health, &Health { hp = 30 },
		// 	Rotation, &Rotation { angle = 90 },
		// 	Velocity, &Velocity { 50 })
	}
}

system3 :: proc(entities: ^[dynamic]^ecs.Entity, world: ^ecs.World) {
	for entity in entities {
		// res1 := ecs.get(world, Resource1)
		// res2 := ecs.get(world, Resource2)
		// res3 := ecs.get_resource(world, Resource3)
		// res4 := ecs.get_resource(world, Resource4)
		// res5 := ecs.get(world, Resource5)
		res1, res2, res3, res4, res5 := ecs.get(world, Resource1, Resource2, Resource3, Resource4, Resource5)
		// pos, center, vec, health, vel, rot := ecs.get(entity, Position, Center, VecType, Health, Velocity, Rotation)
		// pos, center, vec, health, vel := ecs.get(entity, Position, Center, VecType, Health, Velocity)
		// pos, center, vec, health := ecs.get(entity, Position, Center, VecType, Health)
		// pos, center, vec := ecs.get(entity, Position, Center, VecType)
		// pos, center := ecs.get(entity, Position, Center)
		// pos := ecs.get(entity, Position)

		// pos.x += 1
		// center.cx += 1
		// fmt.println(pos, center)
		res3.data[0] = 3
		res4.pos.x += 1

		// ecs.set(entity,
		// 	Position, &Position { x = 10, y = 10 },
		// 	Center, &Center { cx = 20, cy = 20 },
		// 	Health, &Health { hp = 30 },
		// 	Rotation, &Rotation { angle = 90 },
		// 	Velocity, &Velocity { 50 })
	}
}

main :: proc() {
	_time: time.Time = ---
	_duration: time.Duration = ---
	
	ecs.init()
	
	world : ^ecs.World = ecs.new_world(.ARCHETYPE)

	ecs.register(world, .COMPONENT, Position)
	ecs.register(world, .COMPONENT, Center)
	ecs.register(world, .COMPONENT, VecType)
	ecs.register(world, .COMPONENT, Health)
	ecs.register(world, .COMPONENT, Rotation)
	ecs.register(world, .COMPONENT, Velocity)
	ecs.register(world, .RESOURCE, Resource1)
	ecs.register(world, .RESOURCE, Resource2)
	ecs.register(world, .RESOURCE, Resource3)
	ecs.register(world, .RESOURCE, Resource4)
	ecs.register(world, .RESOURCE, Resource5)
	ecs.register(world, .TAG, Tag1)
	ecs.register(world, .TAG, Tag2)

	ecs.mount(world, { tags = { Tag1 }, callback = system1 })
	ecs.mount(world, { tags = { Tag2 }, callback = system1 })
	ecs.mount(world, { components = { Position, Center }, callback = system3 })
	ecs.mount(world, { components = { Position, Center }, tags = { Tag1, Tag2 }, callback = system3})
	ecs.mount(world, { name = "s1", components = { Position }, tags = { Tag1 }, callback = system2 })
	ecs.mount(world, { name = "s2", components = { Center }, tags = { Tag2 }, callback = system2 })
	ecs.run(world)
	fmt.println("--- world is running ---")

	// ecs.unmount(world, "s2")
	// fmt.println(ecs.get(world, "s2"))

	// fmt.println(transmute(u64)typeid_of(Position))
	// fmt.println(transmute(u64)typeid_of(Center))
	// fmt.println(transmute(u64)typeid_of(VecType))
	// fmt.println(transmute(u64)typeid_of(Tag1))
	// fmt.println(transmute(u64)typeid_of(Tag2))
	// fmt.printfln("%b", max(uint) >> (64 - 62 % 64))
	// fmt.printfln("marker: %b", max(uint) >> (64 - 3 % 64))
	// fmt.println(3 / 64)
	fmt.printfln("Entity size: %v", size_of(ecs.Entity))

	// marker: [MARKER_SIZE]uint

	// marker_print(marker)
	// fmt.printfln("is all unset: %v", ecs.marker_is_all_unset(MAX_COUNT, MARKER_SIZE, marker))
	// ecs.marker_set(MARKER_SIZE, &marker, 7)
	// ecs.marker_set(MARKER_SIZE, &marker, 63)
	// ecs.marker_set(MARKER_SIZE, &marker, 129)
	// fmt.printfln("is any set: %v", ecs.marker_is_any_set(MAX_COUNT, MARKER_SIZE, marker))
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

	// _time = time.now()
	// fmt.println("-- spawning dynamics (100000 iterations by 500 entities) --")

	// for i in 0..<100000 {
	// 	for i in 0..<500 {
	// 		ecs.add(ecs.spawn(world, .DYNAMIC),
	// 			Position, &Position { x = f64(i) + 10, y = f64(i) + 10 },
	// 			Center, &Center { cx = i + 20, cy = i + 20 },
	// 			Health, &Health { hp = 30 },
	// 			Rotation, &Rotation { angle = 90 },
	// 			Velocity, &Velocity { 50 })
	// 	}

	// 	ecs.each(world, { .DYNAMIC }, callback = proc(entity: ^ecs.Entity, lifetime: ecs.Lifetime, world: ^ecs.World) {
	// 		ecs.despawn(world, entity)
	// 	})

	// 	// fmt.printfln("-- before: %v", len(world.deffered.despawning))
	// 	ecs.perform(world)
	// 	// fmt.println(world.deleted)
	// 	// fmt.printfln("-- after: %v", len(world.deffered.despawning))
	// }

	// _duration = time.diff(_time, time.now())
	// fmt.printfln("-- ellapsed: %v", _duration)
	// fmt.printfln("-- dynamic blocks count: %v", len(world.dynamics))

	// _time = time.now()
	// fmt.println("-- spawning statics (1000 iterations by 500 entities) --")

	// for i in 0..<1000 {
	// 	for i in 0..<500 {
	// 		ecs.add(ecs.spawn(world, .STATIC),
	// 			Position, &Position { x = f64(i) + 10, y = f64(i) + 10 },
	// 			Center, &Center { cx = i + 20, cy = i + 20 },
	// 			Health, &Health { hp = 30 },
	// 			Rotation, &Rotation { angle = 90 },
	// 			Velocity, &Velocity { 50 })
	// 	}

	// 	// ecs.each(world, { .STATIC }, callback = proc(entity: ^ecs.Entity, lifetime: ecs.Lifetime, world: ^ecs.World) {
	// 	// 	ecs.despawn(world, entity)
	// 	// })

	// 	// ecs.perform(world)
	// }

	// _duration = time.diff(_time, time.now())
	// fmt.printfln("-- ellapsed: %v", _duration)
	// fmt.printfln("-- static blocks count: %v", len(world.statics))

	ecs.set(world,
		Resource1, &Resource1 { enabled = true },
		Resource2, &Resource2 { count = 10 })
	
	// if r, ok := ecs.get(world, Resource1); ok {
	// 	fmt.println(r)
	// }

	r1, r2 := ecs.get(world, Resource1, Resource2)

	fmt.println(r1)
	fmt.println(r2)

	for i in 0..<100000 + 3 {
		ecs.add(ecs.spawn(world, .STATIC),
			Position, &Position { x = f64(i) + 10, y = f64(i) + 10 },
			Center, &Center { cx = i + 20, cy = i + 20 },
			Health, &Health { hp = 30 },
			Rotation, &Rotation { angle = 90 },
			Velocity, &Velocity { 50 })
	}

	ecs.each(world, callback = proc(entity: ^ecs.Entity, lifetime: ecs.Lifetime, world: ^ecs.World) {
		pos, center := ecs.get(entity, Position, Center)
		// fmt.println(pos, center)

		// if pos, ok := ecs.get(entity, Position); ok {
		// 	fmt.println(pos)
		// }

		// if center, ok := ecs.get(entity, Center); ok {
		// 	fmt.println(center)
		// }
	})

	e1 : ^ecs.Entity = ecs.spawn(world, .DYNAMIC)
	e2 : ^ecs.Entity = ecs.spawn(world, .DYNAMIC)
	e3 : ^ecs.Entity = ecs.spawn(world, .STATIC)

	e4 := ecs.spawn(world, .DYNAMIC)
	e5 := ecs.spawn(world, .STATIC)

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

	// ecs.despawn(world, e1, e2, e4, e5)
	
	_time = time.now()
	fmt.printfln("-- spawning dynamics ( %v )", 100000 + 3)

	for i in 0..<100000 + 3 {
		e := ecs.spawn(world, .DYNAMIC)
		ecs.add(e,
			// Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 },
			Health, &Health { hp = 30 },
			Rotation, &Rotation { angle = 90 },
			Velocity, &Velocity { 50 })
		ecs.tag(e, Tag2)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	_time = time.now()
	fmt.printfln("-- spawning dynamics ( %v )", 500000 + 3)

	for i in 0..<500000 + 3 {
		e := ecs.spawn(world, .DYNAMIC)

		ecs.add(e,
			Position, &Position { x = 10, y = 10 },
			Health, &Health { hp = 30 },
			Rotation, &Rotation { angle = 90 },
			Velocity, &Velocity { 50 }
			/*Center, &Center { cx = 20, cy = 20 }*/)
		ecs.tag(e, Tag1)
		
		if i >= 100 && i < 105 {
			ecs.add(e, Center, &Center { cx = i, cy = i + 1 })
			ecs.tag(e, Tag2)
		}
		// ecs.spawn(world, .DYNAMIC)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v", _duration)

	_time = time.now()
	fmt.printfln("-- spawning statics ( %v )", 300000 + 3)

	for i in 0..<300000 + 3 {
		ecs.add(ecs.spawn(world, .STATIC),
			Position, &Position { x = 10, y = 10 },
			Center, &Center { cx = 20, cy = 20 },
			Health, &Health { hp = 30 },
			Rotation, &Rotation { angle = 90 },
			Velocity, &Velocity { 50 })
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
	})

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v, count: %v", _duration, count)

	// ecs.run(world)
	// fmt.println("--- world is running ---")
	ecs.despawn(world, e1, e2, e4)

	for archetype in world.archetypes {
		fmt.printfln("archetype: %v, %v, %v", len(archetype.entities), archetype.components, archetype.tags)
	}

	_time = time.now()
	fmt.println("--- progress 100 times ---")

	for i in 0..<100 {
		ecs.progress(world)
	}

	_duration = time.diff(_time, time.now())
	fmt.printfln("-- ellapsed: %v ms", time.duration_milliseconds(_duration))
	fmt.printfln("-- ellapsed: %v", _duration)

	// buffer: [10]byte
	// os.read(os.stdin, buffer[:])
}
