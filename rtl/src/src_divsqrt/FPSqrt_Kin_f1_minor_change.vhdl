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
signal eRn1 :  std_logic_vector(7 downto 0);
   -- timing of eRn1: (c0, 0.000000ns)
signal fracXnorm :  std_logic_vector(26 downto 0);
   -- timing of fracXnorm: (c0, 0.043000ns)
signal S0 :  std_logic_vector(1 downto 0);
   -- timing of S0: (c0, 0.000000ns)
signal T1 :  std_logic_vector(26 downto 0);
   -- timing of T1: (c0, 1.086000ns)
signal d1 :  std_logic;
   -- timing of d1: (c0, 1.086000ns)
signal T1s :  std_logic_vector(27 downto 0);
   -- timing of T1s: (c0, 1.086000ns)
signal T1s_h :  std_logic_vector(5 downto 0);
   -- timing of T1s_h: (c0, 1.086000ns)
signal T1s_l :  std_logic_vector(21 downto 0);
   -- timing of T1s_l: (c0, 1.086000ns)
signal U1 :  std_logic_vector(5 downto 0);
   -- timing of U1: (c0, 1.086000ns)
signal T3_h :  std_logic_vector(5 downto 0);
   -- timing of T3_h: (c0, 2.080000ns)
signal T2 :  std_logic_vector(26 downto 0);
   -- timing of T2: (c0, 2.080000ns)
signal S1 :  std_logic_vector(2 downto 0);
   -- timing of S1: (c0, 1.086000ns)

signal d2 :  std_logic;
   -- timing of d2: (c0, 2.080000ns)
signal T2s :  std_logic_vector(27 downto 0);
   -- timing of T2s: (c0, 2.080000ns)
signal T2s_h :  std_logic_vector(6 downto 0);
   -- timing of T2s_h: (c0, 2.080000ns)
signal T2s_l :  std_logic_vector(20 downto 0);
   -- timing of T2s_l: (c0, 2.080000ns)
signal U2 :  std_logic_vector(6 downto 0);
   -- timing of U2: (c0, 2.080000ns)
signal T4_h :  std_logic_vector(6 downto 0);
   -- timing of T4_h: (c0, 3.123000ns)
signal T3 :  std_logic_vector(26 downto 0);
   -- timing of T3: (c0, 3.123000ns)
signal S2 :  std_logic_vector(3 downto 0);
   -- timing of S2: (c0, 2.080000ns)

signal d3 :  std_logic;
   -- timing of d3: (c0, 3.123000ns)
signal T3s :  std_logic_vector(27 downto 0);
   -- timing of T3s: (c0, 3.123000ns)
signal T3s_h :  std_logic_vector(7 downto 0);
   -- timing of T3s_h: (c0, 3.123000ns)
signal T3s_l :  std_logic_vector(19 downto 0);
   -- timing of T3s_l: (c0, 3.123000ns)
signal U3 :  std_logic_vector(7 downto 0);
   -- timing of U3: (c0, 3.123000ns)
signal T5_h :  std_logic_vector(7 downto 0);
   -- timing of T5_h: (c0, 4.166000ns)
signal T4 :  std_logic_vector(26 downto 0);
   -- timing of T4: (c0, 4.166000ns)
signal S3 :  std_logic_vector(4 downto 0);
   -- timing of S3: (c0, 3.123000ns)
   
signal d4 :  std_logic;
   -- timing of d4: (c0, 4.166000ns)
signal T4s :  std_logic_vector(27 downto 0);
   -- timing of T4s: (c0, 4.166000ns)
signal T4s_h :  std_logic_vector(8 downto 0);
   -- timing of T4s_h: (c0, 4.166000ns)
signal T4s_l :  std_logic_vector(18 downto 0);
   -- timing of T4s_l: (c0, 4.166000ns)
signal U4 :  std_logic_vector(8 downto 0);
   -- timing of U4: (c0, 4.166000ns)
signal T6_h :  std_logic_vector(8 downto 0);
   -- timing of T6_h: (c0, 5.209000ns)
signal T5 :  std_logic_vector(26 downto 0);
   -- timing of T5: (c0, 5.209000ns)
signal S4 :  std_logic_vector(5 downto 0);
   -- timing of S4: (c0, 4.166000ns)
signal d5 :  std_logic;
   -- timing of d5: (c0, 5.209000ns)
signal T5s :  std_logic_vector(27 downto 0);
   -- timing of T5s: (c0, 5.209000ns)
signal T5s_h :  std_logic_vector(9 downto 0);
   -- timing of T5s_h: (c0, 5.209000ns)
