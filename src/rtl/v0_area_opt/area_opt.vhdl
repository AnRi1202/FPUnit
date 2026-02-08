--------------------------------------------------------------------------------
--                           FPALL_combine
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Maxime Christ, Florent de Dinechin (2015)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity area_opt is
    port (
        clk : in std_logic;
        opcode : in std_logic_vector(1 downto 0); -- 00: Add, 01: Mul, 10: Sqrt, 11: Div
        X : in std_logic_vector(31 downto 0);
        Y : in std_logic_vector(31 downto 0);
        R : out std_logic_vector(31 downto 0)
    );
end entity;

architecture arch of area_opt is
 -- FPAdd --
   component RightShifterSticky24_by_max_26_Freq1_uid4 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             S : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(25 downto 0);
             Sticky : out  std_logic   );
   end component;

   -- IntAdder_27_Freq1_uid6 is now shared in FPALL_Shared

   component Normalizer_Z_28_28_28_Freq1_uid8 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(27 downto 0);
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(27 downto 0)   );
   end component;

   -- FPMul --
   component IntMultiplier_24x24_48_Freq1_uid5 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;
   -- FPDiv --
   component selFunction_Freq1_uid4 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : out  std_logic_vector(2 downto 0)   );
   end component;

    
    component IntAdder_27_Freq1_uid6 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(26 downto 0);
              Y : in  std_logic_vector(26 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(26 downto 0)   );
    end component;

-- FPAdd --

signal swap :  std_logic;
signal expDiff :  std_logic_vector(7 downto 0);
signal newX :  std_logic_vector(31 downto 0);
signal newY :  std_logic_vector(31 downto 0);
signal add_expX :  std_logic_vector(7 downto 0);
signal signX :  std_logic;
signal signY :  std_logic;
signal EffSub :  std_logic;
signal fracY :  std_logic_vector(23 downto 0);
signal shiftedOut :  std_logic;
signal shiftVal :  std_logic_vector(4 downto 0);
signal shiftedFracY :  std_logic_vector(25 downto 0);
signal add_sticky :  std_logic;
signal fracYpad :  std_logic_vector(26 downto 0);
signal EffSubVector :  std_logic_vector(26 downto 0);
signal fracYpadXorOp :  std_logic_vector(26 downto 0);
signal fracXpad :  std_logic_vector(26 downto 0);
signal cInSigAdd :  std_logic;
signal fracAddResult :  std_logic_vector(26 downto 0);
signal fracSticky :  std_logic_vector(27 downto 0);
signal nZerosNew :  std_logic_vector(4 downto 0);
signal shiftedFrac :  std_logic_vector(27 downto 0);
signal extendedExpInc :  std_logic_vector(8 downto 0);
signal updatedExp :  std_logic_vector(8 downto 0);

signal stk :  std_logic;
signal rnd :  std_logic;
signal lsb :  std_logic;
signal RoundedExpFrac :  std_logic_vector(32 downto 0);
signal fracR :  std_logic_vector(22 downto 0);
signal expR :  std_logic_vector(7 downto 0);

-- FPMul --

signal sign :  std_logic;
signal mul_expX :  std_logic_vector(7 downto 0);
signal expY :  std_logic_vector(7 downto 0);
signal expSumPreSub :  std_logic_vector(9 downto 0);
signal bias :  std_logic_vector(9 downto 0);
signal expSum :  std_logic_vector(9 downto 0);
signal sigX :  std_logic_vector(23 downto 0);
signal sigY :  std_logic_vector(23 downto 0);
signal sigProd :  std_logic_vector(47 downto 0);
   signal norm :  std_logic;
   signal expPostNorm :  std_logic_vector(9 downto 0);
   signal sigProdExt :  std_logic_vector(47 downto 0);
   signal expSig :  std_logic_vector(32 downto 0);
   signal mul_guard_bit :  std_logic;
   signal mul_sticky :  std_logic;
   signal mul_lsb :  std_logic;
   signal expSigPostRound :  std_logic_vector(30 downto 0);

-- FPDiv --
signal fX :  std_logic_vector(23 downto 0);
signal fY :  std_logic_vector(23 downto 0);
signal expR0 :  std_logic_vector(9 downto 0);
signal sR :  std_logic;
signal D :  std_logic_vector(23 downto 0);
signal psX :  std_logic_vector(24 downto 0);
signal betaw14 :  std_logic_vector(26 downto 0);
signal sel14 :  std_logic_vector(8 downto 0);
signal q14 :  std_logic_vector(2 downto 0);
signal q14_copy5 :  std_logic_vector(2 downto 0);
signal absq14D :  std_logic_vector(26 downto 0);
signal w13 :  std_logic_vector(26 downto 0);
signal betaw13 :  std_logic_vector(26 downto 0);
signal sel13 :  std_logic_vector(8 downto 0);
signal q13 :  std_logic_vector(2 downto 0);
signal q13_copy6 :  std_logic_vector(2 downto 0);
signal absq13D :  std_logic_vector(26 downto 0);
signal w12 :  std_logic_vector(26 downto 0);
signal betaw12 :  std_logic_vector(26 downto 0);
signal sel12 :  std_logic_vector(8 downto 0);
signal q12 :  std_logic_vector(2 downto 0);
signal q12_copy7 :  std_logic_vector(2 downto 0);
signal absq12D :  std_logic_vector(26 downto 0);
signal w11 :  std_logic_vector(26 downto 0);
signal betaw11 :  std_logic_vector(26 downto 0);
signal sel11 :  std_logic_vector(8 downto 0);
signal q11 :  std_logic_vector(2 downto 0);
signal q11_copy8 :  std_logic_vector(2 downto 0);
signal absq11D :  std_logic_vector(26 downto 0);
signal w10 :  std_logic_vector(26 downto 0);
signal betaw10 :  std_logic_vector(26 downto 0);
signal sel10 :  std_logic_vector(8 downto 0);
signal q10 :  std_logic_vector(2 downto 0);
signal q10_copy9 :  std_logic_vector(2 downto 0);
signal absq10D :  std_logic_vector(26 downto 0);
signal w9 :  std_logic_vector(26 downto 0);
signal betaw9 :  std_logic_vector(26 downto 0);
signal sel9 :  std_logic_vector(8 downto 0);
signal q9 :  std_logic_vector(2 downto 0);
signal q9_copy10 :  std_logic_vector(2 downto 0);
signal absq9D :  std_logic_vector(26 downto 0);
signal w8 :  std_logic_vector(26 downto 0);
signal betaw8 :  std_logic_vector(26 downto 0);
signal sel8 :  std_logic_vector(8 downto 0);
signal q8 :  std_logic_vector(2 downto 0);
signal q8_copy11 :  std_logic_vector(2 downto 0);
signal absq8D :  std_logic_vector(26 downto 0);
signal w7 :  std_logic_vector(26 downto 0);
signal betaw7 :  std_logic_vector(26 downto 0);
signal sel7 :  std_logic_vector(8 downto 0);
signal q7 :  std_logic_vector(2 downto 0);
signal q7_copy12 :  std_logic_vector(2 downto 0);
signal absq7D :  std_logic_vector(26 downto 0);
signal w6 :  std_logic_vector(26 downto 0);
signal betaw6 :  std_logic_vector(26 downto 0);
signal sel6 :  std_logic_vector(8 downto 0);
signal q6 :  std_logic_vector(2 downto 0);
signal q6_copy13 :  std_logic_vector(2 downto 0);
signal absq6D :  std_logic_vector(26 downto 0);
signal w5 :  std_logic_vector(26 downto 0);
signal betaw5 :  std_logic_vector(26 downto 0);
signal sel5 :  std_logic_vector(8 downto 0);
signal q5 :  std_logic_vector(2 downto 0);
signal q5_copy14 :  std_logic_vector(2 downto 0);
signal absq5D :  std_logic_vector(26 downto 0);
signal w4 :  std_logic_vector(26 downto 0);
signal betaw4 :  std_logic_vector(26 downto 0);
signal sel4 :  std_logic_vector(8 downto 0);
signal q4 :  std_logic_vector(2 downto 0);
signal q4_copy15 :  std_logic_vector(2 downto 0);
signal absq4D :  std_logic_vector(26 downto 0);
signal w3 :  std_logic_vector(26 downto 0);
signal betaw3 :  std_logic_vector(26 downto 0);
signal sel3 :  std_logic_vector(8 downto 0);
signal q3 :  std_logic_vector(2 downto 0);
signal q3_copy16 :  std_logic_vector(2 downto 0);
signal absq3D :  std_logic_vector(26 downto 0);
signal w2 :  std_logic_vector(26 downto 0);
signal betaw2 :  std_logic_vector(26 downto 0);
signal sel2 :  std_logic_vector(8 downto 0);
signal q2 :  std_logic_vector(2 downto 0);
signal q2_copy17 :  std_logic_vector(2 downto 0);
signal absq2D :  std_logic_vector(26 downto 0);
signal w1 :  std_logic_vector(26 downto 0);
signal betaw1 :  std_logic_vector(26 downto 0);
signal sel1 :  std_logic_vector(8 downto 0);
signal q1 :  std_logic_vector(2 downto 0);
signal q1_copy18 :  std_logic_vector(2 downto 0);
signal absq1D :  std_logic_vector(26 downto 0);
signal w0 :  std_logic_vector(26 downto 0);
signal wfinal :  std_logic_vector(24 downto 0);
signal qM0 :  std_logic;
signal qP14 :  std_logic_vector(1 downto 0);
signal qM14 :  std_logic_vector(1 downto 0);
signal qP13 :  std_logic_vector(1 downto 0);
signal qM13 :  std_logic_vector(1 downto 0);
signal qP12 :  std_logic_vector(1 downto 0);
signal qM12 :  std_logic_vector(1 downto 0);
signal qP11 :  std_logic_vector(1 downto 0);
signal qM11 :  std_logic_vector(1 downto 0);
signal qP10 :  std_logic_vector(1 downto 0);
signal qM10 :  std_logic_vector(1 downto 0);
signal qP9 :  std_logic_vector(1 downto 0);
signal qM9 :  std_logic_vector(1 downto 0);
signal qP8 :  std_logic_vector(1 downto 0);
signal qM8 :  std_logic_vector(1 downto 0);
signal qP7 :  std_logic_vector(1 downto 0);
signal qM7 :  std_logic_vector(1 downto 0);
signal qP6 :  std_logic_vector(1 downto 0);
signal qM6 :  std_logic_vector(1 downto 0);
signal qP5 :  std_logic_vector(1 downto 0);
signal qM5 :  std_logic_vector(1 downto 0);
signal qP4 :  std_logic_vector(1 downto 0);
signal qM4 :  std_logic_vector(1 downto 0);
signal qP3 :  std_logic_vector(1 downto 0);
signal qM3 :  std_logic_vector(1 downto 0);
signal qP2 :  std_logic_vector(1 downto 0);
signal qM2 :  std_logic_vector(1 downto 0);
signal qP1 :  std_logic_vector(1 downto 0);
signal qM1 :  std_logic_vector(1 downto 0);
signal qP :  std_logic_vector(27 downto 0);
signal qM :  std_logic_vector(27 downto 0);
signal quotient :  std_logic_vector(27 downto 0);
signal div_mR :  std_logic_vector(25 downto 0);
signal fRnorm :  std_logic_vector(23 downto 0);
signal expR1 :  std_logic_vector(9 downto 0);
signal expfracR :  std_logic_vector(32 downto 0);



