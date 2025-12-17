--------------------------------------------------------------------------------
--                    IntMultiplier_24x24_48_Freq500_uid5
-- VHDL generated for DummyFPGA @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Martin Kumm, Florent de Dinechin, Andreas Böttcher, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012-
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 2
-- Target frequency (MHz): 500
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.000000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_24x24_48_Freq500_uid5 is
    port (clk : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(23 downto 0);
          R : out  std_logic_vector(47 downto 0)   );
end entity;

architecture arch of IntMultiplier_24x24_48_Freq500_uid5 is
signal XX_m6 :  std_logic_vector(23 downto 0);
   -- timing of XX_m6: (c0, 0.000000ns)
signal YY_m6 :  std_logic_vector(23 downto 0);
   -- timing of YY_m6: (c0, 0.000000ns)
signal XX :  unsigned(-1+24 downto 0);
   -- timing of XX: (c0, 0.000000ns)
signal YY :  unsigned(-1+24 downto 0);
   -- timing of YY: (c0, 0.000000ns)
signal RR :  unsigned(-1+48 downto 0);
   -- timing of RR: (c0, 0.000000ns)
begin
   XX_m6 <= X ;
   YY_m6 <= Y ;
   XX <= unsigned(X);
   YY <= unsigned(Y);
   RR <= XX*YY;
   R <= std_logic_vector(RR(47 downto 0));
end architecture;

