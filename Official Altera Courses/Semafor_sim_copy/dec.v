module dec(clk, clr, divider, red, yellow, green);

	parameter m = 8;
	localparam comb = 0;
	
	input clk, clr;
	input [1:0] divider;
	output red, yellow, green;
	
	wire [m-1:0] divisor;
	reg [m-1:0] cntdiv;
	reg [1:0] contr;
	reg enacnt;
	reg [2:0]colors; 
	
	periodrom	b2v_inst2(
	.clock(clk),
	.address({divider, contr}),
	.q(divisor));

//	assign {red, yellow, green} = colors;
	assign red = colors[2];
	assign yellow = colors[1];
	assign green = colors[0];
	
/*-----------------------------------------------------*/
	generate 
		if(!comb)
		begin : contr_reg
			always @ (posedge clk or posedge clr)
			begin
				if (clr) contr<=0;
				else
				begin
					if (enacnt)
					begin
						if (contr!=3) contr<=contr+1'b1;
					end
				end
			end
			
		end
		else 
		begin : contr_comb
			always @ (*)
			begin
				case (colors)
					3'b010: contr = 1;
					3'b011: contr = 2;
					3'b001: contr = 3;
					default: contr = 0;
				endcase
			end
		end
	endgenerate
/*-----------------------------------------------------*/
	always @ (posedge clk or posedge clr)
	begin
		if (clr) cntdiv<=0;
		else
		begin
			if (cntdiv==divisor) cntdiv<=0;
			else cntdiv<=cntdiv+1'b1;
		end
	end
/*-----------------------------------------------------*/	
/*	always @ (*)
	begin
		red = colors[2];
		yellow = colors[1];
		green = colors[0];
	end
*/	
/*-----------------------------------------------------*/	
	always @ (*)
	begin
		enacnt=(cntdiv==divisor);
	end
/*-----------------------------------------------------*/
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
					default: colors<=3'b100;
				endcase
				
			end
		end
	end
	
endmodule
