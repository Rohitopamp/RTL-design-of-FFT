module fft4point(
    input  signed [15:0] x0r, x0i, // real and imag part of signal required
    input  signed [15:0] x1r, x1i,
    input  signed [15:0] x2r, x2i,
    input  signed [15:0] x3r, x3i,
    output signed [15:0] X0r, X0i,
    output signed [15:0] X1r, X1i,
    output signed [15:0] X2r, X2i,
    output signed [15:0] X3r, X3i
);

    // Stage 1 
    wire signed [15:0] A0r = x0r + x2r;
    wire signed [15:0] A0i = x0i + x2i;

    wire signed [15:0] A1r = x0r - x2r;
    wire signed [15:0] A1i = x0i - x2i;

    wire signed [15:0] B0r = x1r + x3r;
    wire signed [15:0] B0i = x1i + x3i;

    wire signed [15:0] Dr  = x1r - x3r;
    wire signed [15:0] Di  = x1i - x3i;

    // W4^1 = -j
    wire signed [15:0] B1r =  Di;
    wire signed [15:0] B1i = -Dr;

    // Stage 2 
    assign X0r = A0r + B0r;
    assign X0i = A0i + B0i;

    assign X2r = A0r - B0r;
    assign X2i = A0i - B0i;

    assign X1r = A1r + B1r;
    assign X1i = A1i + B1i;

    assign X3r = A1r - B1r;
    assign X3i = A1i - B1i;

endmodule

