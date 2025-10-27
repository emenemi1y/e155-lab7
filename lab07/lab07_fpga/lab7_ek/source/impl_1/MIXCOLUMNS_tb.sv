module MIXCOLUMNS_tb();
	logic [127:0] a;
	logic [127:0] y;
	logic clk;
	
	MIXCOLUMNS mc(a, y);
	
	
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
	
	initial begin
		#5;
		a = 128'hd4bf5d30e0b452aeb84111f11e2798e5; #5;
		assert(y == 128'h046681e5e0cb199a48f8d37a2806264c) else $error("test 1 output word = %h, rotword = %h, exp = %h", a, y, 128'h046681e5e0cb199a48f8d37a2806264c); #10;
		
		#5;
		a = 128'h49db873b453953897f02d2f177de961a; #5;
		assert(y == 128'h584dcaf11b4b5aacdbe7caa81b6bb0e5) else $error("test 1 output word = %h, rotword = %h, exp = %h", a, y, 128'h584dcaf11b4b5aacdbe7caa81b6bb0e5); #10;
		
	end
endmodule

		
	
