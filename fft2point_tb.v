`timescale 1ns/1ps

module fft2point_tb;

    // DUT inputs
    reg  signed [15:0] x0r, x0i;
    reg  signed [15:0] x1r, x1i;

    // DUT outputs
    wire signed [15:0] X0r, X0i;
    wire signed [15:0] X1r, X1i;

     // Instantiate the FFT module
    fft2point dut (
        .x0r(x0r), .x0i(x0i),
        .x1r(x1r), .x1i(x1i),
        .X0r(X0r), .X0i(X0i),
        .X1r(X1r), .X1i(X1i)
    );

    initial begin
        $display("2 POINT FFT TESTBENCH START");

        // Apply some test inputs
        // Example: input = {1, 2} with 0 imaginary part
        x0r = 16'sd1;   x0i = 16'sd0;
        x1r = 16'sd2;   x1i = 16'sd0;

        #10; // wait for outputs to settle

        $display("X0 = %d + j%d", X0r, X0i);
        $display("X1 = %d + j%d", X1r, X1i);

        // Another test with complex inputs
        #20;
        x0r = 16'sd10;  x0i = 16'sd5;
        x1r = 16'sd0;   x1i = -16'sd5;

        #10;
        $display(" COMPLEX INPUT TEST ");
        $display("X0 = %d + j%d", X0r, X0i);
        $display("X1 = %d + j%d", X1r, X1i);

        $display(" TEST COMPLETE ");
        $stop;
    end

endmodule
