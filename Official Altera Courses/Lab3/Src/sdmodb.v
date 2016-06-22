module sdmodb
(
	input clk, clrn,
	input signed [7:0] val,
	output daco
);

	reg signed [8:0] u;
	wire signed [8:0] ysh;
	
	always @(posedge clk or negedge clrn) 
	begin
		if (!clrn) u <= 0;
		else u <= val-ysh+u;
	end

	assign ysh = (u[8])?-128:127;
	assign daco = !u[8];
	
endmodule
