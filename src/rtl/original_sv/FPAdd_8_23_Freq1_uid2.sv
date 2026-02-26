`timescale 1ns/1ps
// =============================================================================
// RightShifterSticky24_by_max_26_Freq1_uid4
// Direct SV translation of FloPoCo-generated VHDL
// 24-bit input, right shift by up to 26, with sticky bit
// =============================================================================
module RightShifterSticky24_by_max_26_Freq1_uid4 (
    input  logic        clk,
    input  logic [23:0] X,
    input  logic [4:0]  S,
    output logic [25:0] R,
    output logic        Sticky
);
    logic [4:0]  ps;
    logic [25:0] Xpadded;
    logic [25:0] level5, level4, level3, level2, level1, level0;
    logic        stk4, stk3, stk2, stk1, stk0, stk;

    assign ps      = S;
    assign Xpadded = {X, 2'b00};
    assign level5  = Xpadded;

    assign stk4   = (level5[15:0] != 16'h0000) && ps[4];
    assign level4  = ps[4] ? {16'h0000, level5[25:16]} : level5;

    assign stk3   = ((level4[7:0] != 8'h00) && ps[3]) || stk4;
    assign level3  = ps[3] ? {8'h00, level4[25:8]} : level4;

    assign stk2   = ((level3[3:0] != 4'h0) && ps[2]) || stk3;
    assign level2  = ps[2] ? {4'h0, level3[25:4]} : level3;

    assign stk1   = ((level2[1:0] != 2'b00) && ps[1]) || stk2;
    assign level1  = ps[1] ? {2'b00, level2[25:2]} : level2;

    assign stk0   = (level1[0] && ps[0]) || stk1;
    assign level0  = ps[0] ? {1'b0, level1[25:1]} : level1;

    assign stk    = stk0;
    assign R      = level0;
    assign Sticky = stk;
endmodule


// =============================================================================
// IntAdder_27_Freq1_uid6
// 27-bit adder with carry-in
// =============================================================================
module IntAdder_27_Freq1_uid6 (
    input  logic        clk,
    input  logic [26:0] X,
    input  logic [26:0] Y,
    input  logic        Cin,
    output logic [26:0] R
);
    assign R = X + Y + 27'(Cin);
endmodule


// =============================================================================
// Normalizer_Z_28_28_28_Freq1_uid8
// 28-bit leading-zero count + left shift normalizer
// =============================================================================
module Normalizer_Z_28_28_28_Freq1_uid8 (
    input  logic        clk,
    input  logic [27:0] X,
    output logic [4:0]  Count,
    output logic [27:0] R
);
    logic [27:0] level5, level4, level3, level2, level1, level0;
    logic        count4, count3, count2, count1, count0;
    logic [4:0]  sCount;

    assign level5  = X;

    assign count4  = (level5[27:12] == 16'h0000);
    assign level4  = count4 ? {level5[11:0], 16'h0000} : level5;

    assign count3  = (level4[27:20] == 8'h00);
    assign level3  = count3 ? {level4[19:0], 8'h00} : level4;

    assign count2  = (level3[27:24] == 4'h0);
    assign level2  = count2 ? {level3[23:0], 4'h0} : level3;

    assign count1  = (level2[27:26] == 2'b00);
    assign level1  = count1 ? {level2[25:0], 2'b00} : level2;

    assign count0  = (level1[27] == 1'b0);
    assign level0  = count0 ? {level1[26:0], 1'b0} : level1;

    assign R      = level0;
    assign sCount = {count4, count3, count2, count1, count0};
    assign Count  = sCount;
endmodule


// =============================================================================
// IntAdder_34_Freq1_uid11
// 34-bit adder with carry-in (used for rounding)
// =============================================================================
module IntAdder_34_Freq1_uid11 (
    input  logic        clk,
    input  logic [33:0] X,
    input  logic [33:0] Y,
    input  logic        Cin,
    output logic [33:0] R
);
    assign R = X + Y + 34'(Cin);
endmodule


// =============================================================================
// FPAdd_8_23_Freq1_uid2
// FloPoCo FP32 adder (34-bit FloPoCo format: [33:32]=exc, [31]=sign,
// [30:23]=exp, [22:0]=frac)
// Direct SV translation of FPAdd_Kin_f1_origin.vhdl
// =============================================================================
module FPAdd_8_23_Freq1_uid2 (
    input  logic        clk,
    input  logic [33:0] X,
    input  logic [33:0] Y,
    output logic [33:0] R
);
    // Exception+Exp+Frac shorthand (drop sign bit for comparison)
    logic [32:0] excExpFracX, excExpFracY;
    logic        swap;
    logic [7:0]  eXmeY, eYmeX, expDiff;
    logic [33:0] newX, newY;
    logic [7:0]  expX;
    logic [1:0]  excX, excY;
    logic        signX, signY, EffSub;
    logic [5:0]  sXsYExnXY;
    logic [3:0]  sdExnXY;
    logic [23:0] fracY;
    logic [1:0]  excRt;
    logic        signR;
    logic        shiftedOut;
    logic [4:0]  shiftVal;
    logic [25:0] shiftedFracY;
    logic        sticky;
    logic [26:0] fracYpad, EffSubVector, fracYpadXorOp, fracXpad;
    logic        cInSigAdd;
    logic [26:0] fracAddResult;
    logic [27:0] fracSticky;
    logic [4:0]  nZerosNew;
    logic [27:0] shiftedFrac;
    logic [8:0]  extendedExpInc;
    logic [9:0]  updatedExp;
    logic        eqdiffsign;
    logic [33:0] expFrac;
    logic        stk, rnd, lsb, needToRound;
    logic [33:0] RoundedExpFrac;
    logic [1:0]  upExc;
    logic [22:0] fracR;
    logic [7:0]  expR;
    logic [3:0]  exExpExc;
    logic [1:0]  excRt2, excR;
    logic        signR2;
    logic [33:0] computedR;

    // Exception+frac comparison (sign bit excluded)
    assign excExpFracX = {X[33:32], X[30:0]};
    assign excExpFracY = {Y[33:32], Y[30:0]};

    // Swap so |newX| >= |newY|
    assign swap    = (excExpFracX < excExpFracY);
    assign eXmeY   = X[30:23] - Y[30:23];
    assign eYmeX   = Y[30:23] - X[30:23];
    assign expDiff = swap ? eYmeX : eXmeY;
    assign newX    = swap ? Y : X;
    assign newY    = swap ? X : Y;

    // Decompose
    assign expX    = newX[30:23];
    assign excX    = newX[33:32];
    assign excY    = newY[33:32];
    assign signX   = newX[31];
    assign signY   = newY[31];
    assign EffSub  = signX ^ signY;

    assign sXsYExnXY = {signX, signY, excX, excY};
    assign sdExnXY   = {excX, excY};

    // fracY: 0 if Y is zero (excY==00), else hidden bit + frac
    assign fracY = (excY == 2'b00) ? 24'h000000 : {1'b1, newY[22:0]};

    // Exception result logic (same truth table as original VHDL)
    always_comb begin
        case (sXsYExnXY)
            6'b000000, 6'b010000, 6'b100000, 6'b110000: excRt = 2'b00;
            6'b000101, 6'b010101, 6'b100101, 6'b110101,
            6'b000100, 6'b010100, 6'b100100, 6'b110100,
            6'b000001, 6'b010001, 6'b100001, 6'b110001: excRt = 2'b01;
            6'b111010, 6'b001010, 6'b001000, 6'b011000,
            6'b101000, 6'b111000, 6'b000010, 6'b010010,
            6'b100010, 6'b110010, 6'b001001, 6'b011001,
            6'b101001, 6'b111001, 6'b000110, 6'b010110,
            6'b100110, 6'b110110:                        excRt = 2'b10;
            default:                                     excRt = 2'b11;
        endcase
    end

    assign signR = ((sXsYExnXY == 6'b100000) || (sXsYExnXY == 6'b010000)) ? 1'b0 : signX;

    // Shift amount (cap at 26)
    assign shiftedOut = (expDiff > 8'd25);
    assign shiftVal   = shiftedOut ? 5'd26 : expDiff[4:0];

    // Right-shift fracY with sticky
    RightShifterSticky24_by_max_26_Freq1_uid4 RightShifterComponent (
        .clk    (clk),
        .X      (fracY),
        .S      (shiftVal),
        .R      (shiftedFracY),
        .Sticky (sticky)
    );

    // Prepare significand adder inputs
    assign fracYpad      = {1'b0, shiftedFracY};          // 27-bit
    assign EffSubVector  = {27{EffSub}};
    assign fracYpadXorOp = fracYpad ^ EffSubVector;
    assign fracXpad      = {2'b01, newX[22:0], 2'b00};    // 27-bit
    assign cInSigAdd     = EffSub & (~sticky);

    // Significand addition
    IntAdder_27_Freq1_uid6 fracAdder (
        .clk (clk),
        .X   (fracXpad),
        .Y   (fracYpadXorOp),
        .Cin (cInSigAdd),
        .R   (fracAddResult)
    );

    assign fracSticky = {fracAddResult, sticky};

    // Normalize (LZC + left-shift)
    Normalizer_Z_28_28_28_Freq1_uid8 LZCAndShifter (
        .clk   (clk),
        .X     (fracSticky),
        .Count (nZerosNew),
        .R     (shiftedFrac)
    );

    // Exponent update
    assign extendedExpInc = {1'b0, expX} + 9'd1;
    assign updatedExp     = {1'b0, extendedExpInc} - {5'b00000, nZerosNew};
    assign eqdiffsign     = (nZerosNew == 5'b11111);

    // Pack exp+frac for rounding adder
    assign expFrac = {updatedExp, shiftedFrac[26:3]};
    assign stk     = shiftedFrac[2] | shiftedFrac[1] | shiftedFrac[0];
    assign rnd     = shiftedFrac[3];
    assign lsb     = shiftedFrac[4];
    assign needToRound = (rnd & stk) | (rnd & ~stk & lsb);

    // Rounding adder
    IntAdder_34_Freq1_uid11 roundingAdder (
        .clk (clk),
        .X   (expFrac),
        .Y   (34'h0),
        .Cin (needToRound),
        .R   (RoundedExpFrac)
    );

    // Unpack rounded result
    assign upExc  = RoundedExpFrac[33:32];
    assign fracR  = RoundedExpFrac[23:1];
    assign expR   = RoundedExpFrac[31:24];

    // Final exception resolution
    assign exExpExc = {upExc, excRt};
    always_comb begin
        case (exExpExc)
            4'b0000, 4'b0100, 4'b1000, 4'b1100,
            4'b1001, 4'b1101: excRt2 = 2'b00;
            4'b0001:          excRt2 = 2'b01;
            4'b0010, 4'b0110, 4'b1010, 4'b1110,
            4'b0101:          excRt2 = 2'b10;
            default:          excRt2 = 2'b11;
        endcase
    end

    assign excR   = (eqdiffsign && EffSub && (excRt != 2'b11)) ? 2'b00 : excRt2;
    assign signR2 = (eqdiffsign && EffSub) ? 1'b0 : signR;

    assign computedR = {excR, signR2, expR, fracR};
    assign R         = computedR;

endmodule
