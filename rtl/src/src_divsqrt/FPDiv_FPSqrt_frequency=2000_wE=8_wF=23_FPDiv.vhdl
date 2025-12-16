--------------------------------------------------------------------------------
--                         selFunction_Freq2000_uid4
-- VHDL generated for DummyFPGA @ 2000MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 0.5
-- Target frequency (MHz): 2000
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.550000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity selFunction_Freq2000_uid4 is
    port (X : in  std_logic_vector(8 downto 0);
          Y : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of selFunction_Freq2000_uid4 is
signal Y0 :  std_logic_vector(2 downto 0);
   -- timing of Y0: (c0, 0.550000ns)
signal Y1 :  std_logic_vector(2 downto 0);
   -- timing of Y1: (c0, 0.550000ns)
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
--                          FPDiv_8_23_Freq2000_uid2
-- VHDL generated for DummyFPGA @ 2000MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Maxime Christ, Florent de Dinechin (2015)
--------------------------------------------------------------------------------
-- Pipeline depth: 92 cycles
-- Clock period (ns): 0.5
-- Target frequency (MHz): 2000
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c92, 0.270000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPDiv_8_23_Freq2000_uid2 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPDiv_8_23_Freq2000_uid2 is
   component selFunction_Freq2000_uid4 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : out  std_logic_vector(2 downto 0)   );
   end component;

signal fX :  std_logic_vector(23 downto 0);
   -- timing of fX: (c0, 0.000000ns)
signal fY :  std_logic_vector(23 downto 0);
   -- timing of fY: (c0, 0.000000ns)
signal expR0, expR0_d1, expR0_d2, expR0_d3, expR0_d4, expR0_d5, expR0_d6, expR0_d7, expR0_d8, expR0_d9, expR0_d10, expR0_d11, expR0_d12, expR0_d13, expR0_d14, expR0_d15, expR0_d16, expR0_d17, expR0_d18, expR0_d19, expR0_d20, expR0_d21, expR0_d22, expR0_d23, expR0_d24, expR0_d25, expR0_d26, expR0_d27, expR0_d28, expR0_d29, expR0_d30, expR0_d31, expR0_d32, expR0_d33, expR0_d34, expR0_d35, expR0_d36, expR0_d37, expR0_d38, expR0_d39, expR0_d40, expR0_d41, expR0_d42, expR0_d43, expR0_d44, expR0_d45, expR0_d46, expR0_d47, expR0_d48, expR0_d49, expR0_d50, expR0_d51, expR0_d52, expR0_d53, expR0_d54, expR0_d55, expR0_d56, expR0_d57, expR0_d58, expR0_d59, expR0_d60, expR0_d61, expR0_d62, expR0_d63, expR0_d64, expR0_d65, expR0_d66, expR0_d67, expR0_d68, expR0_d69, expR0_d70, expR0_d71, expR0_d72, expR0_d73, expR0_d74, expR0_d75, expR0_d76, expR0_d77, expR0_d78, expR0_d79, expR0_d80, expR0_d81, expR0_d82, expR0_d83, expR0_d84, expR0_d85, expR0_d86, expR0_d87, expR0_d88, expR0_d89, expR0_d90, expR0_d91, expR0_d92 :  std_logic_vector(9 downto 0);
   -- timing of expR0: (c0, 0.000000ns)
signal sR, sR_d1, sR_d2, sR_d3, sR_d4, sR_d5, sR_d6, sR_d7, sR_d8, sR_d9, sR_d10, sR_d11, sR_d12, sR_d13, sR_d14, sR_d15, sR_d16, sR_d17, sR_d18, sR_d19, sR_d20, sR_d21, sR_d22, sR_d23, sR_d24, sR_d25, sR_d26, sR_d27, sR_d28, sR_d29, sR_d30, sR_d31, sR_d32, sR_d33, sR_d34, sR_d35, sR_d36, sR_d37, sR_d38, sR_d39, sR_d40, sR_d41, sR_d42, sR_d43, sR_d44, sR_d45, sR_d46, sR_d47, sR_d48, sR_d49, sR_d50, sR_d51, sR_d52, sR_d53, sR_d54, sR_d55, sR_d56, sR_d57, sR_d58, sR_d59, sR_d60, sR_d61, sR_d62, sR_d63, sR_d64, sR_d65, sR_d66, sR_d67, sR_d68, sR_d69, sR_d70, sR_d71, sR_d72, sR_d73, sR_d74, sR_d75, sR_d76, sR_d77, sR_d78, sR_d79, sR_d80, sR_d81, sR_d82, sR_d83, sR_d84, sR_d85, sR_d86, sR_d87, sR_d88, sR_d89, sR_d90, sR_d91, sR_d92 :  std_logic;
   -- timing of sR: (c0, 0.050000ns)
signal exnXY :  std_logic_vector(3 downto 0);
   -- timing of exnXY: (c0, 0.000000ns)
signal exnR0, exnR0_d1, exnR0_d2, exnR0_d3, exnR0_d4, exnR0_d5, exnR0_d6, exnR0_d7, exnR0_d8, exnR0_d9, exnR0_d10, exnR0_d11, exnR0_d12, exnR0_d13, exnR0_d14, exnR0_d15, exnR0_d16, exnR0_d17, exnR0_d18, exnR0_d19, exnR0_d20, exnR0_d21, exnR0_d22, exnR0_d23, exnR0_d24, exnR0_d25, exnR0_d26, exnR0_d27, exnR0_d28, exnR0_d29, exnR0_d30, exnR0_d31, exnR0_d32, exnR0_d33, exnR0_d34, exnR0_d35, exnR0_d36, exnR0_d37, exnR0_d38, exnR0_d39, exnR0_d40, exnR0_d41, exnR0_d42, exnR0_d43, exnR0_d44, exnR0_d45, exnR0_d46, exnR0_d47, exnR0_d48, exnR0_d49, exnR0_d50, exnR0_d51, exnR0_d52, exnR0_d53, exnR0_d54, exnR0_d55, exnR0_d56, exnR0_d57, exnR0_d58, exnR0_d59, exnR0_d60, exnR0_d61, exnR0_d62, exnR0_d63, exnR0_d64, exnR0_d65, exnR0_d66, exnR0_d67, exnR0_d68, exnR0_d69, exnR0_d70, exnR0_d71, exnR0_d72, exnR0_d73, exnR0_d74, exnR0_d75, exnR0_d76, exnR0_d77, exnR0_d78, exnR0_d79, exnR0_d80, exnR0_d81, exnR0_d82, exnR0_d83, exnR0_d84, exnR0_d85, exnR0_d86, exnR0_d87, exnR0_d88, exnR0_d89, exnR0_d90, exnR0_d91, exnR0_d92 :  std_logic_vector(1 downto 0);
   -- timing of exnR0: (c0, 0.050000ns)
signal D, D_d1, D_d2, D_d3, D_d4, D_d5, D_d6, D_d7, D_d8, D_d9, D_d10, D_d11, D_d12, D_d13, D_d14, D_d15, D_d16, D_d17, D_d18, D_d19, D_d20, D_d21, D_d22, D_d23, D_d24, D_d25, D_d26, D_d27, D_d28, D_d29, D_d30, D_d31, D_d32, D_d33, D_d34, D_d35, D_d36, D_d37, D_d38, D_d39, D_d40, D_d41, D_d42, D_d43, D_d44, D_d45, D_d46, D_d47, D_d48, D_d49, D_d50, D_d51, D_d52, D_d53, D_d54, D_d55, D_d56, D_d57, D_d58, D_d59, D_d60, D_d61, D_d62, D_d63, D_d64, D_d65, D_d66, D_d67, D_d68, D_d69, D_d70, D_d71, D_d72, D_d73, D_d74, D_d75, D_d76, D_d77, D_d78, D_d79, D_d80 :  std_logic_vector(23 downto 0);
   -- timing of D: (c0, 0.000000ns)
signal psX :  std_logic_vector(24 downto 0);
   -- timing of psX: (c0, 0.000000ns)
signal betaw14, betaw14_d1, betaw14_d2, betaw14_d3, betaw14_d4, betaw14_d5, betaw14_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw14: (c0, 0.000000ns)
signal sel14 :  std_logic_vector(8 downto 0);
   -- timing of sel14: (c0, 0.000000ns)
signal q14, q14_d1, q14_d2, q14_d3, q14_d4, q14_d5 :  std_logic_vector(2 downto 0);
   -- timing of q14: (c1, 0.250000ns)
signal q14_copy5, q14_copy5_d1 :  std_logic_vector(2 downto 0);
   -- timing of q14_copy5: (c0, 0.000000ns)
signal absq14D, absq14D_d1, absq14D_d2, absq14D_d3, absq14D_d4, absq14D_d5 :  std_logic_vector(26 downto 0);
   -- timing of absq14D: (c1, 0.250000ns)
signal w13 :  std_logic_vector(26 downto 0);
   -- timing of w13: (c6, 0.010000ns)
signal betaw13, betaw13_d1, betaw13_d2, betaw13_d3, betaw13_d4, betaw13_d5, betaw13_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw13: (c6, 0.010000ns)
signal sel13 :  std_logic_vector(8 downto 0);
   -- timing of sel13: (c6, 0.010000ns)
signal q13, q13_d1, q13_d2, q13_d3, q13_d4, q13_d5 :  std_logic_vector(2 downto 0);
   -- timing of q13: (c7, 0.260000ns)
signal q13_copy6, q13_copy6_d1 :  std_logic_vector(2 downto 0);
   -- timing of q13_copy6: (c6, 0.010000ns)
signal absq13D, absq13D_d1, absq13D_d2, absq13D_d3, absq13D_d4, absq13D_d5 :  std_logic_vector(26 downto 0);
   -- timing of absq13D: (c7, 0.260000ns)
signal w12 :  std_logic_vector(26 downto 0);
   -- timing of w12: (c12, 0.020000ns)
signal betaw12, betaw12_d1, betaw12_d2, betaw12_d3, betaw12_d4, betaw12_d5, betaw12_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw12: (c12, 0.020000ns)
signal sel12 :  std_logic_vector(8 downto 0);
   -- timing of sel12: (c12, 0.020000ns)
signal q12, q12_d1, q12_d2, q12_d3, q12_d4, q12_d5 :  std_logic_vector(2 downto 0);
   -- timing of q12: (c13, 0.270000ns)
signal q12_copy7, q12_copy7_d1 :  std_logic_vector(2 downto 0);
   -- timing of q12_copy7: (c12, 0.020000ns)
signal absq12D, absq12D_d1, absq12D_d2, absq12D_d3, absq12D_d4, absq12D_d5 :  std_logic_vector(26 downto 0);
   -- timing of absq12D: (c13, 0.270000ns)
signal w11 :  std_logic_vector(26 downto 0);
   -- timing of w11: (c18, 0.030000ns)
signal betaw11, betaw11_d1, betaw11_d2, betaw11_d3, betaw11_d4, betaw11_d5, betaw11_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw11: (c18, 0.030000ns)
signal sel11 :  std_logic_vector(8 downto 0);
   -- timing of sel11: (c18, 0.030000ns)
signal q11, q11_d1, q11_d2, q11_d3, q11_d4, q11_d5 :  std_logic_vector(2 downto 0);
   -- timing of q11: (c19, 0.280000ns)
signal q11_copy8, q11_copy8_d1 :  std_logic_vector(2 downto 0);
   -- timing of q11_copy8: (c18, 0.030000ns)
signal absq11D, absq11D_d1, absq11D_d2, absq11D_d3, absq11D_d4, absq11D_d5 :  std_logic_vector(26 downto 0);
   -- timing of absq11D: (c19, 0.280000ns)
signal w10 :  std_logic_vector(26 downto 0);
   -- timing of w10: (c24, 0.040000ns)
signal betaw10, betaw10_d1, betaw10_d2, betaw10_d3, betaw10_d4, betaw10_d5, betaw10_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw10: (c24, 0.040000ns)
signal sel10 :  std_logic_vector(8 downto 0);
   -- timing of sel10: (c24, 0.040000ns)
signal q10, q10_d1, q10_d2, q10_d3, q10_d4, q10_d5 :  std_logic_vector(2 downto 0);
   -- timing of q10: (c25, 0.290000ns)
signal q10_copy9, q10_copy9_d1 :  std_logic_vector(2 downto 0);
   -- timing of q10_copy9: (c24, 0.040000ns)
signal absq10D, absq10D_d1, absq10D_d2, absq10D_d3, absq10D_d4, absq10D_d5 :  std_logic_vector(26 downto 0);
   -- timing of absq10D: (c25, 0.290000ns)
signal w9 :  std_logic_vector(26 downto 0);
   -- timing of w9: (c30, 0.050000ns)
signal betaw9, betaw9_d1, betaw9_d2, betaw9_d3, betaw9_d4, betaw9_d5, betaw9_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw9: (c30, 0.050000ns)
signal sel9 :  std_logic_vector(8 downto 0);
   -- timing of sel9: (c30, 0.050000ns)
signal q9, q9_d1, q9_d2, q9_d3, q9_d4 :  std_logic_vector(2 downto 0);
   -- timing of q9: (c32, 0.000000ns)
signal q9_copy10, q9_copy10_d1, q9_copy10_d2 :  std_logic_vector(2 downto 0);
   -- timing of q9_copy10: (c30, 0.050000ns)
signal absq9D, absq9D_d1, absq9D_d2, absq9D_d3, absq9D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq9D: (c32, 0.000000ns)
signal w8 :  std_logic_vector(26 downto 0);
   -- timing of w8: (c36, 0.060000ns)
signal betaw8, betaw8_d1, betaw8_d2, betaw8_d3, betaw8_d4, betaw8_d5, betaw8_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw8: (c36, 0.060000ns)
signal sel8 :  std_logic_vector(8 downto 0);
   -- timing of sel8: (c36, 0.060000ns)
signal q8, q8_d1, q8_d2, q8_d3, q8_d4 :  std_logic_vector(2 downto 0);
   -- timing of q8: (c38, 0.010000ns)
signal q8_copy11, q8_copy11_d1, q8_copy11_d2 :  std_logic_vector(2 downto 0);
   -- timing of q8_copy11: (c36, 0.060000ns)
signal absq8D, absq8D_d1, absq8D_d2, absq8D_d3, absq8D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq8D: (c38, 0.010000ns)
signal w7 :  std_logic_vector(26 downto 0);
   -- timing of w7: (c42, 0.070000ns)
signal betaw7, betaw7_d1, betaw7_d2, betaw7_d3, betaw7_d4, betaw7_d5, betaw7_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw7: (c42, 0.070000ns)
signal sel7 :  std_logic_vector(8 downto 0);
   -- timing of sel7: (c42, 0.070000ns)
signal q7, q7_d1, q7_d2, q7_d3, q7_d4 :  std_logic_vector(2 downto 0);
   -- timing of q7: (c44, 0.020000ns)
signal q7_copy12, q7_copy12_d1, q7_copy12_d2 :  std_logic_vector(2 downto 0);
   -- timing of q7_copy12: (c42, 0.070000ns)
signal absq7D, absq7D_d1, absq7D_d2, absq7D_d3, absq7D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq7D: (c44, 0.020000ns)
signal w6 :  std_logic_vector(26 downto 0);
   -- timing of w6: (c48, 0.080000ns)
signal betaw6, betaw6_d1, betaw6_d2, betaw6_d3, betaw6_d4, betaw6_d5, betaw6_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw6: (c48, 0.080000ns)
signal sel6 :  std_logic_vector(8 downto 0);
   -- timing of sel6: (c48, 0.080000ns)
signal q6, q6_d1, q6_d2, q6_d3, q6_d4 :  std_logic_vector(2 downto 0);
   -- timing of q6: (c50, 0.030000ns)
signal q6_copy13, q6_copy13_d1, q6_copy13_d2 :  std_logic_vector(2 downto 0);
   -- timing of q6_copy13: (c48, 0.080000ns)
signal absq6D, absq6D_d1, absq6D_d2, absq6D_d3, absq6D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq6D: (c50, 0.030000ns)
signal w5 :  std_logic_vector(26 downto 0);
   -- timing of w5: (c54, 0.090000ns)
signal betaw5, betaw5_d1, betaw5_d2, betaw5_d3, betaw5_d4, betaw5_d5, betaw5_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw5: (c54, 0.090000ns)
signal sel5 :  std_logic_vector(8 downto 0);
   -- timing of sel5: (c54, 0.090000ns)
signal q5, q5_d1, q5_d2, q5_d3, q5_d4 :  std_logic_vector(2 downto 0);
   -- timing of q5: (c56, 0.040000ns)
signal q5_copy14, q5_copy14_d1, q5_copy14_d2 :  std_logic_vector(2 downto 0);
   -- timing of q5_copy14: (c54, 0.090000ns)
signal absq5D, absq5D_d1, absq5D_d2, absq5D_d3, absq5D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq5D: (c56, 0.040000ns)
signal w4 :  std_logic_vector(26 downto 0);
   -- timing of w4: (c60, 0.100000ns)
signal betaw4, betaw4_d1, betaw4_d2, betaw4_d3, betaw4_d4, betaw4_d5, betaw4_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw4: (c60, 0.100000ns)
signal sel4 :  std_logic_vector(8 downto 0);
   -- timing of sel4: (c60, 0.100000ns)
