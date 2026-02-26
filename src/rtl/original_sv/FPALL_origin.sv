`timescale 1ns/1ps

// =================================================================================
// Unified Floating-Point Unit Wrapper (FloPoCo-based Baseline)
// Supports 2, 4, or 6 operations based on NUM_OPS parameter.
//
// Opcode Mapping (3rd bit for BF16, lower 2 bits match FPALL_shared):
//   000: Add  (FP32)
//   001: Mul  (FP32)
//   010: Sqrt (FP32)
//   011: Div  (FP32)
//   100: BFAdd (BF16 x 2)
//   101: BFMul (BF16 x 2)
//
// NUM_OPS:
//   1: Add only
//   2: Add + Mul
//   3: Mul only
//   4: Add + Mul + Sqrt + Div (All FP32)
//   5: Add + BFAdd
//   6: All (Add + Mul + Sqrt + Div + BFAdd + BFMul)
//   7: Mul + BFMul
// =================================================================================

module FPALL_origin #(
    parameter int NUM_OPS = 6
)(
    input  logic        clk,
    input  logic [2:0]  opcode,
    input  logic [33:0] X,  // FloPoCo 34-bit format
    input  logic [33:0] Y,
    output logic [33:0] R
);

    // Internal result wires
    logic [33:0] add_R, mul_R, sqrt_R, div_R;
    logic [33:0] bfadd_R, bfmult_R;
    logic [17:0] bfadd_h, bfadd_l, bfmul_h, bfmul_l;
    logic [17:0] X_bf_l, Y_bf_l;

    // -------------------------------------------------------------------------
    // FP32 Add (present unless Mul-only: NUM_OPS == 3 or 7)
    // -------------------------------------------------------------------------
    generate
        if (NUM_OPS != 3 && NUM_OPS != 7) begin : GEN_ADD
            FPAdd_8_23_Freq1_uid2 U_ADD (
                .clk(clk), .X(X), .Y(Y), .R(add_R)
            );
        end else begin : GEN_NO_ADD
            assign add_R = '0;
        end
    endgenerate

    // -------------------------------------------------------------------------
    // FP32 Mul (present unless Add-only: NUM_OPS == 1 or 5)
    // -------------------------------------------------------------------------
    generate
        if (NUM_OPS != 1 && NUM_OPS != 5) begin : GEN_MUL
            FPMult_8_23_uid2_Freq1_uid3 U_MUL (
                .clk(clk), .X(X), .Y(Y), .R(mul_R)
            );
        end else begin : GEN_NO_MUL
            assign mul_R = '0;
        end
    endgenerate

    // -------------------------------------------------------------------------
    // FP32 Sqrt + Div (present for NUM_OPS == 4 or 6)
    // -------------------------------------------------------------------------
    generate
        if (NUM_OPS == 4 || NUM_OPS == 6) begin : GEN_SQRT_DIV
            FPSqrt_8_23 U_SQRT (
                .clk(clk), .X(X), .R(sqrt_R)
            );
            FPDiv_8_23_Freq1_uid2 U_DIV (
                .clk(clk), .X(X), .Y(Y), .R(div_R)
            );
        end else begin : GEN_NO_SQRT_DIV
            assign sqrt_R = '0;
            assign div_R  = '0;
        end
    endgenerate

    // -------------------------------------------------------------------------
    // BF16 Ops (present for NUM_OPS >= 5)
    // -------------------------------------------------------------------------
    generate
        if (NUM_OPS >= 5) begin : GEN_BF16
            assign X_bf_l = {2'b00, X[15:0]};
            assign Y_bf_l = {2'b00, Y[15:0]};

            // BF16 Add (NUM_OPS == 5 or 6)
            if (NUM_OPS == 5 || NUM_OPS == 6) begin : GEN_BF_ADD
                FPAdd_8_7_Freq1_uid2 U_BFADD_H (  // Upper lane [33:16]
                    .clk(clk), .X(X[33:16]), .Y(Y[33:16]), .R(bfadd_h)
                );
                FPAdd_8_7_Freq1_uid2 U_BFADD_L (  // Lower lane [15:0]
                    .clk(clk), .X(X_bf_l), .Y(Y_bf_l), .R(bfadd_l)
                );
                assign bfadd_R = {bfadd_h, bfadd_l[15:0]};
            end else begin : GEN_NO_BF_ADD
                assign bfadd_R = '0;
                assign bfadd_h = '0;
                assign bfadd_l = '0;
            end

            // BF16 Mul (NUM_OPS == 6 or 7)
            if (NUM_OPS == 6 || NUM_OPS == 7) begin : GEN_BF_MUL
                FPMult_8_7_uid2_Freq1_uid3 U_BFMUL_H (  // Upper lane [33:16]
                    .clk(clk), .X(X[33:16]), .Y(Y[33:16]), .R(bfmul_h)
                );
                FPMult_8_7_uid2_Freq1_uid3 U_BFMUL_L (  // Lower lane [15:0]
                    .clk(clk), .X(X_bf_l), .Y(Y_bf_l), .R(bfmul_l)
                );
                assign bfmult_R = {bfmul_h, bfmul_l[15:0]};
            end else begin : GEN_NO_BF_MUL
                assign bfmult_R = '0;
                assign bfmul_h  = '0;
                assign bfmul_l  = '0;
            end
        end else begin : GEN_NO_BF16
            assign bfadd_R  = '0;
            assign bfmult_R = '0;
        end
    endgenerate

    // -------------------------------------------------------------------------
    // Output Mux
    // -------------------------------------------------------------------------
    always_comb begin
        if (NUM_OPS == 1) begin
            R = add_R;
        end else if (NUM_OPS == 3) begin
            R = mul_R;
        end else if (NUM_OPS == 5) begin
            // Add & BFAdd only
            case (opcode)
                3'b000:  R = add_R;
                3'b100:  R = bfadd_R;
                default: R = '0;
            endcase
        end else if (NUM_OPS == 7) begin
            // Mul & BFMul only
            case (opcode)
                3'b001:  R = mul_R;
                3'b101:  R = bfmult_R;
                default: R = '0;
            endcase
        end else begin
            // Full mux (NUM_OPS == 2, 4, 6)
            case (opcode)
                3'b000:  R = add_R;
                3'b001:  R = mul_R;
                3'b010:  R = sqrt_R;
                3'b011:  R = div_R;
                3'b100:  R = bfadd_R;
                3'b101:  R = bfmult_R;
                default: R = '0;
            endcase
        end
    end

endmodule
