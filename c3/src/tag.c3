module moecs;

<* Tag element type description. *>
struct Tag {
	<* Type id of the tag type. *>
	typeid type;
	<* Index of the tag in the bitset (entity's tags marker). *>
	usz idx;
}
