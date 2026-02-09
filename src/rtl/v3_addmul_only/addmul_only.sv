
module addmul_only(
    input logic clk,
    input logic [1:0] opcode, //00: Add, 01: Mul, 10: Sqrt, 11: Div
    input logic fmt, // 0: FP32, 1: FP16
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

    // FPAdd signals
    logic swap;
    logic [7:0] expDiff;
    logic [31:0] newX, newY;
    logic [7:0] add_expX;
    logic signX, signY, EffSub;
    logic [23:0] fracY;
    logic shiftedOut;
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
    logic signR2;

    // FPMul signals
    logic sign;
    logic [7:0] mul_expX, expY;
    logic [9:0] expSumPreSub, bias, expSum;
    logic [23:0] sigX, sigY;
    logic [47:0] sigProd;
    logic norm;
    logic [9:0] expPostNorm;
    logic [47:0] sigProdExt;
    logic [32:0] expSig;
    logic mul_guard_bit, mul_sticky, mul_round, mul_lsb;
    logic [30:0] expSigPostRound;

    // Shared Output Signals
    logic [31:0] add_R, mul_R;
    logic [33:0] add_expFrac;
    logic add_round;
    logic [33:0] ra_X, ra_R;
    logic [33:0] add_ra_X, mul_ra_X;
    logic ra_Cin;
    
    logic [26:0] add_fracAdder_X, add_fracAdder_Y, add_fracAdder_R;
    logic add_fracAdder_Cin;
    
    logic [7:0] mul_expAdder_X, mul_expAdder_Y;
    logic mul_expAdder_Cin;
    logic [8:0] mul_expAdder_R; 
    
    logic [26:0] ia27_X, ia27_Y, ia27_R;
    logic ia27_Cin;


    // =================================================================================
    // FPAdd Logic
    // =================================================================================

    assign swap = (X[30:0] < Y[30:0]); 
    assign newX = (swap == 1'b0) ? X : Y; 
    assign newY = (swap == 1'b0) ? Y : X; 
    assign expDiff = newX[30:23] - newY[30:23]; 
    assign add_expX = newX[30:23];
    assign signX = newX[31];
    assign signY = newY[31];
    assign EffSub = signX ^ signY;
    assign fracY = {1'b1, newY[22:0]};
    
    assign shiftedOut = (expDiff > 8'd25) ? 1'b1 : 1'b0;
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
    assign cInSigAdd = EffSub & (~add_sticky); 

    assign add_fracAdder_X = fracXpad;
    assign add_fracAdder_Y = fracYpadXorOp;
    assign add_fracAdder_Cin = cInSigAdd;
    assign fracAddResult = add_fracAdder_R;
    
    assign fracSticky = {fracAddResult, add_sticky};
    
    Normalizer_Z_28_28_28_Freq1_uid8 LZCAndShifter (
        .clk(clk),
        .X(fracSticky),
        .Count(nZerosNew),
        .R(shiftedFrac)
    );
    
    assign extendedExpInc = {1'b0, add_expX} + 9'd1;
    assign updatedExp = {1'b0, extendedExpInc} - {5'b00000, nZerosNew};
    assign eqdiffsign = (nZerosNew == 5'b11111);
    
    assign add_expFrac = {updatedExp, shiftedFrac[26:3]};
    assign stk = shiftedFrac[2] | shiftedFrac[1] | shiftedFrac[0];
    assign rnd = shiftedFrac[3];
    assign lsb = shiftedFrac[4];
    assign add_ra_X = add_expFrac; 
    assign add_round = ((rnd == 1'b1) && (stk == 1'b1)) || ((rnd == 1'b1) && (stk == 1'b0) && (lsb == 1'b1)) ? 1'b1 : 1'b0;

    assign RoundedExpFrac = ra_R;
    assign fracR = RoundedExpFrac[23:1];
    assign expR = RoundedExpFrac[31:24];
    
    assign signR2 = (eqdiffsign && EffSub) ? 1'b0 : signX;
    assign add_R = {signR2, expR, fracR};

    
    // =================================================================================
    // FPMult Logic
    // =================================================================================
    
    assign sign = X[31] ^ Y[31];
    assign mul_expX = X[30:23];
    assign expY = Y[30:23];
    
    assign mul_expAdder_X = mul_expX;
    assign mul_expAdder_Y = expY;
    assign mul_expAdder_Cin = 1'b0;
    assign expSumPreSub = {1'b0, mul_expAdder_R[8:0]};
    
    assign bias = 10'd127;
    assign expSum = expSumPreSub - bias;
    assign sigX = {1'b1, X[22:0]};
    assign sigY = {1'b1, Y[22:0]};
    assign sigProd = sigX * sigY;
    assign norm = sigProd[47];
    assign expPostNorm = expSum + {9'd0, norm};
    assign sigProdExt = (norm == 1'b1) ? {sigProd[46:0], 1'b0} : {sigProd[45:0], 2'b00};
    assign expSig = {expPostNorm, sigProdExt[47:25]};
    assign mul_guard_bit = sigProdExt[24];
    assign mul_sticky = |sigProdExt[23:0];
    assign mul_lsb = sigProdExt[25];
    assign mul_round = mul_guard_bit & (mul_sticky | mul_lsb);
    
    assign mul_ra_X = {1'b0, expSig}; 
    assign expSigPostRound = ra_R[30:0];
    assign mul_R = {sign, expSigPostRound};


    // =================================================================================
    // Shared Resources & Output Mux
    // =================================================================================

    always_comb begin
        unique case (opcode)
            2'b00: begin
                ra_X   = add_ra_X;
                ra_Cin = add_round;
            end
            2'b01: begin
                ra_X   = mul_ra_X;
                ra_Cin = mul_round;
            end
            default: begin
                ra_X   = 'x;
                ra_Cin = 'x;
            end
        endcase
    end
    assign ra_R = ra_X + ra_Cin;

    assign ia27_X[26:9] = add_fracAdder_X[26:9];
    assign ia27_X[8:0] = (opcode == 2'b00) ? add_fracAdder_X[8:0] : {1'b0, mul_expAdder_X};
    
    assign ia27_Y[26:9] = add_fracAdder_Y[26:9];
    assign ia27_Y[8:0] = (opcode == 2'b00) ? add_fracAdder_Y[8:0] : {1'b0, mul_expAdder_Y};
    
    assign ia27_Cin = (opcode == 2'b00) ? add_fracAdder_Cin : mul_expAdder_Cin;
    
    assign add_fracAdder_R = ia27_R;
    assign mul_expAdder_R = ia27_R[8:0];

    IntAdder_27_Freq1_uid6 U_SHARED_IA27 (
        .clk(clk),
        .X(ia27_X),
        .Y(ia27_Y),
        .Cin(ia27_Cin),
        .R(ia27_R)
    );

    always_comb begin
        unique case (opcode)
            2'b00: R = add_R;
            2'b01: R = mul_R;
            default: R = 32'h0;
        endcase
    end

endmodule