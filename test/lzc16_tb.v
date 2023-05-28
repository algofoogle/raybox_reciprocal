`default_nettype none
`timescale 1ns / 1ps

module lzc16_tb;
    initial begin
        $dumpfile ("lzc16.vcd");
        $dumpvars (0, lzc16);
        #1;
    end
endmodule