signal T5s_l :  std_logic_vector(17 downto 0);
   -- timing of T5s_l: (c0, 5.209000ns)
signal U5 :  std_logic_vector(9 downto 0);
   -- timing of U5: (c0, 5.209000ns)
signal T7_h :  std_logic_vector(9 downto 0);
   -- timing of T7_h: (c0, 6.252000ns)
signal T6 :  std_logic_vector(26 downto 0);
   -- timing of T6: (c0, 6.252000ns)
signal S5 :  std_logic_vector(6 downto 0);
   -- timing of S5: (c0, 5.209000ns)
signal d6 :  std_logic;
   -- timing of d6: (c0, 6.252000ns)
signal T6s :  std_logic_vector(27 downto 0);
   -- timing of T6s: (c0, 6.252000ns)
signal T6s_h :  std_logic_vector(10 downto 0);
   -- timing of T6s_h: (c0, 6.252000ns)
signal T6s_l :  std_logic_vector(16 downto 0);
   -- timing of T6s_l: (c0, 6.252000ns)
signal U6 :  std_logic_vector(10 downto 0);
   -- timing of U6: (c0, 6.252000ns)
signal T8_h :  std_logic_vector(10 downto 0);
   -- timing of T8_h: (c0, 7.344000ns)
signal T7 :  std_logic_vector(26 downto 0);
   -- timing of T7: (c0, 7.344000ns)
signal S6 :  std_logic_vector(7 downto 0);
   -- timing of S6: (c0, 6.252000ns)
signal d7 :  std_logic;
   -- timing of d7: (c0, 7.344000ns)
signal T7s :  std_logic_vector(27 downto 0);
   -- timing of T7s: (c0, 7.344000ns)
signal T7s_h :  std_logic_vector(11 downto 0);
   -- timing of T7s_h: (c0, 7.344000ns)
signal T7s_l :  std_logic_vector(15 downto 0);
   -- timing of T7s_l: (c0, 7.344000ns)
signal U7 :  std_logic_vector(11 downto 0);
   -- timing of U7: (c0, 7.344000ns)
signal T9_h :  std_logic_vector(11 downto 0);
   -- timing of T9_h: (c0, 8.436000ns)
signal T8 :  std_logic_vector(26 downto 0);
   -- timing of T8: (c0, 8.436000ns)
signal S7 :  std_logic_vector(8 downto 0);
   -- timing of S7: (c0, 7.344000ns)
signal d8 :  std_logic;
   -- timing of d8: (c0, 8.436000ns)
signal T8s :  std_logic_vector(27 downto 0);
   -- timing of T8s: (c0, 8.436000ns)
signal T8s_h :  std_logic_vector(12 downto 0);
   -- timing of T8s_h: (c0, 8.436000ns)
signal T8s_l :  std_logic_vector(14 downto 0);
   -- timing of T8s_l: (c0, 8.436000ns)
signal U8 :  std_logic_vector(12 downto 0);
   -- timing of U8: (c0, 8.436000ns)
signal T10_h :  std_logic_vector(12 downto 0);
   -- timing of T10_h: (c0, 9.528000ns)
signal T9 :  std_logic_vector(26 downto 0);
   -- timing of T9: (c0, 9.528000ns)
signal S8 :  std_logic_vector(9 downto 0);
   -- timing of S8: (c0, 8.436000ns)
signal d9 :  std_logic;
   -- timing of d9: (c0, 9.528000ns)
signal T9s :  std_logic_vector(27 downto 0);
   -- timing of T9s: (c0, 9.528000ns)
signal T9s_h :  std_logic_vector(13 downto 0);
   -- timing of T9s_h: (c0, 9.528000ns)
signal T9s_l :  std_logic_vector(13 downto 0);
   -- timing of T9s_l: (c0, 9.528000ns)
signal U9 :  std_logic_vector(13 downto 0);
   -- timing of U9: (c0, 9.528000ns)
signal T11_h :  std_logic_vector(13 downto 0);
   -- timing of T11_h: (c0, 10.620000ns)
signal T10 :  std_logic_vector(26 downto 0);
   -- timing of T10: (c0, 10.620000ns)
signal S9 :  std_logic_vector(10 downto 0);
   -- timing of S9: (c0, 9.528000ns)
signal d10 :  std_logic;
   -- timing of d10: (c0, 10.620000ns)
signal T10s :  std_logic_vector(27 downto 0);
   -- timing of T10s: (c0, 10.620000ns)
signal T10s_h :  std_logic_vector(14 downto 0);
   -- timing of T10s_h: (c0, 10.620000ns)
