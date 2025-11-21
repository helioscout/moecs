module moecs::block::interfaces;

<* Base interface for blocks. *>
interface BlockGene {
	fn void 	init();
	fn bool 	has_free_rows();
	fn bool 	full();
	fn bool		free();
	fn Entity*	insert();
	fn void 	absorb();
	fn World*	get_world();
	fn Lifetime get_lifetime();
	fn char*?	get_chunk(typeid type);
}
