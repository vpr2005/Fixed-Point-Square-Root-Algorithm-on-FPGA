`timescale 1ns/1ps
module tb_fixed_sqrt;
  reg clk = 0;
  always #5 clk = ~clk;
  reg rst;
  reg start;
  reg [15:0] x_in;
  wire [15:0] sqrt_out;
  wire done;

  fixed_sqrt dut(.clk(clk), .rst(rst), .start(start), .x_in(x_in), .sqrt_out(sqrt_out), .done(done));

  integer i;
  real expected, actual, err;
  initial begin
    rst = 1; start = 0; x_in = 0;
    #20 rst = 0;
    // Run 100 random tests
    for (i=0; i<100; i=i+1) begin
      x_in = $urandom_range(0, 16'hFFFF);
      start = 1; @(posedge clk); start = 0;
      // wait for done
      wait (done);
      // compute expected sqrt in real domain
      expected = $sqrt($itor(x_in) / 256.0); // Q8.8 -> real
      actual = $itor(sqrt_out) / 256.0;
      if (expected != 0.0) begin
        err = 100.0 * (expected - actual) / expected;
        if (err < 0) err = -err;
        if (err > 1.0) begin
          $display("FAIL: input=%0d (%0f) exp=%0f act=%0f err=%0f%%", x_in, x_in/256.0, expected, actual, err);
          $finish;
        end
      end
      #10;
    end
    $display("All %0d tests passed", i);
    $finish;
  end
endmodule
