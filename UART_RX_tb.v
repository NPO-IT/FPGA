`timescale 10 ps/10 ps

module UART_RX_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk, clr;
	reg rxwire;
	wire [7:0]dat;
	wire val;
	
	reg clk5;
	reg [7:0]number[0:4];
	reg [2:0]i = 0;
	reg [2:0]j = 0;
	
	// Instantiate UUT
	UARTRX UART_RX_tb(.clk(clk), .reset(clr), .iRX(rxwire), .oData(dat), .oValid(val));

	// Clock definition
	initial begin
		clk = 0;
		forever #625 clk = ~clk;
	end
	initial begin
		clk5=0;
		forever #10000 clk5 = ~clk5;
	end
	
	initial begin
		number[0]=54;
		number[1]=55;
		number[2]=56;
		number[3]=57;
		number[4]=58;
		//repeat (32768) @(posedge clk);
		rxwire = 1;
		clr = 0;
		repeat(10)@(posedge clk);
		clr = 1;
		
		repeat (5) begin
			repeat(10)@(posedge clk5);
			rxwire = 0;
			repeat (8)
			begin
				@(posedge clk5)
				rxwire=number[j][i];
				i=i+1;
			end
			@(posedge clk5);
			rxwire = 1;
			j=j+1;
		end
		repeat(10)@(posedge clk5);
		
		$stop;
	end
	
	// Strobe and divisor definition
	/*initial begin
		value = 64;
		clr = 0;
		#5 clr = 1;
		repeat (32768) @(posedge clk);
		$stop;
	end
	*/
endmodule
