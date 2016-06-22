module dec(clk, clr, divisor, contr, red, yellow, green);

	parameter m = 8;
	
	input clk, clr;
	input [m-1:0] divisor;
	output [1:0] contr;
	output red, yellow, green;
	
	reg [m-1:0] cntdiv;
	reg [1:0] contr;
	reg enacnt;
	
	reg [2:0]colors;

	assign {red, yellow, green} = colors;
	
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
	
	always @ (posedge clk or posedge clr)
	begin
		if (clr) colors<=3'b100;
		else
		begin
			if (enacnt)
			begin
				case (colors)
					3'b100: colors <= 3'b010;
					3'b010: colors <= 3'b011;
					3'b011: colors <= 3'b001;
				endcase
			end
		end
	end
endmodule
