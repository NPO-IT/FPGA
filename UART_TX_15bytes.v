/*
	Ivan I. Ovchinnikov
	last upd.: 2016.03.29
	
	15 bytes * 8 bits, startbit 0, stopbit 1, 
	no parity, MSB sequence, multiplexed input, 
	15to1 mux control
	Done Signal included
*/

module UART_TX_15bytes
(
	input reset,					// global reset and enable signal
	input clk,						// actual needed baudrate (tested on 4,8 MHz)
	input RQ,						// start transfer signal
	input [7:0] data,				// 14bytes * 8bits data
	output reg tx,					// serial transmitted data
	output reg dirTX,				// rs485 TX dir controller 
	output reg dirRX,				// rs485 RX dir controller
	output reg [3:0] switch,		// multiplexor switcher
	output reg TXDone
);

`define WAIT 0						// state machine definitions
`define MEGAWAIT 1
`define DIRON 2
`define TX 3
`define DIROFF 4

reg [2:0] state;
reg [3:0] serialize;
reg [5:0] delay;
reg [1:0] rqsync;

always@(posedge clk) begin			// double d-flipflop to avoid metastability
	rqsync <= { rqsync[0],  RQ };	// start signal from other clock domain
end

always@(posedge clk)
begin
if (~reset) begin					// global asyncronous reset, initial values
	state <= 1'b0;
	serialize <= 1'b0;
	delay <= 1'b0;
	tx <= 1'b1;
end else begin						// main circuit
	case (state)					// state machine
		`WAIT: begin				// waiting for transfer request
			if (rqsync[1]) state <= `DIRON;		// just move on
		end
		`DIRON: begin 				// set the DIR pins to high level with a tiny delay
			delay <= delay + 1'b1;	// count while in this state
			if (delay == 0) begin dirRX <= 1; end;
			if (delay == 15) begin dirTX <= 1; end
			if (delay == 30) begin state <= `TX; end	// proceed to next state
		end
		`TX: begin					// the transfer
			serialize <= serialize + 1'b1;		// count while in this state
			case (serialize)					// make a sequence while here
				0: begin 
					tx <= 0;  		// startbit
					delay <= 0;		// reset previous counter
				end
				1,2,3,4,5,6,7,8: tx <= data[(serialize - 1)];	// transmit every bit of data
				9: begin 
					tx <= 1;		// stopbit
					switch <= switch + 1'b1;	// switch multiplexor
				end
				10: begin
					serialize <= 0; // reset sequencer
					if (switch == 15) begin 
						state <= `DIROFF;	// if completed transfer proceed to next state 
						switch <= 0;
					end
				end	
			endcase
		end
		`DIROFF: begin				// set the DIR pins to low level with a tiny delay
			delay <= delay + 1'b1;	// count while in this state
			if (delay == 15) begin dirTX <= 0; end
			if (delay == 30) begin dirRX <= 0; TXDone <= 1; end
			if (delay == 45) begin TXDone <= 0; state <= `MEGAWAIT; end	// proceed to next state
		end
		`MEGAWAIT: begin			// checking the low level of request signal
			delay <= 0;				// reset previous counter
			if (~rqsync[1]) state <= `WAIT; // just move on
		end
	endcase 
end
end
endmodule
