// This is just a wrapper to ensure we synthesise a Q12.12 instance and that
// it doesn't trigger OpenLane issues with negative vector bit indices.

module reciprocal_12_12 (
    input   wire [23:0] i_data,
    input   wire        i_abs,  // 1=we want the absolute value only.
    output  wire [23:0] o_data,
    output  wire        o_sat   // 1=saturated
);
    reciprocal #(.M(12), .N(12)) rcp1212 (
        .i_data (i_data),
        .i_abs  (i_abs),
        .o_data (o_data),
        .o_sat  (o_sat)
    );
endmodule
