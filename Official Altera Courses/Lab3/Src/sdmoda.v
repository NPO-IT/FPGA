module sdmoda
(
	input clk, clrn,
	input signed [7:0] val,
	output reg daco
);

	reg signed [8:0] u;
	reg signed [8:0] ysh;
	reg signed [8:0] eps;
	
	always @(posedge clk or negedge clrn) 
	begin
		if (!clrn) u <= 0;
		else u <= val-eps;
	end

	always @(*)
	begin
		if (u>=0) 
		begin
			ysh=127;
			daco=1;
		end
		else
		begin
			ysh=-128;
			daco=0;
		end
		eps=ysh-u;
	end
	
endmodule
