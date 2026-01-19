
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

entity FPALL_Shared is
    port (
        clk : in std_logic;
        opcode : in std_logic_vector(1 downto 0); -- 00: Add, 01: Mul, 10: Sqrt, 11: Div
        X : in std_logic_vector(33 downto 0);
        Y : in std_logic_vector(33 downto 0);
        R : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPALL_Shared is

    component FPAdd_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            expFrac_out : out std_logic_vector(33 downto 0);
            round_out : out std_logic;
            RoundedExpFrac_in : in std_logic_vector(33 downto 0);
            fracAdder_X_out : out std_logic_vector(26 downto 0);
            fracAdder_Y_out : out std_logic_vector(26 downto 0);
            fracAdder_Cin_out : out std_logic;
            fracAdder_R_in : in std_logic_vector(26 downto 0)
        );
    end component;

    component FPMult_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            expSig_out : out std_logic_vector(32 downto 0);
            round_out : out std_logic;
            expSigPostRound_in : in std_logic_vector(32 downto 0);
            expAdder_X_out : out std_logic_vector(7 downto 0);
            expAdder_Y_out : out std_logic_vector(7 downto 0);
            expAdder_Cin_out : out std_logic;
            expAdder_R_in : in std_logic_vector(26 downto 0)
        );
    end component;

    component FPSqrt_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            round_out : out std_logic;
            expFrac_out: out std_logic_vector(22 downto 0);
            RoundedExpFrac_in : in std_logic_vector(22 downto 0)
        );
    end component;

    component FPDiv_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            round_out : out std_logic;
            expfrac_out: out std_logic_vector(32 downto 0);
            expfracR_in : in std_logic_vector(32 downto 0)
        );
    end component;
    
    component IntAdder_34_Freq1_uid11 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(33 downto 0);
              Y : in  std_logic_vector(33 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(33 downto 0)   );
    end component;
    
    component IntAdder_27_Freq1_uid6 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(26 downto 0);
              Y : in  std_logic_vector(26 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(26 downto 0)   );
    end component;

    -- Add signals
    signal add_R : std_logic_vector(33 downto 0);
    signal add_expFrac : std_logic_vector(33 downto 0);
    signal add_round : std_logic;
    signal add_ResultBack : std_logic_vector(33 downto 0);
    
    -- Mul signals
    signal mul_R : std_logic_vector(33 downto 0);
    signal mul_expSig : std_logic_vector(32 downto 0);
    signal mul_round : std_logic;
    signal mul_ResultBack : std_logic_vector(32 downto 0);

    -- Sqrt signals
    signal sqrt_R : std_logic_vector(33 downto 0);
    signal sqrt_expFrac : std_logic_vector(22 downto 0);
    signal sqrt_round : std_logic;
    signal sqrt_ResultBack : std_logic_vector(22 downto 0);

    -- Div signals
    signal div_R : std_logic_vector(33 downto 0);
    signal div_expfrac : std_logic_vector(32 downto 0);
    signal div_round : std_logic;
    signal div_ResultBack : std_logic_vector(32 downto 0);
    
    -- Shared Adder signals
    signal ra_X : std_logic_vector(33 downto 0);
    signal ra_Cin : std_logic;
    signal ra_R : std_logic_vector(33 downto 0);
    
    -- Shared IntAdder_27 signals
    signal add_fracAdder_X : std_logic_vector(26 downto 0);
    signal add_fracAdder_Y : std_logic_vector(26 downto 0);
    signal add_fracAdder_Cin : std_logic;
    signal add_fracAdder_R : std_logic_vector(26 downto 0);
    
    signal mul_expAdder_X : std_logic_vector(7 downto 0);
    signal mul_expAdder_Y : std_logic_vector(7 downto 0);
    signal mul_expAdder_Cin : std_logic;
    signal mul_expAdder_R : std_logic_vector(26 downto 0);
    
    signal ia27_X : std_logic_vector(26 downto 0);
    signal ia27_Y : std_logic_vector(26 downto 0);
    signal ia27_Cin : std_logic;
    signal ia27_R : std_logic_vector(26 downto 0);