-- FPSqrt signals
signal fracX :  std_logic_vector(22 downto 0);
signal eRn0 :  std_logic_vector(7 downto 0);
signal eRn1 :  std_logic_vector(7 downto 0);
signal fracXnorm :  std_logic_vector(26 downto 0);
signal S0 :  std_logic_vector(1 downto 0);
signal T1 :  std_logic_vector(26 downto 0);
signal d1 :  std_logic;
signal T1s :  std_logic_vector(27 downto 0);
signal T1s_h :  std_logic_vector(5 downto 0);
signal T1s_l :  std_logic_vector(21 downto 0);
signal U1 :  std_logic_vector(5 downto 0);
signal T3_h :  std_logic_vector(5 downto 0);
signal T2 :  std_logic_vector(26 downto 0);
signal S1 :  std_logic_vector(2 downto 0);
signal d2 :  std_logic;
signal T2s :  std_logic_vector(27 downto 0);
signal T2s_h :  std_logic_vector(6 downto 0);
signal T2s_l :  std_logic_vector(20 downto 0);
signal U2 :  std_logic_vector(6 downto 0);
signal T4_h :  std_logic_vector(6 downto 0);
signal T3 :  std_logic_vector(26 downto 0);
signal S2 :  std_logic_vector(3 downto 0);
signal d3 :  std_logic;
signal T3s :  std_logic_vector(27 downto 0);
signal T3s_h :  std_logic_vector(7 downto 0);
signal T3s_l :  std_logic_vector(19 downto 0);
signal U3 :  std_logic_vector(7 downto 0);
signal T5_h :  std_logic_vector(7 downto 0);
signal T4 :  std_logic_vector(26 downto 0);
signal S3 :  std_logic_vector(4 downto 0);
signal d4 :  std_logic;
signal T4s :  std_logic_vector(27 downto 0);
signal T4s_h :  std_logic_vector(8 downto 0);
signal T4s_l :  std_logic_vector(18 downto 0);
signal U4 :  std_logic_vector(8 downto 0);
signal T6_h :  std_logic_vector(8 downto 0);
signal T5 :  std_logic_vector(26 downto 0);
signal S4 :  std_logic_vector(5 downto 0);
signal d5 :  std_logic;
signal T5s :  std_logic_vector(27 downto 0);
signal T5s_h :  std_logic_vector(9 downto 0);
signal T5s_l :  std_logic_vector(17 downto 0);
signal U5 :  std_logic_vector(9 downto 0);
signal T7_h :  std_logic_vector(9 downto 0);
signal T6 :  std_logic_vector(26 downto 0);
signal S5 :  std_logic_vector(6 downto 0);
signal d6 :  std_logic;
signal T6s :  std_logic_vector(27 downto 0);
signal T6s_h :  std_logic_vector(10 downto 0);
signal T6s_l :  std_logic_vector(16 downto 0);
signal U6 :  std_logic_vector(10 downto 0);
signal T8_h :  std_logic_vector(10 downto 0);
signal T7 :  std_logic_vector(26 downto 0);
signal S6 :  std_logic_vector(7 downto 0);
signal d7 :  std_logic;
signal T7s :  std_logic_vector(27 downto 0);
signal T7s_h :  std_logic_vector(11 downto 0);
signal T7s_l :  std_logic_vector(15 downto 0);
signal U7 :  std_logic_vector(11 downto 0);
signal T9_h :  std_logic_vector(11 downto 0);
signal T8 :  std_logic_vector(26 downto 0);
signal S7 :  std_logic_vector(8 downto 0);
signal d8 :  std_logic;
signal T8s :  std_logic_vector(27 downto 0);
signal T8s_h :  std_logic_vector(12 downto 0);
signal T8s_l :  std_logic_vector(14 downto 0);
signal U8 :  std_logic_vector(12 downto 0);
signal T10_h :  std_logic_vector(12 downto 0);
signal T9 :  std_logic_vector(26 downto 0);
signal S8 :  std_logic_vector(9 downto 0);
signal d9 :  std_logic;
signal T9s :  std_logic_vector(27 downto 0);
signal T9s_h :  std_logic_vector(13 downto 0);
signal T9s_l :  std_logic_vector(13 downto 0);
signal U9 :  std_logic_vector(13 downto 0);
signal T11_h :  std_logic_vector(13 downto 0);
signal T10 :  std_logic_vector(26 downto 0);
signal S9 :  std_logic_vector(10 downto 0);
signal d10 :  std_logic;
signal T10s :  std_logic_vector(27 downto 0);
signal T10s_h :  std_logic_vector(14 downto 0);
signal T10s_l :  std_logic_vector(12 downto 0);
signal U10 :  std_logic_vector(14 downto 0);
signal T12_h :  std_logic_vector(14 downto 0);
signal T11 :  std_logic_vector(26 downto 0);
signal S10 :  std_logic_vector(11 downto 0);
signal d11 :  std_logic;
signal T11s :  std_logic_vector(27 downto 0);
signal T11s_h :  std_logic_vector(15 downto 0);
signal T11s_l :  std_logic_vector(11 downto 0);
signal U11 :  std_logic_vector(15 downto 0);
signal T13_h :  std_logic_vector(15 downto 0);
signal T12 :  std_logic_vector(26 downto 0);
signal S11 :  std_logic_vector(12 downto 0);
signal d12 :  std_logic;
signal T12s :  std_logic_vector(27 downto 0);
signal T12s_h :  std_logic_vector(16 downto 0);
signal T12s_l :  std_logic_vector(10 downto 0);
signal U12 :  std_logic_vector(16 downto 0);
signal T14_h :  std_logic_vector(16 downto 0);
signal T13 :  std_logic_vector(26 downto 0);
signal S12 :  std_logic_vector(13 downto 0);
signal d13 :  std_logic;
signal T13s :  std_logic_vector(27 downto 0);
signal T13s_h :  std_logic_vector(17 downto 0);
signal T13s_l :  std_logic_vector(9 downto 0);
signal U13 :  std_logic_vector(17 downto 0);
signal T15_h :  std_logic_vector(17 downto 0);
signal T14 :  std_logic_vector(26 downto 0);
signal S13 :  std_logic_vector(14 downto 0);
signal d14 :  std_logic;
signal T14s :  std_logic_vector(27 downto 0);
signal T14s_h :  std_logic_vector(18 downto 0);
signal T14s_l :  std_logic_vector(8 downto 0);
signal U14 :  std_logic_vector(18 downto 0);
signal T16_h :  std_logic_vector(18 downto 0);
signal T15 :  std_logic_vector(26 downto 0);
signal S14 :  std_logic_vector(15 downto 0);
signal d15 :  std_logic;
signal T15s :  std_logic_vector(27 downto 0);
signal T15s_h :  std_logic_vector(19 downto 0);
signal T15s_l :  std_logic_vector(7 downto 0);
signal U15 :  std_logic_vector(19 downto 0);
signal T17_h :  std_logic_vector(19 downto 0);
signal T16 :  std_logic_vector(26 downto 0);
signal S15 :  std_logic_vector(16 downto 0);
signal d16 :  std_logic;
signal T16s :  std_logic_vector(27 downto 0);
signal T16s_h :  std_logic_vector(20 downto 0);
signal T16s_l :  std_logic_vector(6 downto 0);
signal U16 :  std_logic_vector(20 downto 0);
signal T18_h :  std_logic_vector(20 downto 0);
signal T17 :  std_logic_vector(26 downto 0);
signal S16 :  std_logic_vector(17 downto 0);
signal d17 :  std_logic;
signal T17s :  std_logic_vector(27 downto 0);
signal T17s_h :  std_logic_vector(21 downto 0);
signal T17s_l :  std_logic_vector(5 downto 0);
signal U17 :  std_logic_vector(21 downto 0);
signal T19_h :  std_logic_vector(21 downto 0);
signal T18 :  std_logic_vector(26 downto 0);
signal S17 :  std_logic_vector(18 downto 0);
signal d18 :  std_logic;
signal T18s :  std_logic_vector(27 downto 0);
signal T18s_h :  std_logic_vector(22 downto 0);
signal T18s_l :  std_logic_vector(4 downto 0);
signal U18 :  std_logic_vector(22 downto 0);
signal T20_h :  std_logic_vector(22 downto 0);
signal T19 :  std_logic_vector(26 downto 0);
signal S18 :  std_logic_vector(19 downto 0);
signal d19 :  std_logic;
signal T19s :  std_logic_vector(27 downto 0);
signal T19s_h :  std_logic_vector(23 downto 0);
signal T19s_l :  std_logic_vector(3 downto 0);
signal U19 :  std_logic_vector(23 downto 0);
signal T21_h :  std_logic_vector(23 downto 0);
signal T20 :  std_logic_vector(26 downto 0);
signal S19 :  std_logic_vector(20 downto 0);
signal d20 :  std_logic;
signal T20s :  std_logic_vector(27 downto 0);
signal T20s_h :  std_logic_vector(24 downto 0);
signal T20s_l :  std_logic_vector(2 downto 0);
signal U20 :  std_logic_vector(24 downto 0);
signal T22_h :  std_logic_vector(24 downto 0);
signal T21 :  std_logic_vector(26 downto 0);
signal S20 :  std_logic_vector(21 downto 0);
signal d21 :  std_logic;
signal T21s :  std_logic_vector(27 downto 0);
signal T21s_h :  std_logic_vector(25 downto 0);
signal T21s_l :  std_logic_vector(1 downto 0);
signal U21 :  std_logic_vector(25 downto 0);
signal T23_h :  std_logic_vector(25 downto 0);
signal T22 :  std_logic_vector(26 downto 0);
signal S21 :  std_logic_vector(22 downto 0);
signal d22 :  std_logic;
signal T22s :  std_logic_vector(27 downto 0);
signal T22s_h :  std_logic_vector(26 downto 0);
signal T22s_l :  std_logic_vector(0 downto 0);
signal U22 :  std_logic_vector(26 downto 0);
signal T24_h :  std_logic_vector(26 downto 0);
signal T23 :  std_logic_vector(26 downto 0);
signal S22 :  std_logic_vector(23 downto 0);
signal d23 :  std_logic;
signal T23s :  std_logic_vector(27 downto 0);
signal T23s_h :  std_logic_vector(27 downto 0);
signal U23 :  std_logic_vector(27 downto 0);
signal T25_h :  std_logic_vector(27 downto 0);
signal T24 :  std_logic_vector(26 downto 0);
signal S23 :  std_logic_vector(24 downto 0);
signal d25 :  std_logic;
signal sqrt_mR :  std_logic_vector(25 downto 0);
signal fR :  std_logic_vector(22 downto 0);
signal fRrnd :  std_logic_vector(22 downto 0);
signal Rn2 :  std_logic_vector(30 downto 0);


