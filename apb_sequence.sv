class base_seq extends uvm_sequence#(apb_tx);
	`uvm_object_utils(base_seq)
	`NEW_OBJ
	uvm_phase phase;
apb_tx tx,tx_q[$];
	task pre_body();
		if(phase!=null) begin
			phase.raise_objection(this);
			phase.phase_done.set_drain_time(this, 50);
			end
	endtask

	task post_body();
		if(phase != null) begin
			phase.drop_objection(this);
			end
	endtask

endclass


// concurrent write and read

class apb_seq extends base_seq;
`uvm_object_utils(apb_seq)
`NEW_OBJ

	task body();
			int temp;
			repeat(3) begin
					`uvm_do_with(req,{req.pwrite==1; req.penable==1; req.psel==1;req.transfer==1;})
			$display("###### inside seq #########");
				temp=req.paddr;
			   `uvm_do_with(req,{req.pwrite==0;req.paddr==temp; req.penable==1; req.psel==1;req.transfer==1;})
			end
	endtask


endclass


// n write n read

class apb_nwr_nrd_seq extends base_seq;
`uvm_object_utils(apb_nwr_nrd_seq)
`NEW_OBJ

	task body();
			int temp,temp_r[$];
			repeat(3) begin
					`uvm_do_with(req,{req.pwrite==1; req.penable==1; req.psel==1;req.transfer==1;})
					temp_r.push_back(req.paddr);
			end
			
			
			repeat(3) begin
				temp = temp_r.pop_front();
			   `uvm_do_with(req,{req.pwrite==0;req.paddr==temp; req.penable==1; req.psel==1;req.transfer==1;})
			end
	endtask


endclass




// n write n read

class apb_nwr_nrd_seq1 extends base_seq;
`uvm_object_utils(apb_nwr_nrd_seq1)
`NEW_OBJ

	task body();
			
			repeat(3) begin
					`uvm_do_with(req,{req.pwrite==1; req.penable==1; req.psel==1;req.transfer==1;})
			         tx=new req; 
				     tx_q.push_back(tx);
					// req.print();
			end
						
			repeat(3) begin
				   tx= tx_q.pop_front();
			      `uvm_do_with(req,{req.pwrite==0;req.paddr==tx.paddr; req.penable==1; req.psel==1;req.transfer==1;})
			      // req.print();
			end
	endtask


endclass

