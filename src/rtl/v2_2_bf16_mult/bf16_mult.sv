
import fpall_pkg::*;

module bf16_mult(
    input logic clk,
    input fp_op_e opcode, //00: Add, 01: Mul, 10: Sqrt, 11: Div
    input fp_fmt_e fmt, // 
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);


    // FPMul signals
    logic sign_h;
    logic sign_l;
    logic [7:0] mult_expX, mult_expY;
    logic [9:0] expSumPreSub_h, expSumPreSub_l, bias, expSum_h, expSum_l;
    logic [24:0] sigX, sigY;
    logic [49:0] sigProd;
    logic [3:0] excSel;
    logic [1:0] exc;
    logic norm_h, norm_l;
    logic [7:0] expPostNorm_h, expPostNorm_l;
    logic [47:0] sigProdExt;
    logic [32:0] expSig;
    logic mult_round, mult_round_32;
    logic mult_round_l;
    logic mult_round_h;
    logic [30:0] expSigPostRound;
    logic [1:0] excPostNorm, finalExc;
    logic [33:0] mul_ra_X, mul_ra_Y;
    logic [7:0] mul_expAdder_X, mul_expAdder_Y;
    logic mul_expAdder_Cin;
    logic [8:0] mul_expAdder_R; 
    // =================================================================================
    // FPMult Logic
    // =================================================================================
    fp_vec_u  mult_x, mult_y;
    assign mult_x.raw = X;
    assign mult_y.raw = Y;
    assign sign_h = X[31] ^ Y[31];
    assign sign_l = X[15] ^ Y[15];

    // assign mult_expX = X[30:23];
    // assign mult_expY = Y[30:23];
    
    // // Connect to Shared IntAdder_27
    // assign mul_expAdder_X = mult_expX;        // Connect exponent X
    // assign mul_expAdder_Y = mult_expY;            // Connect exponent Y
    // assign mul_expAdder_Cin = 1'b0;          // No carry-in needed for simple addition
    // assign expSumPreSub = {1'b0, mul_expAdder_R[8:0]}; // Get addition result
    
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


    // exponent update 
    assign norm_h = (fmt ==FP16) ? sigProd[49] : sigProd[47]; // 1x.xx... 
    assign norm_l = (fmt ==FP16) ? sigProd[15]: 1'b0; // 1x.xx... 

    assign expPostNorm_h = expSum_h + {7'd0, norm_h};
    assign expPostNorm_l = expSum_l + {7'd0, norm_l};
    // significand normalization shift 
    always_comb begin
        sigProdExt = 48'd0;
        if(fmt ==FP32) begin
            sigProdExt = (norm_h) ? {sigProd[46:0], 1'b0} : {sigProd[45:0], 2'b00}; //cut implicit 1
        end else begin
            sigProdExt[47:32] = (norm_h) ? {sigProd[48:34], 1'b0} : {sigProd[47:34], 2'b00};
            sigProdExt[15: 0] = (norm_l) ? {sigProd[14:0], 1'b0} : {sigProd[13:0], 2'b00}; 
        end
    end

    always_comb begin
        if(fmt == FP32) begin
            expSig = {expPostNorm_h, sigProdExt[47:25]};
        end else begin
            // Internal layout: High Lane [30:16] | sign_l [15] | Low Lane [14:0]
            // Lane = Exp(8) + Frac(7). sign_l is used for separation and packed later.
            expSig = { {expPostNorm_h, sigProdExt[47:41]}, 
                       sign_l, 
                       {expPostNorm_l, sigProdExt[15:9]} };
        end
    end

    // --- FPMult Rounding Logic ---
    // Rounding bits: Guard & (LSB | Sticky)
    assign mult_round_32 = sigProdExt[24] & (sigProdExt[25] | (|sigProdExt[23:0]));
    assign mult_round_h  = sigProdExt[40] & (sigProdExt[41] | (|sigProdExt[39:32]));
    assign mult_round_l  = sigProdExt[8]  & (sigProdExt[9]  | (|sigProdExt[7:0]));
    
    // Select rounding carries for shared adder (ra_Cin for Low/FP32, mul_ra_Y for High)
    assign mult_round = (fmt == FP32) ? mult_round_32 : mult_round_l;
    assign mul_ra_Y   = (fmt == FP16) ? (34'(mult_round_h) << 16) : 34'd0;

    // Connect to Shared Rounding Adder
    assign mul_ra_X = {1'b0, expSig}; 
    
    // Get result from Shared Rounding Adder
    assign expSigPostRound =  mul_ra_X + mul_ra_Y +mult_round;
    assign R = {sign_h, expSigPostRound};

endmodule