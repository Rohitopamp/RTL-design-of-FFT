module fft2point(
    input signed [15:0] x0r, x0i,
    input signed [15:0] x1r, x1i,
	output signed [15:0] X0r, X0i,
    output signed [15:0] X1r, X1i
);
	
	assign X0r = x0r + x1r;
    assign X0i = x0i + x1i;

	assign X1r = x0r - x1r;
    assign X1i = x0i - x1i;

endmodule