begin

    -- Instantiate FPAdd (No RA)
    U_ADD: FPAdd_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => add_R,
        expFrac_out => add_expFrac,
        round_out => add_round,
        RoundedExpFrac_in => add_ResultBack,
        fracAdder_X_out => add_fracAdder_X,
        fracAdder_Y_out => add_fracAdder_Y,
        fracAdder_Cin_out => add_fracAdder_Cin,
        fracAdder_R_in => add_fracAdder_R
    );

    -- Instantiate FPMult (No RA)
    U_MUL: FPMult_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => mul_R,
        expSig_out => mul_expSig,
        round_out => mul_round,
        expSigPostRound_in => mul_ResultBack,
        expAdder_X_out => mul_expAdder_X,
        expAdder_Y_out => mul_expAdder_Y,
        expAdder_Cin_out => mul_expAdder_Cin,
        expAdder_R_in => mul_expAdder_R
    );

    -- Instantiate FPSqrt (No RA)
    U_SQRT: FPSqrt_NoRA
    port map (
        clk => clk,
        X => X,
        R => sqrt_R,
        expFrac_out => sqrt_expFrac,
        round_out => sqrt_round,
        RoundedExpFrac_in => sqrt_ResultBack
    );

    -- Instantiate FPDiv (No RA)
    U_DIV: FPDiv_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => div_R,
        expfrac_out => div_expfrac,
        round_out => div_round,
        expfracR_in => div_ResultBack
    );
    
    -- Multiplex inputs to Shared Rounding Adder
    -- opcode: 00=Add, 01=Mul, 10=Sqrt, 11=Div
    ra_X(33) <= add_expFrac(33);
    ra_X(32 downto 23) <= add_expFrac(32 downto 23) when opcode="00" else 
                        mul_expSig(32 downto 23) when opcode="01" else
                        div_expfrac(32 downto 23); -- 11 for Div

    ra_X(22 downto 0) <= add_expFrac(22 downto 0) when opcode="00" else 
            mul_expSig(22 downto 0) when opcode="01" else
            sqrt_expFrac when opcode="10" else
            div_expfrac(22 downto 0); -- 11 for Div
            
    ra_Cin <= add_round when opcode="00" else 
              mul_round when opcode="01" else
              sqrt_round when opcode="10" else
              div_round;
    
    -- Multiplex inputs to Shared IntAdder_27
    -- opcode: 00=Add (fracAdder), 01=Mul (expAdder), others unused
    ia27_X(26 downto 8) <= add_fracAdder_X(26 downto 8);
    ia27_X(7 downto 0) <= add_fracAdder_X (7 downto 0) when opcode="00" else
              mul_expAdder_X; -- when opcode="01"
    ia27_Y(26 downto 8) <= add_fracAdder_Y(26 downto 8);
    ia27_Y(7 downto 0)<= add_fracAdder_Y(7 downto 0) when opcode="00" else
              mul_expAdder_Y; -- when opcode="01"
    
    ia27_Cin <= add_fracAdder_Cin when opcode="00" else
                mul_expAdder_Cin; -- when opcode="01"
    
    -- Shared IntAdder_27 for Add frac addition and Mult exp addition
    U_SHARED_IA27: IntAdder_27_Freq1_uid6
    port map (
        clk => clk,
        X => ia27_X,
        Y => ia27_Y,
        Cin => ia27_Cin,
        R => ia27_R
    );
    
    -- Route IntAdder_27 outputs back
    add_fracAdder_R <= ia27_R;
    mul_expAdder_R <= ia27_R;
    
    -- Shared Rounding Adder (34 bits)
    U_SHARED_RA: IntAdder_34_Freq1_uid11
    port map (
        clk => clk,
        X => ra_X,
        Y => (others => '0'),
        Cin => ra_Cin,
        R => ra_R
    );
    
    -- Route outputs back
    -- Add expects 34 bits
    add_ResultBack <= ra_R;
    
    -- Mul expects 33 bits
    mul_ResultBack <= ra_R(32 downto 0);
    
    -- Sqrt expects 34 bits
    sqrt_ResultBack <= ra_R(22 downto 0);

    -- Div expects 33 bits
    div_ResultBack <= ra_R(32 downto 0);
    
    -- Final Output Mux
    R <= add_R when opcode="00" else 
         mul_R when opcode="01" else
         sqrt_R when opcode="10" else
         div_R;

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


