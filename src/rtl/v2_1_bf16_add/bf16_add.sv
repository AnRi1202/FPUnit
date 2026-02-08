
import fpall_pkg::*;


module bf16_add(
    input logic clk,
    input fp_fmt_e fmt, 
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);
    // ========================================================================
    // for multiprecision
    // Design Policy:
    // When in FP32 mode, prioritize using the logic/resources associated with 
    // the high-order 16-bit lanes (FP16 high part) to maximize sharing.
    // ========================================================================
    fp_vec_u x, y;
    assign x.raw = X;
    assign y.raw = Y;
    // assign R     = r.raw;
        
    // FPAdd signals
    logic [32:0] excExpFracX, excExpFracY;
    logic swap;
    logic swap_h, swap_l;
    logic [7:0] expDiff_h;
    logic [7:0] expDiff_l;
    fp_vec_u newX, newY;
    // logic [31:0] newX, newY;
    logic [7:0] add_expX_h,add_expX_l;
    logic signX_h, signY_h, EffSub_h;
    logic signX_l, signY_l, EffSub_l;
    logic [23:0] fracY;
    logic [7:0] fracY_h, fracY_l;
    logic [1:0] excRt;
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
    logic eqdiffsign_h, eqdiffsign_l;
    logic stk_h, rnd_h, lsb_h;
    logic stk_l, rnd_l, lsb_l;
    logic [35 :0] round_vec;
    logic [35:0] add_RoundedExpFrac;
    logic [22:0] fracR;
    logic [7:0] expR;
    logic [1:0] excR;
    logic [31:0] add_R_fp32;
    logic [31:0] add_R_fp16;

    logic [26:0] add_fracAdder_X, add_fracAdder_Y, add_fracAdder_R;
    logic add_fracAdder_Cin;
    logic [35:0] add_expFrac;
    logic add_round_h, add_round_l, add_round;

    // =================================================================================
    // FPAdd Logic
    // =================================================================================

    // Shared comparator
    abs_comparator u_abs_cmp (
        .fmt(fmt),
        .x(x),
        .y(y),
        .swap_l(swap_l),
        .swap_h(swap_h)
    );

    // assign swap = swaps[1]; // Currently forcing FP32 behavior for swap as the rest of the logic isn't updated yet.
    // input swap so that |X|>|Y| 
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
    
    /* Exponent Difference */
    assign expDiff_h = newX.fp32.exp - newY.fp32.exp; 
    assign expDiff_l = newX.lanes.lo[14:7] - newY.lanes.lo[14:7]; //lo expDiff

    /* Sign, Exponent, Fraction Decomposition */
    assign signX_h = newX.fp32.sign;
    assign signY_h = newY.fp32.sign;
    assign signX_l = newX.lanes.lo[15];
    assign signY_l = newY.lanes.lo[15];

    assign add_expX_h = newX.fp32.exp; // == newX.lanes.hi[14:8];
    assign add_expX_l = newX.lanes.lo[14:7];

    assign EffSub_h = signX_h ^ signY_h;
    assign EffSub_l = signX_l ^ signY_l;


    assign fracY_h = {1'b1, newY.lanes.hi[6:0]};
    assign fracY_l = {1'b1, newY.lanes.lo[6:0]};

    // FP32 shift amount (cap at 26)
    assign shiftedOut_h   = (|expDiff_h[7:5]); // expDiff_h > 31
    assign shiftVal_h_fp32 = shiftedOut_h ? 5'd26 : expDiff_h[4:0];

    // FP16 shift amount (cap at 10)
    assign shiftedOut_l    = (expDiff_l > 9);
    assign shiftVal_h_fp16 = (shiftedOut_h |expDiff_h[4]) ? 4'd10 : expDiff_h[3:0]; //expDiff_h > 16 (area -4)
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
    /* --- Significand Addition Prep --- */ 

    // ** Bit Layout (27-bit) [fracYpad, EffSub_Vector, fracXpad] **:
    //
    // [26:16] Lane High: {padding(2), frac(7), guard, rnd}
    // [15:11] Gap/Zero:  {00000}
    // [10: 0] Lane Low:  {padding(2), frac(7), guard, rnd}
    assign fracYpad = {1'b0, shiftedFracY}; // align to 27b adder input (MSB pad)
    assign EffSub_Vector = (fmt == FP32) ? {27{EffSub_h}} : { {11{EffSub_h}}, 5'd0, {11{EffSub_l}} };
    assign fracYpadXorOp = fracYpad ^ EffSub_Vector;

    assign fracXpad = 
        (fmt ==FP32) ? {2'b01, newX[22:0], 2'b00}
            : {{2'b01,newX.lanes.hi[6:0],2'b0}, 3'b0, 2'b0 , {2'b01, newX.lanes.lo[6:0],2'b0}};
            // same bit layout as fracYpad
    
    assign cInSigAdd_h = EffSub_h & (~add_sticky_h);
    // if we subtract and the sticky was one, some of the negated sticky bits would have absorbed this carry 
    assign cInSigAdd_l = (fmt ==FP32) ? EffSub_h & (~add_sticky_l):  EffSub_l & (~add_sticky_l); 


    // Connect to Shared IntAdder_27 (TODO: not conneced now. separated from other op)
    assign add_fracAdder_X = fracXpad;       // Connect padded X fraction
    assign add_fracAdder_Y = fracYpadXorOp;  // Connect prepared Y fraction
    assign add_fracAdder_Cin = cInSigAdd_l;    // Carry-in accounting for subtraction and sticky bit

    // Vectorize Carry-in for Shared Adder 
    assign cin_vec =
    (fmt == FP16) ? ((27'(cInSigAdd_l)) | (27'(cInSigAdd_h) << 16))
                :  (27'(cInSigAdd_l));

    /* Execute Significand Addition/Subtraction */
    assign fracAddResult = add_fracAdder_X + add_fracAdder_Y + cin_vec;
 
    // Prepare Normalizer Input (Significand + Sticky)
    always_comb begin
        fracSticky = {fracAddResult, add_sticky_l};
        if(fmt ==FP16) fracSticky[16] = add_sticky_h; 
    end

    /* --- LZC and shifter --- */
    normalizer LZCAndShifter (
        .clk(clk),
        .fmt(fmt),
        .X(fracSticky),
        .Count_h(nZerosNew_h),
        .Count_l(nZerosNew_l),
        .R(shiftedFrac)
    );
    
    // Exponent Update 
    assign extendedExpInc_h = {1'b0, add_expX_h} + 9'd1;
    assign extendedExpInc_l = {1'b0, add_expX_l} + 9'd1;

    assign normShift_h = {4'b0, nZerosNew_h};   
    assign normShift_l = {4'b0, nZerosNew_l};  
    assign updatedExp_h = extendedExpInc_h - normShift_h;
    assign updatedExp_l = (fmt == FP32) ? 9'd0 : (extendedExpInc_l - normShift_l);
    

     
    /* --- rounding --- */
    assign shiftedFrac_h = shiftedFrac[27:14];
    assign shiftedFrac_l = shiftedFrac[13:0];

    // FP32: exponent uses high lane, rounding uses low lane
    always_comb begin
        add_expFrac = '0;
        if (fmt ==FP32) begin
            add_expFrac = {2'b0, updatedExp_h, shiftedFrac_h[12:0], shiftedFrac_l[13:3]}; //[26:3]
        end else begin
            add_expFrac = {updatedExp_h, shiftedFrac_h[12:5], updatedExp_l, shiftedFrac_l[10:3]}; //36bit
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

    // Shared rounding adder (36bit)
    assign round_vec = 
        (fmt == FP16) ? ((36'(add_round_l)) | (36'(add_round_h) << 18))
                :  (36'(add_round_l));
    assign add_RoundedExpFrac = add_expFrac + round_vec;
    
    // Pack Result (Sign, Exponent, Mantissa)
    assign add_R_fp32 = {
        signX_h,
        add_RoundedExpFrac[31:1]   // exp + frac (FP32)
    };

    assign add_R_fp16 = {
        signX_h,
        add_RoundedExpFrac[33:19], // exp+frac high lane
        signX_l,
        add_RoundedExpFrac[15:1]   // exp+frac low lane
    };

    assign R = (fmt == FP32) ? add_R_fp32 : add_R_fp16;
    

endmodule