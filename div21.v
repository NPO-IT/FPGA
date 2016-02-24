/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.20
*/

module div21
(
    input wire clkIN,
    output reg clkOUT = 1'b0
    );

reg [4:0] count;
wire clk = count > 10 ? 1'b1 : 0;
always @ (posedge clkIN)
begin
	count <= count + 1'b1;
	if(count == 5'd20) begin
		count<=0;
	end 
end
always @ (posedge clkIN)
begin
clkOUT <= clk;
end
endmodule