--------------------------------------------------------------------------------
--                          IntAdder_33_Freq500_uid9
-- VHDL generated for DummyFPGA @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles
-- Clock period (ns): 2
-- Target frequency (MHz): 500
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c1, 0.380000ns)Y: (c0, 0.000000ns)Cin: (c0, 1.700000ns)
--  approx. output signal timings: R: (c1, 1.700000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_33_Freq500_uid9 is
    port (clk : in std_logic;
          X : in  std_logic_vector(32 downto 0);
          Y : in  std_logic_vector(32 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(32 downto 0)   );
end entity;

architecture arch of IntAdder_33_Freq500_uid9 is
signal Rtmp :  std_logic_vector(32 downto 0);
   -- timing of Rtmp: (c1, 1.700000ns)
signal Y_d1 :  std_logic_vector(32 downto 0);
   -- timing of Y: (c0, 0.000000ns)
signal Cin_d1 :  std_logic;
   -- timing of Cin: (c0, 1.700000ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            Y_d1 <=  Y;
            Cin_d1 <=  Cin;
         end if;
      end process;
   Rtmp <= X + Y_d1 + Cin_d1;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                       FPMult_8_23_uid2_Freq500_uid3
-- VHDL generated for DummyFPGA @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2021
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles
-- Clock period (ns): 2
-- Target frequency (MHz): 500
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c1, 1.700000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPMult_8_23_uid2_Freq500_uid3 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPMult_8_23_uid2_Freq500_uid3 is
   component IntMultiplier_24x24_48_Freq500_uid5 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;

   component IntAdder_33_Freq500_uid9 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(32 downto 0);
             Y : in  std_logic_vector(32 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(32 downto 0)   );
   end component;

signal sign, sign_d1 :  std_logic;
   -- timing of sign: (c0, 0.050000ns)
signal expX :  std_logic_vector(7 downto 0);
   -- timing of expX: (c0, 0.000000ns)
signal expY :  std_logic_vector(7 downto 0);
   -- timing of expY: (c0, 0.000000ns)
signal expSumPreSub, expSumPreSub_d1 :  std_logic_vector(9 downto 0);
   -- timing of expSumPreSub: (c0, 1.090000ns)
signal bias, bias_d1 :  std_logic_vector(9 downto 0);
   -- timing of bias: (c0, 0.000000ns)
signal expSum :  std_logic_vector(9 downto 0);
   -- timing of expSum: (c1, 0.380000ns)
signal sigX :  std_logic_vector(23 downto 0);
   -- timing of sigX: (c0, 0.000000ns)
signal sigY :  std_logic_vector(23 downto 0);
   -- timing of sigY: (c0, 0.000000ns)
signal sigProd :  std_logic_vector(47 downto 0);
   -- timing of sigProd: (c0, 0.000000ns)
signal excSel :  std_logic_vector(3 downto 0);
   -- timing of excSel: (c0, 0.000000ns)
signal exc, exc_d1 :  std_logic_vector(1 downto 0);
   -- timing of exc: (c0, 0.050000ns)
signal norm, norm_d1 :  std_logic;
   -- timing of norm: (c0, 0.000000ns)
signal expPostNorm :  std_logic_vector(9 downto 0);
   -- timing of expPostNorm: (c1, 0.380000ns)
signal sigProdExt, sigProdExt_d1 :  std_logic_vector(47 downto 0);
   -- timing of sigProdExt: (c0, 0.550000ns)
signal expSig :  std_logic_vector(32 downto 0);
   -- timing of expSig: (c1, 0.380000ns)
signal sticky :  std_logic;
   -- timing of sticky: (c0, 0.550000ns)
signal guard :  std_logic;
   -- timing of guard: (c0, 1.150000ns)
signal round :  std_logic;
   -- timing of round: (c0, 1.700000ns)
signal expSigPostRound :  std_logic_vector(32 downto 0);
   -- timing of expSigPostRound: (c1, 1.700000ns)
signal excPostNorm :  std_logic_vector(1 downto 0);
   -- timing of excPostNorm: (c1, 1.700000ns)
signal finalExc :  std_logic_vector(1 downto 0);
   -- timing of finalExc: (c1, 1.700000ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            sign_d1 <=  sign;
            expSumPreSub_d1 <=  expSumPreSub;
            bias_d1 <=  bias;
            exc_d1 <=  exc;
            norm_d1 <=  norm;
            sigProdExt_d1 <=  sigProdExt;
         end if;
      end process;
   sign <= X(31) xor Y(31);
   expX <= X(30 downto 23);
   expY <= Y(30 downto 23);
   expSumPreSub <= ("00" & expX) + ("00" & expY);
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub_d1 - bias_d1;
   sigX <= "1" & X(22 downto 0);
   sigY <= "1" & Y(22 downto 0);
   SignificandMultiplication: IntMultiplier_24x24_48_Freq500_uid5
      port map ( clk  => clk,
                 X => sigX,
                 Y => sigY,
                 R => sigProd);
   excSel <= X(33 downto 32) & Y(33 downto 32);
   with excSel  select  
   exc <= "00" when  "0000" | "0001" | "0100", 
          "01" when "0101",
          "10" when "0110" | "1001" | "1010" ,
          "11" when others;
   norm <= sigProd(47);
   -- exponent update
   expPostNorm <= expSum + ("000000000" & norm_d1);
   -- significand normalization shift
   sigProdExt <= sigProd(46 downto 0) & "0" when norm='1' else
                         sigProd(45 downto 0) & "00";
   expSig <= expPostNorm & sigProdExt_d1(47 downto 25);
   sticky <= sigProdExt(24);
   guard <= '0' when sigProdExt(23 downto 0)="000000000000000000000000" else '1';
   round <= sticky and ( (guard and not(sigProdExt(25))) or (sigProdExt(25) ))  ;
   RoundingAdder: IntAdder_33_Freq500_uid9
      port map ( clk  => clk,
                 Cin => round,
                 X => expSig,
                 Y => "000000000000000000000000000000000",
                 R => expSigPostRound);
   with expSigPostRound(32 downto 31)  select 
   excPostNorm <=  "01"  when  "00",
                               "10"             when "01", 
                               "00"             when "11"|"10",
                               "11"             when others;
   with exc_d1  select  
   finalExc <= exc_d1 when  "11"|"10"|"00",
                       excPostNorm when others; 
   R <= finalExc & sign_d1 & expSigPostRound(30 downto 0);
end architecture;

