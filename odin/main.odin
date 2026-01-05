package main

import "core:fmt"
import ecs "src"

main :: proc() {
	world := ecs.new_world()
	fmt.println(ecs.size())
}
