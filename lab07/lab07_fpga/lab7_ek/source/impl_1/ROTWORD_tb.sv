/////////////////////////////////////////////
// ROTWORD_tb
//   Testbench for ROTWORD module.
//   Author: Emily Kendrick
//   Email:  ekendrick@hmc.edu
//   Date:   10/28/25
/////////////////////////////////////////////

module ROTWORD_tb();
	logic [31:0] word, rotword;
	logic clk;
	
	ROTWORD rd(word, rotword);
	
	
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
	
	initial begin
		#5;
		word = 32'h09cf4f3c; #5;
		assert(word == 32'hcf4f3c09) else $error("test 1 output word = %h, rotword = %h, exp = %h", word, rotword, 32'hcf4f3c09); #10;
		
		#5;
		word = 32'h2a6c7605; #5;
		assert(word == 32'h6c76052a) else $error("test 1 output word = %h, rotword = %h, exp = %h", word, rotword, 32'h6c76052a); #10;
		
	end
endmodule

		
	
