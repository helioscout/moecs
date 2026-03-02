#+private
package moecs

import "core:fmt"

/* Archetype for components/tags configuration. */
Archetype :: struct {
	/* Components marker, each set bit specifies that the component exists in the archetype. */
	components : [COMPONENTS_MARKER_SIZE]uint,
	/* Tags marker, each set bit specifies that the tag exists in the archetype. */
	tags : [TAGS_MARKER_SIZE]uint,
	/* Entities that belongs to the archetype. Each entity clould be included only into one archetype. */
	entities : [dynamic]^Entity
}

@(private="package")
archetype_remove :: #force_inline proc(entity: ^Entity) {
	if entity.archetype != nil {
		unordered_remove(&entity.archetype.entities, entity.arch_idx)
		/* We need to correct moved (if it was) entity index in the archetype collection. */
		if len(entity.archetype.entities) > 0 && entity.arch_idx < len(entity.archetype.entities) {
			entity.archetype.entities[entity.arch_idx].arch_idx = entity.arch_idx
		}

		entity.archetype = nil
	}
}

/* Free all archetype resources.
   `archetype` : Pointer to the achetype. */
@(private="package")
free_archetype :: proc(archetype: ^Archetype) {
	delete(archetype.entities)
}
