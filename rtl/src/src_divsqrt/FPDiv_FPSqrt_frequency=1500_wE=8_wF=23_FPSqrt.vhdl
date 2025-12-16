--------------------------------------------------------------------------------
--                                FPSqrt_8_23
-- VHDL generated for DummyFPGA @ 1500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 60 cycles
-- Clock period (ns): 0.666667
-- Target frequency (MHz): 1500
-- Input signals: X
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: R: (c60, 0.290000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPSqrt_8_23 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPSqrt_8_23 is
signal fracX :  std_logic_vector(22 downto 0);
   -- timing of fracX: (c0, 0.000000ns)
signal eRn0 :  std_logic_vector(7 downto 0);
   -- timing of eRn0: (c0, 0.000000ns)
signal xsX :  std_logic_vector(2 downto 0);
   -- timing of xsX: (c0, 0.000000ns)
signal eRn1, eRn1_d1, eRn1_d2, eRn1_d3, eRn1_d4, eRn1_d5, eRn1_d6, eRn1_d7, eRn1_d8, eRn1_d9, eRn1_d10, eRn1_d11, eRn1_d12, eRn1_d13, eRn1_d14, eRn1_d15, eRn1_d16, eRn1_d17, eRn1_d18, eRn1_d19, eRn1_d20, eRn1_d21, eRn1_d22, eRn1_d23, eRn1_d24, eRn1_d25, eRn1_d26, eRn1_d27, eRn1_d28, eRn1_d29, eRn1_d30, eRn1_d31, eRn1_d32, eRn1_d33, eRn1_d34, eRn1_d35, eRn1_d36, eRn1_d37, eRn1_d38, eRn1_d39, eRn1_d40, eRn1_d41, eRn1_d42, eRn1_d43, eRn1_d44, eRn1_d45, eRn1_d46, eRn1_d47, eRn1_d48, eRn1_d49, eRn1_d50, eRn1_d51, eRn1_d52, eRn1_d53, eRn1_d54, eRn1_d55, eRn1_d56, eRn1_d57, eRn1_d58, eRn1_d59, eRn1_d60 :  std_logic_vector(7 downto 0);
   -- timing of eRn1: (c0, 0.000000ns)
signal fracXnorm, fracXnorm_d1, fracXnorm_d2 :  std_logic_vector(26 downto 0);
   -- timing of fracXnorm: (c0, 0.050000ns)
signal S0, S0_d1, S0_d2 :  std_logic_vector(1 downto 0);
   -- timing of S0: (c0, 0.000000ns)
signal T1 :  std_logic_vector(26 downto 0);
   -- timing of T1: (c2, 0.146667ns)
signal d1, d1_d1, d1_d2 :  std_logic;
   -- timing of d1: (c2, 0.146667ns)
signal T1s :  std_logic_vector(27 downto 0);
   -- timing of T1s: (c2, 0.146667ns)
signal T1s_h, T1s_h_d1, T1s_h_d2 :  std_logic_vector(5 downto 0);
   -- timing of T1s_h: (c2, 0.146667ns)
signal T1s_l, T1s_l_d1, T1s_l_d2 :  std_logic_vector(21 downto 0);
   -- timing of T1s_l: (c2, 0.146667ns)
signal U1, U1_d1, U1_d2 :  std_logic_vector(5 downto 0);
   -- timing of U1: (c2, 0.146667ns)
signal T3_h :  std_logic_vector(5 downto 0);
   -- timing of T3_h: (c4, 0.233333ns)
signal T2 :  std_logic_vector(26 downto 0);
   -- timing of T2: (c4, 0.233333ns)
signal S1, S1_d1, S1_d2 :  std_logic_vector(2 downto 0);
   -- timing of S1: (c2, 0.146667ns)
signal d2, d2_d1, d2_d2 :  std_logic;
   -- timing of d2: (c4, 0.233333ns)
signal T2s :  std_logic_vector(27 downto 0);
   -- timing of T2s: (c4, 0.233333ns)
signal T2s_h, T2s_h_d1, T2s_h_d2 :  std_logic_vector(6 downto 0);
   -- timing of T2s_h: (c4, 0.233333ns)
signal T2s_l, T2s_l_d1, T2s_l_d2 :  std_logic_vector(20 downto 0);
   -- timing of T2s_l: (c4, 0.233333ns)
signal U2, U2_d1, U2_d2 :  std_logic_vector(6 downto 0);
   -- timing of U2: (c4, 0.233333ns)
signal T4_h :  std_logic_vector(6 downto 0);
   -- timing of T4_h: (c6, 0.330000ns)
signal T3 :  std_logic_vector(26 downto 0);
   -- timing of T3: (c6, 0.330000ns)
signal S2, S2_d1, S2_d2 :  std_logic_vector(3 downto 0);
   -- timing of S2: (c4, 0.233333ns)
signal d3, d3_d1, d3_d2 :  std_logic;
   -- timing of d3: (c6, 0.330000ns)
signal T3s :  std_logic_vector(27 downto 0);
   -- timing of T3s: (c6, 0.330000ns)
signal T3s_h, T3s_h_d1, T3s_h_d2 :  std_logic_vector(7 downto 0);
   -- timing of T3s_h: (c6, 0.330000ns)
signal T3s_l, T3s_l_d1, T3s_l_d2 :  std_logic_vector(19 downto 0);
   -- timing of T3s_l: (c6, 0.330000ns)
signal U3, U3_d1, U3_d2 :  std_logic_vector(7 downto 0);
   -- timing of U3: (c6, 0.330000ns)
signal T5_h :  std_logic_vector(7 downto 0);
   -- timing of T5_h: (c8, 0.436667ns)
signal T4 :  std_logic_vector(26 downto 0);
   -- timing of T4: (c8, 0.436667ns)
signal S3, S3_d1, S3_d2 :  std_logic_vector(4 downto 0);
   -- timing of S3: (c6, 0.330000ns)
signal d4, d4_d1, d4_d2, d4_d3 :  std_logic;
   -- timing of d4: (c8, 0.436667ns)
signal T4s :  std_logic_vector(27 downto 0);
   -- timing of T4s: (c8, 0.436667ns)
signal T4s_h, T4s_h_d1, T4s_h_d2, T4s_h_d3 :  std_logic_vector(8 downto 0);
   -- timing of T4s_h: (c8, 0.436667ns)
signal T4s_l, T4s_l_d1, T4s_l_d2, T4s_l_d3 :  std_logic_vector(18 downto 0);
   -- timing of T4s_l: (c8, 0.436667ns)
signal U4, U4_d1, U4_d2, U4_d3 :  std_logic_vector(8 downto 0);
   -- timing of U4: (c8, 0.436667ns)
signal T6_h :  std_logic_vector(8 downto 0);
   -- timing of T6_h: (c11, 0.086667ns)
signal T5 :  std_logic_vector(26 downto 0);
   -- timing of T5: (c11, 0.086667ns)
signal S4, S4_d1, S4_d2, S4_d3 :  std_logic_vector(5 downto 0);
   -- timing of S4: (c8, 0.436667ns)
signal d5, d5_d1, d5_d2 :  std_logic;
   -- timing of d5: (c11, 0.086667ns)
signal T5s :  std_logic_vector(27 downto 0);
   -- timing of T5s: (c11, 0.086667ns)
signal T5s_h, T5s_h_d1, T5s_h_d2 :  std_logic_vector(9 downto 0);
   -- timing of T5s_h: (c11, 0.086667ns)
signal T5s_l, T5s_l_d1, T5s_l_d2 :  std_logic_vector(17 downto 0);
   -- timing of T5s_l: (c11, 0.086667ns)
signal U5, U5_d1, U5_d2 :  std_logic_vector(9 downto 0);
   -- timing of U5: (c11, 0.086667ns)
signal T7_h :  std_logic_vector(9 downto 0);
   -- timing of T7_h: (c13, 0.213333ns)
signal T6 :  std_logic_vector(26 downto 0);
   -- timing of T6: (c13, 0.213333ns)
signal S5, S5_d1, S5_d2 :  std_logic_vector(6 downto 0);
   -- timing of S5: (c11, 0.086667ns)
signal d6, d6_d1, d6_d2 :  std_logic;
   -- timing of d6: (c13, 0.213333ns)
signal T6s :  std_logic_vector(27 downto 0);
   -- timing of T6s: (c13, 0.213333ns)
signal T6s_h, T6s_h_d1, T6s_h_d2 :  std_logic_vector(10 downto 0);
   -- timing of T6s_h: (c13, 0.213333ns)
signal T6s_l, T6s_l_d1, T6s_l_d2 :  std_logic_vector(16 downto 0);
   -- timing of T6s_l: (c13, 0.213333ns)
signal U6, U6_d1, U6_d2 :  std_logic_vector(10 downto 0);
   -- timing of U6: (c13, 0.213333ns)
signal T8_h :  std_logic_vector(10 downto 0);
   -- timing of T8_h: (c15, 0.350000ns)
signal T7 :  std_logic_vector(26 downto 0);
   -- timing of T7: (c15, 0.350000ns)
signal S6, S6_d1, S6_d2 :  std_logic_vector(7 downto 0);
   -- timing of S6: (c13, 0.213333ns)
signal d7, d7_d1, d7_d2, d7_d3 :  std_logic;
   -- timing of d7: (c15, 0.350000ns)
signal T7s :  std_logic_vector(27 downto 0);
   -- timing of T7s: (c15, 0.350000ns)
signal T7s_h, T7s_h_d1, T7s_h_d2, T7s_h_d3 :  std_logic_vector(11 downto 0);
   -- timing of T7s_h: (c15, 0.350000ns)
signal T7s_l, T7s_l_d1, T7s_l_d2, T7s_l_d3 :  std_logic_vector(15 downto 0);
   -- timing of T7s_l: (c15, 0.350000ns)
signal U7, U7_d1, U7_d2, U7_d3 :  std_logic_vector(11 downto 0);
   -- timing of U7: (c15, 0.350000ns)
signal T9_h :  std_logic_vector(11 downto 0);
   -- timing of T9_h: (c18, 0.030000ns)
signal T8 :  std_logic_vector(26 downto 0);
   -- timing of T8: (c18, 0.030000ns)
signal S7, S7_d1, S7_d2, S7_d3 :  std_logic_vector(8 downto 0);
   -- timing of S7: (c15, 0.350000ns)
signal d8, d8_d1, d8_d2 :  std_logic;
   -- timing of d8: (c18, 0.030000ns)
signal T8s :  std_logic_vector(27 downto 0);
   -- timing of T8s: (c18, 0.030000ns)
signal T8s_h, T8s_h_d1, T8s_h_d2 :  std_logic_vector(12 downto 0);
   -- timing of T8s_h: (c18, 0.030000ns)
signal T8s_l, T8s_l_d1, T8s_l_d2 :  std_logic_vector(14 downto 0);
   -- timing of T8s_l: (c18, 0.030000ns)
signal U8, U8_d1, U8_d2 :  std_logic_vector(12 downto 0);
   -- timing of U8: (c18, 0.030000ns)
signal T10_h :  std_logic_vector(12 downto 0);
   -- timing of T10_h: (c20, 0.186667ns)
signal T9 :  std_logic_vector(26 downto 0);
   -- timing of T9: (c20, 0.186667ns)
signal S8, S8_d1, S8_d2 :  std_logic_vector(9 downto 0);
   -- timing of S8: (c18, 0.030000ns)
signal d9, d9_d1, d9_d2 :  std_logic;
   -- timing of d9: (c20, 0.186667ns)
signal T9s :  std_logic_vector(27 downto 0);
   -- timing of T9s: (c20, 0.186667ns)
signal T9s_h, T9s_h_d1, T9s_h_d2 :  std_logic_vector(13 downto 0);
   -- timing of T9s_h: (c20, 0.186667ns)
signal T9s_l, T9s_l_d1, T9s_l_d2 :  std_logic_vector(13 downto 0);
   -- timing of T9s_l: (c20, 0.186667ns)
signal U9, U9_d1, U9_d2 :  std_logic_vector(13 downto 0);
   -- timing of U9: (c20, 0.186667ns)
signal T11_h :  std_logic_vector(13 downto 0);
   -- timing of T11_h: (c22, 0.353333ns)
signal T10 :  std_logic_vector(26 downto 0);
   -- timing of T10: (c22, 0.353333ns)
signal S9, S9_d1, S9_d2 :  std_logic_vector(10 downto 0);
   -- timing of S9: (c20, 0.186667ns)
signal d10, d10_d1, d10_d2, d10_d3 :  std_logic;
   -- timing of d10: (c22, 0.353333ns)
signal T10s :  std_logic_vector(27 downto 0);
   -- timing of T10s: (c22, 0.353333ns)
signal T10s_h, T10s_h_d1, T10s_h_d2, T10s_h_d3 :  std_logic_vector(14 downto 0);
   -- timing of T10s_h: (c22, 0.353333ns)
signal T10s_l, T10s_l_d1, T10s_l_d2, T10s_l_d3 :  std_logic_vector(12 downto 0);
   -- timing of T10s_l: (c22, 0.353333ns)
signal U10, U10_d1, U10_d2, U10_d3 :  std_logic_vector(14 downto 0);
   -- timing of U10: (c22, 0.353333ns)
signal T12_h :  std_logic_vector(14 downto 0);
   -- timing of T12_h: (c25, 0.063333ns)
signal T11 :  std_logic_vector(26 downto 0);
   -- timing of T11: (c25, 0.063333ns)
signal S10, S10_d1, S10_d2, S10_d3 :  std_logic_vector(11 downto 0);
   -- timing of S10: (c22, 0.353333ns)
signal d11, d11_d1, d11_d2 :  std_logic;
   -- timing of d11: (c25, 0.063333ns)
signal T11s :  std_logic_vector(27 downto 0);
   -- timing of T11s: (c25, 0.063333ns)
signal T11s_h, T11s_h_d1, T11s_h_d2 :  std_logic_vector(15 downto 0);
   -- timing of T11s_h: (c25, 0.063333ns)
signal T11s_l, T11s_l_d1, T11s_l_d2 :  std_logic_vector(11 downto 0);
   -- timing of T11s_l: (c25, 0.063333ns)
signal U11, U11_d1, U11_d2 :  std_logic_vector(15 downto 0);
   -- timing of U11: (c25, 0.063333ns)
signal T13_h :  std_logic_vector(15 downto 0);
   -- timing of T13_h: (c27, 0.250000ns)
signal T12 :  std_logic_vector(26 downto 0);
   -- timing of T12: (c27, 0.250000ns)
signal S11, S11_d1, S11_d2 :  std_logic_vector(12 downto 0);
   -- timing of S11: (c25, 0.063333ns)
signal d12, d12_d1, d12_d2 :  std_logic;
   -- timing of d12: (c27, 0.250000ns)
signal T12s :  std_logic_vector(27 downto 0);
   -- timing of T12s: (c27, 0.250000ns)
signal T12s_h, T12s_h_d1, T12s_h_d2 :  std_logic_vector(16 downto 0);
   -- timing of T12s_h: (c27, 0.250000ns)
signal T12s_l, T12s_l_d1, T12s_l_d2 :  std_logic_vector(10 downto 0);
   -- timing of T12s_l: (c27, 0.250000ns)
signal U12, U12_d1, U12_d2 :  std_logic_vector(16 downto 0);
   -- timing of U12: (c27, 0.250000ns)
signal T14_h :  std_logic_vector(16 downto 0);
   -- timing of T14_h: (c29, 0.446667ns)
signal T13 :  std_logic_vector(26 downto 0);
   -- timing of T13: (c29, 0.446667ns)
signal S12, S12_d1, S12_d2 :  std_logic_vector(13 downto 0);
   -- timing of S12: (c27, 0.250000ns)
signal d13, d13_d1, d13_d2, d13_d3 :  std_logic;
   -- timing of d13: (c29, 0.446667ns)
signal T13s :  std_logic_vector(27 downto 0);
   -- timing of T13s: (c29, 0.446667ns)
signal T13s_h, T13s_h_d1, T13s_h_d2, T13s_h_d3 :  std_logic_vector(17 downto 0);
   -- timing of T13s_h: (c29, 0.446667ns)
signal T13s_l, T13s_l_d1, T13s_l_d2, T13s_l_d3 :  std_logic_vector(9 downto 0);
   -- timing of T13s_l: (c29, 0.446667ns)
signal U13, U13_d1, U13_d2, U13_d3 :  std_logic_vector(17 downto 0);
   -- timing of U13: (c29, 0.446667ns)
signal T15_h :  std_logic_vector(17 downto 0);
   -- timing of T15_h: (c32, 0.186667ns)
signal T14 :  std_logic_vector(26 downto 0);
   -- timing of T14: (c32, 0.186667ns)
signal S13, S13_d1, S13_d2, S13_d3 :  std_logic_vector(14 downto 0);
   -- timing of S13: (c29, 0.446667ns)
signal d14, d14_d1, d14_d2 :  std_logic;
   -- timing of d14: (c32, 0.186667ns)
signal T14s :  std_logic_vector(27 downto 0);
   -- timing of T14s: (c32, 0.186667ns)
signal T14s_h, T14s_h_d1, T14s_h_d2 :  std_logic_vector(18 downto 0);
   -- timing of T14s_h: (c32, 0.186667ns)
signal T14s_l, T14s_l_d1, T14s_l_d2 :  std_logic_vector(8 downto 0);
   -- timing of T14s_l: (c32, 0.186667ns)
signal U14, U14_d1, U14_d2 :  std_logic_vector(18 downto 0);
   -- timing of U14: (c32, 0.186667ns)
signal T16_h :  std_logic_vector(18 downto 0);
   -- timing of T16_h: (c34, 0.403333ns)
signal T15 :  std_logic_vector(26 downto 0);
   -- timing of T15: (c34, 0.403333ns)
signal S14, S14_d1, S14_d2 :  std_logic_vector(15 downto 0);
   -- timing of S14: (c32, 0.186667ns)
signal d15, d15_d1, d15_d2, d15_d3 :  std_logic;
   -- timing of d15: (c34, 0.403333ns)
signal T15s :  std_logic_vector(27 downto 0);
   -- timing of T15s: (c34, 0.403333ns)
signal T15s_h, T15s_h_d1, T15s_h_d2, T15s_h_d3 :  std_logic_vector(19 downto 0);
   -- timing of T15s_h: (c34, 0.403333ns)
signal T15s_l, T15s_l_d1, T15s_l_d2, T15s_l_d3 :  std_logic_vector(7 downto 0);
   -- timing of T15s_l: (c34, 0.403333ns)
signal U15, U15_d1, U15_d2, U15_d3 :  std_logic_vector(19 downto 0);
   -- timing of U15: (c34, 0.403333ns)
signal T17_h :  std_logic_vector(19 downto 0);
   -- timing of T17_h: (c37, 0.163333ns)
signal T16 :  std_logic_vector(26 downto 0);
   -- timing of T16: (c37, 0.163333ns)
signal S15, S15_d1, S15_d2, S15_d3 :  std_logic_vector(16 downto 0);
   -- timing of S15: (c34, 0.403333ns)
signal d16, d16_d1, d16_d2 :  std_logic;
   -- timing of d16: (c37, 0.163333ns)
signal T16s :  std_logic_vector(27 downto 0);
   -- timing of T16s: (c37, 0.163333ns)
signal T16s_h, T16s_h_d1, T16s_h_d2 :  std_logic_vector(20 downto 0);
   -- timing of T16s_h: (c37, 0.163333ns)
signal T16s_l, T16s_l_d1, T16s_l_d2 :  std_logic_vector(6 downto 0);
   -- timing of T16s_l: (c37, 0.163333ns)
signal U16, U16_d1, U16_d2 :  std_logic_vector(20 downto 0);
   -- timing of U16: (c37, 0.163333ns)
signal T18_h :  std_logic_vector(20 downto 0);
   -- timing of T18_h: (c39, 0.400000ns)
signal T17 :  std_logic_vector(26 downto 0);
   -- timing of T17: (c39, 0.400000ns)
signal S16, S16_d1, S16_d2 :  std_logic_vector(17 downto 0);
   -- timing of S16: (c37, 0.163333ns)
signal d17, d17_d1, d17_d2, d17_d3 :  std_logic;
   -- timing of d17: (c39, 0.400000ns)
signal T17s :  std_logic_vector(27 downto 0);
   -- timing of T17s: (c39, 0.400000ns)
signal T17s_h, T17s_h_d1, T17s_h_d2, T17s_h_d3 :  std_logic_vector(21 downto 0);
   -- timing of T17s_h: (c39, 0.400000ns)
signal T17s_l, T17s_l_d1, T17s_l_d2, T17s_l_d3 :  std_logic_vector(5 downto 0);
   -- timing of T17s_l: (c39, 0.400000ns)
signal U17, U17_d1, U17_d2, U17_d3 :  std_logic_vector(21 downto 0);
   -- timing of U17: (c39, 0.400000ns)
signal T19_h :  std_logic_vector(21 downto 0);
   -- timing of T19_h: (c42, 0.180000ns)
signal T18 :  std_logic_vector(26 downto 0);
   -- timing of T18: (c42, 0.180000ns)
signal S17, S17_d1, S17_d2, S17_d3 :  std_logic_vector(18 downto 0);
   -- timing of S17: (c39, 0.400000ns)
signal d18, d18_d1, d18_d2 :  std_logic;
   -- timing of d18: (c42, 0.180000ns)
signal T18s :  std_logic_vector(27 downto 0);
   -- timing of T18s: (c42, 0.180000ns)
signal T18s_h, T18s_h_d1, T18s_h_d2 :  std_logic_vector(22 downto 0);
   -- timing of T18s_h: (c42, 0.180000ns)
signal T18s_l, T18s_l_d1, T18s_l_d2 :  std_logic_vector(4 downto 0);
   -- timing of T18s_l: (c42, 0.180000ns)
signal U18, U18_d1, U18_d2 :  std_logic_vector(22 downto 0);
   -- timing of U18: (c42, 0.180000ns)
signal T20_h :  std_logic_vector(22 downto 0);
   -- timing of T20_h: (c44, 0.436667ns)
signal T19 :  std_logic_vector(26 downto 0);
   -- timing of T19: (c44, 0.436667ns)
signal S18, S18_d1, S18_d2 :  std_logic_vector(19 downto 0);
   -- timing of S18: (c42, 0.180000ns)
signal d19, d19_d1, d19_d2, d19_d3 :  std_logic;
   -- timing of d19: (c44, 0.436667ns)
signal T19s :  std_logic_vector(27 downto 0);
   -- timing of T19s: (c44, 0.436667ns)
signal T19s_h, T19s_h_d1, T19s_h_d2, T19s_h_d3 :  std_logic_vector(23 downto 0);
   -- timing of T19s_h: (c44, 0.436667ns)
signal T19s_l, T19s_l_d1, T19s_l_d2, T19s_l_d3 :  std_logic_vector(3 downto 0);
   -- timing of T19s_l: (c44, 0.436667ns)
signal U19, U19_d1, U19_d2, U19_d3 :  std_logic_vector(23 downto 0);
   -- timing of U19: (c44, 0.436667ns)
signal T21_h :  std_logic_vector(23 downto 0);
   -- timing of T21_h: (c47, 0.236667ns)
signal T20 :  std_logic_vector(26 downto 0);
   -- timing of T20: (c47, 0.236667ns)
signal S19, S19_d1, S19_d2, S19_d3 :  std_logic_vector(20 downto 0);
   -- timing of S19: (c44, 0.436667ns)
signal d20, d20_d1, d20_d2, d20_d3 :  std_logic;
   -- timing of d20: (c47, 0.236667ns)
signal T20s :  std_logic_vector(27 downto 0);
   -- timing of T20s: (c47, 0.236667ns)
signal T20s_h, T20s_h_d1, T20s_h_d2, T20s_h_d3 :  std_logic_vector(24 downto 0);
   -- timing of T20s_h: (c47, 0.236667ns)
signal T20s_l, T20s_l_d1, T20s_l_d2, T20s_l_d3 :  std_logic_vector(2 downto 0);
   -- timing of T20s_l: (c47, 0.236667ns)
signal U20, U20_d1, U20_d2, U20_d3 :  std_logic_vector(24 downto 0);
   -- timing of U20: (c47, 0.236667ns)
signal T22_h :  std_logic_vector(24 downto 0);
   -- timing of T22_h: (c50, 0.046667ns)
signal T21 :  std_logic_vector(26 downto 0);
   -- timing of T21: (c50, 0.046667ns)
signal S20, S20_d1, S20_d2, S20_d3 :  std_logic_vector(21 downto 0);
   -- timing of S20: (c47, 0.236667ns)
signal d21, d21_d1, d21_d2 :  std_logic;
   -- timing of d21: (c50, 0.046667ns)
signal T21s :  std_logic_vector(27 downto 0);
   -- timing of T21s: (c50, 0.046667ns)
signal T21s_h, T21s_h_d1, T21s_h_d2 :  std_logic_vector(25 downto 0);
   -- timing of T21s_h: (c50, 0.046667ns)
signal T21s_l, T21s_l_d1, T21s_l_d2 :  std_logic_vector(1 downto 0);
   -- timing of T21s_l: (c50, 0.046667ns)
signal U21, U21_d1, U21_d2 :  std_logic_vector(25 downto 0);
   -- timing of U21: (c50, 0.046667ns)
signal T23_h :  std_logic_vector(25 downto 0);
   -- timing of T23_h: (c52, 0.333333ns)
signal T22 :  std_logic_vector(26 downto 0);
   -- timing of T22: (c52, 0.333333ns)
signal S21, S21_d1, S21_d2 :  std_logic_vector(22 downto 0);
   -- timing of S21: (c50, 0.046667ns)
signal d22, d22_d1, d22_d2, d22_d3 :  std_logic;
   -- timing of d22: (c52, 0.333333ns)
signal T22s :  std_logic_vector(27 downto 0);
   -- timing of T22s: (c52, 0.333333ns)
signal T22s_h, T22s_h_d1, T22s_h_d2, T22s_h_d3 :  std_logic_vector(26 downto 0);
   -- timing of T22s_h: (c52, 0.333333ns)
signal T22s_l, T22s_l_d1, T22s_l_d2, T22s_l_d3 :  std_logic_vector(0 downto 0);
   -- timing of T22s_l: (c52, 0.333333ns)
signal U22, U22_d1, U22_d2, U22_d3 :  std_logic_vector(26 downto 0);
   -- timing of U22: (c52, 0.333333ns)
signal T24_h :  std_logic_vector(26 downto 0);
   -- timing of T24_h: (c55, 0.163333ns)
signal T23 :  std_logic_vector(26 downto 0);
   -- timing of T23: (c55, 0.163333ns)
signal S22, S22_d1, S22_d2, S22_d3 :  std_logic_vector(23 downto 0);
   -- timing of S22: (c52, 0.333333ns)
signal d23, d23_d1, d23_d2, d23_d3 :  std_logic;
   -- timing of d23: (c55, 0.163333ns)
signal T23s :  std_logic_vector(27 downto 0);
   -- timing of T23s: (c55, 0.163333ns)
signal T23s_h, T23s_h_d1, T23s_h_d2, T23s_h_d3 :  std_logic_vector(27 downto 0);
   -- timing of T23s_h: (c55, 0.163333ns)
signal U23, U23_d1, U23_d2, U23_d3 :  std_logic_vector(27 downto 0);
   -- timing of U23: (c55, 0.163333ns)
signal T25_h :  std_logic_vector(27 downto 0);
   -- timing of T25_h: (c58, 0.003333ns)
signal T24 :  std_logic_vector(26 downto 0);
   -- timing of T24: (c58, 0.003333ns)
signal S23, S23_d1, S23_d2, S23_d3 :  std_logic_vector(24 downto 0);
   -- timing of S23: (c55, 0.163333ns)
signal d25 :  std_logic;
   -- timing of d25: (c58, 0.003333ns)
signal mR :  std_logic_vector(25 downto 0);
   -- timing of mR: (c58, 0.003333ns)
signal fR, fR_d1, fR_d2 :  std_logic_vector(22 downto 0);
   -- timing of fR: (c58, 0.003333ns)
signal round, round_d1, round_d2 :  std_logic;
   -- timing of round: (c58, 0.003333ns)
signal fRrnd :  std_logic_vector(22 downto 0);
   -- timing of fRrnd: (c60, 0.290000ns)
signal Rn2 :  std_logic_vector(30 downto 0);
   -- timing of Rn2: (c60, 0.290000ns)
signal xsR, xsR_d1, xsR_d2, xsR_d3, xsR_d4, xsR_d5, xsR_d6, xsR_d7, xsR_d8, xsR_d9, xsR_d10, xsR_d11, xsR_d12, xsR_d13, xsR_d14, xsR_d15, xsR_d16, xsR_d17, xsR_d18, xsR_d19, xsR_d20, xsR_d21, xsR_d22, xsR_d23, xsR_d24, xsR_d25, xsR_d26, xsR_d27, xsR_d28, xsR_d29, xsR_d30, xsR_d31, xsR_d32, xsR_d33, xsR_d34, xsR_d35, xsR_d36, xsR_d37, xsR_d38, xsR_d39, xsR_d40, xsR_d41, xsR_d42, xsR_d43, xsR_d44, xsR_d45, xsR_d46, xsR_d47, xsR_d48, xsR_d49, xsR_d50, xsR_d51, xsR_d52, xsR_d53, xsR_d54, xsR_d55, xsR_d56, xsR_d57, xsR_d58, xsR_d59, xsR_d60 :  std_logic_vector(2 downto 0);
   -- timing of xsR: (c0, 0.050000ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            eRn1_d1 <=  eRn1;
            eRn1_d2 <=  eRn1_d1;
            eRn1_d3 <=  eRn1_d2;
            eRn1_d4 <=  eRn1_d3;
            eRn1_d5 <=  eRn1_d4;
            eRn1_d6 <=  eRn1_d5;
            eRn1_d7 <=  eRn1_d6;
            eRn1_d8 <=  eRn1_d7;
            eRn1_d9 <=  eRn1_d8;
            eRn1_d10 <=  eRn1_d9;
            eRn1_d11 <=  eRn1_d10;
            eRn1_d12 <=  eRn1_d11;
            eRn1_d13 <=  eRn1_d12;
            eRn1_d14 <=  eRn1_d13;
            eRn1_d15 <=  eRn1_d14;
            eRn1_d16 <=  eRn1_d15;
            eRn1_d17 <=  eRn1_d16;
            eRn1_d18 <=  eRn1_d17;
            eRn1_d19 <=  eRn1_d18;
            eRn1_d20 <=  eRn1_d19;
            eRn1_d21 <=  eRn1_d20;
            eRn1_d22 <=  eRn1_d21;
            eRn1_d23 <=  eRn1_d22;
            eRn1_d24 <=  eRn1_d23;
            eRn1_d25 <=  eRn1_d24;
            eRn1_d26 <=  eRn1_d25;
            eRn1_d27 <=  eRn1_d26;
            eRn1_d28 <=  eRn1_d27;
            eRn1_d29 <=  eRn1_d28;
            eRn1_d30 <=  eRn1_d29;
            eRn1_d31 <=  eRn1_d30;
            eRn1_d32 <=  eRn1_d31;
            eRn1_d33 <=  eRn1_d32;
            eRn1_d34 <=  eRn1_d33;
            eRn1_d35 <=  eRn1_d34;
            eRn1_d36 <=  eRn1_d35;
            eRn1_d37 <=  eRn1_d36;
            eRn1_d38 <=  eRn1_d37;
            eRn1_d39 <=  eRn1_d38;
            eRn1_d40 <=  eRn1_d39;
            eRn1_d41 <=  eRn1_d40;
            eRn1_d42 <=  eRn1_d41;
            eRn1_d43 <=  eRn1_d42;
            eRn1_d44 <=  eRn1_d43;
            eRn1_d45 <=  eRn1_d44;
            eRn1_d46 <=  eRn1_d45;
            eRn1_d47 <=  eRn1_d46;
            eRn1_d48 <=  eRn1_d47;
            eRn1_d49 <=  eRn1_d48;
            eRn1_d50 <=  eRn1_d49;
            eRn1_d51 <=  eRn1_d50;
            eRn1_d52 <=  eRn1_d51;
            eRn1_d53 <=  eRn1_d52;
            eRn1_d54 <=  eRn1_d53;
            eRn1_d55 <=  eRn1_d54;
            eRn1_d56 <=  eRn1_d55;
            eRn1_d57 <=  eRn1_d56;
            eRn1_d58 <=  eRn1_d57;
            eRn1_d59 <=  eRn1_d58;
            eRn1_d60 <=  eRn1_d59;
            fracXnorm_d1 <=  fracXnorm;
            fracXnorm_d2 <=  fracXnorm_d1;
            S0_d1 <=  S0;
            S0_d2 <=  S0_d1;
            d1_d1 <=  d1;
            d1_d2 <=  d1_d1;
            T1s_h_d1 <=  T1s_h;
            T1s_h_d2 <=  T1s_h_d1;
            T1s_l_d1 <=  T1s_l;
            T1s_l_d2 <=  T1s_l_d1;
            U1_d1 <=  U1;
            U1_d2 <=  U1_d1;
            S1_d1 <=  S1;
            S1_d2 <=  S1_d1;
            d2_d1 <=  d2;
            d2_d2 <=  d2_d1;
            T2s_h_d1 <=  T2s_h;
            T2s_h_d2 <=  T2s_h_d1;
            T2s_l_d1 <=  T2s_l;
            T2s_l_d2 <=  T2s_l_d1;
            U2_d1 <=  U2;
            U2_d2 <=  U2_d1;
            S2_d1 <=  S2;
            S2_d2 <=  S2_d1;
            d3_d1 <=  d3;
            d3_d2 <=  d3_d1;
            T3s_h_d1 <=  T3s_h;
            T3s_h_d2 <=  T3s_h_d1;
            T3s_l_d1 <=  T3s_l;
            T3s_l_d2 <=  T3s_l_d1;
            U3_d1 <=  U3;
            U3_d2 <=  U3_d1;
            S3_d1 <=  S3;
            S3_d2 <=  S3_d1;
            d4_d1 <=  d4;
            d4_d2 <=  d4_d1;
            d4_d3 <=  d4_d2;
            T4s_h_d1 <=  T4s_h;
            T4s_h_d2 <=  T4s_h_d1;
            T4s_h_d3 <=  T4s_h_d2;
            T4s_l_d1 <=  T4s_l;
            T4s_l_d2 <=  T4s_l_d1;
            T4s_l_d3 <=  T4s_l_d2;
            U4_d1 <=  U4;
            U4_d2 <=  U4_d1;
            U4_d3 <=  U4_d2;
            S4_d1 <=  S4;
            S4_d2 <=  S4_d1;
            S4_d3 <=  S4_d2;
            d5_d1 <=  d5;
            d5_d2 <=  d5_d1;
            T5s_h_d1 <=  T5s_h;
            T5s_h_d2 <=  T5s_h_d1;
            T5s_l_d1 <=  T5s_l;
            T5s_l_d2 <=  T5s_l_d1;
            U5_d1 <=  U5;
            U5_d2 <=  U5_d1;
            S5_d1 <=  S5;
            S5_d2 <=  S5_d1;
            d6_d1 <=  d6;
            d6_d2 <=  d6_d1;
            T6s_h_d1 <=  T6s_h;
            T6s_h_d2 <=  T6s_h_d1;
            T6s_l_d1 <=  T6s_l;
            T6s_l_d2 <=  T6s_l_d1;
            U6_d1 <=  U6;
            U6_d2 <=  U6_d1;
            S6_d1 <=  S6;
            S6_d2 <=  S6_d1;
            d7_d1 <=  d7;
            d7_d2 <=  d7_d1;
            d7_d3 <=  d7_d2;
            T7s_h_d1 <=  T7s_h;
            T7s_h_d2 <=  T7s_h_d1;
            T7s_h_d3 <=  T7s_h_d2;
            T7s_l_d1 <=  T7s_l;
            T7s_l_d2 <=  T7s_l_d1;
            T7s_l_d3 <=  T7s_l_d2;
            U7_d1 <=  U7;
            U7_d2 <=  U7_d1;
            U7_d3 <=  U7_d2;
            S7_d1 <=  S7;
            S7_d2 <=  S7_d1;
            S7_d3 <=  S7_d2;
            d8_d1 <=  d8;
            d8_d2 <=  d8_d1;
            T8s_h_d1 <=  T8s_h;
            T8s_h_d2 <=  T8s_h_d1;
            T8s_l_d1 <=  T8s_l;
            T8s_l_d2 <=  T8s_l_d1;
            U8_d1 <=  U8;
            U8_d2 <=  U8_d1;
            S8_d1 <=  S8;
            S8_d2 <=  S8_d1;
            d9_d1 <=  d9;
            d9_d2 <=  d9_d1;
            T9s_h_d1 <=  T9s_h;
            T9s_h_d2 <=  T9s_h_d1;
            T9s_l_d1 <=  T9s_l;
            T9s_l_d2 <=  T9s_l_d1;
            U9_d1 <=  U9;
            U9_d2 <=  U9_d1;
            S9_d1 <=  S9;
            S9_d2 <=  S9_d1;
            d10_d1 <=  d10;
            d10_d2 <=  d10_d1;
            d10_d3 <=  d10_d2;
            T10s_h_d1 <=  T10s_h;
            T10s_h_d2 <=  T10s_h_d1;
            T10s_h_d3 <=  T10s_h_d2;
            T10s_l_d1 <=  T10s_l;
            T10s_l_d2 <=  T10s_l_d1;
            T10s_l_d3 <=  T10s_l_d2;
            U10_d1 <=  U10;
            U10_d2 <=  U10_d1;
            U10_d3 <=  U10_d2;
            S10_d1 <=  S10;
            S10_d2 <=  S10_d1;
            S10_d3 <=  S10_d2;
            d11_d1 <=  d11;
            d11_d2 <=  d11_d1;
            T11s_h_d1 <=  T11s_h;
            T11s_h_d2 <=  T11s_h_d1;
            T11s_l_d1 <=  T11s_l;
            T11s_l_d2 <=  T11s_l_d1;
            U11_d1 <=  U11;
            U11_d2 <=  U11_d1;
            S11_d1 <=  S11;
            S11_d2 <=  S11_d1;
            d12_d1 <=  d12;
            d12_d2 <=  d12_d1;
            T12s_h_d1 <=  T12s_h;
            T12s_h_d2 <=  T12s_h_d1;
            T12s_l_d1 <=  T12s_l;
            T12s_l_d2 <=  T12s_l_d1;
            U12_d1 <=  U12;
            U12_d2 <=  U12_d1;
            S12_d1 <=  S12;
            S12_d2 <=  S12_d1;
            d13_d1 <=  d13;
            d13_d2 <=  d13_d1;
            d13_d3 <=  d13_d2;
            T13s_h_d1 <=  T13s_h;
            T13s_h_d2 <=  T13s_h_d1;
            T13s_h_d3 <=  T13s_h_d2;
            T13s_l_d1 <=  T13s_l;
            T13s_l_d2 <=  T13s_l_d1;
            T13s_l_d3 <=  T13s_l_d2;
            U13_d1 <=  U13;
            U13_d2 <=  U13_d1;
            U13_d3 <=  U13_d2;
            S13_d1 <=  S13;
            S13_d2 <=  S13_d1;
            S13_d3 <=  S13_d2;
            d14_d1 <=  d14;
            d14_d2 <=  d14_d1;
            T14s_h_d1 <=  T14s_h;
            T14s_h_d2 <=  T14s_h_d1;
            T14s_l_d1 <=  T14s_l;
            T14s_l_d2 <=  T14s_l_d1;
            U14_d1 <=  U14;
            U14_d2 <=  U14_d1;
            S14_d1 <=  S14;
            S14_d2 <=  S14_d1;
            d15_d1 <=  d15;
            d15_d2 <=  d15_d1;
            d15_d3 <=  d15_d2;
            T15s_h_d1 <=  T15s_h;
            T15s_h_d2 <=  T15s_h_d1;
            T15s_h_d3 <=  T15s_h_d2;
            T15s_l_d1 <=  T15s_l;
            T15s_l_d2 <=  T15s_l_d1;
            T15s_l_d3 <=  T15s_l_d2;
            U15_d1 <=  U15;
            U15_d2 <=  U15_d1;
            U15_d3 <=  U15_d2;
            S15_d1 <=  S15;
            S15_d2 <=  S15_d1;
            S15_d3 <=  S15_d2;
            d16_d1 <=  d16;
            d16_d2 <=  d16_d1;
            T16s_h_d1 <=  T16s_h;
            T16s_h_d2 <=  T16s_h_d1;
            T16s_l_d1 <=  T16s_l;
            T16s_l_d2 <=  T16s_l_d1;
            U16_d1 <=  U16;
            U16_d2 <=  U16_d1;
            S16_d1 <=  S16;
            S16_d2 <=  S16_d1;
            d17_d1 <=  d17;
            d17_d2 <=  d17_d1;
            d17_d3 <=  d17_d2;
            T17s_h_d1 <=  T17s_h;
            T17s_h_d2 <=  T17s_h_d1;
            T17s_h_d3 <=  T17s_h_d2;
            T17s_l_d1 <=  T17s_l;
            T17s_l_d2 <=  T17s_l_d1;
            T17s_l_d3 <=  T17s_l_d2;
            U17_d1 <=  U17;
            U17_d2 <=  U17_d1;
            U17_d3 <=  U17_d2;
            S17_d1 <=  S17;
            S17_d2 <=  S17_d1;
            S17_d3 <=  S17_d2;
            d18_d1 <=  d18;
            d18_d2 <=  d18_d1;
            T18s_h_d1 <=  T18s_h;
            T18s_h_d2 <=  T18s_h_d1;
            T18s_l_d1 <=  T18s_l;
            T18s_l_d2 <=  T18s_l_d1;
            U18_d1 <=  U18;
            U18_d2 <=  U18_d1;
            S18_d1 <=  S18;
            S18_d2 <=  S18_d1;
            d19_d1 <=  d19;
            d19_d2 <=  d19_d1;
            d19_d3 <=  d19_d2;
            T19s_h_d1 <=  T19s_h;
            T19s_h_d2 <=  T19s_h_d1;
            T19s_h_d3 <=  T19s_h_d2;
            T19s_l_d1 <=  T19s_l;
            T19s_l_d2 <=  T19s_l_d1;
            T19s_l_d3 <=  T19s_l_d2;
            U19_d1 <=  U19;
            U19_d2 <=  U19_d1;
            U19_d3 <=  U19_d2;
            S19_d1 <=  S19;
            S19_d2 <=  S19_d1;
            S19_d3 <=  S19_d2;
            d20_d1 <=  d20;
            d20_d2 <=  d20_d1;
            d20_d3 <=  d20_d2;
            T20s_h_d1 <=  T20s_h;
            T20s_h_d2 <=  T20s_h_d1;
            T20s_h_d3 <=  T20s_h_d2;
            T20s_l_d1 <=  T20s_l;
            T20s_l_d2 <=  T20s_l_d1;
            T20s_l_d3 <=  T20s_l_d2;
            U20_d1 <=  U20;
            U20_d2 <=  U20_d1;
            U20_d3 <=  U20_d2;
            S20_d1 <=  S20;
            S20_d2 <=  S20_d1;
            S20_d3 <=  S20_d2;
            d21_d1 <=  d21;
            d21_d2 <=  d21_d1;
            T21s_h_d1 <=  T21s_h;
            T21s_h_d2 <=  T21s_h_d1;
            T21s_l_d1 <=  T21s_l;
            T21s_l_d2 <=  T21s_l_d1;
            U21_d1 <=  U21;
            U21_d2 <=  U21_d1;
            S21_d1 <=  S21;
            S21_d2 <=  S21_d1;
            d22_d1 <=  d22;
            d22_d2 <=  d22_d1;
            d22_d3 <=  d22_d2;
            T22s_h_d1 <=  T22s_h;
            T22s_h_d2 <=  T22s_h_d1;
            T22s_h_d3 <=  T22s_h_d2;
            T22s_l_d1 <=  T22s_l;
            T22s_l_d2 <=  T22s_l_d1;
            T22s_l_d3 <=  T22s_l_d2;
            U22_d1 <=  U22;
            U22_d2 <=  U22_d1;
            U22_d3 <=  U22_d2;
            S22_d1 <=  S22;
            S22_d2 <=  S22_d1;
            S22_d3 <=  S22_d2;
            d23_d1 <=  d23;
            d23_d2 <=  d23_d1;
            d23_d3 <=  d23_d2;
            T23s_h_d1 <=  T23s_h;
            T23s_h_d2 <=  T23s_h_d1;
            T23s_h_d3 <=  T23s_h_d2;
            U23_d1 <=  U23;
            U23_d2 <=  U23_d1;
            U23_d3 <=  U23_d2;
            S23_d1 <=  S23;
            S23_d2 <=  S23_d1;
            S23_d3 <=  S23_d2;
            fR_d1 <=  fR;
            fR_d2 <=  fR_d1;
            round_d1 <=  round;
            round_d2 <=  round_d1;
            xsR_d1 <=  xsR;
            xsR_d2 <=  xsR_d1;
            xsR_d3 <=  xsR_d2;
            xsR_d4 <=  xsR_d3;
            xsR_d5 <=  xsR_d4;
            xsR_d6 <=  xsR_d5;
            xsR_d7 <=  xsR_d6;
            xsR_d8 <=  xsR_d7;
            xsR_d9 <=  xsR_d8;
            xsR_d10 <=  xsR_d9;
            xsR_d11 <=  xsR_d10;
            xsR_d12 <=  xsR_d11;
            xsR_d13 <=  xsR_d12;
            xsR_d14 <=  xsR_d13;
            xsR_d15 <=  xsR_d14;
            xsR_d16 <=  xsR_d15;
            xsR_d17 <=  xsR_d16;
            xsR_d18 <=  xsR_d17;
            xsR_d19 <=  xsR_d18;
            xsR_d20 <=  xsR_d19;
            xsR_d21 <=  xsR_d20;
            xsR_d22 <=  xsR_d21;
            xsR_d23 <=  xsR_d22;
            xsR_d24 <=  xsR_d23;
            xsR_d25 <=  xsR_d24;
            xsR_d26 <=  xsR_d25;
            xsR_d27 <=  xsR_d26;
            xsR_d28 <=  xsR_d27;
            xsR_d29 <=  xsR_d28;
            xsR_d30 <=  xsR_d29;
            xsR_d31 <=  xsR_d30;
            xsR_d32 <=  xsR_d31;
            xsR_d33 <=  xsR_d32;
            xsR_d34 <=  xsR_d33;
            xsR_d35 <=  xsR_d34;
            xsR_d36 <=  xsR_d35;
            xsR_d37 <=  xsR_d36;
            xsR_d38 <=  xsR_d37;
            xsR_d39 <=  xsR_d38;
            xsR_d40 <=  xsR_d39;
            xsR_d41 <=  xsR_d40;
            xsR_d42 <=  xsR_d41;
            xsR_d43 <=  xsR_d42;
            xsR_d44 <=  xsR_d43;
            xsR_d45 <=  xsR_d44;
            xsR_d46 <=  xsR_d45;
            xsR_d47 <=  xsR_d46;
            xsR_d48 <=  xsR_d47;
            xsR_d49 <=  xsR_d48;
            xsR_d50 <=  xsR_d49;
            xsR_d51 <=  xsR_d50;
            xsR_d52 <=  xsR_d51;
            xsR_d53 <=  xsR_d52;
            xsR_d54 <=  xsR_d53;
            xsR_d55 <=  xsR_d54;
            xsR_d56 <=  xsR_d55;
            xsR_d57 <=  xsR_d56;
            xsR_d58 <=  xsR_d57;
            xsR_d59 <=  xsR_d58;
            xsR_d60 <=  xsR_d59;
         end if;
      end process;
   fracX <= X(22 downto 0); -- fraction
   eRn0 <= "0" & X(30 downto 24); -- exponent
   xsX <= X(33 downto 31); -- exception and sign
   eRn1 <= eRn0 + ("00" & (5 downto 0 => '1')) + X(23);
   fracXnorm <= "1" & fracX & "000" when X(23) = '0' else
         "01" & fracX&"00"; -- pre-normalization
   S0 <= "01";
   T1 <= ("0111" + fracXnorm_d2(26 downto 23)) & fracXnorm_d2(22 downto 0);
   -- now implementing the recurrence 
   --  this is a binary non-restoring algorithm, see ASA book
   -- Step 2
   d1 <= not T1(26); --  bit of weight -1
   T1s <= T1 & "0";
   T1s_h <= T1s(27 downto 22);
   T1s_l <= T1s(21 downto 0);
   U1 <=  "0" & S0_d2 & d1 & (not d1) & "1"; 
   T3_h <=   T1s_h_d2 - U1_d2 when d1_d2='1'
        else T1s_h_d2 + U1_d2;
   T2 <= T3_h(4 downto 0) & T1s_l_d2;
   S1 <= S0_d2 & d1; -- here -1 becomes 0 and 1 becomes 1
   -- Step 3
   d2 <= not T2(26); --  bit of weight -2
   T2s <= T2 & "0";
   T2s_h <= T2s(27 downto 21);
   T2s_l <= T2s(20 downto 0);
   U2 <=  "0" & S1_d2 & d2 & (not d2) & "1"; 
   T4_h <=   T2s_h_d2 - U2_d2 when d2_d2='1'
        else T2s_h_d2 + U2_d2;
   T3 <= T4_h(5 downto 0) & T2s_l_d2;
   S2 <= S1_d2 & d2; -- here -1 becomes 0 and 1 becomes 1
   -- Step 4
   d3 <= not T3(26); --  bit of weight -3
   T3s <= T3 & "0";
   T3s_h <= T3s(27 downto 20);
   T3s_l <= T3s(19 downto 0);
   U3 <=  "0" & S2_d2 & d3 & (not d3) & "1"; 
   T5_h <=   T3s_h_d2 - U3_d2 when d3_d2='1'
        else T3s_h_d2 + U3_d2;
   T4 <= T5_h(6 downto 0) & T3s_l_d2;
   S3 <= S2_d2 & d3; -- here -1 becomes 0 and 1 becomes 1
   -- Step 5
   d4 <= not T4(26); --  bit of weight -4
   T4s <= T4 & "0";
   T4s_h <= T4s(27 downto 19);
   T4s_l <= T4s(18 downto 0);
   U4 <=  "0" & S3_d2 & d4 & (not d4) & "1"; 
   T6_h <=   T4s_h_d3 - U4_d3 when d4_d3='1'
        else T4s_h_d3 + U4_d3;
   T5 <= T6_h(7 downto 0) & T4s_l_d3;
   S4 <= S3_d2 & d4; -- here -1 becomes 0 and 1 becomes 1
   -- Step 6
   d5 <= not T5(26); --  bit of weight -5
   T5s <= T5 & "0";
   T5s_h <= T5s(27 downto 18);
   T5s_l <= T5s(17 downto 0);
   U5 <=  "0" & S4_d3 & d5 & (not d5) & "1"; 
   T7_h <=   T5s_h_d2 - U5_d2 when d5_d2='1'
        else T5s_h_d2 + U5_d2;
   T6 <= T7_h(8 downto 0) & T5s_l_d2;
   S5 <= S4_d3 & d5; -- here -1 becomes 0 and 1 becomes 1
   -- Step 7
   d6 <= not T6(26); --  bit of weight -6
   T6s <= T6 & "0";
   T6s_h <= T6s(27 downto 17);
   T6s_l <= T6s(16 downto 0);
   U6 <=  "0" & S5_d2 & d6 & (not d6) & "1"; 
   T8_h <=   T6s_h_d2 - U6_d2 when d6_d2='1'
        else T6s_h_d2 + U6_d2;
   T7 <= T8_h(9 downto 0) & T6s_l_d2;
   S6 <= S5_d2 & d6; -- here -1 becomes 0 and 1 becomes 1
   -- Step 8
   d7 <= not T7(26); --  bit of weight -7
   T7s <= T7 & "0";
   T7s_h <= T7s(27 downto 16);
   T7s_l <= T7s(15 downto 0);
   U7 <=  "0" & S6_d2 & d7 & (not d7) & "1"; 
   T9_h <=   T7s_h_d3 - U7_d3 when d7_d3='1'
        else T7s_h_d3 + U7_d3;
   T8 <= T9_h(10 downto 0) & T7s_l_d3;
   S7 <= S6_d2 & d7; -- here -1 becomes 0 and 1 becomes 1
   -- Step 9
   d8 <= not T8(26); --  bit of weight -8
   T8s <= T8 & "0";
   T8s_h <= T8s(27 downto 15);
   T8s_l <= T8s(14 downto 0);
   U8 <=  "0" & S7_d3 & d8 & (not d8) & "1"; 
   T10_h <=   T8s_h_d2 - U8_d2 when d8_d2='1'
        else T8s_h_d2 + U8_d2;
   T9 <= T10_h(11 downto 0) & T8s_l_d2;
   S8 <= S7_d3 & d8; -- here -1 becomes 0 and 1 becomes 1
   -- Step 10
   d9 <= not T9(26); --  bit of weight -9
   T9s <= T9 & "0";
   T9s_h <= T9s(27 downto 14);
   T9s_l <= T9s(13 downto 0);
   U9 <=  "0" & S8_d2 & d9 & (not d9) & "1"; 
   T11_h <=   T9s_h_d2 - U9_d2 when d9_d2='1'
        else T9s_h_d2 + U9_d2;
   T10 <= T11_h(12 downto 0) & T9s_l_d2;
   S9 <= S8_d2 & d9; -- here -1 becomes 0 and 1 becomes 1
   -- Step 11
   d10 <= not T10(26); --  bit of weight -10
   T10s <= T10 & "0";
   T10s_h <= T10s(27 downto 13);
   T10s_l <= T10s(12 downto 0);
   U10 <=  "0" & S9_d2 & d10 & (not d10) & "1"; 
   T12_h <=   T10s_h_d3 - U10_d3 when d10_d3='1'
        else T10s_h_d3 + U10_d3;
   T11 <= T12_h(13 downto 0) & T10s_l_d3;
   S10 <= S9_d2 & d10; -- here -1 becomes 0 and 1 becomes 1
   -- Step 12
   d11 <= not T11(26); --  bit of weight -11
   T11s <= T11 & "0";
   T11s_h <= T11s(27 downto 12);
   T11s_l <= T11s(11 downto 0);
   U11 <=  "0" & S10_d3 & d11 & (not d11) & "1"; 
   T13_h <=   T11s_h_d2 - U11_d2 when d11_d2='1'
        else T11s_h_d2 + U11_d2;
   T12 <= T13_h(14 downto 0) & T11s_l_d2;
   S11 <= S10_d3 & d11; -- here -1 becomes 0 and 1 becomes 1
   -- Step 13
   d12 <= not T12(26); --  bit of weight -12
   T12s <= T12 & "0";
   T12s_h <= T12s(27 downto 11);
   T12s_l <= T12s(10 downto 0);
   U12 <=  "0" & S11_d2 & d12 & (not d12) & "1"; 
   T14_h <=   T12s_h_d2 - U12_d2 when d12_d2='1'
        else T12s_h_d2 + U12_d2;
   T13 <= T14_h(15 downto 0) & T12s_l_d2;
   S12 <= S11_d2 & d12; -- here -1 becomes 0 and 1 becomes 1
   -- Step 14
   d13 <= not T13(26); --  bit of weight -13
   T13s <= T13 & "0";
   T13s_h <= T13s(27 downto 10);
   T13s_l <= T13s(9 downto 0);
   U13 <=  "0" & S12_d2 & d13 & (not d13) & "1"; 
   T15_h <=   T13s_h_d3 - U13_d3 when d13_d3='1'
        else T13s_h_d3 + U13_d3;
   T14 <= T15_h(16 downto 0) & T13s_l_d3;
   S13 <= S12_d2 & d13; -- here -1 becomes 0 and 1 becomes 1
   -- Step 15
   d14 <= not T14(26); --  bit of weight -14
   T14s <= T14 & "0";
   T14s_h <= T14s(27 downto 9);
   T14s_l <= T14s(8 downto 0);
   U14 <=  "0" & S13_d3 & d14 & (not d14) & "1"; 
   T16_h <=   T14s_h_d2 - U14_d2 when d14_d2='1'
        else T14s_h_d2 + U14_d2;
   T15 <= T16_h(17 downto 0) & T14s_l_d2;
   S14 <= S13_d3 & d14; -- here -1 becomes 0 and 1 becomes 1
   -- Step 16
   d15 <= not T15(26); --  bit of weight -15
   T15s <= T15 & "0";
   T15s_h <= T15s(27 downto 8);
   T15s_l <= T15s(7 downto 0);
   U15 <=  "0" & S14_d2 & d15 & (not d15) & "1"; 
   T17_h <=   T15s_h_d3 - U15_d3 when d15_d3='1'
        else T15s_h_d3 + U15_d3;
   T16 <= T17_h(18 downto 0) & T15s_l_d3;
   S15 <= S14_d2 & d15; -- here -1 becomes 0 and 1 becomes 1
   -- Step 17
   d16 <= not T16(26); --  bit of weight -16
   T16s <= T16 & "0";
   T16s_h <= T16s(27 downto 7);
   T16s_l <= T16s(6 downto 0);
   U16 <=  "0" & S15_d3 & d16 & (not d16) & "1"; 
   T18_h <=   T16s_h_d2 - U16_d2 when d16_d2='1'
        else T16s_h_d2 + U16_d2;
   T17 <= T18_h(19 downto 0) & T16s_l_d2;
   S16 <= S15_d3 & d16; -- here -1 becomes 0 and 1 becomes 1
   -- Step 18
   d17 <= not T17(26); --  bit of weight -17
   T17s <= T17 & "0";
   T17s_h <= T17s(27 downto 6);
   T17s_l <= T17s(5 downto 0);
   U17 <=  "0" & S16_d2 & d17 & (not d17) & "1"; 
   T19_h <=   T17s_h_d3 - U17_d3 when d17_d3='1'
        else T17s_h_d3 + U17_d3;
   T18 <= T19_h(20 downto 0) & T17s_l_d3;
   S17 <= S16_d2 & d17; -- here -1 becomes 0 and 1 becomes 1
   -- Step 19
   d18 <= not T18(26); --  bit of weight -18
   T18s <= T18 & "0";
   T18s_h <= T18s(27 downto 5);
   T18s_l <= T18s(4 downto 0);
   U18 <=  "0" & S17_d3 & d18 & (not d18) & "1"; 
   T20_h <=   T18s_h_d2 - U18_d2 when d18_d2='1'
        else T18s_h_d2 + U18_d2;
   T19 <= T20_h(21 downto 0) & T18s_l_d2;
   S18 <= S17_d3 & d18; -- here -1 becomes 0 and 1 becomes 1
   -- Step 20
   d19 <= not T19(26); --  bit of weight -19
   T19s <= T19 & "0";
   T19s_h <= T19s(27 downto 4);
   T19s_l <= T19s(3 downto 0);
   U19 <=  "0" & S18_d2 & d19 & (not d19) & "1"; 
   T21_h <=   T19s_h_d3 - U19_d3 when d19_d3='1'
        else T19s_h_d3 + U19_d3;
   T20 <= T21_h(22 downto 0) & T19s_l_d3;
   S19 <= S18_d2 & d19; -- here -1 becomes 0 and 1 becomes 1
   -- Step 21
   d20 <= not T20(26); --  bit of weight -20
   T20s <= T20 & "0";
   T20s_h <= T20s(27 downto 3);
   T20s_l <= T20s(2 downto 0);
   U20 <=  "0" & S19_d3 & d20 & (not d20) & "1"; 
   T22_h <=   T20s_h_d3 - U20_d3 when d20_d3='1'
        else T20s_h_d3 + U20_d3;
   T21 <= T22_h(23 downto 0) & T20s_l_d3;
   S20 <= S19_d3 & d20; -- here -1 becomes 0 and 1 becomes 1
   -- Step 22
   d21 <= not T21(26); --  bit of weight -21
   T21s <= T21 & "0";
   T21s_h <= T21s(27 downto 2);
   T21s_l <= T21s(1 downto 0);
   U21 <=  "0" & S20_d3 & d21 & (not d21) & "1"; 
   T23_h <=   T21s_h_d2 - U21_d2 when d21_d2='1'
        else T21s_h_d2 + U21_d2;
   T22 <= T23_h(24 downto 0) & T21s_l_d2;
   S21 <= S20_d3 & d21; -- here -1 becomes 0 and 1 becomes 1
   -- Step 23
   d22 <= not T22(26); --  bit of weight -22
   T22s <= T22 & "0";
   T22s_h <= T22s(27 downto 1);
   T22s_l <= T22s(0 downto 0);
   U22 <=  "0" & S21_d2 & d22 & (not d22) & "1"; 
   T24_h <=   T22s_h_d3 - U22_d3 when d22_d3='1'
        else T22s_h_d3 + U22_d3;
   T23 <= T24_h(25 downto 0) & T22s_l_d3;
   S22 <= S21_d2 & d22; -- here -1 becomes 0 and 1 becomes 1
   -- Step 24
   d23 <= not T23(26); --  bit of weight -23
   T23s <= T23 & "0";
   T23s_h <= T23s(27 downto 0);
   U23 <=  "0" & S22_d3 & d23 & (not d23) & "1"; 
   T25_h <=   T23s_h_d3 - U23_d3 when d23_d3='1'
        else T23s_h_d3 + U23_d3;
   T24 <= T25_h(26 downto 0);
   S23 <= S22_d3 & d23; -- here -1 becomes 0 and 1 becomes 1
   d25 <= not T24(26) ; -- the sign of the remainder will become the round bit
   mR <= S23_d3 & d25; -- result significand
   fR <= mR(23 downto 1);-- removing leading 1
   round <= mR(0); -- round bit
   fRrnd <= fR_d2 + ((22 downto 1 => '0') & round_d2); -- rounding sqrt never changes exponents 
   Rn2 <= eRn1_d60 & fRrnd;
   -- sign and exception processing
   with xsX  select 
      xsR <= "010"  when "010",  -- normal case
             "100"  when "100",  -- +infty
             "000"  when "000",  -- +0
             "001"  when "001",  -- the infamous sqrt(-0)=-0
             "110"  when others; -- return NaN
   R <= xsR_d60 & Rn2; 
end architecture;

