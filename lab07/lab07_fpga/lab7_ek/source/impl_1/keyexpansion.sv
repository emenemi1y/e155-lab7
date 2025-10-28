module keyexpansion(input logic [127:0]  prev_key,
					input logic [3:0]   round,
					input logic 	    clk,
					output logic [127:0] new_key);
	
	// Get Rcon[i/Nk]
	logic [31:0] rconi;
	RCon constant(round, rconi);
	
	// ROTWORD(w[i-1]) for i is a multiple of Nk
	logic [31:0] rotword;
	ROTWORD rot(prev_key[31:0], rotword); 
	
	
	// SUBWORD(ROTWORD(w[i-1])) for i is a multiple of Nk
	logic [31:0] subword;
	sbox_sync sb[3:0](rotword, clk, subword);
	
	always_comb begin
		if (round == 0) new_key = prev_key;
		else begin
			new_key[127:96] = prev_key[127:96] ^ (subword ^ rconi);
			new_key[95:64] = prev_key[95:64] ^ (prev_key[127:96] ^ (subword ^ rconi));
			new_key[63:32] = prev_key[63:32] ^ (prev_key[95:64] ^ (prev_key[127:96] ^ (subword ^ rconi)));
			new_key[31:0] = prev_key[31:0] ^ (prev_key[63:32] ^ (prev_key[95:64] ^ (prev_key[127:96] ^ (subword ^ rconi))));
		end
	end

endmodule
			