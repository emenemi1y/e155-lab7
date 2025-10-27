module XTIMES(input logic [7:0] in,
			  output logic [7:0] out);
			  
	always_comb begin
		if (in[7] == 0) begin
			out[7:1] = in[6:0];
			out[0] = 0;
		end
		else begin
			out = {in[6:0], 1'b0} ^ 8'b00011011;
		end
		
	end

endmodule