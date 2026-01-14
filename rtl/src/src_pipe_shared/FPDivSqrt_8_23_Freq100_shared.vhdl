--------------------------------------------------------------------------------
-- FPDiv/FPSqrt merged wrapper with shared pipeline registers (2-stage)
-- Source: /mnt/data/FPDiv_f100.vhdl and /mnt/data/FPSqrt_f100.vhdl
-- Operation select:
--   op = '0' : Division (FPDiv)
--   op = '1' : Square root (FPSqrt)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--                          selFunction_Freq100_uid4
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity selFunction_Freq100_uid4 is
    port (X : in  std_logic_vector(8 downto 0);
          Y : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of selFunction_Freq100_uid4 is
signal Y0 :  std_logic_vector(2 downto 0);
   -- timing of Y0: (c0, 0.543000ns)
signal Y1 :  std_logic_vector(2 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
begin
   with X  select  Y0 <= 
      "000" when "000000000",
      "000" when "000000001",
      "000" when "000000010",
      "000" when "000000011",
      "000" when "000000100",
      "000" when "000000101",
      "000" when "000000110",
      "000" when "000000111",
      "000" when "000001000",
      "000" when "000001001",
      "000" when "000001010",
      "000" when "000001011",
      "000" when "000001100",
      "000" when "000001101",
      "000" when "000001110",
      "000" when "000001111",
      "001" when "000010000",
      "000" when "000010001",
      "000" when "000010010",
      "000" when "000010011",
      "000" when "000010100",
      "000" when "000010101",
      "000" when "000010110",
      "000" when "000010111",
      "001" when "000011000",
      "001" when "000011001",
      "001" when "000011010",
      "001" when "000011011",
      "000" when "000011100",
      "000" when "000011101",
      "000" when "000011110",
      "000" when "000011111",
      "001" when "000100000",
      "001" when "000100001",
      "001" when "000100010",
      "001" when "000100011",
      "001" when "000100100",
      "001" when "000100101",
      "001" when "000100110",
      "000" when "000100111",
      "001" when "000101000",
      "001" when "000101001",
      "001" when "000101010",
      "001" when "000101011",
      "001" when "000101100",
      "001" when "000101101",
      "001" when "000101110",
      "001" when "000101111",
      "010" when "000110000",
      "001" when "000110001",
      "001" when "000110010",
      "001" when "000110011",
      "001" when "000110100",
      "001" when "000110101",
      "001" when "000110110",
      "001" when "000110111",
      "010" when "000111000",
      "010" when "000111001",
      "001" when "000111010",
      "001" when "000111011",
      "001" when "000111100",
      "001" when "000111101",
      "001" when "000111110",
      "001" when "000111111",
      "010" when "001000000",
      "010" when "001000001",
      "010" when "001000010",
      "001" when "001000011",
      "001" when "001000100",
      "001" when "001000101",
      "001" when "001000110",
      "001" when "001000111",
      "010" when "001001000",
      "010" when "001001001",
      "010" when "001001010",
      "010" when "001001011",
      "001" when "001001100",
      "001" when "001001101",
      "001" when "001001110",
      "001" when "001001111",
      "010" when "001010000",
      "010" when "001010001",
      "010" when "001010010",
      "010" when "001010011",
      "010" when "001010100",
      "010" when "001010101",
      "001" when "001010110",
      "001" when "001010111",
      "010" when "001011000",
      "010" when "001011001",
      "010" when "001011010",
      "010" when "001011011",
      "010" when "001011100",
      "010" when "001011101",
      "010" when "001011110",
      "001" when "001011111",
      "010" when "001100000",
      "010" when "001100001",
      "010" when "001100010",
      "010" when "001100011",
      "010" when "001100100",
      "010" when "001100101",
      "010" when "001100110",
      "010" when "001100111",
      "010" when "001101000",
      "010" when "001101001",
      "010" when "001101010",
      "010" when "001101011",
      "010" when "001101100",
      "010" when "001101101",
      "010" when "001101110",
      "010" when "001101111",
      "010" when "001110000",
      "010" when "001110001",
      "010" when "001110010",
      "010" when "001110011",
      "010" when "001110100",
      "010" when "001110101",
      "010" when "001110110",
      "010" when "001110111",
      "010" when "001111000",
      "010" when "001111001",
      "010" when "001111010",
      "010" when "001111011",
      "010" when "001111100",
      "010" when "001111101",
      "010" when "001111110",
      "010" when "001111111",
      "010" when "010000000",
      "010" when "010000001",
      "010" when "010000010",
      "010" when "010000011",
      "010" when "010000100",
      "010" when "010000101",
      "010" when "010000110",
      "010" when "010000111",
      "010" when "010001000",
      "010" when "010001001",
      "010" when "010001010",
      "010" when "010001011",
      "010" when "010001100",
      "010" when "010001101",
      "010" when "010001110",
      "010" when "010001111",
      "010" when "010010000",
      "010" when "010010001",
      "010" when "010010010",
      "010" when "010010011",
      "010" when "010010100",
      "010" when "010010101",
      "010" when "010010110",
      "010" when "010010111",
      "010" when "010011000",
      "010" when "010011001",
      "010" when "010011010",
      "010" when "010011011",
      "010" when "010011100",
      "010" when "010011101",
      "010" when "010011110",
      "010" when "010011111",
      "010" when "010100000",
      "010" when "010100001",
      "010" when "010100010",
      "010" when "010100011",
      "010" when "010100100",
      "010" when "010100101",
      "010" when "010100110",
      "010" when "010100111",
      "010" when "010101000",
      "010" when "010101001",
      "010" when "010101010",
      "010" when "010101011",
      "010" when "010101100",
      "010" when "010101101",
      "010" when "010101110",
      "010" when "010101111",
      "010" when "010110000",
      "010" when "010110001",
      "010" when "010110010",
      "010" when "010110011",
      "010" when "010110100",
      "010" when "010110101",
      "010" when "010110110",
      "010" when "010110111",
      "010" when "010111000",
      "010" when "010111001",
      "010" when "010111010",
      "010" when "010111011",
      "010" when "010111100",
      "010" when "010111101",
      "010" when "010111110",
      "010" when "010111111",
      "010" when "011000000",
      "010" when "011000001",
      "010" when "011000010",
      "010" when "011000011",
      "010" when "011000100",
      "010" when "011000101",
      "010" when "011000110",
      "010" when "011000111",
      "010" when "011001000",
      "010" when "011001001",
      "010" when "011001010",
      "010" when "011001011",
      "010" when "011001100",
      "010" when "011001101",
      "010" when "011001110",
      "010" when "011001111",
      "010" when "011010000",
      "010" when "011010001",
      "010" when "011010010",
      "010" when "011010011",
      "010" when "011010100",
      "010" when "011010101",
      "010" when "011010110",
      "010" when "011010111",
      "010" when "011011000",
      "010" when "011011001",
      "010" when "011011010",
      "010" when "011011011",
      "010" when "011011100",
      "010" when "011011101",
      "010" when "011011110",
      "010" when "011011111",
      "010" when "011100000",
      "010" when "011100001",
      "010" when "011100010",
      "010" when "011100011",
      "010" when "011100100",
      "010" when "011100101",
      "010" when "011100110",
      "010" when "011100111",
      "010" when "011101000",
      "010" when "011101001",
      "010" when "011101010",
      "010" when "011101011",
      "010" when "011101100",
      "010" when "011101101",
      "010" when "011101110",
      "010" when "011101111",
      "010" when "011110000",
      "010" when "011110001",
      "010" when "011110010",
      "010" when "011110011",
      "010" when "011110100",
      "010" when "011110101",
      "010" when "011110110",
      "010" when "011110111",
      "010" when "011111000",
      "010" when "011111001",
      "010" when "011111010",
      "010" when "011111011",
      "010" when "011111100",
      "010" when "011111101",
      "010" when "011111110",
      "010" when "011111111",
      "110" when "100000000",
      "110" when "100000001",
      "110" when "100000010",
      "110" when "100000011",
      "110" when "100000100",
      "110" when "100000101",
      "110" when "100000110",
      "110" when "100000111",
      "110" when "100001000",
      "110" when "100001001",
      "110" when "100001010",
      "110" when "100001011",
      "110" when "100001100",
      "110" when "100001101",
      "110" when "100001110",
      "110" when "100001111",
      "110" when "100010000",
      "110" when "100010001",
      "110" when "100010010",
      "110" when "100010011",
      "110" when "100010100",
      "110" when "100010101",
      "110" when "100010110",
      "110" when "100010111",
      "110" when "100011000",
      "110" when "100011001",
      "110" when "100011010",
      "110" when "100011011",
      "110" when "100011100",
      "110" when "100011101",
      "110" when "100011110",
      "110" when "100011111",
      "110" when "100100000",
      "110" when "100100001",
      "110" when "100100010",
      "110" when "100100011",
      "110" when "100100100",
      "110" when "100100101",
      "110" when "100100110",
      "110" when "100100111",
      "110" when "100101000",
      "110" when "100101001",
      "110" when "100101010",
      "110" when "100101011",
      "110" when "100101100",
      "110" when "100101101",
      "110" when "100101110",
      "110" when "100101111",
      "110" when "100110000",
      "110" when "100110001",
      "110" when "100110010",
      "110" when "100110011",
      "110" when "100110100",
      "110" when "100110101",
      "110" when "100110110",
      "110" when "100110111",
      "110" when "100111000",
      "110" when "100111001",
      "110" when "100111010",
      "110" when "100111011",
      "110" when "100111100",
      "110" when "100111101",
      "110" when "100111110",
      "110" when "100111111",
      "110" when "101000000",
      "110" when "101000001",
      "110" when "101000010",
      "110" when "101000011",
      "110" when "101000100",
      "110" when "101000101",
      "110" when "101000110",
      "110" when "101000111",
      "110" when "101001000",
      "110" when "101001001",
      "110" when "101001010",
      "110" when "101001011",
      "110" when "101001100",
      "110" when "101001101",
      "110" when "101001110",
      "110" when "101001111",
      "110" when "101010000",
      "110" when "101010001",
      "110" when "101010010",
      "110" when "101010011",
      "110" when "101010100",
      "110" when "101010101",
      "110" when "101010110",
      "110" when "101010111",
      "110" when "101011000",
      "110" when "101011001",
      "110" when "101011010",
      "110" when "101011011",
      "110" when "101011100",
      "110" when "101011101",
      "110" when "101011110",
      "110" when "101011111",
      "110" when "101100000",
      "110" when "101100001",
      "110" when "101100010",
      "110" when "101100011",
      "110" when "101100100",
      "110" when "101100101",
      "110" when "101100110",
      "110" when "101100111",
      "110" when "101101000",
      "110" when "101101001",
      "110" when "101101010",
      "110" when "101101011",
      "110" when "101101100",
      "110" when "101101101",
      "110" when "101101110",
      "110" when "101101111",
      "110" when "101110000",
      "110" when "101110001",
      "110" when "101110010",
      "110" when "101110011",
      "110" when "101110100",
      "110" when "101110101",
      "110" when "101110110",
      "110" when "101110111",
      "110" when "101111000",
      "110" when "101111001",
      "110" when "101111010",
      "110" when "101111011",
      "110" when "101111100",
      "110" when "101111101",
      "110" when "101111110",
      "110" when "101111111",
      "110" when "110000000",
      "110" when "110000001",
      "110" when "110000010",
      "110" when "110000011",
      "110" when "110000100",
      "110" when "110000101",
      "110" when "110000110",
      "110" when "110000111",
      "110" when "110001000",
      "110" when "110001001",
      "110" when "110001010",
      "110" when "110001011",
      "110" when "110001100",
      "110" when "110001101",
      "110" when "110001110",
      "110" when "110001111",
      "110" when "110010000",
      "110" when "110010001",
      "110" when "110010010",
      "110" when "110010011",
      "110" when "110010100",
      "110" when "110010101",
      "110" when "110010110",
      "110" when "110010111",
      "110" when "110011000",
      "110" when "110011001",
      "110" when "110011010",
      "110" when "110011011",
      "110" when "110011100",
      "110" when "110011101",
      "110" when "110011110",
      "110" when "110011111",
      "110" when "110100000",
      "110" when "110100001",
      "110" when "110100010",
      "110" when "110100011",
      "110" when "110100100",
      "110" when "110100101",
      "110" when "110100110",
      "110" when "110100111",
      "110" when "110101000",
      "110" when "110101001",
      "110" when "110101010",
      "110" when "110101011",
      "110" when "110101100",
      "110" when "110101101",
      "110" when "110101110",
      "111" when "110101111",
      "110" when "110110000",
      "110" when "110110001",
      "110" when "110110010",
      "110" when "110110011",
      "110" when "110110100",
      "111" when "110110101",
      "111" when "110110110",
      "111" when "110110111",
      "110" when "110111000",
      "110" when "110111001",
      "110" when "110111010",
      "110" when "110111011",
      "111" when "110111100",
      "111" when "110111101",
      "111" when "110111110",
      "111" when "110111111",
      "110" when "111000000",
      "110" when "111000001",
      "111" when "111000010",
      "111" when "111000011",
      "111" when "111000100",
      "111" when "111000101",
      "111" when "111000110",
      "111" when "111000111",
      "110" when "111001000",
      "111" when "111001001",
      "111" when "111001010",
      "111" when "111001011",
      "111" when "111001100",
      "111" when "111001101",
      "111" when "111001110",
      "111" when "111001111",
      "111" when "111010000",
      "111" when "111010001",
      "111" when "111010010",
      "111" when "111010011",
      "111" when "111010100",
      "111" when "111010101",
      "111" when "111010110",
      "111" when "111010111",
      "111" when "111011000",
      "111" when "111011001",
      "111" when "111011010",
      "111" when "111011011",
      "111" when "111011100",
      "111" when "111011101",
      "111" when "111011110",
      "111" when "111011111",
      "111" when "111100000",
      "111" when "111100001",
      "111" when "111100010",
      "111" when "111100011",
      "111" when "111100100",
      "111" when "111100101",
      "111" when "111100110",
      "111" when "111100111",
      "111" when "111101000",
      "111" when "111101001",
      "111" when "111101010",
      "111" when "111101011",
      "000" when "111101100",
      "000" when "111101101",
      "000" when "111101110",
      "000" when "111101111",
      "000" when "111110000",
      "000" when "111110001",
      "000" when "111110010",
      "000" when "111110011",
      "000" when "111110100",
      "000" when "111110101",
      "000" when "111110110",
      "000" when "111110111",
      "000" when "111111000",
      "000" when "111111001",
      "000" when "111111010",
      "000" when "111111011",
      "000" when "111111100",
      "000" when "111111101",
      "000" when "111111110",
      "000" when "111111111",
      "---" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          FPDiv_8_23_Freq100_uid2
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Maxime Christ, Florent de Dinechin (2015)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c2, 8.624000ns)

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

entity FPDivSqrt_8_23_Freq100 is
    port (
        clk : in std_logic;
        op  : in std_logic; -- 0: div, 1: sqrt
        X   : in  std_logic_vector(8+23+2 downto 0);
        Y   : in  std_logic_vector(8+23+2 downto 0);
        R   : out std_logic_vector(8+23+2 downto 0);
          -- Exposed Rounding Adder Interface (Shared IntAdder_34)
          expfrac_out : out std_logic_vector(32 downto 0);
          round_out : out std_logic;
          expfracR_in : in std_logic_vector(32 downto 0)
    );
end entity;

architecture arch of FPDivSqrt_8_23_Freq100 is

   -- Shared pipeline storage (overlayed between div and sqrt per stage)
   signal pipe1 : std_logic_vector(194 downto 0);
   signal pipe2 : std_logic_vector(60 downto 0);

   -- Next-state vectors for each operation
   signal pipe1_next_div  : std_logic_vector(194 downto 0);
   signal pipe2_next_div  : std_logic_vector(60 downto 0);
   signal pipe1_next_sqrt : std_logic_vector(194 downto 0);
   signal pipe2_next_sqrt : std_logic_vector(60 downto 0);

   -- Selected next-state (based on op)
   signal pipe1_next_sel : std_logic_vector(194 downto 0);
   signal pipe2_next_sel : std_logic_vector(60 downto 0);

   -- Operand isolation to reduce switching on the inactive datapath
   signal X_div  : std_logic_vector(8+23+2 downto 0);
   signal Y_div  : std_logic_vector(8+23+2 downto 0);
   signal X_sqrt : std_logic_vector(8+23+2 downto 0);

   signal div_R  : std_logic_vector(8+23+2 downto 0);
   signal sqrt_R : std_logic_vector(8+23+2 downto 0);

   signal div_expfrac : std_logic_vector(32 downto 0);
   signal div_round   : std_logic;
   signal sqrt_expfrac: std_logic_vector(32 downto 0);
   signal sqrt_round  : std_logic;

begin

   -- Simple operand isolation (can be replaced with input holding if you have a valid/ready protocol)
   X_div  <= X when op = '1' else (others => '0');
   Y_div  <= Y when op = '1' else (others => '0');
   X_sqrt <= X when op = '0' else (others => '0');

   -- Select next-state vectors
   pipe1_next_sel <= pipe1_next_div  when op  = '1' else pipe1_next_sqrt;
   pipe2_next_sel <= pipe2_next_div  when op  = '1' else pipe2_next_sqrt;

   -- Shared pipeline update
   process(clk)
   begin
      if clk'event and clk = '1' then
         pipe2 <= pipe2_next_sel;  -- computed from previous-cycle pipe1 (op is assumed stable)

         pipe1 <= pipe1_next_sel;  -- computed from current inputs/op

      end if;
   end process;

   -- Output select (op is assumed stable for the duration of an operation)
   R <= div_R when op = '1' else sqrt_R;
   expfrac_out <= div_expfrac when op = '1' else sqrt_expfrac;
   round_out   <= div_round   when op = '1' else sqrt_round;

   -----------------------------------------------------------------------------
   -- DIV datapath block (combinational + externalized pipeline regs)
   -----------------------------------------------------------------------------
   div_blk: block is
   component selFunction_Freq100_uid4 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : out  std_logic_vector(2 downto 0)   );
   end component;

