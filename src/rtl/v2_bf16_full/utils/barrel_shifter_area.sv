import FpuPkg::*;

// 4-lane segmented barrel shifter: FP32 / BF16x2 / FP8x4 (area measurement)
module BarrelShifter(
    input  FpFmt_e       fmt,
    input  logic [23:0]  operandX,
    input  logic [11:0]  shiftAmount,
    output logic [25:0]  result,
    output logic [3:0]   sticky
);
    logic [25:0] level5, level4, level3, level2, level1, level0;
    logic        stk0, stk1, stk2, stk3;
    logic [25:0] shifted;
    logic [4:0]  steps0, steps1, steps2, steps3;
    logic        prop07, prop13, prop20;
    logic [25:0] X26;

    always_comb begin: set_steps
        steps0 = '0;
        steps1 = '0;
        steps2 = '0;
        steps3 = '0;
        unique case (fmt)
            FMT_FP32: begin
                steps0 = shiftAmount[4:0];
                steps1 = steps0;
                steps2 = steps0;
                steps3 = steps0;
            end
            FMT_BF16: begin
                steps0 = {1'b0, shiftAmount[3:0]};
                steps1 = steps0;
                steps2 = {1'b0, shiftAmount[7:4]};
                steps3 = steps2;
            end
            FMT_FP8: begin
                steps0 = {2'b0, shiftAmount[2:0]};
                steps1 = {2'b0, shiftAmount[5:3]};
                steps2 = {2'b0, shiftAmount[8:6]};
                steps3 = {2'b0, shiftAmount[11:9]};
            end
            default: ;
        endcase
    end

    always_comb begin: bit_propagation
        prop07 = (fmt == FMT_FP8);
        prop13 = (fmt != FMT_FP32);
        prop20 = (fmt == FMT_FP8);
    end

    always_comb begin: barrel_core
        X26    = {operandX, 2'b00};
        level5 = X26;
        stk0   = 1'b0;
        stk1   = 1'b0;
        stk2   = 1'b0;
        stk3   = 1'b0;

        // stage by 16 : level5 -> level4
        shifted = level5 >> 16;
        shifted[6:0]  = shifted[6:0]  & {7{prop07}};
        shifted[12:0] = shifted[12:0] & {13{prop13}};
        shifted[19:4] = shifted[19:4] & {16{prop20}};
        stk0 |=           steps0[4] & (|level5[6:0]);
        stk1 |= !prop07 & steps1[4] & (|level5[12:7]);
        stk2 |= !prop13 & steps2[4] & (|level5[19:13]);
        stk3 |= !prop20 & steps3[4] & (|level5[25:20]);
        level4[6:0]   = steps0[4] ? shifted[6:0]   : level5[6:0];
        level4[12:7]  = steps1[4] ? shifted[12:7]  : level5[12:7];
        level4[19:13] = steps2[4] ? shifted[19:13] : level5[19:13];
        level4[25:20] = steps3[4] ? shifted[25:20] : level5[25:20];

        // stage by 8 : level4 -> level3
        shifted = level4 >> 8;
        shifted[6:0]   = shifted[6:0]   & {7{prop07}};
        shifted[12:5]  = shifted[12:5]  & {8{prop13}};
        shifted[19:12] = shifted[19:12] & {8{prop20}};
        stk0 |=           steps0[3] & (|level4[6:0]);
        stk1 |= !prop07 & steps1[3] & (|level4[12:7]);
        stk2 |= !prop13 & steps2[3] & (|level4[19:13]);
        stk3 |= !prop20 & steps3[3] & (|level4[25:20]);
        level3[6:0]   = steps0[3] ? shifted[6:0]   : level4[6:0];
        level3[12:7]  = steps1[3] ? shifted[12:7]  : level4[12:7];
        level3[19:13] = steps2[3] ? shifted[19:13] : level4[19:13];
        level3[25:20] = steps3[3] ? shifted[25:20] : level4[25:20];

        // stage by 4 : level3 -> level2
        shifted = level3 >> 4;
        shifted[6:3]   = shifted[6:3]   & {4{prop07}};
        shifted[12:9]  = shifted[12:9]  & {4{prop13}};
        shifted[19:16] = shifted[19:16] & {4{prop20}};
        stk0 |=           steps0[2] & (|level3[3:0]);
        stk1 |= !prop07 & steps1[2] & (|level3[10:7]);
        stk2 |= !prop13 & steps2[2] & (|level3[16:13]);
        stk3 |= !prop20 & steps3[2] & (|level3[23:20]);
        level2[6:0]   = steps0[2] ? shifted[6:0]   : level3[6:0];
        level2[12:7]  = steps1[2] ? shifted[12:7]  : level3[12:7];
        level2[19:13] = steps2[2] ? shifted[19:13] : level3[19:13];
        level2[25:20] = steps3[2] ? shifted[25:20] : level3[25:20];

        // stage by 2 : level2 -> level1
        shifted = level2 >> 2;
        shifted[6:5]   = shifted[6:5]   & {2{prop07}};
        shifted[12:11] = shifted[12:11] & {2{prop13}};
        shifted[19:18] = shifted[19:18] & {2{prop20}};
        stk0 |=           steps0[1] & (|level2[1:0]);
        stk1 |= !prop07 & steps1[1] & (|level2[8:7]);
        stk2 |= !prop13 & steps2[1] & (|level2[14:13]);
        stk3 |= !prop20 & steps3[1] & (|level2[21:20]);
        level1[6:0]   = steps0[1] ? shifted[6:0]   : level2[6:0];
        level1[12:7]  = steps1[1] ? shifted[12:7]  : level2[12:7];
        level1[19:13] = steps2[1] ? shifted[19:13] : level2[19:13];
        level1[25:20] = steps3[1] ? shifted[25:20] : level2[25:20];

        // stage by 1 : level1 -> level0
        shifted = level1 >> 1;
        shifted[6]  = shifted[6]  & prop07;
        shifted[12] = shifted[12] & prop13;
        shifted[19] = shifted[19] & prop20;
        stk0 |=           steps0[0] & level1[0];
        stk1 |= !prop07 & steps1[0] & level1[7];
        stk2 |= !prop13 & steps2[0] & level1[13];
        stk3 |= !prop20 & steps3[0] & level1[20];
        level0[6:0]   = steps0[0] ? shifted[6:0]   : level1[6:0];
        level0[12:7]  = steps1[0] ? shifted[12:7]  : level1[12:7];
        level0[19:13] = steps2[0] ? shifted[19:13] : level1[19:13];
        level0[25:20] = steps3[0] ? shifted[25:20] : level1[25:20];

        if (fmt == FMT_BF16) begin
            stk2 |= |level0[15:13];
            level0[15:13] = 3'b0;
        end
        if (fmt == FMT_FP8) begin
            stk1 |= |level0[7:6];
            level0[7:6] = 2'b0;
            stk2 |= |level0[15:10];
            level0[15:10] = 6'b0;
            stk3 |= |level0[23:22];
            level0[23:22] = 2'b0;
        end

        result = level0;
        sticky = {stk3, stk2, stk1, stk0};
    end

endmodule
