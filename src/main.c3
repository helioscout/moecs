module moecs;

import std::io;
import std::collections::map;

// const int CHUNK_LENGTH = 100;
// int count = 0;

// alias Chunks = HashMap{typeid, any};

// struct Component (Printable) {
	// int idx;
// }

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

// Chunks chunks;

// fn usz? Component.to_format(&self, Formatter* f) @dynamic {
// 	return f.printf("index: %d", self.idx);
// }
 
fn usz? Position.to_format(&self, Formatter* f) @dynamic {
	return f.printf("x: %f, y: %f", self.x, self.y);
}
 
fn usz? Center.to_format(&self, Formatter* f) @dynamic {
	return f.printf("cx: %d, cy: %d", self.cx, self.cy);
}
/*
macro void register($Type) {
	chunks.set($Type.typeid, mem::alloc($Type[CHUNK_SIZE]));
}

macro void add($component) {
	$typeof($component)[CHUNK_SIZE]*? chunk = ($typeof($component)[CHUNK_SIZE]*)chunks.get($typeof($component).typeid);

	if (try chunk) {
		(*chunk)[count] = $component;
	}
}

macro get($Type, index) {
	$Type[CHUNK_SIZE]*? chunk = ($Type[CHUNK_SIZE]*)chunks.get($Type.typeid);

	if (try chunk) {
		return (*chunk)[index];
	}

	return ($Type){};
}

fn void adding() {
	add((Position){ .x = 1.0, .y = 2.0 });
	add((Center){ .cx = 3, .cy = 4 });

	count++;
}
*/
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

	world.register(COMPONENT, Position, &positions)
		 .register(COMPONENT, Center, &centers)
		 .register(COMPONENT, VecType, &vectors)
		 .register(RESOURCE, Resource1)
		 .register(RESOURCE, Resource2)
		 .register(TAG, Tag1)
		 .register(TAG, Tag2)
		 .run();

	world.run();

	io::printn(world.use_quicks);

	world.spawn(QUICK);
	world.spawn(DYNAMIC);
	world.spawn(STATIC);
	world.spawn(QUICK);
	world.spawn(DYNAMIC);
	world.spawn(STATIC);

	// io::printn(positions);
	// adding();

	// io::printn(get(Position, 0));
	// io::printn(get(Center, 0));
}
