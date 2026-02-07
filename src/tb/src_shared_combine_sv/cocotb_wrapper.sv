`timescale 1ns/1ps
import fpall_pkg::*;
import fp_pkg::*;

// FP32 Addition Wrapper
module fp32_add_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   logic           i_mode,
  input   fp_pkg::fp32_t  i_operand_a,
  input   fp_pkg::fp32_t  i_operand_b,
  output  fp_pkg::fp32_t  o_sum
);

  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP32),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_sum)
  );

endmodule


// FP32 Multiplication Wrapper
module fp32_mul_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   logic           i_mode,
  input   fp_pkg::fp32_t  i_operand_a,
  input   fp_pkg::fp32_t  i_operand_b,
  output  fp_pkg::fp32_t  o_prod
);

  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP32),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_prod)
  );

endmodule


// BFloat16 Addition Wrapper (Dual-Lane)
module bf16_add_wrapper (
  input   logic                i_clk,
  input   logic                i_rst_n,
  input   logic                i_mode,
  input   fp_pkg::bf16_t [1:0] i_operand_a,
  input   fp_pkg::bf16_t [1:0] i_operand_b,
  output  fp_pkg::bf16_t [1:0] o_sum
);

  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP16), // FP16 in fpall_shared refers to dual-lane 16-bit mode (BF16)
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_sum)
  );

endmodule


// BFloat16 Multiplication Wrapper (Dual-Lane)
module bf16_mul_wrapper (
  input   logic                i_clk,
  input   logic                i_rst_n,
  input   logic                i_mode,
  input   fp_pkg::bf16_t [1:0] i_operand_a,
  input   fp_pkg::bf16_t [1:0] i_operand_b,
  output  fp_pkg::bf16_t [1:0] o_prod
);

  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP16),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_prod)
  );

endmodule


// FP32 Square Root Wrapper
module fp32_sqrt_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   logic           i_mode,
  input   fp_pkg::fp32_t  i_operand,
  output  fp_pkg::fp32_t  o_result
);

  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_SQRT),
    .fmt    (FP32),
    .X      (32'(i_operand)),
    .Y      (32'b0),
    .R      (o_result)
  );

endmodule
