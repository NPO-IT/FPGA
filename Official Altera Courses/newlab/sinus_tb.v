`timescale 1 ns/1 ns

module sinus_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk;
	reg phase_up, phase_dn;
	wire result, result1;
	
	// Instantiate UUT
	sinus sinus_tb(.inclk(clk),  
	.phase_up(phase_up), 
	.phase_dn(phase_dn),
	.fouta(result),
	.foutd(result1)
	);

	// Clock definition
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
	// Strobe and divisor definition
	initial begin
		phase_up = 1;
		phase_dn = 1;

		repeat (32768) @(posedge clk);
		phase_up = 0;
		repeat (32768) @(posedge clk);
		phase_up = 1;
		repeat (32768) @(posedge clk);
		phase_up = 0;
		repeat (32768) @(posedge clk);
		phase_up = 1;
		repeat (32768) @(posedge clk);
		phase_up = 0;
		repeat (32768) @(posedge clk);
		phase_up = 1;
		repeat (32768) @(posedge clk);
		phase_dn = 0;
		repeat (32768) @(posedge clk);
		phase_dn = 1;
		repeat (32768) @(posedge clk);
		phase_dn = 0;
		repeat (32768) @(posedge clk);
		phase_dn = 1;
		repeat (32768) @(posedge clk);
		$stop;
	end
	
endmodule
