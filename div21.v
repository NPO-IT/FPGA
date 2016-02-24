/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.20
*/

module div21
(
    input wire clkIN,				// whatever clock
    output reg clkOUT = 1'b0		// awesome result
    );

reg [4:0] count;
wire clk = count > 10 ? 1'b1 : 0;	// asyncronous counter if counter = 10 set high, otherwise set low
always @ (posedge clkIN)
begin
	count <= count + 1'b1;			// count every clock
	if(count == 5'd20) begin		// if counted
		count<=0;					// reset counter
	end 
end
always @ (posedge clkIN)
begin
clkOUT <= clk;						// separate clock for classic timing assignment
end
endmodule
