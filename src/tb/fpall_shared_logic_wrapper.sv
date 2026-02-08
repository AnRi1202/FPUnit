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
    add_fp32_bf16 u_dut (
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

`elsif V3_ADDMUL_ONLY
    addmul_only u_dut (
        .clk(clk),
        .opcode(opcode_in),
        .fmt(fmt_in),
        .X(X),
        .Y(Y),
        .R(R)
    );
`else
    // Trigger compilation error if no version is defined
    Error_No_DUT_Version_Defined_Check_Macros();
`endif

endmodule
