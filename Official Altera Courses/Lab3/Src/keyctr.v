module keyctr
#(parameter DIV_WIDTH=16)
(
	input clk,
	input phase_up, phase_dn,
	output reg [7:0] phinc
);

reg [DIV_WIDTH:0] cntdiv;
reg [2:0] btn_up, btn_dn;
wire detect_up, detect_dn;

// synthesis translate_off
initial 
begin
	cntdiv=0;
	btn_up=0;
	btn_dn=0;
	phinc=0;
end
// synthesis translate_on

always @ (posedge clk)
begin
	if (cntdiv[DIV_WIDTH])
	begin
		cntdiv<=0;
		btn_up<={btn_up[1:0],phase_up};
		btn_dn<={btn_dn[1:0],phase_dn};
		if (detect_up) phinc<=phinc+1;
		else if (detect_dn) phinc<=phinc-1;
	end
	else cntdiv<=cntdiv+1;
end

assign detect_up = btn_up[2]&&!btn_up[1];
assign detect_dn = btn_dn[2]&&!btn_dn[1];

endmodule
