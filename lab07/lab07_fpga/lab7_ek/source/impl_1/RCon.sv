module RCon(input logic [3:0] i,
			output logic [127:0] rconi);
	
	always_comb
		case(i)
			4'b0001:	rconi = 128'h01000000;
			4'b0010:	rconi = 128'h02000000;
			4'b0011:	rconi = 128'h04000000;
			4'b0100:	rconi = 128'h08000000;
			4'b0101:	rconi = 128'h10000000;
			4'b0110:	rconi = 128'h20000000;
			4'b0111:	rconi = 128'h40000000;
			4'b1000:	rconi = 128'h80000000;
			4'b1001:	rconi = 128'h1b000000;
			4'b1010:	rconi = 128'h36000000;
			default 	rconi = 128'h00000000;
		endcase
	end			
endmodule

