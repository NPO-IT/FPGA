begin_group Verilog HDL
begin_group User
begin_template Signal Detector
reg	[2:0]		<detectorRegister>;
wire				<signalFront>;
wire				<signalRear>;
always@(posedge <clock_signal> or negedge <reset>) begin
	if (~<reset>) begin <detectorRegister> <= 3'b0; end
	else begin <detectorRegister> <= { <detectorRegister>[1:0],  <incomingSignal> }; end
end
assign	<signalFront>	=	(!<detectorRegister>[2] & <detectorRegister>[1]);
assign	<signalRear>	=	(<detectorRegister>[2] & !<detectorRegister>[1]);
end_template
end_group 
end_group 
