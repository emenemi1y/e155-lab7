module SUBBYTES(input logic [127:0] a,
				input logic clk,
				output logic [127:0] y);
				
	sbox_sync sb[15:0](a, clk, y);

endmodule

				