signal fX :  std_logic_vector(23 downto 0);
   -- timing of fX: (c0, 0.000000ns)
signal fY :  std_logic_vector(23 downto 0);
   -- timing of fY: (c0, 0.000000ns)
signal expR0, expR0_d1, expR0_d2 :  std_logic_vector(9 downto 0);
   -- timing of expR0: (c0, 0.000000ns)
signal sR, sR_d1, sR_d2 :  std_logic;
   -- timing of sR: (c0, 0.043000ns)
signal exnXY :  std_logic_vector(3 downto 0);
   -- timing of exnXY: (c0, 0.000000ns)
signal exnR0, exnR0_d1, exnR0_d2 :  std_logic_vector(1 downto 0);
   -- timing of exnR0: (c0, 0.043000ns)
signal D, D_d1, D_d2 :  std_logic_vector(23 downto 0);
   -- timing of D: (c0, 0.000000ns)
signal psX :  std_logic_vector(24 downto 0);
   -- timing of psX: (c0, 0.000000ns)
signal betaw14 :  std_logic_vector(26 downto 0);
   -- timing of betaw14: (c0, 0.000000ns)
signal sel14 :  std_logic_vector(8 downto 0);
   -- timing of sel14: (c0, 0.000000ns)
signal q14 :  std_logic_vector(2 downto 0);
   -- timing of q14: (c0, 0.543000ns)
