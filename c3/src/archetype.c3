module moecs;

<* Archetype for components/tags configuration. *>
struct Archetype {
	<* Components marker, each set bit specifies that the component exists in the archetype. *>
	ComponentsMarker components;
	<* Tags marker, each set bit specifies that the tag exists in the archetype. *>
	TagsMarker tags;
	<* Entities that belongs to the archetype. Each entity clould be included only into one archetype. *>
	Entities entities;
}

<* Initializes the archetype. *>
fn void Archetype.init(&self) @private {
	self.entities.init(mem);
}
