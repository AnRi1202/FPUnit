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

`ifdef V1_1_FP32_ADD
  fp32_add u_dut (
    .clk    (i_clk),
    .fmt    (FP32),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_sum)
  );
`elsif V1_3_ADDMUL_ONLY
  addmul_only u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_ADD)),
    .fmt    (1'(FP32)),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_sum)
  );
`elsif V1_AREA_OPT
  area_opt u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_ADD)),
    .fmt    (1'(FP32)),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_sum)
  );
`else
  // V2_BF16_FULL, V2_1_BF16_ADD, V2_2_BF16_MULT, etc.
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP32),
    .X      (32'(i_operand_a)),
    .Y      (32'(i_operand_b)),
    .R      (o_sum)
  );
`endif

endmodule


module fp32_mult_wrapper (
  input   logic           i_clk,
  input   logic           i_rst_n,
  input   fp_pkg::fp32_t  i_a,
  input   fp_pkg::fp32_t  i_b,
  output  fp_pkg::fp32_t  o_prod
);

`ifdef V1_2_FP32_MULT
  fp32_mult u_dut (
    .clk    (i_clk),
    .fmt    (FP32),
    .X      (32'(i_a)),
    .Y      (32'(i_b)),
    .R      (o_prod)
  );
`elsif V1_3_ADDMUL_ONLY
  addmul_only u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_MUL)),
    .fmt    (1'(FP32)),
    .X      (32'(i_a)),
    .Y      (32'(i_b)),
    .R      (o_prod)
  );
`elsif V1_AREA_OPT
  area_opt u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_MUL)),
    .fmt    (1'(FP32)),
    .X      (32'(i_a)),
    .Y      (32'(i_b)),
    .R      (o_prod)
  );
`else
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP32),
    .X      (32'(i_a)),
    .Y      (32'(i_b)),
    .R      (o_prod)
  );
`endif

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

`ifdef V1_AREA_OPT
  area_opt u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_ADD)),
    .fmt    (1'(FP16)),
    .X      ({16'b0, i_operand_a}),
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
`else
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP16),
    .X      ({16'b0, i_operand_a}),
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
`endif

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

`ifdef V1_AREA_OPT
  area_opt u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_MUL)),
    .fmt    (1'(FP16)),
    .X      ({16'b0, i_a}),
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
`else
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP16),
    .X      ({16'b0, i_a}),
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
`endif

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

`ifdef V2_1_BF16_ADD
  bf16_add u_dut (
    .clk    (i_clk),
    .fmt    (FP16),
    .X      ({16'b0, i_operand_a}),
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
`elsif V1_AREA_OPT
  area_opt u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_ADD)),
    .fmt    (1'(FP16)),
    .X      ({16'b0, i_operand_a}),
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
`else
  // V2_BF16_FULL, V2_2_BF16_MULT, etc.
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_ADD),
    .fmt    (FP16),
    .X      ({16'b0, i_operand_a}),
    .Y      ({16'b0, i_operand_b}),
    .R      (tmp_R)
  );
`endif

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

`ifdef V2_2_BF16_MULT
  bf16_mult u_dut (
    .clk    (i_clk),
    .fmt    (FP16),
    .X      ({16'b0, i_a}),
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
`elsif V1_AREA_OPT
  area_opt u_dut (
    .clk    (i_clk),
    .opcode (2'(OP_MUL)),
    .fmt    (1'(FP16)),
    .X      ({16'b0, i_a}),
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
`else
  // V2_BF16_FULL, V2_1_BF16_ADD, etc.
  fpall_shared u_dut (
    .clk    (i_clk),
    .opcode (OP_MUL),
    .fmt    (FP16),
    .X      ({16'b0, i_a}),
    .Y      ({16'b0, i_b}),
    .R      (tmp_R)
  );
`endif

  assign o_prod = tmp_R[15:0];

endmodule
