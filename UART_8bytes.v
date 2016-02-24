module UART_8bytes
(
	input reset,
	input clk,
	input RQ,
	input [7:0] data,
	output reg tx,
	output reg dirTX,
	output reg dirRX,
	output reg [2:0] switch,
	output reg test
);
`define WAIT 0
`define MEGAWAIT 1
`define DIRON 2
`define TX 3
`define DIROFF 4

reg [2:0] state;
reg [3:0] serialize;
reg [4:0] delay;
reg [1:0] rqsync;

always@(posedge clk) begin
	rqsync <= { rqsync[0],  RQ };
end

always@(posedge clk)
begin
if (~reset) begin
	state <= 1'b0;
	serialize <= 1'b0;
	delay <= 1'b0;
	tx <= 1'b1;
end else begin
	case (state)
		`WAIT: begin
			if (rqsync[1]) state <= `DIRON;
			test <= 0;
		end
		`DIRON: begin //для отладки - это состояние просто отправлет в следующее
			delay <= delay + 1'b1;
			if (delay == 0) begin dirRX <= 1; end;
			if (delay == 15) begin dirTX <= 1; end
			if (delay == 30) begin state <= `TX; end
		end
		`TX: begin
			serialize <= serialize + 1'b1;
			case (serialize)
				0: begin 
					tx <= 0;  
					delay <= 0;
				end
				1,2,3,4,5,6,7,8: tx <= data[(serialize - 1)];
				9: begin 
					tx <= 1;
					switch <= switch + 1'b1;
				end
				10: begin
					serialize <= 0; 
					if (switch == 0) state <= `DIROFF; 
				end	
			endcase
		end
		`DIROFF: begin //для отладки - это состояние просто отправлет в следующее
			delay <= delay + 1'b1;
			if (delay == 15) begin dirTX <= 0; end
			if (delay == 30) begin dirTX <= 0; state <= `MEGAWAIT; end
		end
		`MEGAWAIT: begin
			delay <= 0;
			if (~rqsync[1]) state <= `WAIT;
		end
	endcase 
end
end
endmodule