signal T10s_l :  std_logic_vector(12 downto 0);
   -- timing of T10s_l: (c0, 10.620000ns)
signal U10 :  std_logic_vector(14 downto 0);
   -- timing of U10: (c0, 10.620000ns)
signal T12_h :  std_logic_vector(14 downto 0);
   -- timing of T12_h: (c0, 11.761000ns)
signal T11 :  std_logic_vector(26 downto 0);
   -- timing of T11: (c0, 11.761000ns)
signal S10 :  std_logic_vector(11 downto 0);
   -- timing of S10: (c0, 10.620000ns)
signal d11 :  std_logic;
   -- timing of d11: (c0, 11.761000ns)
signal T11s :  std_logic_vector(27 downto 0);
   -- timing of T11s: (c0, 11.761000ns)
signal T11s_h :  std_logic_vector(15 downto 0);
   -- timing of T11s_h: (c0, 11.761000ns)
signal T11s_l :  std_logic_vector(11 downto 0);
   -- timing of T11s_l: (c0, 11.761000ns)
signal U11 :  std_logic_vector(15 downto 0);
   -- timing of U11: (c0, 11.761000ns)
signal T13_h :  std_logic_vector(15 downto 0);
   -- timing of T13_h: (c0, 12.902000ns)
signal T12 :  std_logic_vector(26 downto 0);
   -- timing of T12: (c0, 12.902000ns)
signal S11 :  std_logic_vector(12 downto 0);
   -- timing of S11: (c0, 11.761000ns)
signal d12 :  std_logic;
   -- timing of d12: (c0, 12.902000ns)
signal T12s :  std_logic_vector(27 downto 0);
   -- timing of T12s: (c0, 12.902000ns)
signal T12s_h :  std_logic_vector(16 downto 0);
   -- timing of T12s_h: (c0, 12.902000ns)
signal T12s_l :  std_logic_vector(10 downto 0);
   -- timing of T12s_l: (c0, 12.902000ns)
signal U12 :  std_logic_vector(16 downto 0);
   -- timing of U12: (c0, 12.902000ns)
signal T14_h :  std_logic_vector(16 downto 0);
   -- timing of T14_h: (c0, 14.043000ns)
signal T13 :  std_logic_vector(26 downto 0);
   -- timing of T13: (c0, 14.043000ns)
signal S12 :  std_logic_vector(13 downto 0);
   -- timing of S12: (c0, 12.902000ns)
signal d13 :  std_logic;
   -- timing of d13: (c0, 14.043000ns)
signal T13s :  std_logic_vector(27 downto 0);
   -- timing of T13s: (c0, 14.043000ns)
signal T13s_h :  std_logic_vector(17 downto 0);
   -- timing of T13s_h: (c0, 14.043000ns)
signal T13s_l :  std_logic_vector(9 downto 0);
   -- timing of T13s_l: (c0, 14.043000ns)
signal U13 :  std_logic_vector(17 downto 0);
   -- timing of U13: (c0, 14.043000ns)
signal T15_h :  std_logic_vector(17 downto 0);
   -- timing of T15_h: (c0, 15.184000ns)
signal T14 :  std_logic_vector(26 downto 0);
   -- timing of T14: (c0, 15.184000ns)
signal S13 :  std_logic_vector(14 downto 0);
   -- timing of S13: (c0, 14.043000ns)
signal d14 :  std_logic;
   -- timing of d14: (c0, 15.184000ns)
signal T14s :  std_logic_vector(27 downto 0);
   -- timing of T14s: (c0, 15.184000ns)
signal T14s_h :  std_logic_vector(18 downto 0);
   -- timing of T14s_h: (c0, 15.184000ns)
signal T14s_l :  std_logic_vector(8 downto 0);
   -- timing of T14s_l: (c0, 15.184000ns)
signal U14 :  std_logic_vector(18 downto 0);
   -- timing of U14: (c0, 15.184000ns)
signal T16_h :  std_logic_vector(18 downto 0);
   -- timing of T16_h: (c0, 16.374000ns)
signal T15 :  std_logic_vector(26 downto 0);
   -- timing of T15: (c0, 16.374000ns)
signal S14 :  std_logic_vector(15 downto 0);
   -- timing of S14: (c0, 15.184000ns)
signal d15 :  std_logic;
   -- timing of d15: (c0, 16.374000ns)
signal T15s :  std_logic_vector(27 downto 0);
   -- timing of T15s: (c0, 16.374000ns)
signal T15s_h :  std_logic_vector(19 downto 0);
   -- timing of T15s_h: (c0, 16.374000ns)
