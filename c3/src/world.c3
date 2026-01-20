module moecs;

import std::collections::elastic_array;
import moecs::block;
import std::io;

<* Indexes type for deleted rows in buffered chunks. *>
alias BufferedIndexes = ElasticArray { usz, QUICK_CHUNK_SIZE };

<* World type, main container of the sapce. The world is built of blocks. *>
struct World {
	<* Registered component types. *>
	Components components;
	<* Registered tag types. *>
	Tags tags;
	<* Registered resource types with its instances (values).
	   Collection of all world resources. *>
	Resources resources;
	<* Mounted systems. *>
	Systems systems;
	<* Blocks for entities with quick lifetime. *>
	QuickBlocks quicks;
	<* Blocks for entities with dynamic lifetime. *>
	DynamicBlocks dynamics;
	<* Blocks for entities with static lifetime. *>
	StaticBlocks statics;
	<* Defines that world uses quick lifetime (default: true).
	   If at least one component is registered without a buffer it will be set to false.
	   If disabled than all attempts to create quick lifetime entites will fail. *>
	bool use_quicks;
	<* Buffer for quick life time entities, must be provided from the main app. *>
	Entity[QUICK_CHUNK_SIZE]* buffer;
	<* Deleted (freed) rows in the quick lifetime buffer. *>
	BufferedIndexes deleted;
	<* Current inserting index in the quick lifetime buffer (last inserted index + 1). *>
	usz idx;
	<* Indicates that the world is running. *>
	bool running;
}

<* Gets world blocks count for specific (default: all) lifetimes.
   @param lifetime : "Blocks lifetime flag."
*>
fn usz World.size(&self, char lifetime = 0b00000111) {
	usz size;

	if (lifetime & Lifetime.QUICK)   size += self.quicks.size;
	if (lifetime & Lifetime.DYNAMIC) size += self.dynamics.size;
	if (lifetime & Lifetime.STATIC)  size += self.statics.size;
	
	return size;
}

<* Gets world blocks count for specific lifetimes (comma-separated arguments). *>
macro usz World.size_of(&self, ...) {
	char $lifetime;
	
	$for var $i = 0; $i < $vacount; $i++:
		$if @typeid($vaexpr[$i]) == Lifetime.typeid:
			$lifetime |= $vaexpr[$i];
		$endif
	$endfor

	return self.size($lifetime);
}

<* Initializes the world. *>
fn void World.init(&self) @private {
	self.components.init(mem);
	self.tags.init(mem);
	self.resources.init(mem);
	self.systems.init(mem);

	self.quicks.init(mem);
	self.dynamics.init(mem);
	self.statics.init(mem);
}

<* Registers element type for the world.
   @param element : "World element kind."
   @param $Type : "Element (component/tag/resource) type."
   @param buffer : "Pointer to buffer for quick lifetime chunk. Ensure that you don't use same buffers for different worlds."
   @require $Type.kindof == TypeKind.STRUCT || $Type.kindof == TypeKind.DISTINCT : "Element type is not valid."
   @require element != SYSTEM : "Systems should be registered with mount method."
   @require !(element == COMPONENT && self.components.has_key($Type.typeid)) : "Component already registered."
   @require !(element == TAG && self.tags.has_key($Type.typeid)) : "Tag already registered."
   @require !(element == RESOURCE && self.resources.has_key($Type.typeid)) : "Resource already registered."
   @require !(element != COMPONENT && buffer != null) : "You do not need a bufer for different from component element type."
   @require !(buffer != null && buffer.type != $Type[QUICK_CHUNK_SIZE].typeid) : "Buffer must have a type of array $Type[QUICK_CHUNK_SIZE]."
   @require !self.running : "You can't change already running world."
   @return "Pointer to the world for chain calls."
*>
macro World* World.register(&self, Element element, $Type, any buffer = null) {
	switch (element) {
		case COMPONENT:
			self.components.set($Type.typeid, { .type = $Type.typeid, .size = $Type.sizeof, .buffer = buffer,
				.idx = self.components.len() });
			/* We must disbale quick lifetime for this world when no buffer provided. */
			if (buffer == null) self.use_quicks = false;
		case TAG:
			self.tags.set($Type.typeid, { .type = $Type.typeid, .idx = self.tags.len() });
		case RESOURCE:
			self.resources.set($Type.typeid, { .type = $Type.typeid, .value = mem::new($Type, {}) });
		case SYSTEM: break;
	}

	return self;
}

<* Mounts new system to the world.
   @param definition : "System definition."
   @require !(definition.name && self.has_system(definition.name)) : "System with such name has already been mounted."
   @require !(definition.components.len == 0 && definition.tags.len == 0) : "Components or tags must be specified."
   @require definition.callback != null : "Callback must be provided."
   @require !self.running : "You can't change already running world."
   @return "Pointer to the world for chain calls."
