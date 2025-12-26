module moecs;

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
}

<* Adds component to the entity by type and initializer.
   If entity already has a component it will be replaced by new one.
   @param $Type : "Component type."
   @param #init : "Component initialization block."
   @return "Pointer to the entity."
*>
macro Entity* Entity.@add(&self, $Type, #init) {
	if (try component = self.get_world().components.get_ref($Type.typeid)) {
		self.@set($Type, #init);				/* Storing value in the chunk. */
		self.components.set(component.idx);		/* Setting marker bit.		   */
	}

	return self;
}

<* Sets component value in the entity by its type and initializer.
   @param $Type : "Component type."
   @param #init : "Component initialization block."
   @return "Pointer to the entity."
*>
macro Entity* Entity.@set(&self, $Type, #init) {
	if (self.state & ElementState.BUFFERED) {
		if (try component = self.world.components.get_ref($Type.typeid)) {
			$Type[QUICK_CHUNK_SIZE]* chunk = ($Type[QUICK_CHUNK_SIZE]*)component.buffer;
			(*chunk)[self.chunk_idx] = #init;
		}
	} else {
		switch (self.block.get_lifetime()) {
			case DYNAMIC: {
				if (try chunk = ($Type[DYNAMIC_CHUNK_SIZE]*)self.block.get_chunk($Type)) {
					(*chunk)[self.chunk_idx] = #init;
				}
			}

			case STATIC: {
				if (try chunk = ($Type[STATIC_CHUNK_SIZE]*)self.block.get_chunk($Type)) {
					(*chunk)[self.chunk_idx] = #init;
				}
			}
		}
	}
	
	return self;
}

<* Add component to the entity by its instance. If entity already has a component it will be replaced by new one.
   @param $component : "Component instance."
   @return "Pointer to the entity."
*>
macro Entity* Entity.add(&self, $component) {
	if (try component = self.get_world().components.get_ref($typeof($component).typeid)) {
		self.set($component);					/* Storing value in the chunk. */
		self.components.set(component.idx);		/* Setting marker bit.		   */
	}

	return self;
}

<* Sets component in the entity by its instance.
   @param $component : "Component instance."
   @return "Pointer to the entity."
*>
macro Entity* Entity.set(&self, $component) {
	if (self.state & ElementState.BUFFERED) {
		if (try component = self.world.components.get_ref($typeof($component).typeid)) {
			$typeof($component)[QUICK_CHUNK_SIZE]* chunk = ($typeof($component)[QUICK_CHUNK_SIZE]*)component.buffer;
			(*chunk)[self.chunk_idx] = $component;
		}
	} else {
		switch (self.block.get_lifetime()) {
			case DYNAMIC: {
				if (try chunk = ($typeof($component)[DYNAMIC_CHUNK_SIZE]*)self.block.get_chunk($typeof($component))) {
					(*chunk)[self.chunk_idx] = $component;
				}
			}

			case STATIC: {
				if (try chunk = ($typeof($component)[STATIC_CHUNK_SIZE]*)self.block.get_chunk($typeof($component))) {
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
	if (try component = self.get_world().components.get_ref($Type.typeid)) {
		if (self.components.get(component.idx)) {
			if (self.state & ElementState.BUFFERED) {
				$Type[QUICK_CHUNK_SIZE]* chunk = ($Type[QUICK_CHUNK_SIZE]*)component.buffer;
				return &(*chunk)[self.chunk_idx];
			} else {
				switch (self.block.get_lifetime()) {
					case DYNAMIC: {
						if (try chunk = ($Type[DYNAMIC_CHUNK_SIZE]*)self.block.get_chunk($Type)) {
							return &(*chunk)[self.chunk_idx];
						}
					}

					case STATIC: {
						if (try chunk = ($Type[STATIC_CHUNK_SIZE]*)self.block.get_chunk($Type)) {
							return &(*chunk)[self.chunk_idx];
						}
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
	ComponentPointers values;

	self.get_world().components.@each_ref(; typeid type, Component* c) {
		if (self.components.get(c.idx)) {
			void* ptr;

			if (self.state & ElementState.BUFFERED) {
				ptr = (char*)c.buffer + c.size * self.chunk_idx;
			} else if (try chunk = self.block.get_chunk(type)) {
				/* If entity is not BUFFERED than it is DYNAMIC or STATIC (not QUICK), */
				/* so we can just get pointer of the block and do math with it.		   */
				ptr = chunk + c.size * self.chunk_idx;
			}

			if (ptr != null) values.push(any_make(ptr, type));
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

	self.get_world().components.@each_ref(; typeid type, Component* c) {
		if (self.components.get(c.idx)) {
			void* ptr;

			if (self.state & ElementState.BUFFERED) {
				ptr = (char*)c.buffer + c.size * self.chunk_idx;
			} else if (try chunk = self.block.get_chunk(type)) {
				ptr = chunk + c.size * self.chunk_idx;
			}

			if (ptr != null) @body(type, ptr);
		}
	};
}

<* Removes component from entity by its type.
   @param type : "Component type id."
*>
fn void Entity.remove(&self, typeid type) {
	if (try component = self.get_world().components.get_ref(type)) {
		self.components.unset(component.idx);
	}
}

<* Removes components from entity of all passed types.
   @require $vacount > 0 : "You must pass at least one component type."
*>
macro void Entity.remove_all(&self, ...) {
	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		self.remove($Type.typeid);
	$endfor
}

<* Checks if the enity has a component.
   @param $Type : "Component type."
   @return "True if entity has a component, otherwise - false."
*>
macro bool Entity.has(&self, $Type) {
	if (try component = self.get_world().components.get_ref($Type.typeid)) {
		return self.components.get(component.idx);
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
		if (try component = world.components.get_ref(type)) {
			has = has && self.components.get(component.idx);
		} else {
			has = false;
		}
	}

	return has;
}

<* Tags entity with specified tag type.
   @param type : "Tag type id."
*>
fn void Entity.tag(&self, typeid type) {
	if (try tag = self.get_world().tags.get_ref(type)) {
		self.tags.set(tag.idx);
	}
}

<* Tags entity with all passed tag types.
   @require $vacount > 0 : "You must pass at least one tag type."
*>
macro void Entity.tag_all(&self, ...) {
	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		self.tag($Type.typeid);
	$endfor
}

<* Removes tag from entity.
   @param type : "Tag type id."
*>
fn void Entity.untag(&self, typeid type) {
	if (try tag = self.get_world().tags.get_ref(type)) {
		self.tags.unset(tag.idx);
	}
}

<* Removes tags from entity of all passed types.
   @require $vacount > 0 : "You must pass at least one tag type."
*>
macro void Entity.untag_all(&self, ...) {
	$for var $i = 0; $i < $vacount; $i++:
		var $Type = $vaexpr[$i];
		self.untag($Type.typeid);
	$endfor
}

<* Checks if the entity is tagged with specified tag type.
   @param type : "Tag type id."
   @return "True if the entity has tag, otherwise - false."
*>
fn bool Entity.tagged(&self, typeid type) {
	if (try tag = self.get_world().tags.get_ref(type)) {
		return self.tags.get(tag.idx);
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
		if (try tag = world.tags.get_ref(type)) {
			tagged = tagged && self.tags.get(tag.idx);
		} else {
			tagged = false;
		}
	}

	return tagged;
}

<* Despawns entity. *>
fn void Entity.despawn(&self) {
	if (self.state & ElementState.BUFFERED) {
		self.world.despawn(self);
	} else {
		self.block.delete(self.chunk_idx);
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
