module divReg
(
	input iClkIN,
	output Outdiv2,
	output Outdiv4,
	output Outdiv8,
	output Outdiv16
);

reg [3:0] clk;

always @(posedge iClkIN)
clk<=clk+1'b1;

assign Outdiv2 = clk[0];
assign Outdiv4 = clk[1];
assign Outdiv8 = clk[2];
assign Outdiv16 = clk[3];
endmodule 