*>
fn World* World.mount(&self, SystemDefinition definition) {
	System* system = mem::new(System, { .name = definition.name, .callback = definition.callback, .state = ENABLED,
					  .lifetime = definition.lifetime == 0 ? 0b00000111 : definition.lifetime });

	if (definition.components.len > 0) {
		foreach (type : definition.components) {
			if (try component = self.components.get_ref(type)) {
				system.components.set(component.idx);
			}
		}

		system.state |= ElementState.HAS_COMPONENTS;
	}

	if (definition.tags.len > 0) {
		foreach (type : definition.tags) {
			if (try tag = self.tags.get_ref(type)) {
				system.tags.set(tag.idx);
			}
		}

		system.state |= ElementState.HAS_TAGS;
	}

	system.entities.init(mem);
	self.systems.push(system);
	
	return self;
}

<* Unmounts the system from the world.
   @param name : "System name."
   @require name != "" : "Name can't be empty."
   @return "Pointer to the world for chain calls."
*>
fn World* World.unmount(&self, String name) {
	if (try system = self.get_system(name)) {
		self.systems.remove_item(system);
		system.entities.free();
	}
	
	return self;
}

<* Runs the world, but at first constructs all neccessary data from registered elements.
   World must has at least one registered component, but can has no tags, resources.
   @require !self.components.is_empty() : "The world has no registered components."
   @require !self.running : "The world is already running."
   @return "Pointer to the world for chain calls."
*>
fn World* World.run(&self) {
	self.running = true;

	return self;
}

<* Spawns new entity into the world.
   @param lifetime : "Entity lifetime (default: Lifetime.DYNAMIC)."
   @require !(lifetime == QUICK && !self.use_quicks) : "Quick lifetime was disabled, you should provide entity and components buffers."
   @return "Pointer to new entity."
*>
fn Entity* World.spawn(&self, Lifetime lifetime = DYNAMIC) {
	Entity* entity;

	switch (lifetime) {
		case QUICK: {
			if (self.deleted.is_empty() && self.idx == QUICK_CHUNK_SIZE) {
			    /* If buffers are full we must flush them to free quick block. */
				self.get_free_block(QUICK).absorb();
				/* And reset current inserting index. */
				self.idx = 0;
			}

			usz idx = self.pop_free_index();	/* Here we increase inserting index. */
			
			/* .state has BUFFERED is a sign that entity is in the quick lifetime buffer, not a real block.		  */
			/* But .chunk_idx will not change when flushed. We need assign world reference for access the buffer. */
			(*self.buffer)[idx] = { .state = BUFFERED, .world = self, .chunk_idx = idx };
			entity = &(*self.buffer)[idx];
		}
		
		case DYNAMIC:
		case STATIC: entity = self.get_sparse_block(lifetime).insert();
	}

	return entity;
}

<* Despawns entity from the world.
   @param entity : "Reference to the entity."
*>
fn void World.despawn(&self, Entity* entity) {
	if (entity.state & ElementState.BUFFERED) {
		self.deleted.push(entity.chunk_idx);
	} else {
		entity.block.delete(entity.chunk_idx);
	}

	entity.state |= ElementState.DELETED;
}

<* Creates new empty block in the world.
   @param lifetime : "Block lifetime."
   @return "Pointer to newly created block interface."
*>
fn BlockGene World.new(&self, Lifetime lifetime) @local {
	BlockGene block;

	switch (lifetime) {
		case QUICK:
			self.quicks.push(mem::new(QuickBlock, { .lifetime = QUICK, .world = self }));
			block = self.quicks.get(self.quicks.size - 1);
		case DYNAMIC:
			self.dynamics.push(mem::new(DynamicBlock, { .lifetime = DYNAMIC, .world = self }));
			block = self.dynamics.get(self.dynamics.size - 1);
		case STATIC:
			self.statics.push(mem::new(StaticBlock, { .lifetime = STATIC, .world = self }));
			block = self.statics.get(self.statics.size - 1);
	}

	block.init();

	return block;
}

<* Gets reference to the resource value by its type.
   @param $Type : "Resource type."
   @return "Pointer to the resource."
   @return? NOT_FOUND : "Resource was not found (registered)."
*>
macro void*? World.get(&self, $Type) {
	if (try resource = self.resources.get_ref($Type.typeid)) {
		return resource.value.ptr;
	}

	return NOT_FOUND?;
}

<* Sets resource value by its type and initializer.
   @param $Type : "Resource type."
   @param #init : "Resource initialization block."
   @return "Pointer to the world for chain calls."
*>
macro World* World.@set(&self, $Type, #init) {
	if (try resource = self.resources.get_ref($Type.typeid) &&
		try $Type* value = anycast(resource.value, $Type)) {
		*value = #init;
	}

	return self;
}

<* Sets resource value by its instance.
   @param $resource : "Resource instance."
   @return "Pointer to the world for chain calls."
*>
macro World* World.set(&self, $resource) {
	if (try resource = self.resources.get_ref($typeof($resource).typeid) &&
		try $typeof($resource)* value = anycast(resource.value, $typeof($resource))) {
		*value = $resource;
	}

	return self;
}

<* Step through each entity reference in the world.
   @param lifetime : "Entities lifetime flag."