entity FPAdd_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          round_out : out std_logic;
          expFrac_out: out std_logic_vector(33 downto 0);
          RoundedExpFrac_in : in std_logic_vector(33 downto 0); -- 再び入れるという不気味な形ではあるが、combinationalなので
          -- Shared IntAdder_27 ports
          fracAdder_X_out : out std_logic_vector(26 downto 0);
          fracAdder_Y_out : out std_logic_vector(26 downto 0);
          fracAdder_Cin_out : out std_logic;
          fracAdder_R_in : in std_logic_vector(26 downto 0));
end entity;

architecture arch of FPAdd_NoRA is
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

   -- component IntAdder_34_Freq1_uid11 is
   --    port ( clk : in std_logic;
   --           X : in  std_logic_vector(33 downto 0);
   --           Y : in  std_logic_vector(33 downto 0);
   --           Cin : in  std_logic;
   --           R : out  std_logic_vector(33 downto 0)   );
   -- end component;

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
signal round :  std_logic;
   -- timing of round: (c0, 14.126000ns)
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
   swap <= '1' when excExpFracX < excExpFracY else '0'; -- x is lager then y
   -- exponent difference
   eXmeY <= (X(30 downto 23)) - (Y(30 downto 23));
   eYmeX <= (Y(30 downto 23)) - (X(30 downto 23));
   expDiff <= eXmeY when swap = '0' else eYmeX;
   -- input swap so that |X|>|Y|
   newX <= X when swap = '0' else Y;
   newY <= Y when swap = '0' else X;
   -- now we decompose the inputs into their sign, exponent, fraction
   expX<= newX(30 downto 23);
   excX<= newX(33 downto 32); -- normal などの表示
   excY<= newY(33 downto 32);
   signX<= newX(31);
   signY<= newY(31);
   EffSub <= signX xor signY;
   sXsYExnXY <= signX & signY & excX & excY;
   sdExnXY <= excX & excY; -- not used
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
                 S => shiftVal, -- in
                 X => fracY, --in 
                 R => shiftedFracY, -- out
                 Sticky => sticky); -- out shiftoutがどれか一つでも1なら1かな
   fracYpad <= "0" & shiftedFracY; -- 27bit
   EffSubVector <= (26 downto 0 => EffSub); -- maskの役割
   fracYpadXorOp <= fracYpad xor EffSubVector; --27bit
   fracXpad <= "01" & (newX(22 downto 0)) & "00"; --27bit
   cInSigAdd <= EffSub and not sticky; -- if we subtract and the sticky was one, some of the negated sticky bits would have absorbed this carry 
   -- Connect to shared IntAdder_27 via ports
   fracAdder_X_out <= fracXpad;
   fracAdder_Y_out <= fracYpadXorOp;
   fracAdder_Cin_out <= cInSigAdd;
   fracAddResult <= fracAdder_R_in;
   fracSticky<= fracAddResult & sticky; -- stickyありの計算結果
   LZCAndShifter: Normalizer_Z_28_28_28_Freq1_uid8 --オーバーフローを考えて28桁なってる
      port map ( clk  => clk,
                 X => fracSticky,
                 Count => nZerosNew, -- 先頭の0の数　maxで5桁
                 R => shiftedFrac); -- 1.　。。。の形をしている -28桁
   extendedExpInc<= ("0" & expX) + '1'; -- 28桁でやってる分1をプラスしてる
   updatedExp <= ("0" &extendedExpInc) - ("00000" & nZerosNew); -- 5桁だったので、8と+2で10. 11. . .って時は1になろうようにして、減らす量を調整してる
   -- updatedExpが最終的なexp.あとは丸め誤差用
   eqdiffsign <= '1' when nZerosNew="11111" else '0'; --完全に0になったパターン
   expFrac<= updatedExp & shiftedFrac(26 downto 3); -- 
   stk<= shiftedFrac(2) or shiftedFrac(1) or shiftedFrac(0); 
   rnd<= shiftedFrac(3);
   lsb<= shiftedFrac(4);
   round<= '1' when (rnd='1' and stk='1') or (rnd='1' and stk='0' and lsb='1')
  else '0';
   -- roundingAdder: IntAdder_34_Freq1_uid11
   --    port map ( clk  => clk,
   --               Cin => round,
   --               X => expFrac,
   --               Y => "0000000000000000000000000000000000",
   --               R => RoundedExpFrac);
   -- possible update to exception bits
   expFrac_out <=expFrac;
   round_out <= round;

   -- ここまでで一回外にでて、また外から戻ってくる
   RoundedExpFrac <= RoundedExpFrac_in;
   upExc <= RoundedExpFrac(33 downto 32); -- overflowで01, underflowで11になる
   fracR <= RoundedExpFrac(23 downto 1); --23bit
   expR <= RoundedExpFrac(31 downto 24); --8bit
   exExpExc <= upExc & excRt;
   with exExpExc  select  
   -- upExc は00で正常。 01でover, 11でunder
   -- excRtは00がzero, 01が正常、10が無限(overflow), 11がNan
   excRt2<= "00" when "0000"|"0100"|"1000"|"1100"|"1001"|"1101",
      "01" when "0001",
      "10" when "0010"|"0110"|"1010"|"1110"|"0101",
      "11" when others;
   excR <= "00" when (eqdiffsign='1' and EffSub='1'  and not(excRt="11")) else excRt2;
   signR2 <= '0' when (eqdiffsign='1' and EffSub='1') else signR;
   computedR <= excR & signR2 & expR & fracR;
   R <= computedR;
