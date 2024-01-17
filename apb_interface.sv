interface apb_intf(input bit pclk,preset_n);
  
  bit [8:0] paddr;
  bit psel;
  bit transfer;
  bit penable;
  bit pwrite;
  bit [31:0] pwdata;
  bit pready;
  bit [31:0] prdata;

  clocking drv_cb@(posedge pclk);
 default input #1 output#0;
 input  paddr;
 input psel;
 input transfer;
 input penable;
 input pwrite;
 input pwdata;
 output pready;
 output prdata;

	
  endclocking

  clocking mon_cb@(posedge pclk);
 default input #1;
 input  paddr;
 input  psel;
 input  transfer;
 input  penable;
 input  pwrite;
 input  pwdata;
 input pready;
 input prdata;


  endclocking


endinterface
