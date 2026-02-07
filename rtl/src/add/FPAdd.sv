typedef enum logic {
    FP32 = 1'b0,
    FP16 = 1'b1
} fp_fmt_e;

typedef enum logic [1:0] {
    OP_ADD  = 2'b00,
    OP_MUL  = 2'b01,
    OP_SQRT = 2'b10,
    OP_DIV  = 2'b11
} fp_op_e;

module FPAdd(
    input logic clk,
    input fp_fmt_e fmt, 
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

    
    // FPAdd signals
    logic [32:0] excExpFracX, excExpFracY;
    logic swap;
    logic [7:0] expDiff;
    logic [31:0] newX, newY;
    logic [7:0] add_expX;
    logic signX, signY, EffSub;
    logic [1:0] sXsYExnXY;
    logic [3:0] sdExnXY;
    logic [23:0] fracY;
    logic [1:0] excRt;
    logic signR, shiftedOut;
    logic [4:0] shiftVal;
    logic [25:0] shiftedFracY;
    logic add_sticky;
    logic [26:0] fracYpad, EffSubVector, fracYpadXorOp, fracXpad;
    logic cInSigAdd;
    logic [26:0] fracAddResult;
    logic [27:0] fracSticky;
    logic [4:0] nZerosNew;
    logic [27:0] shiftedFrac;
    logic [8:0] extendedExpInc;
    logic [9:0] updatedExp;
    logic eqdiffsign;
    logic stk, rnd, lsb;
    logic [33:0] RoundedExpFrac;
    logic [22:0] fracR;
    logic [7:0] expR;
    logic [3:0] exExpExc;
    logic [1:0] excRt2, excR;
    logic signR2;
    logic [33:0] computedR;
    logic [33:0] add_expFrac;
    logic [33:0] add_ra_X;
    logic add_round;
    // =================================================================================
    // FPAdd Logic
    // =================================================================================

    //-------------------
    // shared comparator
    //-------------------
    assign swap = (X[30:0] < Y[30:0]) ? 1'b1 : 1'b0; //comparator
    // input swap so that |X|>|Y| 
    assign newX = (swap == 1'b0) ? X : Y; 
    assign newY = (swap == 1'b0) ? Y : X; 
    // exponent difference
    assign expDiff = newX[30:23] - newY[30:23]; 
    // now we decompose the inputs into their sign, exponent, fraction 
    assign add_expX = newX[30:23];
    assign signX = newX[31];
    assign signY = newY[31];
    assign EffSub = signX ^ signY;
    
    assign fracY = {1'b1, newY[22:0]};
    assign signR = signX;
    
    assign shiftedOut = (expDiff > 25) ? 1'b1 : 1'b0;
    assign shiftVal = (shiftedOut == 1'b0) ? expDiff[4:0] : 5'd26;

    RightShifterSticky24_by_max_26_Freq1_uid4 RightShifterComponent (
        .clk(clk),
        .S(shiftVal),
        .X(fracY),
        .R(shiftedFracY),
        .Sticky(add_sticky)
    );
    
    assign fracYpad = {1'b0, shiftedFracY};
    assign EffSubVector = {27{EffSub}};
    assign fracYpadXorOp = fracYpad ^ EffSubVector;
    assign fracXpad = {2'b01, newX[22:0], 2'b00};
    assign cInSigAdd = EffSub & (~add_sticky); // if we subtract and the sticky was one, some of the negated sticky bits would have absorbed this carry 

    // Connect to Shared IntAdder_27
    IntAdder_27_Freq1_uid6 fracAdder(
        .clk(clk),
        .Cin(cInSigAdd),
        .X(fracXpad),
        .Y(fracYpadXorOp),
        .R(fracAddResult)
    );
    // assign fracAddResult = fracXpad + fracYpadXorOp + cInSigAdd;
    
    assign fracSticky = {fracAddResult, add_sticky};
    
    Normalizer_Z_28_28_28_Freq1_uid8 LZCAndShifter (
        .clk(clk),
        .X(fracSticky),
        .Count(nZerosNew),
        .R(shiftedFrac)
    );
    
    assign extendedExpInc = {1'b0, add_expX} + 9'd1;
    assign updatedExp = {1'b0, extendedExpInc} - {5'b00000, nZerosNew};
    
    assign add_expFrac = {updatedExp, shiftedFrac[26:3]};
    assign stk = shiftedFrac[2] | shiftedFrac[1] | shiftedFrac[0];
    assign rnd = shiftedFrac[3];
    assign lsb = shiftedFrac[4];
    // Connect to Shared Rounding Adder
    assign add_ra_X = add_expFrac; 
    assign add_round = ((rnd == 1'b1) && (stk == 1'b1)) || ((rnd == 1'b1) && (stk == 1'b0) && (lsb == 1'b1)) ? 1'b1 : 1'b0;
    // Get result from Shared Rounding Adder
    // IntAdder_34_Freq1_uid11 roundingAdder(
    //     .clk(clk),
    //     .Cin(add_round),
    //     .X(add_expFrac),
    //     .Y('0),
    //     .R(RoundedExpFrac)
    // );
    assign RoundedExpFrac = add_round + add_expFrac;
    assign fracR = RoundedExpFrac[23:1];
    assign expR = RoundedExpFrac[31:24];
    
    assign signR2 = signR;
    assign R = {signR2, expR, fracR};

endmodule