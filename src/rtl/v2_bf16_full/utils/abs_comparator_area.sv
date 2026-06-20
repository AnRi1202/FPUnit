import FpuPkg::*;

// 4-byte segmented abs comparator: FP32 / BF16x2 / FP8x4
module AbsComparator (
    input  FpFmt_e     fmt,
    input  FpVec_u     operandX,
    input  FpVec_u     operandY,
    output logic [3:0] swap
);
    logic [7:0] x0, x1, x2, x3;
    logic [7:0] y0, y1, y2, y3;

    logic [8:0] s0, s1, s2, s3;
    logic       c0, c1, c2, c3;
    logic       cin1, cin2, cin3;

    always_comb begin
        x0 = operandX.fp8x4.lane0;
        x1 = operandX.fp8x4.lane1;
        x2 = operandX.fp8x4.lane2;
        x3 = operandX.fp8x4.lane3;

        y0 = operandY.fp8x4.lane0;
        y1 = operandY.fp8x4.lane1;
        y2 = operandY.fp8x4.lane2;
        y3 = operandY.fp8x4.lane3;

        x3[7] = 1'b0;
        y3[7] = 1'b0;
        if (fmt != FMT_FP32) begin
            x1[7] = 1'b0;
            y1[7] = 1'b0;
        end
        if (fmt == FMT_FP8) begin
            x0[7] = 1'b0;
            y0[7] = 1'b0;
            x2[7] = 1'b0;
            y2[7] = 1'b0;
        end

        s0   = {1'b0, x0} + {1'b0, ~y0} + 9'd1;
        c0   = s0[8];

        cin1 = (fmt == FMT_FP8) ? 1'b1 : c0;
        s1   = {1'b0, x1} + {1'b0, ~y1} + {8'd0, cin1};
        c1   = s1[8];

        cin2 = (fmt == FMT_FP32) ? c1 : 1'b1;
        s2   = {1'b0, x2} + {1'b0, ~y2} + {8'd0, cin2};
        c2   = s2[8];

        cin3 = (fmt == FMT_FP8) ? 1'b1 : c2;
        s3   = {1'b0, x3} + {1'b0, ~y3} + {8'd0, cin3};
        c3   = s3[8];

        swap = {~c3, ~c2, ~c1, ~c0};
    end
endmodule


// BF16x2 only: 2-segment compare (no FP8/FP32 fmt mux)
module AbsComparator_bf16 (
    input  FpVec_u     operandX,
    input  FpVec_u     operandY,
    output logic       swap_hi,
    output logic       swap_lo
);
    logic [15:0] x_lo, y_lo;
    logic [14:0] x_hi, y_hi;

    logic [16:0] sub_lo;
    logic        c_lo;
    logic [15:0] sub_hi;
    logic        c_hi;

    always_comb begin
        x_lo = operandX.lanes.lo;
        x_hi = operandX.lanes.hi[14:0];
        y_lo = operandY.lanes.lo;
        y_hi = operandY.lanes.hi[14:0];

        x_lo[15] = 1'b0;
        y_lo[15] = 1'b0;
    end

    assign sub_lo = {1'b0, x_lo} + {1'b0, ~y_lo} + 17'd1;
    assign c_lo   = sub_lo[16];

    assign sub_hi = {1'b0, x_hi} + {1'b0, ~y_hi} + {15'd0, 1'b1};
    assign c_hi   = sub_hi[15];

    assign swap_lo = ~c_lo;
    assign swap_hi = ~c_hi;
endmodule
