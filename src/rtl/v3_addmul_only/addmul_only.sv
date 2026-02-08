
module addmul_only(
    input logic clk,
    input logic [1:0] opcode, //00: Add, 01: Mul, 10: Sqrt, 11: Div
    input logic fmt, // 0: FP32, 1: FP16
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

    
    // FPAdd signals
    // logic [32:0] excExpFracX, excExpFracY; // Unused
    logic swap;
    logic [7:0] expDiff;
    logic [31:0] newX, newY;
    logic [7:0] add_expX;
    logic signX, signY, EffSub;
    logic [1:0] sXsYExnXY;
    logic [3:0] sdExnXY;
    logic [23:0] fracY;
    // logic [1:0] excRt; // Unused
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
    logic mul_guard_bit, mul_sticky_or, mul_round, mul_lsb;
    logic [30:0] expSigPostRound;

    // FPDiv signals
    logic [23:0] fX, fY;
    logic [9:0] expR0;
    logic sR;
    logic [23:0] D;
    logic [24:0] psX;
    
    // Div iterations (unrolled)
    // Div iterations (unrolled)
    // is_div removed as per request


    logic [26:0] betaw14, w13;
    logic[26:0] absq14D; // reg/logic for always_comb
    logic [8:0] sel14;
    logic [2:0] q14, q14_copy5;
    
    logic [26:0] betaw13, w12;
    logic[26:0] absq13D;
    logic [8:0] sel13;
    logic [2:0] q13, q13_copy6;
    
    logic [26:0] betaw12, w11;
    logic[26:0] absq12D;
    logic [8:0] sel12;
    logic [2:0] q12, q12_copy7;

    logic [26:0] betaw11, w10;
    logic[26:0] absq11D;
    logic [8:0] sel11;
    logic [2:0] q11, q11_copy8;
    
    logic [26:0] betaw10, w9;
    logic[26:0] absq10D;
    logic [8:0] sel10;
    logic [2:0] q10, q10_copy9;
    
    logic [26:0] betaw9, w8;
    logic[26:0] absq9D;
    logic [8:0] sel9;
    logic [2:0] q9, q9_copy10;
    
    logic [26:0] betaw8, w7;
    logic[26:0] absq8D;
    logic [8:0] sel8;
    logic [2:0] q8, q8_copy11;
    
    logic [26:0] betaw7, w6;
    logic[26:0] absq7D;
    logic [8:0] sel7;
    logic [2:0] q7, q7_copy12;
    
    logic [26:0] betaw6, w5;
    logic[26:0] absq6D;
    logic [8:0] sel6;
    logic [2:0] q6, q6_copy13;
    
    logic [26:0] betaw5, w4;
    logic[26:0] absq5D;
    logic [8:0] sel5;
    logic [2:0] q5, q5_copy14;
    
    logic [26:0] betaw4, w3;
    logic[26:0] absq4D;
    logic [8:0] sel4;
    logic [2:0] q4, q4_copy15;
    
    logic [26:0] betaw3, w2;
    logic[26:0] absq3D;
    logic [8:0] sel3;
    logic [2:0] q3, q3_copy16;
    
    logic [26:0] betaw2, w1;
    logic[26:0] absq2D;
    logic [8:0] sel2;
    logic [2:0] q2, q2_copy17;
    
    logic [26:0] betaw1, w0;
    logic[26:0] absq1D;
    logic [8:0] sel1;
    logic [2:0] q1, q1_copy18;

    logic [24:0] wfinal;
    logic qM0;
    logic [1:0] qP14, qM14, qP13, qM13, qP12, qM12, qP11, qM11, qP10, qM10;
    logic [1:0] qP9, qM9, qP8, qM8, qP7, qM7, qP6, qM6, qP5, qM5, qP4, qM4;
    logic [1:0] qP3, qM3, qP2, qM2, qP1, qM1;
    logic [27:0] qP, qM, quotient;
    logic [25:0] div_mR;
    logic [23:0] fRnorm;
    logic div_round;
    logic [9:0] expR1;
    logic [32:0] div_expfrac, expfracR;
    logic [31:0] div_R;

    // FPSqrt signals
    logic [22:0] fracX;
    logic [7:0] eRn0;
    logic [2:0] xsX;
    logic [7:0] eRn1;
    logic [26:0] fracXnorm;
    
    logic [1:0] S0;
    logic [26:0] T1;
    logic d1;
    logic [27:0] T1s;
    logic [5:0] T1s_h, U1, T3_h;
    logic [21:0] T1s_l;
    
    logic [26:0] T2;
    logic [2:0] S1;
    logic d2;
    logic [27:0] T2s;
    logic [6:0] T2s_h, U2, T4_h;
    logic [20:0] T2s_l;

    logic [26:0] T3;
    logic [3:0] S2;
    logic d3;
    logic [27:0] T3s;
    logic [7:0] T3s_h, U3, T5_h;
    logic [19:0] T3s_l;

    logic [26:0] T4;
    logic [4:0] S3;
    logic d4;
    logic [27:0] T4s;
    logic [8:0] T4s_h, U4, T6_h;
    logic [18:0] T4s_l;
    
    logic [26:0] T5;
    logic [5:0] S4;
    logic d5;
    logic [27:0] T5s;
    logic [9:0] T5s_h, U5, T7_h;
    logic [17:0] T5s_l;

    logic [26:0] T6;
    logic [6:0] S5;
    logic d6;
    logic [27:0] T6s;
    logic [10:0] T6s_h, U6, T8_h;
    logic [16:0] T6s_l;

    logic [26:0] T7;
    logic [7:0] S6;
    logic d7;
    logic [27:0] T7s;
    logic [11:0] T7s_h, U7, T9_h;
    logic [15:0] T7s_l;
    
    logic [26:0] T8;
    logic [8:0] S7;
    logic d8;
    logic [27:0] T8s;
    logic [12:0] T8s_h, U8, T10_h;
    logic [14:0] T8s_l;

    logic [26:0] T9;
    logic [9:0] S8;
    logic d9;
    logic [27:0] T9s;
    logic [13:0] T9s_h, U9, T11_h;
    logic [13:0] T9s_l;

    logic [26:0] T10;
    logic [10:0] S9;
    logic d10;
    logic [27:0] T10s;
    logic [14:0] T10s_h, U10, T12_h;
    logic [12:0] T10s_l;
    
    logic [26:0] T11;
    logic [11:0] S10;
    logic d11;
    logic [27:0] T11s;
    logic [15:0] T11s_h, U11, T13_h;
    logic [11:0] T11s_l;
    
    logic [26:0] T12;
    logic [12:0] S11;
    logic d12;
    logic [27:0] T12s;
    logic [16:0] T12s_h, U12, T14_h;
    logic [10:0] T12s_l;
    
    logic [26:0] T13;
    logic [13:0] S12;
    logic d13;
    logic [27:0] T13s;
    logic [17:0] T13s_h, U13, T15_h;
    logic [9:0] T13s_l;
    
    logic [26:0] T14;
    logic [14:0] S13;
    logic d14;
    logic [27:0] T14s;
    logic [18:0] T14s_h, U14, T16_h;
    logic [8:0] T14s_l;
    
    logic [26:0] T15;
    logic [15:0] S14;
    logic d15;
    logic [27:0] T15s;
    logic [19:0] T15s_h, U15, T17_h;
    logic [7:0] T15s_l;
    
    logic [26:0] T16;
    logic [16:0] S15;
    logic d16;
    logic [27:0] T16s;
    logic [20:0] T16s_h, U16, T18_h;
    logic [6:0] T16s_l;
    
    logic [26:0] T17;
    logic [17:0] S16;
    logic d17;
    logic [27:0] T17s;
    logic [21:0] T17s_h, U17, T19_h;
    logic [5:0] T17s_l;
    
    logic [26:0] T18;
    logic [18:0] S17;
    logic d18;
    logic [27:0] T18s;
    logic [22:0] T18s_h, U18, T20_h;
    logic [4:0] T18s_l;
    
    logic [26:0] T19;
    logic [19:0] S18;
    logic d19;
    logic [27:0] T19s;
    logic [23:0] T19s_h, U19, T21_h;
    logic [3:0] T19s_l;

    logic [26:0] T20;
    logic [20:0] S19;
    logic d20;
    logic [27:0] T20s;
    logic [24:0] T20s_h, U20, T22_h;
    logic [2:0] T20s_l;
    
    logic [26:0] T21;
    logic [21:0] S20;
    logic d21;
    logic [27:0] T21s;
    logic [25:0] T21s_h, U21, T23_h;
    logic [1:0] T21s_l;
    
    logic [26:0] T22;
    logic [22:0] S21;
    logic d22;
    logic [27:0] T22s;
    logic [26:0] T22s_h, U22, T24_h;
    logic [0:0] T22s_l;
    
    logic [26:0] T23;
    logic [23:0] S22;
    logic d23;
    logic [27:0] T23s;
    logic [27:0] T23s_h, U23, T25_h;
    
    logic [26:0] T24;
    logic [24:0] S23;
    logic d25;
    logic [25:0] sqrt_mR;
    logic [22:0] fR;
    logic sqrt_round;
    logic [22:0] fRrnd;
    logic [30:0] Rn2;
    logic [2:0] xsR;
    logic [31:0] sqrt_R;
    logic [22:0] sqrt_expFrac;

    // Shared Add/Sub Signals
    // Gen 0
    logic [27:0] shared_as_x0, shared_as_y0;
    logic shared_as_sub0;
    logic [27:0] shared_as_r0, sub_mask0, y_xor0, cin_vec0;
    
    // Gen 1
    logic [26:0] shared_as_x1, shared_as_y1;
    logic shared_as_sub1;
    logic [26:0] shared_as_r1;
    
    // Gen 2
    logic [26:0] shared_as_x2, shared_as_y2;
    logic shared_as_sub2;
    logic [26:0] shared_as_r2, sub_mask2, y_xor2, cin_vec2;
    
    // Gen 3
    logic [26:0] shared_as_x3, shared_as_y3;
    logic shared_as_sub3;
    logic [26:0] shared_as_r3;
    
    // Gen 4
    logic [26:0] shared_as_x4, shared_as_y4;
    logic shared_as_sub4;
    logic [26:0] shared_as_r4;
    
    // Gen 5
    logic [26:0] shared_as_x5, shared_as_y5;
    logic shared_as_sub5;
    logic [26:0] shared_as_r5, sub_mask5, y_xor5, cin_vec5;
    
    // Gen 6
    logic [26:0] shared_as_x6, shared_as_y6;
    logic shared_as_sub6;
    logic [26:0] shared_as_r6;
    
    // Gen 7
    logic [26:0] shared_as_x7, shared_as_y7;
    logic shared_as_sub7;
    logic [26:0] shared_as_r7;
    
    // Gen 8
    logic [26:0] shared_as_x8, shared_as_y8;
    logic shared_as_sub8;
    logic [26:0] shared_as_r8;
    
    // Gen 9
    logic [26:0] shared_as_x9, shared_as_y9;
    logic shared_as_sub9;
    logic [26:0] shared_as_r9;
    
    // Gen 10
    logic [26:0] shared_as_x10, shared_as_y10;
    logic shared_as_sub10;
    logic [26:0] shared_as_r10;
    
    // Gen 11
    logic [26:0] shared_as_x11, shared_as_y11;
    logic shared_as_sub11;
    logic [26:0] shared_as_r11;
    
    // Gen 12
    logic [26:0] shared_as_x12, shared_as_y12;
    logic shared_as_sub12;
    logic [26:0] shared_as_r12;
    
    // Gen 13
    logic [26:0] shared_as_x13, shared_as_y13;
    logic shared_as_sub13;
    logic [26:0] shared_as_r13, sub_mask13, y_xor13, cin_vec13;

    // Shared Output Signals
    logic [31:0] add_R, mul_R;
    logic [33:0] add_expFrac;
    logic add_round;
    logic [32:0] mul_expSig;
    // logic mul_round; // already defined
    logic [33:0] ra_X, ra_R;
    logic [33:0] add_ra_X, mul_ra_X, div_ra_X, sqrt_ra_X;
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
    assign add_fracAdder_X = fracXpad;       // Connect padded X fraction
    assign add_fracAdder_Y = fracYpadXorOp;  // Connect prepared Y fraction
    assign add_fracAdder_Cin = cInSigAdd;    // Carry-in accounting for subtraction and sticky bit
    assign fracAddResult = add_fracAdder_R;  // Get addition result back
    
    assign fracSticky = {fracAddResult, add_sticky};
    
    Normalizer_Z_28_28_28_Freq1_uid8 LZCAndShifter (
        .clk(clk),
        .X(fracSticky),
        .Count(nZerosNew),
        .R(shiftedFrac)
    );
    
    assign extendedExpInc = {1'b0, add_expX} + 9'd1;
    assign updatedExp = {1'b0, extendedExpInc} - {5'b00000, nZerosNew};
    assign eqdiffsign = (nZerosNew == 5'b11111) ? 1'b1 : 1'b0;
    
    assign add_expFrac = {updatedExp, shiftedFrac[26:3]};
    assign stk = shiftedFrac[2] | shiftedFrac[1] | shiftedFrac[0];
    assign rnd = shiftedFrac[3];
    assign lsb = shiftedFrac[4];
    // Connect to Shared Rounding Adder
    assign add_ra_X = add_expFrac; 
    assign add_round = ((rnd == 1'b1) && (stk == 1'b1)) || ((rnd == 1'b1) && (stk == 1'b0) && (lsb == 1'b1)) ? 1'b1 : 1'b0;
    // Get result from Shared Rounding Adder
    assign RoundedExpFrac = ra_R;
    assign fracR = RoundedExpFrac[23:1];
    assign expR = RoundedExpFrac[31:24];
    
    assign signR2 = ((eqdiffsign == 1'b1) && (EffSub == 1'b1)) ? 1'b0 : signR;
    assign add_R = {signR2, expR, fracR};

    
    // =================================================================================
    // FPMult Logic
    // =================================================================================
    
    assign sign = X[31] ^ Y[31];
    assign mul_expX = X[30:23];
    assign expY = Y[30:23];
    
    // Connect to Shared IntAdder_27
    assign mul_expAdder_X = mul_expX;        // Connect exponent X
    assign mul_expAdder_Y = expY;            // Connect exponent Y
    assign mul_expAdder_Cin = 1'b0;          // No carry-in needed for simple addition
    assign expSumPreSub = {1'b0, mul_expAdder_R[8:0]}; // Get addition result
    
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
    
    assign mul_expSig = expSig;
    // Connect to Shared Rounding Adder
    assign mul_ra_X = {1'b0, mul_expSig}; 
    
    // Get result from Shared Rounding Adder
    assign expSigPostRound = ra_R[30:0];
    assign mul_R = {sign, expSigPostRound};

    // =================================================================================
    // Shared Resources & Output Mux
    // =================================================================================

    // Multiplex inputs to Shared Rounding Adder
    // opcode: 00=Add, 01=Mul, 10=Sqrt, 11=Div
    // Multiplex inputs to Shared Rounding Adder
    // opcode: 00=Add, 01=Mul, 10=Sqrt, 11=Div
    assign ra_X = (opcode == 2'b00) ? add_ra_X :
                  mul_ra_X;                                  
    assign ra_Cin = (opcode == 2'b00) ? add_round :
                  mul_round;


    // Multiplex inputs to Shared IntAdder_27
    // opcode: 00=Add (fracAdder), 01=Mul (expAdder), others unused
    assign ia27_X[26:9] = add_fracAdder_X[26:9];
    assign ia27_X[8:0] = (opcode == 2'b00) ? add_fracAdder_X[8:0] : {1'b0, mul_expAdder_X}; // Lower bits shared: Add(8:0) vs Mul(Exp)
    
    assign ia27_Y[26:9] = add_fracAdder_Y[26:9];
    assign ia27_Y[8:0] = (opcode == 2'b00) ? add_fracAdder_Y[8:0] : {1'b0, mul_expAdder_Y}; // Lower bits shared
    
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

    IntAdder_34_Freq1_uid11 U_SHARED_RA (
        .clk(clk),
        .X(ra_X),
        .Y(34'd0),
        .Cin(ra_Cin),
        .R(ra_R)
    );

assign R = (opcode == 2'b00) ? add_R :  // Add Result
            (opcode == 2'b01) ? mul_R :  // Mul Result
            32'h0;

endmodule