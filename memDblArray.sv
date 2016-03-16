module memDblArray
(
	input reset,
	input clk,
	input iRQ,
	input [4:0]iNumRQ,
	output reg[7:0]MARK,
	output reg[7:0]m1b1,
	output reg[7:0]m1b2,
	output reg[7:0]m1b3,
	output reg[7:0]m1b4,
	output reg[7:0]m2b1,
	output reg[7:0]m2b2,
	output reg[7:0]m2b3,
	output reg[7:0]m2b4,
	output reg[7:0]m3b1,
	output reg[7:0]m3b2,
	output reg[7:0]m3b3,
	output reg[7:0]m3b4,
	output reg[7:0]CRC8,

	output reg test
);

`define WAIT 0
`define TX 1
`define DONE 2

reg [7:0] Memories [0:31][0:13] = '{
'{8'd10,	8'd1,	8'd178,	8'd178,	8'd1,	8'd2,	8'd3,	8'd178,	8'd1,	8'd2,	8'd178,	8'd178,	8'd63,	8'd79},
'{8'd2,		8'd3,	8'd178,	8'd178,	8'd4,	8'd5,	8'd6,	8'd178,	8'd3,	8'd4,	8'd178,	8'd178,	8'd201,	8'd103},
'{8'd4,		8'd5,	8'd178,	8'd178,	8'd7,	8'd8,	8'd9,	8'd178,	8'd5,	8'd6,	8'd178,	8'd178,	8'd157,	8'd40},
'{8'd6,		8'd7,	8'd178,	8'd178,	8'd10,	8'd11,	8'd12,	8'd178,	8'd7,	8'd8,	8'd178,	8'd178,	8'd0,	8'd255},
'{8'd8,		8'd9,	8'd178,	8'd178,	8'd13,	8'd14,	8'd15,	8'd178,	8'd9,	8'd10,	8'd178,	8'd178,	8'd255,	8'd118},
'{8'd11,	8'd12,	8'd178,	8'd178,	8'd16,	8'd17,	8'd18,	8'd178,	8'd11,	8'd12,	8'd178,	8'd178,	8'd174,	8'd170},
'{8'd13,	8'd14,	8'd178,	8'd178,	8'd19,	8'd20,	8'd21,	8'd178,	8'd13,	8'd14,	8'd178,	8'd178,	8'd53,	8'd77},
'{8'd15,	8'd16,	8'd178,	8'd178,	8'd22,	8'd23,	8'd152,	8'd178,	8'd15,	8'd16,	8'd178,	8'd178,	8'd138,	8'd181},
'{8'd10,	8'd17,	8'd178,	8'd178,	8'd1,	8'd2,	8'd3,	8'd178,	8'd17,	8'd18,	8'd178,	8'd178,	8'd50,	8'd182},
'{8'd18,	8'd19,	8'd178,	8'd178,	8'd4,	8'd5,	8'd6,	8'd178,	8'd19,	8'd20,	8'd178,	8'd178,	8'd243,	8'd206},
'{8'd20,	8'd149,	8'd178,	8'd178,	8'd7,	8'd8,	8'd9,	8'd178,	8'd21,	8'd22,	8'd178,	8'd178,	8'd46,	8'd43},
'{8'd150,	8'd151,	8'd178,	8'd178,	8'd10,	8'd11,	8'd12,	8'd178,	8'd23,	8'd24,	8'd178,	8'd178,	8'd25,	8'd93},
'{8'd151,	8'd153,	8'd178,	8'd178,	8'd13,	8'd14,	8'd15,	8'd178,	8'd153,	8'd154,	8'd178,	8'd178,	8'd19,	8'd85},
'{8'd152,	8'd155,	8'd178,	8'd178,	8'd153,	8'd154,	8'd31,	8'd178,	8'd155,	8'd156,	8'd178,	8'd178,	8'd119,	8'd85},
'{8'd31,	8'd32,	8'd178,	8'd178,	8'd32,	8'd33,	8'd34,	8'd178,	8'd157,	8'd158,	8'd178,	8'd178,	8'd10,	8'd31},
'{8'd33,	8'd34,	8'd178,	8'd178,	8'd35,	8'd36,	8'd37,	8'd178,	8'd31,	8'd32,	8'd178,	8'd178,	8'd79,	8'd247},
'{8'd10,	8'd35,	8'd178,	8'd178,	8'd1,	8'd2,	8'd3,	8'd178,	8'd33,	8'd162,	8'd178,	8'd178,	8'd191,	8'd84},
'{8'd36,	8'd37,	8'd178,	8'd178,	8'd4,	8'd5,	8'd6,	8'd178,	8'd163,	8'd164,	8'd178,	8'd178,	8'd160,	8'd157},
'{8'd38,	8'd39,	8'd178,	8'd178,	8'd7,	8'd8,	8'd9,	8'd178,	8'd176,	8'd177,	8'd178,	8'd178,	8'd201,	8'd80},
'{8'd40,	8'd176,	8'd178,	8'd178,	8'd10,	8'd11,	8'd12,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd85,	8'd51},
'{8'd177,	8'd178,	8'd178,	8'd178,	8'd13,	8'd14,	8'd15,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd0,	8'd243},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd38,	8'd39,	8'd40,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd16,	8'd216},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd176,	8'd177,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd37,	8'd39},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd114,	8'd3},
'{8'd10,	8'd178,	8'd178,	8'd178,	8'd1,	8'd2,	8'd3,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd165,	8'd170},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd4,	8'd5,	8'd6,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd95,	8'd168},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd7,	8'd8,	8'd9,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd184,	8'd212},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd10,	8'd11,	8'd12,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd117,	8'd51},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd13,	8'd14,	8'd15,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd5,	8'd108},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd114,	8'd3},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd114,	8'd3},
'{8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd178,	8'd114,	8'd3}
};

reg [1:0]state;


always@(posedge clk)
begin
	if (~reset) begin								// initial
		
	end else begin									// main
		case (state)
			`WAIT: begin
				if (~iRQ) state <= `TX;
			end
			`TX: begin
				MARK <= 8'b11001100;
				m1b1 <= Memories[iNumRQ][0];
				m1b2 <= Memories[iNumRQ][1];
				m1b3 <= Memories[iNumRQ][2];
				m1b4 <= Memories[iNumRQ][3];
				m2b1 <= Memories[iNumRQ][4];
				m2b2 <= Memories[iNumRQ][5];
				m2b3 <= Memories[iNumRQ][6];
				m2b4 <= Memories[iNumRQ][7];
				m3b1 <= Memories[iNumRQ][8];
				m3b2 <= Memories[iNumRQ][9];
				m3b3 <= Memories[iNumRQ][10];
				m3b4 <= Memories[iNumRQ][11];
				CRC8 <= Memories[iNumRQ][12];
			end
			`DONE: begin
				if (iRQ) state <= `WAIT;
			end
		endcase
	end
end
endmodule
