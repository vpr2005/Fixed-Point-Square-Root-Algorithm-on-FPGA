// tb_sqrt_nonrestoring.v

`timescale 1ns/1ps

module tb_sqrt_nonrestoring;

reg clk = 0;
reg rst;
reg start;
reg [15:0] x_in;
wire [7:0] sqrt_out;
wire done;

sqrt_nonrestoring uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .x_in(x_in),
    .sqrt_out(sqrt_out),
    .done(done)
);

always #5 clk = ~clk;

initial begin
    rst = 1; start = 0; x_in = 0;
    #20;
    rst = 0;

    repeat (5) begin
        @(posedge clk);
        x_in = 16'h0100; // 1.0 in Q8.8
        start = 1;
        @(posedge clk); start = 0;
        wait (done);
        $display("sqrt(1.0)= %f", sqrt_out / 16.0); // Q4.4 -> real
    end

    @(posedge clk);
    x_in = 16'h1000; // 16.0 in Q8.8
    start = 1;
    @(posedge clk); start = 0;
    wait (done);
    $display("sqrt(16.0)= %f", sqrt_out / 16.0);

    @(posedge clk);
    x_in = 16'h0400; // 4.0
    start = 1;
    @(posedge clk); start = 0;
    wait (done);
    $display("sqrt(4.0)= %f", sqrt_out / 16.0);

    #50;
    $finish;
end

endmodule
