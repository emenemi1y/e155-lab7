/////////////////////////////////////////////
// keyexpansion_seq_tb
//   Testbench for sequential AES-128 key expansion.
//   Author: Emily Kendrick
//   Email:  ekendrick@hmc.edu
//   Date:   10/28/25
/////////////////////////////////////////////

module keyexpansion_seq_tb();

  logic clk;
  logic rst_n;
  logic start;
  logic [127:0] prev_key;
  logic [127:0] next_key;
  logic [3:0]   round;
  logic         valid;

  // DUT instantiation
  aes128_keyexp_seq dut (
    .clk      (clk),
    .rst_n    (rst_n),
    .start    (start),
    .prev_key (prev_key),
    .round_num(round),
    .next_key (next_key),
    .valid    (valid)
  );

  // simple clock generator (10 ns period)
  always begin
    clk = 1; #5;
    clk = 0; #5;
  end

  // Test sequence
  initial begin
    // initialization
    rst_n   = 0;
    start   = 0;
    prev_key= 0;
    round   = 0;

    // deassert reset
    #15;
    rst_n = 1;
    #10;

    // --- Test 1 (from FIPS-197 Appendix A AES-128 example) ---
    // previous key = 2b7e151628aed2a6abf7158809cf4f3c
    // round = 1
    // expected next key = a0fafe1788542cb123a339392a6c7605
    prev_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    round    = 4'd1;

    // pulse start for one cycle
    start = 1; @(posedge clk);
    start = 0;

    // wait until valid goes high
    wait (valid === 1);
    @(posedge clk); // sample outputs on valid

    // check result
    assert (next_key == 128'ha0fafe1788542cb123a339392a6c7605)
      else $error("Test 1 FAILED: new_key = %h, expected = %h",
                   next_key, 128'ha0fafe1788542cb123a339392a6c7605);
    $display("Test 1 PASSED: new_key = %h", next_key);

    #20;
    $finish;
  end

endmodule