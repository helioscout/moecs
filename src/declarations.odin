package moecs

/* Size (items count) of the one components chunk or entities collection for each block.
   Bigger chunk size increase productivity of entities adding, less chunk size can save a bit of memory. */

/* Dynamic lifetime chunk size. */
DYNAMIC_CHUNK_SIZE : int : 500
/* Static lifetime chunk size. */
STATIC_CHUNK_SIZE  : int : 300
/* Bytes buffer size used for reading/writing components.
   Must be not less that total size of all registered components. */
STACK_BUFFER_SIZE : int : 16 * 1024

/* Maximum components count available for adding to entity. */
MAX_COMPONENTS_COUNT : int : 128
/* Maximum tags count available for adding to entity. */
MAX_TAGS_COUNT       : int : 128
/* Maximum resources count available for adding to the world. */
MAX_RESOURCES_COUNT  : int : 128

/* Count of bits in one marker word (element of marker array). */
@(private) MARKER_BITS_COUNT : uint : size_of(uint) * 8
/* Size of components marker (array of bitset). */
@(private) COMPONENTS_MARKER_SIZE : uint : (uint(MAX_COMPONENTS_COUNT) + MARKER_BITS_COUNT - 1) / MARKER_BITS_COUNT
/* Size of tags marker (array of bitset). */
@(private) TAGS_MARKER_SIZE : uint : (uint(MAX_TAGS_COUNT) + MARKER_BITS_COUNT - 1) / MARKER_BITS_COUNT

/* Entities/blocks lifetime. */
Lifetime :: enum u8 {
	/* Entities whose lifespan is not defined or determined in advance (from one frame to app exit).
	   Such blocks will reuse freed after deletion rows to insert new entities. */
	DYNAMIC = 0b00000001,
	/* Immortal entities that will exist until the end of the application.
	   Such blocks are simply created when necessary, since entities cannot be despawn. */
	STATIC  = 0b00000010
}

/* Kinds of elements that the world can consist of. */
Element :: enum {
	/* Component element type (Position, Mass, Velocity).
	   Must be defined as a struct or distinct custom type. */
	COMPONENT,
	/* Tag element type for marking entities with some kind of characteristic.
	   Must be defined as a typedef with a simple fundamental underlying type (typedef Tag = int). */
	TAG,
	/* Resource element type for storing data in the world that has only one instance, singleton.
	   Must be defined as a struct or typedef custom type. Resources are not entities without components
	   as in other ECS, they have own storage and methods. */
	RESOURCE,
	/* System element type for running actions at each step of the world progress. */
	SYSTEM
}

/* The state flags for an element (entity or system). */
ElementState :: enum {
	/* Entity has been deleted. */
	DELETED,
	/* System is enabled. */
	ENABLED,
	/* System has tags in the match query. */
	HAS_TAGS,
	/* System has components in the match query. */
	HAS_COMPONENTS,
	/* System has excluding tags condition in the match query. */
	HAS_WITHOUT_TAGS,
	/* System has excluding components condition in the match query. */
	HAS_WITHOUT_COMPONENTS,
	/* Indicates that a system is task, has no components or tags in match query. */
	IS_TASK,
	/* Entity should be re-archetyped at deferred (perform) stage. */
	ARCHETYPING,
	/* Entity should be despawned at deferred (perform) stage. */
	DESPAWNING
}

/* Query match approach of selection entities for the systems. */
Approach :: enum {
	/* Using this approach at each progress step all world entities will be iterated
	   with applying match conditions to select them for each running system.
	   First, iterates through all entities in the world for which the match condition is checked,
	   and if the entity matches, it is added to the system's collection of entities.
	   Then, all systems to which the generated collections are passed are executed in turn.
	   At the beginning of progress each step, these collections are cleared.
	   This is a very inefficient method, but it does not involve deferred actions. */
	ITERATION,
	/* Each entity belongs to some unique archetype that is combination of bit flags
	   that represent entity's components/tags configuration. At each world progress step
	   all archetypes will be iterated with applying match condition of each system.
	   If an archetype matches the system query conditions, the system is launched with a list
	   of entities of that archetype. This is an effective approach, but it requires deferred actions.
	   The system callback will be invoked for each matching archetype. */
	ARCHETYPE
}

/* System running phase, determine when system should run during pipeline. */
Phase :: enum u8 {
	/* System will run once at the beginning of the first progress step. */
	START       = 1,
	/* System will run before update phase. */
	PRE_UPDATE  = 2,
	/* Main phase of each progress step. */
	UPDATE      = 0,
	/* System will run after update phase. */
	POST_UPDATE = 3,
	/* System can be executed only manually using its name, excluded from progress pipeline. */
	MANUAL      = 4
}