-- FPShared --
    -- Add signals
    signal add_R : std_logic_vector(31 downto 0);
    signal add_expFrac : std_logic_vector(32 downto 0);
    signal add_round : std_logic;
    
    -- Mul signals
    signal mul_R : std_logic_vector(31 downto 0);
    signal mul_round : std_logic;

    -- Sqrt signals
    signal sqrt_R : std_logic_vector(31 downto 0);
    signal sqrt_expFrac : std_logic_vector(22 downto 0);
    signal sqrt_round : std_logic;

    -- Div signals
    signal div_R : std_logic_vector(31 downto 0);
    signal div_round : std_logic;
    
    -- Shared Adder signals
    signal ra_X : std_logic_vector(32 downto 0);
    signal ra_Cin : std_logic;
    signal ra_R : std_logic_vector(32 downto 0);
    
    -- Shared IntAdder_27 signals
    signal add_fracAdder_X : std_logic_vector(26 downto 0);
    signal add_fracAdder_Y : std_logic_vector(26 downto 0);
    signal add_fracAdder_Cin : std_logic;
    signal add_fracAdder_R : std_logic_vector(26 downto 0);
    
    signal mul_expAdder_X : std_logic_vector(7 downto 0);
    signal mul_expAdder_Y : std_logic_vector(7 downto 0);
    signal mul_expAdder_Cin : std_logic;
    signal mul_expAdder_R : std_logic_vector(8 downto 0);
    
    signal ia27_X : std_logic_vector(26 downto 0);
    signal ia27_Y : std_logic_vector(26 downto 0);
    signal ia27_Cin : std_logic;
    signal ia27_R : std_logic_vector(26 downto 0);

    -- Shared Add/Sub Gen 0 signals
    signal shared_as_x0 : std_logic_vector(27 downto 0);
    signal shared_as_y0 : std_logic_vector(27 downto 0);
    signal shared_as_sub0 : std_logic;
    signal shared_as_r0 : std_logic_vector(27 downto 0);
    signal sub_mask0 : std_logic_vector(27 downto 0);
    signal y_xor0 : std_logic_vector(27 downto 0);
    signal cin_vec0 : std_logic_vector(27 downto 0);

    -- Shared Add/Sub Gen 1 signals
    signal shared_as_x1 : std_logic_vector(26 downto 0);
    signal shared_as_y1 : std_logic_vector(26 downto 0);
    signal shared_as_sub1 : std_logic;
    signal shared_as_r1 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 2 signals
    signal shared_as_x2 : std_logic_vector(26 downto 0);
    signal shared_as_y2 : std_logic_vector(26 downto 0);
    signal shared_as_sub2 : std_logic;
    signal shared_as_r2 : std_logic_vector(26 downto 0);
      signal sub_mask2 : std_logic_vector(26 downto 0); 
      signal y_xor2 : std_logic_vector(26 downto 0); 
      signal cin_vec2 : std_logic_vector(26 downto 0);     
    -- Shared Add/Sub Gen 3 signals
    signal shared_as_x3 : std_logic_vector(26 downto 0);
    signal shared_as_y3 : std_logic_vector(26 downto 0);
    signal shared_as_sub3 : std_logic;
    signal shared_as_r3 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 4 signals
    signal shared_as_x4 : std_logic_vector(26 downto 0);
    signal shared_as_y4 : std_logic_vector(26 downto 0);
    signal shared_as_sub4 : std_logic;
    signal shared_as_r4 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 5 signals
    signal shared_as_x5 : std_logic_vector(26 downto 0);
    signal shared_as_y5 : std_logic_vector(26 downto 0);
    signal shared_as_sub5 : std_logic;
    signal shared_as_r5 : std_logic_vector(26 downto 0);

    -- Shared Add/Sub Gen 6 signals
    signal shared_as_x6 : std_logic_vector(26 downto 0);
    signal shared_as_y6 : std_logic_vector(26 downto 0);
    signal shared_as_sub6 : std_logic;
    signal shared_as_r6 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 7 signals
    signal shared_as_x7 : std_logic_vector(26 downto 0);
    signal shared_as_y7 : std_logic_vector(26 downto 0);
    signal shared_as_sub7 : std_logic;
    signal shared_as_r7 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 8 signals
    signal shared_as_x8 : std_logic_vector(26 downto 0);
    signal shared_as_y8 : std_logic_vector(26 downto 0);
    signal shared_as_sub8 : std_logic;
    signal shared_as_r8 : std_logic_vector(26 downto 0);

    -- Shared Add/Sub Gen 9 signals
    signal shared_as_x9 : std_logic_vector(26 downto 0);
    signal shared_as_y9 : std_logic_vector(26 downto 0);
    signal shared_as_sub9 : std_logic;
    signal shared_as_r9 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 10 signals
    signal shared_as_x10 : std_logic_vector(26 downto 0);
    signal shared_as_y10 : std_logic_vector(26 downto 0);
    signal shared_as_sub10 : std_logic;
    signal shared_as_r10 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 11 signals
    signal shared_as_x11 : std_logic_vector(26 downto 0);
    signal shared_as_y11 : std_logic_vector(26 downto 0);
    signal shared_as_sub11 : std_logic;
    signal shared_as_r11 : std_logic_vector(26 downto 0);
    
    -- Shared Add/Sub Gen 12 signals
    signal shared_as_x12 : std_logic_vector(26 downto 0);
    signal shared_as_y12 : std_logic_vector(26 downto 0);
    signal shared_as_sub12 : std_logic;
    signal shared_as_r12 : std_logic_vector(26 downto 0);

    -- Shared Add/Sub Gen 13 signals
    signal shared_as_x13 : std_logic_vector(26 downto 0);
    signal shared_as_y13 : std_logic_vector(26 downto 0);
    signal shared_as_sub13 : std_logic;
    signal shared_as_r13 : std_logic_vector(26 downto 0);
    signal sub_mask13 : std_logic_vector(26 downto 0); 
    signal y_xor13 : std_logic_vector(26 downto 0); 
    signal cin_vec13 : std_logic_vector(26 downto 0);



    signal add_ra_X : std_logic_vector(32 downto 0);
    signal mul_ra_X : std_logic_vector(32 downto 0);
    signal div_ra_X : std_logic_vector(32 downto 0);
    signal sqrt_ra_X : std_logic_vector(32 downto 0);
