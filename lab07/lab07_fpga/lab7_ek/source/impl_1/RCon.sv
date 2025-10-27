module RCon(input logic [3:0] i,
			output logic [31:0] rconi);
	
	always_comb begin
		case(i)
			4'b0001:	rconi = 31'h01000000;
			4'b0010:	rconi = 31'h02000000;
			4'b0011:	rconi = 31'h04000000;
			4'b0100:	rconi = 31'h08000000;
			4'b0101:	rconi = 31'h10000000;
			4'b0110:	rconi = 31'h20000000;
			4'b0111:	rconi = 31'h40000000;
			4'b1000:	rconi = 31'h80000000;
			4'b1001:	rconi = 31'h1b000000;
			4'b1010:	rconi = 31'h36000000;
			default 	rconi = 31'h00000000;
		endcase
	end			
endmodule

