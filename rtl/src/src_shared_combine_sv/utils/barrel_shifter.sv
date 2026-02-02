import FPALL_pkg::*;


module barrel_shifter(
    input  logic       clk,
    input  fp_fmt_e    fmt,
    input  logic [23:0] X,
    input  logic [7:0]  S,
    output logic [25:0] R,
    output logic        Sticky_h,
    output logic        Sticky_l
);
/*
  Barrel shifter for FP32/FP16 dual-lane path.
 
  Inputs:
   - X layout:
      * FP32: {frac_Y[22:0], 1'b0}
      * FP16: {frac_Y_h[6:0], 8'b0, frac_Y_l[6:0], 2'b0}
   - S (shift amount) usage:
      * fmt == FP32: use S[4:0] as a single shift amount.
      * fmt == FP16: S[7:4] is lanes.hi shift, S[3:0] is lanes.lo shift.
 
  Outputs:
   - Sticky_h: FP16 lanes.hi sticky (FP32 unused)
   - Sticky_l: FP32 sticky, FP16 lanes.lo sticky
 */


    logic [3:0] S_h,S_l;
    logic [7:0]  ps;
    logic [25:0] Xpadded;// FP16, ->{frac_Y_h(8), gs(2bit), 6'b0, frac_Y_l(8), gs(2bit)}
    // FP32 -> {frac_Y(24), gs}
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
    logic [12:0] level0_h, level0_l; // {shiftedFracY_l,}

    assign level5  = Xpadded;

    always_comb begin
        // defaults to avoid X/U
        Xpadded = {X, 2'b00};
        S_h = 4'b0;
        S_l = 4'b0;
        if(fmt == FP16) begin
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
        if(fmt ==FP16) begin 
            Sticky_h = stk0_h || level0_h[2] || level0_h[1] || level0_h[0];
            level0_h[2:0] = 3'b0; 
        end else Sticky_h = stk0_h;
        R = {level0_h, level0_l};
        Sticky_l = stk0_l;
        
    end

endmodule

module normalizer_z_28_28_28_multi(
    input  logic       clk,
    input  fp_fmt_e    fmt,
    input  logic [27:0] X,
    output logic [4:0]  Count_h,
    output logic [4:0]  Count_l,
    output logic [27:0] R
);
    always_comb begin
        R = 28'b0;
        Count_l = 5'b0;
        Count_h = 5'b0;
        begin
            logic [13:0] level4_h, level3_h, level2_h, level1_h, level0_h;
            logic [13:0] level4_l, level3_l, level2_l, level1_l, level0_l;
            logic count4;
            logic count4_h, count3_h, count2_h, count1_h, count0_h;
            logic count4_l, count3_l, count2_l, count1_l, count0_l;
            // Stage 4: shift by 16 (FP32 lane only)

            count4 = ~(|X[27:12]);
            
            if (fmt ==FP32) begin
                {level4_h,level4_l} = count4 ? {X[11:0], 16'b0}: X;
                count4_h = count4;
                count4_l = count4;
            end else begin
                level4_h = X[27:14]; // no meaning 2 LSB bits
                level4_l = X[13:0];
                count4_h =1'b0;
                count4_l =1'b0;
            end
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
