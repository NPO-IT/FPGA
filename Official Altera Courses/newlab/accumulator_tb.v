`timescale 1 ns/1 ns

module accumulator_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk, clr;
	reg [7:0] increment;
	wire [7:0] result;
	
	// Instantiate UUT
	accumulator accumulator_tb(.clk(clk), .clrn(clr), .phinc(increment),
		.phase(result));

	// Clock definition
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
	// Strobe and divisor definition
	initial begin
		increment = 2;
		clr = 0;
		repeat (2)
		begin
			repeat(20)@(posedge clk)
			@(negedge clk)	clr=0;
			repeat(20)@(negedge clk)
			@(negedge clk)	clr=1;
			repeat(640)@(posedge clk);
		end
		$stop;
	end
	
endmodule
