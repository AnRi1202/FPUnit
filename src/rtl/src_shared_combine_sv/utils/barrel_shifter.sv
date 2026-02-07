import fpall_pkg::*;

/*
===============================================================================
Barrel Shifter for Shared FP32 / Dual-FP16 Datapath
-------------------------------------------------------------------------------
This shifter is shared between:
  - FP32   : single 26-bit fraction path
  - FP16x2 : dual-lane segmented fraction path (lane isolation via a zero gap)

Implementation note:
  - Logarithmic barrel shifter (staged shifts: 16/8/4/2/1).
  - One shared shift network serves both FP32 and FP16x2 modes.

Input packing expectation:
  - FP32 (fmt == FP32):
      `X` represents the single FP32 fraction payload.
      `X26` conceptually corresponds to { frac[23:0], guard, sticky }.
  - FP16 (fmt == FP16):
      FP16x2 is interpreted in the 26-bit widened vector `X26` (after
      `X26 = { X, 2'b00 }`) as two 10-bit lanes separated by a 6-bit zero gap:
        lane.hi -> X26[25:16] = { frac_hi[7:0], guard_hi, sticky_hi }
        gap     -> X26[15:10] = 6'b0
        lane.lo -> X26[9:0]   = { frac_lo[7:0], guard_lo, sticky_lo }

      NOTE: This module does not repack lanes; correct lane+gap packing is an
      upstream responsibility.

Shift amount encoding (`S`):
  - FP32 : shift_amt = S[4:0]  (0–31)
  - FP16 : shift_hi  = S[7:4]  (0–15), shift_lo = S[3:0] (0–15)

Output (`R`):
  - `R[25:0]` is the shifted result in the same `X26` layout.
    - FP32  : 26-bit shifted fraction path
    - FP16x2: lane.hi in `R[25:16]`, zero gap in `R[15:10]`, lane.lo in `R[9:0]`

Sticky outputs:
  - Sticky_h : valid only in FP16 mode (upper lane)
  - Sticky_l : FP32 = global sticky; FP16 = lower-lane sticky
===============================================================================
*/

