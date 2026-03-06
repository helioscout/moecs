This is my modest attempt at creating an ECS (Entity Component System).\

### Memory concept
The main idea is that memory for components is divided into blocks, and entities belong to two lifetimes:
- DYNAMIC: usual entities that are spawned and despawned while world exists;
- STATIC: entities that lives forever (same as the world lifetime), like asteroids, planets, buildings;\
\
For DYNAMIC lifetime blocks, components chunks inserted at the end of the block if there are no free rows after previously deleted entities.\
![Design](docs/design.png)\
\
Because static lifetime entities lives wile the world exists there are no deleting mechanism for them in its blocks, and components are simply inserted to the next free row or new block will be inserted if current one is full.\
\
![Static](docs/static.png)\
\
There are main constants that you can change when copying ECS into your project if you want to experiment with performance:
- DYNAMIC_CHUNK_SIZE: Dynamic lifetime chunk size;
- STATIC_CHUNK_SIZE: Static lifetime chunk size;\
\
There is no limitations of entities count, but for components and tags:
- MAX_COMPONENTS_COUNT: Maximum components count available for adding to entity;
- MAX_TAGS_COUNT: Maximum tags count available for adding to entity.\

### Worlds
The top container is the space (ecs) that consists of worlds. You can create as much worlds as you want and all of them will be proceeded separately. But as a rule, one world is enough for you.
```odin
import ecs "moecs/src"

main :: proc() {
  /* Initializes the space (ecs). */
  ecs.init()
  /* Creates new world. */
  world : ^ecs.World = ecs.new_world()
  /* Destroy all objects and free memory. */
  ecs.destroy()
}
```
| Procedure      | Description                                                                                  |
|----------------|----------------------------------------------------------------------------------------------|
| init()         | Initializes the ecs. Call it before all other actions with ecs.                              |
| size()         | Gets worlds count.                                                                           |
| new_world()    | Creates new world and returns a pointer to it.                                               |
| destroy()      | Free all worlds of the space. Call it before app exit or when ecs is not need anymore.       |

### Elements
Kinds of elements that the world can consist of represented with `Element` enum.
| Member         | Description                                                                                  |
|----------------|----------------------------------------------------------------------------------------------|
| COMPONENT      | Component element type (`Position`, `Mass`, `Velocity`).                                      
                   Must be defined as a struct or distinct custom type.                                         |
| TAG            | Tag element type for marking entities with some kind of characteristic.                       
                   Must be defined as a `typedef` with a simple fundamental underlying type                      
                   (`typedef Tag = int`).                                                                       |
| RESOURCE       | Resource element type for storing data in the world that has only one instance, singleton.    
                   Must be defined as a struct or `typedef` custom type. Resources are not entities without      
                   components as in other ECS, they have own storage and methods.                               |
| SYSTEM         | System element type for running actions at each step of the world progress.                  |

You must register world elements before running the world.
```odin
import ecs "moecs/src"

main :: proc() {
  ecs.init()
  world := ecs.new_world()

  /* Register components */
  ecs.register(world, .COMPONENT, Position)
  ecs.register(world, .COMPONENT, Rotation)
  /* Register resources. */
  ecs.register(world, .RESOURCE, GameState)
  ecs.register(world, .RESOURCE, Sprites)
  /* Register tags. */
  ecs.register(world, .TAG, Player)
  ecs.register(world, .TAG, Asteroid)

  ecs.destroy()
}

```
| Procedure      | Description                                                                                  |
|----------------|----------------------------------------------------------------------------------------------|
| register()     | Registers element type for the world.                                                        |

[![Hits](https://hits.sh/sr.ht/~modevstudio/moecs.svg)](https://hits.sh/sr.ht/~modevstudio/moecs/)