signal q14_copy5 :  std_logic_vector(2 downto 0);
   -- timing of q14_copy5: (c0, 0.000000ns)
signal absq14D :  std_logic_vector(26 downto 0);
   -- timing of absq14D: (c0, 0.543000ns)
signal w13 :  std_logic_vector(26 downto 0);
   -- timing of w13: (c0, 1.831000ns)
signal betaw13 :  std_logic_vector(26 downto 0);
   -- timing of betaw13: (c0, 1.831000ns)
signal sel13 :  std_logic_vector(8 downto 0);
   -- timing of sel13: (c0, 1.831000ns)
signal q13 :  std_logic_vector(2 downto 0);
   -- timing of q13: (c0, 2.374000ns)
signal q13_copy6 :  std_logic_vector(2 downto 0);
   -- timing of q13_copy6: (c0, 1.831000ns)
signal absq13D :  std_logic_vector(26 downto 0);
   -- timing of absq13D: (c0, 2.374000ns)
signal w12 :  std_logic_vector(26 downto 0);
   -- timing of w12: (c0, 3.662000ns)
signal betaw12 :  std_logic_vector(26 downto 0);
   -- timing of betaw12: (c0, 3.662000ns)
signal sel12 :  std_logic_vector(8 downto 0);
   -- timing of sel12: (c0, 3.662000ns)
signal q12 :  std_logic_vector(2 downto 0);
   -- timing of q12: (c0, 4.205000ns)
signal q12_copy7 :  std_logic_vector(2 downto 0);
   -- timing of q12_copy7: (c0, 3.662000ns)
signal absq12D :  std_logic_vector(26 downto 0);
   -- timing of absq12D: (c0, 4.205000ns)
signal w11 :  std_logic_vector(26 downto 0);
   -- timing of w11: (c0, 5.493000ns)
signal betaw11 :  std_logic_vector(26 downto 0);
   -- timing of betaw11: (c0, 5.493000ns)
signal sel11 :  std_logic_vector(8 downto 0);
   -- timing of sel11: (c0, 5.493000ns)
signal q11 :  std_logic_vector(2 downto 0);
   -- timing of q11: (c0, 6.036000ns)
signal q11_copy8 :  std_logic_vector(2 downto 0);
   -- timing of q11_copy8: (c0, 5.493000ns)
signal absq11D :  std_logic_vector(26 downto 0);
   -- timing of absq11D: (c0, 6.036000ns)
signal w10 :  std_logic_vector(26 downto 0);
   -- timing of w10: (c0, 7.324000ns)
signal betaw10 :  std_logic_vector(26 downto 0);
   -- timing of betaw10: (c0, 7.324000ns)
signal sel10 :  std_logic_vector(8 downto 0);
   -- timing of sel10: (c0, 7.324000ns)
signal q10 :  std_logic_vector(2 downto 0);
   -- timing of q10: (c0, 7.867000ns)
signal q10_copy9 :  std_logic_vector(2 downto 0);
   -- timing of q10_copy9: (c0, 7.324000ns)
signal absq10D :  std_logic_vector(26 downto 0);
   -- timing of absq10D: (c0, 7.867000ns)
signal w9 :  std_logic_vector(26 downto 0);
   -- timing of w9: (c0, 9.155000ns)
signal betaw9, betaw9_d1 :  std_logic_vector(26 downto 0);
   -- timing of betaw9: (c0, 9.155000ns)
signal sel9 :  std_logic_vector(8 downto 0);
   -- timing of sel9: (c0, 9.155000ns)
signal q9, q9_d1 :  std_logic_vector(2 downto 0);
   -- timing of q9: (c0, 9.698000ns)
signal q9_copy10 :  std_logic_vector(2 downto 0);
   -- timing of q9_copy10: (c0, 9.155000ns)
signal absq9D, absq9D_d1 :  std_logic_vector(26 downto 0);
   -- timing of absq9D: (c0, 9.698000ns)
signal w8 :  std_logic_vector(26 downto 0);
   -- timing of w8: (c1, 1.202000ns)
signal betaw8 :  std_logic_vector(26 downto 0);
   -- timing of betaw8: (c1, 1.202000ns)
signal sel8 :  std_logic_vector(8 downto 0);
   -- timing of sel8: (c1, 1.202000ns)
signal q8 :  std_logic_vector(2 downto 0);
   -- timing of q8: (c1, 1.745000ns)
signal q8_copy11 :  std_logic_vector(2 downto 0);
   -- timing of q8_copy11: (c1, 1.202000ns)
signal absq8D :  std_logic_vector(26 downto 0);
   -- timing of absq8D: (c1, 1.745000ns)
signal w7 :  std_logic_vector(26 downto 0);
   -- timing of w7: (c1, 3.033000ns)
signal betaw7 :  std_logic_vector(26 downto 0);
   -- timing of betaw7: (c1, 3.033000ns)
signal sel7 :  std_logic_vector(8 downto 0);
   -- timing of sel7: (c1, 3.033000ns)
signal q7 :  std_logic_vector(2 downto 0);
   -- timing of q7: (c1, 3.576000ns)
signal q7_copy12 :  std_logic_vector(2 downto 0);
   -- timing of q7_copy12: (c1, 3.033000ns)
signal absq7D :  std_logic_vector(26 downto 0);
   -- timing of absq7D: (c1, 3.576000ns)
signal w6 :  std_logic_vector(26 downto 0);
   -- timing of w6: (c1, 4.864000ns)
signal betaw6 :  std_logic_vector(26 downto 0);
   -- timing of betaw6: (c1, 4.864000ns)
signal sel6 :  std_logic_vector(8 downto 0);
   -- timing of sel6: (c1, 4.864000ns)
signal q6 :  std_logic_vector(2 downto 0);
   -- timing of q6: (c1, 5.407000ns)
signal q6_copy13 :  std_logic_vector(2 downto 0);
   -- timing of q6_copy13: (c1, 4.864000ns)
signal absq6D :  std_logic_vector(26 downto 0);
   -- timing of absq6D: (c1, 5.407000ns)
signal w5 :  std_logic_vector(26 downto 0);
   -- timing of w5: (c1, 6.695000ns)
signal betaw5 :  std_logic_vector(26 downto 0);
   -- timing of betaw5: (c1, 6.695000ns)
signal sel5 :  std_logic_vector(8 downto 0);
   -- timing of sel5: (c1, 6.695000ns)
signal q5 :  std_logic_vector(2 downto 0);
   -- timing of q5: (c1, 7.238000ns)
signal q5_copy14 :  std_logic_vector(2 downto 0);
   -- timing of q5_copy14: (c1, 6.695000ns)
signal absq5D :  std_logic_vector(26 downto 0);
   -- timing of absq5D: (c1, 7.238000ns)
signal w4 :  std_logic_vector(26 downto 0);
   -- timing of w4: (c1, 8.526000ns)
signal betaw4, betaw4_d1 :  std_logic_vector(26 downto 0);
   -- timing of betaw4: (c1, 8.526000ns)
signal sel4 :  std_logic_vector(8 downto 0);
   -- timing of sel4: (c1, 8.526000ns)
signal q4, q4_d1 :  std_logic_vector(2 downto 0);
   -- timing of q4: (c1, 9.069000ns)
signal q4_copy15 :  std_logic_vector(2 downto 0);
   -- timing of q4_copy15: (c1, 8.526000ns)
signal absq4D, absq4D_d1 :  std_logic_vector(26 downto 0);
   -- timing of absq4D: (c1, 9.069000ns)
signal w3 :  std_logic_vector(26 downto 0);
   -- timing of w3: (c2, 0.573000ns)
signal betaw3 :  std_logic_vector(26 downto 0);
   -- timing of betaw3: (c2, 0.573000ns)
signal sel3 :  std_logic_vector(8 downto 0);
   -- timing of sel3: (c2, 0.573000ns)
signal q3 :  std_logic_vector(2 downto 0);
   -- timing of q3: (c2, 1.116000ns)
