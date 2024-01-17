class apb_tx extends uvm_sequence_item;
  rand bit [8:0] paddr;
  rand bit psel;
  rand bit penable;
  rand bit transfer;
  rand bit pwrite;
  rand bit [31:0] pwdata;
  bit pready;
  bit [31:0] prdata;

	
	`uvm_object_utils_begin(apb_tx)
		`uvm_field_int(paddr,UVM_ALL_ON)
		`uvm_field_int(psel,UVM_ALL_ON)
		`uvm_field_int(penable,UVM_ALL_ON)
		`uvm_field_int(transfer,UVM_ALL_ON)
		`uvm_field_int(pwrite,UVM_ALL_ON)
		`uvm_field_int(pwdata,UVM_ALL_ON)
		`uvm_field_int(pready,UVM_ALL_ON)
		`uvm_field_int(prdata,UVM_ALL_ON)
	`uvm_object_utils_end
	
  `NEW_OBJ

endclass
