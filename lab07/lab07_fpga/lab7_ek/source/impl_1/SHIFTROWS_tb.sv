/////////////////////////////////////////////
// SHIFTROWS_tb
//   Testbench for the SHIFTROWS module.
//   Author: Emily Kendrick
//   Email:  ekendrick@hmc.edu
//   Date:   10/28/25
/////////////////////////////////////////////

module SHIFTROWS_tb();
	logic [127:0] a;
	logic [127:0] y;
	logic clk;
	
	SHIFTROWS sr(a, y);
	
	
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
	
	initial begin
		#5;
		a = 128'hd42711aee0bf98f1b8b45de51e415230; #5;
		assert(y == 128'hd4bf5d30e0b452aeb84111f11e2798e5) else $error("test 1 output word = %h, rotword = %h, exp = %h", a, y, 128'hd4bf5d30e0b452aeb84111f11e2798e5); #10;
		
		#5;
		a = 128'h49ded28945db96f17f39871a7702533b; #5;
		assert(y == 128'h49db873b453953897f02d2f177de961a) else $error("test 1 output word = %h, rotword = %h, exp = %h", a, y, 128'h49db873b453953897f02d2f177de961a); #10;
		
	end
endmodule

		
	
