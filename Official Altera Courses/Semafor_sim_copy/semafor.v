// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 15.1.0 Build 185 10/21/2015 SJ Standard Edition"
// CREATED		"Wed Apr 06 11:28:33 2016"

module semafor(
	line,
	strobe,
	divider,
	red,
	yellow,
	green
);


input wire	line;
input wire	strobe;
input wire	[1:0] divider;
output wire	red;
output wire	yellow;
output wire	green;

wire	[1:0] s;
wire	[7:0] SYNTHESIZED_WIRE_0;

wire	[3:0] GDFX_TEMP_SIGNAL_0;


assign	GDFX_TEMP_SIGNAL_0 = {divider[1:0],s[1:0]};


dec	b2v_inst1(
	.clk(line),
	.clr(strobe),
	.divisor(SYNTHESIZED_WIRE_0),
	.contr(s),
	.red(red),
	.yellow(yellow),
	.green(green));
	defparam	b2v_inst1.m = 8;


periodrom	b2v_inst2(
	.clock(line),
	.address(GDFX_TEMP_SIGNAL_0),
	.q(SYNTHESIZED_WIRE_0));


endmodule