signal T15s_l :  std_logic_vector(7 downto 0);
   -- timing of T15s_l: (c0, 16.374000ns)
signal U15 :  std_logic_vector(19 downto 0);
   -- timing of U15: (c0, 16.374000ns)
signal T17_h :  std_logic_vector(19 downto 0);
   -- timing of T17_h: (c0, 17.564000ns)
signal T16 :  std_logic_vector(26 downto 0);
   -- timing of T16: (c0, 17.564000ns)
signal S15 :  std_logic_vector(16 downto 0);
   -- timing of S15: (c0, 16.374000ns)
signal d16 :  std_logic;
   -- timing of d16: (c0, 17.564000ns)
signal T16s :  std_logic_vector(27 downto 0);
   -- timing of T16s: (c0, 17.564000ns)
signal T16s_h :  std_logic_vector(20 downto 0);
   -- timing of T16s_h: (c0, 17.564000ns)
signal T16s_l :  std_logic_vector(6 downto 0);
   -- timing of T16s_l: (c0, 17.564000ns)
signal U16 :  std_logic_vector(20 downto 0);
   -- timing of U16: (c0, 17.564000ns)
signal T18_h :  std_logic_vector(20 downto 0);
   -- timing of T18_h: (c0, 18.754000ns)
signal T17 :  std_logic_vector(26 downto 0);
   -- timing of T17: (c0, 18.754000ns)
signal S16 :  std_logic_vector(17 downto 0);
   -- timing of S16: (c0, 17.564000ns)
signal d17 :  std_logic;
   -- timing of d17: (c0, 18.754000ns)
signal T17s :  std_logic_vector(27 downto 0);
   -- timing of T17s: (c0, 18.754000ns)
signal T17s_h :  std_logic_vector(21 downto 0);
   -- timing of T17s_h: (c0, 18.754000ns)
signal T17s_l :  std_logic_vector(5 downto 0);
   -- timing of T17s_l: (c0, 18.754000ns)
signal U17 :  std_logic_vector(21 downto 0);
   -- timing of U17: (c0, 18.754000ns)
signal T19_h :  std_logic_vector(21 downto 0);
   -- timing of T19_h: (c0, 19.944000ns)
signal T18 :  std_logic_vector(26 downto 0);
   -- timing of T18: (c0, 19.944000ns)
signal S17 :  std_logic_vector(18 downto 0);
   -- timing of S17: (c0, 18.754000ns)
signal d18 :  std_logic;
   -- timing of d18: (c0, 19.944000ns)
signal T18s :  std_logic_vector(27 downto 0);
   -- timing of T18s: (c0, 19.944000ns)
signal T18s_h :  std_logic_vector(22 downto 0);
   -- timing of T18s_h: (c0, 19.944000ns)
signal T18s_l :  std_logic_vector(4 downto 0);
   -- timing of T18s_l: (c0, 19.944000ns)
signal U18 :  std_logic_vector(22 downto 0);
   -- timing of U18: (c0, 19.944000ns)
signal T20_h :  std_logic_vector(22 downto 0);
   -- timing of T20_h: (c0, 21.183000ns)
signal T19 :  std_logic_vector(26 downto 0);
   -- timing of T19: (c0, 21.183000ns)
signal S18 :  std_logic_vector(19 downto 0);
   -- timing of S18: (c0, 19.944000ns)
signal d19 :  std_logic;
   -- timing of d19: (c0, 21.183000ns)
signal T19s :  std_logic_vector(27 downto 0);
   -- timing of T19s: (c0, 21.183000ns)
signal T19s_h :  std_logic_vector(23 downto 0);
   -- timing of T19s_h: (c0, 21.183000ns)
signal T19s_l :  std_logic_vector(3 downto 0);
   -- timing of T19s_l: (c0, 21.183000ns)
signal U19 :  std_logic_vector(23 downto 0);
   -- timing of U19: (c0, 21.183000ns)
signal T21_h :  std_logic_vector(23 downto 0);
   -- timing of T21_h: (c0, 22.422000ns)
signal T20 :  std_logic_vector(26 downto 0);
   -- timing of T20: (c0, 22.422000ns)
signal S19 :  std_logic_vector(20 downto 0);
   -- timing of S19: (c0, 21.183000ns)
signal d20 :  std_logic;
   -- timing of d20: (c0, 22.422000ns)
signal T20s :  std_logic_vector(27 downto 0);
   -- timing of T20s: (c0, 22.422000ns)
signal T20s_h :  std_logic_vector(24 downto 0);
   -- timing of T20s_h: (c0, 22.422000ns)
