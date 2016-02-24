module globalReset
(
	input clk40,
	output reg rst
);
reg [5:0] count;

always@(posedge clk40)
begin
	if (count > 6'b111110) rst <= 1;
	else begin rst <= 0; count <= count + 1'b1; end
end
endmodule
