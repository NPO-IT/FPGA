/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.20
*/

module clk80Mto640K(
    input wire clkIN,
    output reg clkOUT = 1'b0
    );

reg [6:0] count=1'b0;

always @ (posedge clkIN)
begin
	count <= count + 1'b1;
	if(count == 63)
		clkOUT <= 1;
	else if(count == 124) begin
		count<=0;
		clkOUT <=0;
	end
end
endmodule