signal q3_copy16 :  std_logic_vector(2 downto 0);
   -- timing of q3_copy16: (c2, 0.573000ns)
signal absq3D :  std_logic_vector(26 downto 0);
   -- timing of absq3D: (c2, 1.116000ns)
signal w2 :  std_logic_vector(26 downto 0);
   -- timing of w2: (c2, 2.404000ns)
signal betaw2 :  std_logic_vector(26 downto 0);
   -- timing of betaw2: (c2, 2.404000ns)
signal sel2 :  std_logic_vector(8 downto 0);
   -- timing of sel2: (c2, 2.404000ns)
signal q2 :  std_logic_vector(2 downto 0);
   -- timing of q2: (c2, 2.947000ns)
signal q2_copy17 :  std_logic_vector(2 downto 0);
   -- timing of q2_copy17: (c2, 2.404000ns)
signal absq2D :  std_logic_vector(26 downto 0);
   -- timing of absq2D: (c2, 2.947000ns)
signal w1 :  std_logic_vector(26 downto 0);
   -- timing of w1: (c2, 4.235000ns)
signal betaw1 :  std_logic_vector(26 downto 0);
   -- timing of betaw1: (c2, 4.235000ns)
signal sel1 :  std_logic_vector(8 downto 0);
   -- timing of sel1: (c2, 4.235000ns)
signal q1 :  std_logic_vector(2 downto 0);
   -- timing of q1: (c2, 4.778000ns)
signal q1_copy18 :  std_logic_vector(2 downto 0);
   -- timing of q1_copy18: (c2, 4.235000ns)
signal absq1D :  std_logic_vector(26 downto 0);
   -- timing of absq1D: (c2, 4.778000ns)
signal w0 :  std_logic_vector(26 downto 0);
   -- timing of w0: (c2, 6.066000ns)
signal wfinal :  std_logic_vector(24 downto 0);
   -- timing of wfinal: (c2, 6.066000ns)
signal qM0 :  std_logic;
   -- timing of qM0: (c2, 6.066000ns)
signal qP14, qP14_d1, qP14_d2 :  std_logic_vector(1 downto 0);
   -- timing of qP14: (c0, 0.543000ns)
signal qM14, qM14_d1, qM14_d2 :  std_logic_vector(1 downto 0);
   -- timing of qM14: (c0, 0.543000ns)
signal qP13, qP13_d1, qP13_d2 :  std_logic_vector(1 downto 0);
   -- timing of qP13: (c0, 2.374000ns)
signal qM13, qM13_d1, qM13_d2 :  std_logic_vector(1 downto 0);
   -- timing of qM13: (c0, 2.374000ns)
signal qP12, qP12_d1, qP12_d2 :  std_logic_vector(1 downto 0);
   -- timing of qP12: (c0, 4.205000ns)
signal qM12, qM12_d1, qM12_d2 :  std_logic_vector(1 downto 0);
   -- timing of qM12: (c0, 4.205000ns)
signal qP11, qP11_d1, qP11_d2 :  std_logic_vector(1 downto 0);
   -- timing of qP11: (c0, 6.036000ns)
signal qM11, qM11_d1, qM11_d2 :  std_logic_vector(1 downto 0);
   -- timing of qM11: (c0, 6.036000ns)
signal qP10, qP10_d1, qP10_d2 :  std_logic_vector(1 downto 0);
   -- timing of qP10: (c0, 7.867000ns)
signal qM10, qM10_d1, qM10_d2 :  std_logic_vector(1 downto 0);
   -- timing of qM10: (c0, 7.867000ns)
signal qP9, qP9_d1, qP9_d2 :  std_logic_vector(1 downto 0);
   -- timing of qP9: (c0, 9.698000ns)
signal qM9, qM9_d1, qM9_d2 :  std_logic_vector(1 downto 0);
   -- timing of qM9: (c0, 9.698000ns)
signal qP8, qP8_d1 :  std_logic_vector(1 downto 0);
   -- timing of qP8: (c1, 1.745000ns)
signal qM8, qM8_d1 :  std_logic_vector(1 downto 0);
   -- timing of qM8: (c1, 1.745000ns)
signal qP7, qP7_d1 :  std_logic_vector(1 downto 0);
   -- timing of qP7: (c1, 3.576000ns)
signal qM7, qM7_d1 :  std_logic_vector(1 downto 0);
   -- timing of qM7: (c1, 3.576000ns)
signal qP6, qP6_d1 :  std_logic_vector(1 downto 0);
   -- timing of qP6: (c1, 5.407000ns)
signal qM6, qM6_d1 :  std_logic_vector(1 downto 0);
   -- timing of qM6: (c1, 5.407000ns)
signal qP5, qP5_d1 :  std_logic_vector(1 downto 0);
   -- timing of qP5: (c1, 7.238000ns)
signal qM5, qM5_d1 :  std_logic_vector(1 downto 0);
   -- timing of qM5: (c1, 7.238000ns)
signal qP4, qP4_d1 :  std_logic_vector(1 downto 0);
   -- timing of qP4: (c1, 9.069000ns)
signal qM4, qM4_d1 :  std_logic_vector(1 downto 0);
   -- timing of qM4: (c1, 9.069000ns)
signal qP3 :  std_logic_vector(1 downto 0);
   -- timing of qP3: (c2, 1.116000ns)
signal qM3 :  std_logic_vector(1 downto 0);
   -- timing of qM3: (c2, 1.116000ns)
signal qP2 :  std_logic_vector(1 downto 0);
   -- timing of qP2: (c2, 2.947000ns)
signal qM2 :  std_logic_vector(1 downto 0);
   -- timing of qM2: (c2, 2.947000ns)
signal qP1 :  std_logic_vector(1 downto 0);
   -- timing of qP1: (c2, 4.778000ns)
signal qM1 :  std_logic_vector(1 downto 0);
   -- timing of qM1: (c2, 4.778000ns)
signal qP :  std_logic_vector(27 downto 0);
   -- timing of qP: (c2, 4.778000ns)
signal qM :  std_logic_vector(27 downto 0);
   -- timing of qM: (c2, 6.066000ns)
signal quotient :  std_logic_vector(27 downto 0);
   -- timing of quotient: (c2, 7.403000ns)
signal mR :  std_logic_vector(25 downto 0);
   -- timing of mR: (c2, 7.446000ns)
signal fRnorm :  std_logic_vector(23 downto 0);
   -- timing of fRnorm: (c2, 7.489000ns)
signal round :  std_logic;
   -- timing of round: (c2, 7.532000ns)
signal expR1 :  std_logic_vector(9 downto 0);
   -- timing of expR1: (c2, 8.538000ns)
signal expfrac :  std_logic_vector(32 downto 0);
   -- timing of expfrac: (c2, 8.538000ns)
signal expfracR :  std_logic_vector(32 downto 0);
   -- timing of expfracR: (c2, 8.538000ns)
signal exnR :  std_logic_vector(1 downto 0);
   -- timing of exnR: (c2, 8.581000ns)
signal exnRfinal :  std_logic_vector(1 downto 0);
   -- timing of exnRfinal: (c2, 8.624000ns)
