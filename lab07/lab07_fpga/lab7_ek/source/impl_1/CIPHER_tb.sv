/////////////////////////////////////////////
// CIPHER_tb
//   Testbench for cipher fsm 
//   Author: Emily Kendrick
//   Email:  ekendrick@hmc.edu
//   Date:   10/28/25
/////////////////////////////////////////////

module CIPHER_tb();
	logic [3:0] round;
	logic reset, clk, load, cipherComplete, incrementRound, keyUpdate;
	logic [3:0] operation;
	
	CIPHER dut(round, reset, clk, load, cipherComplete, incrementRound, keyUpdate, operation);
	
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
	
	initial begin
		#12;
		load = 1'b1;
		round = 4'b1;
		reset = 1;
		round = 1; #12;
		
		load = 1'b0;
		round = 4'b1;
		#100;
		round = 4'd10;
		#12;
			
	end
endmodule

		
	
