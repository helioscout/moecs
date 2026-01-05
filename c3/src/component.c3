module moecs;

<* Component elment type description. *>
struct Component {
	<* Type id of the component type. *>
	typeid type;
	<* Index of the component in the bitset (entity's components marker). *>
	usz idx;
	<* Type size for allocations. *>
	usz size;
	<* Pointer to buffer for quick lifetime chunk, must be provided from the main app. *>
	any buffer;
}
