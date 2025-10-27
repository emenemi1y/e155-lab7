module SHIFTROWS(input logic [127:0] a,
				output logic [127:0] y);
				
	assign y[127:120] = a[127:120];	// s'0,0 = s0,0
	assign y[119:112] = a[87:80]; 	// s'1,0 = s1,1
	assign y[111:104] = a[47:40];   // s'2,0 = s2,2
	assign y[103:96]  = a[7:0]; 	// s'3,0 = s3,3
	
	assign y[95:88]   = a[95:88];  	// s'0,1 = s1,1
	assign y[87:80]   = a[55:48];  	// s'1,1 = s1,2
	assign y[79:72]   = a[15:8]; 	// s'2,1 = s2,3
	assign y[71:64]   = a[103:96];  // s'3,1 = s3,0
	
	assign y[63:56]   = a[63:56];   // s'0,2 = s0,2
	assign y[55:48]   = a[23:16]; 	// s'1,2 = s1,3
	assign y[47:40]   = a[111:104];	// s'2,2 = s2,0
	assign y[39:32]   = a[71:64];  	// s'3,2 = s3,1
	
	assign y[31:24]   = a[31:24]; 	// s'0,3 = s0,3
	assign y[23:16]   = a[119:112]; // s'1,3 = s1,0
	assign y[15:8] 	  = a[79:72]; 	// s'2,3 = s2,1
	assign y[7:0] 	  = a[39:32]; 	// s'3,3 = s3,2
					
endmodule