--------------------------------------------------------------------------------
--                RightShifterSticky24_by_max_26_Freq600_uid4
-- VHDL generated for Kintex7 @ 600MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- Pipeline depth: 3 cycles
-- Clock period (ns): 1.66667
-- Target frequency (MHz): 600
-- Input signals: X S
-- Output signals: R Sticky
--  approx. input signal timings: X: (c1, 0.825333ns)S: (c1, 1.392833ns)
--  approx. output signal timings: R: (c2, 1.028167ns)Sticky: (c4, 0.409083ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky24_by_max_26_Freq600_uid4 is
    port (clk : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          S : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(25 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky24_by_max_26_Freq600_uid4 is
signal ps, ps_d1, ps_d2 :  std_logic_vector(4 downto 0);
   -- timing of ps: (c1, 1.392833ns)
signal Xpadded :  std_logic_vector(25 downto 0);
   -- timing of Xpadded: (c1, 0.825333ns)
signal level5, level5_d1 :  std_logic_vector(25 downto 0);
   -- timing of level5: (c1, 0.825333ns)
signal stk4 :  std_logic;
   -- timing of stk4: (c2, 0.534167ns)
signal level4, level4_d1 :  std_logic_vector(25 downto 0);
   -- timing of level4: (c1, 1.392833ns)
signal stk3, stk3_d1 :  std_logic;
   -- timing of stk3: (c2, 1.101667ns)
signal level3, level3_d1 :  std_logic_vector(25 downto 0);
   -- timing of level3: (c2, 0.485167ns)
signal stk2 :  std_logic;
   -- timing of stk2: (c3, 0.206250ns)
signal level2, level2_d1 :  std_logic_vector(25 downto 0);
   -- timing of level2: (c2, 0.485167ns)
signal stk1 :  std_logic;
   -- timing of stk1: (c3, 0.761500ns)
signal level1, level1_d1 :  std_logic_vector(25 downto 0);
   -- timing of level1: (c2, 1.028167ns)
signal stk0, stk0_d1 :  std_logic;
   -- timing of stk0: (c3, 1.316750ns)
signal level0 :  std_logic_vector(25 downto 0);
   -- timing of level0: (c2, 1.028167ns)
signal stk :  std_logic;
   -- timing of stk: (c4, 0.409083ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            ps_d1 <=  ps;
            ps_d2 <=  ps_d1;
            level5_d1 <=  level5;
            level4_d1 <=  level4;
            stk3_d1 <=  stk3;
            level3_d1 <=  level3;
            level2_d1 <=  level2;
            level1_d1 <=  level1;
            stk0_d1 <=  stk0;
         end if;
      end process;
   ps<= S;
   Xpadded <= X&(1 downto 0 => '0');
   level5<= Xpadded;
   stk4 <= '1' when (level5_d1(15 downto 0)/="0000000000000000" and ps_d1(4)='1')   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => '0') & level5(25 downto 16);
   stk3 <= '1' when (level4_d1(7 downto 0)/="00000000" and ps_d1(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4_d1 when  ps_d1(3)='0'    else (7 downto 0 => '0') & level4_d1(25 downto 8);
   stk2 <= '1' when (level3_d1(3 downto 0)/="0000" and ps_d2(2)='1') or stk3_d1 ='1'   else '0';
   level2 <=  level3 when  ps_d1(2)='0'    else (3 downto 0 => '0') & level3(25 downto 4);
   stk1 <= '1' when (level2_d1(1 downto 0)/="00" and ps_d2(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps_d1(1)='0'    else (1 downto 0 => '0') & level2(25 downto 2);
   stk0 <= '1' when (level1_d1(0 downto 0)/="0" and ps_d2(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps_d1(0)='0'    else (0 downto 0 => '0') & level1(25 downto 1);
   stk <= stk0_d1;
   R <= level0;
   Sticky <= stk;
end architecture;

--------------------------------------------------------------------------------
--                          IntAdder_27_Freq600_uid6
-- VHDL generated for Kintex7 @ 600MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
-- Clock period (ns): 1.66667
-- Target frequency (MHz): 600
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c1, 0.282333ns)Y: (c3, 0.120500ns)Cin: (c4, 0.952083ns)
--  approx. output signal timings: R: (c5, 0.838417ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_27_Freq600_uid6 is
    port (clk : in std_logic;
          X : in  std_logic_vector(26 downto 0);
          Y : in  std_logic_vector(26 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(26 downto 0)   );
end entity;

architecture arch of IntAdder_27_Freq600_uid6 is
signal Cin_1, Cin_1_d1 :  std_logic;
   -- timing of Cin_1: (c4, 0.952083ns)
signal X_1, X_1_d1, X_1_d2, X_1_d3, X_1_d4 :  std_logic_vector(27 downto 0);
   -- timing of X_1: (c1, 0.282333ns)
signal Y_1, Y_1_d1, Y_1_d2 :  std_logic_vector(27 downto 0);
   -- timing of Y_1: (c3, 0.120500ns)
signal S_1 :  std_logic_vector(27 downto 0);
   -- timing of S_1: (c5, 0.838417ns)
signal R_1 :  std_logic_vector(26 downto 0);
   -- timing of R_1: (c5, 0.838417ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            Cin_1_d1 <=  Cin_1;
            X_1_d1 <=  X_1;
            X_1_d2 <=  X_1_d1;
            X_1_d3 <=  X_1_d2;
            X_1_d4 <=  X_1_d3;
            Y_1_d1 <=  Y_1;
            Y_1_d2 <=  Y_1_d1;
         end if;
      end process;
   Cin_1 <= Cin;
   X_1 <= '0' & X(26 downto 0);
   Y_1 <= '0' & Y(26 downto 0);
   S_1 <= X_1_d4 + Y_1_d2 + Cin_1_d1;
   R_1 <= S_1(26 downto 0);
   R <= R_1 ;
end architecture;

--------------------------------------------------------------------------------
--                     Normalizer_Z_28_28_28_Freq600_uid8
-- VHDL generated for Kintex7 @ 600MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
-- Clock period (ns): 1.66667
-- Target frequency (MHz): 600
-- Input signals: X
-- Output signals: Count R
--  approx. input signal timings: X: (c5, 0.838417ns)
--  approx. output signal timings: Count: (c9, 0.033000ns)R: (c9, 0.576000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_Z_28_28_28_Freq600_uid8 is
    port (clk : in std_logic;
          X : in  std_logic_vector(27 downto 0);
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(27 downto 0)   );
end entity;

architecture arch of Normalizer_Z_28_28_28_Freq600_uid8 is
signal level5, level5_d1 :  std_logic_vector(27 downto 0);
   -- timing of level5: (c5, 0.838417ns)
signal count4, count4_d1, count4_d2, count4_d3, count4_d4 :  std_logic;
   -- timing of count4: (c5, 1.430417ns)
signal level4, level4_d1 :  std_logic_vector(27 downto 0);
   -- timing of level4: (c6, 0.522750ns)
signal count3, count3_d1, count3_d2, count3_d3 :  std_logic;
   -- timing of count3: (c6, 1.090250ns)
signal level3 :  std_logic_vector(27 downto 0);
   -- timing of level3: (c7, 0.182583ns)
signal count2, count2_d1, count2_d2 :  std_logic;
   -- timing of count2: (c7, 0.737833ns)
signal level2, level2_d1 :  std_logic_vector(27 downto 0);
   -- timing of level2: (c7, 1.280833ns)
signal count1, count1_d1 :  std_logic;
   -- timing of count1: (c8, 0.385417ns)
signal level1, level1_d1 :  std_logic_vector(27 downto 0);
   -- timing of level1: (c8, 0.928417ns)
signal count0 :  std_logic;
   -- timing of count0: (c9, 0.033000ns)
signal level0 :  std_logic_vector(27 downto 0);
   -- timing of level0: (c9, 0.576000ns)
signal sCount :  std_logic_vector(4 downto 0);
   -- timing of sCount: (c9, 0.033000ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            level5_d1 <=  level5;
            count4_d1 <=  count4;
            count4_d2 <=  count4_d1;
            count4_d3 <=  count4_d2;
            count4_d4 <=  count4_d3;
            level4_d1 <=  level4;
            count3_d1 <=  count3;
            count3_d2 <=  count3_d1;
            count3_d3 <=  count3_d2;
            count2_d1 <=  count2;
            count2_d2 <=  count2_d1;
            level2_d1 <=  level2;
            count1_d1 <=  count1;
            level1_d1 <=  level1;
         end if;
      end process;
   level5 <= X ;
   count4<= '1' when level5(27 downto 12) = (27 downto 12=>'0') else '0';
   level4<= level5_d1(27 downto 0) when count4_d1='0' else level5_d1(11 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(27 downto 20) = (27 downto 20=>'0') else '0';
   level3<= level4_d1(27 downto 0) when count3_d1='0' else level4_d1(19 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(27 downto 24) = (27 downto 24=>'0') else '0';
   level2<= level3(27 downto 0) when count2='0' else level3(23 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2_d1(27 downto 26) = (27 downto 26=>'0') else '0';
   level1<= level2_d1(27 downto 0) when count1='0' else level2_d1(25 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1_d1(27 downto 27) = (27 downto 27=>'0') else '0';
   level0<= level1_d1(27 downto 0) when count0='0' else level1_d1(26 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4_d4 & count3_d3 & count2_d2 & count1_d1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         IntAdder_34_Freq600_uid11
-- VHDL generated for Kintex7 @ 600MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 10 cycles
-- Clock period (ns): 1.66667
-- Target frequency (MHz): 600
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c9, 1.125000ns)Y: (c0, 0.000000ns)Cin: (c9, 1.119000ns)
--  approx. output signal timings: R: (c10, 1.060333ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_34_Freq600_uid11 is
    port (clk : in std_logic;
          X : in  std_logic_vector(33 downto 0);
          Y : in  std_logic_vector(33 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(33 downto 0)   );
end entity;

architecture arch of IntAdder_34_Freq600_uid11 is
signal Cin_1, Cin_1_d1 :  std_logic;
   -- timing of Cin_1: (c9, 1.119000ns)
signal X_1, X_1_d1 :  std_logic_vector(34 downto 0);
   -- timing of X_1: (c9, 1.125000ns)
signal Y_1, Y_1_d1, Y_1_d2, Y_1_d3, Y_1_d4, Y_1_d5, Y_1_d6, Y_1_d7, Y_1_d8, Y_1_d9, Y_1_d10 :  std_logic_vector(34 downto 0);
   -- timing of Y_1: (c0, 0.000000ns)
signal S_1 :  std_logic_vector(34 downto 0);
   -- timing of S_1: (c10, 1.060333ns)
signal R_1 :  std_logic_vector(33 downto 0);
   -- timing of R_1: (c10, 1.060333ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            Cin_1_d1 <=  Cin_1;
            X_1_d1 <=  X_1;
            Y_1_d1 <=  Y_1;
            Y_1_d2 <=  Y_1_d1;
            Y_1_d3 <=  Y_1_d2;
            Y_1_d4 <=  Y_1_d3;
            Y_1_d5 <=  Y_1_d4;
            Y_1_d6 <=  Y_1_d5;
            Y_1_d7 <=  Y_1_d6;
            Y_1_d8 <=  Y_1_d7;
            Y_1_d9 <=  Y_1_d8;
            Y_1_d10 <=  Y_1_d9;
         end if;
      end process;
   Cin_1 <= Cin;
   X_1 <= '0' & X(33 downto 0);
   Y_1 <= '0' & Y(33 downto 0);
   S_1 <= X_1_d1 + Y_1_d10 + Cin_1_d1;
   R_1 <= S_1(33 downto 0);
   R <= R_1 ;
end architecture;

--------------------------------------------------------------------------------
--                          FPAdd_8_23_Freq600_uid2
-- VHDL generated for Kintex7 @ 600MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2010-2017)
--------------------------------------------------------------------------------
-- Pipeline depth: 11 cycles
-- Clock period (ns): 1.66667
-- Target frequency (MHz): 600
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c11, 0.695667ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPAdd_8_23_Freq600_uid2 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPAdd_8_23_Freq600_uid2 is
   component RightShifterSticky24_by_max_26_Freq600_uid4 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             S : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(25 downto 0);
             Sticky : out  std_logic   );
   end component;

   component IntAdder_27_Freq600_uid6 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(26 downto 0);
             Y : in  std_logic_vector(26 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(26 downto 0)   );
   end component;

   component Normalizer_Z_28_28_28_Freq600_uid8 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(27 downto 0);
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(27 downto 0)   );
   end component;

   component IntAdder_34_Freq600_uid11 is
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
signal swap, swap_d1 :  std_logic;
   -- timing of swap: (c0, 1.190000ns)
signal eXmeY, eXmeY_d1 :  std_logic_vector(7 downto 0);
   -- timing of eXmeY: (c0, 1.092000ns)
signal eYmeX, eYmeX_d1 :  std_logic_vector(7 downto 0);
   -- timing of eYmeX: (c0, 1.092000ns)
signal expDiff :  std_logic_vector(7 downto 0);
   -- timing of expDiff: (c1, 0.282333ns)
signal newX :  std_logic_vector(33 downto 0);
   -- timing of newX: (c1, 0.282333ns)
signal newY :  std_logic_vector(33 downto 0);
   -- timing of newY: (c1, 0.282333ns)
signal expX :  std_logic_vector(7 downto 0);
   -- timing of expX: (c1, 0.282333ns)
signal excX :  std_logic_vector(1 downto 0);
   -- timing of excX: (c1, 0.282333ns)
signal excY :  std_logic_vector(1 downto 0);
   -- timing of excY: (c1, 0.282333ns)
signal signX :  std_logic;
   -- timing of signX: (c1, 0.282333ns)
signal signY :  std_logic;
   -- timing of signY: (c1, 0.282333ns)
signal EffSub, EffSub_d1, EffSub_d2, EffSub_d3, EffSub_d4, EffSub_d5, EffSub_d6, EffSub_d7, EffSub_d8, EffSub_d9, EffSub_d10 :  std_logic;
   -- timing of EffSub: (c1, 0.825333ns)
signal sXsYExnXY :  std_logic_vector(5 downto 0);
   -- timing of sXsYExnXY: (c1, 0.282333ns)
signal sdExnXY :  std_logic_vector(3 downto 0);
   -- timing of sdExnXY: (c1, 0.282333ns)
signal fracY :  std_logic_vector(23 downto 0);
   -- timing of fracY: (c1, 0.825333ns)
signal excRt, excRt_d1, excRt_d2, excRt_d3, excRt_d4, excRt_d5, excRt_d6, excRt_d7, excRt_d8, excRt_d9, excRt_d10 :  std_logic_vector(1 downto 0);
   -- timing of excRt: (c1, 0.901333ns)
signal signR, signR_d1, signR_d2, signR_d3, signR_d4, signR_d5, signR_d6, signR_d7, signR_d8 :  std_logic;
   -- timing of signR: (c1, 0.825333ns)
signal shiftedOut :  std_logic;
   -- timing of shiftedOut: (c1, 0.849833ns)
signal shiftVal :  std_logic_vector(4 downto 0);
   -- timing of shiftVal: (c1, 1.392833ns)
signal shiftedFracY :  std_logic_vector(25 downto 0);
   -- timing of shiftedFracY: (c2, 1.028167ns)
signal sticky, sticky_d1 :  std_logic;
   -- timing of sticky: (c4, 0.409083ns)
signal fracYpad, fracYpad_d1 :  std_logic_vector(26 downto 0);
   -- timing of fracYpad: (c2, 1.028167ns)
signal EffSubVector, EffSubVector_d1, EffSubVector_d2 :  std_logic_vector(26 downto 0);
   -- timing of EffSubVector: (c1, 0.825333ns)
signal fracYpadXorOp :  std_logic_vector(26 downto 0);
   -- timing of fracYpadXorOp: (c3, 0.120500ns)
signal fracXpad :  std_logic_vector(26 downto 0);
   -- timing of fracXpad: (c1, 0.282333ns)
signal cInSigAdd :  std_logic;
   -- timing of cInSigAdd: (c4, 0.952083ns)
signal fracAddResult :  std_logic_vector(26 downto 0);
   -- timing of fracAddResult: (c5, 0.838417ns)
signal fracSticky :  std_logic_vector(27 downto 0);
   -- timing of fracSticky: (c5, 0.838417ns)
signal nZerosNew :  std_logic_vector(4 downto 0);
   -- timing of nZerosNew: (c9, 0.033000ns)
signal shiftedFrac :  std_logic_vector(27 downto 0);
   -- timing of shiftedFrac: (c9, 0.576000ns)
signal extendedExpInc, extendedExpInc_d1, extendedExpInc_d2, extendedExpInc_d3, extendedExpInc_d4, extendedExpInc_d5, extendedExpInc_d6, extendedExpInc_d7, extendedExpInc_d8 :  std_logic_vector(8 downto 0);
   -- timing of extendedExpInc: (c1, 1.374333ns)
signal updatedExp :  std_logic_vector(9 downto 0);
   -- timing of updatedExp: (c9, 1.125000ns)
signal eqdiffsign, eqdiffsign_d1, eqdiffsign_d2 :  std_logic;
   -- timing of eqdiffsign: (c9, 0.033000ns)
signal expFrac :  std_logic_vector(33 downto 0);
   -- timing of expFrac: (c9, 1.125000ns)
signal stk :  std_logic;
   -- timing of stk: (c9, 0.576000ns)
signal rnd :  std_logic;
   -- timing of rnd: (c9, 0.576000ns)
signal lsb :  std_logic;
   -- timing of lsb: (c9, 0.576000ns)
signal needToRound :  std_logic;
   -- timing of needToRound: (c9, 1.119000ns)
signal RoundedExpFrac :  std_logic_vector(33 downto 0);
   -- timing of RoundedExpFrac: (c10, 1.060333ns)
signal upExc :  std_logic_vector(1 downto 0);
   -- timing of upExc: (c10, 1.060333ns)
signal fracR, fracR_d1 :  std_logic_vector(22 downto 0);
   -- timing of fracR: (c10, 1.060333ns)
signal expR, expR_d1 :  std_logic_vector(7 downto 0);
   -- timing of expR: (c10, 1.060333ns)
signal exExpExc, exExpExc_d1 :  std_logic_vector(3 downto 0);
   -- timing of exExpExc: (c10, 1.060333ns)
signal excRt2 :  std_logic_vector(1 downto 0);
   -- timing of excRt2: (c11, 0.152667ns)
signal excR :  std_logic_vector(1 downto 0);
   -- timing of excR: (c11, 0.695667ns)
signal signR2, signR2_d1, signR2_d2 :  std_logic;
   -- timing of signR2: (c9, 0.576000ns)
signal computedR :  std_logic_vector(33 downto 0);
   -- timing of computedR: (c11, 0.695667ns)
signal X_d1 :  std_logic_vector(8+23+2 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal Y_d1 :  std_logic_vector(8+23+2 downto 0);
   -- timing of Y: (c0, 0.000000ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            swap_d1 <=  swap;
            eXmeY_d1 <=  eXmeY;
            eYmeX_d1 <=  eYmeX;
            EffSub_d1 <=  EffSub;
            EffSub_d2 <=  EffSub_d1;
            EffSub_d3 <=  EffSub_d2;
            EffSub_d4 <=  EffSub_d3;
            EffSub_d5 <=  EffSub_d4;
            EffSub_d6 <=  EffSub_d5;
            EffSub_d7 <=  EffSub_d6;
            EffSub_d8 <=  EffSub_d7;
            EffSub_d9 <=  EffSub_d8;
            EffSub_d10 <=  EffSub_d9;
            excRt_d1 <=  excRt;
            excRt_d2 <=  excRt_d1;
            excRt_d3 <=  excRt_d2;
            excRt_d4 <=  excRt_d3;
            excRt_d5 <=  excRt_d4;
            excRt_d6 <=  excRt_d5;
            excRt_d7 <=  excRt_d6;
            excRt_d8 <=  excRt_d7;
            excRt_d9 <=  excRt_d8;
            excRt_d10 <=  excRt_d9;
            signR_d1 <=  signR;
            signR_d2 <=  signR_d1;
            signR_d3 <=  signR_d2;
            signR_d4 <=  signR_d3;
            signR_d5 <=  signR_d4;
            signR_d6 <=  signR_d5;
            signR_d7 <=  signR_d6;
            signR_d8 <=  signR_d7;
            sticky_d1 <=  sticky;
            fracYpad_d1 <=  fracYpad;
            EffSubVector_d1 <=  EffSubVector;
            EffSubVector_d2 <=  EffSubVector_d1;
            extendedExpInc_d1 <=  extendedExpInc;
            extendedExpInc_d2 <=  extendedExpInc_d1;
            extendedExpInc_d3 <=  extendedExpInc_d2;
            extendedExpInc_d4 <=  extendedExpInc_d3;
            extendedExpInc_d5 <=  extendedExpInc_d4;
            extendedExpInc_d6 <=  extendedExpInc_d5;
            extendedExpInc_d7 <=  extendedExpInc_d6;
            extendedExpInc_d8 <=  extendedExpInc_d7;
            eqdiffsign_d1 <=  eqdiffsign;
            eqdiffsign_d2 <=  eqdiffsign_d1;
            fracR_d1 <=  fracR;
            expR_d1 <=  expR;
            exExpExc_d1 <=  exExpExc;
            signR2_d1 <=  signR2;
            signR2_d2 <=  signR2_d1;
            X_d1 <=  X;
            Y_d1 <=  Y;
         end if;
      end process;
   excExpFracX <= X(33 downto 32) & X(30 downto 0);
   excExpFracY <= Y(33 downto 32) & Y(30 downto 0);
   swap <= '1' when excExpFracX < excExpFracY else '0';
   -- exponent difference
   eXmeY <= (X(30 downto 23)) - (Y(30 downto 23));
   eYmeX <= (Y(30 downto 23)) - (X(30 downto 23));
   expDiff <= eXmeY_d1 when swap_d1 = '0' else eYmeX_d1;
   -- input swap so that |X|>|Y|
   newX <= X_d1 when swap_d1 = '0' else Y_d1;
   newY <= Y_d1 when swap_d1 = '0' else X_d1;
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
   RightShifterComponent: RightShifterSticky24_by_max_26_Freq600_uid4
      port map ( clk  => clk,
                 S => shiftVal,
                 X => fracY,
                 R => shiftedFracY,
                 Sticky => sticky);
   fracYpad <= "0" & shiftedFracY;
   EffSubVector <= (26 downto 0 => EffSub);
   fracYpadXorOp <= fracYpad_d1 xor EffSubVector_d2;
   fracXpad <= "01" & (newX(22 downto 0)) & "00";
   cInSigAdd <= EffSub_d3 and not sticky; -- if we subtract and the sticky was one, some of the negated sticky bits would have absorbed this carry 
   fracAdder: IntAdder_27_Freq600_uid6
      port map ( clk  => clk,
                 Cin => cInSigAdd,
                 X => fracXpad,
                 Y => fracYpadXorOp,
                 R => fracAddResult);
   fracSticky<= fracAddResult & sticky_d1; 
   LZCAndShifter: Normalizer_Z_28_28_28_Freq600_uid8
      port map ( clk  => clk,
                 X => fracSticky,
                 Count => nZerosNew,
                 R => shiftedFrac);
   extendedExpInc<= ("0" & expX) + '1';
   updatedExp <= ("0" &extendedExpInc_d8) - ("00000" & nZerosNew);
   eqdiffsign <= '1' when nZerosNew="11111" else '0';
   expFrac<= updatedExp & shiftedFrac(26 downto 3);
   stk<= shiftedFrac(2) or shiftedFrac(1) or shiftedFrac(0);
   rnd<= shiftedFrac(3);
   lsb<= shiftedFrac(4);
   needToRound<= '1' when (rnd='1' and stk='1') or (rnd='1' and stk='0' and lsb='1')
  else '0';
   roundingAdder: IntAdder_34_Freq600_uid11
      port map ( clk  => clk,
                 Cin => needToRound,
                 X => expFrac,
                 Y => "0000000000000000000000000000000000",
                 R => RoundedExpFrac);
   -- possible update to exception bits
   upExc <= RoundedExpFrac(33 downto 32);
   fracR <= RoundedExpFrac(23 downto 1);
   expR <= RoundedExpFrac(31 downto 24);
   exExpExc <= upExc & excRt_d9;
   with exExpExc_d1  select  
   excRt2<= "00" when "0000"|"0100"|"1000"|"1100"|"1001"|"1101",
      "01" when "0001",
      "10" when "0010"|"0110"|"1010"|"1110"|"0101",
      "11" when others;
   excR <= "00" when (eqdiffsign_d2='1' and EffSub_d10='1'  and not(excRt_d10="11")) else excRt2;
   signR2 <= '0' when (eqdiffsign='1' and EffSub_d8='1') else signR_d8;
   computedR <= excR & signR2_d2 & expR_d1 & fracR_d1;
   R <= computedR;
end architecture;

