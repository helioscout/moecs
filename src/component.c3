module moecs;

<* Component elment type description. *>
struct Component {
	<* Type id of the component type. *>
	typeid type;
	<* Pointer to buffer for quick lifetime chunk, must be provided from the main app. *>
	any buffer;
}