begin


-- FPAdd --
   swap <= '1' when X(30 downto 0) < Y(30 downto 0) else '0'; -- comparator
   -- input swap so that |X|>|Y|
   newX <=  X when swap = '0' else Y;
   newY <= Y when swap = '0' else X;
   expDiff <= newX(30 downto 23) - newY(30 downto 23);
   -- now we decompose the inputs into their sign, exponent, fraction
   add_expX<= newX(30 downto 23);
   signX<= newX(31);
   signY<= newY(31);
   EffSub <= signX xor signY;

   fracY <= '1' & newY(22 downto 0);

   shiftedOut <= '1' when (expDiff > 25) else '0';
   shiftVal <= expDiff(4 downto 0) when shiftedOut='0' else CONV_STD_LOGIC_VECTOR(26,5);

   RightShifterComponent: RightShifterSticky24_by_max_26_Freq1_uid4
      port map ( clk  => clk,
                 S => shiftVal, 
                 X => fracY, 
                 R => shiftedFracY, 
                 Sticky => add_sticky); 

   fracYpad <= "0" & shiftedFracY; -- 27bit
   EffSubVector <= (26 downto 0 => EffSub); -- maskの役割
   fracYpadXorOp <= fracYpad xor EffSubVector; --27bit
   fracXpad <= "01" & (newX(22 downto 0)) & "00"; --27bit
   cInSigAdd <= EffSub and not add_sticky; -- if we subtract and the sticky was one, some of the negated sticky bits would have absorbed this carry 
   -- Connect to shared IntAdder_27 via ports
   add_fracAdder_X <= fracXpad;
   add_fracAdder_Y<= fracYpadXorOp;
   add_fracAdder_Cin<= cInSigAdd;
   fracAddResult <= add_fracAdder_R;
   fracSticky<= fracAddResult & add_sticky; -- stickyありの計算結果

   LZCAndShifter: Normalizer_Z_28_28_28_Freq1_uid8 --オーバーフローを考えて28桁なってる
      port map ( clk  => clk,
                 X => fracSticky,
                 Count => nZerosNew, -- 先頭の0の数　maxで5桁
                 R => shiftedFrac); -- 1.　。。。の形をしている -28桁

   extendedExpInc<= ("0" & add_expX) + '1'; -- 28桁でやってる分1をプラスしてる
   updatedExp <= (extendedExpInc) - ("0000" & nZerosNew); -- 5桁だったので、8と+2で10. 11. . .って時は1になろうようにして、減らす量を調整してる

   add_expFrac<= updatedExp & shiftedFrac(26 downto 3);
   stk<= shiftedFrac(2) or shiftedFrac(1) or shiftedFrac(0); 
   rnd<= shiftedFrac(3);
   lsb<= shiftedFrac(4);
   -- Connect to Shared Rounding Adder
   add_ra_X <= add_expFrac;
   add_round<= '1' when (rnd='1' and stk='1') or (rnd='1' and stk='0' and lsb='1')
  else '0';

   RoundedExpFrac <= ra_R;
   fracR <= RoundedExpFrac(23 downto 1); 
   expR <= RoundedExpFrac(31 downto 24); 

   add_R <=  signX & expR & fracR;

-- FPMul --
   sign <= X(31) xor Y(31);
   mul_expX <= X(30 downto 23);
   expY <= Y(30 downto 23);
   
   -- Use shared IntAdder_27 for expSumPreSub calculation
   -- Pad 10-bit values to 27-bit
   mul_expAdder_X<=mul_expX;  -- 8bit  
   mul_expAdder_Y<=expY;  -- 8bit
   mul_expAdder_Cin<= '0';
   expSumPreSub <= '0' & mul_expAdder_R(8 downto 0);  -- Extract lower 10 bits
   
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub - bias;
   sigX <= "1" & X(22 downto 0);
   sigY <= "1" & Y(22 downto 0);

   sigProd <= sigX * sigY;
   -- exponent update 
   norm <= sigProd(47);
   expPostNorm <= expSum + ("000000000" & norm); -- 最上位が1ならexpを1つ挙げる. [1,2)同士の掛け算は[2,4), 11ならnormが1になるからexpを上げる
   -- significand normalization shift
   sigProdExt <= sigProd(46 downto 0) & "0" when norm='1' else
                         sigProd(45 downto 0) & "00"; --normが0なら01. . ってつづくから1でカットしていい
   expSig <= expPostNorm & sigProdExt(47 downto 25);
   mul_guard_bit <= sigProdExt(24); 
