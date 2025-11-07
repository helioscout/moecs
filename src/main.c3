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
	inline Component _c;
	double x, y;
}

struct Center (Printable) {
	inline Component _c;
	int cx, cy;
}

// Chunks chunks;

// fn usz? Component.to_format(&self, Formatter* f) @dynamic {
// 	return f.printf("index: %d", self.idx);
// }
 
fn usz? Position.to_format(&self, Formatter* f) @dynamic {
	return f.printf("x: %f, y: %f, %s", self.x, self.y, self._c);
}
 
fn usz? Center.to_format(&self, Formatter* f) @dynamic {
	return f.printf("cx: %d, cy: %d, %s", self.cx, self.cy, self._c);
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

	World* world = new();

	// register(Position);
	// register(Center);

	// adding();

	// io::printn(get(Position, 0));
	// io::printn(get(Center, 0));
}
