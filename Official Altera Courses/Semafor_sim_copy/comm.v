module comm(contr0, contr1, red, yellow, green);

	input contr0, contr1;
	output red, yellow, green;
	
	reg  red, yellow, green;
	
	always @ (*)
	begin
		case ({contr1,contr0}) 
		2'b00: begin red=1'b1; yellow=1'b0; green=1'b0; end
		2'b01: begin red=1'b0; yellow=1'b1; green=1'b0; end
		2'b10: begin red=1'b0; yellow=1'b1; green=1'b1; end
		2'b11: begin red=1'b0; yellow=1'b0; green=1'b1; end
		endcase
	end

endmodule


