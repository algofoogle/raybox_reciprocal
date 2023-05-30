`default_nettype none
`timescale 1ns / 1ps

module lzc24_tb;
    initial begin
        $dumpfile ("lzc24.vcd");
        $dumpvars (0, lzc24);
        #1;
    end
endmodule