*>
macro World.@each(&self, char lifetime = 0b00000111; @body(entity, lifetime)) {
	if (lifetime & Lifetime.QUICK && self.use_quicks) {
		/* Iterate entities in the buffer. */
		for (usz idx = 0; idx < self.idx; idx++) {
			if (!self.deleted.contains(idx)) {	/* Omit deleted entities. */
				@body(&(*self.buffer)[idx], Lifetime.QUICK);
			}
		}

		foreach (block : self.quicks) {
			EntitiesIterator iter = block.iter();

			while (block.next(&iter)) {
				@body(iter.entity, Lifetime.QUICK);
			}
		}
	}

	if (lifetime & Lifetime.DYNAMIC) {
		foreach (block : self.dynamics) {
			EntitiesIterator iter = block.iter();

			while (block.next(&iter)) {
				@body(iter.entity, Lifetime.DYNAMIC);
			}
		}
	}

	if (lifetime & Lifetime.STATIC) {
		foreach (block : self.statics) {
			EntitiesIterator iter = block.iter();

			while (block.next(&iter)) {
				@body(iter.entity, Lifetime.STATIC);
			}
		}
	}
}

<* Checks if system with specific name was mounted.
   @param name : "System name."
   @require name != "" : "Name can't be empty."
   @return "True if system exists, otherwise - false."
*>
fn bool World.has_system(&self, String name) {
	foreach (system : self.systems) {
		if (system.name == name) return true;
	}

	return false;
}

<* Gets reference to the system by its name.
   @param name : "System name."
   @require name != "" : "Name can't be empty."
   @return "Pointer to the system."
   @return? NOT_FOUND : "System was not found (mounted)."
*>
fn System*? World.get_system(&self, String name) {
	foreach (system : self.systems) {
		if (system.name == name) return system;
	}

	return NOT_FOUND?;
}

<* Progress one step of the world life.
   Runs all mounted systems. *>
fn void World.progress(&self) {
	/* Clear all systems entities collections. */
	foreach (system : self.systems) {
		if (system.enabled()) system.entities.clear();
	}
	
	self.@each(; Entity* entity, Lifetime lifetime) {
		foreach (system : self.systems) {
			if (system.enabled() &&						/* If system is enabled and                           */
				system.lifetime & lifetime) {			/* consider system lifetime.                          */
				if ((!system.has_tags() ||				/* If system query has no tags, or                    */
						system.tags						/* take system tags bits,                             */
							.and(entity.tags)			/* perform and (&) with entity tags bits              */
							.xor(system.tags)			/* and perform xor (^) with system tags bits.         */
							.cardinality() == 0) &&		/* Ensure that xor prove all system tags match.       */
					(!system.has_components() ||		/* If system query has no components, or              */
						system.components				/* take system components bits,                       */
							.and(entity.components)		/* perform and (&) with entity components bits        */
							.xor(system.components)		/* and perform xor (^) with system components bits.   */
							.cardinality() == 0)) {		/* Ensure that xor prove all system components match. */
					/* Add pointer to entity into system collection of entities for current system call.      */
					system.entities.push(entity);
				}
			}
		}
	};

	foreach (system : self.systems) {
		if (system.enabled()) system.callback(system.entities);
	}
}

<* Gets the reference to block interface that is available to insert new entities,
   has free rows or newly created one.
   @param lifetime : "Block lifetime."
   @require lifetime != QUICK : "Quick lifetime blocks can't be sparsed."
   @return "Pointer to available block interface."
*>
fn BlockGene World.get_sparse_block(&self, Lifetime lifetime) @inline @local {
	return self.find_block(lifetime, fn (b) => b.has_free_rows()) ?? self.new(lifetime);
}

<* Gets the reference to block interface that is totally free block.
   @param lifetime : "Block lifetime."
   @return "Pointer to free block interface."
*>
fn BlockGene World.get_free_block(&self, Lifetime lifetime) @inline @local {
	return self.find_block(lifetime, fn (b) => b.free()) ?? self.new(lifetime);
}

<* Finds a block using match predicate function.
   @param lifetime : "Block lifetime."
   @param match : "Predicate function for match blocks using their intefraces."
   @return "Pointer to block interface."
   @return? NOT_FOUND : "Block was not found."
*>
fn BlockGene? World.find_block(&self, Lifetime lifetime, BlockGeneMatch match) @private {
	switch (lifetime) {
		case QUICK:
			foreach (b : self.quicks) { if (match(b)) return b; }
		case DYNAMIC:
			foreach (b : self.dynamics) { if (match(b)) return b; }
		case STATIC:
			foreach (b : self.statics) { if (match(b)) return b; }
	}

	return NOT_FOUND?;
}

<* Returns index of the first free to insert (last deleted) row in the quick lifetime buffer.
   @require !(self.deleted.is_empty() && self.idx == QUICK_CHUNK_SIZE) : "The buffer is already full."
   @ensure return >= 0 && return < QUICK_CHUNK_SIZE : "Index can't be less then 0 and grater then QUICK_CHUNK_SIZE."
   @return "Index of the row to insert."
*>
fn usz World.pop_free_index(&self) @inline @local {
	return self.deleted.is_empty() ? self.idx++ : self.deleted.pop()!!;
}
