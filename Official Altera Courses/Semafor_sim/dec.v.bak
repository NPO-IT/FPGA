module dec(clk, clr, divisor, contr);

	parameter m = 8;
	
	input clk, clr;
	input [m-1:0] divisor;
	output [1:0] contr;
	
	reg [m-1:0] cntdiv;
	reg [1:0] contr;
	reg enacnt;

	always @ (posedge clk or posedge clr)
	begin
		if (clr) cntdiv<=0;
		else
		begin
			if (cntdiv==divisor) cntdiv<=0;
			else cntdiv<=cntdiv+1;
		end
	end
	
	always @ (*)
	begin
		enacnt=(cntdiv==divisor);
	end
	
	always @ (posedge clk or posedge clr)
	begin
		if (clr) contr<=0;
		else
		begin
			if (enacnt)
			begin
				if (contr!=3) contr<=contr+1;
			end
		end
	end
	
endmodule