begin
   -- [REMOVED clocked process]
   fX <= "1" & X_div(22 downto 0);
   fY <= "1" & Y_div(22 downto 0);
   -- exponent difference, sign and exception combination computed early, to have fewer bits to pipeline
   expR0 <= ("00" & X_div(30 downto 23)) - ("00" & Y_div(30 downto 23));
   sR <= X_div(31) xor Y_div(31);
   -- early exception handling 
   exnXY <= X_div(33 downto 32) & Y_div(33 downto 32);
   with exnXY  select 
      exnR0 <= 
         "01"	 when "0101",										-- normal
         "00"	 when "0001" | "0010" | "0110", -- zero
         "10"	 when "0100" | "1000" | "1001", -- overflow
         "11"	 when others;										-- NaN
   D <= fY ;
   psX <= "0" & fX ;
   betaw14 <=  "00" & psX;
   sel14 <= betaw14(26 downto 21) & D(22 downto 20);
   SelFunctionTable14: selFunction_Freq100_uid4
      port map ( X => sel14,
                 Y => q14_copy5);
   q14 <= q14_copy5; -- output copy to hold a pipeline register if needed

   with q14  select 
      absq14D <= 
         "000" & D						 when "001" | "111", -- mult by 1
         "00" & D & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q14(2)  select 
   w13<= betaw14 - absq14D when '0',
         betaw14 + absq14D when others;

   betaw13 <= w13(24 downto 0) & "00"; -- multiplication by the radix
   sel13 <= betaw13(26 downto 21) & D(22 downto 20);
   SelFunctionTable13: selFunction_Freq100_uid4
      port map ( X => sel13,
                 Y => q13_copy6);
   q13 <= q13_copy6; -- output copy to hold a pipeline register if needed

   with q13  select 
      absq13D <= 
         "000" & D						 when "001" | "111", -- mult by 1
         "00" & D & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q13(2)  select 
   w12<= betaw13 - absq13D when '0',
         betaw13 + absq13D when others;

   betaw12 <= w12(24 downto 0) & "00"; -- multiplication by the radix
   sel12 <= betaw12(26 downto 21) & D(22 downto 20);
   SelFunctionTable12: selFunction_Freq100_uid4
      port map ( X => sel12,
                 Y => q12_copy7);
   q12 <= q12_copy7; -- output copy to hold a pipeline register if needed

   with q12  select 
      absq12D <= 
         "000" & D						 when "001" | "111", -- mult by 1
         "00" & D & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q12(2)  select 
   w11<= betaw12 - absq12D when '0',
         betaw12 + absq12D when others;

   betaw11 <= w11(24 downto 0) & "00"; -- multiplication by the radix
   sel11 <= betaw11(26 downto 21) & D(22 downto 20);
   SelFunctionTable11: selFunction_Freq100_uid4
      port map ( X => sel11,
                 Y => q11_copy8);
   q11 <= q11_copy8; -- output copy to hold a pipeline register if needed

   with q11  select 
      absq11D <= 
         "000" & D						 when "001" | "111", -- mult by 1
         "00" & D & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q11(2)  select 
   w10<= betaw11 - absq11D when '0',
         betaw11 + absq11D when others;

   betaw10 <= w10(24 downto 0) & "00"; -- multiplication by the radix
   sel10 <= betaw10(26 downto 21) & D(22 downto 20);
   SelFunctionTable10: selFunction_Freq100_uid4
      port map ( X => sel10,
                 Y => q10_copy9);
   q10 <= q10_copy9; -- output copy to hold a pipeline register if needed

   with q10  select 
      absq10D <= 
         "000" & D						 when "001" | "111", -- mult by 1
         "00" & D & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q10(2)  select 
   w9<= betaw10 - absq10D when '0',
         betaw10 + absq10D when others;

   betaw9 <= w9(24 downto 0) & "00"; -- multiplication by the radix
   sel9 <= betaw9(26 downto 21) & D(22 downto 20);
   SelFunctionTable9: selFunction_Freq100_uid4
      port map ( X => sel9,
                 Y => q9_copy10);
   q9 <= q9_copy10; -- output copy to hold a pipeline register if needed

   with q9  select 
      absq9D <= 
         "000" & D						 when "001" | "111", -- mult by 1
         "00" & D & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q9_d1(2)  select 
   w8<= betaw9_d1 - absq9D_d1 when '0',
         betaw9_d1 + absq9D_d1 when others;

   betaw8 <= w8(24 downto 0) & "00"; -- multiplication by the radix
   sel8 <= betaw8(26 downto 21) & D_d1(22 downto 20);
   SelFunctionTable8: selFunction_Freq100_uid4
      port map ( X => sel8,
                 Y => q8_copy11);
   q8 <= q8_copy11; -- output copy to hold a pipeline register if needed

   with q8  select 
      absq8D <= 
         "000" & D_d1						 when "001" | "111", -- mult by 1
         "00" & D_d1 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q8(2)  select 
   w7<= betaw8 - absq8D when '0',
         betaw8 + absq8D when others;

   betaw7 <= w7(24 downto 0) & "00"; -- multiplication by the radix
   sel7 <= betaw7(26 downto 21) & D_d1(22 downto 20);
   SelFunctionTable7: selFunction_Freq100_uid4
      port map ( X => sel7,
                 Y => q7_copy12);
   q7 <= q7_copy12; -- output copy to hold a pipeline register if needed

   with q7  select 
      absq7D <= 
         "000" & D_d1						 when "001" | "111", -- mult by 1
         "00" & D_d1 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q7(2)  select 
   w6<= betaw7 - absq7D when '0',
         betaw7 + absq7D when others;

   betaw6 <= w6(24 downto 0) & "00"; -- multiplication by the radix
   sel6 <= betaw6(26 downto 21) & D_d1(22 downto 20);
   SelFunctionTable6: selFunction_Freq100_uid4
      port map ( X => sel6,
                 Y => q6_copy13);
   q6 <= q6_copy13; -- output copy to hold a pipeline register if needed

   with q6  select 
      absq6D <= 
         "000" & D_d1						 when "001" | "111", -- mult by 1
         "00" & D_d1 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q6(2)  select 
   w5<= betaw6 - absq6D when '0',
         betaw6 + absq6D when others;

   betaw5 <= w5(24 downto 0) & "00"; -- multiplication by the radix
   sel5 <= betaw5(26 downto 21) & D_d1(22 downto 20);
   SelFunctionTable5: selFunction_Freq100_uid4
      port map ( X => sel5,
                 Y => q5_copy14);
   q5 <= q5_copy14; -- output copy to hold a pipeline register if needed

   with q5  select 
      absq5D <= 
         "000" & D_d1						 when "001" | "111", -- mult by 1
         "00" & D_d1 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q5(2)  select 
   w4<= betaw5 - absq5D when '0',
         betaw5 + absq5D when others;

   betaw4 <= w4(24 downto 0) & "00"; -- multiplication by the radix
   sel4 <= betaw4(26 downto 21) & D_d1(22 downto 20);
   SelFunctionTable4: selFunction_Freq100_uid4
      port map ( X => sel4,
                 Y => q4_copy15);
   q4 <= q4_copy15; -- output copy to hold a pipeline register if needed

   with q4  select 
      absq4D <= 
         "000" & D_d1						 when "001" | "111", -- mult by 1
         "00" & D_d1 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q4_d1(2)  select 
   w3<= betaw4_d1 - absq4D_d1 when '0',
         betaw4_d1 + absq4D_d1 when others;

   betaw3 <= w3(24 downto 0) & "00"; -- multiplication by the radix
   sel3 <= betaw3(26 downto 21) & D_d2(22 downto 20);
   SelFunctionTable3: selFunction_Freq100_uid4
      port map ( X => sel3,
                 Y => q3_copy16);
   q3 <= q3_copy16; -- output copy to hold a pipeline register if needed

   with q3  select 
      absq3D <= 
         "000" & D_d2						 when "001" | "111", -- mult by 1
         "00" & D_d2 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q3(2)  select 
   w2<= betaw3 - absq3D when '0',
         betaw3 + absq3D when others;

   betaw2 <= w2(24 downto 0) & "00"; -- multiplication by the radix
   sel2 <= betaw2(26 downto 21) & D_d2(22 downto 20);
   SelFunctionTable2: selFunction_Freq100_uid4
      port map ( X => sel2,
                 Y => q2_copy17);
   q2 <= q2_copy17; -- output copy to hold a pipeline register if needed

   with q2  select 
      absq2D <= 
         "000" & D_d2						 when "001" | "111", -- mult by 1
         "00" & D_d2 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q2(2)  select 
   w1<= betaw2 - absq2D when '0',
         betaw2 + absq2D when others;

   betaw1 <= w1(24 downto 0) & "00"; -- multiplication by the radix
   sel1 <= betaw1(26 downto 21) & D_d2(22 downto 20);
   SelFunctionTable1: selFunction_Freq100_uid4
      port map ( X => sel1,
                 Y => q1_copy18);
   q1 <= q1_copy18; -- output copy to hold a pipeline register if needed

   with q1  select 
      absq1D <= 
         "000" & D_d2						 when "001" | "111", -- mult by 1
         "00" & D_d2 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q1(2)  select 
   w0<= betaw1 - absq1D when '0',
         betaw1 + absq1D when others;

   wfinal <= w0(24 downto 0);
   qM0 <= wfinal(24); -- rounding bit is the sign of the remainder
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
   qP <= qP14_d2 & qP13_d2 & qP12_d2 & qP11_d2 & qP10_d2 & qP9_d2 & qP8_d1 & qP7_d1 & qP6_d1 & qP5_d1 & qP4_d1 & qP3 & qP2 & qP1;
   qM <= qM14_d2(0) & qM13_d2 & qM12_d2 & qM11_d2 & qM10_d2 & qM9_d2 & qM8_d1 & qM7_d1 & qM6_d1 & qM5_d1 & qM4_d1 & qM3 & qM2 & qM1 & qM0;
   quotient <= qP - qM;
   -- We need a mR in (0, -wf-2) format: 1+wF fraction bits, 1 round bit, and 1 guard bit for the normalisation,
   -- quotient is the truncation of the exact quotient to at least 2^(-wF-2) bits
   -- now discarding its possible known MSB zeroes, and dropping the possible extra LSB bit (due to radix 4) 
   mR <= quotient(26 downto 1); 
   -- normalisation
   fRnorm <=    mR(24 downto 1)  when mR(25)= '1'
           else mR(23 downto 0);  -- now fRnorm is a (-1, -wF-1) fraction
   round <= fRnorm(0); 
   expR1 <= expR0_d2 + ("000" & (6 downto 1 => '1') & mR(25)); -- add back bias
   -- final rounding
   expfrac <= expR1 & fRnorm(23 downto 1) ;
   div_expfrac <= expfrac;
   div_round <= round;
   expfracR <= expfracR_in;
   exnR <=      "00"  when expfracR(32) = '1'   -- underflow
           else "10"  when  expfracR(32 downto 31) =  "01" -- overflow
           else "01";      -- 00, normal case
   with exnR0_d2  select 
      exnRfinal <= 
         exnR   when "01", -- normal
         exnR0_d2  when others;
   div_R <= exnRfinal & sR_d2 & expfracR(30 downto 0);

   -- Unpack shared stage1/stage2 regs into the div "d1/d2" signals (gated by op tag)
   expR0_d1 <= pipe1(194 downto 185) when op = '1' else (others => '0');
   sR_d1 <= pipe1(184) when op = '1' else '0';
   exnR0_d1 <= pipe1(183 downto 182) when op = '1' else (others => '0');
   D_d1 <= pipe1(181 downto 158) when op = '1' else (others => '0');
   betaw9_d1 <= pipe1(157 downto 131) when op = '1' else (others => '0');
   q9_d1 <= pipe1(130 downto 128) when op = '1' else (others => '0');
   absq9D_d1 <= pipe1(127 downto 101) when op = '1' else (others => '0');
   betaw4_d1 <= pipe1(100 downto 74) when op = '1' else (others => '0');
   q4_d1 <= pipe1(73 downto 71) when op = '1' else (others => '0');
   absq4D_d1 <= pipe1(70 downto 44) when op = '1' else (others => '0');
   qP14_d1 <= pipe1(43 downto 42) when op = '1' else (others => '0');
   qM14_d1 <= pipe1(41 downto 40) when op = '1' else (others => '0');
   qP13_d1 <= pipe1(39 downto 38) when op = '1' else (others => '0');
   qM13_d1 <= pipe1(37 downto 36) when op = '1' else (others => '0');
   qP12_d1 <= pipe1(35 downto 34) when op = '1' else (others => '0');
   qM12_d1 <= pipe1(33 downto 32) when op = '1' else (others => '0');
   qP11_d1 <= pipe1(31 downto 30) when op = '1' else (others => '0');
   qM11_d1 <= pipe1(29 downto 28) when op = '1' else (others => '0');
   qP10_d1 <= pipe1(27 downto 26) when op = '1' else (others => '0');
   qM10_d1 <= pipe1(25 downto 24) when op = '1' else (others => '0');
   qP9_d1 <= pipe1(23 downto 22) when op = '1' else (others => '0');
   qM9_d1 <= pipe1(21 downto 20) when op = '1' else (others => '0');
   qP8_d1 <= pipe1(19 downto 18) when op = '1' else (others => '0');
   qM8_d1 <= pipe1(17 downto 16) when op = '1' else (others => '0');
   qP7_d1 <= pipe1(15 downto 14) when op = '1' else (others => '0');
   qM7_d1 <= pipe1(13 downto 12) when op = '1' else (others => '0');
   qP6_d1 <= pipe1(11 downto 10) when op = '1' else (others => '0');
   qM6_d1 <= pipe1(9 downto 8) when op = '1' else (others => '0');
   qP5_d1 <= pipe1(7 downto 6) when op = '1' else (others => '0');
   qM5_d1 <= pipe1(5 downto 4) when op = '1' else (others => '0');
   qP4_d1 <= pipe1(3 downto 2) when op = '1' else (others => '0');
   qM4_d1 <= pipe1(1 downto 0) when op = '1' else (others => '0');

   expR0_d2 <= pipe2(60 downto 51) when op = '1' else (others => '0');
   sR_d2 <= pipe2(50) when op = '1' else '1';
   exnR0_d2 <= pipe2(49 downto 48) when op = '1' else (others => '0');
   D_d2 <= pipe2(47 downto 24) when op = '1' else (others => '0');
   qP14_d2 <= pipe2(23 downto 22) when op = '1' else (others => '0');
   qM14_d2 <= pipe2(21 downto 20) when op = '1' else (others => '0');
   qP13_d2 <= pipe2(19 downto 18) when op = '1' else (others => '0');
   qM13_d2 <= pipe2(17 downto 16) when op = '1' else (others => '0');
   qP12_d2 <= pipe2(15 downto 14) when op = '1' else (others => '0');
   qM12_d2 <= pipe2(13 downto 12) when op = '1' else (others => '0');
   qP11_d2 <= pipe2(11 downto 10) when op = '1' else (others => '0');
   qM11_d2 <= pipe2(9 downto 8) when op = '1' else (others => '0');
   qP10_d2 <= pipe2(7 downto 6) when op = '1' else (others => '0');
   qM10_d2 <= pipe2(5 downto 4) when op = '1' else (others => '0');
   qP9_d2 <= pipe2(3 downto 2) when op = '1' else (others => '0');
   qM9_d2 <= pipe2(1 downto 0) when op = '1' else (others => '0');

   pack_div_stage1: process(all) begin
      pipe1_next_div <= (others => '0');
      pipe1_next_div(194 downto 185) <= expR0;
      pipe1_next_div(184) <= sR;
      pipe1_next_div(183 downto 182) <= exnR0;
      pipe1_next_div(181 downto 158) <= D;
      pipe1_next_div(157 downto 131) <= betaw9;
      pipe1_next_div(130 downto 128) <= q9;
      pipe1_next_div(127 downto 101) <= absq9D;
      pipe1_next_div(100 downto 74) <= betaw4;
      pipe1_next_div(73 downto 71) <= q4;
      pipe1_next_div(70 downto 44) <= absq4D;
      pipe1_next_div(43 downto 42) <= qP14;
      pipe1_next_div(41 downto 40) <= qM14;
      pipe1_next_div(39 downto 38) <= qP13;
      pipe1_next_div(37 downto 36) <= qM13;
      pipe1_next_div(35 downto 34) <= qP12;
      pipe1_next_div(33 downto 32) <= qM12;
      pipe1_next_div(31 downto 30) <= qP11;
      pipe1_next_div(29 downto 28) <= qM11;
      pipe1_next_div(27 downto 26) <= qP10;
      pipe1_next_div(25 downto 24) <= qM10;
      pipe1_next_div(23 downto 22) <= qP9;
      pipe1_next_div(21 downto 20) <= qM9;
      pipe1_next_div(19 downto 18) <= qP8;
      pipe1_next_div(17 downto 16) <= qM8;
      pipe1_next_div(15 downto 14) <= qP7;
      pipe1_next_div(13 downto 12) <= qM7;
      pipe1_next_div(11 downto 10) <= qP6;
      pipe1_next_div(9 downto 8) <= qM6;
      pipe1_next_div(7 downto 6) <= qP5;
      pipe1_next_div(5 downto 4) <= qM5;
      pipe1_next_div(3 downto 2) <= qP4;
      pipe1_next_div(1 downto 0) <= qM4;
   end process;

   pack_div_stage2: process(all) begin
      pipe2_next_div <= (others => '0');
      pipe2_next_div(60 downto 51) <= expR0_d1;
      pipe2_next_div(50) <= sR_d1;
      pipe2_next_div(49 downto 48) <= exnR0_d1;
      pipe2_next_div(47 downto 24) <= D_d1;
      pipe2_next_div(23 downto 22) <= qP14_d1;
      pipe2_next_div(21 downto 20) <= qM14_d1;
      pipe2_next_div(19 downto 18) <= qP13_d1;
      pipe2_next_div(17 downto 16) <= qM13_d1;
      pipe2_next_div(15 downto 14) <= qP12_d1;
      pipe2_next_div(13 downto 12) <= qM12_d1;
      pipe2_next_div(11 downto 10) <= qP11_d1;
      pipe2_next_div(9 downto 8) <= qM11_d1;
      pipe2_next_div(7 downto 6) <= qP10_d1;
      pipe2_next_div(5 downto 4) <= qM10_d1;
      pipe2_next_div(3 downto 2) <= qP9_d1;
      pipe2_next_div(1 downto 0) <= qM9_d1;
   end process;