signal q4, q4_d1, q4_d2, q4_d3, q4_d4 :  std_logic_vector(2 downto 0);
   -- timing of q4: (c62, 0.050000ns)
signal q4_copy15, q4_copy15_d1, q4_copy15_d2 :  std_logic_vector(2 downto 0);
   -- timing of q4_copy15: (c60, 0.100000ns)
signal absq4D, absq4D_d1, absq4D_d2, absq4D_d3, absq4D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq4D: (c62, 0.050000ns)
signal w3 :  std_logic_vector(26 downto 0);
   -- timing of w3: (c66, 0.110000ns)
signal betaw3, betaw3_d1, betaw3_d2, betaw3_d3, betaw3_d4, betaw3_d5, betaw3_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw3: (c66, 0.110000ns)
signal sel3 :  std_logic_vector(8 downto 0);
   -- timing of sel3: (c66, 0.110000ns)
signal q3, q3_d1, q3_d2, q3_d3, q3_d4 :  std_logic_vector(2 downto 0);
   -- timing of q3: (c68, 0.060000ns)
signal q3_copy16, q3_copy16_d1, q3_copy16_d2 :  std_logic_vector(2 downto 0);
   -- timing of q3_copy16: (c66, 0.110000ns)
signal absq3D, absq3D_d1, absq3D_d2, absq3D_d3, absq3D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq3D: (c68, 0.060000ns)
signal w2 :  std_logic_vector(26 downto 0);
   -- timing of w2: (c72, 0.120000ns)
signal betaw2, betaw2_d1, betaw2_d2, betaw2_d3, betaw2_d4, betaw2_d5, betaw2_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw2: (c72, 0.120000ns)
signal sel2 :  std_logic_vector(8 downto 0);
   -- timing of sel2: (c72, 0.120000ns)
signal q2, q2_d1, q2_d2, q2_d3, q2_d4 :  std_logic_vector(2 downto 0);
   -- timing of q2: (c74, 0.070000ns)
signal q2_copy17, q2_copy17_d1, q2_copy17_d2 :  std_logic_vector(2 downto 0);
   -- timing of q2_copy17: (c72, 0.120000ns)
signal absq2D, absq2D_d1, absq2D_d2, absq2D_d3, absq2D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq2D: (c74, 0.070000ns)
signal w1 :  std_logic_vector(26 downto 0);
   -- timing of w1: (c78, 0.130000ns)
signal betaw1, betaw1_d1, betaw1_d2, betaw1_d3, betaw1_d4, betaw1_d5, betaw1_d6 :  std_logic_vector(26 downto 0);
   -- timing of betaw1: (c78, 0.130000ns)
signal sel1 :  std_logic_vector(8 downto 0);
   -- timing of sel1: (c78, 0.130000ns)
signal q1, q1_d1, q1_d2, q1_d3, q1_d4 :  std_logic_vector(2 downto 0);
   -- timing of q1: (c80, 0.080000ns)
signal q1_copy18, q1_copy18_d1, q1_copy18_d2 :  std_logic_vector(2 downto 0);
   -- timing of q1_copy18: (c78, 0.130000ns)
signal absq1D, absq1D_d1, absq1D_d2, absq1D_d3, absq1D_d4 :  std_logic_vector(26 downto 0);
   -- timing of absq1D: (c80, 0.080000ns)
signal w0 :  std_logic_vector(26 downto 0);
   -- timing of w0: (c84, 0.140000ns)
signal wfinal :  std_logic_vector(24 downto 0);
   -- timing of wfinal: (c84, 0.140000ns)
signal qM0 :  std_logic;
   -- timing of qM0: (c84, 0.140000ns)
signal qP14, qP14_d1, qP14_d2, qP14_d3, qP14_d4, qP14_d5, qP14_d6, qP14_d7, qP14_d8, qP14_d9, qP14_d10, qP14_d11, qP14_d12, qP14_d13, qP14_d14, qP14_d15, qP14_d16, qP14_d17, qP14_d18, qP14_d19, qP14_d20, qP14_d21, qP14_d22, qP14_d23, qP14_d24, qP14_d25, qP14_d26, qP14_d27, qP14_d28, qP14_d29, qP14_d30, qP14_d31, qP14_d32, qP14_d33, qP14_d34, qP14_d35, qP14_d36, qP14_d37, qP14_d38, qP14_d39, qP14_d40, qP14_d41, qP14_d42, qP14_d43, qP14_d44, qP14_d45, qP14_d46, qP14_d47, qP14_d48, qP14_d49, qP14_d50, qP14_d51, qP14_d52, qP14_d53, qP14_d54, qP14_d55, qP14_d56, qP14_d57, qP14_d58, qP14_d59, qP14_d60, qP14_d61, qP14_d62, qP14_d63, qP14_d64, qP14_d65, qP14_d66, qP14_d67, qP14_d68, qP14_d69, qP14_d70, qP14_d71, qP14_d72, qP14_d73, qP14_d74, qP14_d75, qP14_d76, qP14_d77, qP14_d78, qP14_d79 :  std_logic_vector(1 downto 0);
   -- timing of qP14: (c1, 0.250000ns)
signal qM14, qM14_d1, qM14_d2, qM14_d3, qM14_d4, qM14_d5, qM14_d6, qM14_d7, qM14_d8, qM14_d9, qM14_d10, qM14_d11, qM14_d12, qM14_d13, qM14_d14, qM14_d15, qM14_d16, qM14_d17, qM14_d18, qM14_d19, qM14_d20, qM14_d21, qM14_d22, qM14_d23, qM14_d24, qM14_d25, qM14_d26, qM14_d27, qM14_d28, qM14_d29, qM14_d30, qM14_d31, qM14_d32, qM14_d33, qM14_d34, qM14_d35, qM14_d36, qM14_d37, qM14_d38, qM14_d39, qM14_d40, qM14_d41, qM14_d42, qM14_d43, qM14_d44, qM14_d45, qM14_d46, qM14_d47, qM14_d48, qM14_d49, qM14_d50, qM14_d51, qM14_d52, qM14_d53, qM14_d54, qM14_d55, qM14_d56, qM14_d57, qM14_d58, qM14_d59, qM14_d60, qM14_d61, qM14_d62, qM14_d63, qM14_d64, qM14_d65, qM14_d66, qM14_d67, qM14_d68, qM14_d69, qM14_d70, qM14_d71, qM14_d72, qM14_d73, qM14_d74, qM14_d75, qM14_d76, qM14_d77, qM14_d78, qM14_d79, qM14_d80, qM14_d81, qM14_d82, qM14_d83 :  std_logic_vector(1 downto 0);
   -- timing of qM14: (c1, 0.250000ns)
signal qP13, qP13_d1, qP13_d2, qP13_d3, qP13_d4, qP13_d5, qP13_d6, qP13_d7, qP13_d8, qP13_d9, qP13_d10, qP13_d11, qP13_d12, qP13_d13, qP13_d14, qP13_d15, qP13_d16, qP13_d17, qP13_d18, qP13_d19, qP13_d20, qP13_d21, qP13_d22, qP13_d23, qP13_d24, qP13_d25, qP13_d26, qP13_d27, qP13_d28, qP13_d29, qP13_d30, qP13_d31, qP13_d32, qP13_d33, qP13_d34, qP13_d35, qP13_d36, qP13_d37, qP13_d38, qP13_d39, qP13_d40, qP13_d41, qP13_d42, qP13_d43, qP13_d44, qP13_d45, qP13_d46, qP13_d47, qP13_d48, qP13_d49, qP13_d50, qP13_d51, qP13_d52, qP13_d53, qP13_d54, qP13_d55, qP13_d56, qP13_d57, qP13_d58, qP13_d59, qP13_d60, qP13_d61, qP13_d62, qP13_d63, qP13_d64, qP13_d65, qP13_d66, qP13_d67, qP13_d68, qP13_d69, qP13_d70, qP13_d71, qP13_d72, qP13_d73 :  std_logic_vector(1 downto 0);
   -- timing of qP13: (c7, 0.260000ns)
signal qM13, qM13_d1, qM13_d2, qM13_d3, qM13_d4, qM13_d5, qM13_d6, qM13_d7, qM13_d8, qM13_d9, qM13_d10, qM13_d11, qM13_d12, qM13_d13, qM13_d14, qM13_d15, qM13_d16, qM13_d17, qM13_d18, qM13_d19, qM13_d20, qM13_d21, qM13_d22, qM13_d23, qM13_d24, qM13_d25, qM13_d26, qM13_d27, qM13_d28, qM13_d29, qM13_d30, qM13_d31, qM13_d32, qM13_d33, qM13_d34, qM13_d35, qM13_d36, qM13_d37, qM13_d38, qM13_d39, qM13_d40, qM13_d41, qM13_d42, qM13_d43, qM13_d44, qM13_d45, qM13_d46, qM13_d47, qM13_d48, qM13_d49, qM13_d50, qM13_d51, qM13_d52, qM13_d53, qM13_d54, qM13_d55, qM13_d56, qM13_d57, qM13_d58, qM13_d59, qM13_d60, qM13_d61, qM13_d62, qM13_d63, qM13_d64, qM13_d65, qM13_d66, qM13_d67, qM13_d68, qM13_d69, qM13_d70, qM13_d71, qM13_d72, qM13_d73, qM13_d74, qM13_d75, qM13_d76, qM13_d77 :  std_logic_vector(1 downto 0);
   -- timing of qM13: (c7, 0.260000ns)
signal qP12, qP12_d1, qP12_d2, qP12_d3, qP12_d4, qP12_d5, qP12_d6, qP12_d7, qP12_d8, qP12_d9, qP12_d10, qP12_d11, qP12_d12, qP12_d13, qP12_d14, qP12_d15, qP12_d16, qP12_d17, qP12_d18, qP12_d19, qP12_d20, qP12_d21, qP12_d22, qP12_d23, qP12_d24, qP12_d25, qP12_d26, qP12_d27, qP12_d28, qP12_d29, qP12_d30, qP12_d31, qP12_d32, qP12_d33, qP12_d34, qP12_d35, qP12_d36, qP12_d37, qP12_d38, qP12_d39, qP12_d40, qP12_d41, qP12_d42, qP12_d43, qP12_d44, qP12_d45, qP12_d46, qP12_d47, qP12_d48, qP12_d49, qP12_d50, qP12_d51, qP12_d52, qP12_d53, qP12_d54, qP12_d55, qP12_d56, qP12_d57, qP12_d58, qP12_d59, qP12_d60, qP12_d61, qP12_d62, qP12_d63, qP12_d64, qP12_d65, qP12_d66, qP12_d67 :  std_logic_vector(1 downto 0);
   -- timing of qP12: (c13, 0.270000ns)
signal qM12, qM12_d1, qM12_d2, qM12_d3, qM12_d4, qM12_d5, qM12_d6, qM12_d7, qM12_d8, qM12_d9, qM12_d10, qM12_d11, qM12_d12, qM12_d13, qM12_d14, qM12_d15, qM12_d16, qM12_d17, qM12_d18, qM12_d19, qM12_d20, qM12_d21, qM12_d22, qM12_d23, qM12_d24, qM12_d25, qM12_d26, qM12_d27, qM12_d28, qM12_d29, qM12_d30, qM12_d31, qM12_d32, qM12_d33, qM12_d34, qM12_d35, qM12_d36, qM12_d37, qM12_d38, qM12_d39, qM12_d40, qM12_d41, qM12_d42, qM12_d43, qM12_d44, qM12_d45, qM12_d46, qM12_d47, qM12_d48, qM12_d49, qM12_d50, qM12_d51, qM12_d52, qM12_d53, qM12_d54, qM12_d55, qM12_d56, qM12_d57, qM12_d58, qM12_d59, qM12_d60, qM12_d61, qM12_d62, qM12_d63, qM12_d64, qM12_d65, qM12_d66, qM12_d67, qM12_d68, qM12_d69, qM12_d70, qM12_d71 :  std_logic_vector(1 downto 0);
   -- timing of qM12: (c13, 0.270000ns)
signal qP11, qP11_d1, qP11_d2, qP11_d3, qP11_d4, qP11_d5, qP11_d6, qP11_d7, qP11_d8, qP11_d9, qP11_d10, qP11_d11, qP11_d12, qP11_d13, qP11_d14, qP11_d15, qP11_d16, qP11_d17, qP11_d18, qP11_d19, qP11_d20, qP11_d21, qP11_d22, qP11_d23, qP11_d24, qP11_d25, qP11_d26, qP11_d27, qP11_d28, qP11_d29, qP11_d30, qP11_d31, qP11_d32, qP11_d33, qP11_d34, qP11_d35, qP11_d36, qP11_d37, qP11_d38, qP11_d39, qP11_d40, qP11_d41, qP11_d42, qP11_d43, qP11_d44, qP11_d45, qP11_d46, qP11_d47, qP11_d48, qP11_d49, qP11_d50, qP11_d51, qP11_d52, qP11_d53, qP11_d54, qP11_d55, qP11_d56, qP11_d57, qP11_d58, qP11_d59, qP11_d60, qP11_d61 :  std_logic_vector(1 downto 0);
   -- timing of qP11: (c19, 0.280000ns)
signal qM11, qM11_d1, qM11_d2, qM11_d3, qM11_d4, qM11_d5, qM11_d6, qM11_d7, qM11_d8, qM11_d9, qM11_d10, qM11_d11, qM11_d12, qM11_d13, qM11_d14, qM11_d15, qM11_d16, qM11_d17, qM11_d18, qM11_d19, qM11_d20, qM11_d21, qM11_d22, qM11_d23, qM11_d24, qM11_d25, qM11_d26, qM11_d27, qM11_d28, qM11_d29, qM11_d30, qM11_d31, qM11_d32, qM11_d33, qM11_d34, qM11_d35, qM11_d36, qM11_d37, qM11_d38, qM11_d39, qM11_d40, qM11_d41, qM11_d42, qM11_d43, qM11_d44, qM11_d45, qM11_d46, qM11_d47, qM11_d48, qM11_d49, qM11_d50, qM11_d51, qM11_d52, qM11_d53, qM11_d54, qM11_d55, qM11_d56, qM11_d57, qM11_d58, qM11_d59, qM11_d60, qM11_d61, qM11_d62, qM11_d63, qM11_d64, qM11_d65 :  std_logic_vector(1 downto 0);
   -- timing of qM11: (c19, 0.280000ns)
signal qP10, qP10_d1, qP10_d2, qP10_d3, qP10_d4, qP10_d5, qP10_d6, qP10_d7, qP10_d8, qP10_d9, qP10_d10, qP10_d11, qP10_d12, qP10_d13, qP10_d14, qP10_d15, qP10_d16, qP10_d17, qP10_d18, qP10_d19, qP10_d20, qP10_d21, qP10_d22, qP10_d23, qP10_d24, qP10_d25, qP10_d26, qP10_d27, qP10_d28, qP10_d29, qP10_d30, qP10_d31, qP10_d32, qP10_d33, qP10_d34, qP10_d35, qP10_d36, qP10_d37, qP10_d38, qP10_d39, qP10_d40, qP10_d41, qP10_d42, qP10_d43, qP10_d44, qP10_d45, qP10_d46, qP10_d47, qP10_d48, qP10_d49, qP10_d50, qP10_d51, qP10_d52, qP10_d53, qP10_d54, qP10_d55 :  std_logic_vector(1 downto 0);
   -- timing of qP10: (c25, 0.290000ns)
signal qM10, qM10_d1, qM10_d2, qM10_d3, qM10_d4, qM10_d5, qM10_d6, qM10_d7, qM10_d8, qM10_d9, qM10_d10, qM10_d11, qM10_d12, qM10_d13, qM10_d14, qM10_d15, qM10_d16, qM10_d17, qM10_d18, qM10_d19, qM10_d20, qM10_d21, qM10_d22, qM10_d23, qM10_d24, qM10_d25, qM10_d26, qM10_d27, qM10_d28, qM10_d29, qM10_d30, qM10_d31, qM10_d32, qM10_d33, qM10_d34, qM10_d35, qM10_d36, qM10_d37, qM10_d38, qM10_d39, qM10_d40, qM10_d41, qM10_d42, qM10_d43, qM10_d44, qM10_d45, qM10_d46, qM10_d47, qM10_d48, qM10_d49, qM10_d50, qM10_d51, qM10_d52, qM10_d53, qM10_d54, qM10_d55, qM10_d56, qM10_d57, qM10_d58, qM10_d59 :  std_logic_vector(1 downto 0);
   -- timing of qM10: (c25, 0.290000ns)
signal qP9, qP9_d1, qP9_d2, qP9_d3, qP9_d4, qP9_d5, qP9_d6, qP9_d7, qP9_d8, qP9_d9, qP9_d10, qP9_d11, qP9_d12, qP9_d13, qP9_d14, qP9_d15, qP9_d16, qP9_d17, qP9_d18, qP9_d19, qP9_d20, qP9_d21, qP9_d22, qP9_d23, qP9_d24, qP9_d25, qP9_d26, qP9_d27, qP9_d28, qP9_d29, qP9_d30, qP9_d31, qP9_d32, qP9_d33, qP9_d34, qP9_d35, qP9_d36, qP9_d37, qP9_d38, qP9_d39, qP9_d40, qP9_d41, qP9_d42, qP9_d43, qP9_d44, qP9_d45, qP9_d46, qP9_d47, qP9_d48 :  std_logic_vector(1 downto 0);
   -- timing of qP9: (c32, 0.000000ns)
