import FPALL_pkg::*;

module barrel_shifter(
    input  logic       clk,
    input  fp_fmt_e    fmt,
    input  logic [23:0] X,
    input  logic [7:0]  S, //FP32 -> 4:0
    output logic [25:0] R,
    output logic        Sticky_h, Sticky_l //FP32はsticky_lを使う
);

    logic [3:0] S_h,S_l;
    logic [7:0]  ps;
    logic [23:0] Xfmt; // FP16, -> {frac_Y_h, 4'b0, frac_Y_l, 4'b0}
    logic [25:0] Xpadded;
    logic [25:0] level5;
    logic        stk4_h, stk4_l;
    logic [12:0] level4_h, level4_l;
    logic        stk3_h, stk3_l;
    logic [12:0] level3_h, level3_l;
    logic        stk2_h, stk2_l;
    logic [12:0] level2_h, level2_l;
    logic        stk1_h, stk1_l;
    logic [12:0] level1_h,level1_l;
    logic        stk0_h, stk0_l;
    logic [12:0] level0_h, level0_l;

    assign level5  = Xpadded;

    always_comb begin
        // defaults to avoid X/U
        Xpadded = {X, 2'b00};
        S_h = 4'b0;
        S_l = 4'b0;
        if(fmt == FP16) begin
            Xpadded = {X[23:16], 5'b0, X[11:4], 5'b0};
            S_h = S[7:4];
            S_l = S[3:0];
        end
    end

    logic [4:0] steps_h, steps_l;

    always_comb begin
        steps_h[4] = (fmt ==FP32) ? S[4] : 1'b0; //本当はいらん
        steps_l[4] = (fmt ==FP32) ? S[4] : 1'b0;

        steps_h[3] = (fmt ==FP32) ? S[3] : S_h[3];
        steps_l[3] = (fmt ==FP32) ? S[3] : S_l[3];

        steps_h[2] = (fmt ==FP32) ? S[2] : S_h[2];
        steps_l[2] = (fmt ==FP32) ? S[2] : S_l[2];
    
        steps_h[1] = (fmt ==FP32) ? S[1] : S_h[1];
        steps_l[1] = (fmt ==FP32) ? S[1] : S_l[1];

        steps_h[0] = (fmt ==FP32) ? S[0] : S_h[0];
        steps_l[0] = (fmt ==FP32) ? S[0] : S_l[0];
    end
    always_comb begin
        // Stage 4: shift by 16 (FP32 lane only)
        stk4_h  = 1'b0;
        stk4_l  = (fmt == FP32) && S[4] && (|level5[15:0]);
        {level4_h,level4_l} = steps_h[4] ? {16'b0, level5[25:16]} : level5[25:0];

        // Stage 3: shift by 8
        stk3_h   = (fmt == FP16) && steps_h[3] && (|level4_h[7:0]);
        stk3_l   = ((level4_l[7:0] != 8'b0 && steps_l[3]) || stk4_l) ? 1'b1 : 1'b0;
        level3_h = steps_h[3] ? {8'b0, level4_h[12:8]} : level4_h;
        if (fmt ==FP32) begin
            level3_l = steps_l[3] ? {level4_h[7:0], level4_l[12:8]} : level4_l;
        end else begin
            level3_l = steps_l[3] ? {8'b0, level4_l[12:8]} : level4_l;
        end
        // Stage 2: shift by 4
        stk2_h   = stk3_h || ((fmt == FP16) && steps_h[2] && (|level3_h[3:0]));
        stk2_l   = ((level3_l[3:0] != 4'b0 && steps_l[2]) || stk3_l) ? 1'b1 : 1'b0;
        level2_h = steps_h[2] ? {4'b0, level3_h[12:4]} : level3_h;
        if (fmt == FP32) begin
            level2_l = steps_l[2] ? {level3_h[3:0], level3_l[12:4]} : level3_l;
        end else begin
            level2_l = steps_l[2] ? {4'b0, level3_l[12:4]} : level3_l;
        end

        // Stage 1: shift by 2
        stk1_h   = stk2_h || ((fmt == FP16) && steps_h[1] && (|level2_h[1:0]));
        stk1_l   = ((level2_l[1:0] != 2'b0 && steps_l[1]) || stk2_l) ? 1'b1 : 1'b0;
        level1_h = steps_h[1] ? {2'b0, level2_h[12:2]} : level2_h;
        if (fmt == FP32) begin
            level1_l = steps_l[1] ? {level2_h[1:0], level2_l[12:2]} : level2_l;
        end else begin
            level1_l = steps_l[1] ? {2'b0, level2_l[12:2]} : level2_l;
        end

        // Stage 0: shift by 1
        stk0_h   = stk1_h || ((fmt == FP16) && steps_h[0] && (|level1_h[0]));
        stk0_l   = ((level1_l[0] != 1'b0 && steps_l[0]) || stk1_l) ? 1'b1 : 1'b0;
        level0_h = steps_h[0] ? {1'b0, level1_h[12:1]} : level1_h;
        if (fmt == FP32) begin
            level0_l = steps_l[0] ? {level1_h[0], level1_l[12:1]} : level1_l;
        end else begin
            level0_l = steps_l[0] ? {1'b0, level1_l[12:1]} : level1_l;
        end

        R        = {level0_h, level0_l};
        Sticky_h = stk0_h;
        Sticky_l = stk0_l;

    end

endmodule

module barrel_shifter_separate(
    input  logic       clk,
    input  logic [23:0] X32,
    input  logic [4:0]  S32,
    input  logic [7:0]  X16_h,
    input  logic [7:0]  X16_l,
    input  logic [3:0]  S16_h,
    input  logic [3:0]  S16_l,
    output logic [25:0] R32,
    output logic        Sticky32,
    output logic [12:0] R16_h,
    output logic [12:0] R16_l,
    output logic        Sticky16_h,
    output logic        Sticky16_l
);
    logic [25:0] x32;
    logic [12:0] x16_h, x16_l;
    logic [4:0]  sh32;
    logic [3:0]  sh16_h, sh16_l;
    logic [25:0] r32;
    logic [12:0] r16_h, r16_l;
    logic        sticky32_l;
    logic        sticky16_h, sticky16_l;

    function automatic logic sticky_shift_26(input logic [25:0] v, input logic [4:0] sh);
        logic s;
        s = 1'b0;
        for (int i = 0; i < 26; i++) begin
            if ((sh > i[4:0]) && v[i]) begin
                s = 1'b1;
            end
        end
        sticky_shift_26 = s;
    endfunction

    function automatic logic sticky_shift_13(input logic [12:0] v, input logic [3:0] sh);
        logic s;
        s = 1'b0;
        for (int i = 0; i < 13; i++) begin
            if ((sh > i[3:0]) && v[i]) begin
                s = 1'b1;
            end
        end
        sticky_shift_13 = s;
    endfunction

    always_comb begin
        x32   = {X32, 2'b00};
        x16_h = {X16_h, 5'b0};
        x16_l = {X16_l, 5'b0};
        sh32  = S32;
        sh16_h = S16_h;
        sh16_l = S16_l;

        r32 = (sh32 >= 5'd26) ? 26'b0 : (x32 >> sh32);
        sticky32_l = sticky_shift_26(x32, sh32);

        r16_h = (sh16_h >= 4'd13) ? 13'b0 : (x16_h >> sh16_h);
        r16_l = (sh16_l >= 4'd13) ? 13'b0 : (x16_l >> sh16_l);
        sticky16_h = sticky_shift_13(x16_h, sh16_h);
        sticky16_l = sticky_shift_13(x16_l, sh16_l);

        R32 = r32;
        Sticky32 = sticky32_l;
        R16_h = r16_h;
        R16_l = r16_l;
        Sticky16_h = sticky16_h;
        Sticky16_l = sticky16_l;
    end
endmodule
