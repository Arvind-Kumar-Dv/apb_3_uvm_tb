class apb_cov extends uvm_subscriber#(apb_tx);
	`uvm_component_utils(apb_cov)
	apb_tx tx;
	covergroup cg_name;

	endgroup

	function new(string name="", uvm_component parent=null);
		super.new(name,parent);
		cg_name = new();
	endfunction
	function void write(T t);
		$cast(tx, t);
		cg_name.sample();
	endfunction
endclass