signal qM9, qM9_d1, qM9_d2, qM9_d3, qM9_d4, qM9_d5, qM9_d6, qM9_d7, qM9_d8, qM9_d9, qM9_d10, qM9_d11, qM9_d12, qM9_d13, qM9_d14, qM9_d15, qM9_d16, qM9_d17, qM9_d18, qM9_d19, qM9_d20, qM9_d21, qM9_d22, qM9_d23, qM9_d24, qM9_d25, qM9_d26, qM9_d27, qM9_d28, qM9_d29, qM9_d30, qM9_d31, qM9_d32, qM9_d33, qM9_d34, qM9_d35, qM9_d36, qM9_d37, qM9_d38, qM9_d39, qM9_d40, qM9_d41, qM9_d42, qM9_d43, qM9_d44, qM9_d45, qM9_d46, qM9_d47, qM9_d48, qM9_d49, qM9_d50, qM9_d51, qM9_d52 :  std_logic_vector(1 downto 0);
   -- timing of qM9: (c32, 0.000000ns)
signal qP8, qP8_d1, qP8_d2, qP8_d3, qP8_d4, qP8_d5, qP8_d6, qP8_d7, qP8_d8, qP8_d9, qP8_d10, qP8_d11, qP8_d12, qP8_d13, qP8_d14, qP8_d15, qP8_d16, qP8_d17, qP8_d18, qP8_d19, qP8_d20, qP8_d21, qP8_d22, qP8_d23, qP8_d24, qP8_d25, qP8_d26, qP8_d27, qP8_d28, qP8_d29, qP8_d30, qP8_d31, qP8_d32, qP8_d33, qP8_d34, qP8_d35, qP8_d36, qP8_d37, qP8_d38, qP8_d39, qP8_d40, qP8_d41, qP8_d42 :  std_logic_vector(1 downto 0);
   -- timing of qP8: (c38, 0.010000ns)
signal qM8, qM8_d1, qM8_d2, qM8_d3, qM8_d4, qM8_d5, qM8_d6, qM8_d7, qM8_d8, qM8_d9, qM8_d10, qM8_d11, qM8_d12, qM8_d13, qM8_d14, qM8_d15, qM8_d16, qM8_d17, qM8_d18, qM8_d19, qM8_d20, qM8_d21, qM8_d22, qM8_d23, qM8_d24, qM8_d25, qM8_d26, qM8_d27, qM8_d28, qM8_d29, qM8_d30, qM8_d31, qM8_d32, qM8_d33, qM8_d34, qM8_d35, qM8_d36, qM8_d37, qM8_d38, qM8_d39, qM8_d40, qM8_d41, qM8_d42, qM8_d43, qM8_d44, qM8_d45, qM8_d46 :  std_logic_vector(1 downto 0);
   -- timing of qM8: (c38, 0.010000ns)
signal qP7, qP7_d1, qP7_d2, qP7_d3, qP7_d4, qP7_d5, qP7_d6, qP7_d7, qP7_d8, qP7_d9, qP7_d10, qP7_d11, qP7_d12, qP7_d13, qP7_d14, qP7_d15, qP7_d16, qP7_d17, qP7_d18, qP7_d19, qP7_d20, qP7_d21, qP7_d22, qP7_d23, qP7_d24, qP7_d25, qP7_d26, qP7_d27, qP7_d28, qP7_d29, qP7_d30, qP7_d31, qP7_d32, qP7_d33, qP7_d34, qP7_d35, qP7_d36 :  std_logic_vector(1 downto 0);
   -- timing of qP7: (c44, 0.020000ns)
signal qM7, qM7_d1, qM7_d2, qM7_d3, qM7_d4, qM7_d5, qM7_d6, qM7_d7, qM7_d8, qM7_d9, qM7_d10, qM7_d11, qM7_d12, qM7_d13, qM7_d14, qM7_d15, qM7_d16, qM7_d17, qM7_d18, qM7_d19, qM7_d20, qM7_d21, qM7_d22, qM7_d23, qM7_d24, qM7_d25, qM7_d26, qM7_d27, qM7_d28, qM7_d29, qM7_d30, qM7_d31, qM7_d32, qM7_d33, qM7_d34, qM7_d35, qM7_d36, qM7_d37, qM7_d38, qM7_d39, qM7_d40 :  std_logic_vector(1 downto 0);
   -- timing of qM7: (c44, 0.020000ns)
signal qP6, qP6_d1, qP6_d2, qP6_d3, qP6_d4, qP6_d5, qP6_d6, qP6_d7, qP6_d8, qP6_d9, qP6_d10, qP6_d11, qP6_d12, qP6_d13, qP6_d14, qP6_d15, qP6_d16, qP6_d17, qP6_d18, qP6_d19, qP6_d20, qP6_d21, qP6_d22, qP6_d23, qP6_d24, qP6_d25, qP6_d26, qP6_d27, qP6_d28, qP6_d29, qP6_d30 :  std_logic_vector(1 downto 0);
   -- timing of qP6: (c50, 0.030000ns)
signal qM6, qM6_d1, qM6_d2, qM6_d3, qM6_d4, qM6_d5, qM6_d6, qM6_d7, qM6_d8, qM6_d9, qM6_d10, qM6_d11, qM6_d12, qM6_d13, qM6_d14, qM6_d15, qM6_d16, qM6_d17, qM6_d18, qM6_d19, qM6_d20, qM6_d21, qM6_d22, qM6_d23, qM6_d24, qM6_d25, qM6_d26, qM6_d27, qM6_d28, qM6_d29, qM6_d30, qM6_d31, qM6_d32, qM6_d33, qM6_d34 :  std_logic_vector(1 downto 0);
   -- timing of qM6: (c50, 0.030000ns)
signal qP5, qP5_d1, qP5_d2, qP5_d3, qP5_d4, qP5_d5, qP5_d6, qP5_d7, qP5_d8, qP5_d9, qP5_d10, qP5_d11, qP5_d12, qP5_d13, qP5_d14, qP5_d15, qP5_d16, qP5_d17, qP5_d18, qP5_d19, qP5_d20, qP5_d21, qP5_d22, qP5_d23, qP5_d24 :  std_logic_vector(1 downto 0);
   -- timing of qP5: (c56, 0.040000ns)
signal qM5, qM5_d1, qM5_d2, qM5_d3, qM5_d4, qM5_d5, qM5_d6, qM5_d7, qM5_d8, qM5_d9, qM5_d10, qM5_d11, qM5_d12, qM5_d13, qM5_d14, qM5_d15, qM5_d16, qM5_d17, qM5_d18, qM5_d19, qM5_d20, qM5_d21, qM5_d22, qM5_d23, qM5_d24, qM5_d25, qM5_d26, qM5_d27, qM5_d28 :  std_logic_vector(1 downto 0);
   -- timing of qM5: (c56, 0.040000ns)
signal qP4, qP4_d1, qP4_d2, qP4_d3, qP4_d4, qP4_d5, qP4_d6, qP4_d7, qP4_d8, qP4_d9, qP4_d10, qP4_d11, qP4_d12, qP4_d13, qP4_d14, qP4_d15, qP4_d16, qP4_d17, qP4_d18 :  std_logic_vector(1 downto 0);
   -- timing of qP4: (c62, 0.050000ns)
signal qM4, qM4_d1, qM4_d2, qM4_d3, qM4_d4, qM4_d5, qM4_d6, qM4_d7, qM4_d8, qM4_d9, qM4_d10, qM4_d11, qM4_d12, qM4_d13, qM4_d14, qM4_d15, qM4_d16, qM4_d17, qM4_d18, qM4_d19, qM4_d20, qM4_d21, qM4_d22 :  std_logic_vector(1 downto 0);
   -- timing of qM4: (c62, 0.050000ns)
signal qP3, qP3_d1, qP3_d2, qP3_d3, qP3_d4, qP3_d5, qP3_d6, qP3_d7, qP3_d8, qP3_d9, qP3_d10, qP3_d11, qP3_d12 :  std_logic_vector(1 downto 0);
   -- timing of qP3: (c68, 0.060000ns)
signal qM3, qM3_d1, qM3_d2, qM3_d3, qM3_d4, qM3_d5, qM3_d6, qM3_d7, qM3_d8, qM3_d9, qM3_d10, qM3_d11, qM3_d12, qM3_d13, qM3_d14, qM3_d15, qM3_d16 :  std_logic_vector(1 downto 0);
   -- timing of qM3: (c68, 0.060000ns)
signal qP2, qP2_d1, qP2_d2, qP2_d3, qP2_d4, qP2_d5, qP2_d6 :  std_logic_vector(1 downto 0);
   -- timing of qP2: (c74, 0.070000ns)
signal qM2, qM2_d1, qM2_d2, qM2_d3, qM2_d4, qM2_d5, qM2_d6, qM2_d7, qM2_d8, qM2_d9, qM2_d10 :  std_logic_vector(1 downto 0);
   -- timing of qM2: (c74, 0.070000ns)
signal qP1 :  std_logic_vector(1 downto 0);
   -- timing of qP1: (c80, 0.080000ns)
signal qM1, qM1_d1, qM1_d2, qM1_d3, qM1_d4 :  std_logic_vector(1 downto 0);
   -- timing of qM1: (c80, 0.080000ns)
signal qP, qP_d1, qP_d2, qP_d3, qP_d4, qP_d5, qP_d6, qP_d7, qP_d8 :  std_logic_vector(27 downto 0);
   -- timing of qP: (c80, 0.080000ns)
signal qM, qM_d1, qM_d2, qM_d3, qM_d4 :  std_logic_vector(27 downto 0);
   -- timing of qM: (c84, 0.140000ns)
signal quotient :  std_logic_vector(27 downto 0);
   -- timing of quotient: (c88, 0.230000ns)
signal mR, mR_d1, mR_d2, mR_d3, mR_d4 :  std_logic_vector(25 downto 0);
   -- timing of mR: (c88, 0.280000ns)
signal fRnorm, fRnorm_d1, fRnorm_d2, fRnorm_d3 :  std_logic_vector(23 downto 0);
   -- timing of fRnorm: (c89, 0.030000ns)
signal round, round_d1, round_d2, round_d3 :  std_logic;
   -- timing of round: (c89, 0.080000ns)
signal expR1 :  std_logic_vector(9 downto 0);
   -- timing of expR1: (c92, 0.170000ns)
signal expfrac :  std_logic_vector(32 downto 0);
   -- timing of expfrac: (c92, 0.170000ns)
signal expfracR :  std_logic_vector(32 downto 0);
   -- timing of expfracR: (c92, 0.170000ns)
signal exnR :  std_logic_vector(1 downto 0);
   -- timing of exnR: (c92, 0.220000ns)
