import FPALL_pkg::*;
/*
===============================================================================
Normalizer (Leading-Zero Count + Left Shift) for Shared FP32 / Dual-FP16 Datapath
-------------------------------------------------------------------------------
Normalizes the post-add fraction by:
  1) Leading-zero count (LZC)
  2) Left shift by the LZC result

Modes:
  - FP32   : single 28-bit lane (`X[27:0]`)
  - FP16x2 : two independent 14-bit lanes (`X[27:14]`, `X[13:0]`)

I/O:
  - Input  `X[27:0]` : concatenated fraction (includes sticky extension)
  - Output `R[27:0]` : normalized fraction
  - Output `Count_h` : valid only in FP16 mode 
  - Output `Count_l` : FP16x2 lo-lane LZC, or full 28-bit LZC in FP32

Datapath:
  - FP32   : LZC(28) on `X[27:0]` then cross-lane shift -> `R[27:0]`
  - FP16x2 : LZC(14) + shift on each lane independently

Notes:
  - Cross-lane shifting occurs only in FP32 mode.
  - FP16x2 lanes remain independent to reduce area/routing and avoid per-stage
    `fmt` multiplexers.
===============================================================================
*/
module normalizer(
    input  logic       clk,
    input  fp_fmt_e    fmt,
    input  logic [27:0] X,
    output logic [4:0]  Count_h,
    output logic [4:0]  Count_l,
    output logic [27:0] R
);

    // stage levels (14b hi/lo halves)
    logic [13:0] level4_h, level4_l;
    logic [13:0] level3_h, level3_l;
    logic [13:0] level2_h, level2_l;
    logic [13:0] level1_h, level1_l;
    logic [13:0] level0_h, level0_l;

    // stage count bits
    logic count4_h, count4_l;
    logic count3_h, count3_l;
    logic count2_h, count2_l;
    logic count1_h, count1_l;
    logic count0_h, count0_l;

    // Stage 4 decision (FP32-only shift-by-16)
    always_comb begin
        // Stage 4: shift by 16 (FP32 lane only)
        
        // "stage4 on" condition: FP32 mode AND upper 16b are all-zero
        count4_h = ((fmt == FP32) &&  ~(|X[27:12]));
        count4_l = 1'b0;                 // Stage4 is FP32-only, and Count_h is FP16-only
        {level4_h, level4_l} = ((fmt == FP32) && count4_h) ? {X[11:0], 16'b0} : X;

        // Stage 3: shift by 8
        count3_h = ~(|level4_h[13:6]);
        count3_l = (fmt ==FP32) ? count3_h :~(|level4_l[11:4]);
        if (fmt == FP32) begin
            level3_h = count3_h ? {level4_h[5:0],  level4_l[13:6]}: level4_h;
        end else begin 
            level3_h = count3_h ? {level4_h[5:2], 8'b0, 2'b0} : level4_h;
        end
        level3_l = count3_l ? {level4_l[5:0], 8'b0} : level4_l;

        // Stage 2: shift by 4            
        count2_h = ~(|level3_h[13:10]);
        count2_l = (fmt ==FP32) ? count2_h : ~(|level3_l[11:8]);
        if (fmt == FP32) begin
            level2_h = count2_h ? {level3_h[9:0],  level3_l[13:10]} :level3_h;
        end else begin 
            level2_h = count2_h ? {level3_h[9:2], 4'b0, 2'b0} : level3_h;
        end
        level2_l = count2_l ? {level3_l[9:0], 4'b0} : level3_l;
        // Stage 1: shift by 2
        count1_h = ~(|level2_h[13:12]);
        count1_l = (fmt ==FP32) ? count1_h :~(|level2_l[11:10]);
        if (fmt == FP32) begin
            level1_h = count1_h ? {level2_h[11:0],  level2_l[13:12]} : level2_h;
        end else begin 
            level1_h = count1_h ? {level2_h[11:2], 2'b0, 2'b0} : level2_h;
        end
        level1_l = count1_l ? {level2_l[11:0], 2'b0} : level2_l;
        // Stage 0: shift by 1
        count0_h = ~(|level1_h[13]);
        count0_l = (fmt ==FP32) ? count0_h : ~(|level1_l[11]);
        if (fmt == FP32) begin
            level0_h = count0_h ? {level1_h[12:0],  level1_l[13]}: level1_h;
        end else begin 
            level0_h = count0_h ? {level1_h[12:2], 1'b0, 2'b0} : level1_h;
        end
        level0_l = count0_l ? {level1_l[12:0], 1'b0} : level1_l;


        R = {level0_h, level0_l};
        Count_h = {count4_h, count3_h, count2_h, count1_h, count0_h};
        Count_l = {count4_l, count3_l, count2_l, count1_l, count0_l};
    end
endmodule


module normalizer_gpt(
    input  logic        clk,
    input  fp_fmt_e      fmt,
    input  logic [27:0]  X,
    output logic [4:0]   Count_h,
    output logic [4:0]   Count_l,
    output logic [27:0]  R
);

    // -------------------------
    // FP32 path: 28-bit LZC + left shift
    // -------------------------
    logic [4:0]  cnt28;
    logic [27:0] sh28;

    lzc_shift28 u_lzc28 (
        .X    (X),
        .Count(cnt28),
        .R    (sh28)
    );

    // -------------------------
    // FP16 path: 14-bit x 2 LZC + left shift (no cross-lane)
    // -------------------------
    logic [4:0]  cnt14_h, cnt14_l;
    logic [13:0] sh14_h,  sh14_l;

    lzc_shift14 u_lzc14_h (
        .X    (X[27:14]),
        .Count(cnt14_h),
        .R    (sh14_h)
    );

    lzc_shift14 u_lzc14_l (
        .X    (X[13:0]),
        .Count(cnt14_l),
        .R    (sh14_l)
    );

    // -------------------------
    // Select by fmt
    //   - FP32: Count_l meaningful, Count_h = 0
    //   - FP16: Count_h/Count_l meaningful
    // -------------------------
    always_comb begin
        if (fmt == FP32) begin
            R       = sh28;
            Count_l = cnt28;
            Count_h = 5'd0;
        end else begin
            R       = {sh14_h, sh14_l};
            Count_h = cnt14_h;
            Count_l = cnt14_l;
        end
    end

endmodule


// =========================================================
// 28-bit leading-zero normalizer: Count + left shift by Count
// shift stages: 16, 8, 4, 2, 1  (max 27)
// =========================================================
module lzc_shift28(
    input  logic [27:0] X,
    output logic [4:0]  Count,
    output logic [27:0] R
);
    logic [27:0] s16, s8, s4, s2, s1;

    logic c16, c8, c4, c2, c1;

    // stage 16
    assign c16 = ~(|X[27:12]);
    assign s16 = c16 ? {X[11:0], 16'b0} : X;

    // stage 8
    assign c8  = ~(|s16[27:20]);
    assign s8  = c8  ? {s16[19:0], 8'b0} : s16;

    // stage 4
    assign c4  = ~(|s8[27:24]);
    assign s4  = c4  ? {s8[23:0], 4'b0} : s8;

    // stage 2
    assign c2  = ~(|s4[27:26]);
    assign s2  = c2  ? {s4[25:0], 2'b0} : s4;

    // stage 1
    assign c1  = ~(|s2[27]);
    assign s1  = c1  ? {s2[26:0], 1'b0} : s2;

    assign R     = s1;
    assign Count = {c16, c8, c4, c2, c1};

endmodule


// =========================================================
// 14-bit leading-zero normalizer: Count + left shift by Count
// shift stages: 8, 4, 2, 1  (max 13)
// Count is still 5-bit for interface consistency: {0, c8, c4, c2, c1}
// =========================================================
module lzc_shift14(
    input  logic [13:0] X,
    output logic [4:0]  Count,
    output logic [13:0] R
);
    logic [13:0] s8, s4, s2, s1;

    logic c8, c4, c2, c1;

    // stage 8
    assign c8 = ~(|X[13:6]);
    assign s8 = c8 ? {X[5:0], 8'b0} : X;

    // stage 4
    assign c4 = ~(|s8[13:10]);
    assign s4 = c4 ? {s8[9:0], 4'b0} : s8;

    // stage 2
    assign c2 = ~(|s4[13:12]);
    assign s2 = c2 ? {s4[11:0], 2'b0} : s4;

    // stage 1
    assign c1 = ~(|s2[13]);
    assign s1 = c1 ? {s2[12:0], 1'b0} : s2;

    assign R     = s1;
    assign Count = {1'b0, c8, c4, c2, c1};

endmodule
