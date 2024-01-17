module apb_slv(pclk,preset_n,psel,paddr,pwrite,pwdata,penable,prdata,pready,transfer);
	
	parameter IDLE=3'b001;
	parameter SET_UP=3'b010;
	parameter ACCESS=3'b100;

	input pclk;
	input preset_n;
	input psel;
	input [8:0]paddr;
	input pwrite;
	input [31:0]pwdata;
	input penable;
	output reg [31:0]prdata;
	output reg pready;
	input transfer;

	reg [31:0]memory[511:0];
	integer i;
	reg [2:0]state;
	reg [2:0]next_state;


	always@(posedge pclk) begin
		if(preset_n==0) begin
			prdata<=0;
			pready<=0;
			state<=IDLE;
			next_state<=IDLE;
			for(i=0;i<512;i=i+1) begin
				memory[i]<=0;
			end
		end
		else begin
			case(state)
				IDLE: begin
						if(psel==1'b0) begin
							if(transfer==1'b0) begin
								next_state<=IDLE;
							end
						else next_state<=SET_UP;
						end
					 end

				SET_UP: begin
					if(psel==1'b1 && transfer==1'b1) begin					   
						next_state<=ACCESS;
					end
					else 
					next_state<=IDLE;
				end

				ACCESS: begin
					if(psel==1'b1 && penable==1'b1) begin	
							if(pwrite==1'b1) begin
									pready<=1'b1;
									memory[paddr]<=pwdata;
									if(transfer==1) next_state<=ACCESS;
									else if(transfer==0) next_state<=IDLE;
							end
							else if(pwrite==0) begin
									pready<=1'b1;
									prdata<=memory[paddr];
								if(transfer==1) next_state<=ACCESS;
								else if(transfer==0) next_state<=IDLE;
							end
					end
					else begin
								next_state<=IDLE;

					end
				end
			endcase
		end
	end
	always@(next_state) begin
		state<=next_state;
	end
endmodule
