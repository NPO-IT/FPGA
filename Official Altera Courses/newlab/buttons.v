module buttons 
#(
	parameter DEFAULT = 8'd1
)

(
	input reset,
	input clk,
	input phase_up,
	input phase_dn,
	output reg [7:0]phinc
);

reg [14:0]cntClk;		
wire clkDetect;				// 250Hz clk
wire btn_up; 
wire btn_dn; 
reg[2:0]btn_up_sync; 
reg[2:0]btn_dn_sync; 


assign btn_up = ((btn_up_sync[2]) & !btn_up_sync[1]); 	// detect the front
assign btn_dn = ((btn_dn_sync[2]) & !btn_dn_sync[1]); 

assign clkDetect = (cntClk>5000) ? 0 : 1;


always@(negedge reset or posedge clk) begin		// generate clock
	if (~reset) begin
		cntClk <= 0;
	end else begin
		if (cntClk == 10000) begin
			cntClk <= 0;
		end else begin
			cntClk <= cntClk + 1'b1;
		end
		
	end
end

always@(negedge reset or posedge clk) begin						// double dff
	if (~reset) begin
		btn_up_sync <= 0;
		btn_dn_sync <= 0;
	end else begin
		if (clkDetect) begin
			btn_up_sync <= {btn_up_sync[1:0], phase_up}; 
			btn_dn_sync <= {btn_dn_sync[1:0], phase_dn}; 
		end
	end
end


always@(negedge reset or posedge clk) begin		// inc or dec the phase
	if (~reset)begin
		phinc <= DEFAULT;
	end else begin
		if (btn_dn) begin phinc <= phinc - 1'b1; end
		else if (btn_up) begin phinc <= phinc + 1'b1; end
	end
end


endmodule