`default_nettype none
`timescale 1ns / 1ps

module lzc4(
    input   [3:0]   x,
    output          a,
    output  [1:0]   z
);
    assign z[0] = ~x[3] & x[2] | ~x[3] & ~x[1];
    assign z[1] = ~(x[3] | x[2]);
    assign a = ~|x;
endmodule


module lze4(
    input   [3:0]   a,
    output  [1:0]   q
);
    assign q[0] = a[0] & (~a[1] | (a[2] & ~a[3]));
    assign q[1] = a[0] & a[1] & (~a[2] | ~a[3]);
endmodule


module lzc16(
    input   [15:0]  x,
    output  [3:0]   c
);
    wire [3:0] a;
    wire [7:0] z;
    lzc4 n0(.x(x[15:12]), .a(a[0]), .z(z[1:0]));
    lzc4 n1(.x(x[11: 8]), .a(a[1]), .z(z[3:2]));
    lzc4 n2(.x(x[ 7: 4]), .a(a[2]), .z(z[5:4]));
    lzc4 n3(.x(x[ 3: 0]), .a(a[3]), .z(z[7:6]));
    lze4 lze(.a(a), .q(c[3:2]));

    function [1:0] mux(input [1:0] s, z0, z1, z2, z3);
        case(s)
            0: mux = z0;
            1: mux = z1;
            2: mux = z2;
            3: mux = z3;
        endcase
    endfunction

    assign c[1:0] = mux(c[3:2], z[1:0], z[3:2], z[5:4], z[7:6]);
endmodule
