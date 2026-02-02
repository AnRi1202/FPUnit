module shifter_area_cell (
    input  logic        clk,
    input  logic        fmt,     // 0: FP32, 1: FP16
    input  logic [7:0]  S,       // shift amount
    input  logic [25:0] X,

    output logic [25:0] R,
    output logic        dummy_out
);

    // --------------------------------------------------
    // Prevent optimization
    // --------------------------------------------------
    (* dont_touch = "true" *) logic [25:0] level8;
    (* dont_touch = "true" *) logic [25:0] level4;
    (* dont_touch = "true" *) logic [25:0] level2;
    (* dont_touch = "true" *) logic [25:0] level1;

    (* dont_touch = "true" *) logic [3:0]  S_l;
    (* dont_touch = "true" *) logic [3:0]  S_fmt;

    (* dont_touch = "true" *) logic b0, b1, b2, b3;

    // --------------------------------------------------
    // 8,4,2,1 mux barrel
    // --------------------------------------------------
    assign level8 = S[3] ? {8'b0, X[25:8]}  : X;
    assign level4 = S[2] ? {4'b0, level8[25:4]} : level8;
    assign level2 = S[1] ? {2'b0, level4[25:2]} : level4;
    assign level1 = S[0] ? {1'b0, level2[25:1]} : level2;

    // --------------------------------------------------
    // 4bit mux (S_l selected by fmt)
    // --------------------------------------------------
    assign S_fmt = fmt ? S[3:0] : S[3:0]; // force real mux
    assign S_l   = fmt ? S_fmt : S_fmt;  // dummy fanout keep

    // --------------------------------------------------
    // 1bit mux *4
    // --------------------------------------------------
    assign b0 = fmt ? S_l[0] : S_l[0];
    assign b1 = fmt ? S_l[1] : S_l[1];
    assign b2 = fmt ? S_l[2] : S_l[2];
    assign b3 = fmt ? S_l[3] : S_l[3];

    // --------------------------------------------------
    // Output
    // --------------------------------------------------
    assign R = level1;
    assign dummy_out = b0 ^ b1 ^ b2 ^ b3;

endmodule
