`timescale 1 ns/1 ns

module semafor_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk, train;
	reg [1:0] div;
	wire r, y, g;
	
	// Instantiate UUT
	semafor my_sem(.line(clk), .strobe(train), .divider(div),
		.red(r), .yellow(y), .green(g));

	// Clock definition
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
	// Strob and divisor definition
	initial begin
		div = 0;
		train = 0;
		repeat (4)
		begin
			#200 train=1;
			#80 train=0;
			wait ({r,y,g}==3'b001);
			#80 div=div+1;
		end
		$stop;
	end
	
endmodule
