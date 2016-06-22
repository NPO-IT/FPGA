module ffSync (
	input wire clk,
	input wire wireIN,
	output wire ffOUT
);

reg [1:0] sync;
assign ffOUT = sync[1];

always @ (posedge clk)
	sync <= { sync[0], wireIN };

endmodule