mul_sticky <= '1' when sigProdExt(23 downto 0) /= 0 else '0';
   mul_lsb <= sigProdExt(25);
   mul_round <= mul_guard_bit and (mul_sticky or mul_lsb);

   -- Connect to Shared Rounding Adder
   mul_ra_X <= expSig;
   expSigPostRound <= ra_R(30 downto 0);
   mul_R <= sign & expSigPostRound(30 downto 0);



-- FPDiv --
   fX <= "1" & X(22 downto 0);
   fY <= "1" & Y(22 downto 0);
   expR0 <= ("00" & X(30 downto 23)) - ("00" & Y(30 downto 23));
   sR <= X(31) xor Y(31);
   -- exnXY <= X(33 downto 32) & Y(33 downto 32);
   -- with exnXY  select 
   --    exnR0 <= 
   --       "01"	 when "0101",
   --       "00"	 when "0001" | "0010" | "0110",
   --       "10"	 when "0100" | "1000" | "1001",
   --       "11"	 when others;

   D <= fY ;
   psX <= "0" & fX ;
   betaw14 <=  "00" & psX;
   sel14 <= betaw14(26 downto 21) & D(22 downto 20);
   SelFunctionTable14: selFunction_Freq1_uid4
      port map ( X => sel14,
                 Y => q14_copy5);
   q14 <= q14_copy5;

   with q14  select 
      absq14D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w13
   w13 <= shared_as_r13;

   betaw13 <= w13(24 downto 0) & "00";
   sel13 <= betaw13(26 downto 21) & D(22 downto 20);
   SelFunctionTable13: selFunction_Freq1_uid4
      port map ( X => sel13,
                 Y => q13_copy6);
   q13 <= q13_copy6;

   with q13  select 
      absq13D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w12
   w12 <= shared_as_r12;

   betaw12 <= w12(24 downto 0) & "00";
   sel12 <= betaw12(26 downto 21) & D(22 downto 20);
   SelFunctionTable12: selFunction_Freq1_uid4
      port map ( X => sel12,
                 Y => q12_copy7);
   q12 <= q12_copy7;

   with q12  select 
      absq12D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w11
   w11 <= shared_as_r11;

   betaw11 <= w11(24 downto 0) & "00";
   sel11 <= betaw11(26 downto 21) & D(22 downto 20);
   SelFunctionTable11: selFunction_Freq1_uid4
      port map ( X => sel11,
                 Y => q11_copy8);
   q11 <= q11_copy8;

   with q11  select 
      absq11D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w10
   w10 <= shared_as_r10;

   betaw10 <= w10(24 downto 0) & "00";
   sel10 <= betaw10(26 downto 21) & D(22 downto 20);
   SelFunctionTable10: selFunction_Freq1_uid4
      port map ( X => sel10,
                 Y => q10_copy9);
   q10 <= q10_copy9;

   with q10  select 
      absq10D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w9
   w9 <= shared_as_r9;

   betaw9 <= w9(24 downto 0) & "00";
   sel9 <= betaw9(26 downto 21) & D(22 downto 20);
   SelFunctionTable9: selFunction_Freq1_uid4
      port map ( X => sel9,
                 Y => q9_copy10);
   q9 <= q9_copy10;

   with q9  select 
      absq9D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w8
   w8 <= shared_as_r8;

   betaw8 <= w8(24 downto 0) & "00";
   sel8 <= betaw8(26 downto 21) & D(22 downto 20);
   SelFunctionTable8: selFunction_Freq1_uid4
      port map ( X => sel8,
                 Y => q8_copy11);
   q8 <= q8_copy11;

   with q8  select 
      absq8D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w7
   w7 <= shared_as_r7;

   betaw7 <= w7(24 downto 0) & "00";
   sel7 <= betaw7(26 downto 21) & D(22 downto 20);
   SelFunctionTable7: selFunction_Freq1_uid4
      port map ( X => sel7,
                 Y => q7_copy12);
   q7 <= q7_copy12;

   with q7  select 
      absq7D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w6
   w6 <= shared_as_r6;

   betaw6 <= w6(24 downto 0) & "00";
   sel6 <= betaw6(26 downto 21) & D(22 downto 20);
   SelFunctionTable6: selFunction_Freq1_uid4
      port map ( X => sel6,
                 Y => q6_copy13);
   q6 <= q6_copy13;

   with q6  select 
      absq6D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w5
   w5 <= shared_as_r5;

   betaw5 <= w5(24 downto 0) & "00";
   sel5 <= betaw5(26 downto 21) & D(22 downto 20);
   SelFunctionTable5: selFunction_Freq1_uid4
      port map ( X => sel5,
                 Y => q5_copy14);
   q5 <= q5_copy14;

   with q5  select 
      absq5D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w4
   w4 <= shared_as_r4;

   betaw4 <= w4(24 downto 0) & "00";
   sel4 <= betaw4(26 downto 21) & D(22 downto 20);
   SelFunctionTable4: selFunction_Freq1_uid4
      port map ( X => sel4,
                 Y => q4_copy15);
   q4 <= q4_copy15;

   with q4  select 
      absq4D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w3
   w3 <= shared_as_r3;

   betaw3 <= w3(24 downto 0) & "00";
   sel3 <= betaw3(26 downto 21) & D(22 downto 20);
   SelFunctionTable3: selFunction_Freq1_uid4
      port map ( X => sel3,
                 Y => q3_copy16);
   q3 <= q3_copy16;

   with q3  select 
      absq3D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w2
   w2 <= shared_as_r2;

   betaw2 <= w2(24 downto 0) & "00";
   sel2 <= betaw2(26 downto 21) & D(22 downto 20);
   SelFunctionTable2: selFunction_Freq1_uid4
      port map ( X => sel2,
                 Y => q2_copy17);
   q2 <= q2_copy17;

   with q2  select 
      absq2D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   -- Shared Logic Connection for w1
   w1 <= shared_as_r1;

   betaw1 <= w1(24 downto 0) & "00";
   sel1 <= betaw1(26 downto 21) & D(22 downto 20);
   SelFunctionTable1: selFunction_Freq1_uid4
      port map ( X => sel1,
                 Y => q1_copy18);
   q1 <= q1_copy18;

   with q1  select 
      absq1D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;


   -- Shared Logic Connection for w0
   w0 <= shared_as_r0(26 downto 0);

   wfinal <= w0(24 downto 0);
   qM0 <= wfinal(24);
   qP14 <=      q14(1 downto 0);
   qM14 <=      q14(2) & "0";
   qP13 <=      q13(1 downto 0);
   qM13 <=      q13(2) & "0";
   qP12 <=      q12(1 downto 0);
   qM12 <=      q12(2) & "0";
   qP11 <=      q11(1 downto 0);
   qM11 <=      q11(2) & "0";
   qP10 <=      q10(1 downto 0);
   qM10 <=      q10(2) & "0";
   qP9 <=      q9(1 downto 0);
   qM9 <=      q9(2) & "0";
   qP8 <=      q8(1 downto 0);
   qM8 <=      q8(2) & "0";
   qP7 <=      q7(1 downto 0);
   qM7 <=      q7(2) & "0";
   qP6 <=      q6(1 downto 0);
   qM6 <=      q6(2) & "0";
   qP5 <=      q5(1 downto 0);
   qM5 <=      q5(2) & "0";
   qP4 <=      q4(1 downto 0);
   qM4 <=      q4(2) & "0";
   qP3 <=      q3(1 downto 0);
   qM3 <=      q3(2) & "0";
   qP2 <=      q2(1 downto 0);
   qM2 <=      q2(2) & "0";
   qP1 <=      q1(1 downto 0);
   qM1 <=      q1(2) & "0";
   qP <= qP14 & qP13 & qP12 & qP11 & qP10 & qP9 & qP8 & qP7 & qP6 & qP5 & qP4 & qP3 & qP2 & qP1;
   qM <= qM14(0) & qM13 & qM12 & qM11 & qM10 & qM9 & qM8 & qM7 & qM6 & qM5 & qM4 & qM3 & qM2 & qM1 & qM0;
   quotient <= qP - qM;
   div_mR <= quotient(26 downto 1);
   fRnorm <=    div_mR(24 downto 1)  when div_mR(25)= '1'
           else div_mR(23 downto 0);
   div_round <= fRnorm(0); 
   expR1 <= expR0 + ("000" & (6 downto 1 => '1') & div_mR(25));
   div_ra_X <= expR1 & fRnorm(23 downto 1) ;
   
   expfracR <= ra_R(32 downto 0);
   -- exnR <=      "00"  when expfracR(32) = '1'
   --         else "10"  when   expfracR(32 downto 31) =  "01"
   --         else "01";
   -- with exnR0  select 
   --    exnRfinal <= 
   --       exnR   when "01",
   --       exnR0  when others;
   div_R <= sR &  expfracR(30 downto 0);


