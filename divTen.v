/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.18
*/

module divTen // divides clock by 10
(
    input wire clkIN,
    output reg clkOUT = 1'b0
    );

reg [3:0] count=1'b0;

always @ (posedge clkIN)
begin
	count <= count + 1'b1;
	if(count == 5)
		clkOUT <= 1;
	else if(count == 9) begin
		count<=0;
		clkOUT <=0;
	end
end
endmodule
