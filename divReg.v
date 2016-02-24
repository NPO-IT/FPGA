/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.10
*/

module divReg
(
	input iClkIN,			// whatever clock
	output Outdiv2,			// divided by 2 
	output Outdiv4,			// divided by 4
	output Outdiv8,			// divided by 8
	output Outdiv16			// divided by 16
);

reg [3:0] clk;

always @(posedge iClkIN)	
clk<=clk+1'b1;				// always count 4-digit binary: 0..15

assign Outdiv2 = clk[0];	// asyncronous outputs
assign Outdiv4 = clk[1];
assign Outdiv8 = clk[2];
assign Outdiv16 = clk[3];
endmodule 