--------------------------------------------------------------------------------
--                                FPSqrt_NoRA
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 28.715000ns)


   fracX <= X(22 downto 0); -- fraction
   eRn0 <= "0" & X(30 downto 24); -- exponent 最上位切り捨てなので　/2をしている
   -- xsX <= "01" & X(31); -- exception and sign
   eRn1 <= eRn0 + ("00" & (5 downto 0 => '1')) + X(23); --63のバイアスを足す。奇数の場合X(23)の場合はさらに1足して偶数にする
   fracXnorm <= "1" & fracX & "000" when X(23) = '0' else
         "01" & fracX&"00"; -- pre-normalization　eRn1で奇数の場合は1つ桁を挙げたから0.1的な形になってる
   S0 <= "01";
   T1 <= ("0111" + fracXnorm(26 downto 23)) & fracXnorm(22 downto 0);
   -- now implementing the recurrence 
   --  this is a binary non-restoring algorithm, see ASA book
   -- Step 2
   d1 <= not T1(26); --  bit of weight -1
   T1s <= T1 & "0";
   T1s_h <= T1s(27 downto 22);
   T1s_l <= T1s(21 downto 0);
   U1 <=  "0" & S0 & d1 & (not d1) & "1"; 
   T3_h <=   T1s_h - U1 when d1='1'
        else T1s_h + U1;
   T2 <= T3_h(4 downto 0) & T1s_l;
   S1 <= S0 & d1; -- here -1 becomes 0 and 1 becomes 1
   -- Step 3
   d2 <= not T2(26); --  bit of weight -2
   T2s <= T2 & "0";
   T2s_h <= T2s(27 downto 21);
   T2s_l <= T2s(20 downto 0);
   U2 <=  "0" & S1 & d2 & (not d2) & "1"; 
   T4_h <=   T2s_h - U2 when d2='1'
        else T2s_h + U2;
   T3 <= T4_h(5 downto 0) & T2s_l;
   S2 <= S1 & d2; -- here -1 becomes 0 and 1 becomes 1
   -- Step 4
   d3 <= not T3(26); --  bit of weight -3
   T3s <= T3 & "0";
   T3s_h <= T3s(27 downto 20);
   T3s_l <= T3s(19 downto 0);
   U3 <=  "0" & S2 & d3 & (not d3) & "1"; 
   T5_h <=   T3s_h - U3 when d3='1'
        else T3s_h + U3;
   T4 <= T5_h(6 downto 0) & T3s_l;
   S3 <= S2 & d3; -- here -1 becomes 0 and 1 becomes 1
   -- Step 5
   d4 <= not T4(26); --  bit of weight -4
   T4s <= T4 & "0";
   T4s_h <= T4s(27 downto 19);
   T4s_l <= T4s(18 downto 0);
   U4 <=  "0" & S3 & d4 & (not d4) & "1"; 
   T6_h <=   T4s_h - U4 when d4='1'
        else T4s_h + U4;
   T5 <= T6_h(7 downto 0) & T4s_l;
   S4 <= S3 & d4; -- here -1 becomes 0 and 1 becomes 1
   -- Step 6
   d5 <= not T5(26); --  bit of weight -5
   T5s <= T5 & "0";
   T5s_h <= T5s(27 downto 18);
   T5s_l <= T5s(17 downto 0);
   U5 <=  "0" & S4 & d5 & (not d5) & "1"; 
   T7_h <=   T5s_h - U5 when d5='1'
        else T5s_h + U5;
   T6 <= T7_h(8 downto 0) & T5s_l;
   S5 <= S4 & d5; -- here -1 becomes 0 and 1 becomes 1
   -- Step 7
   d6 <= not T6(26); --  bit of weight -6
   T6s <= T6 & "0";
   T6s_h <= T6s(27 downto 17);
   T6s_l <= T6s(16 downto 0);
   U6 <=  "0" & S5 & d6 & (not d6) & "1"; 
   T8_h <=   T6s_h - U6 when d6='1'
        else T6s_h + U6;
   T7 <= T8_h(9 downto 0) & T6s_l;
   S6 <= S5 & d6; -- here -1 becomes 0 and 1 becomes 1
   -- Step 8
   d7 <= not T7(26); --  bit of weight -7
   T7s <= T7 & "0";
   T7s_h <= T7s(27 downto 16);
   T7s_l <= T7s(15 downto 0);
   U7 <=  "0" & S6 & d7 & (not d7) & "1"; 
   T9_h <=   T7s_h - U7 when d7='1'
        else T7s_h + U7;
   T8 <= T9_h(10 downto 0) & T7s_l;
   S7 <= S6 & d7; -- here -1 becomes 0 and 1 becomes 1
   -- Step 9
   d8 <= not T8(26); --  bit of weight -8
   T8s <= T8 & "0";
   T8s_h <= T8s(27 downto 15);
   T8s_l <= T8s(14 downto 0);
   U8 <=  "0" & S7 & d8 & (not d8) & "1"; 
   T10_h <=   T8s_h - U8 when d8='1'
        else T8s_h + U8;
   T9 <= T10_h(11 downto 0) & T8s_l;
   S8 <= S7 & d8; -- here -1 becomes 0 and 1 becomes 1
   -- Step 10
   d9 <= not T9(26); --  bit of weight -9
   T9s <= T9 & "0";
   T9s_h <= T9s(27 downto 14);
   T9s_l <= T9s(13 downto 0);
   U9 <=  "0" & S8 & d9 & (not d9) & "1"; 
   T11_h <=   T9s_h - U9 when d9='1'
        else T9s_h + U9;
   T10 <= T11_h(12 downto 0) & T9s_l;
   S9 <= S8 & d9; -- here -1 becomes 0 and 1 becomes 1
   -- Step 11
   d10 <= not T10(26); --  bit of weight -10
   T10s <= T10 & "0";
   T10s_h <= T10s(27 downto 13);
   T10s_l <= T10s(12 downto 0);
   U10 <=  "0" & S9 & d10 & (not d10) & "1"; 
   -- Shared Logic Connection for T12_h (Index 11, Step 11)
   T12_h <= shared_as_r13(14 downto 0);
   T11 <= T12_h(13 downto 0) & T10s_l;
   S10 <= S9 & d10; -- here -1 becomes 0 and 1 becomes 1
   -- Step 12
   d11 <= not T11(26); --  bit of weight -11
   T11s <= T11 & "0";
   T11s_h <= T11s(27 downto 12);
   T11s_l <= T11s(11 downto 0);
   U11 <=  "0" & S10 & d11 & (not d11) & "1"; 
   -- Shared Logic Connection for T13_h (Index 12)
   T13_h <= shared_as_r12(15 downto 0);
   T12 <= T13_h(14 downto 0) & T11s_l;
   S11 <= S10 & d11; -- here -1 becomes 0 and 1 becomes 1
   -- Step 13
   d12 <= not T12(26); --  bit of weight -12
   T12s <= T12 & "0";
   T12s_h <= T12s(27 downto 11);
   T12s_l <= T12s(10 downto 0);
   U12 <=  "0" & S11 & d12 & (not d12) & "1"; 
   -- Shared Logic Connection for T14_h (Index 11)
   T14_h <= shared_as_r11(16 downto 0);
   T13 <= T14_h(15 downto 0) & T12s_l;
   S12 <= S11 & d12; -- here -1 becomes 0 and 1 becomes 1
   -- Step 14
   d13 <= not T13(26); --  bit of weight -13
   T13s <= T13 & "0";
   T13s_h <= T13s(27 downto 10);
   T13s_l <= T13s(9 downto 0);
   U13 <=  "0" & S12 & d13 & (not d13) & "1"; 
   -- Shared Logic Connection for T15_h (Index 10)
   T15_h <= shared_as_r10(17 downto 0);
   T14 <= T15_h(16 downto 0) & T13s_l;
   S13 <= S12 & d13; -- here -1 becomes 0 and 1 becomes 1
   -- Step 15
   d14 <= not T14(26); --  bit of weight -14
   T14s <= T14 & "0";
   T14s_h <= T14s(27 downto 9);
   T14s_l <= T14s(8 downto 0);
   U14 <=  "0" & S13 & d14 & (not d14) & "1"; 
   -- Shared Logic Connection for T16_h (Index 9)
   T16_h <= shared_as_r9(18 downto 0);
   T15 <= T16_h(17 downto 0) & T14s_l;
   S14 <= S13 & d14; -- here -1 becomes 0 and 1 becomes 1
   -- Step 16
   d15 <= not T15(26); --  bit of weight -15
   T15s <= T15 & "0";
   T15s_h <= T15s(27 downto 8);
   T15s_l <= T15s(7 downto 0);
   U15 <=  "0" & S14 & d15 & (not d15) & "1"; 
   -- Shared Logic Connection for T17_h
   T17_h <= shared_as_r8(19 downto 0);
   T16 <= T17_h(18 downto 0) & T15s_l;
   S15 <= S14 & d15; -- here -1 becomes 0 and 1 becomes 1
   -- Step 17
   d16 <= not T16(26); --  bit of weight -16
   T16s <= T16 & "0";
   T16s_h <= T16s(27 downto 7);
   T16s_l <= T16s(6 downto 0);
   U16 <=  "0" & S15 & d16 & (not d16) & "1"; 
   -- Shared Logic Connection for T18_h
   T18_h <= shared_as_r7(20 downto 0);
   T17 <= T18_h(19 downto 0) & T16s_l;
   S16 <= S15 & d16; -- here -1 becomes 0 and 1 becomes 1
   -- Step 18
   d17 <= not T17(26); --  bit of weight -17
   T17s <= T17 & "0";
   T17s_h <= T17s(27 downto 6);
   T17s_l <= T17s(5 downto 0);
   U17 <=  "0" & S16 & d17 & (not d17) & "1"; 
   -- Shared Logic Connection for T19_h
   T19_h <= shared_as_r6(21 downto 0);
   T18 <= T19_h(20 downto 0) & T17s_l;
   S17 <= S16 & d17; -- here -1 becomes 0 and 1 becomes 1
   -- Step 19
   d18 <= not T18(26); --  bit of weight -18
   T18s <= T18 & "0";
   T18s_h <= T18s(27 downto 5);
   T18s_l <= T18s(4 downto 0);
   U18 <=  "0" & S17 & d18 & (not d18) & "1"; 
   -- Shared Logic Connection for T20_h
   T20_h <= shared_as_r5(22 downto 0);
   T19 <= T20_h(21 downto 0) & T18s_l;
   S18 <= S17 & d18; -- here -1 becomes 0 and 1 becomes 1
   -- Step 20
   d19 <= not T19(26); --  bit of weight -19
   T19s <= T19 & "0";
   T19s_h <= T19s(27 downto 4);
   T19s_l <= T19s(3 downto 0);
   U19 <=  "0" & S18 & d19 & (not d19) & "1"; 
   -- Shared Logic Connection for T21_h
   T21_h <= shared_as_r4(23 downto 0);
   T20 <= T21_h(22 downto 0) & T19s_l;
   S19 <= S18 & d19; -- here -1 becomes 0 and 1 becomes 1
   -- Step 21
   d20 <= not T20(26); --  bit of weight -20
   T20s <= T20 & "0";
   T20s_h <= T20s(27 downto 3);
   T20s_l <= T20s(2 downto 0);
   U20 <=  "0" & S19 & d20 & (not d20) & "1"; 
   -- Shared Logic Connection for T22_h
   T22_h <= shared_as_r3(24 downto 0);
   T21 <= T22_h(23 downto 0) & T20s_l;
   S20 <= S19 & d20; -- here -1 becomes 0 and 1 becomes 1
   -- Step 22
   d21 <= not T21(26); --  bit of weight -21
   T21s <= T21 & "0";
   T21s_h <= T21s(27 downto 2);
   T21s_l <= T21s(1 downto 0);
   U21 <=  "0" & S20 & d21 & (not d21) & "1"; 
   -- Shared Logic Connection for T23_h
   T23_h <= shared_as_r2(25 downto 0);
   T22 <= T23_h(24 downto 0) & T21s_l;
   S21 <= S20 & d21; -- here -1 becomes 0 and 1 becomes 1
   -- Step 23
   d22 <= not T22(26); --  bit of weight -22
   T22s <= T22 & "0";
   T22s_h <= T22s(27 downto 1);
   T22s_l <= T22s(0 downto 0);
   U22 <=  "0" & S21 & d22 & (not d22) & "1"; 
   -- Shared Logic Connection for T24_h
   T24_h <= shared_as_r1;
   T23 <= T24_h(25 downto 0) & T22s_l;
   S22 <= S21 & d22; -- here -1 becomes 0 and 1 becomes 1
   -- Step 24
   d23 <= not T23(26); --  bit of weight -23
   T23s <= T23 & "0";
   T23s_h <= T23s(27 downto 0);
   U23 <=  "0" & S22 & d23 & (not d23) & "1"; 

   -- Shared Logic Connection for T25_h
   T25_h <= shared_as_r0;
   T24 <= T25_h(26 downto 0);
   S23 <= S22 & d23; -- here -1 becomes 0 and 1 becomes 1
   d25 <= not T24(26) ; -- the sign of the remainder will become the round bit
   sqrt_mR <= S23 & d25; -- result significand
   fR <= sqrt_mR(23 downto 1);-- removing leading 1
   sqrt_round <= sqrt_mR(0); -- round bit

   sqrt_ra_X <= "0000000000" & fR;
   -- fRrnd <= fR + ((22 downto 1 => '0') & round); -- rounding sqrt never changes exponents 
   
   -- Output to shared rounding adder
   -- fR is 23 bits. We pad it to 34 bits.
