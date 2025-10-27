module XTIMES_tb();
	logic [7:0] in;
	logic [7:0] out;
	logic clk;
	
	XTIMES xt(in, out);
	
	
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
	
	initial begin
		#5;
		in = 8'h57; #5;
		assert(out == 8'hae) else $error("test 1 output word = %h, rotword = %h, exp = %h", in, out, 8'hae); #10;
		
		#5;
		in = 8'hae; #5;
		assert(out == 8'h47) else $error("test 1 output word = %h, rotword = %h, exp = %h", in, out, 8'h47); #10;
		
	end
endmodule

		
	
