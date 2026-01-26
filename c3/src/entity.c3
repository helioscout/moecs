module moecs;

import std::io;

<* Entity type. *>
struct Entity {
	<* Entity state. *>
	ElementState state;
	<* Components marker, each set bit specifies that the component exists in the entity. *>
	ComponentsMarker components;
	<* Tags marker, each set bit specifies that the tag exists in the entity. *>
	TagsMarker tags;
	
	union {
		<* Reference to the parent block interface. Use only if stae has not BUFFERED flag. *>
		BlockGene block;
		<* Reference to the parent world.
		   If active (state has BUFFERED flag) than entity is in the quick lifetime buffer, not a real block. *>
		World* world;
	}
	
	<* The index of the entity in the collection (chunk index for its components). *>
	usz chunk_idx;
	<* Archetype reference which entity belongs to. Is nill for entities without components/tags. *>
	Archetype* archetype;
}

<* Adds component to the entity by type and initializer.
   If entity already has a component it will be replaced by new one.
   @param $Type : "Component type."
   @param #init : "Component initialization block."
   @param $perform : "Perform archetyping of the entity. You should not change this parameter (inner logic)."
   @return "Pointer to the entity."
*>
macro Entity* Entity.@add(&self, $Type, #init, bool $perform = true) {
	if (try idx = self.get_world().components.index($Type.typeid)) {
		self.@set($Type, #init);			/* Storing value in the chunk. */
		self.components.set(idx);			/* Setting marker bit.		   */
		if ($perform) self.archetyping();
	}

	return self;
}

<* Sets component value in the entity by its type and initializer.
   @param $Type : "Component type."
   @param #init : "Component initialization block."
   @return "Pointer to the entity."
*>
macro Entity* Entity.@set(&self, $Type, #init) {
	if (try component = self.get_world().components.get($Type.typeid)) {
		if (self.state & ElementState.BUFFERED) {
			$Type[QUICK_CHUNK_SIZE]* chunk = ($Type[QUICK_CHUNK_SIZE]*)component.buffer;
			(*chunk)[self.chunk_idx] = #init;
		} else {
			switch (self.block.get_lifetime()) {
				case QUICK: {
					$Type[QUICK_CHUNK_SIZE]* chunk = ($Type[QUICK_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
					(*chunk)[self.chunk_idx] = #init;
				}

				case DYNAMIC: {
					$Type[DYNAMIC_CHUNK_SIZE]* chunk = ($Type[DYNAMIC_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
					(*chunk)[self.chunk_idx] = #init;
				}

				case STATIC: {
					$Type[STATIC_CHUNK_SIZE]* chunk = ($Type[STATIC_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
					(*chunk)[self.chunk_idx] = #init;
				}
			}
		}
	}
	
	return self;
}

<* Add component to the entity by its instance. If entity already has a component it will be replaced by new one.
   @param $component : "Component instance."
   @param $perform : "Perform archetyping of the entity. You should not change this parameter (inner logic)."
   @return "Pointer to the entity."
*>
macro Entity* Entity.add(&self, $component, bool $perform = true) {
	if (try idx = self.get_world().components.index($typeof($component).typeid)) {
		self.set($component);				/* Storing value in the chunk. */
		self.components.set(idx);			/* Setting marker bit.		   */
		if ($perform) self.archetyping();
	}

	return self;
}

<* Sets component in the entity by its instance.
   @param $component : "Component instance."
   @return "Pointer to the entity."
*>
macro Entity* Entity.set(&self, $component) {
	if (try component = self.get_world().components.get($typeof($component).typeid)) {
		if (self.state & ElementState.BUFFERED) {
			$typeof($component)[QUICK_CHUNK_SIZE]* chunk = ($typeof($component)[QUICK_CHUNK_SIZE]*)component.buffer;
			(*chunk)[self.chunk_idx] = $component;
		} else {
			switch (self.block.get_lifetime()) {
				case QUICK: {
					$typeof($component)[QUICK_CHUNK_SIZE]* chunk =
						($typeof($component)[QUICK_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
					(*chunk)[self.chunk_idx] = $component;
				}

				case DYNAMIC: {
					$typeof($component)[DYNAMIC_CHUNK_SIZE]* chunk =
						($typeof($component)[DYNAMIC_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
					(*chunk)[self.chunk_idx] = $component;
				}

				case STATIC: {
					$typeof($component)[STATIC_CHUNK_SIZE]* chunk =
						($typeof($component)[STATIC_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
					(*chunk)[self.chunk_idx] = $component;
				}
			}
		}
	}
	
	return self;
}

<* Gets reference to the component value by its type.
   @param $Type : "Component type."
   @return "Pointer to the component."
   @return? NOT_FOUND : "Component was not found (added)."
*>
macro void*? Entity.get(&self, $Type) {
	if (try component = self.get_world().components.get($Type.typeid)) {
		if (self.components.get(component.idx)) {
			if (self.state & ElementState.BUFFERED) {
				$Type[QUICK_CHUNK_SIZE]* chunk = ($Type[QUICK_CHUNK_SIZE]*)component.buffer;
				return &(*chunk)[self.chunk_idx];
			} else {
				switch (self.block.get_lifetime()) {
					case QUICK: {
						$Type[QUICK_CHUNK_SIZE]* chunk = ($Type[QUICK_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
						return &(*chunk)[self.chunk_idx];
					}

					case DYNAMIC: {
						$Type[DYNAMIC_CHUNK_SIZE]* chunk = ($Type[DYNAMIC_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
						return &(*chunk)[self.chunk_idx];
					}

					case STATIC: {
						$Type[STATIC_CHUNK_SIZE]* chunk = ($Type[STATIC_CHUNK_SIZE]*)self.block.get_chunk(component.idx);
						return &(*chunk)[self.chunk_idx];
					}
				}
			}
		}
	}

	return NOT_FOUND?;
}

<* Gets references to all components of passed types.
   @param allocator : "Allocator for returning slice underlying array."
   @require $vacount > 0 : "You must pass at least one component type. To get references to all components use all() method instead."
   @return "Slice of any with pointers to component values."
*>
macro any[] Entity.get_all(&self, Allocator allocator, ...) {
	any[$vacount]* values = (any[$vacount]*)allocator::malloc(allocator, any.sizeof * $vacount);
	usz idx = 0;	/* We need to know amount of really found component values. */

	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		
		$if $Type.kindof == TypeKind.STRUCT || $Type.kindof == TypeKind.DISTINCT:
			if (try $Type* value = self.get($Type)) {
				(*values)[idx++] = value;
			}
		$endif
	$endfor
	
	/* If there are no components found, return empty slice. */
	return idx == 0 ? {} : (*values)[:idx];
}

<* Gets references to all components of passed types. Alocates using temporary allocator.
   Consider call this function inside @pool() { ... }; marco.
   @return "Slice of any with pointers to component values."
*>
macro any[] Entity.tget_all(&self, ...) => self.get_all(tmem, $vasplat);

<* Gets references to all components set in the entity.
   @param allocator : "Allocator for returning slice underlying array."
   @return "Slice of any with pointers to all component values."
*>
fn any[] Entity.all(&self, Allocator allocator) {
	World* world = self.get_world();
	ComponentPointers values;

	for (usz idx = 0; idx < world.components.count; idx++) {
		Component component = world.components.types[idx];
		
		if (self.components.get(idx)) {
			void* ptr;

			if (self.state & ElementState.BUFFERED) {
				ptr = (char*)component.buffer + component.size * self.chunk_idx;
			} else {
				char* chunk = self.block.get_chunk(idx);
				/* If entity is not BUFFERED than it is DYNAMIC or STATIC (not QUICK), */
				/* so we can just get pointer of the block and do math with it.		   */
				ptr = chunk + component.size * self.chunk_idx;
			}

			if (ptr != null) values.push(any_make(ptr, component.type));
		}
	};

	return values.to_array(allocator);
}

<* Gets references to all components set in the entity. Alocates using temporary allocator.
   Consider call this function inside @pool() { ... }; marco.
   @return "Slice of any with pointers to all component values."
*>
fn any[] Entity.tall(&self) => self.all(tmem);

<* Step through each component of the entity. Does not make any additional allocations.
   @param type : "Type (typeid) of the component."
   @param ptr : "Pointer to the component value."
*>
macro Entity.@each(&self; @body(type, ptr)) {
	/* If entity has no components, return. */
	if (self.components.cardinality() == 0) return;

	World* world = self.get_world();

	for (usz idx = 0; idx < world.components.count; idx++) {
		Component component = world.components.types[idx];

		if (self.components.get(idx)) {
			void* ptr;

			if (self.state & ElementState.BUFFERED) {
				ptr = (char*)component.buffer + component.size * self.chunk_idx;
			} else {
				char* chunk = self.block.get_chunk(idx);
				ptr = chunk + component.size * self.chunk_idx;
			}

			if (ptr != null) @body(component.type, ptr);
		}
	};
}

<* Removes component from entity by its type.
   @param type : "Component type id."
   @param perform : "Perform archetyping of the entity. You should not change this parameter (inner logic)."
*>
fn void Entity.remove(&self, typeid type, bool perform = true) {
	if (try idx = self.get_world().components.index(type)) {
		self.components.unset(idx);
		if (perform) self.archetyping();
	}
}

<* Removes components from entity of all passed types.
   @require $vacount > 0 : "You must pass at least one component type."
*>
macro void Entity.remove_all(&self, ...) {
	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		self.remove($Type.typeid, false);
	$endfor

	self.archetyping();
}

<* Checks if the enity has a component.
   @param $Type : "Component type."
   @return "True if entity has a component, otherwise - false."
*>
macro bool Entity.has(&self, $Type) {
	if (try idx = self.get_world().components.index($Type.typeid)) {
		return self.components.get(idx);
	} else {
		return false;
	}
}

<* Checks if the entity has all components of passed types.
   @param types : "Component types."
   @return "True if entity has all components, otherwise - false."
*>
fn bool Entity.has_all(&self, typeid... types) {
	World* world = self.get_world();
	bool has = true;
	
	foreach (type : types) {
		if (try idx = world.components.index(type)) {
			has = has && self.components.get(idx);
		} else {
			has = false;
		}
	}

	return has;
}

<* Tags entity with specified tag type.
   @param type : "Tag type id."
   @param perform : "Perform archetyping of the entity. You should not change this parameter (inner logic)."
*>
fn void Entity.tag(&self, typeid type, bool perform = true) {
	if (try idx = self.get_world().tags.index(type)) {
		self.tags.set(idx);
		if (perform) self.archetyping();
	}
}

<* Tags entity with all passed tag types.
   @require $vacount > 0 : "You must pass at least one tag type."
*>
macro void Entity.tag_all(&self, ...) {
	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		self.tag($Type.typeid, false);
	$endfor

	self.archetyping();
}

<* Removes tag from entity.
   @param type : "Tag type id."
   @param perform : "Perform archetyping of the entity. You should not change this parameter (inner logic)."
*>
fn void Entity.untag(&self, typeid type, bool perform = true) {
	if (try idx = self.get_world().tags.index(type)) {
		self.tags.unset(idx);
		if (perform) self.archetyping();
	}
}

<* Removes tags from entity of all passed types.
   @require $vacount > 0 : "You must pass at least one tag type."
*>
macro void Entity.untag_all(&self, ...) {
	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		self.untag($Type.typeid, false);
	$endfor

	self.archetyping();
}

<* Checks if the entity is tagged with specified tag type.
   @param type : "Tag type id."
   @return "True if the entity has tag, otherwise - false."
*>
fn bool Entity.tagged(&self, typeid type) {
	if (try idx = self.get_world().tags.index(type)) {
		return self.tags.get(idx);
	} else {
		return false;
	}
}

<* Checks if the entity is tagged with all passed tag types.
   @param types : "Tag types."
   @return "True if entity is tagged with all types, otherwise - false."
*>
fn bool Entity.tagged_all(&self, typeid... types) {
	World* world = self.get_world();
	bool tagged = true;
	
	foreach (type : types) {
		if (try idx = world.tags.index(type)) {
			tagged = tagged && self.tags.get(idx);
		} else {
			tagged = false;
		}
	}

	return tagged;
}

<* Despawns entity. *>
fn void Entity.despawn(&self) {
	if (self.deleted()) return;
	
	if (self.state & ElementState.BUFFERED) {
		self.world.despawn(self);
	} else {
		World* world = self.block.get_world();

		if (world.approach == ARCHETYPE && world.running && !world.performing) {
			world.deffered.despawning.push(self);
		} else {
			self.block.delete(self.chunk_idx);
		}

		self.state |= ElementState.DELETED;
	}
}

<* Checks if the entity has been deleted.
   @return "True if entity is deleted, otherwise - false."
*>
fn bool Entity.deleted(&self) @inline => self.state & ElementState.DELETED != 0;

<* Gets parent world reference.
   @return "Reference to the world."
*>
fn World* Entity.get_world(&self) @inline @local {
	return self.state & ElementState.BUFFERED ? self.world : self.block.get_world();
}

<* Bind the entity to appropriate archetype. *>
fn void Entity.archetyping(&self) @private {
	World* world = self.get_world();

	if (world.approach != ARCHETYPE) return;

	if (world.running && !world.performing) {
		if (self.state & ElementState.ARCHETYPING == 0) {
			world.deffered.archetyping.push(self);
			self.state |= ElementState.ARCHETYPING;
		}

		return;
	}

	if (self.archetype != null) self.archetype.entities.remove_item(self);

	if (self.components.cardinality() == 0 && self.tags.cardinality() == 0) {
		/* If entity has no components and no tags, clear reference to archetype. */
		self.archetype = null;
	} else {
		/* Find appropriate archetype or new one. */
		Archetype* archetype = world.get_archetype(self.components, self.tags);

		archetype.entities.push(self);
		self.archetype = archetype;
	}
}