module barrel_shifter(
    input  fp_fmt_e    fmt,
    input  logic [23:0] X,
    input  logic [7:0]  S,
    output logic [25:0] R,
    output logic        Sticky_h,
    output logic        Sticky_l
);
    // stage levels
    logic [25:0] level5;
    logic [12:0] level4_h, level4_l;
    logic [12:0] level3_h, level3_l;
    logic [12:0] level2_h, level2_l;
    logic [12:0] level1_h, level1_l;
    logic [12:0] level0_h, level0_l;

    // stage sticky bits
    logic stk4_h, stk4_l;
    logic stk3_h, stk3_l;
    logic stk2_h, stk2_l;
    logic stk1_h, stk1_l;
    logic stk0_h, stk0_l;

    // input widening (24b -> 26b)
    logic [25:0] X26;
    assign X26 = {X, 2'b00};
    assign level5  = X26;

    // shift control
    logic [4:0] steps_h, steps_l;
    logic [12:0] level0_h_out;  

    // Shift control
    assign steps_h = (fmt == FP32) ? S[4:0] : {1'b0, S[7:4]};
    assign steps_l = (fmt == FP32) ? S[4:0] : {1'b0, S[3:0]};

    always_comb begin
        // Stage 4: shift by 16 (FP32 only)
        stk4_h  = 1'b0;
        stk4_l  = (fmt == FP32) && S[4] && (|level5[15:0]);

        // Split 26-bit into two 13-bit halves and shift by 16 if enabled
        {level4_h,level4_l} = steps_h[4] ? {16'b0, level5[25:16]} : level5[25:0];


        // Stage 3: shift by 8
        stk3_h   = (fmt == FP16) && steps_h[3] && (|level4_h[7:0]);
        stk3_l   = stk4_l | (steps_l[3] & (|level4_l[7:0]));

        // Upper half shift
        level3_h = steps_h[3] ? {8'b0, level4_h[12:8]} : level4_h;
        // Lower half shift
        if (fmt ==FP32) begin
            level3_l = steps_l[3] ? {level4_h[7:0], level4_l[12:8]} : level4_l;
        end else begin
            level3_l = steps_l[3] ? {8'b0, level4_l[12:8]} : level4_l;
        end

        // Stage 2: shift by 4
        stk2_h   = stk3_h | ((fmt == FP16) && steps_h[2] && (|level3_h[3:0]));
        stk2_l   = stk3_l | (steps_l[2] & (|level3_l[3:0]));
        level2_h = steps_h[2] ? {4'b0, level3_h[12:4]} : level3_h;
        if (fmt == FP32) begin
            level2_l = steps_l[2] ? {level3_h[3:0], level3_l[12:4]} : level3_l;
        end else begin
            level2_l = steps_l[2] ? {4'b0, level3_l[12:4]} : level3_l;
        end

        // Stage 1: shift by 2
        stk1_h   = stk2_h | ((fmt == FP16) && steps_h[1] && (|level2_h[1:0]));
        stk1_l   = stk2_l | (steps_l[1] & (|level2_l[1:0]));
        level1_h = steps_h[1] ? {2'b0, level2_h[12:2]} : level2_h;
        if (fmt == FP32) begin
            level1_l = steps_l[1] ? {level2_h[1:0], level2_l[12:2]} : level2_l;
        end else begin
            level1_l = steps_l[1] ? {2'b0, level2_l[12:2]} : level2_l;
        end

        // Stage 0: shift by 1
        stk0_h   = stk1_h | ((fmt == FP16) && steps_h[0] && (|level1_h[0]));
        stk0_l   = stk1_l | (steps_l[0] & level1_l[0]);
        level0_h = steps_h[0] ? {1'b0, level1_h[12:1]} : level1_h;
        if (fmt == FP32) begin
            level0_l = steps_l[0] ? {level1_h[0], level1_l[12:1]} : level1_l;
        end else begin
            level0_l = steps_l[0] ? {1'b0, level1_l[12:1]} : level1_l;
        end

        // In FP16 mode, lower 3 bits of upper lane are masked (lane width = 10b)
        level0_h_out = level0_h;
        if (fmt == FP16) level0_h_out[2:0] = 3'b0;
        R = {level0_h_out, level0_l};

        Sticky_h =(stk0_h | (|level0_h[2:0]));
        Sticky_l = stk0_l;
        
    end

endmodule

module barrel_shifter_gpt(
    input  logic        clk,      // unused (kept for interface compatibility)
    input  fp_fmt_e      fmt,
    input  logic [23:0]  X,
    input  logic [7:0]   S,
    output logic [25:0]  R,
    output logic         Sticky_h,
    output logic         Sticky_l
);

    // ============================================================
    // FP32 path (26-bit, 5-stage: 16/8/4/2/1)
    // ============================================================
    logic [25:0] v5, v4, v3, v2, v1, v0;
    logic        st4_32, st3_32, st2_32, st1_32, st0_32;
    logic [4:0]  sh32;

    always_comb begin
        sh32 = S[4:0];

        v5 = {X, 2'b00};  // internal 26-bit work vector

        // shift by 16
        st4_32 = sh32[4] & (|v5[15:0]);
        v4     = sh32[4] ? {16'b0, v5[25:16]} : v5;

        // shift by 8
        st3_32 = st4_32 | (sh32[3] & (|v4[7:0]));
        v3     = sh32[3] ? {8'b0,  v4[25:8]}  : v4;

        // shift by 4
        st2_32 = st3_32 | (sh32[2] & (|v3[3:0]));
        v2     = sh32[2] ? {4'b0,  v3[25:4]}  : v3;

        // shift by 2
        st1_32 = st2_32 | (sh32[1] & (|v2[1:0]));
        v1     = sh32[1] ? {2'b0,  v2[25:2]}  : v2;

        // shift by 1
        st0_32 = st1_32 | (sh32[0] &  v1[0]);
        v0     = sh32[0] ? {1'b0,  v1[25:1]}  : v1;
    end

    // ============================================================
    // FP16 path (two independent 10-bit lanes, 4-stage: 8/4/2/1)
    //   lane = {frac[7:0], guard, sticky} (guard/sticky start as 0 here)
    // ============================================================
    logic [3:0]  sh_hi, sh_lo;

    logic [9:0]  hi5, hi3, hi2, hi1, hi0;
    logic [9:0]  lo5, lo3, lo2, lo1, lo0;

    logic        st3_hi, st2_hi, st1_hi, st0_hi;
    logic        st3_lo, st2_lo, st1_lo, st0_lo;

    always_comb begin
        sh_hi = S[7:4];
        sh_lo = S[3:0];

        // Explicit repack from X to guarantee lane definition (ignore X[15:8])
        hi5 = {X[23:16], 2'b00};
        lo5 = {X[7:0],   2'b00};

        // ---- shift by 8
        st3_hi = sh_hi[3] & (|hi5[7:0]);
        hi3    = sh_hi[3] ? {8'b0, hi5[9:8]} : hi5;

        st3_lo = sh_lo[3] & (|lo5[7:0]);
        lo3    = sh_lo[3] ? {8'b0, lo5[9:8]} : lo5;

        // ---- shift by 4
        st2_hi = st3_hi | (sh_hi[2] & (|hi3[3:0]));
        hi2    = sh_hi[2] ? {4'b0, hi3[9:4]} : hi3;

        st2_lo = st3_lo | (sh_lo[2] & (|lo3[3:0]));
        lo2    = sh_lo[2] ? {4'b0, lo3[9:4]} : lo3;

        // ---- shift by 2
        st1_hi = st2_hi | (sh_hi[1] & (|hi2[1:0]));
        hi1    = sh_hi[1] ? {2'b0, hi2[9:2]} : hi2;

        st1_lo = st2_lo | (sh_lo[1] & (|lo2[1:0]));
        lo1    = sh_lo[1] ? {2'b0, lo2[9:2]} : lo2;

        // ---- shift by 1
        st0_hi = st1_hi | (sh_hi[0] &  hi1[0]);
        hi0    = sh_hi[0] ? {1'b0, hi1[9:1]} : hi1;

        st0_lo = st1_lo | (sh_lo[0] &  lo1[0]);
        lo0    = sh_lo[0] ? {1'b0, lo1[9:1]} : lo1;
    end

    // ============================================================
    // Output select (fmt mux ONLY here)
    // ============================================================
    logic [25:0] R16;
    logic        Sticky_h16, Sticky_l16;

    always_comb begin
        // FP16 output pack:
        //   - mask lane.hi[2:0] to 0 on R (lane width constraint)
        //   - keep those bits for Sticky_h computation
        R16       = { hi0, 6'b0, lo0 };
        Sticky_h16= st0_hi;
        Sticky_l16= st0_lo;

        if (fmt == FP32) begin
            R        = v0;
            Sticky_h = 1'b0;
            Sticky_l = st0_32;
        end else begin
            R        = R16;
            Sticky_h = Sticky_h16;
            Sticky_l = Sticky_l16;
        end
    end

endmodule