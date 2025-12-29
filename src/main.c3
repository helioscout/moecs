module moecs;

import std::io;
import std::time;

struct Position (Printable) {
	double x, y;
}

struct Center (Printable) {
	int cx, cy;
}

struct Resource1 {
	bool enabled;
}

struct Resource2 {
	bool enabled;
	int count;
}

typedef VecType = float[<2>];

typedef Tag1 = int;
typedef Tag2 = int;

Entity[QUICK_CHUNK_SIZE] entities;
Position[QUICK_CHUNK_SIZE] positions;
Center[QUICK_CHUNK_SIZE] centers;
VecType[QUICK_CHUNK_SIZE] vectors;

fn usz? Position.to_format(&self, Formatter* f) @dynamic {
	return f.printf("{ x: %f, y: %f }", self.x, self.y);
}
 
fn usz? Center.to_format(&self, Formatter* f) @dynamic {
	return f.printf("{ cx: %d, cy: %d }", self.cx, self.cy);
}

fn usz? Resource1.to_format(&self, Formatter* f) @dynamic {
	return f.printf("{ enabled: %s }", self.enabled);
}

fn usz? Resource2.to_format(&self, Formatter* f) @dynamic {
	return f.printf("{ enabled: %s, count: %d }", self.enabled, self.count);
}

Clock clock @noinit;
NanoDuration duration @noinit;

fn void system1(Entities entities) {
	
}

fn void system2(Entities entities) {
	
}

fn void system3(Entities entities) {
	
}

