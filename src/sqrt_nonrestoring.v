// sqrt_nonrestoring.v
// Fixed-point square root (Q8.8) using non-restoring algorithm

module sqrt_nonrestoring (
    input              clk,
    input              rst,
    input              start,
    input       [15:0] x_in,     // Q8.8 input
    output reg  [7:0]  sqrt_out, // Q4.4 output
    output reg         done
);
    reg [31:0] remainder;
    reg [15:0] root;
    reg [4:0]  count;

    reg        busy;

    always @(posedge clk) begin
        if (rst) begin
            remainder <= 0;
            root      <= 0;
            count     <= 0;
            sqrt_out  <= 0;
            done      <= 0;
            busy      <= 0;
        end else if (start && !busy) begin
            remainder <= 0;
            root      <= 0;
            count     <= 8; // Number of bits to process
            busy      <= 1;
            done      <= 0;
        end else if (busy) begin
            remainder = {remainder[29:0], x_in[15-count], 1'b0};
            if (remainder[31:30] >= {root,2'b01}) begin
                remainder = remainder - {root,2'b01};
                root = {root[14:0],1'b1};
            end else begin
                root = {root[14:0],1'b0};
            end
            count = count - 1;

            if (count == 0) begin
                sqrt_out <= root[15:8]; // Extract Q4.4 output
                done <= 1;
                busy <= 0;
            end
        end
    end
endmodule
