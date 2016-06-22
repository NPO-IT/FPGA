module sinus(inclk, phase_up, phase_dn, fouta, foutd);

	// Input Port(s)
	input inclk;
	input phase_up, phase_dn;
	

	output fouta, foutd;
	//output DAC_out;

	// Additional Module Item(s)
	wire clr; assign clr = 1;
	wire [7:0]phinc;
	wire [7:0]middle;
	wire [7:0]toDAC;
	wire result;
	assign fouta = result;
	assign foutd = result;
	
pll oscdiv(
	.inclk0(inclk),
	.c0(clk)
	);
	
buttons detector(
	.reset(clr),
	.clk(clk),
	.phase_up(phase_up),
	.phase_dn(phase_dn),
	.phinc(phinc)
	);
	defparam detector.DEFAULT = 1;
	
LUT	ROM1PORT(
	.clock(clk),
	.address(middle),
	.q(toDAC)
	);

accumulator phaseacc(
	.clk(clk),
	.clrn(clr),
	.phinc(phinc),
	.phase(middle)
	);
	defparam phaseacc.m = 28;

ds_DAC deltasigma(
	.clk(clk),
	.clrn(clr),
	.value(toDAC),
	.DAC_out(result)
	);

endmodule
