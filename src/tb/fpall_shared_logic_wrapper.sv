`timescale 1ns/1ps
import fpall_pkg::*;

// This wrapper provides a raw bit-vector interface for VHDL compatibility, 
// particularly for tools like ModelSim that are strict about mixed-language port types.
module fpall_shared_logic_wrapper(
    input logic clk,
    input logic [1:0] opcode_in, // 00: Add, 01: Mul, 10: Sqrt, 11: Div
    input logic       fmt_in,    // 1'b0: FP32, 1'b1: FP16
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

`ifdef V0_AREA_OPT
    area_opt u_dut (
        .clk(clk),
        .opcode(opcode_in),
        .X(X),
        .Y(Y),
        .R(R)
    );
`elsif V1_AREA_OPT
    area_opt u_dut (
        .clk(clk),
        .opcode(opcode_in),
        .fmt(fmt_in),
        .X(X),
        .Y(Y),
        .R(R)
    );
`elsif V1_1_FP32_ADD
    fp32_add u_dut (
        .clk(clk),
        .fmt(fp_fmt_e'(fmt_in)),
        .X(X),
        .Y(Y),
        .R(R)
    );

`elsif V1_2_FP32_MULT
    fp32_mult u_dut (
        .clk(clk),
        .fmt(fp_fmt_e'(fmt_in)),
        .X(X),
        .Y(Y),
        .R(R)
    );

`elsif V2_BF16_FULL
    fpall_shared u_dut (
        .clk(clk),
        .opcode(fp_op_e'(opcode_in)),
        .fmt(fp_fmt_e'(fmt_in)),
        .X(X),
        .Y(Y),
        .R(R)
    );
`elsif V2_1_BF16_ADD
    bf16_add u_dut (
        .clk(clk),
        .fmt(fp_fmt_e'(fmt_in)),
        .X(X),
        .Y(Y),
        .R(R)
    );

`elsif V2_2_BF16_MULT
    bf16_mult u_dut (
        .clk(clk),
        .fmt(fp_fmt_e'(fmt_in)),
        .X(X),
        .Y(Y),
        .R(R)
    );

`elsif V1_3_ADDMUL_ONLY
    addmul_only u_dut (
        .clk(clk),
        .opcode(opcode_in),
        .fmt(fmt_in),
        .X(X),
        .Y(Y),
        .R(R)
    );
`elsif ORIGINAL_SV
    // FloPoCo 34-bit format: [33:32]=exc(01=normal), [31]=sign, [30:23]=exp, [22:0]=frac
    // IEEE 32-bit:           [31]=sign, [30:23]=exp, [22:0]=frac
    logic [33:0] fpc_X, fpc_Y, fpc_R;
    assign fpc_X = {2'b01, X};   // assume normal (exc=01)
    assign fpc_Y = {2'b01, Y};
    FPALL_origin u_dut (
        .clk   (clk),
        .opcode({1'b0, opcode_in}),  // 2-bit opcode_in → 3-bit: 00=Add,01=Mul,10=Sqrt,11=Div
        .X     (fpc_X),
        .Y     (fpc_Y),
        .R     (fpc_R)
    );
    assign R = fpc_R[31:0];  // drop exc bits, return IEEE portion

`else
    // Trigger compilation error if no version is defined
    Error_No_DUT_Version_Defined_Check_Macros();
`endif

endmodule
