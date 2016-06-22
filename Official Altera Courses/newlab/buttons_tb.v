`timescale 1 ns/1 ns

module buttons_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk, clr;
	reg btnUP, btnDN;
	wire [7:0] result;
	
	// Instantiate UUT
	buttons buttons_tb(
		.clk(clk), 
		.reset(clr), 
		.phase_up(btnUP),
		.phase_dn(btnDN),
		.phinc(result)
	);

	// Clock definition
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	// Strobe and divisor definition
	initial begin
		clr = 0;
			btnUP = 1;
			btnDN = 1;
		repeat(20)@(posedge clk);
		clr = 1;
		repeat(120)@(posedge clk);

			repeat(40000)@(posedge clk)
			btnUP = 0;
			repeat(40000)@(posedge clk)
			btnUP = 1;
			repeat(40000)@(posedge clk)
			btnUP = 0;
			repeat(40000)@(posedge clk)
			btnUP = 1;
			repeat(40000)@(posedge clk)
			btnUP = 0;
			repeat(40000)@(posedge clk)
			btnUP = 1;
		
			repeat(40000)@(posedge clk)
			btnDN = 0;
			repeat(40000)@(posedge clk)
			btnDN = 1;
			repeat(40000)@(posedge clk)
			btnDN = 0;
			repeat(40000)@(posedge clk)
			btnDN = 1;
			repeat(40000)@(posedge clk)
		$stop;
	end
	
endmodule