end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPMult_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          round_out : out std_logic;
          expSig_out : out std_logic_vector(32 downto 0);
          expSigPostRound_in : in std_logic_vector(32 downto 0);
          -- Shared IntAdder_27 ports for exp calculations
          expAdder_X_out : out std_logic_vector(7 downto 0);
          expAdder_Y_out : out std_logic_vector(7 downto 0);
          expAdder_Cin_out : out std_logic;
          expAdder_R_in : in std_logic_vector(26 downto 0) );
end entity;

architecture arch of FPMult_NoRA is 
   component IntMultiplier_24x24_48_Freq1_uid5 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;

   -- component IntAdder_33_Freq1_uid280 is
   --    port ( clk : in std_logic;
   --           X : in  std_logic_vector(32 downto 0);
   --           Y : in  std_logic_vector(32 downto 0);
   --           Cin : in  std_logic;
   --           R : out  std_logic_vector(32 downto 0)   );
   -- end component;

signal sign :  std_logic;
   -- timing of sign: (c0, 0.043000ns)
signal expX :  std_logic_vector(7 downto 0);
   -- timing of expX: (c0, 0.000000ns)
signal expY :  std_logic_vector(7 downto 0);
   -- timing of expY: (c0, 0.000000ns)
signal expSumPreSub :  std_logic_vector(9 downto 0);
   -- timing of expSumPreSub: (c0, 1.092000ns)
signal bias :  std_logic_vector(9 downto 0);
   -- timing of bias: (c0, 0.000000ns)
signal expSum :  std_logic_vector(9 downto 0);
   -- timing of expSum: (c0, 2.184000ns)
signal sigX :  std_logic_vector(23 downto 0);
   -- timing of sigX: (c0, 0.000000ns)
