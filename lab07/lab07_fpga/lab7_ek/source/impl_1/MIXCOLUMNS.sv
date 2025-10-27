module MIXCOLUMNS(input logic a[127:0],
				  output logic y[127:0]);
	
	logic xt_bytes [127:0];
	XTIMES xt[15:0](a, xt_bytes);
				  
	always_comb begin			  
		for (int c = 0; c < 4; c++) begin
			// First row
			y[(127-8*(4*c)) +: 8] = xt_bytes[(127-8*4*c) +: 8] ^ (xt_bytes[(127-8*(1+4*c)) +: 8] ^ a[(127-8*(1+4*c)) +: 8]) ^ a[(127-8*(2+4*c)) +: 8] ^ a[(127-8*(3+4*c)) +: 8];
				
			// Second row
			y[(127-8*(4*c+1)) +: 8] = a[(127-8*(4*c)) +: 8] ^ xt_bytes[(127-8*(1+4*c)) +: 8] ^ (xt_bytes[(127-8*(2+4*c)) +: 8] ^ a[(127-8*(2+4*c)) +: 8]) ^ a[(127-8*(3+4*c)) +: 8];
				
			// Third row
			y[(127-8*(4*c+2)) +: 8] = a[(127-8*(4*c)) +: 8] ^ a[(127-8*(1+4*c)) +: 8] ^ xt_bytes[(127-8*(2+4*c)) +: 8] ^ (xt_bytes[(127-8*(3+4*c)) +: 8] ^ a[(127-8*(3+4*c)) +: 8]);
			
			// Fourth row
			y[(127-8*(4*c+3)) +: 8] = xt_bytes[(127-8*4*c) +: 8] ^ a[(127-8*4*c) +: 8] ^ a[(127-8*(1+4*c)) +: 8] ^ a[(127-8*(2+4*c)) +: 8] ^ xt_bytes[(127-8*(3+4*c)) +: 8];
		end
	end
				  
				  
endmodule