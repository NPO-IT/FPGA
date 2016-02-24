/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.20
*/

module globalReset			// to use this: set the initial for (~reset) and main circuit for (reset)
(
	input clk40,			// 40 MHz
	output reg rst			// global enable
);
reg [5:0] count;

always@(posedge clk40)
begin
	if (count > 6'b111110) rst <= 1;
	else begin rst <= 0; count <= count + 1'b1; end
end
endmodule
