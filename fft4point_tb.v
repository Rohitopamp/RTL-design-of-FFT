`timescale 1ns/1ps

module fft4point_tb;

    // DUT inputs
    reg  signed [15:0] x0r, x0i;
    reg  signed [15:0] x1r, x1i;
    reg  signed [15:0] x2r, x2i;
    reg  signed [15:0] x3r, x3i;

    // DUT outputs
    wire signed [15:0] X0r, X0i;
    wire signed [15:0] X1r, X1i;
    wire signed [15:0] X2r, X2i;
    wire signed [15:0] X3r, X3i;

    // Instantiate the FFT module
    fft4point dut (
        .x0r(x0r), .x0i(x0i),
        .x1r(x1r), .x1i(x1i),
        .x2r(x2r), .x2i(x2i),
        .x3r(x3r), .x3i(x3i),
        .X0r(X0r), .X0i(X0i),
        .X1r(X1r), .X1i(X1i),
        .X2r(X2r), .X2i(X2i),
        .X3r(X3r), .X3i(X3i)
    );

    initial begin
        $display(" 4 POINT FFT TESTBENCH START ");

        // Apply some test inputs
        // Example: input = {1, 2, 3, 4} with 0 imaginary part
        x0r = 16'sd1;   x0i = 16'sd0;
        x1r = 16'sd2;   x1i = 16'sd0;
        x2r = 16'sd3;   x2i = 16'sd0;
        x3r = 16'sd4;   x3i = 16'sd0;

        #10; // wait for outputs to settle

        $display("X0 = %d + j%d", X0r, X0i);
        $display("X1 = %d + j%d", X1r, X1i);
        $display("X2 = %d + j%d", X2r, X2i);
        $display("X3 = %d + j%d", X3r, X3i);

        // Another test with complex inputs
        #20;
        x0r = 16'sd10;  x0i = 16'sd5;
        x1r = 16'sd0;   x1i = -16'sd5;
        x2r = -16'sd3;  x2i = 16'sd2;
        x3r = 16'sd7;   x3i = -16'sd3;

        #10;
        $display(" COMPLEX INPUT TEST ");
        $display("X0 = %d + j%d", X0r, X0i);
        $display("X1 = %d + j%d", X1r, X1i);
        $display("X2 = %d + j%d", X2r, X2i);
        $display("X3 = %d + j%d", X3r, X3i);

        $display(" TEST COMPLETE ");
        $stop;
    end

endmodule
