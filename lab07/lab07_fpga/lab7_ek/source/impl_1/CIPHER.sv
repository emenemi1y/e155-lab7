module CIPHER(input logic [3:0] round,
			  input logic reset,
			  input logic clk, load,
			  output logic cipherComplete,
			  output logic incrementRound,
			  output logic keyUpdate,
			  output logic [3:0] operation);
			  
	typedef enum logic [4:0] {start, addRoundKey, updateRound, updateKey, hold, subBytes, shiftRows, mixColumns, done} statetype;
	statetype state, nextstate;
	
	always_ff @(posedge clk)
		if (~reset) state <= start;
		else state <= nextstate;
			
	// Next state logic 
	always_comb
		case(state)
			start:			if (load)			nextstate = addRoundKey;
							else 				nextstate = start;
			addRoundKey:						nextstate = updateKey;
			updateKey: 	    if (round == 4'd10) nextstate = done;
							else				nextstate = updateRound;
			updateRound:						nextstate = subBytes;
			subBytes:							nextstate = hold;			// hold because subBytes takes a clock cycle
			hold:								nextstate = shiftRows;
			shiftRows: 		if (round == 4'd10) nextstate = addRoundKey;
							else 				nextstate = mixColumns;
			mixColumns:							nextstate = addRoundKey;
			default: 							nextstate = start;
		endcase
		
	// output logic 
	always_comb begin
		cipherComplete = (state == done);
		incrementRound = (state == updateRound);
		keyUpdate 	   = (state == updateKey);
		operation[0]   = (state == addRoundKey);
		operation[1]   = ((state == subBytes) | (state == hold));
		operation[2]   = (state == shiftRows);
		operation[3]   = (state == mixColumns);
	end

endmodule
			  
			  