class base_test extends uvm_test;
  `uvm_component_utils(base_test);
 `NEW_COMP
  apb_env env;

    function void build_phase(uvm_phase phase);
		  super.build_phase(phase);
   			 env=apb_env::type_id::create("env",this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
		  super.end_of_elaboration_phase(phase);
   			 uvm_top.print_topology();
  endfunction



endclass

class apb_base_test extends base_test;
`uvm_component_utils(apb_base_test)
`NEW_COMP

  task run_phase(uvm_phase phase);
   
	apb_seq seq;
    seq = apb_seq::type_id::create("seq", this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
	phase.phase_done.set_drain_time(this ,100);
    phase.drop_objection(this);
 
 endtask
 
endclass


class apb_nwr_nrd_test extends base_test;
`uvm_component_utils(apb_nwr_nrd_test)
`NEW_COMP

  task run_phase(uvm_phase phase);
   
	apb_nwr_nrd_seq seq;
    seq=apb_nwr_nrd_seq::type_id::create("seq", this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
	phase.phase_done.set_drain_time(this ,100);
    phase.drop_objection(this);
 
 endtask
 
endclass

class apb_nwr_nrd_test1 extends base_test;
`uvm_component_utils(apb_nwr_nrd_test1)
`NEW_COMP

  task run_phase(uvm_phase phase);
   
	apb_nwr_nrd_seq1 seq;
    seq=apb_nwr_nrd_seq1::type_id::create("seq", this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
	phase.phase_done.set_drain_time(this ,100);
    phase.drop_objection(this);
 
 endtask
 
endclass

