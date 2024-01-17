class apb_env extends uvm_env;
	`uvm_component_utils(apb_env)
	`NEW_COMP
	apb_agent agent;
	apb_sbd   sbd;

	function void build_phase(uvm_phase phase);
	 super.build_phase(phase);
		 agent = apb_agent::type_id::create("agent",this);
		 sbd = apb_sbd::type_id::create("sbd",this);
	endfunction

	function void connect_phase(uvm_phase phase);
	super.build_phase(phase);
	agent.mon.ap_port.connect(sbd.imp_sbd1);
	agent.mon.ap_port.connect(sbd.imp_sbd2);
	endfunction

endclass
