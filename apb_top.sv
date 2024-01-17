`include "uvm_pkg.sv"
  import uvm_pkg::*;
`include "apb_common.sv"
`include "apb_slv.sv"
`include "apb_interface.sv"
`include "apb_tx.sv"
`include "apb_monitor.sv"
//`include "apb_coverage.sv"
`include "apb_sequence.sv"
`include "apb_sequencer.sv"
`include "apb_driver.sv"
`include "apb_agent.sv"
`include "apb_sbd.sv"
`include "apb_env.sv"
`include "apb_test.sv"

module apb_top;
	logic pclk;
	logic preset_n;
	apb_intf pif(pclk,preset_n);
	apb_slv DUT (
					.pclk(pif.pclk),
					.preset_n(pif.preset_n),
					.paddr(pif.paddr),
					.psel(pif.psel),
					.penable(pif.penable),
					.pwrite(pif.pwrite),
					.pwdata(pif.pwdata),
					.pready(pif.pready),
					.prdata(pif.prdata),
					.transfer(pif.transfer)
					
				);

				initial begin
					uvm_config_db#(virtual apb_intf)::set(uvm_root::get(),"*","APB_IF",pif);
				end

// clk genration				
initial begin
	pclk=0;
	forever #5 pclk=~pclk;
end

	initial begin
		preset_n=0;
		@(posedge pclk);
		preset_n=1;
	end
	
	initial begin
		run_test("apb_base_test");
	end

endmodule
