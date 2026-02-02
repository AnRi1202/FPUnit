import FPALL_pkg::*;

// Wrapper to keep a generic comparator module name.
module comparator (
    input  fp_fmt_e     fmt,
    input  fp_vec_u     x,
    input  fp_vec_u     y,
    output logic        swap_l,
    output logic        swap_h
);
    abs_comparator u_abs_cmp (
        .fmt(fmt),
        .x(x),
        .y(y),
        .swap_l(swap_l),
        .swap_h(swap_h)
    );
endmodule
