module keyexpansion(input logic [127:0]  prev_key,
					input logic [3:0]   round,
					input logic 	    clk,
					output logic [127:0] new_key);
	
	// Get Rcon[i/Nk]
	logic [31:0] rconi;
	RCon constant(round * 4 / 4, rconi);
	
	// ROTWORD(w[i-1]) for i is a multiple of Nk
	logic [31:0] rotword;
	ROTWORD rot(prev_key[127:96], rotword); 
	
	
	// SUBWORD(ROTWORD(w[i-1])) for i is a multiple of Nk
	logic [31:0] subword;
	sbox_sync sb[3:0](rotword, clk, subword);
	
	logic [31:0] newkey1, newkey2, newkey3, newkey4;
	assign newkey1 = prev_key[31:0] xor (subword xor rconi);
	assign newkey2 = prev_key[63:32] xor (prev_key[31:0] xor (subword xor rconi));
	assign newkey3 = prev_key[95:64] xor (prev_key[63:32] xor (prev_key[31:0] xor (subword xor rconi)));
	assign newkey4 = prev_key[127:96] xor (prev_key[95:64] xor (prev_key[63:32] xor (prev_key[31:0] xor (subword xor rconi))));
	
	always_comb begin
		new_key = {newkey1, newkey2, newkey3, newkey4};
	end
endmodule
			