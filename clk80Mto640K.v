/*
	Ivan I. Ovchinnikov
	last upd.: 2016.02.20
*/

module clk80Mto640K(			// divider by 125
    input wire clkIN,			// 80MHz clock
    output reg clkOUT = 1'b0	// awesome 640KHz result
    );

reg [6:0] count=1'b0;

always @ (posedge clkIN)
begin
	count <= count + 1'b1;		// count every clock
	if(count == 63)				// if counted half phase
		clkOUT <= 1;			// set a high level on output
	else if(count == 124) begin	// if counted a full phase
		count<=0;				// reset counter for the next clock
		clkOUT <=0;				// set a low output level
	end
end
endmodule
