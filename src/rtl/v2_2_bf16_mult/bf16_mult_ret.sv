`timescale 1ns/1ps
import fpall_pkg::*;

module bf16_mult_ret #(
    parameter int PARAM_PIPE = 1
)(
    input logic clk,
    input fp_op_e opcode,
    input fp_fmt_e fmt, 
    input logic [31:0] X,
    input logic [31:0] Y,
    output logic [31:0] R
);

    // Split pipeline stages: Half at input, half at output
    // This allows retiming to push registers from both sides into the logic.
    localparam int PIPE_IN  = PARAM_PIPE / 2;
    localparam int PIPE_OUT = PARAM_PIPE - PIPE_IN; // Remainder to output

    // Internal signals for Input Pipeline
    logic [31:0] X_in;
    logic [31:0] Y_in;
    fp_fmt_e     fmt_in;
    fp_op_e      opcode_in;
    
    // Internal signal for core output
    logic [31:0] R_core;

    // -----------------------------------------------------------
    // Input Pipeline (Move Forward)
    // -----------------------------------------------------------
    generate
        if (PIPE_IN == 0) begin : gen_no_pipe_in
            assign X_in   = X;
            assign Y_in   = Y;
            assign fmt_in = fmt;
            assign opcode_in = opcode;
        end else begin : gen_pipe_in
            logic [31:0] X_r   [0:PIPE_IN-1];
            logic [31:0] Y_r   [0:PIPE_IN-1];
            fp_fmt_e     fmt_r [0:PIPE_IN-1];
            fp_op_e      opcode_r [0:PIPE_IN-1];

            always_ff @(posedge clk) begin
                X_r[0]      <= X;
                Y_r[0]      <= Y;
                fmt_r[0]    <= fmt;
                opcode_r[0] <= opcode;
                for (int i = 1; i < PIPE_IN; i++) begin
                    X_r[i]      <= X_r[i-1];
                    Y_r[i]      <= Y_r[i-1];
                    fmt_r[i]    <= fmt_r[i-1];
                    opcode_r[i] <= opcode_r[i-1];
                end
            end

            assign X_in      = X_r[PIPE_IN-1];
            assign Y_in      = Y_r[PIPE_IN-1];
            assign fmt_in    = fmt_r[PIPE_IN-1];
            assign opcode_in = opcode_r[PIPE_IN-1];
        end
    endgenerate

    // -----------------------------------------------------------
    // Core Logic
    // -----------------------------------------------------------
    bf16_mult u_bf16_mult (
        .clk(clk),
        .opcode(opcode_in),
        .fmt(fmt_in),
        .X(X_in),
        .Y(Y_in),
        .R(R_core)
    );

    // -----------------------------------------------------------
    // Output Pipeline (Move Backward)
    // -----------------------------------------------------------
    generate
        if (PIPE_OUT == 0) begin : gen_no_pipe_out
            assign R = R_core;
        end else begin : gen_pipe_out
            logic [31:0] R_r [0:PIPE_OUT-1]; // Registers. Note: This assumes output is just "R".

            always_ff @(posedge clk) begin
                R_r[0] <= R_core;
                for (int i = 1; i < PIPE_OUT; i++) begin
                    R_r[i] <= R_r[i-1];
                end
            end
            assign R = R_r[PIPE_OUT-1];
        end
    endgenerate

endmodule
