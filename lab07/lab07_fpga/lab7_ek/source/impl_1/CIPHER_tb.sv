/////////////////////////////////////////////
// CIPHER_tb
//   Testbench for cipher fsm 
//   Author: Emily Kendrick
//   Email:  ekendrick@hmc.edu
//   Date:   10/28/25
/////////////////////////////////////////////

module CIPHER_tb();
	input logic [3:0] round;
	input logic reset, clk, load, cipherComplete, incrementRound, keyUpdate;
	output logic [3:0] operation;
	
	CIPHER dut(round, reset, clk, load, cipherComplete, incrementRound, keyUpdate, operation);
	
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

		
	
