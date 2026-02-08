`timescale 1ns/1ps
import fpall_pkg::*;
import fp_pkg::*;

// ============================================================================
// FP32 Wrappers
// ============================================================================

module fp32_add_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
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


module fp32_mult_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   fp_pkg::fp32_t  i_a,
  input   fp_pkg::fp32_t  i_b,
  output  fp_pkg::fp32_t  o_prod
);

  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP32),
    .X      (32'(i_a)),
    .Y      (32'(i_b)),
    .R      (o_prod)
  );

endmodule


// ============================================================================
// FP16 Wrappers (Half Precision)
// ============================================================================

module fp16_add_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   fp_pkg::fp16_t  i_operand_a,
  input   fp_pkg::fp16_t  i_operand_b,
  output  fp_pkg::fp16_t  o_sum
);

  logic [31:0] tmp_R;
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP16),
    .X      ({16'b0, i_operand_a}), // Low lane
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
  assign o_sum = tmp_R[15:0];

endmodule


module fp16_mult_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   fp_pkg::fp16_t  i_a,
  input   fp_pkg::fp16_t  i_b,
  output  fp_pkg::fp16_t  o_prod
);

  logic [31:0] tmp_R;
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP16),
    .X      ({16'b0, i_a}), // Low lane
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
  assign o_prod = tmp_R[15:0];

endmodule


// ============================================================================
// BFloat16 Wrappers
// ============================================================================

module bf16_add_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   fp_pkg::bf16_t  i_operand_a,
  input   fp_pkg::bf16_t  i_operand_b,
  output  fp_pkg::bf16_t  o_sum
);

  logic [31:0] tmp_R;
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP16),
    .X      ({16'b0, i_operand_a}), // Low lane
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
  assign o_sum = tmp_R[15:0];

endmodule


module bf16_mult_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   fp_pkg::bf16_t  i_a,
  input   fp_pkg::bf16_t  i_b,
  output  fp_pkg::bf16_t  o_prod
);

  logic [31:0] tmp_R;
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP16),
    .X      ({16'b0, i_a}), // Low lane
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
  assign o_prod = tmp_R[15:0];

endmodule
