
package fpall_pkg;

    typedef enum logic {
        FP32 = 1'b0,
        FP16 = 1'b1
    } fp_fmt_e;

    typedef enum logic [1:0] {
        OP_ADD  = 2'b00,
        OP_MUL  = 2'b01,
        OP_SQRT = 2'b10,
        OP_DIV  = 2'b11
    } fp_op_e;


    typedef union packed {
    logic [15:0] raw;
    struct packed {
        logic       sign;
        logic [7:0] exp;
        logic [6:0] frac;
    } bf16;
    } bf16_u;

    typedef union packed {
        logic [31:0]  raw;
        struct packed {
            logic [15:0] hi; // Upper 16 bits 
            logic [15:0] lo; // Lower 16 bits
        } lanes;

          struct packed {
            logic       sign;
            logic [7:0] exp;
            logic [22:0] frac;
        } fp32;
    } fp_vec_u;

endpackage