end block;

   -----------------------------------------------------------------------------
   -- SQRT datapath block (combinational + externalized pipeline regs)
   -----------------------------------------------------------------------------
   sqrt_blk: block is
signal fracX :  std_logic_vector(22 downto 0);
   -- timing of fracX: (c0, 0.000000ns)
signal eRn0 :  std_logic_vector(7 downto 0);
   -- timing of eRn0: (c0, 0.000000ns)
signal xsX :  std_logic_vector(2 downto 0);
   -- timing of xsX: (c0, 0.000000ns)
signal eRn1, eRn1_d1, eRn1_d2 :  std_logic_vector(7 downto 0);
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
signal d9, d9_d1 :  std_logic;
   -- timing of d9: (c0, 9.528000ns)
signal T9s :  std_logic_vector(27 downto 0);
   -- timing of T9s: (c0, 9.528000ns)
signal T9s_h, T9s_h_d1 :  std_logic_vector(13 downto 0);
   -- timing of T9s_h: (c0, 9.528000ns)
signal T9s_l, T9s_l_d1 :  std_logic_vector(13 downto 0);
   -- timing of T9s_l: (c0, 9.528000ns)
signal U9, U9_d1 :  std_logic_vector(13 downto 0);
   -- timing of U9: (c0, 9.528000ns)
signal T11_h :  std_logic_vector(13 downto 0);
   -- timing of T11_h: (c1, 0.836000ns)
signal T10 :  std_logic_vector(26 downto 0);
   -- timing of T10: (c1, 0.836000ns)
signal S9, S9_d1 :  std_logic_vector(10 downto 0);
   -- timing of S9: (c0, 9.528000ns)
signal d10 :  std_logic;
   -- timing of d10: (c1, 0.836000ns)
signal T10s :  std_logic_vector(27 downto 0);
   -- timing of T10s: (c1, 0.836000ns)
