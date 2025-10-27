module ROTWORD(input logic [31:0] word,
			   output logic [31:0] rotword);
			   
	// ROTWORD([a0, a1, a2, a3]) = [a1, a2, a3, a0]
	assign rotword = {word[23:16], word[15:8], word[7:0], word[31:24]};
					
endmodule
			   



				