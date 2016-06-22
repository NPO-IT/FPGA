`timescale 1 ns/1 ns

module ds_DAC_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk, clr;
	reg [7:0] value;
	wire DAC_out;
	
	// Instantiate UUT
	ds_DAC ds_DAC_tb(.clk(clk), .clrn(clr), .value(value),
		.DAC_out(DAC_out));

	// Clock definition
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
	// Strobe and divisor definition
	initial begin
		value = 64;
		clr = 0;
		#5 clr = 1;
		repeat (32768) @(posedge clk);
		$stop;
	end
	
endmodule
