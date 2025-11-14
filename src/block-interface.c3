module moecs::block::interfaces;

<* Base interface for blocks. *>
interface BlockGene {
	fn void init();
	fn bool has_free_rows();
	fn bool full();
	fn bool free();
	fn Entity* insert();
	fn void absorb();
}
