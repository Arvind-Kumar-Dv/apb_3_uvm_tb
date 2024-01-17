class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)
	`NEW_COMP
	apb_tx tx;
	virtual apb_intf vif;
	uvm_analysis_port #(apb_tx) ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
		uvm_config_db #(virtual apb_intf)::get(this,"","APB_IF",vif);
	endfunction

	task run_phase(uvm_phase phase);
          forever begin
			//	$display("########## monitor################");
             	tx=new();
			    @(vif.mon_cb);
				if(vif.mon_cb.penable==1 && vif.mon_cb.pready==1 && vif.mon_cb.psel==1 && vif.mon_cb.transfer == 1) begin
 		        tx.penable     =vif.mon_cb.penable; 
 		        tx.transfer    =vif.mon_cb.transfer; 
 		        tx.pready      =vif.mon_cb.pready; 
 		        tx.psel        =vif.mon_cb.psel; 
 		        tx.paddr       =vif.mon_cb.paddr; 
 		        tx.pwrite      =vif.mon_cb.pwrite; 
			    if(vif.mon_cb.pwrite==1) tx.pwdata=vif.mon_cb.pwdata;
				if(vif.mon_cb.pwrite==0) begin
				@(vif.mon_cb);
				tx.prdata=vif.mon_cb.prdata;
				end
	  			ap_port.write(tx);
			 //   tx.print();
		    end
	end

	endtask

endclass
