import FPALL_pkg::*;

module abs_comparator (
    input  fp_fmt_e     fmt,
    input  fp_vec_u x,
    input  fp_vec_u y,
    output logic [1:0]  swaps// FP16x2: lanes-wise |X| < |Y|. [1] is also |X|<|Y| for FP32.
);


    // -----------------------
    // segmented subtraction: a - b (unsigned)
    // a - b = a + ~b + 1
    // A<B  <=> carry_out == 0  <=> ~carry_out
    // -----------------------

    logic [15:0] x_lo, x_hi;
    logic [15:0] y_lo, y_hi;

    always_comb begin
        x_lo = x.lanes.lo;
        x_hi = x.lanes.hi;
        y_lo = y.lanes.lo;
        y_hi = y.lanes.hi;

        // Mask sign bits for absolute comparison
        x_hi[15] = 1'b0; 
        y_hi[15] = 1'b0;
        
        if (fmt == FP16) begin
            x_lo[15] = 1'b0;
            y_lo[15] = 1'b0;
        end
    end

    logic [16:0] sub_lo;
    logic        c16;

    assign sub_lo = {1'b0, x_lo} + {1'b0, ~y_lo} + 17'd1;
    assign c16    = sub_lo[16];

    logic cin_hi;
    assign cin_hi = (fmt == FP16) ? 1'b1 : c16; // Key shared logic: carry propagation control

    logic [16:0] sub_hi;
    logic        c32;

    assign sub_hi = {1'b0, x_hi} + {1'b0, ~y_hi} + {16'd0, cin_hi};
    assign c32    = sub_hi[16];

    // borrow = ~carry_out
    assign swaps[0] = ~c16; // lanes0: a_lo < b_lo
    assign swaps[1] = ~c32; // lanes1 (FP16) or entire 32-bit (FP32)
endmodule



module abs_comparator_origin(
    input  fp_fmt_e     fmt,
    input  logic [31:0] X,
    input  logic [31:0] Y,
    output logic [1:0]  swaps           // FP16x2: lanes-wise |X| < |Y| -> swap needed. [1] is also |X|<|Y| for FP32.
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


module abs_comparator_only(
    input  fp_fmt_e     fmt,
    input  logic [31:0] X,
    input  logic [31:0] Y,
    output logic [1:0]  swaps           // FP16x2: lanes-wise |X| < |Y| -> swap needed. [1] is also |X|<|Y| for FP32.
);


    always_comb begin 
     begin
           swaps[1] = (X[30:0] < Y[30:0])? 1'b1: 1'b0;
           swaps[0] = 1'b0;
        end
    end
endmodule