`timescale 1ns/1ps
// =============================================================================
// fp32_all_origin.sv
// Direct SV translation of FloPoCo FP32 baseline (FPAdd + FPMult + FPSqrt + FPDiv)
// Step1: exc removed - 32-bit IEEE format [31]=sign, [30:23]=exp, [22:0]=frac
// =============================================================================

// ---------------------------------------------------------------------------
// Shared: RightShifterSticky24_by_max_26
// ---------------------------------------------------------------------------
module RightShifterSticky24_by_max_26_Freq1_uid4 (
    input  logic        clk,
    input  logic [23:0] X,
    input  logic [4:0]  S,
    output logic [25:0] R,
    output logic        Sticky
);
    logic [25:0] Xpad, l5, l4, l3, l2, l1, l0;
    logic s4, s3, s2, s1, s0;
    assign Xpad = {X, 2'b00};
    assign l5 = Xpad;
    assign s4 = (l5[15:0] != 16'h0) && S[4];
    assign l4 = S[4] ? {16'h0, l5[25:16]} : l5;
    assign s3 = ((l4[7:0] != 8'h0) && S[3]) || s4;
    assign l3 = S[3] ? {8'h0, l4[25:8]} : l4;
    assign s2 = ((l3[3:0] != 4'h0) && S[2]) || s3;
    assign l2 = S[2] ? {4'h0, l3[25:4]} : l3;
    assign s1 = ((l2[1:0] != 2'b0) && S[1]) || s2;
    assign l1 = S[1] ? {2'b0, l2[25:2]} : l2;
    assign s0 = (l1[0] && S[0]) || s1;
    assign l0 = S[0] ? {1'b0, l1[25:1]} : l1;
    assign R = l0;  assign Sticky = s0;
endmodule

// ---------------------------------------------------------------------------
// Shared: Normalizer_Z_28_28_28
// ---------------------------------------------------------------------------
module Normalizer_Z_28_28_28_Freq1_uid8 (
    input  logic        clk,
    input  logic [27:0] X,
    output logic [4:0]  Count,
    output logic [27:0] R
);
    logic [27:0] l5,l4,l3,l2,l1,l0;
    logic c4,c3,c2,c1,c0;
    assign l5=X;
    assign c4=(l5[27:12]==16'h0); assign l4=c4?{l5[11:0],16'h0}:l5;
    assign c3=(l4[27:20]== 8'h0); assign l3=c3?{l4[19:0], 8'h0}:l4;
    assign c2=(l3[27:24]== 4'h0); assign l2=c2?{l3[23:0], 4'h0}:l3;
    assign c1=(l2[27:26]== 2'b0); assign l1=c1?{l2[25:0], 2'b0}:l2;
    assign c0=(l1[27]   == 1'b0); assign l0=c0?{l1[26:0], 1'b0}:l1;
    assign R={l0}; assign Count={c4,c3,c2,c1,c0};
endmodule

// ---------------------------------------------------------------------------
// FPAdd_8_23_Freq1_uid2  (FP32 Adder, 32-bit I/O, exc removed)
// ---------------------------------------------------------------------------
module FPAdd_8_23_Freq1_uid2 (
    input  logic        clk,
    input  logic [31:0] X, Y,
    output logic [31:0] R
);
    logic [30:0] efX,efY; logic swap;
    logic [7:0]  eXmeY,eYmeX,expDiff; logic [31:0] newX,newY;
    logic [7:0]  expX; logic signX,signY,EffSub;
    logic [23:0] fracY;
    logic signR;
    logic shiftedOut; logic [4:0] shiftVal;
    logic [25:0] shiftedFracY; logic sticky;
    logic [26:0] fracYpad,ESV,fracYpadXor,fracXpad; logic cIn;
    logic [26:0] fracAddResult; logic [27:0] fracSticky;
    logic [4:0]  nZerosNew; logic [27:0] shiftedFrac;
    logic [8:0]  extExpInc; logic [9:0] updatedExp; logic eqdiffsign;
    logic [31:0] expFrac; logic stk,rnd,lsb,needRound;
    logic [31:0] RoundedEF; logic [22:0] fracR;
    logic [7:0]  expR; logic signR2;

    assign efX=X[30:0]; assign efY=Y[30:0];
    assign swap=(efX<efY);
    assign eXmeY=X[30:23]-Y[30:23]; assign eYmeX=Y[30:23]-X[30:23];
    assign expDiff=swap?eYmeX:eXmeY;
    assign newX=swap?Y:X; assign newY=swap?X:Y;
    assign expX=newX[30:23]; assign signX=newX[31]; assign signY=newY[31]; assign EffSub=signX^signY;
    assign fracY={1'b1,newY[22:0]};  // exc removed: always normal

    assign signR=signX;
    assign shiftedOut=(expDiff>8'd25); assign shiftVal=shiftedOut?5'd26:expDiff[4:0];

    RightShifterSticky24_by_max_26_Freq1_uid4 u_rs(.clk,.X(fracY),.S(shiftVal),.R(shiftedFracY),.Sticky(sticky));

    assign fracYpad={1'b0,shiftedFracY}; assign ESV={27{EffSub}}; assign fracYpadXor=fracYpad^ESV;
    assign fracXpad={2'b01,newX[22:0],2'b00}; assign cIn=EffSub&(~sticky);
    assign fracAddResult=fracXpad+fracYpadXor+{{26{1'b0}},cIn};
    assign fracSticky={fracAddResult,sticky};

    Normalizer_Z_28_28_28_Freq1_uid8 u_norm(.clk,.X(fracSticky),.Count(nZerosNew),.R(shiftedFrac));

    assign extExpInc={1'b0,expX}+9'd1; assign updatedExp={1'b0,extExpInc}-{5'b0,nZerosNew};
    assign eqdiffsign=(nZerosNew==5'b11111);
    assign expFrac={updatedExp[7:0],shiftedFrac[26:4]};  // 8bit + 23bit (area_opt同様)
    assign stk=shiftedFrac[2]|shiftedFrac[1]|shiftedFrac[0];
    assign rnd=shiftedFrac[3]; assign lsb=shiftedFrac[4];
    assign needRound=(rnd&stk)|(rnd&~stk&lsb);
    assign RoundedEF=expFrac+{{30{1'b0}},needRound};
    assign fracR=RoundedEF[22:0]; assign expR=RoundedEF[30:23];
    assign signR2=(eqdiffsign&&EffSub)?1'b0:signR;
    assign R={signR2,expR,fracR};
endmodule


// ---------------------------------------------------------------------------
// FPMult_8_23_uid2_Freq1_uid3  (FP32 Multiplier, 32-bit I/O, exc removed)
// ---------------------------------------------------------------------------
module FPMult_8_23_uid2_Freq1_uid3 (
    input  logic        clk,
    input  logic [31:0] X, Y,
    output logic [31:0] R
);
    logic        sign;
    logic [7:0]  expX,expY;
    logic [9:0]  expSumPreSub,bias,expSum;
    logic [23:0] sigX,sigY;
    logic [47:0] sigProd,sigProdExt;
    logic        norm;
    logic [9:0]  expPostNorm;
    logic [31:0] expSig,expSigPostRound;
    logic        sticky,guard,round;

    assign sign=X[31]^Y[31];
    assign expX=X[30:23]; assign expY=Y[30:23];
    assign expSumPreSub={2'b0,expX}+{2'b0,expY};
    assign bias=10'd127; assign expSum=expSumPreSub-bias;
    assign sigX={1'b1,X[22:0]}; assign sigY={1'b1,Y[22:0]};
    assign sigProd=sigX*sigY;

    assign norm=sigProd[47];
    assign expPostNorm=expSum+{9'd0,norm};
    assign sigProdExt=norm?{sigProd[46:0],1'b0}:{sigProd[45:0],2'b00};
    assign expSig={expPostNorm[7:0],sigProdExt[47:25]};  // 8bit + 23bit (area_opt同様)
    assign sticky=sigProdExt[24];
    assign guard=(sigProdExt[23:0]!=24'h0);
    assign round=sticky&((guard&~sigProdExt[25])|sigProdExt[25]);
    assign expSigPostRound=expSig+{{30{1'b0}},round};
    assign R={sign,expSigPostRound[30:0]};
endmodule


// ---------------------------------------------------------------------------
// FPSqrt_8_23  (FP32 Square Root, 32-bit I/O, exc removed)
// ---------------------------------------------------------------------------
module FPSqrt_8_23 (
    input  logic        clk,
    input  logic [31:0] X,
    output logic [31:0] R
);
    logic [22:0] fracX; logic [7:0] eRn0,eRn1;
    logic [26:0] fracXnorm;
    // Recurrence state: S (accumulated root) and T (remainder)
    logic [1:0]  S0;
    logic [26:0] T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24;
    logic [27:0] T1s,T2s,T3s,T4s,T5s,T6s,T7s,T8s,T9s,T10s,T11s,T12s,T13s,T14s,T15s,T16s,T17s,T18s,T19s,T20s,T21s,T22s,T23s;
    logic        d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d25;
    logic [5:0]  T1s_h,U1,T3_h;  logic [21:0] T1s_l;
    logic [6:0]  T2s_h,U2,T4_h;  logic [20:0] T2s_l;
    logic [7:0]  T3s_h,U3,T5_h;  logic [19:0] T3s_l;
    logic [8:0]  T4s_h,U4,T6_h;  logic [18:0] T4s_l;
    logic [9:0]  T5s_h,U5,T7_h;  logic [17:0] T5s_l;
    logic [10:0] T6s_h,U6,T8_h;  logic [16:0] T6s_l;
    logic [11:0] T7s_h,U7,T9_h;  logic [15:0] T7s_l;
    logic [12:0] T8s_h,U8,T10_h; logic [14:0] T8s_l;
    logic [13:0] T9s_h,U9,T11_h; logic [13:0] T9s_l;
    logic [14:0] T10s_h,U10,T12_h;logic[12:0] T10s_l;
    logic [15:0] T11s_h,U11,T13_h;logic[11:0] T11s_l;
    logic [16:0] T12s_h,U12,T14_h;logic[10:0] T12s_l;
    logic [17:0] T13s_h,U13,T15_h;logic[9:0]  T13s_l;
    logic [18:0] T14s_h,U14,T16_h;logic[8:0]  T14s_l;
    logic [19:0] T15s_h,U15,T17_h;logic[7:0]  T15s_l;
    logic [20:0] T16s_h,U16,T18_h;logic[6:0]  T16s_l;
    logic [21:0] T17s_h,U17,T19_h;logic[5:0]  T17s_l;
    logic [22:0] T18s_h,U18,T20_h;logic[4:0]  T18s_l;
    logic [23:0] T19s_h,U19,T21_h;logic[3:0]  T19s_l;
    logic [24:0] T20s_h,U20,T22_h;logic[2:0]  T20s_l;
    logic [25:0] T21s_h,U21,T23_h;logic[1:0]  T21s_l;
    logic [26:0] T22s_h,U22,T24_h;logic[0:0]  T22s_l;
    logic [27:0] T23s_h,U23,T25_h;
    logic [1:0]  S1; logic [2:0] S2; logic [3:0] S3; logic [4:0] S4;
    logic [5:0]  S5; logic [6:0] S6; logic [7:0] S7; logic [8:0] S8;
    logic [9:0]  S9; logic [10:0] S10;logic [11:0] S11;logic [12:0] S12;
    logic [13:0] S13;logic [14:0] S14;logic [15:0] S15;logic [16:0] S16;
    logic [17:0] S17;logic [18:0] S18;logic [19:0] S19;logic [20:0] S20;
    logic [21:0] S21;logic [22:0] S22;logic [23:0] S23;
    logic [25:0] mR; logic [22:0] fR,fRrnd; logic round;
    logic [30:0] Rn2;

    assign fracX=X[22:0]; assign eRn0={1'b0,X[30:24]};
    assign eRn1=eRn0+8'h3f+{7'd0,X[23]};
    assign fracXnorm=X[23]?{2'b01,fracX,2'b0}:{1'b1,fracX,3'b0};
    assign S0=2'b01;
    assign T1={(4'b0111+fracXnorm[26:23]),fracXnorm[22:0]};

    // Step 2
    assign d1=~T1[26]; assign T1s={T1,1'b0}; assign T1s_h=T1s[27:22]; assign T1s_l=T1s[21:0];
    assign U1={1'b0,S0,d1,~d1,1'b1};
    assign T3_h=d1?(T1s_h-U1):(T1s_h+U1); assign T2={T3_h[4:0],T1s_l}; assign S1={S0,d1};
    // Step 3
    assign d2=~T2[26]; assign T2s={T2,1'b0}; assign T2s_h=T2s[27:21]; assign T2s_l=T2s[20:0];
    assign U2={1'b0,S1,d2,~d2,1'b1};
    assign T4_h=d2?(T2s_h-U2):(T2s_h+U2); assign T3={T4_h[5:0],T2s_l}; assign S2={S1,d2};
    // Step 4
    assign d3=~T3[26]; assign T3s={T3,1'b0}; assign T3s_h=T3s[27:20]; assign T3s_l=T3s[19:0];
    assign U3={1'b0,S2,d3,~d3,1'b1};
    assign T5_h=d3?(T3s_h-U3):(T3s_h+U3); assign T4={T5_h[6:0],T3s_l}; assign S3={S2,d3};
    // Step 5
    assign d4=~T4[26]; assign T4s={T4,1'b0}; assign T4s_h=T4s[27:19]; assign T4s_l=T4s[18:0];
    assign U4={1'b0,S3,d4,~d4,1'b1};
    assign T6_h=d4?(T4s_h-U4):(T4s_h+U4); assign T5={T6_h[7:0],T4s_l}; assign S4={S3,d4};
    // Step 6
    assign d5=~T5[26]; assign T5s={T5,1'b0}; assign T5s_h=T5s[27:18]; assign T5s_l=T5s[17:0];
    assign U5={1'b0,S4,d5,~d5,1'b1};
    assign T7_h=d5?(T5s_h-U5):(T5s_h+U5); assign T6={T7_h[8:0],T5s_l}; assign S5={S4,d5};
    // Step 7
    assign d6=~T6[26]; assign T6s={T6,1'b0}; assign T6s_h=T6s[27:17]; assign T6s_l=T6s[16:0];
    assign U6={1'b0,S5,d6,~d6,1'b1};
    assign T8_h=d6?(T6s_h-U6):(T6s_h+U6); assign T7={T8_h[9:0],T6s_l}; assign S6={S5,d6};
    // Step 8
    assign d7=~T7[26]; assign T7s={T7,1'b0}; assign T7s_h=T7s[27:16]; assign T7s_l=T7s[15:0];
    assign U7={1'b0,S6,d7,~d7,1'b1};
    assign T9_h=d7?(T7s_h-U7):(T7s_h+U7); assign T8={T9_h[10:0],T7s_l}; assign S7={S6,d7};
    // Step 9
    assign d8=~T8[26]; assign T8s={T8,1'b0}; assign T8s_h=T8s[27:15]; assign T8s_l=T8s[14:0];
    assign U8={1'b0,S7,d8,~d8,1'b1};
    assign T10_h=d8?(T8s_h-U8):(T8s_h+U8); assign T9={T10_h[11:0],T8s_l}; assign S8={S7,d8};
    // Step 10
    assign d9=~T9[26]; assign T9s={T9,1'b0}; assign T9s_h=T9s[27:14]; assign T9s_l=T9s[13:0];
    assign U9={1'b0,S8,d9,~d9,1'b1};
    assign T11_h=d9?(T9s_h-U9):(T9s_h+U9); assign T10={T11_h[12:0],T9s_l}; assign S9={S8,d9};
    // Step 11
    assign d10=~T10[26]; assign T10s={T10,1'b0}; assign T10s_h=T10s[27:13]; assign T10s_l=T10s[12:0];
    assign U10={1'b0,S9,d10,~d10,1'b1};
    assign T12_h=d10?(T10s_h-U10):(T10s_h+U10); assign T11={T12_h[13:0],T10s_l}; assign S10={S9,d10};
    // Step 12
    assign d11=~T11[26]; assign T11s={T11,1'b0}; assign T11s_h=T11s[27:12]; assign T11s_l=T11s[11:0];
    assign U11={1'b0,S10,d11,~d11,1'b1};
    assign T13_h=d11?(T11s_h-U11):(T11s_h+U11); assign T12={T13_h[14:0],T11s_l}; assign S11={S10,d11};
    // Step 13
    assign d12=~T12[26]; assign T12s={T12,1'b0}; assign T12s_h=T12s[27:11]; assign T12s_l=T12s[10:0];
    assign U12={1'b0,S11,d12,~d12,1'b1};
    assign T14_h=d12?(T12s_h-U12):(T12s_h+U12); assign T13={T14_h[15:0],T12s_l}; assign S12={S11,d12};
    // Step 14
    assign d13=~T13[26]; assign T13s={T13,1'b0}; assign T13s_h=T13s[27:10]; assign T13s_l=T13s[9:0];
    assign U13={1'b0,S12,d13,~d13,1'b1};
    assign T15_h=d13?(T13s_h-U13):(T13s_h+U13); assign T14={T15_h[16:0],T13s_l}; assign S13={S12,d13};
    // Step 15
    assign d14=~T14[26]; assign T14s={T14,1'b0}; assign T14s_h=T14s[27:9]; assign T14s_l=T14s[8:0];
    assign U14={1'b0,S13,d14,~d14,1'b1};
    assign T16_h=d14?(T14s_h-U14):(T14s_h+U14); assign T15={T16_h[17:0],T14s_l}; assign S14={S13,d14};
    // Step 16
    assign d15=~T15[26]; assign T15s={T15,1'b0}; assign T15s_h=T15s[27:8]; assign T15s_l=T15s[7:0];
    assign U15={1'b0,S14,d15,~d15,1'b1};
    assign T17_h=d15?(T15s_h-U15):(T15s_h+U15); assign T16={T17_h[18:0],T15s_l}; assign S15={S14,d15};
    // Step 17
    assign d16=~T16[26]; assign T16s={T16,1'b0}; assign T16s_h=T16s[27:7]; assign T16s_l=T16s[6:0];
    assign U16={1'b0,S15,d16,~d16,1'b1};
    assign T18_h=d16?(T16s_h-U16):(T16s_h+U16); assign T17={T18_h[19:0],T16s_l}; assign S16={S15,d16};
    // Step 18
    assign d17=~T17[26]; assign T17s={T17,1'b0}; assign T17s_h=T17s[27:6]; assign T17s_l=T17s[5:0];
    assign U17={1'b0,S16,d17,~d17,1'b1};
    assign T19_h=d17?(T17s_h-U17):(T17s_h+U17); assign T18={T19_h[20:0],T17s_l}; assign S17={S16,d17};
    // Step 19
    assign d18=~T18[26]; assign T18s={T18,1'b0}; assign T18s_h=T18s[27:5]; assign T18s_l=T18s[4:0];
    assign U18={1'b0,S17,d18,~d18,1'b1};
    assign T20_h=d18?(T18s_h-U18):(T18s_h+U18); assign T19={T20_h[21:0],T18s_l}; assign S18={S17,d18};
    // Step 20
    assign d19=~T19[26]; assign T19s={T19,1'b0}; assign T19s_h=T19s[27:4]; assign T19s_l=T19s[3:0];
    assign U19={1'b0,S18,d19,~d19,1'b1};
    assign T21_h=d19?(T19s_h-U19):(T19s_h+U19); assign T20={T21_h[22:0],T19s_l}; assign S19={S18,d19};
    // Step 21
    assign d20=~T20[26]; assign T20s={T20,1'b0}; assign T20s_h=T20s[27:3]; assign T20s_l=T20s[2:0];
    assign U20={1'b0,S19,d20,~d20,1'b1};
    assign T22_h=d20?(T20s_h-U20):(T20s_h+U20); assign T21={T22_h[23:0],T20s_l}; assign S20={S19,d20};
    // Step 22
    assign d21=~T21[26]; assign T21s={T21,1'b0}; assign T21s_h=T21s[27:2]; assign T21s_l=T21s[1:0];
    assign U21={1'b0,S20,d21,~d21,1'b1};
    assign T23_h=d21?(T21s_h-U21):(T21s_h+U21); assign T22={T23_h[24:0],T21s_l}; assign S21={S20,d21};
    // Step 23
    assign d22=~T22[26]; assign T22s={T22,1'b0}; assign T22s_h=T22s[27:1]; assign T22s_l=T22s[0:0];
    assign U22={1'b0,S21,d22,~d22,1'b1};
    assign T24_h=d22?(T22s_h-U22):(T22s_h+U22); assign T23={T24_h[25:0],T22s_l}; assign S22={S21,d22};
    // Step 24
    assign d23=~T23[26]; assign T23s={T23,1'b0}; assign T23s_h=T23s[27:0];
    assign U23={1'b0,S22,d23,~d23,1'b1};
    assign T25_h=d23?(T23s_h-U23):(T23s_h+U23); assign T24=T25_h[26:0]; assign S23={S22,d23};
    // Final
    assign d25=~T24[26]; assign mR={S23,d25};
    assign fR=mR[23:1]; assign round=mR[0];
    assign fRrnd=fR+{22'b0,round};
    assign Rn2={eRn1,fRrnd};
    assign R={X[31],Rn2};  // exc removed: pass through sign
endmodule


// ---------------------------------------------------------------------------
// selFunction_Freq1_uid4  (Radix-2 digit selection table for FPDiv)
// ---------------------------------------------------------------------------
module selFunction_Freq1_uid4 (
    input  logic [8:0] X,
    output logic [2:0] Y
);
    logic [2:0] Y0;
    always_comb begin
        // Upper half (X[8]=1) → negative digits (110=−2, 111=−1)
        if (X[8]) begin
            if      (X[7:0] >= 8'hAB) Y0=3'b000; // near zero
            else if (X[7:0] >= 8'h81) Y0=3'b111; // -1
            else                       Y0=3'b110; // -2
        end else begin
            // Lower half (X[8]=0) → positive digits
            if      (X[7:0] >= 8'h60) Y0=3'b010; // +2
            else if (X[7:0] >= 8'h30) Y0=3'b001; // +1
            else if (X[7:0] >= 8'h18) Y0=3'b001;
            else                       Y0=3'b000; // 0
        end
    end
    assign Y=Y0;
endmodule


// ---------------------------------------------------------------------------
// FPDiv_8_23_Freq1_uid2  (FP32 Divider, 32-bit I/O, exc removed)
// ---------------------------------------------------------------------------
module FPDiv_8_23_Freq1_uid2 (
    input  logic        clk,
    input  logic [31:0] X, Y,
    output logic [31:0] R
);
    logic [23:0] fX,fY,D;
    logic [9:0]  expR0;
    logic        sR;
    logic [24:0] psX;
    // Remainder chain: betaw = 4*w
    logic [26:0] bw14,bw13,bw12,bw11,bw10,bw9,bw8,bw7,bw6,bw5,bw4,bw3,bw2,bw1;
    logic [26:0] w13,w12,w11,w10,w9,w8,w7,w6,w5,w4,w3,w2,w1,w0;
    logic [8:0]  sel14,sel13,sel12,sel11,sel10,sel9,sel8,sel7,sel6,sel5,sel4,sel3,sel2,sel1;
    logic [2:0]  q14,q13,q12,q11,q10,q9,q8,q7,q6,q5,q4,q3,q2,q1;
    logic [26:0] aqD14,aqD13,aqD12,aqD11,aqD10,aqD9,aqD8,aqD7,aqD6,aqD5,aqD4,aqD3,aqD2,aqD1;
    logic [1:0]  qP14,qM14,qP13,qM13,qP12,qM12,qP11,qM11,qP10,qM10;
    logic [1:0]  qP9,qM9,qP8,qM8,qP7,qM7,qP6,qM6,qP5,qM5,qP4,qM4,qP3,qM3,qP2,qM2,qP1,qM1;
    logic [27:0] qP,qM,quotient;
    logic [24:0] wfinal; logic qM0;
    logic [25:0] mR; logic [23:0] fRnorm; logic round;
    logic [9:0]  expR1;
    logic [31:0] expfrac,expfracR;

    assign fX={1'b1,X[22:0]}; assign fY={1'b1,Y[22:0]};
    assign expR0={2'b0,X[30:23]}-{2'b0,Y[30:23]};
    assign sR=X[31]^Y[31];

    assign D=fY; assign psX={1'b0,fX};

    // Iteration macro: absqD = |q|*D (0,D,or 2D); w_next = 4*w_prev +-absqD
    `define DIV_STEP(w_in, bw_out, sel_in, q_out, aqD_out, w_out) \
        assign bw_out={w_in[24:0],2'b0}; \
        assign sel_in={bw_out[26:21],D[22:20]}; \
        selFunction_Freq1_uid4 u_sel_``q_out (.X(sel_in),.Y(q_out)); \
        always_comb case(q_out) \
            3'b001,3'b111: aqD_out={3'b0,D}; \
            3'b010,3'b110: aqD_out={2'b0,D,1'b0}; \
            default:       aqD_out=27'd0; \
        endcase \
        assign w_out=q_out[2]?(bw_out+aqD_out):(bw_out-aqD_out);

    assign bw14={2'b0,psX};
    assign sel14={bw14[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s14(.X(sel14),.Y(q14));
    always_comb case(q14) 3'b001,3'b111:aqD14={3'b0,D}; 3'b010,3'b110:aqD14={2'b0,D,1'b0}; default:aqD14=27'd0; endcase
    assign w13=q14[2]?(bw14+aqD14):(bw14-aqD14);

    assign bw13={w13[24:0],2'b0}; assign sel13={bw13[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s13(.X(sel13),.Y(q13));
    always_comb case(q13) 3'b001,3'b111:aqD13={3'b0,D}; 3'b010,3'b110:aqD13={2'b0,D,1'b0}; default:aqD13=27'd0; endcase
    assign w12=q13[2]?(bw13+aqD13):(bw13-aqD13);

    assign bw12={w12[24:0],2'b0}; assign sel12={bw12[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s12(.X(sel12),.Y(q12));
    always_comb case(q12) 3'b001,3'b111:aqD12={3'b0,D}; 3'b010,3'b110:aqD12={2'b0,D,1'b0}; default:aqD12=27'd0; endcase
    assign w11=q12[2]?(bw12+aqD12):(bw12-aqD12);

    assign bw11={w11[24:0],2'b0}; assign sel11={bw11[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s11(.X(sel11),.Y(q11));
    always_comb case(q11) 3'b001,3'b111:aqD11={3'b0,D}; 3'b010,3'b110:aqD11={2'b0,D,1'b0}; default:aqD11=27'd0; endcase
    assign w10=q11[2]?(bw11+aqD11):(bw11-aqD11);

    assign bw10={w10[24:0],2'b0}; assign sel10={bw10[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s10(.X(sel10),.Y(q10));
    always_comb case(q10) 3'b001,3'b111:aqD10={3'b0,D}; 3'b010,3'b110:aqD10={2'b0,D,1'b0}; default:aqD10=27'd0; endcase
    assign w9=q10[2]?(bw10+aqD10):(bw10-aqD10);

    assign bw9={w9[24:0],2'b0}; assign sel9={bw9[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s9(.X(sel9),.Y(q9));
    always_comb case(q9) 3'b001,3'b111:aqD9={3'b0,D}; 3'b010,3'b110:aqD9={2'b0,D,1'b0}; default:aqD9=27'd0; endcase
    assign w8=q9[2]?(bw9+aqD9):(bw9-aqD9);

    assign bw8={w8[24:0],2'b0}; assign sel8={bw8[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s8(.X(sel8),.Y(q8));
    always_comb case(q8) 3'b001,3'b111:aqD8={3'b0,D}; 3'b010,3'b110:aqD8={2'b0,D,1'b0}; default:aqD8=27'd0; endcase
    assign w7=q8[2]?(bw8+aqD8):(bw8-aqD8);

    assign bw7={w7[24:0],2'b0}; assign sel7={bw7[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s7(.X(sel7),.Y(q7));
    always_comb case(q7) 3'b001,3'b111:aqD7={3'b0,D}; 3'b010,3'b110:aqD7={2'b0,D,1'b0}; default:aqD7=27'd0; endcase
    assign w6=q7[2]?(bw7+aqD7):(bw7-aqD7);

    assign bw6={w6[24:0],2'b0}; assign sel6={bw6[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s6(.X(sel6),.Y(q6));
    always_comb case(q6) 3'b001,3'b111:aqD6={3'b0,D}; 3'b010,3'b110:aqD6={2'b0,D,1'b0}; default:aqD6=27'd0; endcase
    assign w5=q6[2]?(bw6+aqD6):(bw6-aqD6);

    assign bw5={w5[24:0],2'b0}; assign sel5={bw5[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s5(.X(sel5),.Y(q5));
    always_comb case(q5) 3'b001,3'b111:aqD5={3'b0,D}; 3'b010,3'b110:aqD5={2'b0,D,1'b0}; default:aqD5=27'd0; endcase
    assign w4=q5[2]?(bw5+aqD5):(bw5-aqD5);

    assign bw4={w4[24:0],2'b0}; assign sel4={bw4[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s4(.X(sel4),.Y(q4));
    always_comb case(q4) 3'b001,3'b111:aqD4={3'b0,D}; 3'b010,3'b110:aqD4={2'b0,D,1'b0}; default:aqD4=27'd0; endcase
    assign w3=q4[2]?(bw4+aqD4):(bw4-aqD4);

    assign bw3={w3[24:0],2'b0}; assign sel3={bw3[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s3(.X(sel3),.Y(q3));
    always_comb case(q3) 3'b001,3'b111:aqD3={3'b0,D}; 3'b010,3'b110:aqD3={2'b0,D,1'b0}; default:aqD3=27'd0; endcase
    assign w2=q3[2]?(bw3+aqD3):(bw3-aqD3);

    assign bw2={w2[24:0],2'b0}; assign sel2={bw2[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s2(.X(sel2),.Y(q2));
    always_comb case(q2) 3'b001,3'b111:aqD2={3'b0,D}; 3'b010,3'b110:aqD2={2'b0,D,1'b0}; default:aqD2=27'd0; endcase
    assign w1=q2[2]?(bw2+aqD2):(bw2-aqD2);

    assign bw1={w1[24:0],2'b0}; assign sel1={bw1[26:21],D[22:20]};
    selFunction_Freq1_uid4 u_s1(.X(sel1),.Y(q1));
    always_comb case(q1) 3'b001,3'b111:aqD1={3'b0,D}; 3'b010,3'b110:aqD1={2'b0,D,1'b0}; default:aqD1=27'd0; endcase
    assign w0=q1[2]?(bw1+aqD1):(bw1-aqD1);

    // Quotient assembly (on-the-fly)
    assign wfinal=w0[24:0]; assign qM0=wfinal[24];
    assign qP14=q14[1:0]; assign qM14={q14[2],1'b0};
    assign qP13=q13[1:0]; assign qM13={q13[2],1'b0};
    assign qP12=q12[1:0]; assign qM12={q12[2],1'b0};
    assign qP11=q11[1:0]; assign qM11={q11[2],1'b0};
    assign qP10=q10[1:0]; assign qM10={q10[2],1'b0};
    assign qP9=q9[1:0];   assign qM9={q9[2],1'b0};
    assign qP8=q8[1:0];   assign qM8={q8[2],1'b0};
    assign qP7=q7[1:0];   assign qM7={q7[2],1'b0};
    assign qP6=q6[1:0];   assign qM6={q6[2],1'b0};
    assign qP5=q5[1:0];   assign qM5={q5[2],1'b0};
    assign qP4=q4[1:0];   assign qM4={q4[2],1'b0};
    assign qP3=q3[1:0];   assign qM3={q3[2],1'b0};
    assign qP2=q2[1:0];   assign qM2={q2[2],1'b0};
    assign qP1=q1[1:0];   assign qM1={q1[2],1'b0};
    assign qP={qP14,qP13,qP12,qP11,qP10,qP9,qP8,qP7,qP6,qP5,qP4,qP3,qP2,qP1};
    assign qM={qM14[0],qM13,qM12,qM11,qM10,qM9,qM8,qM7,qM6,qM5,qM4,qM3,qM2,qM1,qM0};
    assign quotient=qP-qM;
    assign mR=quotient[26:1];
    assign fRnorm=mR[25]?mR[24:1]:mR[23:0];
    assign round=fRnorm[0];
    assign expR1=expR0+{3'b0,6'b111111,mR[25]};
    assign expfrac={expR1[7:0],fRnorm[23:1]};  // 8bit + 23bit (area_opt同様)
    assign expfracR=expfrac+{{30{1'b0}},round};
    assign R={sR,expfracR[30:0]};
endmodule


// ---------------------------------------------------------------------------
// FPALL_origin  (top-level wrapper, 32-bit I/O, NUM_OPS=4: Add+Mul+Sqrt+Div)
// ---------------------------------------------------------------------------
module FPALL_origin #(
    parameter int NUM_OPS = 4
)(
    input  logic        clk,
    input  logic [2:0]  opcode,
    input  logic [31:0] X, Y,
    output logic [31:0] R
);
    logic [31:0] add_R, mul_R, sqrt_R, div_R;

    generate
        if (NUM_OPS != 3) begin : G_ADD
            FPAdd_8_23_Freq1_uid2  u_add  (.clk,.X,.Y,.R(add_R));
        end else begin : G_NOADD
            assign add_R=32'h0;
        end
        if (NUM_OPS != 1) begin : G_MUL
            FPMult_8_23_uid2_Freq1_uid3 u_mul (.clk,.X,.Y,.R(mul_R));
        end else begin : G_NOMUL
            assign mul_R=32'h0;
        end
        if (NUM_OPS == 4) begin : G_SQRTDIV
            FPSqrt_8_23           u_sqrt (.clk,.X(X),.R(sqrt_R));
            FPDiv_8_23_Freq1_uid2 u_div  (.clk,.X(X),.Y(Y),.R(div_R));
        end else begin : G_NOSQRTDIV
            assign sqrt_R=32'h0; assign div_R=32'h0;
        end
    endgenerate

    always_comb begin
        if (NUM_OPS==1)      R=add_R;
        else if (NUM_OPS==3) R=mul_R;
        else case(opcode)
            3'b000: R=add_R;
            3'b001: R=mul_R;
            3'b010: R=sqrt_R;
            3'b011: R=div_R;
            default:R=32'h0;
        endcase
    end
endmodule
