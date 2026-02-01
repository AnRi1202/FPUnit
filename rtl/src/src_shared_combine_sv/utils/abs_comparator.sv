import FPALL_pkg::*;

module abs_comparator (
    input  fp_fmt_e     fmt,
    input  logic [31:0] X,
    input  logic [31:0] Y,
    output logic [1:0]  swaps            // FP16x2: lane-wise |X| < |Y| -> swap needed. [1] is also |X|<|Y| for FP32.
);
    fp_vec_u x, y;
    assign x.u32 = X;
    assign y.u32 = Y;

    // Pack "magnitude to compare" into a, b
    // FP32: {0, X[30:0]} vs {0, Y[30:0]}
    // FP16: Pack {0, lane[14:0]} into upper/lower 16 bits for each lane
    fp_vec_u a, b;

    always_comb begin
        if (fmt == FP32) begin
            a.u32 = {1'b0, X[30:0]};
            b.u32 = {1'b0, Y[30:0]};
        end else begin
            a.u16[0] = {1'b0, x.u16[0][14:0]}; // lane0 magnitude
            b.u16[0] = {1'b0, y.u16[0][14:0]};
            a.u16[1] = {1'b0, x.u16[1][14:0]}; // lane1 magnitude
            b.u16[1] = {1'b0, y.u16[1][14:0]};
        end
    end

    // -----------------------
    // segmented subtraction: a - b (unsigned)
    // a - b = a + ~b + 1
    // A<B  <=> carry_out == 0  <=> ~carry_out
    // -----------------------
    logic [16:0] sub_lo;
    logic        c16;

    assign sub_lo = {1'b0, a.u16[0]} + {1'b0, ~b.u16[0]} + 17'd1;
    assign c16    = sub_lo[16];

    logic cin_hi;
    assign cin_hi = (fmt == FP16) ? 1'b1 : c16; // Key shared logic: carry propagation control

    logic [16:0] sub_hi;
    logic        c32;

    assign sub_hi = {1'b0, a.u16[1]} + {1'b0, ~b.u16[1]} + {16'd0, cin_hi};
    assign c32    = sub_hi[16];

    // borrow = ~carry_out
    assign swaps[0] = ~c16; // lane0: a_lo < b_lo
    assign swaps[1] = ~c32; // lane1 (FP16) or entire 32-bit (FP32)
endmodule

module abs_comparator_origin(
    input  fp_fmt_e     fmt,
    input  logic [31:0] X,
    input  logic [31:0] Y,
    output logic [1:0]  swaps           // FP16x2: lane-wise |X| < |Y| -> swap needed. [1] is also |X|<|Y| for FP32.
);


    always_comb begin 
        if (fmt == FP32) begin
           swaps[1] = (X[30:0] < Y[30:0])? 1'b1: 1'b0;
           swaps[0] = 1'b0;
        end else begin
           swaps[1] = (X[30:16] < Y[30:16])? 1'b1:1'b0; 
           swaps[0] = (X[14:0] < Y[14:0])? 1'b1:1'b0; 
        end
    end
endmodule