--    expFrac_out <= fR; 
--    round_out <= sqrt_round;
   
   -- Input from shared rounding adder
   -- It returns 34 bits, but we only used the lower bits appropriately.
   fRrnd <= ra_R(22 downto 0); 
   
   Rn2 <= eRn1 & fRrnd;
   -- sign and exception processing
   -- with xsX  select 
   --    xsR <= "010"  when "010",  -- normal case
   --           "100"  when "100",  -- +infty
   --           "000"  when "000",  -- +0
   --           "001"  when "001",  -- the infamous sqrt(-0)=-0
   --           "110"  when others; -- return NaN
   sqrt_R <= X(31) & Rn2; 


-- Shared Add/Sub Logic Step 0
-- Combined w0 (DIV) and T25_h (SQRT)
-- DIV: opcode="11", sub when q1(2)='0' (active low)
-- SQRT: opcode="10", sub when d23='1' (active high)
    shared_as_x0 <= "0" & betaw1 when opcode(0)='1' else T23s_h;
    shared_as_y0 <= "0" & absq1D when opcode(0)='1' else U23;
    shared_as_sub0 <= not q1(2)  when opcode(0)='1' else d23;

   --  shared_as_r0 <= shared_as_x0 - shared_as_y0 when shared_as_sub0 = '1'
   --             else shared_as_x0 + shared_as_y0;
   sub_mask0 <= (others => shared_as_sub0);
   y_xor0 <= shared_as_y0 xor sub_mask0;

   cin_vec0(27 downto 1) <= (others => '0');
   cin_vec0(0) <= shared_as_sub0;

   shared_as_r0 <= shared_as_x0 + y_xor0 + cin_vec0;


-- Shared Add/Sub Logic Step 1
    shared_as_x1 <= betaw2 when opcode(0)='1' else T22s_h;
    shared_as_y1 <= absq2D when opcode(0)='1' else U22;
    shared_as_sub1 <= not q2(2)  when opcode(0)='1' else d22;

    shared_as_r1 <= shared_as_x1 - shared_as_y1 when shared_as_sub1 = '1'
               else shared_as_x1 + shared_as_y1;

