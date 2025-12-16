--------------------------------------------------------------------------------
--                 RightShifterSticky24_by_max_26_Freq1_uid4
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X S
-- Output signals: R Sticky
--  approx. input signal timings: X: (c0, 2.276000ns)S: (c0, 2.843500ns)
--  approx. output signal timings: R: (c0, 3.929500ns)Sticky: (c0, 6.211750ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky24_by_max_26_Freq1_uid4 is
    port (clk : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          S : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(25 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky24_by_max_26_Freq1_uid4 is
signal ps :  std_logic_vector(4 downto 0);
   -- timing of ps: (c0, 2.843500ns)
signal Xpadded :  std_logic_vector(25 downto 0);
   -- timing of Xpadded: (c0, 2.276000ns)
signal level5 :  std_logic_vector(25 downto 0);
   -- timing of level5: (c0, 2.276000ns)
signal stk4 :  std_logic;
   -- timing of stk4: (c0, 3.435500ns)
signal level4 :  std_logic_vector(25 downto 0);
   -- timing of level4: (c0, 2.843500ns)
signal stk3 :  std_logic;
   -- timing of stk3: (c0, 4.003000ns)
signal level3 :  std_logic_vector(25 downto 0);
   -- timing of level3: (c0, 3.386500ns)
signal stk2 :  std_logic;
   -- timing of stk2: (c0, 4.558250ns)
signal level2 :  std_logic_vector(25 downto 0);
   -- timing of level2: (c0, 3.386500ns)
signal stk1 :  std_logic;
   -- timing of stk1: (c0, 5.113500ns)
signal level1 :  std_logic_vector(25 downto 0);
   -- timing of level1: (c0, 3.929500ns)
signal stk0 :  std_logic;
   -- timing of stk0: (c0, 5.668750ns)
signal level0 :  std_logic_vector(25 downto 0);
   -- timing of level0: (c0, 3.929500ns)
signal stk :  std_logic;
   -- timing of stk: (c0, 6.211750ns)
begin
   ps<= S;
   Xpadded <= X&(1 downto 0 => '0');
   level5<= Xpadded;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1')   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => '0') & level5(25 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => '0') & level4(25 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => '0') & level3(25 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => '0') & level2(25 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => '0') & level1(25 downto 1);
   stk <= stk0;
   R <= level0;
   Sticky <= stk;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_27_Freq1_uid6
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c0, 1.733000ns)Y: (c0, 4.472500ns)Cin: (c0, 6.754750ns)
--  approx. output signal timings: R: (c0, 8.042750ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_27_Freq1_uid6 is
    port (clk : in std_logic;
          X : in  std_logic_vector(26 downto 0);
          Y : in  std_logic_vector(26 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(26 downto 0)   );
end entity;

architecture arch of IntAdder_27_Freq1_uid6 is
signal Rtmp :  std_logic_vector(26 downto 0);
   -- timing of Rtmp: (c0, 8.042750ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                      Normalizer_Z_28_28_28_Freq1_uid8
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X
-- Output signals: Count R
--  approx. input signal timings: X: (c0, 8.042750ns)
--  approx. output signal timings: Count: (c0, 13.040000ns)R: (c0, 13.583000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_Z_28_28_28_Freq1_uid8 is
    port (clk : in std_logic;
          X : in  std_logic_vector(27 downto 0);
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(27 downto 0)   );
end entity;

architecture arch of Normalizer_Z_28_28_28_Freq1_uid8 is
signal level5 :  std_logic_vector(27 downto 0);
   -- timing of level5: (c0, 8.042750ns)
signal count4 :  std_logic;
   -- timing of count4: (c0, 8.634750ns)
signal level4 :  std_logic_vector(27 downto 0);
   -- timing of level4: (c0, 9.177750ns)
signal count3 :  std_logic;
   -- timing of count3: (c0, 9.745250ns)
signal level3 :  std_logic_vector(27 downto 0);
   -- timing of level3: (c0, 10.288250ns)
signal count2 :  std_logic;
   -- timing of count2: (c0, 10.843500ns)
signal level2 :  std_logic_vector(27 downto 0);
   -- timing of level2: (c0, 11.386500ns)
signal count1 :  std_logic;
   -- timing of count1: (c0, 11.941750ns)
signal level1 :  std_logic_vector(27 downto 0);
   -- timing of level1: (c0, 12.484750ns)
signal count0 :  std_logic;
   -- timing of count0: (c0, 13.040000ns)
signal level0 :  std_logic_vector(27 downto 0);
   -- timing of level0: (c0, 13.583000ns)
signal sCount :  std_logic_vector(4 downto 0);
   -- timing of sCount: (c0, 13.040000ns)
begin
   level5 <= X ;
   count4<= '1' when level5(27 downto 12) = (27 downto 12=>'0') else '0';
   level4<= level5(27 downto 0) when count4='0' else level5(11 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(27 downto 20) = (27 downto 20=>'0') else '0';
   level3<= level4(27 downto 0) when count3='0' else level4(19 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(27 downto 24) = (27 downto 24=>'0') else '0';
   level2<= level3(27 downto 0) when count2='0' else level3(23 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(27 downto 26) = (27 downto 26=>'0') else '0';
   level1<= level2(27 downto 0) when count1='0' else level2(25 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(27 downto 27) = (27 downto 27=>'0') else '0';
   level0<= level1(27 downto 0) when count0='0' else level1(26 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                          IntAdder_34_Freq1_uid11
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c0, 14.132000ns)Y: (c0, 0.000000ns)Cin: (c0, 14.126000ns)
--  approx. output signal timings: R: (c0, 15.518000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_34_Freq1_uid11 is
    port (clk : in std_logic;
          X : in  std_logic_vector(33 downto 0);
          Y : in  std_logic_vector(33 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(33 downto 0)   );
end entity;

architecture arch of IntAdder_34_Freq1_uid11 is
signal Rtmp :  std_logic_vector(33 downto 0);
   -- timing of Rtmp: (c0, 15.518000ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           FPAdd_8_23_Freq1_uid2
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2010-2017)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 16.604000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPAdd_8_23_Freq1_uid2 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPAdd_8_23_Freq1_uid2 is
   component RightShifterSticky24_by_max_26_Freq1_uid4 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             S : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(25 downto 0);
             Sticky : out  std_logic   );
   end component;

   component IntAdder_27_Freq1_uid6 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(26 downto 0);
             Y : in  std_logic_vector(26 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(26 downto 0)   );
   end component;

   component Normalizer_Z_28_28_28_Freq1_uid8 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(27 downto 0);
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(27 downto 0)   );
   end component;

   component IntAdder_34_Freq1_uid11 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(33 downto 0);
             Y : in  std_logic_vector(33 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(33 downto 0)   );
   end component;

signal excExpFracX :  std_logic_vector(32 downto 0);
   -- timing of excExpFracX: (c0, 0.000000ns)
signal excExpFracY :  std_logic_vector(32 downto 0);
   -- timing of excExpFracY: (c0, 0.000000ns)
signal swap :  std_logic;
   -- timing of swap: (c0, 1.190000ns)
signal eXmeY :  std_logic_vector(7 downto 0);
   -- timing of eXmeY: (c0, 1.092000ns)
signal eYmeX :  std_logic_vector(7 downto 0);
   -- timing of eYmeX: (c0, 1.092000ns)
signal expDiff :  std_logic_vector(7 downto 0);
   -- timing of expDiff: (c0, 1.733000ns)
signal newX :  std_logic_vector(33 downto 0);
   -- timing of newX: (c0, 1.733000ns)
signal newY :  std_logic_vector(33 downto 0);
   -- timing of newY: (c0, 1.733000ns)
signal expX :  std_logic_vector(7 downto 0);
   -- timing of expX: (c0, 1.733000ns)
signal excX :  std_logic_vector(1 downto 0);
   -- timing of excX: (c0, 1.733000ns)
signal excY :  std_logic_vector(1 downto 0);
   -- timing of excY: (c0, 1.733000ns)
signal signX :  std_logic;
   -- timing of signX: (c0, 1.733000ns)
signal signY :  std_logic;
   -- timing of signY: (c0, 1.733000ns)
signal EffSub :  std_logic;
   -- timing of EffSub: (c0, 2.276000ns)
signal sXsYExnXY :  std_logic_vector(5 downto 0);
   -- timing of sXsYExnXY: (c0, 1.733000ns)
signal sdExnXY :  std_logic_vector(3 downto 0);
   -- timing of sdExnXY: (c0, 1.733000ns)
signal fracY :  std_logic_vector(23 downto 0);
   -- timing of fracY: (c0, 2.276000ns)
signal excRt :  std_logic_vector(1 downto 0);
   -- timing of excRt: (c0, 2.352000ns)
signal signR :  std_logic;
   -- timing of signR: (c0, 2.276000ns)
signal shiftedOut :  std_logic;
   -- timing of shiftedOut: (c0, 2.300500ns)
signal shiftVal :  std_logic_vector(4 downto 0);
   -- timing of shiftVal: (c0, 2.843500ns)
signal shiftedFracY :  std_logic_vector(25 downto 0);
   -- timing of shiftedFracY: (c0, 3.929500ns)
signal sticky :  std_logic;
   -- timing of sticky: (c0, 6.211750ns)
signal fracYpad :  std_logic_vector(26 downto 0);
   -- timing of fracYpad: (c0, 3.929500ns)
signal EffSubVector :  std_logic_vector(26 downto 0);
   -- timing of EffSubVector: (c0, 2.276000ns)
signal fracYpadXorOp :  std_logic_vector(26 downto 0);
   -- timing of fracYpadXorOp: (c0, 4.472500ns)
signal fracXpad :  std_logic_vector(26 downto 0);
   -- timing of fracXpad: (c0, 1.733000ns)
signal cInSigAdd :  std_logic;
   -- timing of cInSigAdd: (c0, 6.754750ns)
signal fracAddResult :  std_logic_vector(26 downto 0);
   -- timing of fracAddResult: (c0, 8.042750ns)
signal fracSticky :  std_logic_vector(27 downto 0);
   -- timing of fracSticky: (c0, 8.042750ns)
signal nZerosNew :  std_logic_vector(4 downto 0);
   -- timing of nZerosNew: (c0, 13.040000ns)
signal shiftedFrac :  std_logic_vector(27 downto 0);
   -- timing of shiftedFrac: (c0, 13.583000ns)
signal extendedExpInc :  std_logic_vector(8 downto 0);
   -- timing of extendedExpInc: (c0, 2.825000ns)
signal updatedExp :  std_logic_vector(9 downto 0);
   -- timing of updatedExp: (c0, 14.132000ns)
signal eqdiffsign :  std_logic;
   -- timing of eqdiffsign: (c0, 13.040000ns)
signal expFrac :  std_logic_vector(33 downto 0);
   -- timing of expFrac: (c0, 14.132000ns)
signal stk :  std_logic;
   -- timing of stk: (c0, 13.583000ns)
signal rnd :  std_logic;
   -- timing of rnd: (c0, 13.583000ns)
signal lsb :  std_logic;
   -- timing of lsb: (c0, 13.583000ns)
signal needToRound :  std_logic;
   -- timing of needToRound: (c0, 14.126000ns)
signal RoundedExpFrac :  std_logic_vector(33 downto 0);
   -- timing of RoundedExpFrac: (c0, 15.518000ns)
signal upExc :  std_logic_vector(1 downto 0);
   -- timing of upExc: (c0, 15.518000ns)
signal fracR :  std_logic_vector(22 downto 0);
   -- timing of fracR: (c0, 15.518000ns)
signal expR :  std_logic_vector(7 downto 0);
   -- timing of expR: (c0, 15.518000ns)
signal exExpExc :  std_logic_vector(3 downto 0);
   -- timing of exExpExc: (c0, 15.518000ns)
signal excRt2 :  std_logic_vector(1 downto 0);
   -- timing of excRt2: (c0, 16.061000ns)
signal excR :  std_logic_vector(1 downto 0);
   -- timing of excR: (c0, 16.604000ns)
signal signR2 :  std_logic;
   -- timing of signR2: (c0, 13.583000ns)
signal computedR :  std_logic_vector(33 downto 0);
   -- timing of computedR: (c0, 16.604000ns)
begin
   excExpFracX <= X(33 downto 32) & X(30 downto 0);
   excExpFracY <= Y(33 downto 32) & Y(30 downto 0);
   swap <= '1' when excExpFracX < excExpFracY else '0';
   -- exponent difference
   eXmeY <= (X(30 downto 23)) - (Y(30 downto 23));
   eYmeX <= (Y(30 downto 23)) - (X(30 downto 23));
   expDiff <= eXmeY when swap = '0' else eYmeX;
   -- input swap so that |X|>|Y|
   newX <= X when swap = '0' else Y;
   newY <= Y when swap = '0' else X;
   -- now we decompose the inputs into their sign, exponent, fraction
   expX<= newX(30 downto 23);
   excX<= newX(33 downto 32);
   excY<= newY(33 downto 32);
   signX<= newX(31);
   signY<= newY(31);
   EffSub <= signX xor signY;
   sXsYExnXY <= signX & signY & excX & excY;
   sdExnXY <= excX & excY;
   fracY <= "000000000000000000000000" when excY="00" else ('1' & newY(22 downto 0));
   -- Exception management logic
   with sXsYExnXY  select  
   excRt <= "00" when "000000"|"010000"|"100000"|"110000",
      "01" when "000101"|"010101"|"100101"|"110101"|"000100"|"010100"|"100100"|"110100"|"000001"|"010001"|"100001"|"110001",
      "10" when "111010"|"001010"|"001000"|"011000"|"101000"|"111000"|"000010"|"010010"|"100010"|"110010"|"001001"|"011001"|"101001"|"111001"|"000110"|"010110"|"100110"|"110110", 
      "11" when others;
   signR<= '0' when (sXsYExnXY="100000" or sXsYExnXY="010000") else signX;
   shiftedOut <= '1' when (expDiff > 25) else '0';
   shiftVal <= expDiff(4 downto 0) when shiftedOut='0' else CONV_STD_LOGIC_VECTOR(26,5);
   RightShifterComponent: RightShifterSticky24_by_max_26_Freq1_uid4
      port map ( clk  => clk,
                 S => shiftVal,
                 X => fracY,
                 R => shiftedFracY,
                 Sticky => sticky);
   fracYpad <= "0" & shiftedFracY;
   EffSubVector <= (26 downto 0 => EffSub);
   fracYpadXorOp <= fracYpad xor EffSubVector;
   fracXpad <= "01" & (newX(22 downto 0)) & "00";
   cInSigAdd <= EffSub and not sticky; -- if we subtract and the sticky was one, some of the negated sticky bits would have absorbed this carry 
   fracAdder: IntAdder_27_Freq1_uid6
      port map ( clk  => clk,
                 Cin => cInSigAdd,
                 X => fracXpad,
                 Y => fracYpadXorOp,
                 R => fracAddResult);
   fracSticky<= fracAddResult & sticky; 
   LZCAndShifter: Normalizer_Z_28_28_28_Freq1_uid8
      port map ( clk  => clk,
                 X => fracSticky,
                 Count => nZerosNew,
                 R => shiftedFrac);
   extendedExpInc<= ("0" & expX) + '1';
   updatedExp <= ("0" &extendedExpInc) - ("00000" & nZerosNew);
   eqdiffsign <= '1' when nZerosNew="11111" else '0';
   expFrac<= updatedExp & shiftedFrac(26 downto 3);
   stk<= shiftedFrac(2) or shiftedFrac(1) or shiftedFrac(0);
   rnd<= shiftedFrac(3);
   lsb<= shiftedFrac(4);
   needToRound<= '1' when (rnd='1' and stk='1') or (rnd='1' and stk='0' and lsb='1')
  else '0';
   roundingAdder: IntAdder_34_Freq1_uid11
      port map ( clk  => clk,
                 Cin => needToRound,
                 X => expFrac,
                 Y => "0000000000000000000000000000000000",
                 R => RoundedExpFrac);
   -- possible update to exception bits
   upExc <= RoundedExpFrac(33 downto 32);
   fracR <= RoundedExpFrac(23 downto 1);
   expR <= RoundedExpFrac(31 downto 24);
   exExpExc <= upExc & excRt;
   with exExpExc  select  
   excRt2<= "00" when "0000"|"0100"|"1000"|"1100"|"1001"|"1101",
      "01" when "0001",
      "10" when "0010"|"0110"|"1010"|"1110"|"0101",
      "11" when others;
   excR <= "00" when (eqdiffsign='1' and EffSub='1'  and not(excRt="11")) else excRt2;
   signR2 <= '0' when (eqdiffsign='1' and EffSub='1') else signR;
   computedR <= excR & signR2 & expR & fracR;
   R <= computedR;
end architecture;

