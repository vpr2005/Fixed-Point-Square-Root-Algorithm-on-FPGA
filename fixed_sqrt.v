module fixed_sqrt #(
  parameter WIDTH = 16,
  parameter FRAC  = 8
)(
  input  wire clk,
  input  wire rst,
  input  wire start,
  input  wire [WIDTH-1:0] x_in,
  output reg  [WIDTH-1:0] sqrt_out,
  output reg  done
);
  // Sequential non-restoring digit-by-digit sqrt.
  reg [2*WIDTH-1:0] rem;
  reg [WIDTH-1:0] root;
  reg [5:0] iter;
  reg running;

  wire [WIDTH-1:0] x_ext = x_in;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      rem <= 0;
      root <= 0;
      iter <= 0;
      sqrt_out <= 0;
      done <= 0;
      running <= 0;
    end else begin
      if (start && !running) begin
        // initialize: align input to the MSB side in rem
        rem <= { {(WIDTH){1'b0}}, x_ext }; // place x in lower half
        root <= 0;
        iter <= WIDTH; // number of bits to produce
        done <= 0;
        running <= 1;
      end else if (running) begin
        if (iter > 0) begin
          // trial = (root << 1) | 1  placed in upper half for comparison
          // shift rem left by 2 (equiv to bringing next 2 bits)
          rem <= rem << 2;
          // compute trial
          // trial aligned to rem width: (root << (WIDTH+1)) | (1 << WIDTH)
          // simplified comparison and update using combinational logic could be used
          // for clarity we use arithmetic operations:
          if (rem >= ({root, 2'b01} << (WIDTH-1))) begin
            rem <= rem - ({root, 2'b01} << (WIDTH-1));
            root <= (root << 1) | 1'b1;
          end else begin
            // non-restoring add step (conceptual)
            root <= (root << 1);
          end
          iter <= iter - 1;
        end else begin
          sqrt_out <= root;
          done <= 1;
          running <= 0;
        end
      end
    end
  end
endmodule