signal T20s_l :  std_logic_vector(2 downto 0);
   -- timing of T20s_l: (c0, 22.422000ns)
signal U20 :  std_logic_vector(24 downto 0);
   -- timing of U20: (c0, 22.422000ns)
signal T22_h :  std_logic_vector(24 downto 0);
   -- timing of T22_h: (c0, 23.661000ns)
signal T21 :  std_logic_vector(26 downto 0);
   -- timing of T21: (c0, 23.661000ns)
signal S20 :  std_logic_vector(21 downto 0);
   -- timing of S20: (c0, 22.422000ns)
signal d21 :  std_logic;
   -- timing of d21: (c0, 23.661000ns)
signal T21s :  std_logic_vector(27 downto 0);
   -- timing of T21s: (c0, 23.661000ns)
signal T21s_h :  std_logic_vector(25 downto 0);
   -- timing of T21s_h: (c0, 23.661000ns)
signal T21s_l :  std_logic_vector(1 downto 0);
   -- timing of T21s_l: (c0, 23.661000ns)
signal U21 :  std_logic_vector(25 downto 0);
   -- timing of U21: (c0, 23.661000ns)
signal T23_h :  std_logic_vector(25 downto 0);
   -- timing of T23_h: (c0, 24.900000ns)
signal T22 :  std_logic_vector(26 downto 0);
   -- timing of T22: (c0, 24.900000ns)
signal S21 :  std_logic_vector(22 downto 0);
   -- timing of S21: (c0, 23.661000ns)
signal d22 :  std_logic;
   -- timing of d22: (c0, 24.900000ns)
signal T22s :  std_logic_vector(27 downto 0);
   -- timing of T22s: (c0, 24.900000ns)
signal T22s_h :  std_logic_vector(26 downto 0);
   -- timing of T22s_h: (c0, 24.900000ns)
signal T22s_l :  std_logic_vector(0 downto 0);
   -- timing of T22s_l: (c0, 24.900000ns)
signal U22 :  std_logic_vector(26 downto 0);
   -- timing of U22: (c0, 24.900000ns)
signal T24_h :  std_logic_vector(26 downto 0);
   -- timing of T24_h: (c0, 26.188000ns)
signal T23 :  std_logic_vector(26 downto 0);
   -- timing of T23: (c0, 26.188000ns)
signal S22 :  std_logic_vector(23 downto 0);
   -- timing of S22: (c0, 24.900000ns)
signal d23 :  std_logic;
   -- timing of d23: (c0, 26.188000ns)
signal T23s :  std_logic_vector(27 downto 0);
   -- timing of T23s: (c0, 26.188000ns)
signal T23s_h :  std_logic_vector(27 downto 0);
   -- timing of T23s_h: (c0, 26.188000ns)
signal U23 :  std_logic_vector(27 downto 0);
   -- timing of U23: (c0, 26.188000ns)
signal T25_h :  std_logic_vector(27 downto 0);
   -- timing of T25_h: (c0, 27.476000ns)
signal T24 :  std_logic_vector(26 downto 0);
   -- timing of T24: (c0, 27.476000ns)
signal S23 :  std_logic_vector(24 downto 0);
   -- timing of S23: (c0, 26.188000ns)
signal d25 :  std_logic;
   -- timing of d25: (c0, 27.476000ns)
signal mR :  std_logic_vector(25 downto 0);
   -- timing of mR: (c0, 27.476000ns)
signal fR :  std_logic_vector(22 downto 0);
   -- timing of fR: (c0, 27.476000ns)
signal round :  std_logic;
   -- timing of round: (c0, 27.476000ns)
signal fRrnd :  std_logic_vector(22 downto 0);
   -- timing of fRrnd: (c0, 28.715000ns)
signal Rn2 :  std_logic_vector(30 downto 0);
   -- timing of Rn2: (c0, 28.715000ns)
signal xsR :  std_logic_vector(2 downto 0);
   -- timing of xsR: (c0, 0.043000ns)