signal sigY :  std_logic_vector(23 downto 0);
   -- timing of sigY: (c0, 0.000000ns)
signal sigProd :  std_logic_vector(47 downto 0);
   -- timing of sigProd: (c0, 4.870000ns)
   -- signals removed for shared exception handling (excSel, exc, excPostNorm, finalExc)
   -- Restoring arithmetic signals
   signal norm :  std_logic;
   signal expPostNorm :  std_logic_vector(9 downto 0);
   signal sigProdExt :  std_logic_vector(47 downto 0);
   signal expSig :  std_logic_vector(32 downto 0);
   signal sticky :  std_logic;
   signal guard :  std_logic;
   signal round :  std_logic;
   signal expSigPostRound :  std_logic_vector(32 downto 0);
begin
   sign <= X(31) xor Y(31);
   expX <= X(30 downto 23);
   expY <= Y(30 downto 23);
   
   -- Use shared IntAdder_27 for expSumPreSub calculation
   -- Pad 10-bit values to 27-bit
   expAdder_X_out <=expX;  -- 8bit  
   expAdder_Y_out <=expY;  -- 8bit
   expAdder_Cin_out <= '0';
   expSumPreSub <= expAdder_R_in(9 downto 0);  -- Extract lower 10 bits
   
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub - bias;
   sigX <= "1" & X(22 downto 0);
   sigY <= "1" & Y(22 downto 0);
   SignificandMultiplication: IntMultiplier_24x24_48_Freq1_uid5
      port map ( clk  => clk,
                 X => sigX,
                 Y => sigY,
                 R => sigProd); -- 48bit
   -- excSel logic removed


   norm <= sigProd(47); -- 最大桁
   -- exponent update
   expPostNorm <= expSum + ("000000000" & norm); -- 最上位が1ならexpを1つ挙げる. [1,2)同士の掛け算は[2,4), 11ならnormが1になるからexpを上げる
   -- significand normalization shift
   sigProdExt <= sigProd(46 downto 0) & "0" when norm='1' else
                         sigProd(45 downto 0) & "00"; --normが0なら01. . ってつづくから1でカットしていい
   expSig <= expPostNorm & sigProdExt(47 downto 25);
   sticky <= sigProdExt(24); -- addとは意味が違う sticky, guardの順番(addはguard, stickyだった)
   guard <= '0' when sigProdExt(23 downto 0)="000000000000000000000000" else '1';
   round <= sticky and ( (guard and not(sigProdExt(25))) or (sigProdExt(25) ))  ;
   -- RoundingAdder: IntAdder_33_Freq1_uid280
   --    port map ( clk  => clk,
   --               Cin => round,
   --               X => expSig,
   --               Y => "000000000000000000000000000000000",
   --               R => expSigPostRound);
   round_out <= round;
   expSig_out <= expSig;
   expSigPostRound <= expSigPostRound_in;
   -- Final result construction removed
   R <= (others => '0');

end architecture;


--------------------------------------------------------------------------------
--                           FPDiv_NoRA
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

entity FPDiv_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          round_out : out std_logic;
          expfrac_out: out std_logic_vector(32 downto 0);
          expfracR_in : in std_logic_vector(32 downto 0)
          );
end entity;

architecture arch of FPDiv_NoRA is
   component selFunction_Freq1_uid4 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : out  std_logic_vector(2 downto 0)   );
   end component;

