module CIPHER(input logic [127:0] plaintext, key,
			  input logic [4:0] round,
			  input logic reset,
			  input logic clk,
			  output logic [127:0] ciphertext,
			  output logic updateRound);
			  
	typedef enum logic [3:0] {start, addRoundKey, UpdateRound, subBytes, shiftRows, mixColumns, done} statetype
	statetype state, nextstate;
	
	always_ff @(posedge clk)
		if (~reset) state <= start;
		else state <= nextstate;
			
	// Next state logic 
	always_comb
		case(state)
			start:			nextstate = addRoundKey;
			addRoundKey:	nextstate = updateRound;
			  
			  

endmodule
			  
			  