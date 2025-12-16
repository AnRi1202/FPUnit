library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

entity FPMult_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
                    R : out  std_logic_vector(8+23+2 downto 0);
          -- Added ports for shared RA
          expSig_out : out std_logic_vector(32 downto 0);
          round_out : out std_logic;
          expSigPostRound_in : in std_logic_vector(32 downto 0)
          );
end entity;

architecture arch of FPMult_NoRA is
   component IntMultiplier_24x24_48_Freq1_uid5 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;

   component IntAdder_33_Freq1_uid280 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(32 downto 0);
             Y : in  std_logic_vector(32 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(32 downto 0)   );
   end component;

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
signal excSel :  std_logic_vector(3 downto 0);
   -- timing of excSel: (c0, 0.000000ns)
signal exc :  std_logic_vector(1 downto 0);
   -- timing of exc: (c0, 0.043000ns)
signal norm :  std_logic;
   -- timing of norm: (c0, 4.870000ns)
signal expPostNorm :  std_logic_vector(9 downto 0);
   -- timing of expPostNorm: (c0, 4.870000ns)
signal sigProdExt :  std_logic_vector(47 downto 0);
   -- timing of sigProdExt: (c0, 5.413000ns)
signal expSig :  std_logic_vector(32 downto 0);
   -- timing of expSig: (c0, 5.413000ns)
signal sticky :  std_logic;
   -- timing of sticky: (c0, 5.413000ns)
signal guard :  std_logic;
   -- timing of guard: (c0, 6.017250ns)
signal round :  std_logic;
   -- timing of round: (c0, 6.560250ns)
signal expSigPostRound :  std_logic_vector(32 downto 0);
   -- timing of expSigPostRound: (c0, 7.946250ns)
signal excPostNorm :  std_logic_vector(1 downto 0);
   -- timing of excPostNorm: (c0, 7.946250ns)
signal finalExc :  std_logic_vector(1 downto 0);
   -- timing of finalExc: (c0, 7.946250ns)
begin
   sign <= X(31) xor Y(31);
   expX <= X(30 downto 23);
   expY <= Y(30 downto 23);
   expSumPreSub <= ("00" & expX) + ("00" & expY);
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub - bias;
   sigX <= "1" & X(22 downto 0);
   sigY <= "1" & Y(22 downto 0);
   SignificandMultiplication: IntMultiplier_24x24_48_Freq1_uid5
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
   expPostNorm <= expSum + ("000000000" & norm);
   -- significand normalization shift
   sigProdExt <= sigProd(46 downto 0) & "0" when norm='1' else
                         sigProd(45 downto 0) & "00";
   expSig <= expPostNorm & sigProdExt(47 downto 25);
   sticky <= sigProdExt(24);
   guard <= '0' when sigProdExt(23 downto 0)="000000000000000000000000" else '1';
   round <= sticky and ( (guard and not(sigProdExt(25))) or (sigProdExt(25) ))  ;
--    RoundingAdder: IntAdder_33_Freq1_uid280
--       port map ( clk  => clk,
--                  Cin => round,
--                  X => expSig,
--                  Y => "000000000000000000000000000000000",
--                  R => expSigPostRound);
   with expSigPostRound(32 downto 31)  select 
   excPostNorm <=  "01"  when  "00",
                               "10"             when "01", 
                               "00"             when "11"|"10",
                               "11"             when others;
   with exc  select  
   finalExc <= exc when  "11"|"10"|"00",
                       excPostNorm when others; 
--    R <= finalExc & sign & expSigPostRound(30 downto 0);
   -- Bypass assignments
   expSig_out <= expSig;
   round_out <= round;
   expSigPostRound <= expSigPostRound_in;
end architecture;

