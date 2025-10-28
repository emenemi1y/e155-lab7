module roundCounter(input logic incrementRound,
					input logic clk, reset,
					output logic [3:0] round);

	// Round counter
	always_ff @(posedge clk) begin
		if (reset == 0) round <= 0;
		else begin
			if (incrementRound) round <= round + 4'b1;
			else round <= round;
		end
	end
										
endmodule
