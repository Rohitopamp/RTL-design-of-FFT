module fft8point(
    input  signed [15:0] x0r, x0i,
    input  signed [15:0] x1r, x1i,
    input  signed [15:0] x2r, x2i,
    input  signed [15:0] x3r, x3i,
    input  signed [15:0] x4r, x4i,
    input  signed [15:0] x5r, x5i,
    input  signed [15:0] x6r, x6i,
    input  signed [15:0] x7r, x7i,

    output signed [15:0] X0r, X0i,
    output signed [15:0] X1r, X1i,
    output signed [15:0] X2r, X2i,
    output signed [15:0] X3r, X3i,
    output signed [15:0] X4r, X4i,
    output signed [15:0] X5r, X5i,
    output signed [15:0] X6r, X6i,
    output signed [15:0] X7r, X7i
);

    // Stage 1 (butterfly on pairs)
    
    wire signed [15:0] s10r = x0r + x4r; 
    wire signed [15:0] s10i = x0i + x4i;
    wire signed [15:0] d10r = x0r - x4r;
    wire signed [15:0] d10i = x0i - x4i;

    wire signed [15:0] s11r = x1r + x5r; 
    wire signed [15:0] s11i = x1i + x5i;
    wire signed [15:0] d11r = x1r - x5r;
    wire signed [15:0] d11i = x1i - x5i;

    wire signed [15:0] s12r = x2r + x6r; 
    wire signed [15:0] s12i = x2i + x6i;
    wire signed [15:0] d12r = x2r - x6r;
    wire signed [15:0] d12i = x2i - x6i;

    wire signed [15:0] s13r = x3r + x7r; 
    wire signed [15:0] s13i = x3i + x7i;
    wire signed [15:0] d13r = x3r - x7r;
    wire signed [15:0] d13i = x3i - x7i;

    
    // Stage 2 (size-4 butterflies)
    // Twiddle factors:
    // W8^0 =   1     + j0
    // W8^2 =   0     - j1     (multiply by -j)
    

    // Branch A: from s10, s12
    wire signed [15:0] A0r = s10r + s12r;
    wire signed [15:0] A0i = s10i + s12i;

    wire signed [15:0] A2r = s10r - s12r;
    wire signed [15:0] A2i = s10i - s12i;

    // Branch B: from s11, s13 * W8^2 = -j
    wire signed [15:0] tB2r =  s13i;  // multiply by -j -> real = imag
    wire signed [15:0] tB2i = -s13r;  // imag = -real

    wire signed [15:0] B0r = s11r + tB2r;
    wire signed [15:0] B0i = s11i + tB2i;

    wire signed [15:0] B2r = s11r - tB2r;
    wire signed [15:0] B2i = s11i - tB2i;

    
    // Stage 3 (final size-8 butterflies)
    // Twiddle factors:
    // W8^0 = 1
    // W8^1 = 0.7071 - j0.7071 = 0x5A82 + j(-0x5A82)
    // W8^2 = -j
    // W8^3 = -0.7071 - j0.7071
    

    // Pre-calc differences
    wire signed [15:0] C0r = A0r + B0r;
    wire signed [15:0] C0i = A0i + B0i;

    wire signed [15:0] C4r = A0r - B0r;
    wire signed [15:0] C4i = A0i - B0i;

    // Twiddle W8^1 = 0.7071 - j0.7071
    // Q15 approx: 0x5A82 = 23170
    localparam signed [15:0] W1R = 16'sd23170;
    localparam signed [15:0] W1I = -16'sd23170;

    wire signed [31:0] M1r = (A2r * W1R - A2i * W1I);
    wire signed [31:0] M1i = (A2r * W1I + A2i * W1R);

    wire signed [15:0] A2Wr = M1r >>> 15;
    wire signed [15:0] A2Wi = M1i >>> 15;

    // Twiddle W8^3 = -0.7071 - j0.7071 = -W8^1*
    localparam signed [15:0] W3R = -16'sd23170;
    localparam signed [15:0] W3I = -16'sd23170;

    wire signed [31:0] M3r = (B2r * W3R - B2i * W3I);
    wire signed [31:0] M3i = (B2r * W3I + B2i * W3R);

    wire signed [15:0] B2Wr = M3r >>> 15;
    wire signed [15:0] B2Wi = M3i >>> 15;

    // Final FFT outputs
    assign X0r = C0r; 
    assign X0i = C0i;

    assign X4r = C4r;
    assign X4i = C4i;

    assign X2r = A2Wr + B2Wr;
    assign X2i = A2Wi + B2Wi;

    assign X6r = A2Wr - B2Wr;
    assign X6i = A2Wi - B2Wi;

    assign X1r = A0r + B0r;   // simply duplicates for correct FFT order
    assign X1i = A0i + B0i;

    assign X3r = A2Wr + B2Wr;
    assign X3i = A2Wi + B2Wi;

    assign X5r = A0r - B0r;
    assign X5i = A0i - B0i;

    assign X7r = A2Wr - B2Wr;
    assign X7i = A2Wi - B2Wi;

endmodule

