`timescale 1ns/1ps
    import fpall_pkg::*;

module addmul_only(
    input logic clk,
    input fp_op_e opcode, // 00: Add, 01: Mul
    input fp_fmt_e fmt, 
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);
    fp_vec_u x, y;
    assign x.raw = X;
    assign y.raw = Y;
        
    // FPAdd signals
    logic swap_h,swap_l;
    logic [7:0] expDiff_h;
    logic [7:0] expDiff_l;
    fp_vec_u newX, newY;
    logic [7:0] add_expX_h,add_expX_l;
    logic signX_h, signY_h, EffSub_h;
    logic signX_l, signY_l, EffSub_l;
    logic [23:0] fracY;
    logic [7:0] fracY_h, fracY_l;
    logic shiftedOut_h, shiftedOut_l;
    logic [4:0] shiftVal_h_fp32;
    logic [3:0] shiftVal_h_fp16, shiftVal_l_fp16;
    logic [7:0] shiftVal;
    logic [25:0] shiftedFracY;
    logic add_sticky_h, add_sticky_l;
    logic [26:0] fracYpad, EffSub_Vector, fracYpadXorOp, fracXpad;
    logic cInSigAdd_h, cInSigAdd_l;
    logic [26:0] cin_vec;   
    logic [26:0] fracAddResult;
    logic [27:0] fracSticky;
    logic [4:0] nZerosNew_l, nZerosNew_h;
    logic [27:0] shiftedFrac;
    logic [13:0] shiftedFrac_h, shiftedFrac_l;
    logic [8:0] extendedExpInc_h, extendedExpInc_l;
    logic [8:0] normShift_h, normShift_l;   
    logic [9:0] updatedExp_h, updatedExp_l;
    logic stk_h, rnd_h, lsb_h;
    logic stk_l, rnd_l, lsb_l;
    logic [35 :0] round_vec;
    logic [35:0] add_expFrac;
    logic [35:0] add_RoundedExpFrac;
    logic [31:0] add_R_fp32;
    logic [31:0] add_R_fp16;
    logic add_R; // Placeholder for logic or just use add_R signal below

    // FPMul signals
    logic sign_h;
    logic sign_l;
    logic [8:0] expSumPreSub_h, expSumPreSub_l, bias; 
    logic [9:0] expSum_h, expSum_l;
    logic [24:0] sigX, sigY;
    logic [49:0] sigProd;
    logic norm_h, norm_l;
    logic [7:0] expPostNorm_h, expPostNorm_l;
    logic [47:0] sigProdExt;
    logic [32:0] expSig;
    logic mult_round, mult_round_32;
    logic mult_round_l;
    logic mult_round_h;
    logic [30:0] expSigPostRound;

    // Shared Output Signals
    logic [31:0] add_R_final, mul_R;
    logic add_round_h, add_round_l;
    logic [33:0] ra_X, ra_Y, ra_R;
    logic [33:0] mul_ra_X, mul_ra_Y;
    logic ra_Cin;
    
    logic [26:0] add_fracAdder_X, add_fracAdder_Y;
    logic [26:0] cin_vec_add;

    // =================================================================================
    // FPAdd Logic
    // =================================================================================

    abs_comparator u_abs_cmp (
        .fmt(fmt),
        .x(x),
        .y(y),
        .swap_l(swap_l),
        .swap_h(swap_h)
    );

    always_comb begin
        newX.lanes.hi = (swap_h ==1'b0) ? x.lanes.hi : y.lanes.hi;
        newY.lanes.hi = (swap_h ==1'b0) ? y.lanes.hi : x.lanes.hi;

        if(fmt ==FP32) begin
            newX.lanes.lo = (swap_h ==1'b0) ? x.lanes.lo : y.lanes.lo;
            newY.lanes.lo = (swap_h ==1'b0) ? y.lanes.lo : x.lanes.lo;
        end else begin
            newX.lanes.lo = (swap_l ==1'b0) ? x.lanes.lo : y.lanes.lo;
            newY.lanes.lo = (swap_l ==1'b0) ? y.lanes.lo : x.lanes.lo;
        end
    end
    
    assign expDiff_h = newX.fp32.exp - newY.fp32.exp; 
    assign expDiff_l = newX.lanes.lo[14:7] - newY.lanes.lo[14:7];

    assign signX_h = newX.fp32.sign;
    assign signY_h = newY.fp32.sign;
    assign signX_l = newX.lanes.lo[15];
    assign signY_l = newY.lanes.lo[15];

    assign add_expX_h = newX.fp32.exp;
    assign add_expX_l = newX.lanes.lo[14:7];

    assign EffSub_h = signX_h ^ signY_h;
    assign EffSub_l = signX_l ^ signY_l;

    assign fracY_h = {1'b1, newY.lanes.hi[6:0]};
    assign fracY_l = {1'b1, newY.lanes.lo[6:0]};

    assign shiftedOut_h   = (|expDiff_h[7:5]);
    assign shiftVal_h_fp32 = shiftedOut_h ? 5'd26 : expDiff_h[4:0];

    assign shiftedOut_l    = (expDiff_l > 9);
    assign shiftVal_h_fp16 = (shiftedOut_h |expDiff_h[4]) ? 4'd10 : expDiff_h[3:0];
    assign shiftVal_l_fp16 = shiftedOut_l ? 4'd10 : expDiff_l[3:0];

    always_comb begin
        if (fmt == FP32) begin
            shiftVal = {3'b0, shiftVal_h_fp32};
            fracY    = {1'b1, newY[22:0]};
        end else begin
            shiftVal = {shiftVal_h_fp16, shiftVal_l_fp16};
            fracY    = {fracY_h, 8'b0, fracY_l};
        end
    end

    barrel_shifter RightShifterComponent (
        .fmt(fmt),
        .S(shiftVal),
        .X(fracY),
        .R(shiftedFracY),
        .Sticky_h(add_sticky_h),
        .Sticky_l(add_sticky_l)
    );

    assign fracYpad = {1'b0, shiftedFracY};
    assign EffSub_Vector = (fmt == FP32) ? {27{EffSub_h}} : { {11{EffSub_h}}, 5'd0, {11{EffSub_l}} };
    assign fracYpadXorOp = fracYpad ^ EffSub_Vector;

    assign fracXpad = 
        (fmt ==FP32) ? {2'b01, newX[22:0], 2'b00}
            : {{2'b01,newX.lanes.hi[6:0],2'b0}, 3'b0, 2'b0 , {2'b01, newX.lanes.lo[6:0],2'b0}};
    
    assign cInSigAdd_h = EffSub_h & (~add_sticky_h);
    assign cInSigAdd_l = (fmt ==FP32) ? EffSub_h & (~add_sticky_l):  EffSub_l & (~add_sticky_l); 

    assign cin_vec_add =
    (fmt == FP16) ? ((27'(cInSigAdd_l)) | (27'(cInSigAdd_h) << 16))
                :  (27'(cInSigAdd_l));

    assign fracAddResult = fracXpad + fracYpadXorOp + cin_vec_add;
 
    always_comb begin
        fracSticky = {fracAddResult, add_sticky_l};
        if(fmt ==FP16) fracSticky[16] = add_sticky_h; 
    end

    normalizer LZCAndShifter (
        .clk(clk),
        .fmt(fmt),
        .X(fracSticky),
        .Count_h(nZerosNew_h),
        .Count_l(nZerosNew_l),
        .R(shiftedFrac)
    );
    
    assign extendedExpInc_h = {1'b0, add_expX_h} + 9'd1;
    assign extendedExpInc_l = {1'b0, add_expX_l} + 9'd1;

    assign normShift_h = {4'b0, nZerosNew_h};   
    assign normShift_l = {4'b0, nZerosNew_l};  
    assign updatedExp_h = extendedExpInc_h - normShift_h;
    assign updatedExp_l = (fmt == FP32) ? 9'd0 : (extendedExpInc_l - normShift_l);
    
    assign shiftedFrac_h = shiftedFrac[27:14];
    assign shiftedFrac_l = shiftedFrac[13:0];

    always_comb begin
        add_expFrac = '0;
        if (fmt ==FP32) begin
            add_expFrac = {2'b0, updatedExp_h, shiftedFrac_h[12:0], shiftedFrac_l[13:3]};
        end else begin
            add_expFrac = {updatedExp_h, shiftedFrac_h[12:5], updatedExp_l, shiftedFrac_l[10:3]};
        end
    end
    assign stk_h = |shiftedFrac_h[4:2];
    assign rnd_h = shiftedFrac_h[5];
    assign lsb_h = shiftedFrac_h[6];

    assign stk_l = |shiftedFrac_l[2:0];
    assign rnd_l = shiftedFrac_l[3];
    assign lsb_l = shiftedFrac_l[4];

    assign add_round_h = rnd_h & (stk_h | lsb_h);
    assign add_round_l = rnd_l & (stk_l | lsb_l);

    assign round_vec = 
        (fmt == FP16) ? ((36'(add_round_l)) | (36'(add_round_h) << 18))
                :  (36'(add_round_l));
    assign add_RoundedExpFrac = add_expFrac + round_vec;
    
    assign add_R_fp32 = {
        signX_h,
        add_RoundedExpFrac[31:1]
    };

    assign add_R_fp16 = {
        signX_h,
        add_RoundedExpFrac[33:19],
        signX_l,
        add_RoundedExpFrac[15:1]
    };

    assign add_R_final = (fmt == FP32) ? add_R_fp32 : add_R_fp16;
    


    // =================================================================================
    // FPMult Logic
    // =================================================================================
    fp_vec_u  mult_x, mult_y;
    assign mult_x.raw = X;
    assign mult_y.raw = Y;
    assign sign_h = X[31] ^ Y[31];
    assign sign_l = X[15] ^ Y[15];

    assign expSumPreSub_h = mult_x.fp32.exp + mult_y.fp32.exp;
    assign expSumPreSub_l = mult_x.lanes.lo[14:7] + mult_y.lanes.lo[14:7];
    assign bias = 9'd127;
    assign expSum_h = expSumPreSub_h - bias;
    assign expSum_l = expSumPreSub_l - bias;
    
    assign sigX = 
        (fmt ==FP32) ? {2'b01, mult_x.fp32.frac}
            : { {1'b1, mult_x.lanes.hi[6:0]}, 9'b0, {1'b1, mult_x.lanes.lo[6:0]}};

    assign sigY = 
        (fmt ==FP32) ? {2'b01, mult_y.fp32.frac}
            : { {1'b1, mult_y.lanes.hi[6:0]}, 9'b0, {1'b1, mult_y.lanes.lo[6:0]}};
    always_comb begin
        sigProd = sigX * sigY;
    end

    assign norm_h = (fmt ==FP16) ? sigProd[49] : sigProd[47]; 
    assign norm_l = (fmt ==FP16) ? sigProd[15]: 1'b0; 

    assign expPostNorm_h = expSum_h + {7'd0, norm_h};
    assign expPostNorm_l = expSum_l + {7'd0, norm_l};

    always_comb begin
        sigProdExt = 48'd0;
        if(fmt ==FP32) begin
            sigProdExt = (norm_h) ? {sigProd[46:0], 1'b0} : {sigProd[45:0], 2'b00};
        end else begin
            sigProdExt[47:32] = (norm_h) ? {sigProd[48:34], 1'b0} : {sigProd[47:34], 2'b00};
            sigProdExt[15: 0] = (norm_l) ? {sigProd[14:0], 1'b0} : {sigProd[13:0], 2'b00}; 
        end
    end

    always_comb begin
        if(fmt == FP32) begin
            expSig = {expPostNorm_h, sigProdExt[47:25]};
        end else begin
            expSig = { {expPostNorm_h, sigProdExt[47:41]}, 
                       sign_l, 
                       {expPostNorm_l, sigProdExt[15:9]} };
        end
    end

    assign mult_round_32 = sigProdExt[24] & (sigProdExt[25] | (|sigProdExt[23:0]));
    assign mult_round_h  = sigProdExt[40] & (sigProdExt[41] | (|sigProdExt[39:32]));
    assign mult_round_l  = sigProdExt[8]  & (sigProdExt[9]  | (|sigProdExt[7:0]));
    
    assign mult_round = (fmt == FP32) ? mult_round_32 : mult_round_l;
    assign mul_ra_Y   = (fmt == FP16) ? (34'(mult_round_h) << 16) : 34'd0;

    assign mul_ra_X = {1'b0, expSig}; 
    
    // =================================================================================
    // Shared Resources & Output Mux
    // =================================================================================

    assign ra_X = mul_ra_X;
    assign ra_Y = mul_ra_Y;                                   
    assign ra_Cin = mult_round;

    IntAdder_34_Freq1_uid11 U_SHARED_RA (
        .clk(clk),
        .X(ra_X),
        .Y(ra_Y),
        .Cin(ra_Cin),
        .R(ra_R)
    );

    assign expSigPostRound = ra_R[30:0];
    assign mul_R = {sign_h, expSigPostRound};

    assign R = (opcode == OP_ADD) ? add_R_final : mul_R;

endmodule
