class apb_driver extends uvm_driver#(apb_tx);
	`uvm_component_utils(apb_driver)
	`NEW_COMP
	virtual apb_intf vif;
apb_tx tx;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual apb_intf)::get(this,"","APB_IF",vif))  begin
			`uvm_fatal("vif_id"," VIF FAILED")
			end
	endfunction
	
	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
		//	req.print();
			seq_item_port.item_done();
		end
	endtask

task drive_tx(apb_tx tx);

         		@(posedge vif.pclk);
			 	 vif.transfer =tx.transfer;
        	 	@(posedge vif.pclk);
			 	 vif.psel    =tx.psel;
         		@(posedge vif.pclk);
				vif.penable =tx.penable; 
				vif.pwrite=tx.pwrite;
			   if(tx.pwrite==1)vif.pwdata=tx.pwdata;
 		       vif.paddr   =tx.paddr; 
			   wait(vif.pready==1);
			   if(tx.pwrite==0) begin tx.prdata=vif.prdata; 
			   tx.pwdata=0;
	   		  end
			  // tx.print(); 
			  @(posedge vif.pclk); 
			   vif.transfer=0;
			   vif.pwdata=0;
			   vif.pwrite=0;
               vif.psel=0;
               vif.penable=0;
               vif.paddr=0;
                             
	 endtask

endclass
