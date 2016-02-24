/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.18
*/

module divTen // divides clock by 10
(
    input wire clkIN,			// whatever clock needed to be divided
    output reg clkOUT = 1'b0	// awesome result
    );

reg [3:0] count=1'b0;

always @ (posedge clkIN)
begin
	count <= count + 1'b1;		// always increment
	if(count == 5)				// if counted half of phase
		clkOUT <= 1;			// set output to high level
	else if(count == 9) begin	// when counted to the end of period
		count<=0;				// reset the counter
		clkOUT <=0;				// set output to low level
	end
end
endmodule
