module keyexpansion_tb();

	logic clk;
	logic [127:0] prev_key;
	logic [127:0] new_key;
	logic [3:0] round;
	
	keyexpansion ke(prev_key, round, clk, new_key);
	
	
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
	
	initial begin
		#12;
		prev_key = 128'h2b7e151628aed2a6abf7158809cf4f3c; 
		round = 1; #12;
		assert(new_key == 128'ha0fafe1788542cb123a339392a6c7605) else $error("test 1 output prev_key = %h, new_key = %h, exp = %h", prev_key, new_key, 128'ha0fafe1788542cb123a339392a6c7605); #10;
			
	end
endmodule

		
	
