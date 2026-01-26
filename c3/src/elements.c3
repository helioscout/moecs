module moecs::elements { Type, MAX_COUNT };

<* Abstract collection of typed elements (components/tags).
   Map replacement for faster access and indexing components and tags. *>
struct Elements {
	<* Registered ids of elements converted from typeids.
	   Index in this array will be index in the merker (bitset)
	   and the index of component's chunk in the block. *>
	uptr[MAX_COUNT] ids;
	<* Instances of concrete element type (Component/Tag). *>
	Type[MAX_COUNT] types;
	<* Elements count (last index + 1). *>
	usz count;
}

<* Gets index of element type.
   @param type : "Type of the element."
   @return "Index of the element."
   @return? NOT_FOUND : "Element was not found (registered)."
*>
fn usz? Elements.index(&self, typeid type) @private {
	uptr id = (uptr)type;

	for (usz i = 0; i < self.count; i++) {
		if (self.ids[i] == id) return i;
	}

	return NOT_FOUND?;
}

<* Adds new element into collection.
   @param type : "Type of the element."
   @param instance : "Instance of the element type."
   @require !self.has(type) : "Element already registered."
   @require self.count < MAX_COUNT : "The maximum count of elements has been reached."
*>
fn void Elements.add(&self, typeid type, Type instance) @private {
	self.ids[self.count] = (uptr)type;
	self.types[self.count++] = instance;
}

<* Checks if the collection has specified element type.
   @param type : "Type of the element."
   @return "True if type was found, otherwise - false."
*>
fn bool Elements.has(&self, typeid type) @private => @ok(self.index(type));

<* Gets reference to instance of the element type.
   @param type : "Type of the element."
   @return "Pointer to element's type instance."
   @return? NOT_FOUND : "Element was not found (registered)."
*>
fn Type*? Elements.get(&self, typeid type) @private {
	if (try index = self.index(type)) {
		return &self.types[index];
	} else {
		return NOT_FOUND?;
	}
}

<* Checks if the collection is empty. *>
fn bool Elements.is_empty(&self) @private => self.count == 0;
