`timescale 1ns/1ps

// Wrapper: area_opt + pipeline for retiming. Logic is in area_opt.sv (single source).
module area_opt_ret #(
    parameter int PARAM_PIPE_AM = 1, // Pipeline stages for Add/Mul
    parameter int PARAM_PIPE_DS = 1  // Pipeline stages for Div/Sqrt
)(
    input logic clk,
    input logic [1:0] opcode, //00: Add, 01: Mul, 10: Sqrt, 11: Div
    input logic fmt,
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

    logic [31:0] R_inner;

    area_opt u_inner (
        .clk(clk),
        .opcode(opcode),
        .fmt(fmt),
        .X(X),
        .Y(Y),
        .R(R_inner)
    );

    // Pipeline: depth = max(AM, DS) for retiming flexibility
    localparam int PIPE_DEPTH = (PARAM_PIPE_AM >= PARAM_PIPE_DS) ? PARAM_PIPE_AM : PARAM_PIPE_DS;

    generate
        if (PIPE_DEPTH == 0) begin : gen_no_pipe
            assign R = R_inner;
        end else begin : gen_pipe
            logic [31:0] R_pipe [0:PIPE_DEPTH-1];
            always_ff @(posedge clk) begin
                R_pipe[0] <= R_inner;
                for (int i = 1; i < PIPE_DEPTH; i++) begin
                    R_pipe[i] <= R_pipe[i-1];
                end
            end
            assign R = R_pipe[PIPE_DEPTH-1];
        end
    endgenerate

endmodule
