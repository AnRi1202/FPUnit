
module fp32_mult(
    input logic clk,
    input logic [1:0] opcode, //00: Add, 01: Mul, 10: Sqrt, 11: Div
    input logic fmt, // 0: FP32, 1: FP16
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);
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
    logic mul_guard_bit, mul_sticky_or, mul_round, mul_lsb;
    logic [30:0] expSigPostRound;

    logic [7:0] mul_expAdder_X, mul_expAdder_Y;
    logic mul_expAdder_Cin;
    logic [8:0] mul_expAdder_R; 
    logic [32:0] mul_expSig;

    // =================================================================================
    // FPMult Logic
    // =================================================================================
    
    assign sign = X[31] ^ Y[31];
    assign mul_expX = X[30:23];
    assign expY = Y[30:23];

    assign expSumPreSub = {2'b00,mul_expX} + {2'b00,expY};

    assign bias = 10'd127;
    assign expSum = expSumPreSub - bias;
    
    assign sigX = {1'b1, X[22:0]};
    assign sigY = {1'b1, Y[22:0]};
    
    assign sigProd = sigX * sigY;
    // exponent update 
    assign norm = sigProd[47];
    assign expPostNorm = expSum + {9'd0, norm};
    // significand normalization shift 
    assign sigProdExt = (norm == 1'b1) ? {sigProd[46:0], 1'b0} : {sigProd[45:0], 2'b00};
    assign expSig = {expPostNorm, sigProdExt[47:25]};
    assign mul_guard_bit = sigProdExt[24];
    assign mul_sticky_or = (sigProdExt[23:0] == 24'd0) ? 1'b0 : 1'b1;
    assign mul_lsb = sigProdExt[25];
    assign mul_round = mul_guard_bit & ((mul_sticky_or & (~mul_lsb)) | mul_lsb);
    
    // Connect to Shared Rounding Adder
    
    // Get result from Shared Rounding Adder
    assign expSigPostRound = mul_round + expSig;
    assign R = {sign, expSigPostRound};


endmodule