fn void main() {
	init();

	World* world = new(&entities);

	io::printn("---------");
	io::printn(Lifetime.QUICK);
	io::printn(Lifetime.DYNAMIC);
	io::printn(Lifetime.STATIC);
	io::printn(Lifetime.QUICK | Lifetime.STATIC);
	io::printn(world.size(Lifetime.QUICK | Lifetime.STATIC));
	io::printn("---------");
	io::printn(world.size_of(Lifetime.QUICK, Lifetime.DYNAMIC));
	// io::printn(Tag1.typeid == Tag1.typeid);

	io::printn("--- registering ---");
	world.register(COMPONENT, Position, &positions)
		 .register(COMPONENT, Center, &centers)
		 .register(COMPONENT, VecType, &vectors)
		 .register(RESOURCE, Resource1)
		 .register(RESOURCE, Resource2)
		 .register(TAG, Tag1)
		 .register(TAG, Tag2)
		 .mount({ .tags = { Tag1 }, .callback = &system1 })
		 .mount({ .tags = { Tag2 }, .callback = &system1 })
		 .mount({ .components = { Position, Center }, .callback = &system1 })
		 .mount({ .components = { Position, Center }, .tags = { Tag1, Tag2 }, .callback = &system1 })
		 .mount({ .name = "s1", .components = { Position }, .tags = { Tag1 }, .callback = &system2 })
		 .mount({ .name = "s2", .components = { Position, Center, VecType }, .tags = { Tag1 }, .callback = &system2 })
		 .run();

	// world.spawn(QUICK)
	// 	.add((Position){ .x = 1, .y = 1 })
	// 	.add((Center){ .cx = 1, .cy = 1 });
	
	// world.spawn(DYNAMIC)
	// 	.add((Position){ .x = 1, .y = 1 })
	// 	.add((Center){ .cx = 1, .cy = 1 });
		
	// world.spawn(STATIC)
	// 	.add((Position){ .x = 1, .y = 1 })
	// 	.add((Center){ .cx = 1, .cy = 1 });
		
	Entity* e = world.spawn(QUICK);
		// .@add(Position, { .x = 1, .y = 1 })
		// .@add(Center, { .cx = 1, .cy = 1 });
	
	Entity* ed = world.spawn(DYNAMIC)
		.@add(Position, { .x = 2, .y = 2 })
		.@add(Center, { .cx = 2, .cy = 2 });
		
	Entity* es = world.spawn(STATIC)
		.@add(Position, { .x = 3, .y = 3 })
		.@add(Center, { .cx = 3, .cy = 3 });
		
	world.spawn(QUICK);
	world.spawn(DYNAMIC);
	world.spawn(STATIC);

	io::printn("---------");
	io::printn(e.has(Position));
	io::printn(e.has(Center));
	io::printn(e.has(VecType));
	io::printn("---------");

	if (try Position* p = e.get(Position) && try Center* c = e.get(Center)) {
		io::printn(p);
		io::printn(c);
	} else {
		io::printn("Not found");
	}

	if (try Position* p = ed.get(Position) && try Center* c = ed.get(Center)) {
		io::printn(p);
		io::printn(c);
	} else {
		io::printn("Not found");
	}

	if (try Position* p = es.get(Position) && try Center* c = es.get(Center) && try VecType* v = es.get(VecType)) {
		io::printn(p);
		io::printn(c);
	} else {
		io::printn("Not found");
	}

	io::printn("---------");

	@pool() {
		foreach (component : e.tget_all(Position, Center, VecType, int)) {
			switch (component.type) {
				case Position:
					io::print("Position: ");
					io::printn(component);
				case Center:
					io::print("Center: ");
					io::printn(component);
			}
		}
	};

	io::printn("---- all -----");

	@pool() {
		foreach (component : ed.tall()) {
			switch (component.type) {
				case Position:
					io::print("Position: ");
					io::printn(component);
				case Center:
					io::print("Center: ");
					io::printn(component);
			}
		}
	};

	io::printn("---- @each -----");

	es.@each(; typeid type, void* c) {
		switch (type) {
			case Position:
				io::print("Position: ");
				io::printn((Position*)c);
			case Center:
				io::print("Center: ");
				io::printn((Center*)c);
		}
	};

	// es.remove_all(Position, Center);

	// es.@each(; typeid type, void* c) {
	// 	switch (type) {
	// 		case Position:
	// 			io::print("Position: ");
	// 			io::printn((Position*)c);
	// 		case Center:
	// 			io::print("Center: ");
	// 			io::printn((Center*)c);
	// 	}
	// };

	ed.tag(Tag1);

	io::printfn("Tagged with Tag1: %s", ed.tagged(Tag1));
	io::printfn("Tagged with Tag2: %s", ed.tagged(Tag2));

	es.tag_all(Tag1, Tag2);
	io::printn(es.tagged_all(Tag1, Tag2));
	
	es.untag_all(Tag2, Tag1);
	io::printn(es.tagged_all(Tag1, Tag2));

	io::printfn("-- spawning dynamics ( %d ) --", DYNAMIC_CHUNK_SIZE * 1000 + 3);
	clock = clock::now();
	
	for (usz i = 0; i < DYNAMIC_CHUNK_SIZE * 1000 + 3; i++) {
		world.spawn(DYNAMIC);
	}

	duration = clock.mark();
	io::printfn("\nEllapsed: %s", duration);

	io::printfn("-- spawning quicks ( %d ) --", QUICK_CHUNK_SIZE * 1000 + 3);
	clock = clock::now();
	
	for (usz i = 0; i < QUICK_CHUNK_SIZE * 1000 + 3; i++) {
		world.spawn(QUICK);
	}

	duration = clock.mark();
	io::printfn("\nEllapsed: %s", duration);

	io::printfn("-- spawning statics ( %d ) --", STATIC_CHUNK_SIZE * 1000 + 3);
	clock = clock::now();
	
	for (usz i = 0; i < STATIC_CHUNK_SIZE * 1000 + 3; i++) {
		world.spawn(STATIC);
	}

	duration = clock.mark();
	io::printfn("\nEllapsed: %s", duration);

	if (try Resource1* r = world.get(Resource1)) {
		io::printn(r);
		r.enabled = true;
	}
	if (try Resource1* r = world.get(Resource1)) {
		io::printn(r);
	}

	world.@set(Resource1, { .enabled = false });
	if (try Resource1* r = world.get(Resource1)) {
		io::printn(r);
	}

	io::printn("--- Resource2 ---");
	if (try Resource2* r = world.get(Resource2)) {
		io::printn(r);
	}

	world.set((Resource2) { .enabled = true, .count = 7 });
	if (try Resource2* r = world.get(Resource2)) {
		io::printn(r);
	}

	// io::printfn("-- iterating dynamics ( %d ) --", DYNAMIC_CHUNK_SIZE * 1000 + 3);
	// clock = clock::now();

	// world.@each(Lifetime.DYNAMIC; Entity* entity, Lifetime lifetime) {
	// 	if (try Position* p = e.get(Position) && try Center* c = e.get(Center)) {
	// 		// some actions...
	// 	}
	// };
	
	// duration = clock.mark();
	// io::printfn("\nEllapsed: %s", duration);

	// io::printfn("-- iterating quicks ( %d ) --", QUICK_CHUNK_SIZE * 1000 + 3);
	// clock = clock::now();

	// world.@each(Lifetime.QUICK; Entity* entity, Lifetime lifetime) {
	// 	if (try Position* p = e.get(Position) && try Center* c = e.get(Center)) {
	// 		// some actions...
	// 	}
	// };
	
	// duration = clock.mark();
	// io::printfn("\nEllapsed: %s", duration);

	// io::printfn("-- iterating statics ( %d ) --", STATIC_CHUNK_SIZE * 1000 + 3);
	// clock = clock::now();

	// world.@each(Lifetime.STATIC; Entity* entity, Lifetime lifetime) {
	// 	if (try Position* p = e.get(Position) && try Center* c = e.get(Center)) {
	// 		// some actions...
	// 	}
	// };
	
	// duration = clock.mark();
	// io::printfn("\nEllapsed: %s", duration);

	// io::printn("-- iterating all --");
	// clock = clock::now();

	// world.@each(; Entity* entity, Lifetime lifetime) {
	// 	if (try Position* p = e.get(Position) && try Center* c = e.get(Center)) {
	// 		// some actions...
	// 	}
	// };
	
	// duration = clock.mark();
	// io::printf("\nEllapsed: %s", duration);

	usz step = 0;
	clock = clock::now();
	
	while (step++ < 100) {
		world.progress();
	}
	
	duration = clock.mark();
	io::printf("\nStep ellapsed: %s", duration);
}
