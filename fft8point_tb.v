`timescale 1ns/1ps

module fft8point_tb;

    
    // DUT Inputs (8 complex samples)
    
    reg signed [15:0] x0r, x0i;
    reg signed [15:0] x1r, x1i;
    reg signed [15:0] x2r, x2i;
    reg signed [15:0] x3r, x3i;
    reg signed [15:0] x4r, x4i;
    reg signed [15:0] x5r, x5i;
    reg signed [15:0] x6r, x6i;
    reg signed [15:0] x7r, x7i;

    
    // DUT Outputs (8 complex FFT bins)
    
    wire signed [15:0] X0r, X0i;
    wire signed [15:0] X1r, X1i;
    wire signed [15:0] X2r, X2i;
    wire signed [15:0] X3r, X3i;
    wire signed [15:0] X4r, X4i;
    wire signed [15:0] X5r, X5i;
    wire signed [15:0] X6r, X6i;
    wire signed [15:0] X7r, X7i;

    // Instantiate FFT8 DUT
    fft8point dut (
        .x0r(x0r), .x0i(x0i),
        .x1r(x1r), .x1i(x1i),
        .x2r(x2r), .x2i(x2i),
        .x3r(x3r), .x3i(x3i),
        .x4r(x4r), .x4i(x4i),
        .x5r(x5r), .x5i(x5i),
        .x6r(x6r), .x6i(x6i),
        .x7r(x7r), .x7i(x7i),
        .X0r(X0r), .X0i(X0i),
        .X1r(X1r), .X1i(X1i),
        .X2r(X2r), .X2i(X2i),
        .X3r(X3r), .X3i(X3i),
        .X4r(X4r), .X4i(X4i),
        .X5r(X5r), .X5i(X5i),
        .X6r(X6r), .X6i(X6i),
        .X7r(X7r), .X7i(X7i)
    );

    
    // Test procedure
    
    initial begin
        $display(" 8-POINT FFT TESTBENCH START ");

        
        // Test Case 1: Real input sequence {1,2,3,4,5,6,7,8}
        
        x0r = 1;  x0i = 0;
        x1r = 2;  x1i = 0;
        x2r = 3;  x2i = 0;
        x3r = 4;  x3i = 0;
        x4r = 5;  x4i = 0;
        x5r = 6;  x5i = 0;
        x6r = 7;  x6i = 0;
        x7r = 8;  x7i = 0;

        #10;

        $display("\n Test Case 1: Real input 1..8 ");
        print_fft_outputs();

        
        // Test Case 2: Random complex values
        
        #20;
        x0r = 10;  x0i = -3;
        x1r = -5;  x1i = 7;
        x2r = 2;   x2i = 1;
        x3r = -8;  x3i = 4;
        x4r = 6;   x4i = -2;
        x5r = 1;   x5i = 5;
        x6r = -3;  x6i = -6;
        x7r = 9;   x7i = 4;

        #10;

        $display("\n Test Case 2: Complex random input ");
        print_fft_outputs();

        $display("\n TEST COMPLETE ");
        $stop;
    end

    
    // Task for printing FFT outputs

    task print_fft_outputs;
    begin
        $display("X0 = %d + j%d", X0r, X0i);
        $display("X1 = %d + j%d", X1r, X1i);
        $display("X2 = %d + j%d", X2r, X2i);
        $display("X3 = %d + j%d", X3r, X3i);
        $display("X4 = %d + j%d", X4r, X4i);
        $display("X5 = %d + j%d", X5r, X5i);
        $display("X6 = %d + j%d", X6r, X6i);
        $display("X7 = %d + j%d", X7r, X7i);
    end
    endtask

endmodule

