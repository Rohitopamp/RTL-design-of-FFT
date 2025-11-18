# RTL-design-of-FFT
This project implements FFT (Fast Fourier Transform) architecture in Verilog. The design includes butterfly units stages, fixed-point data handling, and verified testbenches for functional correctness. The RTL is fully synthesizable and suitable for FPGA. Simulation results validate the FFT operation for 2-point, 4-point, and 8-point FFT..
README: Fixed-Point FFT Verilog Modules

1. Overview

This project contains combinational Verilog implementations of:

2-point FFT

4-point FFT

8-point FFT

Each FFT module uses radix-2 decimation-in-time (DIT) algorithm with fixed-point signed representation.

Testbenches are included for each module to verify correctness.

2. Input/Output Format
Property	Description
Input	Each sample is complex: real + imaginary part.
Bit-width	Each part is signed 16-bit (signed [15:0]).
Module Ports	Example (4-point FFT):
x0r, x0i, x1r, x1i, x2r, x2i, x3r, x3i
Output	FFT result for each point: complex, signed 16-bit.
Output Ports	Example (4-point FFT):
X0r, X0i, X1r, X1i, X2r, X2i, X3r, X3i
3. Bit-width and Fixed-Point Representation

16-bit signed fixed-point (signed [15:0])

Real and imaginary parts are separate signals.

Twiddle factors (for 4- and 8-point FFT) are stored as 16-bit Q15 format.

Multiplications are handled using 32-bit intermediate results, then right-shifted 15 bits to maintain Q15 scale.

4. Verification Method

Testbench Simulation

Each module has an accompanying testbench:

fft2point_tb.v

fft4point_tb.v

fft8point_tb.v

Inputs are applied with reg signed [15:0].

Outputs are monitored via $display statements.

Both real-only and complex inputs are tested.

Expected Results

Outputs are compared against mathematical FFT calculation (manually or via Python/Matlab).

2-, 4-, and 8-point FFT results are verified for correctness with fixed-point approximation.

Optional Waveform Verification

Generate waveforms in ModelSim/Questa for signals:

vsim fft4point_tb
add wave *
run


Verify the complex outputs visually.

5. Simulation Notes

Timescale: `timescale 1ns/1ps

Use $finish at the end of testbench to end simulation, or $stop to pause and inspect waveforms.

Bit growth in multiplication is handled using 32-bit intermediate variables.

6. Usage

Compile the module and testbench:

vlog fft4point.v fft4point_tb.v
vsim fft4point_tb


Run simulation:

run 100


Observe FFT outputs in console or waveform viewer.

This README covers input/output format, bit-width, and verification method for 2-, 4-, and 8-point FFT Verilog modules.