signal T10s_h :  std_logic_vector(14 downto 0);
   -- timing of T10s_h: (c1, 0.836000ns)
signal T10s_l :  std_logic_vector(12 downto 0);
   -- timing of T10s_l: (c1, 0.836000ns)
signal U10 :  std_logic_vector(14 downto 0);
   -- timing of U10: (c1, 0.836000ns)
signal T12_h :  std_logic_vector(14 downto 0);
   -- timing of T12_h: (c1, 1.977000ns)
signal T11 :  std_logic_vector(26 downto 0);
   -- timing of T11: (c1, 1.977000ns)
signal S10 :  std_logic_vector(11 downto 0);
   -- timing of S10: (c1, 0.836000ns)
signal d11 :  std_logic;
   -- timing of d11: (c1, 1.977000ns)
signal T11s :  std_logic_vector(27 downto 0);
   -- timing of T11s: (c1, 1.977000ns)
signal T11s_h :  std_logic_vector(15 downto 0);
   -- timing of T11s_h: (c1, 1.977000ns)
signal T11s_l :  std_logic_vector(11 downto 0);
   -- timing of T11s_l: (c1, 1.977000ns)
signal U11 :  std_logic_vector(15 downto 0);
   -- timing of U11: (c1, 1.977000ns)
signal T13_h :  std_logic_vector(15 downto 0);
   -- timing of T13_h: (c1, 3.118000ns)
signal T12 :  std_logic_vector(26 downto 0);
   -- timing of T12: (c1, 3.118000ns)
signal S11 :  std_logic_vector(12 downto 0);
   -- timing of S11: (c1, 1.977000ns)
signal d12 :  std_logic;
   -- timing of d12: (c1, 3.118000ns)
signal T12s :  std_logic_vector(27 downto 0);
   -- timing of T12s: (c1, 3.118000ns)
signal T12s_h :  std_logic_vector(16 downto 0);
   -- timing of T12s_h: (c1, 3.118000ns)
signal T12s_l :  std_logic_vector(10 downto 0);
   -- timing of T12s_l: (c1, 3.118000ns)
signal U12 :  std_logic_vector(16 downto 0);
   -- timing of U12: (c1, 3.118000ns)
signal T14_h :  std_logic_vector(16 downto 0);
   -- timing of T14_h: (c1, 4.259000ns)
signal T13 :  std_logic_vector(26 downto 0);
   -- timing of T13: (c1, 4.259000ns)
signal S12 :  std_logic_vector(13 downto 0);
   -- timing of S12: (c1, 3.118000ns)
signal d13 :  std_logic;
   -- timing of d13: (c1, 4.259000ns)
signal T13s :  std_logic_vector(27 downto 0);
   -- timing of T13s: (c1, 4.259000ns)
signal T13s_h :  std_logic_vector(17 downto 0);
   -- timing of T13s_h: (c1, 4.259000ns)
signal T13s_l :  std_logic_vector(9 downto 0);
   -- timing of T13s_l: (c1, 4.259000ns)
signal U13 :  std_logic_vector(17 downto 0);
   -- timing of U13: (c1, 4.259000ns)
signal T15_h :  std_logic_vector(17 downto 0);
   -- timing of T15_h: (c1, 5.400000ns)
signal T14 :  std_logic_vector(26 downto 0);
   -- timing of T14: (c1, 5.400000ns)
signal S13 :  std_logic_vector(14 downto 0);
   -- timing of S13: (c1, 4.259000ns)
signal d14 :  std_logic;
   -- timing of d14: (c1, 5.400000ns)
signal T14s :  std_logic_vector(27 downto 0);
   -- timing of T14s: (c1, 5.400000ns)
signal T14s_h :  std_logic_vector(18 downto 0);
   -- timing of T14s_h: (c1, 5.400000ns)
signal T14s_l :  std_logic_vector(8 downto 0);
   -- timing of T14s_l: (c1, 5.400000ns)
signal U14 :  std_logic_vector(18 downto 0);
   -- timing of U14: (c1, 5.400000ns)
signal T16_h :  std_logic_vector(18 downto 0);
   -- timing of T16_h: (c1, 6.590000ns)
signal T15 :  std_logic_vector(26 downto 0);
   -- timing of T15: (c1, 6.590000ns)
signal S14 :  std_logic_vector(15 downto 0);
   -- timing of S14: (c1, 5.400000ns)
signal d15 :  std_logic;
   -- timing of d15: (c1, 6.590000ns)
signal T15s :  std_logic_vector(27 downto 0);
   -- timing of T15s: (c1, 6.590000ns)
signal T15s_h :  std_logic_vector(19 downto 0);
   -- timing of T15s_h: (c1, 6.590000ns)
signal T15s_l :  std_logic_vector(7 downto 0);
   -- timing of T15s_l: (c1, 6.590000ns)
signal U15 :  std_logic_vector(19 downto 0);
   -- timing of U15: (c1, 6.590000ns)
signal T17_h :  std_logic_vector(19 downto 0);
   -- timing of T17_h: (c1, 7.780000ns)
signal T16 :  std_logic_vector(26 downto 0);
   -- timing of T16: (c1, 7.780000ns)
signal S15 :  std_logic_vector(16 downto 0);
   -- timing of S15: (c1, 6.590000ns)
signal d16 :  std_logic;
   -- timing of d16: (c1, 7.780000ns)
signal T16s :  std_logic_vector(27 downto 0);
   -- timing of T16s: (c1, 7.780000ns)
signal T16s_h :  std_logic_vector(20 downto 0);
   -- timing of T16s_h: (c1, 7.780000ns)
signal T16s_l :  std_logic_vector(6 downto 0);
   -- timing of T16s_l: (c1, 7.780000ns)
signal U16 :  std_logic_vector(20 downto 0);
   -- timing of U16: (c1, 7.780000ns)
signal T18_h :  std_logic_vector(20 downto 0);
   -- timing of T18_h: (c1, 8.970000ns)
signal T17 :  std_logic_vector(26 downto 0);
   -- timing of T17: (c1, 8.970000ns)
signal S16 :  std_logic_vector(17 downto 0);
   -- timing of S16: (c1, 7.780000ns)
signal d17, d17_d1 :  std_logic;
   -- timing of d17: (c1, 8.970000ns)
signal T17s :  std_logic_vector(27 downto 0);
   -- timing of T17s: (c1, 8.970000ns)
signal T17s_h, T17s_h_d1 :  std_logic_vector(21 downto 0);
   -- timing of T17s_h: (c1, 8.970000ns)
signal T17s_l, T17s_l_d1 :  std_logic_vector(5 downto 0);
   -- timing of T17s_l: (c1, 8.970000ns)
signal U17, U17_d1 :  std_logic_vector(21 downto 0);
   -- timing of U17: (c1, 8.970000ns)
signal T19_h :  std_logic_vector(21 downto 0);
   -- timing of T19_h: (c2, 0.376000ns)
signal T18 :  std_logic_vector(26 downto 0);
   -- timing of T18: (c2, 0.376000ns)
signal S17, S17_d1 :  std_logic_vector(18 downto 0);
   -- timing of S17: (c1, 8.970000ns)
signal d18 :  std_logic;
   -- timing of d18: (c2, 0.376000ns)
signal T18s :  std_logic_vector(27 downto 0);
   -- timing of T18s: (c2, 0.376000ns)
signal T18s_h :  std_logic_vector(22 downto 0);
   -- timing of T18s_h: (c2, 0.376000ns)
signal T18s_l :  std_logic_vector(4 downto 0);
   -- timing of T18s_l: (c2, 0.376000ns)
signal U18 :  std_logic_vector(22 downto 0);
   -- timing of U18: (c2, 0.376000ns)
signal T20_h :  std_logic_vector(22 downto 0);
   -- timing of T20_h: (c2, 1.615000ns)
signal T19 :  std_logic_vector(26 downto 0);
   -- timing of T19: (c2, 1.615000ns)
signal S18 :  std_logic_vector(19 downto 0);
   -- timing of S18: (c2, 0.376000ns)
signal d19 :  std_logic;
   -- timing of d19: (c2, 1.615000ns)
signal T19s :  std_logic_vector(27 downto 0);
   -- timing of T19s: (c2, 1.615000ns)
signal T19s_h :  std_logic_vector(23 downto 0);
   -- timing of T19s_h: (c2, 1.615000ns)
signal T19s_l :  std_logic_vector(3 downto 0);
   -- timing of T19s_l: (c2, 1.615000ns)
signal U19 :  std_logic_vector(23 downto 0);
   -- timing of U19: (c2, 1.615000ns)
signal T21_h :  std_logic_vector(23 downto 0);
   -- timing of T21_h: (c2, 2.854000ns)
signal T20 :  std_logic_vector(26 downto 0);
   -- timing of T20: (c2, 2.854000ns)
signal S19 :  std_logic_vector(20 downto 0);
   -- timing of S19: (c2, 1.615000ns)
signal d20 :  std_logic;
   -- timing of d20: (c2, 2.854000ns)
signal T20s :  std_logic_vector(27 downto 0);
   -- timing of T20s: (c2, 2.854000ns)
