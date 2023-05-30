`default_nettype none
`timescale 1ns / 1ps

module lzc4(
    input   [3:0]   x,  // Input.
    output          a,  // All zero?
    output  [1:0]   z   // If not a, then how many zeroes?
);
    assign z[0] = ~x[3] & x[2] | ~x[3] & ~x[1];
    assign z[1] = ~(x[3] | x[2]);
    assign a = ~|x;
endmodule


module lze6(
    input   [5:0]   a,  // "All zero" inputs from lzc4 modules; 6x4 = 24-bit.
    output          q,  // "All zeroes" general output. If 1, y is invalid.
    output  [2:0]   y   // Upper 3 bits of zero count.
);
    //NOTE: This is a simplification of the BNE in this paper:
    // http://iris.elf.stuba.sk/JEEEC/data/pdf/6_115-05.pdf
    // ...but it might be better to later use their actual gates as presented.
    assign q = &a;
    assign y[2] = &a[3:0];
    assign y[1] = a[0] & a[1] & (~a[2] | ~a[3] | (a[4] & a[5]));
    assign y[0] = (a[0] & (~a[1] | (a[2] & ~a[3]))) | (a[0] & a[2] & a[4]);
endmodule


module lzc24(
    input   [23:0]  x,
    output  [4:0]   z,  
    output          a   // All zeroes.
);
    wire        a0, a1, a2, a3, a4, a5;
    wire [1:0]  z0, z1, z2, z3, z4, z5;
    wire [2:0]  y;

    lzc4 n0(.x(x[23:20]), .a(a0), .z(z0));
    lzc4 n1(.x(x[19:16]), .a(a1), .z(z1));
    lzc4 n2(.x(x[15:12]), .a(a2), .z(z2));
    lzc4 n3(.x(x[11: 8]), .a(a3), .z(z3));
    lzc4 n4(.x(x[ 7: 4]), .a(a4), .z(z4));
    lzc4 n5(.x(x[ 3: 0]), .a(a5), .z(z5));

    lze6 lze(.a({a5,a4,a3,a2,a1,a0}), .q(a), .y(y));

    function [1:0] mux(input [2:0] s, d0, d1, d2, d3, d4, d5);
        case(s)
            0: mux = d0;
            1: mux = d1;
            2: mux = d2;
            3: mux = d3;
            4: mux = d4;
            5: mux = d5;
        endcase
    endfunction

    assign z[4:2] = a ? 3'b110 : y;
    assign z[1:0] = a ? 2'b0 : mux(y, z0, z1, z2, z3, z4, z5);
endmodule
