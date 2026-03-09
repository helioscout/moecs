This is my modest attempt at creating an ECS (Entity Component System).

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
This constants defines a number of entity records (entity struct and its component chunk) that will be stored in one memory block. When block is full the memory allocation occurs for the next block.\
\
There is no limitations of entities count, but for resource, components, and tags:
- MAX_RESOURCES_COUNT: Maximum resources count available for adding to the world.
- MAX_COMPONENTS_COUNT: Maximum components count available for adding to entity;
- MAX_TAGS_COUNT: Maximum tags count available for adding to entity.

### Setup
Clone moecs repository into your project or nearby and import `src` forlder.
```odin
import ecs "moecs/src"

main :: proc() { /* ... */ }
```

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
| COMPONENT      | Component element type (`Position`, `Mass`, `Velocity`). Must be defined as a struct or distinct custom type. |
| TAG            | Tag element type for marking entities with some kind of characteristic. Must be defined as a `typedef` with a simple fundamental underlying type (`typedef Tag = int`). |
| RESOURCE       | Resource element type for storing data in the world that has only one instance, singleton. Must be defined as a struct or `typedef` custom type. Resources are not entities without components as in other ECS, they have own storage and methods. |
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

### Mutability and deferred actions
There are methods for getting resources and components: `get()` and `get_mut()`. Use `get_mut()` only if you need to modify at least one instance of receiving resource/component types, otherwise use `get()` - it is little bit faster. Also use overloaded procedures to get a bunch of elements by one procedure call, the same is true for setting values with `set()` procedure. Bunch methods gives you more performance because use less memory read/write operations.\
\
When you `despawn` entities, these actions will be deferred. We need to keep entities in the archetypes till end of the current progress step, otherwise iterators inside systems code can lead to bugs, as they iterate over collections of the archetypes which we need to delete entities from. Entities will be marked as `DESPAWNING` but despawned (deleted from the block) at performing stage. Also, a new entity can be written in place of a deleted entity, then bugs are inevitable since the reference to the deleted entity will continue to be stored in the archetype collection.\
\
When you `add`/`remove` a component, or `set`/`unset` a tag they will still present in current archetypes till end of the current progress step. When `tags`/`components` is being `added`/`removed` to the entity and world is already running, entities should not be moved to other archetypes till end of the current progress step, so this archetyping action is deferred to the perform stage.\
\
This means that changes will will be applied only at the next world progress step.\
But **setting values to resource/components is being applied immediately** (is not deferred).

### Resources
Resources are data structures that you only need one instance of and represent game state, sprites (textures), physics parameters, etc. You need to `register` their types and `set` their values before `getting` them. You can add a number of resources that is less or equals `MAX_RESOURCES_COUNT`, if you need more, please, change this constant manually. You must `run` the world before setting values to resources.
```odin
import ecs "moecs/src"
import b2 "vendor:box2d"

main :: proc() {
  ecs.init()
  world := ecs.new_world()

  /* ...register resource types. */

  /* You should run the world before meking changes to it. */
  ecs.run(world)

  /* Sets resource value (will be copied into storage). */
  ecs.set(world, GameState, &GameState {
    screen     = .Playing,
    fullscreen = false,
    zoom       = 1.0,
    scaled     = time.now()
	})

  /* Gets resource values (making a copy from storage). */
  state, sprites := ecs.get(world, GameState, Sprites)
  /* Gets pointer to resource value (mutable). */
  physics := ecs.get_mut(world, Physics)

  world_def := b2.DefaultWorldDef()
  world_def.gravity = { 0.0, 0.0 }
  /* Mutating resource value (by pointer/in place). */
  physics.world_id = b2.CreateWorld(world_def)

  ecs.destroy()
}
```
| Procedure          | Description                                                                              |
|--------------------|------------------------------------------------------------------------------------------|
| set_resource()     | Sets **one** resource value by its type.                                                 |
| get_resource()     | Gets **one** resource value by its type.                                                 |
| get_resource_mut() | Gets reference (pointer) to **one** resource value by its type.                          |
| set()              | Sets a bunch of resource values (*recommended*).                                         |
| get()              | Gets a bunch of resource values (*recommended*).                                         |
| get_mut()          | Gets a bunch of pointers to resources for changing resource fields (*recommended*).      |