signal T20s_h :  std_logic_vector(24 downto 0);
   -- timing of T20s_h: (c2, 2.854000ns)
signal T20s_l :  std_logic_vector(2 downto 0);
   -- timing of T20s_l: (c2, 2.854000ns)
signal U20 :  std_logic_vector(24 downto 0);
   -- timing of U20: (c2, 2.854000ns)
signal T22_h :  std_logic_vector(24 downto 0);
   -- timing of T22_h: (c2, 4.093000ns)
signal T21 :  std_logic_vector(26 downto 0);
   -- timing of T21: (c2, 4.093000ns)
signal S20 :  std_logic_vector(21 downto 0);
   -- timing of S20: (c2, 2.854000ns)
signal d21 :  std_logic;
   -- timing of d21: (c2, 4.093000ns)
signal T21s :  std_logic_vector(27 downto 0);
   -- timing of T21s: (c2, 4.093000ns)
signal T21s_h :  std_logic_vector(25 downto 0);
   -- timing of T21s_h: (c2, 4.093000ns)
signal T21s_l :  std_logic_vector(1 downto 0);
   -- timing of T21s_l: (c2, 4.093000ns)
signal U21 :  std_logic_vector(25 downto 0);
   -- timing of U21: (c2, 4.093000ns)
signal T23_h :  std_logic_vector(25 downto 0);
   -- timing of T23_h: (c2, 5.332000ns)
signal T22 :  std_logic_vector(26 downto 0);
   -- timing of T22: (c2, 5.332000ns)
signal S21 :  std_logic_vector(22 downto 0);
   -- timing of S21: (c2, 4.093000ns)
signal d22 :  std_logic;
   -- timing of d22: (c2, 5.332000ns)
signal T22s :  std_logic_vector(27 downto 0);
   -- timing of T22s: (c2, 5.332000ns)
signal T22s_h :  std_logic_vector(26 downto 0);
   -- timing of T22s_h: (c2, 5.332000ns)
signal T22s_l :  std_logic_vector(0 downto 0);
   -- timing of T22s_l: (c2, 5.332000ns)
signal U22 :  std_logic_vector(26 downto 0);
   -- timing of U22: (c2, 5.332000ns)
signal T24_h :  std_logic_vector(26 downto 0);
   -- timing of T24_h: (c2, 6.620000ns)
signal T23 :  std_logic_vector(26 downto 0);
   -- timing of T23: (c2, 6.620000ns)
signal S22 :  std_logic_vector(23 downto 0);
   -- timing of S22: (c2, 5.332000ns)
signal d23 :  std_logic;
   -- timing of d23: (c2, 6.620000ns)
signal T23s :  std_logic_vector(27 downto 0);
   -- timing of T23s: (c2, 6.620000ns)
signal T23s_h :  std_logic_vector(27 downto 0);
   -- timing of T23s_h: (c2, 6.620000ns)
signal U23 :  std_logic_vector(27 downto 0);
   -- timing of U23: (c2, 6.620000ns)
signal T25_h :  std_logic_vector(27 downto 0);
   -- timing of T25_h: (c2, 7.908000ns)
signal T24 :  std_logic_vector(26 downto 0);
   -- timing of T24: (c2, 7.908000ns)
signal S23 :  std_logic_vector(24 downto 0);
   -- timing of S23: (c2, 6.620000ns)
signal d25 :  std_logic;
   -- timing of d25: (c2, 7.908000ns)
signal mR :  std_logic_vector(25 downto 0);
   -- timing of mR: (c2, 7.908000ns)
signal fR :  std_logic_vector(22 downto 0);
   -- timing of fR: (c2, 7.908000ns)
signal round :  std_logic;
   -- timing of round: (c2, 7.908000ns)
-- signal fRrnd :  std_logic_vector(22 downto 0);
--    -- timing of fRrnd: (c2, 9.147000ns)
signal Rn2 :  std_logic_vector(30 downto 0);
   -- timing of Rn2: (c2, 9.147000ns)
signal xsR, xsR_d1, xsR_d2 :  std_logic_vector(2 downto 0);
   -- timing of xsR: (c0, 0.043000ns)
begin
   -- [REMOVED clocked process]
   fracX <= X_sqrt(22 downto 0); -- fraction
   eRn0 <= "0" & X_sqrt(30 downto 24); -- exponent
   xsX <= X_sqrt(33 downto 31); -- exception and sign
   eRn1 <= eRn0 + ("00" & (5 downto 0 => '1')) + X_sqrt(23);
   fracXnorm <= "1" & fracX & "000" when X_sqrt(23) = '0' else
         "01" & fracX&"00"; -- pre-normalization
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
   T11_h <=   T9s_h_d1 - U9_d1 when d9_d1='1'
        else T9s_h_d1 + U9_d1;
   T10 <= T11_h(12 downto 0) & T9s_l_d1;
   S9 <= S8 & d9; -- here -1 becomes 0 and 1 becomes 1
   -- Step 11
   d10 <= not T10(26); --  bit of weight -10
   T10s <= T10 & "0";
   T10s_h <= T10s(27 downto 13);
   T10s_l <= T10s(12 downto 0);
   U10 <=  "0" & S9_d1 & d10 & (not d10) & "1"; 
   T12_h <=   T10s_h - U10 when d10='1'
        else T10s_h + U10;
   T11 <= T12_h(13 downto 0) & T10s_l;
   S10 <= S9_d1 & d10; -- here -1 becomes 0 and 1 becomes 1
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
   T19_h <=   T17s_h_d1 - U17_d1 when d17_d1='1'
        else T17s_h_d1 + U17_d1;
   T18 <= T19_h(20 downto 0) & T17s_l_d1;
   S17 <= S16 & d17; -- here -1 becomes 0 and 1 becomes 1
   -- Step 19
   d18 <= not T18(26); --  bit of weight -18
   T18s <= T18 & "0";
   T18s_h <= T18s(27 downto 5);
   T18s_l <= T18s(4 downto 0);
   U18 <=  "0" & S17_d1 & d18 & (not d18) & "1"; 
   T20_h <=   T18s_h - U18 when d18='1'
        else T18s_h + U18;
   T19 <= T20_h(21 downto 0) & T18s_l;
   S18 <= S17_d1 & d18; -- here -1 becomes 0 and 1 becomes 1
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
   sqrt_expfrac <= "00" & eRn1_d2 & fR;
   sqrt_round <= round;
   Rn2 <= expfracR_in(30 downto 0);
   -- sign and exception processing
   with xsX  select 
      xsR <= "010"  when "010",  -- normal case
             "100"  when "100",  -- +infty
             "000"  when "000",  -- +0
             "001"  when "001",  -- the infamous sqrt(-0)=-0
             "110"  when others; -- return NaN
   sqrt_R <= xsR_d2 & Rn2; 

   -- Unpack shared stage1/stage2 regs into the sqrt "d1/d2" signals (gated by op tag)
   eRn1_d1 <= pipe1(194 downto 187) when op = '0' else (others => '0');
   d9_d1 <= pipe1(186) when op = '0' else '0';
   T9s_h_d1 <= pipe1(185 downto 172) when op = '0' else (others => '0');
   T9s_l_d1 <= pipe1(171 downto 158) when op = '0' else (others => '0');
   U9_d1 <= pipe1(157 downto 144) when op = '0' else (others => '0');
   S9_d1 <= pipe1(143 downto 133) when op = '0' else (others => '0');
   d17_d1 <= pipe1(132) when op = '0' else '0';
   T17s_h_d1 <= pipe1(131 downto 110) when op = '0' else (others => '0');
   T17s_l_d1 <= pipe1(109 downto 104) when op = '0' else (others => '0');
   U17_d1 <= pipe1(103 downto 82) when op = '0' else (others => '0');
   S17_d1 <= pipe1(81 downto 63) when op = '0' else (others => '0');
   xsR_d1 <= pipe1(62 downto 60) when op = '0' else (others => '0');

   eRn1_d2 <= pipe2(60 downto 53) when op = '0' else (others => '0');
   xsR_d2 <= pipe2(52 downto 50) when op = '0' else (others => '0');

   pack_sqrt_stage1: process(all) begin
      pipe1_next_sqrt <= (others => '0');
      pipe1_next_sqrt(194 downto 187) <= eRn1;
      pipe1_next_sqrt(186) <= d9;
      pipe1_next_sqrt(185 downto 172) <= T9s_h;
      pipe1_next_sqrt(171 downto 158) <= T9s_l;
      pipe1_next_sqrt(157 downto 144) <= U9;
      pipe1_next_sqrt(143 downto 133) <= S9;
      pipe1_next_sqrt(132) <= d17;
      pipe1_next_sqrt(131 downto 110) <= T17s_h;
      pipe1_next_sqrt(109 downto 104) <= T17s_l;
      pipe1_next_sqrt(103 downto 82) <= U17;
      pipe1_next_sqrt(81 downto 63) <= S17;
      pipe1_next_sqrt(62 downto 60) <= xsR;
   end process;

   pack_sqrt_stage2: process(all) begin
      pipe2_next_sqrt <= (others => '0');
      pipe2_next_sqrt(60 downto 53) <= eRn1_d1;
      pipe2_next_sqrt(52 downto 50) <= xsR_d1;
   end process;

end block;

end architecture;