begin
   fracX <= X(22 downto 0); -- fraction
   eRn0 <= "0" & X(30 downto 24); -- exponent 最上位切り捨てなので　/2をしている
   xsX <= X(33 downto 31); -- exception and sign
   eRn1 <= eRn0 + ("00" & (5 downto 0 => '1')) + X(23); --63のバイアスを足す。奇数の場合X(23)の場合はさらに1足して偶数にする X(23)は指数のLSB
   fracXnorm <= "1" & fracX & "000" when X(23) = '0' else --27bit 左詰めで1.11みたいな形　最初は暗黙の1 
         "01" & fracX&"00"; -- pre-normalization　eRn1で奇数の場合は1つ桁を挙げたから0.1的な形になってる
   S0 <= "01"; --2bit
   T1 <= ("0111" + fracXnorm(26 downto 23)) & fracXnorm(22 downto 0); --27bit
   -- now implementing the recurrence 
   --  this is a binary non-restoring algorithm, see ASA book
   -- Step 2
   d1 <= not T1(26); -- MSB. fracの上位4bitが9(1001)以上だと上位四ビットは0111の加算でオーバーフローするので、T1(26)が0になる。つまり、引く必要がある
   T1s <= T1 & "0"; --28bit
   T1s_h <= T1s(27 downto 22); --大きい部分6bit
   T1s_l <= T1s(21 downto 0); -- 小さい部分
   S1 <= S0 & d1;
   U1 <=  "0" & S1 & (not d1) & "1"; -- 6bit  S0 & d1がSi,  not d1 & 1 がUiに相当
   T3_h <=   T1s_h - U1 when d1='1'
        else T1s_h + U1; -- dが0は前の結果Tがマイナスの時。だから次は足す。最初のstepにおいては、オーバーフローしてその桁は結果を0にする
   T2 <= T3_h(4 downto 0) & T1s_l; -- 絶対値の部分5bitがT2

   -- Step 3
   d2 <= not T2(26); --  bit of weight -2　T2が負の時にd2は0 2つ上にも書いてる
   T2s <= T2 & "0"; -- 28bit
   T2s_h <= T2s(27 downto 21); --7bit
   T2s_l <= T2s(20 downto 0);
   S2 <= S1 & d2; -- here -1 becomes 0 and 1 becomes 1
   U2 <=  "0" & S2 & (not d2) & "1";  --7bit
   T4_h <=   T2s_h - U2 when d2='1' -- d2が+の場合
        else T2s_h + U2;
   T3 <= T4_h(5 downto 0) & T2s_l;

   -- Step 4
   d3 <= not T3(26); --  bit of weight -3
   T3s <= T3 & "0";
   T3s_h <= T3s(27 downto 20);
   T3s_l <= T3s(19 downto 0);
   S3 <= S2 & d3; -- here -1 becomes 0 and 1 becomes 1
   U3 <=  "0" & S3 & (not d3) & "1"; 
   T5_h <=   T3s_h - U3 when d3='1'
        else T3s_h + U3;
   T4 <= T5_h(6 downto 0) & T3s_l;
   -- Step 5
   d4 <= not T4(26); --  bit of weight -4
   T4s <= T4 & "0";
   T4s_h <= T4s(27 downto 19);
   T4s_l <= T4s(18 downto 0);
   S4 <= S3 & d4; -- here -1 becomes 0 and 1 becomes 1
   U4 <=  "0" & S4 & (not d4) & "1"; 
   T6_h <=   T4s_h - U4 when d4='1'
        else T4s_h + U4;
   T5 <= T6_h(7 downto 0) & T4s_l;
   -- Step 6
   d5 <= not T5(26); --  bit of weight -5
   T5s <= T5 & "0";
   T5s_h <= T5s(27 downto 18);
   T5s_l <= T5s(17 downto 0);
   S5 <= S4 & d5; -- here -1 becomes 0 and 1 becomes 1
   U5 <=  "0" & S5 & (not d5) & "1"; 
   T7_h <=   T5s_h - U5 when d5='1'
        else T5s_h + U5;
   T6 <= T7_h(8 downto 0) & T5s_l;
   -- Step 7
   d6 <= not T6(26); --  bit of weight -6
   T6s <= T6 & "0";
   T6s_h <= T6s(27 downto 17);
   T6s_l <= T6s(16 downto 0);
   S6 <= S5 & d6; -- here -1 becomes 0 and 1 becomes 1
   U6 <=  "0" & S6 & (not d6) & "1"; 
   T8_h <=   T6s_h - U6 when d6='1'
        else T6s_h + U6;
   T7 <= T8_h(9 downto 0) & T6s_l;
   -- Step 8
   d7 <= not T7(26); --  bit of weight -7
   T7s <= T7 & "0";
   T7s_h <= T7s(27 downto 16);
   T7s_l <= T7s(15 downto 0);
   S7 <= S6 & d7; -- here -1 becomes 0 and 1 becomes 1
   U7 <=  "0" & S7 & (not d7) & "1"; 
   T9_h <=   T7s_h - U7 when d7='1'
        else T7s_h + U7;
   T8 <= T9_h(10 downto 0) & T7s_l;
   -- Step 9
   d8 <= not T8(26); --  bit of weight -8　オーバーフローしてないときのflag 前の計算が正なら　１
   T8s <= T8 & "0";
   T8s_h <= T8s(27 downto 15);
   T8s_l <= T8s(14 downto 0);
   S8 <= S7 & d8; -- here -1 becomes 0 and 1 becomes 1
   U8 <=  "0" & S8 & (not d8) & "1"; 
   T10_h <=   T8s_h - U8 when d8='1'
        else T8s_h + U8;
   T9 <= T10_h(11 downto 0) & T8s_l;
   -- Step 10
   d9 <= not T9(26); --  bit of weight -9
   T9s <= T9 & "0";
   T9s_h <= T9s(27 downto 14);
   T9s_l <= T9s(13 downto 0);
   S9 <= S8 & d9; -- here -1 becomes 0 and 1 becomes 1
   U9 <=  "0" & S9 & (not d9) & "1"; 
   T11_h <=   T9s_h - U9 when d9='1'
        else T9s_h + U9;
   T10 <= T11_h(12 downto 0) & T9s_l;
   -- Step 11
   d10 <= not T10(26); --  bit of weight -10
   T10s <= T10 & "0";
   T10s_h <= T10s(27 downto 13);
   T10s_l <= T10s(12 downto 0);
   S10 <= S9 & d10; -- here -1 becomes 0 and 1 becomes 1
   U10 <=  "0" & S10 & (not d10) & "1"; 
   T12_h <=   T10s_h - U10 when d10='1'
        else T10s_h + U10;
   T11 <= T12_h(13 downto 0) & T10s_l;
   -- Step 12
   d11 <= not T11(26); --  bit of weight -11
   T11s <= T11 & "0";
   T11s_h <= T11s(27 downto 12);
   T11s_l <= T11s(11 downto 0);
   S11 <= S10 & d11; -- here -1 becomes 0 and 1 becomes 1
   U11 <=  "0" & S11 & (not d11) & "1"; 
   T13_h <=   T11s_h - U11 when d11='1'
        else T11s_h + U11;
   T12 <= T13_h(14 downto 0) & T11s_l;
   -- Step 13
   d12 <= not T12(26); --  bit of weight -12
   T12s <= T12 & "0";
   T12s_h <= T12s(27 downto 11);
   T12s_l <= T12s(10 downto 0);
   S12 <= S11 & d12; -- here -1 becomes 0 and 1 becomes 1
   U12 <=  "0" & S12 & (not d12) & "1"; 
   T14_h <=   T12s_h - U12 when d12='1'
        else T12s_h + U12;
   T13 <= T14_h(15 downto 0) & T12s_l;
   -- Step 14
   d13 <= not T13(26); --  bit of weight -13
   T13s <= T13 & "0";
   T13s_h <= T13s(27 downto 10);
   T13s_l <= T13s(9 downto 0);
   S13 <= S12 & d13; -- here -1 becomes 0 and 1 becomes 1
   U13 <=  "0" & S13 & (not d13) & "1"; 
   T15_h <=   T13s_h - U13 when d13='1'
        else T13s_h + U13;
   T14 <= T15_h(16 downto 0) & T13s_l;
   -- Step 15
   d14 <= not T14(26); --  bit of weight -14
   T14s <= T14 & "0";
   T14s_h <= T14s(27 downto 9);
   T14s_l <= T14s(8 downto 0);
   S14 <= S13 & d14; -- here -1 becomes 0 and 1 becomes 1
   U14 <=  "0" & S14 & (not d14) & "1"; 
   T16_h <=   T14s_h - U14 when d14='1'
        else T14s_h + U14;
   T15 <= T16_h(17 downto 0) & T14s_l;
   -- Step 16
   d15 <= not T15(26); --  bit of weight -15
   T15s <= T15 & "0";
   T15s_h <= T15s(27 downto 8);
   T15s_l <= T15s(7 downto 0);
   S15 <= S14 & d15; -- here -1 becomes 0 and 1 becomes 1
   U15 <=  "0" & S15 & (not d15) & "1"; 
   T17_h <=   T15s_h - U15 when d15='1'
        else T15s_h + U15;
   T16 <= T17_h(18 downto 0) & T15s_l;
   -- Step 17
   d16 <= not T16(26); --  bit of weight -16
   T16s <= T16 & "0";
   T16s_h <= T16s(27 downto 7);
   T16s_l <= T16s(6 downto 0);
   S16 <= S15 & d16; -- here -1 becomes 0 and 1 becomes 1
   U16 <=  "0" & S16 & (not d16) & "1"; 
   T18_h <=   T16s_h - U16 when d16='1'
        else T16s_h + U16;
   T17 <= T18_h(19 downto 0) & T16s_l;
   -- Step 18
   d17 <= not T17(26); --  bit of weight -17
   T17s <= T17 & "0";
   T17s_h <= T17s(27 downto 6);
   T17s_l <= T17s(5 downto 0);
   S17 <= S16 & d17; -- here -1 becomes 0 and 1 becomes 1
   U17 <=  "0" & S17 & (not d17) & "1"; 
   T19_h <=   T17s_h - U17 when d17='1'
        else T17s_h + U17;
   T18 <= T19_h(20 downto 0) & T17s_l;
   -- Step 19
   d18 <= not T18(26); --  bit of weight -18
   T18s <= T18 & "0";
   T18s_h <= T18s(27 downto 5);
   T18s_l <= T18s(4 downto 0);
   S18 <= S17 & d18; -- here -1 becomes 0 and 1 becomes 1
   U18 <=  "0" & S18 & (not d18) & "1"; 
   T20_h <=   T18s_h - U18 when d18='1'
        else T18s_h + U18;
   T19 <= T20_h(21 downto 0) & T18s_l;
   -- Step 20
   d19 <= not T19(26); --  bit of weight -19
   T19s <= T19 & "0";
   T19s_h <= T19s(27 downto 4);
   T19s_l <= T19s(3 downto 0);
   S19 <= S18 & d19; -- here -1 becomes 0 and 1 becomes 1
   U19 <=  "0" & S19 & (not d19) & "1"; 
   T21_h <=   T19s_h - U19 when d19='1'
        else T19s_h + U19;
   T20 <= T21_h(22 downto 0) & T19s_l;
   -- Step 21
   d20 <= not T20(26); --  bit of weight -20
   T20s <= T20 & "0";
   T20s_h <= T20s(27 downto 3);
   T20s_l <= T20s(2 downto 0);
   S20 <= S19 & d20; -- here -1 becomes 0 and 1 becomes 1
   U20 <=  "0" & S20 & (not d20) & "1"; 
   T22_h <=   T20s_h - U20 when d20='1'
        else T20s_h + U20;
   T21 <= T22_h(23 downto 0) & T20s_l;
   -- Step 22
   d21 <= not T21(26); --  bit of weight -21
   T21s <= T21 & "0";
   T21s_h <= T21s(27 downto 2);
   T21s_l <= T21s(1 downto 0);
   S21 <= S20 & d21; -- here -1 becomes 0 and 1 becomes 1
   U21 <=  "0" & S21 & (not d21) & "1"; 
   T23_h <=   T21s_h - U21 when d21='1'
        else T21s_h + U21;
   T22 <= T23_h(24 downto 0) & T21s_l;
   -- Step 23
   d22 <= not T22(26); --  bit of weight -22
   T22s <= T22 & "0";
   T22s_h <= T22s(27 downto 1);
   T22s_l <= T22s(0 downto 0);
   S22 <= S21 & d22; -- here -1 becomes 0 and 1 becomes 1
   U22 <=  "0" & S22 & (not d22) & "1"; 
   T24_h <=   T22s_h - U22 when d22='1'
        else T22s_h + U22;
   T23 <= T24_h(25 downto 0) & T22s_l;
   -- Step 24
   d23 <= not T23(26); --  bit of weight -23
   T23s <= T23 & "0";
   T23s_h <= T23s(27 downto 0);
   S23 <= S22 & d23; -- here -1 becomes 0 and 1 becomes 1
   U23 <=  "0" & S23 & (not d23) & "1"; 
   T25_h <=   T23s_h - U23 when d23='1'
        else T23s_h + U23;
   T24 <= T25_h(26 downto 0);
   d25 <= not T24(26) ; -- the sign of the remainder will become the round bit
   mR <= S23 & d25; -- result significand
   fR <= mR(23 downto 1);-- removing leading 1
   round <= mR(0); -- round bit
   fRrnd <= fR + ((22 downto 1 => '0') & round); -- rounding sqrt never changes exponents 
   Rn2 <= eRn1 & fRrnd; -- (x +127) /2 = x/2 -127 +63.5 つまり、x/2+63.5が下駄状態なので、そのまま返して良い
   -- sign and exception processing
   with xsX  select 
      xsR <= "010"  when "010",  -- normal case
             "100"  when "100",  -- +infty
             "000"  when "000",  -- +0
             "001"  when "001",  -- the infamous sqrt(-0)=-0
             "110"  when others; -- return NaN
   R <= xsR & Rn2; 
end architecture;