### Entities
Entities are the main elements of the world. It is the abstract data structure that can be specified by components and tags. Entity is not just an id and has some fields, but you should not care about them and use procedures to work with it. Internally there are bit-set fields which define what components and/or tags the entity has. Thus, when deleting a component and adding/removing a tag, reading/writing to memory does not occur.\
\
When you despawn an entity this action is deferred to the end of the current progress step, so if you want to omit such entities in the current progress step (game frame) use `despawning` procedure to check that state. Also you may want to check that entity is really despawned if you have a pointer to it from previous progress steps, then use `deleted` procedure.\
\
All entities have a lifetime (`.DYNAMIC` or `.STATIC`). But you'll not find this data in the entity itself, it is only defined in the memory block the entity belongs to and once entity was spawned its lifetime can't be changed.
```odin
import ecs "moecs/src"

main :: proc() {
  ecs.init()
  world := ecs.new_world()
  ecs.run(world)

  /* Spawns static entity. */
  asteroid: ^ecs.Entity = ecs.spawn(world, .STATIC)
  /* Spawns dynamic entity (.DYNAMIC lifetime is default). */
  ship := ecs.spawn(world)

  ecs.destroy()
}
```
| Procedure          | Description                                                                              |
|--------------------|------------------------------------------------------------------------------------------|
| spawn()            | Spawns **one** new entity into the world.                                                |
| despawn_entity()   | Despawns **one** entity from the world.                                                  |
| despawn_entities() | Despawns **several** entities from the world.                                            |
| despawn()          | Overloaded procedure for despawning one or several entities (*recommended*).             |
| despawning()       | Checks if the entity is deferred for despawning at the perform stage.                    |
| deleted()          | Checks if the entity has been fully deleted (despawned).                                 |
| is_dynamic()       | Checks if the entity belongs to dynamic lifetime block.                                  |
| is_static()        | Checks if the entity belongs to static lifetime block.                                   |

### Components 
Components are stored in the chunks of a block, internally it is continuous block of memory reading/writing to which is implemented with pointer math. We know entity index, components size and block size (`DYNAMIC_CHUNK_SIZE`, `STATIC_CHUNK_SIZE`), so access by pointer is pretty simple.\
\
Entity may has a number of components that less or equals `MAX_COMPONENTS_COUNT` constant. By default it equals `128` and if you need more, please, change the value of this constant manually.\
\
Component types must be registered before using in the ecs and world should run before you start adding components.\
\
When you add components or set values to previously added components, the changes are stored in the memory immediately and you can read these values at the same world progress step, there are no caching at all. But `adding`/`removing` components defer archetypes re-binding (archetyping) till the `perform` stage, so your systems match queries will consider them only on the next progress step.\
\
The presence of certain components in an entity is determined by bit flags in a special field of the entity structure. Removing a component from an entity does not cause any memory access, but simply sets the corresponding bit. Reading this bit applies to checking for the presence of a component in an entity.\
\
Prefer using overloaded procedures to `add`/`set`/`get` a bunch of components by one procedure call. Bunch methods gives you more performance because use less memory read/write operations.
```odin
import ecs "moecs/src"

main :: proc() {
  ecs.init()
  world := ecs.new_world()
  /* ...register component types here. */
  ecs.run(world)

  ship := ecs.spawn(world)

  /* Adds components to the entity. */
  ecs.add(ship,
    Position, &Position { x = 350, y = 170 },
    Rotation, &Rotation { angle = 90 },
    Velocity, &Velocity { 50 },
    Weapon,   &Weapon   { kind = .Rocket })

  /* Getting one component (mutable method). */
  if weapon, ok := ecs.get_mut(ship, Weapon); ok {
    weapon.kind = .Bullet
  }

  /* Setting values of previously added components. */
  ecs.set(ship,
    Position, &Position { x = 700, y = 900 },
    Rotation, &Rotation { angle = 180 })

  /* Getting several compoents (for reading, making a copy from storage). */
  pos, rot := ecs.get(ship, Position, Rotation)
  /* Getting pointers to component values (mutable method). */
  vel, weapon := ecs.get_mut(ship, Velocity, Weapon)

  /* Removes components from the entity. */
  ecs.remove(ship, Position, Rotation)

  /* Checks if the entity has a component. */
  if ecs.has(ship, Position) {
    ecs.set(ship, Position, &Position { x = 0, y = 0 })
  }

  ecs.destroy()
}
```
| Procedure          | Description                                                                              |
|--------------------|------------------------------------------------------------------------------------------|
| add_component()    | Adds **one** component to the entity by type and instance (initializer).                 |
| set_component()    | Sets **one** previously added component value.                                           |
| get_component()    | Gets **one** component value by its type (copy from storage).                            |
| get_component_mut()| Gets reference to **one** component value by its type.                                   |
| remove_component() | Removes **one** component from entity by its type.                                       |
| remove_components()| Removes **several** components from entity of all passed types.                          |
| has_component()    | Checks if the entity has a component.                                                    |
| has_components()   | Checks if the entity has all components of passed types.                                 |
| add()              | Adds a bunch of components (*recommended*).                                              |
| set()              | Sets a bunch of components (*recommended*).                                              |
| get()              | Gets a bunch of components (*recommended*).                                              |
| get_mut()          | Gets a bunch of pointers to components for changing its values (*recommended*).          |
| remove()           | Removes any number of components by their types (*recommended*).                         |
| has()              | Checks for presence of any number of components by their types (*recommended*).          |