-- Shared Add/Sub Logic Step 2
    shared_as_x2 <= betaw3 when opcode(0)='1' else '0' & T21s_h;
    shared_as_y2 <= absq3D when opcode(0)='1' else '0' & U21;
    shared_as_sub2 <= not q3(2)  when opcode(0)='1' else d21;

   --  shared_as_r2 <= shared_as_x2 - shared_as_y2 when shared_as_sub2 = '1'
   --             else shared_as_x2 + shared_as_y2;

   sub_mask2 <= (others => shared_as_sub2);
   y_xor2 <= shared_as_y2 xor sub_mask2;

   cin_vec2(26 downto 1) <= (others => '0');
   cin_vec2(0) <= shared_as_sub2;
   shared_as_r2 <= shared_as_x2 + y_xor2 + cin_vec2;

-- Shared Add/Sub Logic Step 3
    shared_as_x3 <= betaw4 when opcode(0)='1' else "00" & T20s_h;
    shared_as_y3 <= absq4D when opcode(0)='1' else "00" & U20;
    shared_as_sub3 <= not q4(2)  when opcode(0)='1' else d20;

    shared_as_r3 <= shared_as_x3 - shared_as_y3 when shared_as_sub3 = '1'
               else shared_as_x3 + shared_as_y3;

-- Shared Add/Sub Logic Step 4
    shared_as_x4 <= betaw5 when opcode(0)='1' else "000" & T19s_h;
    shared_as_y4 <= absq5D when opcode(0)='1' else "000" & U19;
    shared_as_sub4 <= not q5(2)  when opcode(0)='1' else d19;

    shared_as_r4 <= shared_as_x4 - shared_as_y4 when shared_as_sub4 = '1'
               else shared_as_x4 + shared_as_y4;

-- Shared Add/Sub Logic Step 5
    shared_as_x5 <= betaw6 when opcode(0)='1' else "0000" & T18s_h;
    shared_as_y5 <= absq6D when opcode(0)='1' else "0000" & U18;
    shared_as_sub5 <= not q6(2)  when opcode(0)='1' else d18;

    shared_as_r5 <= shared_as_x5 - shared_as_y5 when shared_as_sub5 = '1'
               else shared_as_x5 + shared_as_y5;

-- Shared Add/Sub Logic Step 6
    shared_as_x6 <= betaw7 when opcode(0)='1' else "00000" & T17s_h;
    shared_as_y6 <= absq7D when opcode(0)='1' else "00000" & U17;
    shared_as_sub6 <= not q7(2)  when opcode(0)='1' else d17;

    shared_as_r6 <= shared_as_x6 - shared_as_y6 when shared_as_sub6 = '1'
               else shared_as_x6 + shared_as_y6;

-- Shared Add/Sub Logic Step 7
    shared_as_x7 <= betaw8 when opcode(0)='1' else "000000" & T16s_h;
    shared_as_y7 <= absq8D when opcode(0)='1' else "000000" & U16;
    shared_as_sub7 <= not q8(2)  when opcode(0)='1' else d16;

    shared_as_r7 <= shared_as_x7 - shared_as_y7 when shared_as_sub7 = '1'
               else shared_as_x7 + shared_as_y7;

-- Shared Add/Sub Logic Step 8
    shared_as_x8 <= betaw9 when opcode(0)='1' else "0000000" & T15s_h;
    shared_as_y8 <= absq9D when opcode(0)='1' else "0000000" & U15;
    shared_as_sub8 <= not q9(2)  when opcode(0)='1' else d15;

    shared_as_r8 <= shared_as_x8 - shared_as_y8 when shared_as_sub8 = '1'
               else shared_as_x8 + shared_as_y8;

-- Shared Add/Sub Logic Step 9
    shared_as_x9 <= betaw10 when opcode(0)='1' else "00000000" & T14s_h;
    shared_as_y9 <= absq10D when opcode(0)='1' else "00000000" & U14;
    shared_as_sub9 <= not q10(2)  when opcode(0)='1' else d14;

    shared_as_r9 <= shared_as_x9 - shared_as_y9 when shared_as_sub9 = '1'
               else shared_as_x9 + shared_as_y9;

-- Shared Add/Sub Logic Step 10
    shared_as_x10 <= betaw11 when opcode(0)='1' else "000000000" & T13s_h;
    shared_as_y10 <= absq11D when opcode(0)='1' else "000000000" & U13;
    shared_as_sub10 <= not q11(2)  when opcode(0)='1' else d13;

    shared_as_r10 <= shared_as_x10 - shared_as_y10 when shared_as_sub10 = '1'
               else shared_as_x10 + shared_as_y10;

-- Shared Add/Sub Logic Step 11
    shared_as_x11 <= betaw12 when opcode(0)='1' else "0000000000" & T12s_h;
    shared_as_y11 <= absq12D when opcode(0)='1' else "0000000000" & U12;
    shared_as_sub11 <= not q12(2)  when opcode(0)='1' else d12;

    shared_as_r11 <= shared_as_x11 - shared_as_y11 when shared_as_sub11 = '1'
               else shared_as_x11 + shared_as_y11;

-- Shared Add/Sub Logic Step 12
    shared_as_x12 <= betaw13 when opcode(0)='1' else "00000000000" & T11s_h;
    shared_as_y12 <= absq13D when opcode(0)='1' else "00000000000" & U11;
    shared_as_sub12 <= not q13(2)  when opcode(0)='1' else d11;

    shared_as_r12 <= shared_as_x12 - shared_as_y12 when shared_as_sub12 = '1'
               else shared_as_x12 + shared_as_y12;

-- Shared Add/Sub Logic Step 13
    -- DIV: w13 <= betaw14 +/- absq14D. sub when q14(2)=0.
    -- SQRT: T12_h <= T10s_h +/- U10. sub when d10=1.
    shared_as_x13 <= betaw14 when opcode(0)='1' else "000000000000" & T10s_h; -- T10s_h is 15 bits (27..13), pad 12
    shared_as_y13 <= absq14D when opcode(0)='1' else "000000000000" & U10;
    shared_as_sub13 <= not q14(2)  when opcode(0)='1' else d10;

   sub_mask13 <= (others => shared_as_sub13);
   y_xor13 <= shared_as_y13 xor sub_mask13;

   cin_vec13(26 downto 1) <= (others => '0');
   cin_vec13(0) <= shared_as_sub13;
   shared_as_r13 <= shared_as_x13 + y_xor13 + cin_vec13;

-- Shared
   -- Output to shared div_rounding adder
    -- Multiplex inputs to Shared Rounding Adder
    -- opcode: 00=Add, 01=Mul, 10=Sqrt, 11=Div
    ra_X <= add_ra_X when opcode="00" else 
            mul_ra_X when opcode="01" else
            div_ra_X when opcode="11" else
            sqrt_ra_X; -- For both Sqrt and Div
            
    ra_Cin <= add_round when opcode="00" else 
              mul_round when opcode="01" else
              div_round when opcode="11" else
              sqrt_round;
    ra_R <= ra_X + ra_Cin;

    -- Multiplex inputs to Shared IntAdder_27
    -- opcode: 00=Add (fracAdder), 01=Mul (expAdder), others unused
    ia27_X(26 downto 9) <= add_fracAdder_X(26 downto 9);
    ia27_X(8 downto 0) <= add_fracAdder_X (8 downto 0) when opcode="00" else
              '0' & mul_expAdder_X; -- when opcode="01"
    ia27_Y(26 downto 9) <= add_fracAdder_Y(26 downto 9);
    ia27_Y(8 downto 0)<= add_fracAdder_Y(8 downto 0) when opcode="00" else
              '0' & mul_expAdder_Y; -- when opcode="01"
    
    ia27_Cin <= add_fracAdder_Cin when opcode="00" else
                mul_expAdder_Cin; -- when opcode="01"

    add_fracAdder_R <= ia27_R;
    mul_expAdder_R <= ia27_R(8 downto 0);   



    U_SHARED_IA27: IntAdder_27_Freq1_uid6
    port map (
        clk => clk,
        X => ia27_X,
        Y => ia27_Y,
        Cin => ia27_Cin,
        R => ia27_R
    );

    R <= add_R when opcode="00" else 
         mul_R when opcode="01" else
         sqrt_R when opcode="10" else
         div_R;
end architecture;
