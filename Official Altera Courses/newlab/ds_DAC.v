module ds_DAC

(
	// Input Ports
	input clk, clrn,
	input signed [7:0]value,

	// Output Ports
	output DAC_out
);

	// Module Item(s)
	
	wire signed [8:0]U;
	wire signed [7:0]Ep;
	reg signed [8:0]latched;
	
	assign DAC_out = ~U[8];
	assign U = latched;
	assign Ep = (U>=0) ? (127-U) : (-128-U);
	
	
	always @ (negedge clrn or posedge clk)
	begin
		// Reset whenever the reset signal goes low, regardless of the clock
		if (!clrn)
		begin
			latched <= 0;
		end
		// If not resetting, update the register output on the clock's rising edge
		else
		begin
			latched <= value - Ep;
		end
	end
	

endmodule