### Tags
Tags are just attributes (signs) that can be `set`/`unset` for entities. Just like components, an entity has a special bit field, in which each bit corresponds to a tag. However, unlike components, tags are not stored in memory chunks. Adding/removing a tag simply means setting the corresponding bit in the entity field.\
\
Entity may has a number of tags that less or equals `MAX_TAGS_COUNT` constant. By default it equals `128` and if you need more, please, change the value of this constant manually. Tags types must be registered before adding to entities.\
\
Settings/unsetting tags defer entity archetypes re-binding (archetyping) till the `perform` stage, so your systems match queries will consider these tags changes only on the next progress step.
```odin
main :: proc() {
  ecs.init()
  world := ecs.new_world()
  /* ...register tags and components types here. */
  ecs.run(world)

  entity := ecs.spawn(world)
  /* Tags entity as a Player. */
  ecs.tag(entity, Player)

  entity = ecs.spawn(world)
  /* Tags entity as a Ship. */
  ecs.tag(entity, Ship, Sleep)
  /* Entity is sleeping. */
  ecs.tag(entity, Sleep)

	ecs.each(world, callback = proc(entity: ^ecs.Entity, lifetime: ecs.Lifetime, world: ^ecs.World) {
    /* Checks if entity has Player tag. */
    if ecs.tagged(entity, Player) {
      ecs.add(entity, Actions, &Actions {})
    } else {
      /* Remove tag from entity (unset corresponding bit). */
      ecs.untag(entity, Sleep)
    }
  })

  ecs.destroy()
}
```
| Procedure          | Description                                                                              |
|--------------------|------------------------------------------------------------------------------------------|
| set_tag()          | Tags entity with **one** specified tag type.                                             |
| set_tags()         | Tags entity with **several** passed tag types.                                           |
| unset_tag()        | Removes **one** tag from entity (unset corresponding bit in entity's marker field).      |
| unset_tags()       | Removes **several** tags from entity of all passed types.                                |
| has_tag()          | Checks if the entity is tagged with specified tag type.                                  |
| has_tags()         | Checks if the entity is tagged with all passed tag types.                                |
| tag()              | Tags entity with a bunch of tag types (*recommended*).                                   |
| untag()            | Removes a bunch of tags from the entity (*recommended*).                                 |
| tagged()           | Checks if the entity is tagged with a bunch of tag types (*recommended*).                |



[![Hits](https://hits.sh/sr.ht/~modevstudio/moecs.svg)](https://hits.sh/sr.ht/~modevstudio/moecs/)