signal fX :  std_logic_vector(23 downto 0);
signal fY :  std_logic_vector(23 downto 0);
signal expR0 :  std_logic_vector(9 downto 0);
signal sR :  std_logic;
signal exnXY :  std_logic_vector(3 downto 0);
signal exnR0 :  std_logic_vector(1 downto 0);
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
signal mR :  std_logic_vector(25 downto 0);
signal fRnorm :  std_logic_vector(23 downto 0);
signal round :  std_logic;
signal expR1 :  std_logic_vector(9 downto 0);
signal expfrac :  std_logic_vector(32 downto 0);
signal expfracR :  std_logic_vector(32 downto 0);
signal exnR :  std_logic_vector(1 downto 0);
signal exnRfinal :  std_logic_vector(1 downto 0);
begin
   fX <= "1" & X(22 downto 0);
   fY <= "1" & Y(22 downto 0);
   expR0 <= ("00" & X(30 downto 23)) - ("00" & Y(30 downto 23));
   sR <= X(31) xor Y(31);
   exnXY <= X(33 downto 32) & Y(33 downto 32);
   with exnXY  select 
      exnR0 <= 
         "01"	 when "0101",
         "00"	 when "0001" | "0010" | "0110",
         "10"	 when "0100" | "1000" | "1001",
         "11"	 when others;

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

   with q14(2)  select
   w13<= betaw14 - absq14D when '0',
         betaw14 + absq14D when others;

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

   with q13(2)  select 
   w12<= betaw13 - absq13D when '0',
         betaw13 + absq13D when others;

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

   with q12(2)  select 
   w11<= betaw12 - absq12D when '0',
         betaw12 + absq12D when others;

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

   with q11(2)  select 
   w10<= betaw11 - absq11D when '0',
         betaw11 + absq11D when others;

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

   with q10(2)  select 
   w9<= betaw10 - absq10D when '0',
         betaw10 + absq10D when others;

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

   with q9(2)  select 
   w8<= betaw9 - absq9D when '0',
         betaw9 + absq9D when others;

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

   with q8(2)  select 
   w7<= betaw8 - absq8D when '0',
         betaw8 + absq8D when others;

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

   with q7(2)  select 
   w6<= betaw7 - absq7D when '0',
         betaw7 + absq7D when others;

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

   with q6(2)  select 
   w5<= betaw6 - absq6D when '0',
         betaw6 + absq6D when others;

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

   with q5(2)  select 
   w4<= betaw5 - absq5D when '0',
         betaw5 + absq5D when others;

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

   with q4(2)  select 
   w3<= betaw4 - absq4D when '0',
         betaw4 + absq4D when others;

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

   with q3(2)  select 
   w2<= betaw3 - absq3D when '0',
         betaw3 + absq3D when others;

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

   with q2(2)  select 
   w1<= betaw2 - absq2D when '0',
         betaw2 + absq2D when others;

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

   with q1(2)  select 
   w0<= betaw1 - absq1D when '0',
         betaw1 + absq1D when others;

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
   mR <= quotient(26 downto 1);
   fRnorm <=    mR(24 downto 1)  when mR(25)= '1'
           else mR(23 downto 0);
   round <= fRnorm(0); 
   expR1 <= expR0 + ("000" & (6 downto 1 => '1') & mR(25));
   expfrac <= expR1 & fRnorm(23 downto 1) ;
   
   -- Output to shared rounding adder
   expfrac_out <= expfrac;
   round_out <= round;
   
   -- Input from shared rounding adder
   expfracR <= expfracR_in;
   
   exnR <=      "00"  when expfracR(32) = '1'
           else "10"  when  expfracR(32 downto 31) =  "01"
           else "01";
   with exnR0  select 
      exnRfinal <= 
         exnR   when "01",
         exnR0  when others;
   R <= exnRfinal & sR & expfracR(30 downto 0);
end architecture;





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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPSqrt_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          round_out : out std_logic;
          expFrac_out: out std_logic_vector(33 downto 0);
          RoundedExpFrac_in : in std_logic_vector(33 downto 0)
          );
end entity;

