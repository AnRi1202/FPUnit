
`timescale 1ns/1ps
import fpall_pkg::*;

module addmul_only_ret #(
    parameter int PARAM_PIPE = 1
)(
    input logic clk,
    input fp_op_e opcode,
    input fp_fmt_e fmt,
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

    logic [31:0] R_inner;
    addmul_only inner (
        .clk(clk),
        .opcode(opcode),
        .fmt(fmt),
        .X(X),
        .Y(Y),
        .R(R_inner)
    );

    // Pipeline stages for retiming
    generate
        if (PARAM_PIPE == 0) begin : gen_no_pipe
            assign R = R_inner;
        end else begin : gen_pipe
            logic [31:0] R_pipe [0:PARAM_PIPE-1];
            always_ff @(posedge clk) begin
                R_pipe[0] <= R_inner;
                for (int i = 1; i < PARAM_PIPE; i++) begin
                    R_pipe[i] <= R_pipe[i-1];
                end
            end
            assign R = R_pipe[PARAM_PIPE-1];
        end
    endgenerate

endmodule