signal exnRfinal :  std_logic_vector(1 downto 0);
   -- timing of exnRfinal: (c92, 0.270000ns)
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            expR0_d1 <=  expR0;
            expR0_d2 <=  expR0_d1;
            expR0_d3 <=  expR0_d2;
            expR0_d4 <=  expR0_d3;
            expR0_d5 <=  expR0_d4;
            expR0_d6 <=  expR0_d5;
            expR0_d7 <=  expR0_d6;
            expR0_d8 <=  expR0_d7;
            expR0_d9 <=  expR0_d8;
            expR0_d10 <=  expR0_d9;
            expR0_d11 <=  expR0_d10;
            expR0_d12 <=  expR0_d11;
            expR0_d13 <=  expR0_d12;
            expR0_d14 <=  expR0_d13;
            expR0_d15 <=  expR0_d14;
            expR0_d16 <=  expR0_d15;
            expR0_d17 <=  expR0_d16;
            expR0_d18 <=  expR0_d17;
            expR0_d19 <=  expR0_d18;
            expR0_d20 <=  expR0_d19;
            expR0_d21 <=  expR0_d20;
            expR0_d22 <=  expR0_d21;
            expR0_d23 <=  expR0_d22;
            expR0_d24 <=  expR0_d23;
            expR0_d25 <=  expR0_d24;
            expR0_d26 <=  expR0_d25;
            expR0_d27 <=  expR0_d26;
            expR0_d28 <=  expR0_d27;
            expR0_d29 <=  expR0_d28;
            expR0_d30 <=  expR0_d29;
            expR0_d31 <=  expR0_d30;
            expR0_d32 <=  expR0_d31;
            expR0_d33 <=  expR0_d32;
            expR0_d34 <=  expR0_d33;
            expR0_d35 <=  expR0_d34;
            expR0_d36 <=  expR0_d35;
            expR0_d37 <=  expR0_d36;
            expR0_d38 <=  expR0_d37;
            expR0_d39 <=  expR0_d38;
            expR0_d40 <=  expR0_d39;
            expR0_d41 <=  expR0_d40;
            expR0_d42 <=  expR0_d41;
            expR0_d43 <=  expR0_d42;
            expR0_d44 <=  expR0_d43;
            expR0_d45 <=  expR0_d44;
            expR0_d46 <=  expR0_d45;
            expR0_d47 <=  expR0_d46;
            expR0_d48 <=  expR0_d47;
            expR0_d49 <=  expR0_d48;
            expR0_d50 <=  expR0_d49;
            expR0_d51 <=  expR0_d50;
            expR0_d52 <=  expR0_d51;
            expR0_d53 <=  expR0_d52;
            expR0_d54 <=  expR0_d53;
            expR0_d55 <=  expR0_d54;
            expR0_d56 <=  expR0_d55;
            expR0_d57 <=  expR0_d56;
            expR0_d58 <=  expR0_d57;
            expR0_d59 <=  expR0_d58;
            expR0_d60 <=  expR0_d59;
            expR0_d61 <=  expR0_d60;
            expR0_d62 <=  expR0_d61;
            expR0_d63 <=  expR0_d62;
            expR0_d64 <=  expR0_d63;
            expR0_d65 <=  expR0_d64;
            expR0_d66 <=  expR0_d65;
            expR0_d67 <=  expR0_d66;
            expR0_d68 <=  expR0_d67;
            expR0_d69 <=  expR0_d68;
            expR0_d70 <=  expR0_d69;
            expR0_d71 <=  expR0_d70;
            expR0_d72 <=  expR0_d71;
            expR0_d73 <=  expR0_d72;
            expR0_d74 <=  expR0_d73;
            expR0_d75 <=  expR0_d74;
            expR0_d76 <=  expR0_d75;
            expR0_d77 <=  expR0_d76;
            expR0_d78 <=  expR0_d77;
            expR0_d79 <=  expR0_d78;
            expR0_d80 <=  expR0_d79;
            expR0_d81 <=  expR0_d80;
            expR0_d82 <=  expR0_d81;
            expR0_d83 <=  expR0_d82;
            expR0_d84 <=  expR0_d83;
            expR0_d85 <=  expR0_d84;
            expR0_d86 <=  expR0_d85;
            expR0_d87 <=  expR0_d86;
            expR0_d88 <=  expR0_d87;
            expR0_d89 <=  expR0_d88;
            expR0_d90 <=  expR0_d89;
            expR0_d91 <=  expR0_d90;
            expR0_d92 <=  expR0_d91;
            sR_d1 <=  sR;
            sR_d2 <=  sR_d1;
            sR_d3 <=  sR_d2;
            sR_d4 <=  sR_d3;
            sR_d5 <=  sR_d4;
            sR_d6 <=  sR_d5;
            sR_d7 <=  sR_d6;
            sR_d8 <=  sR_d7;
            sR_d9 <=  sR_d8;
            sR_d10 <=  sR_d9;
            sR_d11 <=  sR_d10;
            sR_d12 <=  sR_d11;
            sR_d13 <=  sR_d12;
            sR_d14 <=  sR_d13;
            sR_d15 <=  sR_d14;
            sR_d16 <=  sR_d15;
            sR_d17 <=  sR_d16;
            sR_d18 <=  sR_d17;
            sR_d19 <=  sR_d18;
            sR_d20 <=  sR_d19;
            sR_d21 <=  sR_d20;
            sR_d22 <=  sR_d21;
            sR_d23 <=  sR_d22;
            sR_d24 <=  sR_d23;
            sR_d25 <=  sR_d24;
            sR_d26 <=  sR_d25;
            sR_d27 <=  sR_d26;
            sR_d28 <=  sR_d27;
            sR_d29 <=  sR_d28;
            sR_d30 <=  sR_d29;
            sR_d31 <=  sR_d30;
            sR_d32 <=  sR_d31;
            sR_d33 <=  sR_d32;
            sR_d34 <=  sR_d33;
            sR_d35 <=  sR_d34;
            sR_d36 <=  sR_d35;
            sR_d37 <=  sR_d36;
            sR_d38 <=  sR_d37;
            sR_d39 <=  sR_d38;
            sR_d40 <=  sR_d39;
            sR_d41 <=  sR_d40;
            sR_d42 <=  sR_d41;
            sR_d43 <=  sR_d42;
            sR_d44 <=  sR_d43;
            sR_d45 <=  sR_d44;
            sR_d46 <=  sR_d45;
            sR_d47 <=  sR_d46;
            sR_d48 <=  sR_d47;
            sR_d49 <=  sR_d48;
            sR_d50 <=  sR_d49;
            sR_d51 <=  sR_d50;
            sR_d52 <=  sR_d51;
            sR_d53 <=  sR_d52;
            sR_d54 <=  sR_d53;
            sR_d55 <=  sR_d54;
            sR_d56 <=  sR_d55;
            sR_d57 <=  sR_d56;
            sR_d58 <=  sR_d57;
            sR_d59 <=  sR_d58;
            sR_d60 <=  sR_d59;
            sR_d61 <=  sR_d60;
            sR_d62 <=  sR_d61;
            sR_d63 <=  sR_d62;
            sR_d64 <=  sR_d63;
            sR_d65 <=  sR_d64;
            sR_d66 <=  sR_d65;
            sR_d67 <=  sR_d66;
            sR_d68 <=  sR_d67;
            sR_d69 <=  sR_d68;
            sR_d70 <=  sR_d69;
            sR_d71 <=  sR_d70;
            sR_d72 <=  sR_d71;
            sR_d73 <=  sR_d72;
            sR_d74 <=  sR_d73;
            sR_d75 <=  sR_d74;
            sR_d76 <=  sR_d75;
            sR_d77 <=  sR_d76;
            sR_d78 <=  sR_d77;
            sR_d79 <=  sR_d78;
            sR_d80 <=  sR_d79;
            sR_d81 <=  sR_d80;
            sR_d82 <=  sR_d81;
            sR_d83 <=  sR_d82;
            sR_d84 <=  sR_d83;
            sR_d85 <=  sR_d84;
            sR_d86 <=  sR_d85;
            sR_d87 <=  sR_d86;
            sR_d88 <=  sR_d87;
            sR_d89 <=  sR_d88;
            sR_d90 <=  sR_d89;
            sR_d91 <=  sR_d90;
            sR_d92 <=  sR_d91;
            exnR0_d1 <=  exnR0;
            exnR0_d2 <=  exnR0_d1;
            exnR0_d3 <=  exnR0_d2;
            exnR0_d4 <=  exnR0_d3;
            exnR0_d5 <=  exnR0_d4;
            exnR0_d6 <=  exnR0_d5;
            exnR0_d7 <=  exnR0_d6;
            exnR0_d8 <=  exnR0_d7;
            exnR0_d9 <=  exnR0_d8;
            exnR0_d10 <=  exnR0_d9;
            exnR0_d11 <=  exnR0_d10;
            exnR0_d12 <=  exnR0_d11;
            exnR0_d13 <=  exnR0_d12;
            exnR0_d14 <=  exnR0_d13;
            exnR0_d15 <=  exnR0_d14;
            exnR0_d16 <=  exnR0_d15;
            exnR0_d17 <=  exnR0_d16;
            exnR0_d18 <=  exnR0_d17;
            exnR0_d19 <=  exnR0_d18;
            exnR0_d20 <=  exnR0_d19;
            exnR0_d21 <=  exnR0_d20;
            exnR0_d22 <=  exnR0_d21;
            exnR0_d23 <=  exnR0_d22;
            exnR0_d24 <=  exnR0_d23;
            exnR0_d25 <=  exnR0_d24;
            exnR0_d26 <=  exnR0_d25;
            exnR0_d27 <=  exnR0_d26;
            exnR0_d28 <=  exnR0_d27;
            exnR0_d29 <=  exnR0_d28;
            exnR0_d30 <=  exnR0_d29;
            exnR0_d31 <=  exnR0_d30;
            exnR0_d32 <=  exnR0_d31;
            exnR0_d33 <=  exnR0_d32;
            exnR0_d34 <=  exnR0_d33;
            exnR0_d35 <=  exnR0_d34;
            exnR0_d36 <=  exnR0_d35;
            exnR0_d37 <=  exnR0_d36;
            exnR0_d38 <=  exnR0_d37;
            exnR0_d39 <=  exnR0_d38;
            exnR0_d40 <=  exnR0_d39;
            exnR0_d41 <=  exnR0_d40;
            exnR0_d42 <=  exnR0_d41;
            exnR0_d43 <=  exnR0_d42;
            exnR0_d44 <=  exnR0_d43;
            exnR0_d45 <=  exnR0_d44;
            exnR0_d46 <=  exnR0_d45;
            exnR0_d47 <=  exnR0_d46;
            exnR0_d48 <=  exnR0_d47;
            exnR0_d49 <=  exnR0_d48;
            exnR0_d50 <=  exnR0_d49;
            exnR0_d51 <=  exnR0_d50;
            exnR0_d52 <=  exnR0_d51;
            exnR0_d53 <=  exnR0_d52;
            exnR0_d54 <=  exnR0_d53;
            exnR0_d55 <=  exnR0_d54;
            exnR0_d56 <=  exnR0_d55;
            exnR0_d57 <=  exnR0_d56;
            exnR0_d58 <=  exnR0_d57;
            exnR0_d59 <=  exnR0_d58;
            exnR0_d60 <=  exnR0_d59;
            exnR0_d61 <=  exnR0_d60;
            exnR0_d62 <=  exnR0_d61;
            exnR0_d63 <=  exnR0_d62;
            exnR0_d64 <=  exnR0_d63;
            exnR0_d65 <=  exnR0_d64;
            exnR0_d66 <=  exnR0_d65;
            exnR0_d67 <=  exnR0_d66;
            exnR0_d68 <=  exnR0_d67;
            exnR0_d69 <=  exnR0_d68;
            exnR0_d70 <=  exnR0_d69;
            exnR0_d71 <=  exnR0_d70;
            exnR0_d72 <=  exnR0_d71;
            exnR0_d73 <=  exnR0_d72;
            exnR0_d74 <=  exnR0_d73;
            exnR0_d75 <=  exnR0_d74;
            exnR0_d76 <=  exnR0_d75;
            exnR0_d77 <=  exnR0_d76;
            exnR0_d78 <=  exnR0_d77;
            exnR0_d79 <=  exnR0_d78;
            exnR0_d80 <=  exnR0_d79;
            exnR0_d81 <=  exnR0_d80;
            exnR0_d82 <=  exnR0_d81;
            exnR0_d83 <=  exnR0_d82;
            exnR0_d84 <=  exnR0_d83;
            exnR0_d85 <=  exnR0_d84;
            exnR0_d86 <=  exnR0_d85;
            exnR0_d87 <=  exnR0_d86;
            exnR0_d88 <=  exnR0_d87;
            exnR0_d89 <=  exnR0_d88;
            exnR0_d90 <=  exnR0_d89;
            exnR0_d91 <=  exnR0_d90;
            exnR0_d92 <=  exnR0_d91;
            D_d1 <=  D;
            D_d2 <=  D_d1;
            D_d3 <=  D_d2;
            D_d4 <=  D_d3;
            D_d5 <=  D_d4;
            D_d6 <=  D_d5;
            D_d7 <=  D_d6;
            D_d8 <=  D_d7;
            D_d9 <=  D_d8;
            D_d10 <=  D_d9;
            D_d11 <=  D_d10;
            D_d12 <=  D_d11;
            D_d13 <=  D_d12;
            D_d14 <=  D_d13;
            D_d15 <=  D_d14;
            D_d16 <=  D_d15;
            D_d17 <=  D_d16;
            D_d18 <=  D_d17;
            D_d19 <=  D_d18;
            D_d20 <=  D_d19;
            D_d21 <=  D_d20;
            D_d22 <=  D_d21;
            D_d23 <=  D_d22;
            D_d24 <=  D_d23;
            D_d25 <=  D_d24;
            D_d26 <=  D_d25;
            D_d27 <=  D_d26;
            D_d28 <=  D_d27;
            D_d29 <=  D_d28;
            D_d30 <=  D_d29;
            D_d31 <=  D_d30;
            D_d32 <=  D_d31;
            D_d33 <=  D_d32;
            D_d34 <=  D_d33;
            D_d35 <=  D_d34;
            D_d36 <=  D_d35;
            D_d37 <=  D_d36;
            D_d38 <=  D_d37;
            D_d39 <=  D_d38;
            D_d40 <=  D_d39;
            D_d41 <=  D_d40;
            D_d42 <=  D_d41;
            D_d43 <=  D_d42;
            D_d44 <=  D_d43;
            D_d45 <=  D_d44;
            D_d46 <=  D_d45;
            D_d47 <=  D_d46;
            D_d48 <=  D_d47;
            D_d49 <=  D_d48;
            D_d50 <=  D_d49;
            D_d51 <=  D_d50;
            D_d52 <=  D_d51;
            D_d53 <=  D_d52;
            D_d54 <=  D_d53;
            D_d55 <=  D_d54;
            D_d56 <=  D_d55;
            D_d57 <=  D_d56;
            D_d58 <=  D_d57;
            D_d59 <=  D_d58;
            D_d60 <=  D_d59;
            D_d61 <=  D_d60;
            D_d62 <=  D_d61;
            D_d63 <=  D_d62;
            D_d64 <=  D_d63;
            D_d65 <=  D_d64;
            D_d66 <=  D_d65;
            D_d67 <=  D_d66;
            D_d68 <=  D_d67;
            D_d69 <=  D_d68;
            D_d70 <=  D_d69;
            D_d71 <=  D_d70;
            D_d72 <=  D_d71;
            D_d73 <=  D_d72;
            D_d74 <=  D_d73;
            D_d75 <=  D_d74;
            D_d76 <=  D_d75;
            D_d77 <=  D_d76;
            D_d78 <=  D_d77;
            D_d79 <=  D_d78;
            D_d80 <=  D_d79;
            betaw14_d1 <=  betaw14;
            betaw14_d2 <=  betaw14_d1;
            betaw14_d3 <=  betaw14_d2;
            betaw14_d4 <=  betaw14_d3;
            betaw14_d5 <=  betaw14_d4;
            betaw14_d6 <=  betaw14_d5;
            q14_d1 <=  q14;
            q14_d2 <=  q14_d1;
            q14_d3 <=  q14_d2;
            q14_d4 <=  q14_d3;
            q14_d5 <=  q14_d4;
            q14_copy5_d1 <=  q14_copy5;
            absq14D_d1 <=  absq14D;
            absq14D_d2 <=  absq14D_d1;
            absq14D_d3 <=  absq14D_d2;
            absq14D_d4 <=  absq14D_d3;
            absq14D_d5 <=  absq14D_d4;
            betaw13_d1 <=  betaw13;
            betaw13_d2 <=  betaw13_d1;
            betaw13_d3 <=  betaw13_d2;
            betaw13_d4 <=  betaw13_d3;
            betaw13_d5 <=  betaw13_d4;
            betaw13_d6 <=  betaw13_d5;
            q13_d1 <=  q13;
            q13_d2 <=  q13_d1;
            q13_d3 <=  q13_d2;
            q13_d4 <=  q13_d3;
            q13_d5 <=  q13_d4;
            q13_copy6_d1 <=  q13_copy6;
            absq13D_d1 <=  absq13D;
            absq13D_d2 <=  absq13D_d1;
            absq13D_d3 <=  absq13D_d2;
            absq13D_d4 <=  absq13D_d3;
            absq13D_d5 <=  absq13D_d4;
            betaw12_d1 <=  betaw12;
            betaw12_d2 <=  betaw12_d1;
            betaw12_d3 <=  betaw12_d2;
            betaw12_d4 <=  betaw12_d3;
            betaw12_d5 <=  betaw12_d4;
            betaw12_d6 <=  betaw12_d5;
            q12_d1 <=  q12;
            q12_d2 <=  q12_d1;
            q12_d3 <=  q12_d2;
            q12_d4 <=  q12_d3;
            q12_d5 <=  q12_d4;
            q12_copy7_d1 <=  q12_copy7;
            absq12D_d1 <=  absq12D;
            absq12D_d2 <=  absq12D_d1;
            absq12D_d3 <=  absq12D_d2;
            absq12D_d4 <=  absq12D_d3;
            absq12D_d5 <=  absq12D_d4;
            betaw11_d1 <=  betaw11;
            betaw11_d2 <=  betaw11_d1;
            betaw11_d3 <=  betaw11_d2;
            betaw11_d4 <=  betaw11_d3;
            betaw11_d5 <=  betaw11_d4;
            betaw11_d6 <=  betaw11_d5;
            q11_d1 <=  q11;
            q11_d2 <=  q11_d1;
            q11_d3 <=  q11_d2;
            q11_d4 <=  q11_d3;
            q11_d5 <=  q11_d4;
            q11_copy8_d1 <=  q11_copy8;
            absq11D_d1 <=  absq11D;
            absq11D_d2 <=  absq11D_d1;
            absq11D_d3 <=  absq11D_d2;
            absq11D_d4 <=  absq11D_d3;
            absq11D_d5 <=  absq11D_d4;
            betaw10_d1 <=  betaw10;
            betaw10_d2 <=  betaw10_d1;
            betaw10_d3 <=  betaw10_d2;
            betaw10_d4 <=  betaw10_d3;
            betaw10_d5 <=  betaw10_d4;
            betaw10_d6 <=  betaw10_d5;
            q10_d1 <=  q10;
            q10_d2 <=  q10_d1;
            q10_d3 <=  q10_d2;
            q10_d4 <=  q10_d3;
            q10_d5 <=  q10_d4;
            q10_copy9_d1 <=  q10_copy9;
            absq10D_d1 <=  absq10D;
            absq10D_d2 <=  absq10D_d1;
            absq10D_d3 <=  absq10D_d2;
            absq10D_d4 <=  absq10D_d3;
            absq10D_d5 <=  absq10D_d4;
            betaw9_d1 <=  betaw9;
            betaw9_d2 <=  betaw9_d1;
            betaw9_d3 <=  betaw9_d2;
            betaw9_d4 <=  betaw9_d3;
            betaw9_d5 <=  betaw9_d4;
            betaw9_d6 <=  betaw9_d5;
            q9_d1 <=  q9;
            q9_d2 <=  q9_d1;
            q9_d3 <=  q9_d2;
            q9_d4 <=  q9_d3;
            q9_copy10_d1 <=  q9_copy10;
            q9_copy10_d2 <=  q9_copy10_d1;
            absq9D_d1 <=  absq9D;
            absq9D_d2 <=  absq9D_d1;
            absq9D_d3 <=  absq9D_d2;
            absq9D_d4 <=  absq9D_d3;
            betaw8_d1 <=  betaw8;
            betaw8_d2 <=  betaw8_d1;
            betaw8_d3 <=  betaw8_d2;
            betaw8_d4 <=  betaw8_d3;
            betaw8_d5 <=  betaw8_d4;
            betaw8_d6 <=  betaw8_d5;
            q8_d1 <=  q8;
            q8_d2 <=  q8_d1;
            q8_d3 <=  q8_d2;
            q8_d4 <=  q8_d3;
            q8_copy11_d1 <=  q8_copy11;
            q8_copy11_d2 <=  q8_copy11_d1;
            absq8D_d1 <=  absq8D;
            absq8D_d2 <=  absq8D_d1;
            absq8D_d3 <=  absq8D_d2;
            absq8D_d4 <=  absq8D_d3;
            betaw7_d1 <=  betaw7;
            betaw7_d2 <=  betaw7_d1;
            betaw7_d3 <=  betaw7_d2;
            betaw7_d4 <=  betaw7_d3;
            betaw7_d5 <=  betaw7_d4;
            betaw7_d6 <=  betaw7_d5;
            q7_d1 <=  q7;
            q7_d2 <=  q7_d1;
            q7_d3 <=  q7_d2;
            q7_d4 <=  q7_d3;
            q7_copy12_d1 <=  q7_copy12;
            q7_copy12_d2 <=  q7_copy12_d1;
            absq7D_d1 <=  absq7D;
            absq7D_d2 <=  absq7D_d1;
            absq7D_d3 <=  absq7D_d2;
            absq7D_d4 <=  absq7D_d3;
            betaw6_d1 <=  betaw6;
            betaw6_d2 <=  betaw6_d1;
            betaw6_d3 <=  betaw6_d2;
            betaw6_d4 <=  betaw6_d3;
            betaw6_d5 <=  betaw6_d4;
            betaw6_d6 <=  betaw6_d5;
            q6_d1 <=  q6;
            q6_d2 <=  q6_d1;
            q6_d3 <=  q6_d2;
            q6_d4 <=  q6_d3;
            q6_copy13_d1 <=  q6_copy13;
            q6_copy13_d2 <=  q6_copy13_d1;
            absq6D_d1 <=  absq6D;
            absq6D_d2 <=  absq6D_d1;
            absq6D_d3 <=  absq6D_d2;
            absq6D_d4 <=  absq6D_d3;
            betaw5_d1 <=  betaw5;
            betaw5_d2 <=  betaw5_d1;
            betaw5_d3 <=  betaw5_d2;
            betaw5_d4 <=  betaw5_d3;
            betaw5_d5 <=  betaw5_d4;
            betaw5_d6 <=  betaw5_d5;
            q5_d1 <=  q5;
            q5_d2 <=  q5_d1;
            q5_d3 <=  q5_d2;
            q5_d4 <=  q5_d3;
            q5_copy14_d1 <=  q5_copy14;
            q5_copy14_d2 <=  q5_copy14_d1;
            absq5D_d1 <=  absq5D;
            absq5D_d2 <=  absq5D_d1;
            absq5D_d3 <=  absq5D_d2;
            absq5D_d4 <=  absq5D_d3;
            betaw4_d1 <=  betaw4;
            betaw4_d2 <=  betaw4_d1;
            betaw4_d3 <=  betaw4_d2;
            betaw4_d4 <=  betaw4_d3;
            betaw4_d5 <=  betaw4_d4;
            betaw4_d6 <=  betaw4_d5;
            q4_d1 <=  q4;
            q4_d2 <=  q4_d1;
            q4_d3 <=  q4_d2;
            q4_d4 <=  q4_d3;
            q4_copy15_d1 <=  q4_copy15;
            q4_copy15_d2 <=  q4_copy15_d1;
            absq4D_d1 <=  absq4D;
            absq4D_d2 <=  absq4D_d1;
            absq4D_d3 <=  absq4D_d2;
            absq4D_d4 <=  absq4D_d3;
            betaw3_d1 <=  betaw3;
            betaw3_d2 <=  betaw3_d1;
            betaw3_d3 <=  betaw3_d2;
            betaw3_d4 <=  betaw3_d3;
            betaw3_d5 <=  betaw3_d4;
            betaw3_d6 <=  betaw3_d5;
            q3_d1 <=  q3;
            q3_d2 <=  q3_d1;
            q3_d3 <=  q3_d2;
            q3_d4 <=  q3_d3;
            q3_copy16_d1 <=  q3_copy16;
            q3_copy16_d2 <=  q3_copy16_d1;
            absq3D_d1 <=  absq3D;
            absq3D_d2 <=  absq3D_d1;
            absq3D_d3 <=  absq3D_d2;
            absq3D_d4 <=  absq3D_d3;
            betaw2_d1 <=  betaw2;
            betaw2_d2 <=  betaw2_d1;
            betaw2_d3 <=  betaw2_d2;
            betaw2_d4 <=  betaw2_d3;
            betaw2_d5 <=  betaw2_d4;
            betaw2_d6 <=  betaw2_d5;
            q2_d1 <=  q2;
            q2_d2 <=  q2_d1;
            q2_d3 <=  q2_d2;
            q2_d4 <=  q2_d3;
            q2_copy17_d1 <=  q2_copy17;
            q2_copy17_d2 <=  q2_copy17_d1;
            absq2D_d1 <=  absq2D;
            absq2D_d2 <=  absq2D_d1;
            absq2D_d3 <=  absq2D_d2;
            absq2D_d4 <=  absq2D_d3;
            betaw1_d1 <=  betaw1;
            betaw1_d2 <=  betaw1_d1;
            betaw1_d3 <=  betaw1_d2;
            betaw1_d4 <=  betaw1_d3;
            betaw1_d5 <=  betaw1_d4;
            betaw1_d6 <=  betaw1_d5;
            q1_d1 <=  q1;
            q1_d2 <=  q1_d1;
            q1_d3 <=  q1_d2;
            q1_d4 <=  q1_d3;
            q1_copy18_d1 <=  q1_copy18;
            q1_copy18_d2 <=  q1_copy18_d1;
            absq1D_d1 <=  absq1D;
            absq1D_d2 <=  absq1D_d1;
            absq1D_d3 <=  absq1D_d2;
            absq1D_d4 <=  absq1D_d3;
            qP14_d1 <=  qP14;
            qP14_d2 <=  qP14_d1;
            qP14_d3 <=  qP14_d2;
            qP14_d4 <=  qP14_d3;
            qP14_d5 <=  qP14_d4;
            qP14_d6 <=  qP14_d5;
            qP14_d7 <=  qP14_d6;
            qP14_d8 <=  qP14_d7;
            qP14_d9 <=  qP14_d8;
            qP14_d10 <=  qP14_d9;
            qP14_d11 <=  qP14_d10;
            qP14_d12 <=  qP14_d11;
            qP14_d13 <=  qP14_d12;
            qP14_d14 <=  qP14_d13;
            qP14_d15 <=  qP14_d14;
            qP14_d16 <=  qP14_d15;
            qP14_d17 <=  qP14_d16;
            qP14_d18 <=  qP14_d17;
            qP14_d19 <=  qP14_d18;
            qP14_d20 <=  qP14_d19;
            qP14_d21 <=  qP14_d20;
            qP14_d22 <=  qP14_d21;
            qP14_d23 <=  qP14_d22;
            qP14_d24 <=  qP14_d23;
            qP14_d25 <=  qP14_d24;
            qP14_d26 <=  qP14_d25;
            qP14_d27 <=  qP14_d26;
            qP14_d28 <=  qP14_d27;
            qP14_d29 <=  qP14_d28;
            qP14_d30 <=  qP14_d29;
            qP14_d31 <=  qP14_d30;
            qP14_d32 <=  qP14_d31;
            qP14_d33 <=  qP14_d32;
            qP14_d34 <=  qP14_d33;
            qP14_d35 <=  qP14_d34;
            qP14_d36 <=  qP14_d35;
            qP14_d37 <=  qP14_d36;
            qP14_d38 <=  qP14_d37;
            qP14_d39 <=  qP14_d38;
            qP14_d40 <=  qP14_d39;
            qP14_d41 <=  qP14_d40;
            qP14_d42 <=  qP14_d41;
            qP14_d43 <=  qP14_d42;
            qP14_d44 <=  qP14_d43;
            qP14_d45 <=  qP14_d44;
            qP14_d46 <=  qP14_d45;
            qP14_d47 <=  qP14_d46;
            qP14_d48 <=  qP14_d47;
            qP14_d49 <=  qP14_d48;
            qP14_d50 <=  qP14_d49;
            qP14_d51 <=  qP14_d50;
            qP14_d52 <=  qP14_d51;
            qP14_d53 <=  qP14_d52;
            qP14_d54 <=  qP14_d53;
            qP14_d55 <=  qP14_d54;
            qP14_d56 <=  qP14_d55;
            qP14_d57 <=  qP14_d56;
            qP14_d58 <=  qP14_d57;
            qP14_d59 <=  qP14_d58;
            qP14_d60 <=  qP14_d59;
            qP14_d61 <=  qP14_d60;
            qP14_d62 <=  qP14_d61;
            qP14_d63 <=  qP14_d62;
            qP14_d64 <=  qP14_d63;
            qP14_d65 <=  qP14_d64;
            qP14_d66 <=  qP14_d65;
            qP14_d67 <=  qP14_d66;
            qP14_d68 <=  qP14_d67;
            qP14_d69 <=  qP14_d68;
            qP14_d70 <=  qP14_d69;
            qP14_d71 <=  qP14_d70;
            qP14_d72 <=  qP14_d71;
            qP14_d73 <=  qP14_d72;
            qP14_d74 <=  qP14_d73;
            qP14_d75 <=  qP14_d74;
            qP14_d76 <=  qP14_d75;
            qP14_d77 <=  qP14_d76;
            qP14_d78 <=  qP14_d77;
            qP14_d79 <=  qP14_d78;
            qM14_d1 <=  qM14;
            qM14_d2 <=  qM14_d1;
            qM14_d3 <=  qM14_d2;
            qM14_d4 <=  qM14_d3;
            qM14_d5 <=  qM14_d4;
            qM14_d6 <=  qM14_d5;
            qM14_d7 <=  qM14_d6;
            qM14_d8 <=  qM14_d7;
            qM14_d9 <=  qM14_d8;
            qM14_d10 <=  qM14_d9;
            qM14_d11 <=  qM14_d10;
            qM14_d12 <=  qM14_d11;
            qM14_d13 <=  qM14_d12;
            qM14_d14 <=  qM14_d13;
            qM14_d15 <=  qM14_d14;
            qM14_d16 <=  qM14_d15;
            qM14_d17 <=  qM14_d16;
            qM14_d18 <=  qM14_d17;
            qM14_d19 <=  qM14_d18;
            qM14_d20 <=  qM14_d19;
            qM14_d21 <=  qM14_d20;
            qM14_d22 <=  qM14_d21;
            qM14_d23 <=  qM14_d22;
            qM14_d24 <=  qM14_d23;
            qM14_d25 <=  qM14_d24;
            qM14_d26 <=  qM14_d25;
            qM14_d27 <=  qM14_d26;
            qM14_d28 <=  qM14_d27;
            qM14_d29 <=  qM14_d28;
            qM14_d30 <=  qM14_d29;
            qM14_d31 <=  qM14_d30;
            qM14_d32 <=  qM14_d31;
            qM14_d33 <=  qM14_d32;
            qM14_d34 <=  qM14_d33;
            qM14_d35 <=  qM14_d34;
            qM14_d36 <=  qM14_d35;
            qM14_d37 <=  qM14_d36;
            qM14_d38 <=  qM14_d37;
            qM14_d39 <=  qM14_d38;
            qM14_d40 <=  qM14_d39;
            qM14_d41 <=  qM14_d40;
            qM14_d42 <=  qM14_d41;
            qM14_d43 <=  qM14_d42;
            qM14_d44 <=  qM14_d43;
            qM14_d45 <=  qM14_d44;
            qM14_d46 <=  qM14_d45;
            qM14_d47 <=  qM14_d46;
            qM14_d48 <=  qM14_d47;
            qM14_d49 <=  qM14_d48;
            qM14_d50 <=  qM14_d49;
            qM14_d51 <=  qM14_d50;
            qM14_d52 <=  qM14_d51;
            qM14_d53 <=  qM14_d52;
            qM14_d54 <=  qM14_d53;
            qM14_d55 <=  qM14_d54;
            qM14_d56 <=  qM14_d55;
            qM14_d57 <=  qM14_d56;
            qM14_d58 <=  qM14_d57;
            qM14_d59 <=  qM14_d58;
            qM14_d60 <=  qM14_d59;
            qM14_d61 <=  qM14_d60;
            qM14_d62 <=  qM14_d61;
            qM14_d63 <=  qM14_d62;
            qM14_d64 <=  qM14_d63;
            qM14_d65 <=  qM14_d64;
            qM14_d66 <=  qM14_d65;
            qM14_d67 <=  qM14_d66;
            qM14_d68 <=  qM14_d67;
            qM14_d69 <=  qM14_d68;
            qM14_d70 <=  qM14_d69;
            qM14_d71 <=  qM14_d70;
            qM14_d72 <=  qM14_d71;
            qM14_d73 <=  qM14_d72;
            qM14_d74 <=  qM14_d73;
            qM14_d75 <=  qM14_d74;
            qM14_d76 <=  qM14_d75;
            qM14_d77 <=  qM14_d76;
            qM14_d78 <=  qM14_d77;
            qM14_d79 <=  qM14_d78;
            qM14_d80 <=  qM14_d79;
            qM14_d81 <=  qM14_d80;
            qM14_d82 <=  qM14_d81;
            qM14_d83 <=  qM14_d82;
            qP13_d1 <=  qP13;
            qP13_d2 <=  qP13_d1;
            qP13_d3 <=  qP13_d2;
            qP13_d4 <=  qP13_d3;
            qP13_d5 <=  qP13_d4;
            qP13_d6 <=  qP13_d5;
            qP13_d7 <=  qP13_d6;
            qP13_d8 <=  qP13_d7;
            qP13_d9 <=  qP13_d8;
            qP13_d10 <=  qP13_d9;
            qP13_d11 <=  qP13_d10;
            qP13_d12 <=  qP13_d11;
            qP13_d13 <=  qP13_d12;
            qP13_d14 <=  qP13_d13;
            qP13_d15 <=  qP13_d14;
            qP13_d16 <=  qP13_d15;
            qP13_d17 <=  qP13_d16;
            qP13_d18 <=  qP13_d17;
            qP13_d19 <=  qP13_d18;
            qP13_d20 <=  qP13_d19;
            qP13_d21 <=  qP13_d20;
            qP13_d22 <=  qP13_d21;
            qP13_d23 <=  qP13_d22;
            qP13_d24 <=  qP13_d23;
            qP13_d25 <=  qP13_d24;
            qP13_d26 <=  qP13_d25;
            qP13_d27 <=  qP13_d26;
            qP13_d28 <=  qP13_d27;
            qP13_d29 <=  qP13_d28;
            qP13_d30 <=  qP13_d29;
            qP13_d31 <=  qP13_d30;
            qP13_d32 <=  qP13_d31;
            qP13_d33 <=  qP13_d32;
            qP13_d34 <=  qP13_d33;
            qP13_d35 <=  qP13_d34;
            qP13_d36 <=  qP13_d35;
            qP13_d37 <=  qP13_d36;
            qP13_d38 <=  qP13_d37;
            qP13_d39 <=  qP13_d38;
            qP13_d40 <=  qP13_d39;
            qP13_d41 <=  qP13_d40;
            qP13_d42 <=  qP13_d41;
            qP13_d43 <=  qP13_d42;
            qP13_d44 <=  qP13_d43;
            qP13_d45 <=  qP13_d44;
            qP13_d46 <=  qP13_d45;
            qP13_d47 <=  qP13_d46;
            qP13_d48 <=  qP13_d47;
            qP13_d49 <=  qP13_d48;
            qP13_d50 <=  qP13_d49;
            qP13_d51 <=  qP13_d50;
            qP13_d52 <=  qP13_d51;
            qP13_d53 <=  qP13_d52;
            qP13_d54 <=  qP13_d53;
            qP13_d55 <=  qP13_d54;
            qP13_d56 <=  qP13_d55;
            qP13_d57 <=  qP13_d56;
            qP13_d58 <=  qP13_d57;
            qP13_d59 <=  qP13_d58;
            qP13_d60 <=  qP13_d59;
            qP13_d61 <=  qP13_d60;
            qP13_d62 <=  qP13_d61;
            qP13_d63 <=  qP13_d62;
            qP13_d64 <=  qP13_d63;
            qP13_d65 <=  qP13_d64;
            qP13_d66 <=  qP13_d65;
            qP13_d67 <=  qP13_d66;
            qP13_d68 <=  qP13_d67;
            qP13_d69 <=  qP13_d68;
            qP13_d70 <=  qP13_d69;
            qP13_d71 <=  qP13_d70;
            qP13_d72 <=  qP13_d71;
            qP13_d73 <=  qP13_d72;
            qM13_d1 <=  qM13;
            qM13_d2 <=  qM13_d1;
            qM13_d3 <=  qM13_d2;
            qM13_d4 <=  qM13_d3;
            qM13_d5 <=  qM13_d4;
            qM13_d6 <=  qM13_d5;
            qM13_d7 <=  qM13_d6;
            qM13_d8 <=  qM13_d7;
            qM13_d9 <=  qM13_d8;
            qM13_d10 <=  qM13_d9;
            qM13_d11 <=  qM13_d10;
            qM13_d12 <=  qM13_d11;
            qM13_d13 <=  qM13_d12;
            qM13_d14 <=  qM13_d13;
            qM13_d15 <=  qM13_d14;
            qM13_d16 <=  qM13_d15;
            qM13_d17 <=  qM13_d16;
            qM13_d18 <=  qM13_d17;
            qM13_d19 <=  qM13_d18;
            qM13_d20 <=  qM13_d19;
            qM13_d21 <=  qM13_d20;
            qM13_d22 <=  qM13_d21;
            qM13_d23 <=  qM13_d22;
            qM13_d24 <=  qM13_d23;
            qM13_d25 <=  qM13_d24;
            qM13_d26 <=  qM13_d25;
            qM13_d27 <=  qM13_d26;
            qM13_d28 <=  qM13_d27;
            qM13_d29 <=  qM13_d28;
            qM13_d30 <=  qM13_d29;
            qM13_d31 <=  qM13_d30;
            qM13_d32 <=  qM13_d31;
            qM13_d33 <=  qM13_d32;
            qM13_d34 <=  qM13_d33;
            qM13_d35 <=  qM13_d34;
            qM13_d36 <=  qM13_d35;
            qM13_d37 <=  qM13_d36;
            qM13_d38 <=  qM13_d37;
            qM13_d39 <=  qM13_d38;
            qM13_d40 <=  qM13_d39;
            qM13_d41 <=  qM13_d40;
            qM13_d42 <=  qM13_d41;
            qM13_d43 <=  qM13_d42;
            qM13_d44 <=  qM13_d43;
            qM13_d45 <=  qM13_d44;
            qM13_d46 <=  qM13_d45;
            qM13_d47 <=  qM13_d46;
            qM13_d48 <=  qM13_d47;
            qM13_d49 <=  qM13_d48;
            qM13_d50 <=  qM13_d49;
            qM13_d51 <=  qM13_d50;
            qM13_d52 <=  qM13_d51;
            qM13_d53 <=  qM13_d52;
            qM13_d54 <=  qM13_d53;
            qM13_d55 <=  qM13_d54;
            qM13_d56 <=  qM13_d55;
            qM13_d57 <=  qM13_d56;
            qM13_d58 <=  qM13_d57;
            qM13_d59 <=  qM13_d58;
            qM13_d60 <=  qM13_d59;
            qM13_d61 <=  qM13_d60;
            qM13_d62 <=  qM13_d61;
            qM13_d63 <=  qM13_d62;
            qM13_d64 <=  qM13_d63;
            qM13_d65 <=  qM13_d64;
            qM13_d66 <=  qM13_d65;
            qM13_d67 <=  qM13_d66;
            qM13_d68 <=  qM13_d67;
            qM13_d69 <=  qM13_d68;
            qM13_d70 <=  qM13_d69;
            qM13_d71 <=  qM13_d70;
            qM13_d72 <=  qM13_d71;
            qM13_d73 <=  qM13_d72;
            qM13_d74 <=  qM13_d73;
            qM13_d75 <=  qM13_d74;
            qM13_d76 <=  qM13_d75;
            qM13_d77 <=  qM13_d76;
            qP12_d1 <=  qP12;
            qP12_d2 <=  qP12_d1;
            qP12_d3 <=  qP12_d2;
            qP12_d4 <=  qP12_d3;
            qP12_d5 <=  qP12_d4;
            qP12_d6 <=  qP12_d5;
            qP12_d7 <=  qP12_d6;
            qP12_d8 <=  qP12_d7;
            qP12_d9 <=  qP12_d8;
            qP12_d10 <=  qP12_d9;
            qP12_d11 <=  qP12_d10;
            qP12_d12 <=  qP12_d11;
            qP12_d13 <=  qP12_d12;
            qP12_d14 <=  qP12_d13;
            qP12_d15 <=  qP12_d14;
            qP12_d16 <=  qP12_d15;
            qP12_d17 <=  qP12_d16;
            qP12_d18 <=  qP12_d17;
            qP12_d19 <=  qP12_d18;
            qP12_d20 <=  qP12_d19;
            qP12_d21 <=  qP12_d20;
            qP12_d22 <=  qP12_d21;
            qP12_d23 <=  qP12_d22;
            qP12_d24 <=  qP12_d23;
            qP12_d25 <=  qP12_d24;
            qP12_d26 <=  qP12_d25;
            qP12_d27 <=  qP12_d26;
            qP12_d28 <=  qP12_d27;
            qP12_d29 <=  qP12_d28;
            qP12_d30 <=  qP12_d29;
            qP12_d31 <=  qP12_d30;
            qP12_d32 <=  qP12_d31;
            qP12_d33 <=  qP12_d32;
            qP12_d34 <=  qP12_d33;
            qP12_d35 <=  qP12_d34;
            qP12_d36 <=  qP12_d35;
            qP12_d37 <=  qP12_d36;
            qP12_d38 <=  qP12_d37;
            qP12_d39 <=  qP12_d38;
            qP12_d40 <=  qP12_d39;
            qP12_d41 <=  qP12_d40;
            qP12_d42 <=  qP12_d41;
            qP12_d43 <=  qP12_d42;
            qP12_d44 <=  qP12_d43;
            qP12_d45 <=  qP12_d44;
            qP12_d46 <=  qP12_d45;
            qP12_d47 <=  qP12_d46;
            qP12_d48 <=  qP12_d47;
            qP12_d49 <=  qP12_d48;
            qP12_d50 <=  qP12_d49;
            qP12_d51 <=  qP12_d50;
            qP12_d52 <=  qP12_d51;
            qP12_d53 <=  qP12_d52;
            qP12_d54 <=  qP12_d53;
            qP12_d55 <=  qP12_d54;
            qP12_d56 <=  qP12_d55;
            qP12_d57 <=  qP12_d56;
            qP12_d58 <=  qP12_d57;
            qP12_d59 <=  qP12_d58;
            qP12_d60 <=  qP12_d59;
            qP12_d61 <=  qP12_d60;
            qP12_d62 <=  qP12_d61;
            qP12_d63 <=  qP12_d62;
            qP12_d64 <=  qP12_d63;
            qP12_d65 <=  qP12_d64;
            qP12_d66 <=  qP12_d65;
            qP12_d67 <=  qP12_d66;
            qM12_d1 <=  qM12;
            qM12_d2 <=  qM12_d1;
            qM12_d3 <=  qM12_d2;
            qM12_d4 <=  qM12_d3;
            qM12_d5 <=  qM12_d4;
            qM12_d6 <=  qM12_d5;
            qM12_d7 <=  qM12_d6;
            qM12_d8 <=  qM12_d7;
            qM12_d9 <=  qM12_d8;
            qM12_d10 <=  qM12_d9;
            qM12_d11 <=  qM12_d10;
            qM12_d12 <=  qM12_d11;
            qM12_d13 <=  qM12_d12;
            qM12_d14 <=  qM12_d13;
            qM12_d15 <=  qM12_d14;
            qM12_d16 <=  qM12_d15;
            qM12_d17 <=  qM12_d16;
            qM12_d18 <=  qM12_d17;
            qM12_d19 <=  qM12_d18;
            qM12_d20 <=  qM12_d19;
            qM12_d21 <=  qM12_d20;
            qM12_d22 <=  qM12_d21;
            qM12_d23 <=  qM12_d22;
            qM12_d24 <=  qM12_d23;
            qM12_d25 <=  qM12_d24;
            qM12_d26 <=  qM12_d25;
            qM12_d27 <=  qM12_d26;
            qM12_d28 <=  qM12_d27;
            qM12_d29 <=  qM12_d28;
            qM12_d30 <=  qM12_d29;
            qM12_d31 <=  qM12_d30;
            qM12_d32 <=  qM12_d31;
            qM12_d33 <=  qM12_d32;
            qM12_d34 <=  qM12_d33;
            qM12_d35 <=  qM12_d34;
            qM12_d36 <=  qM12_d35;
            qM12_d37 <=  qM12_d36;
            qM12_d38 <=  qM12_d37;
            qM12_d39 <=  qM12_d38;
            qM12_d40 <=  qM12_d39;
            qM12_d41 <=  qM12_d40;
            qM12_d42 <=  qM12_d41;
            qM12_d43 <=  qM12_d42;
            qM12_d44 <=  qM12_d43;
            qM12_d45 <=  qM12_d44;
            qM12_d46 <=  qM12_d45;
            qM12_d47 <=  qM12_d46;
            qM12_d48 <=  qM12_d47;
            qM12_d49 <=  qM12_d48;
            qM12_d50 <=  qM12_d49;
            qM12_d51 <=  qM12_d50;
            qM12_d52 <=  qM12_d51;
            qM12_d53 <=  qM12_d52;
            qM12_d54 <=  qM12_d53;
            qM12_d55 <=  qM12_d54;
            qM12_d56 <=  qM12_d55;
            qM12_d57 <=  qM12_d56;
            qM12_d58 <=  qM12_d57;
            qM12_d59 <=  qM12_d58;
            qM12_d60 <=  qM12_d59;
            qM12_d61 <=  qM12_d60;
            qM12_d62 <=  qM12_d61;
            qM12_d63 <=  qM12_d62;
            qM12_d64 <=  qM12_d63;
            qM12_d65 <=  qM12_d64;
            qM12_d66 <=  qM12_d65;
            qM12_d67 <=  qM12_d66;
            qM12_d68 <=  qM12_d67;
            qM12_d69 <=  qM12_d68;
            qM12_d70 <=  qM12_d69;
            qM12_d71 <=  qM12_d70;
            qP11_d1 <=  qP11;
            qP11_d2 <=  qP11_d1;
            qP11_d3 <=  qP11_d2;
            qP11_d4 <=  qP11_d3;
            qP11_d5 <=  qP11_d4;
            qP11_d6 <=  qP11_d5;
            qP11_d7 <=  qP11_d6;
            qP11_d8 <=  qP11_d7;
            qP11_d9 <=  qP11_d8;
            qP11_d10 <=  qP11_d9;
            qP11_d11 <=  qP11_d10;
            qP11_d12 <=  qP11_d11;
            qP11_d13 <=  qP11_d12;
            qP11_d14 <=  qP11_d13;
            qP11_d15 <=  qP11_d14;
            qP11_d16 <=  qP11_d15;
            qP11_d17 <=  qP11_d16;
            qP11_d18 <=  qP11_d17;
            qP11_d19 <=  qP11_d18;
            qP11_d20 <=  qP11_d19;
            qP11_d21 <=  qP11_d20;
            qP11_d22 <=  qP11_d21;
            qP11_d23 <=  qP11_d22;
            qP11_d24 <=  qP11_d23;
            qP11_d25 <=  qP11_d24;
            qP11_d26 <=  qP11_d25;
            qP11_d27 <=  qP11_d26;
            qP11_d28 <=  qP11_d27;
            qP11_d29 <=  qP11_d28;
            qP11_d30 <=  qP11_d29;
            qP11_d31 <=  qP11_d30;
            qP11_d32 <=  qP11_d31;
            qP11_d33 <=  qP11_d32;
            qP11_d34 <=  qP11_d33;
            qP11_d35 <=  qP11_d34;
            qP11_d36 <=  qP11_d35;
            qP11_d37 <=  qP11_d36;
            qP11_d38 <=  qP11_d37;
            qP11_d39 <=  qP11_d38;
            qP11_d40 <=  qP11_d39;
            qP11_d41 <=  qP11_d40;
            qP11_d42 <=  qP11_d41;
            qP11_d43 <=  qP11_d42;
            qP11_d44 <=  qP11_d43;
            qP11_d45 <=  qP11_d44;
            qP11_d46 <=  qP11_d45;
            qP11_d47 <=  qP11_d46;
            qP11_d48 <=  qP11_d47;
            qP11_d49 <=  qP11_d48;
            qP11_d50 <=  qP11_d49;
            qP11_d51 <=  qP11_d50;
            qP11_d52 <=  qP11_d51;
            qP11_d53 <=  qP11_d52;
            qP11_d54 <=  qP11_d53;
            qP11_d55 <=  qP11_d54;
            qP11_d56 <=  qP11_d55;
            qP11_d57 <=  qP11_d56;
            qP11_d58 <=  qP11_d57;
            qP11_d59 <=  qP11_d58;
            qP11_d60 <=  qP11_d59;
            qP11_d61 <=  qP11_d60;
            qM11_d1 <=  qM11;
            qM11_d2 <=  qM11_d1;
            qM11_d3 <=  qM11_d2;
            qM11_d4 <=  qM11_d3;
            qM11_d5 <=  qM11_d4;
            qM11_d6 <=  qM11_d5;
            qM11_d7 <=  qM11_d6;
            qM11_d8 <=  qM11_d7;
            qM11_d9 <=  qM11_d8;
            qM11_d10 <=  qM11_d9;
            qM11_d11 <=  qM11_d10;
            qM11_d12 <=  qM11_d11;
            qM11_d13 <=  qM11_d12;
            qM11_d14 <=  qM11_d13;
            qM11_d15 <=  qM11_d14;
            qM11_d16 <=  qM11_d15;
            qM11_d17 <=  qM11_d16;
            qM11_d18 <=  qM11_d17;
            qM11_d19 <=  qM11_d18;
            qM11_d20 <=  qM11_d19;
            qM11_d21 <=  qM11_d20;
            qM11_d22 <=  qM11_d21;
            qM11_d23 <=  qM11_d22;
            qM11_d24 <=  qM11_d23;
            qM11_d25 <=  qM11_d24;
            qM11_d26 <=  qM11_d25;
            qM11_d27 <=  qM11_d26;
            qM11_d28 <=  qM11_d27;
            qM11_d29 <=  qM11_d28;
            qM11_d30 <=  qM11_d29;
            qM11_d31 <=  qM11_d30;
            qM11_d32 <=  qM11_d31;
            qM11_d33 <=  qM11_d32;
            qM11_d34 <=  qM11_d33;
            qM11_d35 <=  qM11_d34;
            qM11_d36 <=  qM11_d35;
            qM11_d37 <=  qM11_d36;
            qM11_d38 <=  qM11_d37;
            qM11_d39 <=  qM11_d38;
            qM11_d40 <=  qM11_d39;
            qM11_d41 <=  qM11_d40;
            qM11_d42 <=  qM11_d41;
            qM11_d43 <=  qM11_d42;
            qM11_d44 <=  qM11_d43;
            qM11_d45 <=  qM11_d44;
            qM11_d46 <=  qM11_d45;
            qM11_d47 <=  qM11_d46;
            qM11_d48 <=  qM11_d47;
            qM11_d49 <=  qM11_d48;
            qM11_d50 <=  qM11_d49;
            qM11_d51 <=  qM11_d50;
            qM11_d52 <=  qM11_d51;
            qM11_d53 <=  qM11_d52;
            qM11_d54 <=  qM11_d53;
            qM11_d55 <=  qM11_d54;
            qM11_d56 <=  qM11_d55;
            qM11_d57 <=  qM11_d56;
            qM11_d58 <=  qM11_d57;
            qM11_d59 <=  qM11_d58;
            qM11_d60 <=  qM11_d59;
            qM11_d61 <=  qM11_d60;
            qM11_d62 <=  qM11_d61;
            qM11_d63 <=  qM11_d62;
            qM11_d64 <=  qM11_d63;
            qM11_d65 <=  qM11_d64;
            qP10_d1 <=  qP10;
            qP10_d2 <=  qP10_d1;
            qP10_d3 <=  qP10_d2;
            qP10_d4 <=  qP10_d3;
            qP10_d5 <=  qP10_d4;
            qP10_d6 <=  qP10_d5;
            qP10_d7 <=  qP10_d6;
            qP10_d8 <=  qP10_d7;
            qP10_d9 <=  qP10_d8;
            qP10_d10 <=  qP10_d9;
            qP10_d11 <=  qP10_d10;
            qP10_d12 <=  qP10_d11;
            qP10_d13 <=  qP10_d12;
            qP10_d14 <=  qP10_d13;
            qP10_d15 <=  qP10_d14;
            qP10_d16 <=  qP10_d15;
            qP10_d17 <=  qP10_d16;
            qP10_d18 <=  qP10_d17;
            qP10_d19 <=  qP10_d18;
            qP10_d20 <=  qP10_d19;
            qP10_d21 <=  qP10_d20;
            qP10_d22 <=  qP10_d21;
            qP10_d23 <=  qP10_d22;
            qP10_d24 <=  qP10_d23;
            qP10_d25 <=  qP10_d24;
            qP10_d26 <=  qP10_d25;
            qP10_d27 <=  qP10_d26;
            qP10_d28 <=  qP10_d27;
            qP10_d29 <=  qP10_d28;
            qP10_d30 <=  qP10_d29;
            qP10_d31 <=  qP10_d30;
            qP10_d32 <=  qP10_d31;
            qP10_d33 <=  qP10_d32;
            qP10_d34 <=  qP10_d33;
            qP10_d35 <=  qP10_d34;
            qP10_d36 <=  qP10_d35;
            qP10_d37 <=  qP10_d36;
            qP10_d38 <=  qP10_d37;
            qP10_d39 <=  qP10_d38;
            qP10_d40 <=  qP10_d39;
            qP10_d41 <=  qP10_d40;
            qP10_d42 <=  qP10_d41;
            qP10_d43 <=  qP10_d42;
            qP10_d44 <=  qP10_d43;
            qP10_d45 <=  qP10_d44;
            qP10_d46 <=  qP10_d45;
            qP10_d47 <=  qP10_d46;
            qP10_d48 <=  qP10_d47;
            qP10_d49 <=  qP10_d48;
            qP10_d50 <=  qP10_d49;
            qP10_d51 <=  qP10_d50;
            qP10_d52 <=  qP10_d51;
            qP10_d53 <=  qP10_d52;
            qP10_d54 <=  qP10_d53;
            qP10_d55 <=  qP10_d54;
            qM10_d1 <=  qM10;
            qM10_d2 <=  qM10_d1;
            qM10_d3 <=  qM10_d2;
            qM10_d4 <=  qM10_d3;
            qM10_d5 <=  qM10_d4;
            qM10_d6 <=  qM10_d5;
            qM10_d7 <=  qM10_d6;
            qM10_d8 <=  qM10_d7;
            qM10_d9 <=  qM10_d8;
            qM10_d10 <=  qM10_d9;
            qM10_d11 <=  qM10_d10;
            qM10_d12 <=  qM10_d11;
            qM10_d13 <=  qM10_d12;
            qM10_d14 <=  qM10_d13;
            qM10_d15 <=  qM10_d14;
            qM10_d16 <=  qM10_d15;
            qM10_d17 <=  qM10_d16;
            qM10_d18 <=  qM10_d17;
            qM10_d19 <=  qM10_d18;
            qM10_d20 <=  qM10_d19;
            qM10_d21 <=  qM10_d20;
            qM10_d22 <=  qM10_d21;
            qM10_d23 <=  qM10_d22;
            qM10_d24 <=  qM10_d23;
            qM10_d25 <=  qM10_d24;
            qM10_d26 <=  qM10_d25;
            qM10_d27 <=  qM10_d26;
            qM10_d28 <=  qM10_d27;
            qM10_d29 <=  qM10_d28;
            qM10_d30 <=  qM10_d29;
            qM10_d31 <=  qM10_d30;
            qM10_d32 <=  qM10_d31;
            qM10_d33 <=  qM10_d32;
            qM10_d34 <=  qM10_d33;
            qM10_d35 <=  qM10_d34;
            qM10_d36 <=  qM10_d35;
            qM10_d37 <=  qM10_d36;
            qM10_d38 <=  qM10_d37;
            qM10_d39 <=  qM10_d38;
            qM10_d40 <=  qM10_d39;
            qM10_d41 <=  qM10_d40;
            qM10_d42 <=  qM10_d41;
            qM10_d43 <=  qM10_d42;
            qM10_d44 <=  qM10_d43;
            qM10_d45 <=  qM10_d44;
            qM10_d46 <=  qM10_d45;
            qM10_d47 <=  qM10_d46;
            qM10_d48 <=  qM10_d47;
            qM10_d49 <=  qM10_d48;
            qM10_d50 <=  qM10_d49;
            qM10_d51 <=  qM10_d50;
            qM10_d52 <=  qM10_d51;
            qM10_d53 <=  qM10_d52;
            qM10_d54 <=  qM10_d53;
            qM10_d55 <=  qM10_d54;
            qM10_d56 <=  qM10_d55;
            qM10_d57 <=  qM10_d56;
            qM10_d58 <=  qM10_d57;
            qM10_d59 <=  qM10_d58;
            qP9_d1 <=  qP9;
            qP9_d2 <=  qP9_d1;
            qP9_d3 <=  qP9_d2;
            qP9_d4 <=  qP9_d3;
            qP9_d5 <=  qP9_d4;
            qP9_d6 <=  qP9_d5;
            qP9_d7 <=  qP9_d6;
            qP9_d8 <=  qP9_d7;
            qP9_d9 <=  qP9_d8;
            qP9_d10 <=  qP9_d9;
            qP9_d11 <=  qP9_d10;
            qP9_d12 <=  qP9_d11;
            qP9_d13 <=  qP9_d12;
            qP9_d14 <=  qP9_d13;
            qP9_d15 <=  qP9_d14;
            qP9_d16 <=  qP9_d15;
            qP9_d17 <=  qP9_d16;
            qP9_d18 <=  qP9_d17;
            qP9_d19 <=  qP9_d18;
            qP9_d20 <=  qP9_d19;
            qP9_d21 <=  qP9_d20;
            qP9_d22 <=  qP9_d21;
            qP9_d23 <=  qP9_d22;
            qP9_d24 <=  qP9_d23;
            qP9_d25 <=  qP9_d24;
            qP9_d26 <=  qP9_d25;
            qP9_d27 <=  qP9_d26;
            qP9_d28 <=  qP9_d27;
            qP9_d29 <=  qP9_d28;
            qP9_d30 <=  qP9_d29;
            qP9_d31 <=  qP9_d30;
            qP9_d32 <=  qP9_d31;
            qP9_d33 <=  qP9_d32;
            qP9_d34 <=  qP9_d33;
            qP9_d35 <=  qP9_d34;
            qP9_d36 <=  qP9_d35;
            qP9_d37 <=  qP9_d36;
            qP9_d38 <=  qP9_d37;
            qP9_d39 <=  qP9_d38;
            qP9_d40 <=  qP9_d39;
            qP9_d41 <=  qP9_d40;
            qP9_d42 <=  qP9_d41;
            qP9_d43 <=  qP9_d42;
            qP9_d44 <=  qP9_d43;
            qP9_d45 <=  qP9_d44;
            qP9_d46 <=  qP9_d45;
            qP9_d47 <=  qP9_d46;
            qP9_d48 <=  qP9_d47;
            qM9_d1 <=  qM9;
            qM9_d2 <=  qM9_d1;
            qM9_d3 <=  qM9_d2;
            qM9_d4 <=  qM9_d3;
            qM9_d5 <=  qM9_d4;
            qM9_d6 <=  qM9_d5;
            qM9_d7 <=  qM9_d6;
            qM9_d8 <=  qM9_d7;
            qM9_d9 <=  qM9_d8;
            qM9_d10 <=  qM9_d9;
            qM9_d11 <=  qM9_d10;
            qM9_d12 <=  qM9_d11;
            qM9_d13 <=  qM9_d12;
            qM9_d14 <=  qM9_d13;
            qM9_d15 <=  qM9_d14;
            qM9_d16 <=  qM9_d15;
            qM9_d17 <=  qM9_d16;
            qM9_d18 <=  qM9_d17;
            qM9_d19 <=  qM9_d18;
            qM9_d20 <=  qM9_d19;
            qM9_d21 <=  qM9_d20;
            qM9_d22 <=  qM9_d21;
            qM9_d23 <=  qM9_d22;
            qM9_d24 <=  qM9_d23;
            qM9_d25 <=  qM9_d24;
            qM9_d26 <=  qM9_d25;
            qM9_d27 <=  qM9_d26;
            qM9_d28 <=  qM9_d27;
            qM9_d29 <=  qM9_d28;
            qM9_d30 <=  qM9_d29;
            qM9_d31 <=  qM9_d30;
            qM9_d32 <=  qM9_d31;
            qM9_d33 <=  qM9_d32;
            qM9_d34 <=  qM9_d33;
            qM9_d35 <=  qM9_d34;
            qM9_d36 <=  qM9_d35;
            qM9_d37 <=  qM9_d36;
            qM9_d38 <=  qM9_d37;
            qM9_d39 <=  qM9_d38;
            qM9_d40 <=  qM9_d39;
            qM9_d41 <=  qM9_d40;
            qM9_d42 <=  qM9_d41;
            qM9_d43 <=  qM9_d42;
            qM9_d44 <=  qM9_d43;
            qM9_d45 <=  qM9_d44;
            qM9_d46 <=  qM9_d45;
            qM9_d47 <=  qM9_d46;
            qM9_d48 <=  qM9_d47;
            qM9_d49 <=  qM9_d48;
            qM9_d50 <=  qM9_d49;
            qM9_d51 <=  qM9_d50;
            qM9_d52 <=  qM9_d51;
            qP8_d1 <=  qP8;
            qP8_d2 <=  qP8_d1;
            qP8_d3 <=  qP8_d2;
            qP8_d4 <=  qP8_d3;
            qP8_d5 <=  qP8_d4;
            qP8_d6 <=  qP8_d5;
            qP8_d7 <=  qP8_d6;
            qP8_d8 <=  qP8_d7;
            qP8_d9 <=  qP8_d8;
            qP8_d10 <=  qP8_d9;
            qP8_d11 <=  qP8_d10;
            qP8_d12 <=  qP8_d11;
            qP8_d13 <=  qP8_d12;
            qP8_d14 <=  qP8_d13;
            qP8_d15 <=  qP8_d14;
            qP8_d16 <=  qP8_d15;
            qP8_d17 <=  qP8_d16;
            qP8_d18 <=  qP8_d17;
            qP8_d19 <=  qP8_d18;
            qP8_d20 <=  qP8_d19;
            qP8_d21 <=  qP8_d20;
            qP8_d22 <=  qP8_d21;
            qP8_d23 <=  qP8_d22;
            qP8_d24 <=  qP8_d23;
            qP8_d25 <=  qP8_d24;
            qP8_d26 <=  qP8_d25;
            qP8_d27 <=  qP8_d26;
            qP8_d28 <=  qP8_d27;
            qP8_d29 <=  qP8_d28;
            qP8_d30 <=  qP8_d29;
            qP8_d31 <=  qP8_d30;
            qP8_d32 <=  qP8_d31;
            qP8_d33 <=  qP8_d32;
            qP8_d34 <=  qP8_d33;
            qP8_d35 <=  qP8_d34;
            qP8_d36 <=  qP8_d35;
            qP8_d37 <=  qP8_d36;
            qP8_d38 <=  qP8_d37;
            qP8_d39 <=  qP8_d38;
            qP8_d40 <=  qP8_d39;
            qP8_d41 <=  qP8_d40;
            qP8_d42 <=  qP8_d41;
            qM8_d1 <=  qM8;
            qM8_d2 <=  qM8_d1;
            qM8_d3 <=  qM8_d2;
            qM8_d4 <=  qM8_d3;
            qM8_d5 <=  qM8_d4;
            qM8_d6 <=  qM8_d5;
            qM8_d7 <=  qM8_d6;
            qM8_d8 <=  qM8_d7;
            qM8_d9 <=  qM8_d8;
            qM8_d10 <=  qM8_d9;
            qM8_d11 <=  qM8_d10;
            qM8_d12 <=  qM8_d11;
            qM8_d13 <=  qM8_d12;
            qM8_d14 <=  qM8_d13;
            qM8_d15 <=  qM8_d14;
            qM8_d16 <=  qM8_d15;
            qM8_d17 <=  qM8_d16;
            qM8_d18 <=  qM8_d17;
            qM8_d19 <=  qM8_d18;
            qM8_d20 <=  qM8_d19;
            qM8_d21 <=  qM8_d20;
            qM8_d22 <=  qM8_d21;
            qM8_d23 <=  qM8_d22;
            qM8_d24 <=  qM8_d23;
            qM8_d25 <=  qM8_d24;
            qM8_d26 <=  qM8_d25;
            qM8_d27 <=  qM8_d26;
            qM8_d28 <=  qM8_d27;
            qM8_d29 <=  qM8_d28;
            qM8_d30 <=  qM8_d29;
            qM8_d31 <=  qM8_d30;
            qM8_d32 <=  qM8_d31;
            qM8_d33 <=  qM8_d32;
            qM8_d34 <=  qM8_d33;
            qM8_d35 <=  qM8_d34;
            qM8_d36 <=  qM8_d35;
            qM8_d37 <=  qM8_d36;
            qM8_d38 <=  qM8_d37;
            qM8_d39 <=  qM8_d38;
            qM8_d40 <=  qM8_d39;
            qM8_d41 <=  qM8_d40;
            qM8_d42 <=  qM8_d41;
            qM8_d43 <=  qM8_d42;
            qM8_d44 <=  qM8_d43;
            qM8_d45 <=  qM8_d44;
            qM8_d46 <=  qM8_d45;
            qP7_d1 <=  qP7;
            qP7_d2 <=  qP7_d1;
            qP7_d3 <=  qP7_d2;
            qP7_d4 <=  qP7_d3;
            qP7_d5 <=  qP7_d4;
            qP7_d6 <=  qP7_d5;
            qP7_d7 <=  qP7_d6;
            qP7_d8 <=  qP7_d7;
            qP7_d9 <=  qP7_d8;
            qP7_d10 <=  qP7_d9;
            qP7_d11 <=  qP7_d10;
            qP7_d12 <=  qP7_d11;
            qP7_d13 <=  qP7_d12;
            qP7_d14 <=  qP7_d13;
            qP7_d15 <=  qP7_d14;
            qP7_d16 <=  qP7_d15;
            qP7_d17 <=  qP7_d16;
            qP7_d18 <=  qP7_d17;
            qP7_d19 <=  qP7_d18;
            qP7_d20 <=  qP7_d19;
            qP7_d21 <=  qP7_d20;
            qP7_d22 <=  qP7_d21;
            qP7_d23 <=  qP7_d22;
            qP7_d24 <=  qP7_d23;
            qP7_d25 <=  qP7_d24;
            qP7_d26 <=  qP7_d25;
            qP7_d27 <=  qP7_d26;
            qP7_d28 <=  qP7_d27;
            qP7_d29 <=  qP7_d28;
            qP7_d30 <=  qP7_d29;
            qP7_d31 <=  qP7_d30;
            qP7_d32 <=  qP7_d31;
            qP7_d33 <=  qP7_d32;
            qP7_d34 <=  qP7_d33;
            qP7_d35 <=  qP7_d34;
            qP7_d36 <=  qP7_d35;
            qM7_d1 <=  qM7;
            qM7_d2 <=  qM7_d1;
            qM7_d3 <=  qM7_d2;
            qM7_d4 <=  qM7_d3;
            qM7_d5 <=  qM7_d4;
            qM7_d6 <=  qM7_d5;
            qM7_d7 <=  qM7_d6;
            qM7_d8 <=  qM7_d7;
            qM7_d9 <=  qM7_d8;
            qM7_d10 <=  qM7_d9;
            qM7_d11 <=  qM7_d10;
            qM7_d12 <=  qM7_d11;
            qM7_d13 <=  qM7_d12;
            qM7_d14 <=  qM7_d13;
            qM7_d15 <=  qM7_d14;
            qM7_d16 <=  qM7_d15;
            qM7_d17 <=  qM7_d16;
            qM7_d18 <=  qM7_d17;
            qM7_d19 <=  qM7_d18;
            qM7_d20 <=  qM7_d19;
            qM7_d21 <=  qM7_d20;
            qM7_d22 <=  qM7_d21;
            qM7_d23 <=  qM7_d22;
            qM7_d24 <=  qM7_d23;
            qM7_d25 <=  qM7_d24;
            qM7_d26 <=  qM7_d25;
            qM7_d27 <=  qM7_d26;
            qM7_d28 <=  qM7_d27;
            qM7_d29 <=  qM7_d28;
            qM7_d30 <=  qM7_d29;
            qM7_d31 <=  qM7_d30;
            qM7_d32 <=  qM7_d31;
            qM7_d33 <=  qM7_d32;
            qM7_d34 <=  qM7_d33;
            qM7_d35 <=  qM7_d34;
            qM7_d36 <=  qM7_d35;
            qM7_d37 <=  qM7_d36;
            qM7_d38 <=  qM7_d37;
            qM7_d39 <=  qM7_d38;
            qM7_d40 <=  qM7_d39;
            qP6_d1 <=  qP6;
            qP6_d2 <=  qP6_d1;
            qP6_d3 <=  qP6_d2;
            qP6_d4 <=  qP6_d3;
            qP6_d5 <=  qP6_d4;
            qP6_d6 <=  qP6_d5;
            qP6_d7 <=  qP6_d6;
            qP6_d8 <=  qP6_d7;
            qP6_d9 <=  qP6_d8;
            qP6_d10 <=  qP6_d9;
            qP6_d11 <=  qP6_d10;
            qP6_d12 <=  qP6_d11;
            qP6_d13 <=  qP6_d12;
            qP6_d14 <=  qP6_d13;
            qP6_d15 <=  qP6_d14;
            qP6_d16 <=  qP6_d15;
            qP6_d17 <=  qP6_d16;
            qP6_d18 <=  qP6_d17;
            qP6_d19 <=  qP6_d18;
            qP6_d20 <=  qP6_d19;
            qP6_d21 <=  qP6_d20;
            qP6_d22 <=  qP6_d21;
            qP6_d23 <=  qP6_d22;
            qP6_d24 <=  qP6_d23;
            qP6_d25 <=  qP6_d24;
            qP6_d26 <=  qP6_d25;
            qP6_d27 <=  qP6_d26;
            qP6_d28 <=  qP6_d27;
            qP6_d29 <=  qP6_d28;
            qP6_d30 <=  qP6_d29;
            qM6_d1 <=  qM6;
            qM6_d2 <=  qM6_d1;
            qM6_d3 <=  qM6_d2;
            qM6_d4 <=  qM6_d3;
            qM6_d5 <=  qM6_d4;
            qM6_d6 <=  qM6_d5;
            qM6_d7 <=  qM6_d6;
            qM6_d8 <=  qM6_d7;
            qM6_d9 <=  qM6_d8;
            qM6_d10 <=  qM6_d9;
            qM6_d11 <=  qM6_d10;
            qM6_d12 <=  qM6_d11;
            qM6_d13 <=  qM6_d12;
            qM6_d14 <=  qM6_d13;
            qM6_d15 <=  qM6_d14;
            qM6_d16 <=  qM6_d15;
            qM6_d17 <=  qM6_d16;
            qM6_d18 <=  qM6_d17;
            qM6_d19 <=  qM6_d18;
            qM6_d20 <=  qM6_d19;
            qM6_d21 <=  qM6_d20;
            qM6_d22 <=  qM6_d21;
            qM6_d23 <=  qM6_d22;
            qM6_d24 <=  qM6_d23;
            qM6_d25 <=  qM6_d24;
            qM6_d26 <=  qM6_d25;
            qM6_d27 <=  qM6_d26;
            qM6_d28 <=  qM6_d27;
            qM6_d29 <=  qM6_d28;
            qM6_d30 <=  qM6_d29;
            qM6_d31 <=  qM6_d30;
            qM6_d32 <=  qM6_d31;
            qM6_d33 <=  qM6_d32;
            qM6_d34 <=  qM6_d33;
            qP5_d1 <=  qP5;
            qP5_d2 <=  qP5_d1;
            qP5_d3 <=  qP5_d2;
            qP5_d4 <=  qP5_d3;
            qP5_d5 <=  qP5_d4;
            qP5_d6 <=  qP5_d5;
            qP5_d7 <=  qP5_d6;
            qP5_d8 <=  qP5_d7;
            qP5_d9 <=  qP5_d8;
            qP5_d10 <=  qP5_d9;
            qP5_d11 <=  qP5_d10;
            qP5_d12 <=  qP5_d11;
            qP5_d13 <=  qP5_d12;
            qP5_d14 <=  qP5_d13;
            qP5_d15 <=  qP5_d14;
            qP5_d16 <=  qP5_d15;
            qP5_d17 <=  qP5_d16;
            qP5_d18 <=  qP5_d17;
            qP5_d19 <=  qP5_d18;
            qP5_d20 <=  qP5_d19;
            qP5_d21 <=  qP5_d20;
            qP5_d22 <=  qP5_d21;
            qP5_d23 <=  qP5_d22;
            qP5_d24 <=  qP5_d23;
            qM5_d1 <=  qM5;
            qM5_d2 <=  qM5_d1;
            qM5_d3 <=  qM5_d2;
            qM5_d4 <=  qM5_d3;
            qM5_d5 <=  qM5_d4;
            qM5_d6 <=  qM5_d5;
            qM5_d7 <=  qM5_d6;
            qM5_d8 <=  qM5_d7;
            qM5_d9 <=  qM5_d8;
            qM5_d10 <=  qM5_d9;
            qM5_d11 <=  qM5_d10;
            qM5_d12 <=  qM5_d11;
            qM5_d13 <=  qM5_d12;
            qM5_d14 <=  qM5_d13;
            qM5_d15 <=  qM5_d14;
            qM5_d16 <=  qM5_d15;
            qM5_d17 <=  qM5_d16;
            qM5_d18 <=  qM5_d17;
            qM5_d19 <=  qM5_d18;
            qM5_d20 <=  qM5_d19;
            qM5_d21 <=  qM5_d20;
            qM5_d22 <=  qM5_d21;
            qM5_d23 <=  qM5_d22;
            qM5_d24 <=  qM5_d23;
            qM5_d25 <=  qM5_d24;
            qM5_d26 <=  qM5_d25;
            qM5_d27 <=  qM5_d26;
            qM5_d28 <=  qM5_d27;
            qP4_d1 <=  qP4;
            qP4_d2 <=  qP4_d1;
            qP4_d3 <=  qP4_d2;
            qP4_d4 <=  qP4_d3;
            qP4_d5 <=  qP4_d4;
            qP4_d6 <=  qP4_d5;
            qP4_d7 <=  qP4_d6;
            qP4_d8 <=  qP4_d7;
            qP4_d9 <=  qP4_d8;
            qP4_d10 <=  qP4_d9;
            qP4_d11 <=  qP4_d10;
            qP4_d12 <=  qP4_d11;
            qP4_d13 <=  qP4_d12;
            qP4_d14 <=  qP4_d13;
            qP4_d15 <=  qP4_d14;
            qP4_d16 <=  qP4_d15;
            qP4_d17 <=  qP4_d16;
            qP4_d18 <=  qP4_d17;
            qM4_d1 <=  qM4;
            qM4_d2 <=  qM4_d1;
            qM4_d3 <=  qM4_d2;
            qM4_d4 <=  qM4_d3;
            qM4_d5 <=  qM4_d4;
            qM4_d6 <=  qM4_d5;
            qM4_d7 <=  qM4_d6;
            qM4_d8 <=  qM4_d7;
            qM4_d9 <=  qM4_d8;
            qM4_d10 <=  qM4_d9;
            qM4_d11 <=  qM4_d10;
            qM4_d12 <=  qM4_d11;
            qM4_d13 <=  qM4_d12;
            qM4_d14 <=  qM4_d13;
            qM4_d15 <=  qM4_d14;
            qM4_d16 <=  qM4_d15;
            qM4_d17 <=  qM4_d16;
            qM4_d18 <=  qM4_d17;
            qM4_d19 <=  qM4_d18;
            qM4_d20 <=  qM4_d19;
            qM4_d21 <=  qM4_d20;
            qM4_d22 <=  qM4_d21;
            qP3_d1 <=  qP3;
            qP3_d2 <=  qP3_d1;
            qP3_d3 <=  qP3_d2;
            qP3_d4 <=  qP3_d3;
            qP3_d5 <=  qP3_d4;
            qP3_d6 <=  qP3_d5;
            qP3_d7 <=  qP3_d6;
            qP3_d8 <=  qP3_d7;
            qP3_d9 <=  qP3_d8;
            qP3_d10 <=  qP3_d9;
            qP3_d11 <=  qP3_d10;
            qP3_d12 <=  qP3_d11;
            qM3_d1 <=  qM3;
            qM3_d2 <=  qM3_d1;
            qM3_d3 <=  qM3_d2;
            qM3_d4 <=  qM3_d3;
            qM3_d5 <=  qM3_d4;
            qM3_d6 <=  qM3_d5;
            qM3_d7 <=  qM3_d6;
            qM3_d8 <=  qM3_d7;
            qM3_d9 <=  qM3_d8;
            qM3_d10 <=  qM3_d9;
            qM3_d11 <=  qM3_d10;
            qM3_d12 <=  qM3_d11;
            qM3_d13 <=  qM3_d12;
            qM3_d14 <=  qM3_d13;
            qM3_d15 <=  qM3_d14;
            qM3_d16 <=  qM3_d15;
            qP2_d1 <=  qP2;
            qP2_d2 <=  qP2_d1;
            qP2_d3 <=  qP2_d2;
            qP2_d4 <=  qP2_d3;
            qP2_d5 <=  qP2_d4;
            qP2_d6 <=  qP2_d5;
            qM2_d1 <=  qM2;
            qM2_d2 <=  qM2_d1;
            qM2_d3 <=  qM2_d2;
            qM2_d4 <=  qM2_d3;
            qM2_d5 <=  qM2_d4;
            qM2_d6 <=  qM2_d5;
            qM2_d7 <=  qM2_d6;
            qM2_d8 <=  qM2_d7;
            qM2_d9 <=  qM2_d8;
            qM2_d10 <=  qM2_d9;
            qM1_d1 <=  qM1;
            qM1_d2 <=  qM1_d1;
            qM1_d3 <=  qM1_d2;
            qM1_d4 <=  qM1_d3;
            qP_d1 <=  qP;
            qP_d2 <=  qP_d1;
            qP_d3 <=  qP_d2;
            qP_d4 <=  qP_d3;
            qP_d5 <=  qP_d4;
            qP_d6 <=  qP_d5;
            qP_d7 <=  qP_d6;
            qP_d8 <=  qP_d7;
            qM_d1 <=  qM;
            qM_d2 <=  qM_d1;
            qM_d3 <=  qM_d2;
            qM_d4 <=  qM_d3;
            mR_d1 <=  mR;
            mR_d2 <=  mR_d1;
            mR_d3 <=  mR_d2;
            mR_d4 <=  mR_d3;
            fRnorm_d1 <=  fRnorm;
            fRnorm_d2 <=  fRnorm_d1;
            fRnorm_d3 <=  fRnorm_d2;
            round_d1 <=  round;
            round_d2 <=  round_d1;
            round_d3 <=  round_d2;
         end if;
      end process;
   fX <= "1" & X(22 downto 0);
   fY <= "1" & Y(22 downto 0);
   -- exponent difference, sign and exception combination computed early, to have fewer bits to pipeline
   expR0 <= ("00" & X(30 downto 23)) - ("00" & Y(30 downto 23));
   sR <= X(31) xor Y(31);
   -- early exception handling 
   exnXY <= X(33 downto 32) & Y(33 downto 32);
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
   SelFunctionTable14: selFunction_Freq2000_uid4
      port map ( X => sel14,
                 Y => q14_copy5);
   q14 <= q14_copy5_d1; -- output copy to hold a pipeline register if needed

   with q14  select 
      absq14D <= 
         "000" & D_d1						 when "001" | "111", -- mult by 1
         "00" & D_d1 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q14_d5(2)  select 
   w13<= betaw14_d6 - absq14D_d5 when '0',
         betaw14_d6 + absq14D_d5 when others;

   betaw13 <= w13(24 downto 0) & "00"; -- multiplication by the radix
   sel13 <= betaw13(26 downto 21) & D_d6(22 downto 20);
   SelFunctionTable13: selFunction_Freq2000_uid4
      port map ( X => sel13,
                 Y => q13_copy6);
   q13 <= q13_copy6_d1; -- output copy to hold a pipeline register if needed

   with q13  select 
      absq13D <= 
         "000" & D_d7						 when "001" | "111", -- mult by 1
         "00" & D_d7 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q13_d5(2)  select 
   w12<= betaw13_d6 - absq13D_d5 when '0',
         betaw13_d6 + absq13D_d5 when others;

   betaw12 <= w12(24 downto 0) & "00"; -- multiplication by the radix
   sel12 <= betaw12(26 downto 21) & D_d12(22 downto 20);
   SelFunctionTable12: selFunction_Freq2000_uid4
      port map ( X => sel12,
                 Y => q12_copy7);
   q12 <= q12_copy7_d1; -- output copy to hold a pipeline register if needed

   with q12  select 
      absq12D <= 
         "000" & D_d13						 when "001" | "111", -- mult by 1
         "00" & D_d13 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q12_d5(2)  select 
   w11<= betaw12_d6 - absq12D_d5 when '0',
         betaw12_d6 + absq12D_d5 when others;

   betaw11 <= w11(24 downto 0) & "00"; -- multiplication by the radix
   sel11 <= betaw11(26 downto 21) & D_d18(22 downto 20);
   SelFunctionTable11: selFunction_Freq2000_uid4
      port map ( X => sel11,
                 Y => q11_copy8);
   q11 <= q11_copy8_d1; -- output copy to hold a pipeline register if needed

   with q11  select 
      absq11D <= 
         "000" & D_d19						 when "001" | "111", -- mult by 1
         "00" & D_d19 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q11_d5(2)  select 
   w10<= betaw11_d6 - absq11D_d5 when '0',
         betaw11_d6 + absq11D_d5 when others;

   betaw10 <= w10(24 downto 0) & "00"; -- multiplication by the radix
   sel10 <= betaw10(26 downto 21) & D_d24(22 downto 20);
   SelFunctionTable10: selFunction_Freq2000_uid4
      port map ( X => sel10,
                 Y => q10_copy9);
   q10 <= q10_copy9_d1; -- output copy to hold a pipeline register if needed

   with q10  select 
      absq10D <= 
         "000" & D_d25						 when "001" | "111", -- mult by 1
         "00" & D_d25 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q10_d5(2)  select 
   w9<= betaw10_d6 - absq10D_d5 when '0',
         betaw10_d6 + absq10D_d5 when others;

   betaw9 <= w9(24 downto 0) & "00"; -- multiplication by the radix
   sel9 <= betaw9(26 downto 21) & D_d30(22 downto 20);
   SelFunctionTable9: selFunction_Freq2000_uid4
      port map ( X => sel9,
                 Y => q9_copy10);
   q9 <= q9_copy10_d2; -- output copy to hold a pipeline register if needed

   with q9  select 
      absq9D <= 
         "000" & D_d32						 when "001" | "111", -- mult by 1
         "00" & D_d32 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q9_d4(2)  select 
   w8<= betaw9_d6 - absq9D_d4 when '0',
         betaw9_d6 + absq9D_d4 when others;

   betaw8 <= w8(24 downto 0) & "00"; -- multiplication by the radix
   sel8 <= betaw8(26 downto 21) & D_d36(22 downto 20);
   SelFunctionTable8: selFunction_Freq2000_uid4
      port map ( X => sel8,
                 Y => q8_copy11);
   q8 <= q8_copy11_d2; -- output copy to hold a pipeline register if needed

   with q8  select 
      absq8D <= 
         "000" & D_d38						 when "001" | "111", -- mult by 1
         "00" & D_d38 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q8_d4(2)  select 
   w7<= betaw8_d6 - absq8D_d4 when '0',
         betaw8_d6 + absq8D_d4 when others;

   betaw7 <= w7(24 downto 0) & "00"; -- multiplication by the radix
   sel7 <= betaw7(26 downto 21) & D_d42(22 downto 20);
   SelFunctionTable7: selFunction_Freq2000_uid4
      port map ( X => sel7,
                 Y => q7_copy12);
   q7 <= q7_copy12_d2; -- output copy to hold a pipeline register if needed

   with q7  select 
      absq7D <= 
         "000" & D_d44						 when "001" | "111", -- mult by 1
         "00" & D_d44 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q7_d4(2)  select 
   w6<= betaw7_d6 - absq7D_d4 when '0',
         betaw7_d6 + absq7D_d4 when others;

   betaw6 <= w6(24 downto 0) & "00"; -- multiplication by the radix
   sel6 <= betaw6(26 downto 21) & D_d48(22 downto 20);
   SelFunctionTable6: selFunction_Freq2000_uid4
      port map ( X => sel6,
                 Y => q6_copy13);
   q6 <= q6_copy13_d2; -- output copy to hold a pipeline register if needed

   with q6  select 
      absq6D <= 
         "000" & D_d50						 when "001" | "111", -- mult by 1
         "00" & D_d50 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q6_d4(2)  select 
   w5<= betaw6_d6 - absq6D_d4 when '0',
         betaw6_d6 + absq6D_d4 when others;

   betaw5 <= w5(24 downto 0) & "00"; -- multiplication by the radix
   sel5 <= betaw5(26 downto 21) & D_d54(22 downto 20);
   SelFunctionTable5: selFunction_Freq2000_uid4
      port map ( X => sel5,
                 Y => q5_copy14);
   q5 <= q5_copy14_d2; -- output copy to hold a pipeline register if needed

   with q5  select 
      absq5D <= 
         "000" & D_d56						 when "001" | "111", -- mult by 1
         "00" & D_d56 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q5_d4(2)  select 
   w4<= betaw5_d6 - absq5D_d4 when '0',
         betaw5_d6 + absq5D_d4 when others;

   betaw4 <= w4(24 downto 0) & "00"; -- multiplication by the radix
   sel4 <= betaw4(26 downto 21) & D_d60(22 downto 20);
   SelFunctionTable4: selFunction_Freq2000_uid4
      port map ( X => sel4,
                 Y => q4_copy15);
   q4 <= q4_copy15_d2; -- output copy to hold a pipeline register if needed

   with q4  select 
      absq4D <= 
         "000" & D_d62						 when "001" | "111", -- mult by 1
         "00" & D_d62 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q4_d4(2)  select 
   w3<= betaw4_d6 - absq4D_d4 when '0',
         betaw4_d6 + absq4D_d4 when others;

   betaw3 <= w3(24 downto 0) & "00"; -- multiplication by the radix
   sel3 <= betaw3(26 downto 21) & D_d66(22 downto 20);
   SelFunctionTable3: selFunction_Freq2000_uid4
      port map ( X => sel3,
                 Y => q3_copy16);
   q3 <= q3_copy16_d2; -- output copy to hold a pipeline register if needed

   with q3  select 
      absq3D <= 
         "000" & D_d68						 when "001" | "111", -- mult by 1
         "00" & D_d68 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q3_d4(2)  select 
   w2<= betaw3_d6 - absq3D_d4 when '0',
         betaw3_d6 + absq3D_d4 when others;

   betaw2 <= w2(24 downto 0) & "00"; -- multiplication by the radix
   sel2 <= betaw2(26 downto 21) & D_d72(22 downto 20);
   SelFunctionTable2: selFunction_Freq2000_uid4
      port map ( X => sel2,
                 Y => q2_copy17);
   q2 <= q2_copy17_d2; -- output copy to hold a pipeline register if needed

   with q2  select 
      absq2D <= 
         "000" & D_d74						 when "001" | "111", -- mult by 1
         "00" & D_d74 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q2_d4(2)  select 
   w1<= betaw2_d6 - absq2D_d4 when '0',
         betaw2_d6 + absq2D_d4 when others;

   betaw1 <= w1(24 downto 0) & "00"; -- multiplication by the radix
   sel1 <= betaw1(26 downto 21) & D_d78(22 downto 20);
   SelFunctionTable1: selFunction_Freq2000_uid4
      port map ( X => sel1,
                 Y => q1_copy18);
   q1 <= q1_copy18_d2; -- output copy to hold a pipeline register if needed

   with q1  select 
      absq1D <= 
         "000" & D_d80						 when "001" | "111", -- mult by 1
         "00" & D_d80 & "0"			   when "010" | "110", -- mult by 2
         (26 downto 0 => '0')	 when others;        -- mult by 0

   with q1_d4(2)  select 
   w0<= betaw1_d6 - absq1D_d4 when '0',
         betaw1_d6 + absq1D_d4 when others;

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
   qP <= qP14_d79 & qP13_d73 & qP12_d67 & qP11_d61 & qP10_d55 & qP9_d48 & qP8_d42 & qP7_d36 & qP6_d30 & qP5_d24 & qP4_d18 & qP3_d12 & qP2_d6 & qP1;
   qM <= qM14_d83(0) & qM13_d77 & qM12_d71 & qM11_d65 & qM10_d59 & qM9_d52 & qM8_d46 & qM7_d40 & qM6_d34 & qM5_d28 & qM4_d22 & qM3_d16 & qM2_d10 & qM1_d4 & qM0;
   quotient <= qP_d8 - qM_d4;
   -- We need a mR in (0, -wf-2) format: 1+wF fraction bits, 1 round bit, and 1 guard bit for the normalisation,
   -- quotient is the truncation of the exact quotient to at least 2^(-wF-2) bits
   -- now discarding its possible known MSB zeroes, and dropping the possible extra LSB bit (due to radix 4) 
   mR <= quotient(26 downto 1); 
   -- normalisation
   fRnorm <=    mR_d1(24 downto 1)  when mR_d1(25)= '1'
           else mR_d1(23 downto 0);  -- now fRnorm is a (-1, -wF-1) fraction
   round <= fRnorm(0); 
   expR1 <= expR0_d92 + ("000" & (6 downto 1 => '1') & mR_d4(25)); -- add back bias
   -- final rounding
   expfrac <= expR1 & fRnorm_d3(23 downto 1) ;
   expfracR <= expfrac + ((32 downto 1 => '0') & round_d3);
   exnR <=      "00"  when expfracR(32) = '1'   -- underflow
           else "10"  when  expfracR(32 downto 31) =  "01" -- overflow
           else "01";      -- 00, normal case
   with exnR0_d92  select 
      exnRfinal <= 
         exnR   when "01", -- normal
         exnR0_d92  when others;
   R <= exnRfinal & sR_d92 & expfracR(30 downto 0);
end architecture;