architecture arch of FPSqrt_NoRA is
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
   T12_h <=   T10s_h - U10 when d10='1'
        else T10s_h + U10;
   T11 <= T12_h(13 downto 0) & T10s_l;
   S10 <= S9 & d10; -- here -1 becomes 0 and 1 becomes 1
   -- Step 12
   d11 <= not T11(26); --  bit of weight -11
   T11s <= T11 & "0";
   T11s_h <= T11s(27 downto 12);
   T11s_l <= T11s(11 downto 0);
   U11 <=  "0" & S10 & d11 & (not d11) & "1"; 
   T13_h <=   T11s_h - U11 when d11='1'
        else T11s_h + U11;
   T12 <= T13_h(14 downto 0) & T11s_l;
   S11 <= S10 & d11; -- here -1 becomes 0 and 1 becomes 1
   -- Step 13
   d12 <= not T12(26); --  bit of weight -12
   T12s <= T12 & "0";
   T12s_h <= T12s(27 downto 11);
   T12s_l <= T12s(10 downto 0);
   U12 <=  "0" & S11 & d12 & (not d12) & "1"; 
   T14_h <=   T12s_h - U12 when d12='1'
        else T12s_h + U12;
   T13 <= T14_h(15 downto 0) & T12s_l;
   S12 <= S11 & d12; -- here -1 becomes 0 and 1 becomes 1
   -- Step 14
   d13 <= not T13(26); --  bit of weight -13
   T13s <= T13 & "0";
   T13s_h <= T13s(27 downto 10);
   T13s_l <= T13s(9 downto 0);
   U13 <=  "0" & S12 & d13 & (not d13) & "1"; 
   T15_h <=   T13s_h - U13 when d13='1'
        else T13s_h + U13;
   T14 <= T15_h(16 downto 0) & T13s_l;
   S13 <= S12 & d13; -- here -1 becomes 0 and 1 becomes 1
   -- Step 15
   d14 <= not T14(26); --  bit of weight -14
   T14s <= T14 & "0";
   T14s_h <= T14s(27 downto 9);
   T14s_l <= T14s(8 downto 0);
   U14 <=  "0" & S13 & d14 & (not d14) & "1"; 
   T16_h <=   T14s_h - U14 when d14='1'
        else T14s_h + U14;
   T15 <= T16_h(17 downto 0) & T14s_l;
   S14 <= S13 & d14; -- here -1 becomes 0 and 1 becomes 1
   -- Step 16
   d15 <= not T15(26); --  bit of weight -15
   T15s <= T15 & "0";
   T15s_h <= T15s(27 downto 8);
   T15s_l <= T15s(7 downto 0);
   U15 <=  "0" & S14 & d15 & (not d15) & "1"; 
   T17_h <=   T15s_h - U15 when d15='1'
        else T15s_h + U15;
   T16 <= T17_h(18 downto 0) & T15s_l;
   S15 <= S14 & d15; -- here -1 becomes 0 and 1 becomes 1
   -- Step 17
   d16 <= not T16(26); --  bit of weight -16
   T16s <= T16 & "0";
   T16s_h <= T16s(27 downto 7);
   T16s_l <= T16s(6 downto 0);
   U16 <=  "0" & S15 & d16 & (not d16) & "1"; 
   T18_h <=   T16s_h - U16 when d16='1'
        else T16s_h + U16;
   T17 <= T18_h(19 downto 0) & T16s_l;
   S16 <= S15 & d16; -- here -1 becomes 0 and 1 becomes 1
   -- Step 18
   d17 <= not T17(26); --  bit of weight -17
   T17s <= T17 & "0";
   T17s_h <= T17s(27 downto 6);
   T17s_l <= T17s(5 downto 0);
   U17 <=  "0" & S16 & d17 & (not d17) & "1"; 
   T19_h <=   T17s_h - U17 when d17='1'
        else T17s_h + U17;
   T18 <= T19_h(20 downto 0) & T17s_l;
   S17 <= S16 & d17; -- here -1 becomes 0 and 1 becomes 1
   -- Step 19
   d18 <= not T18(26); --  bit of weight -18
   T18s <= T18 & "0";
   T18s_h <= T18s(27 downto 5);
   T18s_l <= T18s(4 downto 0);
   U18 <=  "0" & S17 & d18 & (not d18) & "1"; 
   T20_h <=   T18s_h - U18 when d18='1'
        else T18s_h + U18;
   T19 <= T20_h(21 downto 0) & T18s_l;
   S18 <= S17 & d18; -- here -1 becomes 0 and 1 becomes 1
   -- Step 20
   d19 <= not T19(26); --  bit of weight -19
   T19s <= T19 & "0";
   T19s_h <= T19s(27 downto 4);
   T19s_l <= T19s(3 downto 0);
   U19 <=  "0" & S18 & d19 & (not d19) & "1"; 
   T21_h <=   T19s_h - U19 when d19='1'
        else T19s_h + U19;
   T20 <= T21_h(22 downto 0) & T19s_l;
   S19 <= S18 & d19; -- here -1 becomes 0 and 1 becomes 1
   -- Step 21
   d20 <= not T20(26); --  bit of weight -20
   T20s <= T20 & "0";
   T20s_h <= T20s(27 downto 3);
   T20s_l <= T20s(2 downto 0);
   U20 <=  "0" & S19 & d20 & (not d20) & "1"; 
   T22_h <=   T20s_h - U20 when d20='1'
        else T20s_h + U20;
   T21 <= T22_h(23 downto 0) & T20s_l;
   S20 <= S19 & d20; -- here -1 becomes 0 and 1 becomes 1
   -- Step 22
   d21 <= not T21(26); --  bit of weight -21
   T21s <= T21 & "0";
   T21s_h <= T21s(27 downto 2);
   T21s_l <= T21s(1 downto 0);
   U21 <=  "0" & S20 & d21 & (not d21) & "1"; 
   T23_h <=   T21s_h - U21 when d21='1'
        else T21s_h + U21;
   T22 <= T23_h(24 downto 0) & T21s_l;
   S21 <= S20 & d21; -- here -1 becomes 0 and 1 becomes 1
   -- Step 23
   d22 <= not T22(26); --  bit of weight -22
   T22s <= T22 & "0";
   T22s_h <= T22s(27 downto 1);
   T22s_l <= T22s(0 downto 0);
   U22 <=  "0" & S21 & d22 & (not d22) & "1"; 
   T24_h <=   T22s_h - U22 when d22='1'
        else T22s_h + U22;
   T23 <= T24_h(25 downto 0) & T22s_l;
   S22 <= S21 & d22; -- here -1 becomes 0 and 1 becomes 1
   -- Step 24
   d23 <= not T23(26); --  bit of weight -23
   T23s <= T23 & "0";
   T23s_h <= T23s(27 downto 0);
   U23 <=  "0" & S22 & d23 & (not d23) & "1"; 
   T25_h <=   T23s_h - U23 when d23='1'
        else T23s_h + U23;
   T24 <= T25_h(26 downto 0);
   S23 <= S22 & d23; -- here -1 becomes 0 and 1 becomes 1
   d25 <= not T24(26) ; -- the sign of the remainder will become the round bit
   mR <= S23 & d25; -- result significand
   fR <= mR(23 downto 1);-- removing leading 1
   round <= mR(0); -- round bit
   -- fRrnd <= fR + ((22 downto 1 => '0') & round); -- rounding sqrt never changes exponents 
   
   -- Output to shared rounding adder
   -- fR is 23 bits. We pad it to 34 bits.
   expFrac_out <= "00000000000" & fR; 
   round_out <= round;
   
   -- Input from shared rounding adder
   -- It returns 34 bits, but we only used the lower bits appropriately.
   fRrnd <= RoundedExpFrac_in(22 downto 0); 
   
   Rn2 <= eRn1 & fRrnd;
   -- sign and exception processing
   with xsX  select 
      xsR <= "010"  when "010",  -- normal case
             "100"  when "100",  -- +infty
             "000"  when "000",  -- +0
             "001"  when "001",  -- the infamous sqrt(-0)=-0
             "110"  when others; -- return NaN
   R <= xsR & Rn2; 
end architecture;
