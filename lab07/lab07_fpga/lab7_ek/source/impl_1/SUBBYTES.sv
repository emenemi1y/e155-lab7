/////////////////////////////////////////////
// SUBBYTES
//   The transformation of the state that applies the S-box independently to each byte of the state. 
//   Author: Emily Kendrick
//   Email:  ekendrick@hmc.edu
//   Date:   10/28/25
/////////////////////////////////////////////

module SUBBYTES(input logic [127:0] a,
				input logic clk,
				output logic [127:0] y);
				
	sbox_sync sb[15:0](a, clk, y);

endmodule

				