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
`ifdef V1_1_FP32_ADD
    add_fp32_base u_dut (
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
`endif

endmodule
