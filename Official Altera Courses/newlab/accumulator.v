module accumulator

#(
	// Parameter Declarations
	parameter m = 28
)

(
	// Input Ports
	input clk, clrn,
	input [7:0]phinc,

	// Output Ports
	output [7:0] phase
);

	// Module Item(s)


reg [m-1:0]accum;

assign phase = accum[m-1:m-8];
	
	always @ (negedge clrn or posedge clk)
begin
	// Reset whenever the reset signal goes low, regardless of the clock
	if (!clrn)
	begin
		accum <= 0;
	end
	// If not resetting, update the register output on the clock's rising edge
	else
	begin
		accum <= accum + phinc;
	end
end

	
	
endmodule