/* Systems collections for each running phase. */
@(private) Schedule :: struct {
	/* Systems that are being ran at the start phase. */
	start		: [dynamic]^System,
	/* Systems that are being ran at the pre-update phase. */
	pre_update	: [dynamic]^System,
	/* Systems that are being ran at the update phase. */
	update		: [dynamic]^System,
	/* Systems that are being ran at the post-update phase. */
	post_update : [dynamic]^System
}

/* Deferred actions for the world. */
@(private) Deferred :: struct {
	/* Despawning entities. We need to keep them in the archetypes till end of the current progress step,
	   otherwise iterators inside systems code can lead to bugs, as they iterate over collections of
	   the archetypes which we need to delete entities from. Entities will be marked as DESPAWNING but
	   despawned (deleted from the block) at performing stage. Also, a new entity can be written in place
	   of a deleted entity, then bugs are inevitable since the reference to the deleted entity will
	   continue to be stored in the archetype collection. */
	despawning : [dynamic]^Entity,
	/* When tags/components is being added/removed to the entity and world is already running,
	   entities should not be moved to other archetypes till end of the current progress step,
	   so this archetyping action is deferred to the perform stage. */
	archetyping : [dynamic]^Entity
}

/* Entities iterator. */
@(private) EntitiesIterator :: struct {
	/* Current entity index. */
	idx : int,
	/* Current entity pointer. */
	entity : ^Entity
}

/* Callback procedure for entities iteration.
   `entity`   : Pointer to the current entity.
   `lifetime` : Current lifetime.
   `world`    : Pointer to the world. */
@(private) IteratorCallback :: proc(entity: ^Entity, lifetime: Lifetime, world: ^World)

/* Callback function for the system.
   `entities` : Matched entities for the system.
   `world`    : Pointer to the world. */
SystemCallback :: proc(entities: ^[dynamic]^Entity, world: ^World)

add :: proc {
	add_component,
	add_2_components,
	add_3_components,
	add_4_components,
	add_5_components,
	add_6_components,
	add_7_components,
	add_8_components,
	add_9_components,
	add_10_components,
	add_11_components,
	add_12_components,
	add_13_components
}

set :: proc {
	set_component,
	set_resource,
	set_2_components,
	set_3_components,
	set_4_components,
	set_5_components,
	set_6_components,
	set_7_components,
	set_8_components,
	set_9_components,
	set_10_components,
	set_11_components,
	set_12_components,
	set_13_components,
	set_2_resources,
	set_3_resources,
	set_4_resources,
	set_5_resources,
	set_6_resources,
	set_7_resources,
	set_8_resources,
	set_9_resources,
	set_10_resources,
	set_11_resources,
	set_12_resources,
	set_13_resources
}

get :: proc {
	get_component,
	get_resource,
	get_system,
	get_2_components,
	get_3_components,
	get_4_components,
	get_5_components,
	get_6_components,
	get_7_components,
	get_8_components,
	get_9_components,
	get_10_components,
	get_11_components,
	get_12_components,
	get_13_components,
	get_2_resources,
	get_3_resources,
	get_4_resources,
	get_5_resources,
	get_6_resources,
	get_7_resources,
	get_8_resources,
	get_9_resources,
	get_10_resources,
	get_11_resources,
	get_12_resources,
	get_13_resources
}

get_mut :: proc {
	get_component_mut,
	get_resource_mut,
	get_2_components_mut,
	get_3_components_mut,
	get_4_components_mut,
	get_5_components_mut,
	get_6_components_mut,
	get_7_components_mut,
	get_8_components_mut,
	get_9_components_mut,
	get_10_components_mut,
	get_11_components_mut,
	get_12_components_mut,
	get_13_components_mut,
	get_2_resources_mut,
	get_3_resources_mut,
	get_4_resources_mut,
	get_5_resources_mut,
	get_6_resources_mut,
	get_7_resources_mut,
	get_8_resources_mut,
	get_9_resources_mut,
	get_10_resources_mut,
	get_11_resources_mut,
	get_12_resources_mut,
	get_13_resources_mut
}

remove :: proc {
	remove_component,
	remove_components
}

has :: proc {
	has_component,
	has_components,
	has_system
}

tag :: proc {
	set_tag,
	set_tags
}

untag :: proc {
	unset_tag,
	unset_tags
}

tagged :: proc {
	has_tag,
	has_tags
}

despawn :: proc {
	despawn_entity,
	despawn_entities
}
