// aes128_keyexp_seq.sv
//
// Sequential/pipelined AES-128 KeyExpansion round using a 1-cycle-latency SubWord.
// - Inputs: prev_key (128 bits), round_num (4 bits), start (pulse)
// - Output: next_key (128 bits), valid (1-cycle pulse) when next_key is available
// - clk / rst_n required because SubWord is sequential
//
// Behavior:
//  cycle N   : start=1 -> latch prev_key, round_num; feed RotWord output to SubWord.in
//  cycle N+1 : SubWord.out valid -> compute next_key combinationally, assert valid=1
//
// Assumes: RotWord is combinational. SubWord has ports (input logic [31:0] in, output logic [31:0] out, input logic clk)
//          SubWord samples 'in' on rising clock and produces 'out' after one clock cycle.
//
// Adapt if your SubWord has slightly different port names.

module aes128_keyexp_seq (
  input  logic         clk,
  input  logic         rst_n,      // active-low reset (synchronous)
  input  logic         start,      // single-cycle pulse to start expansion using prev_key, round_num
  input  logic [127:0] prev_key,   // prev_key[127:96]=w0, [95:64]=w1, [63:32]=w2, [31:0]=w3
  input  logic  [3:0]  round_num,  // 1..10 for AES-128
  output logic [127:0] next_key,   // next 128-bit key (available when valid==1)
  output logic         valid       // single-cycle pulse indicating next_key is ready
);

  // Word registers to hold the latched previous key
  logic [31:0] w0_r, w1_r, w2_r, w3_r;
  logic [31:0] rcon_r;

  // Rcon table (32-bit words; only first 10 used for AES-128)
  localparam logic [31:0] RCON [1:10] = '{
    32'h01000000, // Rcon[1]
    32'h02000000, // Rcon[2]
    32'h04000000, // Rcon[3]
    32'h08000000, // Rcon[4]
    32'h10000000, // Rcon[5]
    32'h20000000, // Rcon[6]
    32'h40000000, // Rcon[7]
    32'h80000000, // Rcon[8]
    32'h1b000000, // Rcon[9]
    32'h36000000  // Rcon[10]
  };

  // Internal signals
  logic [31:0] rot_w3;         // RotWord(w3_r) - combinational
  logic [31:0] sub_rot_w3;     // output from SubWord (available 1 cycle after rot_w3 fed)
  logic [31:0] temp;
  logic        busy;          // indicates a start has been accepted and waiting for SubWord
  
  logic [31:0] t0, t1, t2, t3;

  // Instantiate RotWord (combinational)
  // RotWord should be a combinational module: .in (32) -> .out (32)
  ROTWORD rotword_inst (
    .a (w3_r),
    .y(rot_w3)
  );

  // Instantiate SubWord (sequential, 1 cycle latency)
  // SubWord should sample rot_w3 on rising edge of clk and produce sub_rot_w3 next cycle.
  SUBWORD subword_inst (
    .a  (rot_w3),
	.clk (clk),
    .y (sub_rot_w3)
  );

  // Latch inputs when start asserted and not busy.
  // We use synchronous logic (rising edge) and synchronous reset.
  always_ff @(posedge clk) begin
    if (!rst_n) begin
      w0_r   <= 32'h0;
      w1_r   <= 32'h0;
      w2_r   <= 32'h0;
      w3_r   <= 32'h0;
      rcon_r <= 32'h0;
      busy   <= 1'b0;
      valid  <= 1'b0;
      next_key <= 128'h0;
    end else begin
      // Default valid is deasserted unless set below
      valid <= 1'b0;

      // Accept start when not already busy
      if (start && !busy) begin
        // latch the previous key words
        w0_r <= prev_key[127:96];
        w1_r <= prev_key[95:64];
        w2_r <= prev_key[63:32];
        w3_r <= prev_key[31:0];

        // latch Rcon (clamp to 0 outside 1..10)
        if (round_num >= 1 && round_num <= 10)
          rcon_r <= RCON[round_num];
        else
          rcon_r <= 32'h00000000;

        // indicate we're waiting for SubWord output next cycle
        busy <= 1'b1;
      end else if (busy) begin
        // On the cycle after start, SubWord.out (sub_rot_w3) is valid.
        // Compute temp and next words combinationally and register outputs.
        temp = sub_rot_w3 ^ rcon_r;  // use non-blocking style not needed since temp is a reg in 'always_ff', but we assign directly

        // compute w4..w7
        t0 = w0_r ^ temp;
        t1 = t0   ^ w1_r;
        t2 = t1   ^ w2_r;
        t3 = t2   ^ w3_r;

        next_key <= { t0, t1, t2, t3 };
        valid    <= 1'b1;

        // clear busy to accept next start
        busy <= 1'b0;
      end
      // else: idle, do nothing
    end
  end

endmodule



module SUBWORD(input logic [31:0] a,
				input logic clk,
				output logic [31:0] y);
				
	sbox_sync sb[3:0](a, clk, y);

endmodule
