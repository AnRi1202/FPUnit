
package FPALL_pkg;

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
        logic [31:0]        u32;
        logic [1:0][15:0]   u16; // u16[0]=lower16, u16[1]=upper16
    } fp_vec_u;

endpackage
