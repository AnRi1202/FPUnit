--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid12
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
--  approx. output signal timings: Y: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq100_uid12 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid12 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.619000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
begin
   with X  select  Y0 <= 
      "000000" when "000000",
      "000000" when "000001",
      "000000" when "000010",
      "000000" when "000011",
      "000000" when "000100",
      "000000" when "000101",
      "000000" when "000110",
      "000000" when "000111",
      "000000" when "001000",
      "000001" when "001001",
      "000010" when "001010",
      "000011" when "001011",
      "000100" when "001100",
      "000101" when "001101",
      "000110" when "001110",
      "000111" when "001111",
      "000000" when "010000",
      "000010" when "010001",
      "000100" when "010010",
      "000110" when "010011",
      "001000" when "010100",
      "001010" when "010101",
      "001100" when "010110",
      "001110" when "010111",
      "000000" when "011000",
      "000011" when "011001",
      "000110" when "011010",
      "001001" when "011011",
      "001100" when "011100",
      "001111" when "011101",
      "010010" when "011110",
      "010101" when "011111",
      "000000" when "100000",
      "000100" when "100001",
      "001000" when "100010",
      "001100" when "100011",
      "010000" when "100100",
      "010100" when "100101",
      "011000" when "100110",
      "011100" when "100111",
      "000000" when "101000",
      "000101" when "101001",
      "001010" when "101010",
      "001111" when "101011",
      "010100" when "101100",
      "011001" when "101101",
      "011110" when "101110",
      "100011" when "101111",
      "000000" when "110000",
      "000110" when "110001",
      "001100" when "110010",
      "010010" when "110011",
      "011000" when "110100",
      "011110" when "110101",
      "100100" when "110110",
      "101010" when "110111",
      "000000" when "111000",
      "000111" when "111001",
      "001110" when "111010",
      "010101" when "111011",
      "011100" when "111100",
      "100011" when "111101",
      "101010" when "111110",
      "110001" when "111111",
      "------" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid17
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
--  approx. output signal timings: Y: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq100_uid17 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid17 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.619000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
begin
   with X  select  Y0 <= 
      "000000" when "000000",
      "000000" when "000001",
      "000000" when "000010",
      "000000" when "000011",
      "000000" when "000100",
      "000000" when "000101",
      "000000" when "000110",
      "000000" when "000111",
      "000000" when "001000",
      "000001" when "001001",
      "000010" when "001010",
      "000011" when "001011",
      "000100" when "001100",
      "000101" when "001101",
      "000110" when "001110",
      "000111" when "001111",
      "000000" when "010000",
      "000010" when "010001",
      "000100" when "010010",
      "000110" when "010011",
      "001000" when "010100",
      "001010" when "010101",
      "001100" when "010110",
      "001110" when "010111",
      "000000" when "011000",
      "000011" when "011001",
      "000110" when "011010",
      "001001" when "011011",
      "001100" when "011100",
      "001111" when "011101",
      "010010" when "011110",
      "010101" when "011111",
      "000000" when "100000",
      "000100" when "100001",
      "001000" when "100010",
      "001100" when "100011",
      "010000" when "100100",
      "010100" when "100101",
      "011000" when "100110",
      "011100" when "100111",
      "000000" when "101000",
      "000101" when "101001",
      "001010" when "101010",
      "001111" when "101011",
      "010100" when "101100",
      "011001" when "101101",
      "011110" when "101110",
      "100011" when "101111",
      "000000" when "110000",
      "000110" when "110001",
      "001100" when "110010",
      "010010" when "110011",
      "011000" when "110100",
      "011110" when "110101",
      "100100" when "110110",
      "101010" when "110111",
      "000000" when "111000",
      "000111" when "111001",
      "001110" when "111010",
      "010101" when "111011",
      "011100" when "111100",
      "100011" when "111101",
      "101010" when "111110",
      "110001" when "111111",
      "------" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid22
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
--  approx. output signal timings: Y: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq100_uid22 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid22 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.619000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
begin
   with X  select  Y0 <= 
      "000000" when "000000",
      "000000" when "000001",
      "000000" when "000010",
      "000000" when "000011",
      "000000" when "000100",
      "000000" when "000101",
      "000000" when "000110",
      "000000" when "000111",
      "000000" when "001000",
      "000001" when "001001",
      "000010" when "001010",
      "000011" when "001011",
      "000100" when "001100",
      "000101" when "001101",
      "000110" when "001110",
      "000111" when "001111",
      "000000" when "010000",
      "000010" when "010001",
      "000100" when "010010",
      "000110" when "010011",
      "001000" when "010100",
      "001010" when "010101",
      "001100" when "010110",
      "001110" when "010111",
      "000000" when "011000",
      "000011" when "011001",
      "000110" when "011010",
      "001001" when "011011",
      "001100" when "011100",
      "001111" when "011101",
      "010010" when "011110",
      "010101" when "011111",
      "000000" when "100000",
      "000100" when "100001",
      "001000" when "100010",
      "001100" when "100011",
      "010000" when "100100",
      "010100" when "100101",
      "011000" when "100110",
      "011100" when "100111",
      "000000" when "101000",
      "000101" when "101001",
      "001010" when "101010",
      "001111" when "101011",
      "010100" when "101100",
      "011001" when "101101",
      "011110" when "101110",
      "100011" when "101111",
      "000000" when "110000",
      "000110" when "110001",
      "001100" when "110010",
      "010010" when "110011",
      "011000" when "110100",
      "011110" when "110101",
      "100100" when "110110",
      "101010" when "110111",
      "000000" when "111000",
      "000111" when "111001",
      "001110" when "111010",
      "010101" when "111011",
      "011100" when "111100",
      "100011" when "111101",
      "101010" when "111110",
      "110001" when "111111",
      "------" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid27
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

entity MultTable_Freq100_uid27 is
    port (X : in  std_logic_vector(4 downto 0);
          Y : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid27 is
signal Y0 :  std_logic_vector(4 downto 0);
   -- timing of Y0: (c0, 0.543000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
begin
   with X  select  Y0 <= 
      "00000" when "00000",
      "00000" when "00001",
      "00000" when "00010",
      "00000" when "00011",
      "00000" when "00100",
      "00000" when "00101",
      "00000" when "00110",
      "00000" when "00111",
      "00000" when "01000",
      "00001" when "01001",
      "00010" when "01010",
      "00011" when "01011",
      "00100" when "01100",
      "00101" when "01101",
      "00110" when "01110",
      "00111" when "01111",
      "00000" when "10000",
      "00010" when "10001",
      "00100" when "10010",
      "00110" when "10011",
      "01000" when "10100",
      "01010" when "10101",
      "01100" when "10110",
      "01110" when "10111",
      "00000" when "11000",
      "00011" when "11001",
      "00110" when "11010",
      "01001" when "11011",
      "01100" when "11100",
      "01111" when "11101",
      "10010" when "11110",
      "10101" when "11111",
      "-----" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid32
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
--  approx. output signal timings: Y: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq100_uid32 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid32 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.619000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
begin
   with X  select  Y0 <= 
      "000000" when "000000",
      "000000" when "000001",
      "000000" when "000010",
      "000000" when "000011",
      "000000" when "000100",
      "000000" when "000101",
      "000000" when "000110",
      "000000" when "000111",
      "000000" when "001000",
      "000001" when "001001",
      "000010" when "001010",
      "000011" when "001011",
      "000100" when "001100",
      "000101" when "001101",
      "000110" when "001110",
      "000111" when "001111",
      "000000" when "010000",
      "000010" when "010001",
      "000100" when "010010",
      "000110" when "010011",
      "001000" when "010100",
      "001010" when "010101",
      "001100" when "010110",
      "001110" when "010111",
      "000000" when "011000",
      "000011" when "011001",
      "000110" when "011010",
      "001001" when "011011",
      "001100" when "011100",
      "001111" when "011101",
      "010010" when "011110",
      "010101" when "011111",
      "000000" when "100000",
      "000100" when "100001",
      "001000" when "100010",
      "001100" when "100011",
      "010000" when "100100",
      "010100" when "100101",
      "011000" when "100110",
      "011100" when "100111",
      "000000" when "101000",
      "000101" when "101001",
      "001010" when "101010",
      "001111" when "101011",
      "010100" when "101100",
      "011001" when "101101",
      "011110" when "101110",
      "100011" when "101111",
      "000000" when "110000",
      "000110" when "110001",
      "001100" when "110010",
      "010010" when "110011",
      "011000" when "110100",
      "011110" when "110101",
      "100100" when "110110",
      "101010" when "110111",
      "000000" when "111000",
      "000111" when "111001",
      "001110" when "111010",
      "010101" when "111011",
      "011100" when "111100",
      "100011" when "111101",
      "101010" when "111110",
      "110001" when "111111",
      "------" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid37
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

entity MultTable_Freq100_uid37 is
    port (X : in  std_logic_vector(4 downto 0);
          Y : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid37 is
signal Y0 :  std_logic_vector(4 downto 0);
   -- timing of Y0: (c0, 0.543000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
begin
   with X  select  Y0 <= 
      "00000" when "00000",
      "00000" when "00001",
      "00000" when "00010",
      "00000" when "00011",
      "00000" when "00100",
      "00001" when "00101",
      "00010" when "00110",
      "00011" when "00111",
      "00000" when "01000",
      "00010" when "01001",
      "00100" when "01010",
      "00110" when "01011",
      "00000" when "01100",
      "00011" when "01101",
      "00110" when "01110",
      "01001" when "01111",
      "00000" when "10000",
      "00100" when "10001",
      "01000" when "10010",
      "01100" when "10011",
      "00000" when "10100",
      "00101" when "10101",
      "01010" when "10110",
      "01111" when "10111",
      "00000" when "11000",
      "00110" when "11001",
      "01100" when "11010",
      "10010" when "11011",
      "00000" when "11100",
      "00111" when "11101",
      "01110" when "11110",
      "10101" when "11111",
      "-----" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid42
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

entity MultTable_Freq100_uid42 is
    port (X : in  std_logic_vector(4 downto 0);
          Y : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid42 is
signal Y0 :  std_logic_vector(4 downto 0);
   -- timing of Y0: (c0, 0.543000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
begin
   with X  select  Y0 <= 
      "00000" when "00000",
      "00000" when "00001",
      "00000" when "00010",
      "00000" when "00011",
      "00000" when "00100",
      "00000" when "00101",
      "00000" when "00110",
      "00000" when "00111",
      "00000" when "01000",
      "00001" when "01001",
      "00010" when "01010",
      "00011" when "01011",
      "00100" when "01100",
      "00101" when "01101",
      "00110" when "01110",
      "00111" when "01111",
      "00000" when "10000",
      "00010" when "10001",
      "00100" when "10010",
      "00110" when "10011",
      "01000" when "10100",
      "01010" when "10101",
      "01100" when "10110",
      "01110" when "10111",
      "00000" when "11000",
      "00011" when "11001",
      "00110" when "11010",
      "01001" when "11011",
      "01100" when "11100",
      "01111" when "11101",
      "10010" when "11110",
      "10101" when "11111",
      "-----" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                          MultTable_Freq100_uid47
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

entity MultTable_Freq100_uid47 is
    port (X : in  std_logic_vector(4 downto 0);
          Y : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of MultTable_Freq100_uid47 is
signal Y0 :  std_logic_vector(4 downto 0);
   -- timing of Y0: (c0, 0.543000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
begin
   with X  select  Y0 <= 
      "00000" when "00000",
      "00000" when "00001",
      "00000" when "00010",
      "00000" when "00011",
      "00000" when "00100",
      "00001" when "00101",
      "00010" when "00110",
      "00011" when "00111",
      "00000" when "01000",
      "00010" when "01001",
      "00100" when "01010",
      "00110" when "01011",
      "00000" when "01100",
      "00011" when "01101",
      "00110" when "01110",
      "01001" when "01111",
      "00000" when "10000",
      "00100" when "10001",
      "01000" when "10010",
      "01100" when "10011",
      "00000" when "10100",
      "00101" when "10101",
      "01010" when "10110",
      "01111" when "10111",
      "00000" when "11000",
      "00110" when "11001",
      "01100" when "11010",
      "10010" when "11011",
      "00000" when "11100",
      "00111" when "11101",
      "01110" when "11110",
      "10101" when "11111",
      "-----" when others;
   Y1 <= Y0; -- for the possible blockram register
   Y <= Y1;
end architecture;

--------------------------------------------------------------------------------
--                       Compressor_23_3_Freq100_uid55
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X1 X0
-- Output signals: R
--  approx. input signal timings: X1: (c0, 0.000000ns)X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_23_3_Freq100_uid55 is
    port (X1 : in  std_logic_vector(1 downto 0);
          X0 : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_23_3_Freq100_uid55 is
signal X :  std_logic_vector(4 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(2 downto 0);
   -- timing of R0: (c0, 0.543000ns)
begin
   X <= X1 & X0 ;

   with X  select  R0 <= 
      "000" when "00000",
      "001" when "00001" | "00010" | "00100",
      "010" when "00011" | "00101" | "00110" | "01000" | "10000",
      "011" when "00111" | "01001" | "01010" | "01100" | "10001" | "10010" | "10100",
      "100" when "01011" | "01101" | "01110" | "10011" | "10101" | "10110" | "11000",
      "101" when "01111" | "10111" | "11001" | "11010" | "11100",
      "110" when "11011" | "11101" | "11110",
      "111" when "11111",
      "---" when others;
   R <= R0;
end architecture;

--------------------------------------------------------------------------------
--                        Compressor_3_2_Freq100_uid61
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X0
-- Output signals: R
--  approx. input signal timings: X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_3_2_Freq100_uid61 is
    port (X0 : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of Compressor_3_2_Freq100_uid61 is
signal X :  std_logic_vector(2 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(1 downto 0);
   -- timing of R0: (c0, 0.543000ns)
begin
   X <= X0 ;

   with X  select  R0 <= 
      "00" when "000",
      "01" when "001" | "010" | "100",
      "10" when "011" | "101" | "110",
      "11" when "111",
      "--" when others;
   R <= R0;
end architecture;

--------------------------------------------------------------------------------
--                       Compressor_14_3_Freq100_uid65
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X1 X0
-- Output signals: R
--  approx. input signal timings: X1: (c0, 0.000000ns)X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_14_3_Freq100_uid65 is
    port (X1 : in  std_logic_vector(0 downto 0);
          X0 : in  std_logic_vector(3 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_14_3_Freq100_uid65 is
signal X :  std_logic_vector(4 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(2 downto 0);
   -- timing of R0: (c0, 0.543000ns)
begin
   X <= X1 & X0 ;

   with X  select  R0 <= 
      "000" when "00000",
      "001" when "00001" | "00010" | "00100" | "01000",
      "010" when "00011" | "00101" | "00110" | "01001" | "01010" | "01100" | "10000",
      "011" when "00111" | "01011" | "01101" | "01110" | "10001" | "10010" | "10100" | "11000",
      "100" when "01111" | "10011" | "10101" | "10110" | "11001" | "11010" | "11100",
      "101" when "10111" | "11011" | "11101" | "11110",
      "110" when "11111",
      "---" when others;
   R <= R0;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq100_uid10
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq100_uid10 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq100_uid10 is
   component MultTable_Freq100_uid12 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
signal Y1_copy13 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy13: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid12
      port map ( X => Xtable,
                 Y => Y1_copy13);
   Y1 <= Y1_copy13; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq100_uid15
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq100_uid15 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq100_uid15 is
   component MultTable_Freq100_uid17 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
signal Y1_copy18 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy18: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid17
      port map ( X => Xtable,
                 Y => Y1_copy18);
   Y1 <= Y1_copy18; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq100_uid20
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq100_uid20 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq100_uid20 is
   component MultTable_Freq100_uid22 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
signal Y1_copy23 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy23: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid22
      port map ( X => Xtable,
                 Y => Y1_copy23);
   Y1 <= Y1_copy23; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x2_Freq100_uid25
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x2_Freq100_uid25 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(1 downto 0);
          R : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x2_Freq100_uid25 is
   component MultTable_Freq100_uid27 is
      port ( X : in  std_logic_vector(4 downto 0);
             Y : out  std_logic_vector(4 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(4 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
signal Y1_copy28 :  std_logic_vector(4 downto 0);
   -- timing of Y1_copy28: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid27
      port map ( X => Xtable,
                 Y => Y1_copy28);
   Y1 <= Y1_copy28; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq100_uid30
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.619000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq100_uid30 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq100_uid30 is
   component MultTable_Freq100_uid32 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.619000ns)
signal Y1_copy33 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy33: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid32
      port map ( X => Xtable,
                 Y => Y1_copy33);
   Y1 <= Y1_copy33; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x3_Freq100_uid35
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x3_Freq100_uid35 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x3_Freq100_uid35 is
   component MultTable_Freq100_uid37 is
      port ( X : in  std_logic_vector(4 downto 0);
             Y : out  std_logic_vector(4 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(4 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
signal Y1_copy38 :  std_logic_vector(4 downto 0);
   -- timing of Y1_copy38: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid37
      port map ( X => Xtable,
                 Y => Y1_copy38);
   Y1 <= Y1_copy38; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x2_Freq100_uid40
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x2_Freq100_uid40 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(1 downto 0);
          R : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x2_Freq100_uid40 is
   component MultTable_Freq100_uid42 is
      port ( X : in  std_logic_vector(4 downto 0);
             Y : out  std_logic_vector(4 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(4 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
signal Y1_copy43 :  std_logic_vector(4 downto 0);
   -- timing of Y1_copy43: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid42
      port map ( X => Xtable,
                 Y => Y1_copy43);
   Y1 <= Y1_copy43; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x3_Freq100_uid45
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x3_Freq100_uid45 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x3_Freq100_uid45 is
   component MultTable_Freq100_uid47 is
      port ( X : in  std_logic_vector(4 downto 0);
             Y : out  std_logic_vector(4 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(4 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(4 downto 0);
   -- timing of Y1: (c0, 0.543000ns)
signal Y1_copy48 :  std_logic_vector(4 downto 0);
   -- timing of Y1_copy48: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq100_uid47
      port map ( X => Xtable,
                 Y => Y1_copy48);
   Y1 <= Y1_copy48; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_1x2_Freq100_uid50
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_1x2_Freq100_uid50 is
    port (clk : in std_logic;
          X : in  std_logic_vector(0 downto 0);
          Y : in  std_logic_vector(1 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_1x2_Freq100_uid50 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.543000ns)
begin
   replicated <= (1 downto 0 => X(0));
   prod <= Y and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_1x2_Freq100_uid52
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.543000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_1x2_Freq100_uid52 is
    port (clk : in std_logic;
          X : in  std_logic_vector(0 downto 0);
          Y : in  std_logic_vector(1 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_1x2_Freq100_uid52 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.543000ns)
begin
   replicated <= (1 downto 0 => X(0));
   prod <= Y and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                         IntAdder_12_Freq100_uid95
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c0, 1.705000ns)Y: (c0, 1.705000ns)Cin: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 2.846000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_12_Freq100_uid95 is
    port (clk : in std_logic;
          X : in  std_logic_vector(11 downto 0);
          Y : in  std_logic_vector(11 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(11 downto 0)   );
end entity;

architecture arch of IntAdder_12_Freq100_uid95 is
signal Rtmp :  std_logic_vector(11 downto 0);
   -- timing of Rtmp: (c0, 2.846000ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplier_8x8_16_Freq100_uid5
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Martin Kumm, Florent de Dinechin, Andreas Böttcher, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012-
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 2.846000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_8x8_16_Freq100_uid5 is
    port (clk : in std_logic;
          X : in  std_logic_vector(7 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(15 downto 0)   );
end entity;

architecture arch of IntMultiplier_8x8_16_Freq100_uid5 is
   component IntMultiplierLUT_3x3_Freq100_uid10 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq100_uid15 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq100_uid20 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x2_Freq100_uid25 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(1 downto 0);
             R : out  std_logic_vector(4 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq100_uid30 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x3_Freq100_uid35 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(4 downto 0)   );
   end component;

   component IntMultiplierLUT_3x2_Freq100_uid40 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(1 downto 0);
             R : out  std_logic_vector(4 downto 0)   );
   end component;

   component IntMultiplierLUT_2x3_Freq100_uid45 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(4 downto 0)   );
   end component;

   component IntMultiplierLUT_1x2_Freq100_uid50 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(0 downto 0);
             Y : in  std_logic_vector(1 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_1x2_Freq100_uid52 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(0 downto 0);
             Y : in  std_logic_vector(1 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component Compressor_23_3_Freq100_uid55 is
      port ( X1 : in  std_logic_vector(1 downto 0);
             X0 : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component Compressor_3_2_Freq100_uid61 is
      port ( X0 : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component Compressor_14_3_Freq100_uid65 is
      port ( X1 : in  std_logic_vector(0 downto 0);
             X0 : in  std_logic_vector(3 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component IntAdder_12_Freq100_uid95 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(11 downto 0);
             Y : in  std_logic_vector(11 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(11 downto 0)   );
   end component;

signal XX_m6 :  std_logic_vector(7 downto 0);
   -- timing of XX_m6: (c0, 0.000000ns)
signal YY_m6 :  std_logic_vector(7 downto 0);
   -- timing of YY_m6: (c0, 0.000000ns)
signal t8_tile_0_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_0_X: (c0, 0.000000ns)
signal t8_tile_0_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_0_Y: (c0, 0.000000ns)
signal t8_tile_0_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_0_output: (c0, 0.619000ns)
signal t8_tile_0_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_0_filtered_output: (c0, 0.619000ns)
signal bh7_w10_0 :  std_logic;
   -- timing of bh7_w10_0: (c0, 0.619000ns)
signal bh7_w11_0 :  std_logic;
   -- timing of bh7_w11_0: (c0, 0.619000ns)
signal bh7_w12_0 :  std_logic;
   -- timing of bh7_w12_0: (c0, 0.619000ns)
signal bh7_w13_0 :  std_logic;
   -- timing of bh7_w13_0: (c0, 0.619000ns)
signal bh7_w14_0 :  std_logic;
   -- timing of bh7_w14_0: (c0, 0.619000ns)
signal bh7_w15_0 :  std_logic;
   -- timing of bh7_w15_0: (c0, 0.619000ns)
signal t8_tile_1_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_1_X: (c0, 0.000000ns)
signal t8_tile_1_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_1_Y: (c0, 0.000000ns)
signal t8_tile_1_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_1_output: (c0, 0.619000ns)
signal t8_tile_1_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_1_filtered_output: (c0, 0.619000ns)
signal bh7_w7_0 :  std_logic;
   -- timing of bh7_w7_0: (c0, 0.619000ns)
signal bh7_w8_0 :  std_logic;
   -- timing of bh7_w8_0: (c0, 0.619000ns)
signal bh7_w9_0 :  std_logic;
   -- timing of bh7_w9_0: (c0, 0.619000ns)
signal bh7_w10_1 :  std_logic;
   -- timing of bh7_w10_1: (c0, 0.619000ns)
signal bh7_w11_1 :  std_logic;
   -- timing of bh7_w11_1: (c0, 0.619000ns)
signal bh7_w12_1 :  std_logic;
   -- timing of bh7_w12_1: (c0, 0.619000ns)
signal t8_tile_2_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_2_X: (c0, 0.000000ns)
signal t8_tile_2_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_2_Y: (c0, 0.000000ns)
signal t8_tile_2_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_2_output: (c0, 0.619000ns)
signal t8_tile_2_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_2_filtered_output: (c0, 0.619000ns)
signal bh7_w7_1 :  std_logic;
   -- timing of bh7_w7_1: (c0, 0.619000ns)
signal bh7_w8_1 :  std_logic;
   -- timing of bh7_w8_1: (c0, 0.619000ns)
signal bh7_w9_1 :  std_logic;
   -- timing of bh7_w9_1: (c0, 0.619000ns)
signal bh7_w10_2 :  std_logic;
   -- timing of bh7_w10_2: (c0, 0.619000ns)
signal bh7_w11_2 :  std_logic;
   -- timing of bh7_w11_2: (c0, 0.619000ns)
signal bh7_w12_2 :  std_logic;
   -- timing of bh7_w12_2: (c0, 0.619000ns)
signal t8_tile_3_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_3_X: (c0, 0.000000ns)
signal t8_tile_3_Y :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_3_Y: (c0, 0.000000ns)
signal t8_tile_3_output :  std_logic_vector(4 downto 0);
   -- timing of t8_tile_3_output: (c0, 0.543000ns)
signal t8_tile_3_filtered_output :  unsigned(4-0 downto 0);
   -- timing of t8_tile_3_filtered_output: (c0, 0.543000ns)
signal bh7_w5_0 :  std_logic;
   -- timing of bh7_w5_0: (c0, 0.543000ns)
signal bh7_w6_0 :  std_logic;
   -- timing of bh7_w6_0: (c0, 0.543000ns)
signal bh7_w7_2 :  std_logic;
   -- timing of bh7_w7_2: (c0, 0.543000ns)
signal bh7_w8_2 :  std_logic;
   -- timing of bh7_w8_2: (c0, 0.543000ns)
signal bh7_w9_2 :  std_logic;
   -- timing of bh7_w9_2: (c0, 0.543000ns)
signal t8_tile_4_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_4_X: (c0, 0.000000ns)
signal t8_tile_4_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_4_Y: (c0, 0.000000ns)
signal t8_tile_4_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_4_output: (c0, 0.619000ns)
signal t8_tile_4_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_4_filtered_output: (c0, 0.619000ns)
signal bh7_w4_0 :  std_logic;
   -- timing of bh7_w4_0: (c0, 0.619000ns)
signal bh7_w5_1 :  std_logic;
   -- timing of bh7_w5_1: (c0, 0.619000ns)
signal bh7_w6_1 :  std_logic;
   -- timing of bh7_w6_1: (c0, 0.619000ns)
signal bh7_w7_3 :  std_logic;
   -- timing of bh7_w7_3: (c0, 0.619000ns)
signal bh7_w8_3 :  std_logic;
   -- timing of bh7_w8_3: (c0, 0.619000ns)
signal bh7_w9_3 :  std_logic;
   -- timing of bh7_w9_3: (c0, 0.619000ns)
signal t8_tile_5_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_5_X: (c0, 0.000000ns)
signal t8_tile_5_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_5_Y: (c0, 0.000000ns)
signal t8_tile_5_output :  std_logic_vector(4 downto 0);
   -- timing of t8_tile_5_output: (c0, 0.543000ns)
signal t8_tile_5_filtered_output :  unsigned(4-0 downto 0);
   -- timing of t8_tile_5_filtered_output: (c0, 0.543000ns)
signal bh7_w5_2 :  std_logic;
   -- timing of bh7_w5_2: (c0, 0.543000ns)
signal bh7_w6_2 :  std_logic;
   -- timing of bh7_w6_2: (c0, 0.543000ns)
signal bh7_w7_4 :  std_logic;
   -- timing of bh7_w7_4: (c0, 0.543000ns)
signal bh7_w8_4 :  std_logic;
   -- timing of bh7_w8_4: (c0, 0.543000ns)
signal bh7_w9_4 :  std_logic;
   -- timing of bh7_w9_4: (c0, 0.543000ns)
signal t8_tile_6_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_6_X: (c0, 0.000000ns)
signal t8_tile_6_Y :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_6_Y: (c0, 0.000000ns)
signal t8_tile_6_output :  std_logic_vector(4 downto 0);
   -- timing of t8_tile_6_output: (c0, 0.543000ns)
signal t8_tile_6_filtered_output :  unsigned(4-0 downto 0);
   -- timing of t8_tile_6_filtered_output: (c0, 0.543000ns)
signal bh7_w2_0 :  std_logic;
   -- timing of bh7_w2_0: (c0, 0.543000ns)
signal bh7_w3_0 :  std_logic;
   -- timing of bh7_w3_0: (c0, 0.543000ns)
signal bh7_w4_1 :  std_logic;
   -- timing of bh7_w4_1: (c0, 0.543000ns)
signal bh7_w5_3 :  std_logic;
   -- timing of bh7_w5_3: (c0, 0.543000ns)
signal bh7_w6_3 :  std_logic;
   -- timing of bh7_w6_3: (c0, 0.543000ns)
signal t8_tile_7_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_7_X: (c0, 0.000000ns)
signal t8_tile_7_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_7_Y: (c0, 0.000000ns)
signal t8_tile_7_output :  std_logic_vector(4 downto 0);
   -- timing of t8_tile_7_output: (c0, 0.543000ns)
signal t8_tile_7_filtered_output :  unsigned(4-0 downto 0);
   -- timing of t8_tile_7_filtered_output: (c0, 0.543000ns)
signal bh7_w2_1 :  std_logic;
   -- timing of bh7_w2_1: (c0, 0.543000ns)
signal bh7_w3_1 :  std_logic;
   -- timing of bh7_w3_1: (c0, 0.543000ns)
signal bh7_w4_2 :  std_logic;
   -- timing of bh7_w4_2: (c0, 0.543000ns)
signal bh7_w5_4 :  std_logic;
   -- timing of bh7_w5_4: (c0, 0.543000ns)
signal bh7_w6_4 :  std_logic;
   -- timing of bh7_w6_4: (c0, 0.543000ns)
signal t8_tile_8_X :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_8_X: (c0, 0.000000ns)
signal t8_tile_8_Y :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_8_Y: (c0, 0.000000ns)
signal t8_tile_8_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_8_output: (c0, 0.543000ns)
signal t8_tile_8_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_8_filtered_output: (c0, 0.543000ns)
signal bh7_w1_0 :  std_logic;
   -- timing of bh7_w1_0: (c0, 0.543000ns)
signal bh7_w2_2 :  std_logic;
   -- timing of bh7_w2_2: (c0, 0.543000ns)
signal t8_tile_9_X :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_9_X: (c0, 0.000000ns)
signal t8_tile_9_Y :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_9_Y: (c0, 0.000000ns)
signal t8_tile_9_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_9_output: (c0, 0.543000ns)
signal t8_tile_9_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_9_filtered_output: (c0, 0.543000ns)
signal bh7_w0_0 :  std_logic;
   -- timing of bh7_w0_0: (c0, 0.543000ns)
signal bh7_w1_1 :  std_logic;
   -- timing of bh7_w1_1: (c0, 0.543000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid56_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid56_In0: (c0, 0.543000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid56_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid56_In1: (c0, 0.543000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid56_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid56_Out0: (c0, 1.086000ns)
signal bh7_w0_1 :  std_logic;
   -- timing of bh7_w0_1: (c0, 1.086000ns)
signal bh7_w1_2 :  std_logic;
   -- timing of bh7_w1_2: (c0, 1.086000ns)
signal bh7_w2_3 :  std_logic;
   -- timing of bh7_w2_3: (c0, 1.086000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid56_Out0_copy57 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid56_Out0_copy57: (c0, 0.543000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid58_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid58_In0: (c0, 0.543000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid58_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid58_In1: (c0, 0.543000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid58_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid58_Out0: (c0, 1.086000ns)
signal bh7_w2_4 :  std_logic;
   -- timing of bh7_w2_4: (c0, 1.086000ns)
signal bh7_w3_2 :  std_logic;
   -- timing of bh7_w3_2: (c0, 1.086000ns)
signal bh7_w4_3 :  std_logic;
   -- timing of bh7_w4_3: (c0, 1.086000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid58_Out0_copy59 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid58_Out0_copy59: (c0, 0.543000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid62_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid62_In0: (c0, 0.619000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid62_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid62_Out0: (c0, 1.162000ns)
signal bh7_w4_4 :  std_logic;
   -- timing of bh7_w4_4: (c0, 1.162000ns)
signal bh7_w5_5 :  std_logic;
   -- timing of bh7_w5_5: (c0, 1.162000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid62_Out0_copy63 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid62_Out0_copy63: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid66_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid66_In0: (c0, 0.543000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid66_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid66_In1: (c0, 0.543000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid66_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid66_Out0: (c0, 1.086000ns)
signal bh7_w5_6 :  std_logic;
   -- timing of bh7_w5_6: (c0, 1.086000ns)
signal bh7_w6_5 :  std_logic;
   -- timing of bh7_w6_5: (c0, 1.086000ns)
signal bh7_w7_5 :  std_logic;
   -- timing of bh7_w7_5: (c0, 1.086000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid66_Out0_copy67 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid66_Out0_copy67: (c0, 0.543000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid68_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid68_In0: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid68_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid68_In1: (c0, 0.543000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid68_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid68_Out0: (c0, 1.162000ns)
signal bh7_w6_6 :  std_logic;
   -- timing of bh7_w6_6: (c0, 1.162000ns)
signal bh7_w7_6 :  std_logic;
   -- timing of bh7_w7_6: (c0, 1.162000ns)
signal bh7_w8_5 :  std_logic;
   -- timing of bh7_w8_5: (c0, 1.162000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid68_Out0_copy69 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid68_Out0_copy69: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid70_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid70_In0: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid70_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid70_In1: (c0, 0.543000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid70_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid70_Out0: (c0, 1.162000ns)
signal bh7_w7_7 :  std_logic;
   -- timing of bh7_w7_7: (c0, 1.162000ns)
signal bh7_w8_6 :  std_logic;
   -- timing of bh7_w8_6: (c0, 1.162000ns)
signal bh7_w9_5 :  std_logic;
   -- timing of bh7_w9_5: (c0, 1.162000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid70_Out0_copy71 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid70_Out0_copy71: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid72_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid72_In0: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid72_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid72_In1: (c0, 0.543000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid72_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid72_Out0: (c0, 1.162000ns)
signal bh7_w8_7 :  std_logic;
   -- timing of bh7_w8_7: (c0, 1.162000ns)
signal bh7_w9_6 :  std_logic;
   -- timing of bh7_w9_6: (c0, 1.162000ns)
signal bh7_w10_3 :  std_logic;
   -- timing of bh7_w10_3: (c0, 1.162000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid72_Out0_copy73 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid72_Out0_copy73: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid74_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid74_In0: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid74_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid74_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid74_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid74_Out0: (c0, 1.162000ns)
signal bh7_w9_7 :  std_logic;
   -- timing of bh7_w9_7: (c0, 1.162000ns)
signal bh7_w10_4 :  std_logic;
   -- timing of bh7_w10_4: (c0, 1.162000ns)
signal bh7_w11_3 :  std_logic;
   -- timing of bh7_w11_3: (c0, 1.162000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid74_Out0_copy75 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid74_Out0_copy75: (c0, 0.619000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid76_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid76_In0: (c0, 0.619000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid76_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid76_Out0: (c0, 1.162000ns)
signal bh7_w10_5 :  std_logic;
   -- timing of bh7_w10_5: (c0, 1.162000ns)
signal bh7_w11_4 :  std_logic;
   -- timing of bh7_w11_4: (c0, 1.162000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid76_Out0_copy77 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid76_Out0_copy77: (c0, 0.619000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid78_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid78_In0: (c0, 0.619000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid78_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid78_In1: (c0, 0.619000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid78_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid78_Out0: (c0, 1.162000ns)
signal bh7_w11_5 :  std_logic;
   -- timing of bh7_w11_5: (c0, 1.162000ns)
signal bh7_w12_3 :  std_logic;
   -- timing of bh7_w12_3: (c0, 1.162000ns)
signal bh7_w13_1 :  std_logic;
   -- timing of bh7_w13_1: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid78_Out0_copy79 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid78_Out0_copy79: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid80_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid80_In0: (c0, 1.086000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid80_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid80_In1: (c0, 1.086000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid80_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid80_Out0: (c0, 1.629000ns)
signal bh7_w2_5 :  std_logic;
   -- timing of bh7_w2_5: (c0, 1.629000ns)
signal bh7_w3_3 :  std_logic;
   -- timing of bh7_w3_3: (c0, 1.629000ns)
signal bh7_w4_5 :  std_logic;
   -- timing of bh7_w4_5: (c0, 1.629000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid80_Out0_copy81 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid80_Out0_copy81: (c0, 1.086000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid82_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid82_In0: (c0, 1.162000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid82_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid82_Out0: (c0, 1.705000ns)
signal bh7_w4_6 :  std_logic;
   -- timing of bh7_w4_6: (c0, 1.705000ns)
signal bh7_w5_7 :  std_logic;
   -- timing of bh7_w5_7: (c0, 1.705000ns)
signal Compressor_3_2_Freq100_uid61_bh7_uid82_Out0_copy83 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq100_uid61_bh7_uid82_Out0_copy83: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid84_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid84_In0: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid84_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid84_In1: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid84_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid84_Out0: (c0, 1.705000ns)
signal bh7_w5_8 :  std_logic;
   -- timing of bh7_w5_8: (c0, 1.705000ns)
signal bh7_w6_7 :  std_logic;
   -- timing of bh7_w6_7: (c0, 1.705000ns)
signal bh7_w7_8 :  std_logic;
   -- timing of bh7_w7_8: (c0, 1.705000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid84_Out0_copy85 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid84_Out0_copy85: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid86_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid86_In0: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid86_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid86_In1: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid86_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid86_Out0: (c0, 1.705000ns)
signal bh7_w7_9 :  std_logic;
   -- timing of bh7_w7_9: (c0, 1.705000ns)
signal bh7_w8_8 :  std_logic;
   -- timing of bh7_w8_8: (c0, 1.705000ns)
signal bh7_w9_8 :  std_logic;
   -- timing of bh7_w9_8: (c0, 1.705000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid86_Out0_copy87 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid86_Out0_copy87: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid88_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid88_In0: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid88_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid88_In1: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid88_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid88_Out0: (c0, 1.705000ns)
signal bh7_w9_9 :  std_logic;
   -- timing of bh7_w9_9: (c0, 1.705000ns)
signal bh7_w10_6 :  std_logic;
   -- timing of bh7_w10_6: (c0, 1.705000ns)
signal bh7_w11_6 :  std_logic;
   -- timing of bh7_w11_6: (c0, 1.705000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid88_Out0_copy89 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid88_Out0_copy89: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid90_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid90_In0: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid90_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid90_In1: (c0, 1.162000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid90_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid90_Out0: (c0, 1.705000ns)
signal bh7_w11_7 :  std_logic;
   -- timing of bh7_w11_7: (c0, 1.705000ns)
signal bh7_w12_4 :  std_logic;
   -- timing of bh7_w12_4: (c0, 1.705000ns)
signal bh7_w13_2 :  std_logic;
   -- timing of bh7_w13_2: (c0, 1.705000ns)
signal Compressor_23_3_Freq100_uid55_bh7_uid90_Out0_copy91 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq100_uid55_bh7_uid90_Out0_copy91: (c0, 1.162000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid92_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid92_In0: (c0, 1.162000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid92_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid92_In1: (c0, 0.619000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid92_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid92_Out0: (c0, 1.705000ns)
signal bh7_w13_3 :  std_logic;
   -- timing of bh7_w13_3: (c0, 1.705000ns)
signal bh7_w14_1 :  std_logic;
   -- timing of bh7_w14_1: (c0, 1.705000ns)
signal bh7_w15_1 :  std_logic;
   -- timing of bh7_w15_1: (c0, 1.705000ns)
signal Compressor_14_3_Freq100_uid65_bh7_uid92_Out0_copy93 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq100_uid65_bh7_uid92_Out0_copy93: (c0, 1.162000ns)
signal tmp_bitheapResult_bh7_3 :  std_logic_vector(3 downto 0);
   -- timing of tmp_bitheapResult_bh7_3: (c0, 1.629000ns)
signal bitheapFinalAdd_bh7_In0 :  std_logic_vector(11 downto 0);
   -- timing of bitheapFinalAdd_bh7_In0: (c0, 1.705000ns)
signal bitheapFinalAdd_bh7_In1 :  std_logic_vector(11 downto 0);
   -- timing of bitheapFinalAdd_bh7_In1: (c0, 1.705000ns)
signal bitheapFinalAdd_bh7_Cin :  std_logic;
   -- timing of bitheapFinalAdd_bh7_Cin: (c0, 0.000000ns)
signal bitheapFinalAdd_bh7_Out :  std_logic_vector(11 downto 0);
   -- timing of bitheapFinalAdd_bh7_Out: (c0, 2.846000ns)
signal bitheapResult_bh7 :  std_logic_vector(15 downto 0);
   -- timing of bitheapResult_bh7: (c0, 2.846000ns)
begin
   XX_m6 <= X ;
   YY_m6 <= Y ;
   t8_tile_0_X <= X(7 downto 5);
   t8_tile_0_Y <= Y(7 downto 5);
   t8_tile_0: IntMultiplierLUT_3x3_Freq100_uid10
      port map ( clk  => clk,
                 X => t8_tile_0_X,
                 Y => t8_tile_0_Y,
                 R => t8_tile_0_output);

   t8_tile_0_filtered_output <= unsigned(t8_tile_0_output(5 downto 0));
   bh7_w10_0 <= t8_tile_0_filtered_output(0);
   bh7_w11_0 <= t8_tile_0_filtered_output(1);
   bh7_w12_0 <= t8_tile_0_filtered_output(2);
   bh7_w13_0 <= t8_tile_0_filtered_output(3);
   bh7_w14_0 <= t8_tile_0_filtered_output(4);
   bh7_w15_0 <= t8_tile_0_filtered_output(5);
   t8_tile_1_X <= X(7 downto 5);
   t8_tile_1_Y <= Y(4 downto 2);
   t8_tile_1: IntMultiplierLUT_3x3_Freq100_uid15
      port map ( clk  => clk,
                 X => t8_tile_1_X,
                 Y => t8_tile_1_Y,
                 R => t8_tile_1_output);

   t8_tile_1_filtered_output <= unsigned(t8_tile_1_output(5 downto 0));
   bh7_w7_0 <= t8_tile_1_filtered_output(0);
   bh7_w8_0 <= t8_tile_1_filtered_output(1);
   bh7_w9_0 <= t8_tile_1_filtered_output(2);
   bh7_w10_1 <= t8_tile_1_filtered_output(3);
   bh7_w11_1 <= t8_tile_1_filtered_output(4);
   bh7_w12_1 <= t8_tile_1_filtered_output(5);
   t8_tile_2_X <= X(4 downto 2);
   t8_tile_2_Y <= Y(7 downto 5);
   t8_tile_2: IntMultiplierLUT_3x3_Freq100_uid20
      port map ( clk  => clk,
                 X => t8_tile_2_X,
                 Y => t8_tile_2_Y,
                 R => t8_tile_2_output);

   t8_tile_2_filtered_output <= unsigned(t8_tile_2_output(5 downto 0));
   bh7_w7_1 <= t8_tile_2_filtered_output(0);
   bh7_w8_1 <= t8_tile_2_filtered_output(1);
   bh7_w9_1 <= t8_tile_2_filtered_output(2);
   bh7_w10_2 <= t8_tile_2_filtered_output(3);
   bh7_w11_2 <= t8_tile_2_filtered_output(4);
   bh7_w12_2 <= t8_tile_2_filtered_output(5);
   t8_tile_3_X <= X(7 downto 5);
   t8_tile_3_Y <= Y(1 downto 0);
   t8_tile_3: IntMultiplierLUT_3x2_Freq100_uid25
      port map ( clk  => clk,
                 X => t8_tile_3_X,
                 Y => t8_tile_3_Y,
                 R => t8_tile_3_output);

   t8_tile_3_filtered_output <= unsigned(t8_tile_3_output(4 downto 0));
   bh7_w5_0 <= t8_tile_3_filtered_output(0);
   bh7_w6_0 <= t8_tile_3_filtered_output(1);
   bh7_w7_2 <= t8_tile_3_filtered_output(2);
   bh7_w8_2 <= t8_tile_3_filtered_output(3);
   bh7_w9_2 <= t8_tile_3_filtered_output(4);
   t8_tile_4_X <= X(4 downto 2);
   t8_tile_4_Y <= Y(4 downto 2);
   t8_tile_4: IntMultiplierLUT_3x3_Freq100_uid30
      port map ( clk  => clk,
                 X => t8_tile_4_X,
                 Y => t8_tile_4_Y,
                 R => t8_tile_4_output);

   t8_tile_4_filtered_output <= unsigned(t8_tile_4_output(5 downto 0));
   bh7_w4_0 <= t8_tile_4_filtered_output(0);
   bh7_w5_1 <= t8_tile_4_filtered_output(1);
   bh7_w6_1 <= t8_tile_4_filtered_output(2);
   bh7_w7_3 <= t8_tile_4_filtered_output(3);
   bh7_w8_3 <= t8_tile_4_filtered_output(4);
   bh7_w9_3 <= t8_tile_4_filtered_output(5);
   t8_tile_5_X <= X(1 downto 0);
   t8_tile_5_Y <= Y(7 downto 5);
   t8_tile_5: IntMultiplierLUT_2x3_Freq100_uid35
      port map ( clk  => clk,
                 X => t8_tile_5_X,
                 Y => t8_tile_5_Y,
                 R => t8_tile_5_output);

   t8_tile_5_filtered_output <= unsigned(t8_tile_5_output(4 downto 0));
   bh7_w5_2 <= t8_tile_5_filtered_output(0);
   bh7_w6_2 <= t8_tile_5_filtered_output(1);
   bh7_w7_4 <= t8_tile_5_filtered_output(2);
   bh7_w8_4 <= t8_tile_5_filtered_output(3);
   bh7_w9_4 <= t8_tile_5_filtered_output(4);
   t8_tile_6_X <= X(4 downto 2);
   t8_tile_6_Y <= Y(1 downto 0);
   t8_tile_6: IntMultiplierLUT_3x2_Freq100_uid40
      port map ( clk  => clk,
                 X => t8_tile_6_X,
                 Y => t8_tile_6_Y,
                 R => t8_tile_6_output);

   t8_tile_6_filtered_output <= unsigned(t8_tile_6_output(4 downto 0));
   bh7_w2_0 <= t8_tile_6_filtered_output(0);
   bh7_w3_0 <= t8_tile_6_filtered_output(1);
   bh7_w4_1 <= t8_tile_6_filtered_output(2);
   bh7_w5_3 <= t8_tile_6_filtered_output(3);
   bh7_w6_3 <= t8_tile_6_filtered_output(4);
   t8_tile_7_X <= X(1 downto 0);
   t8_tile_7_Y <= Y(4 downto 2);
   t8_tile_7: IntMultiplierLUT_2x3_Freq100_uid45
      port map ( clk  => clk,
                 X => t8_tile_7_X,
                 Y => t8_tile_7_Y,
                 R => t8_tile_7_output);

   t8_tile_7_filtered_output <= unsigned(t8_tile_7_output(4 downto 0));
   bh7_w2_1 <= t8_tile_7_filtered_output(0);
   bh7_w3_1 <= t8_tile_7_filtered_output(1);
   bh7_w4_2 <= t8_tile_7_filtered_output(2);
   bh7_w5_4 <= t8_tile_7_filtered_output(3);
   bh7_w6_4 <= t8_tile_7_filtered_output(4);
   t8_tile_8_X <= X(1 downto 1);
   t8_tile_8_Y <= Y(1 downto 0);
   t8_tile_8: IntMultiplierLUT_1x2_Freq100_uid50
      port map ( clk  => clk,
                 X => t8_tile_8_X,
                 Y => t8_tile_8_Y,
                 R => t8_tile_8_output);

   t8_tile_8_filtered_output <= unsigned(t8_tile_8_output(1 downto 0));
   bh7_w1_0 <= t8_tile_8_filtered_output(0);
   bh7_w2_2 <= t8_tile_8_filtered_output(1);
   t8_tile_9_X <= X(0 downto 0);
   t8_tile_9_Y <= Y(1 downto 0);
   t8_tile_9: IntMultiplierLUT_1x2_Freq100_uid52
      port map ( clk  => clk,
                 X => t8_tile_9_X,
                 Y => t8_tile_9_Y,
                 R => t8_tile_9_output);

   t8_tile_9_filtered_output <= unsigned(t8_tile_9_output(1 downto 0));
   bh7_w0_0 <= t8_tile_9_filtered_output(0);
   bh7_w1_1 <= t8_tile_9_filtered_output(1);

   -- Adding the constant bits 
      -- All the constant bits are zero, nothing to add


   Compressor_23_3_Freq100_uid55_bh7_uid56_In0 <= "" & bh7_w0_0 & "0" & "0";
   Compressor_23_3_Freq100_uid55_bh7_uid56_In1 <= "" & bh7_w1_0 & bh7_w1_1;
   bh7_w0_1 <= Compressor_23_3_Freq100_uid55_bh7_uid56_Out0(0);
   bh7_w1_2 <= Compressor_23_3_Freq100_uid55_bh7_uid56_Out0(1);
   bh7_w2_3 <= Compressor_23_3_Freq100_uid55_bh7_uid56_Out0(2);
   Compressor_23_3_Freq100_uid55_uid56: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid56_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid56_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid56_Out0_copy57);
   Compressor_23_3_Freq100_uid55_bh7_uid56_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid56_Out0_copy57; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq100_uid55_bh7_uid58_In0 <= "" & bh7_w2_0 & bh7_w2_1 & bh7_w2_2;
   Compressor_23_3_Freq100_uid55_bh7_uid58_In1 <= "" & bh7_w3_0 & bh7_w3_1;
   bh7_w2_4 <= Compressor_23_3_Freq100_uid55_bh7_uid58_Out0(0);
   bh7_w3_2 <= Compressor_23_3_Freq100_uid55_bh7_uid58_Out0(1);
   bh7_w4_3 <= Compressor_23_3_Freq100_uid55_bh7_uid58_Out0(2);
   Compressor_23_3_Freq100_uid55_uid58: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid58_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid58_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid58_Out0_copy59);
   Compressor_23_3_Freq100_uid55_bh7_uid58_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid58_Out0_copy59; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq100_uid61_bh7_uid62_In0 <= "" & bh7_w4_1 & bh7_w4_2 & bh7_w4_0;
   bh7_w4_4 <= Compressor_3_2_Freq100_uid61_bh7_uid62_Out0(0);
   bh7_w5_5 <= Compressor_3_2_Freq100_uid61_bh7_uid62_Out0(1);
   Compressor_3_2_Freq100_uid61_uid62: Compressor_3_2_Freq100_uid61
      port map ( X0 => Compressor_3_2_Freq100_uid61_bh7_uid62_In0,
                 R => Compressor_3_2_Freq100_uid61_bh7_uid62_Out0_copy63);
   Compressor_3_2_Freq100_uid61_bh7_uid62_Out0 <= Compressor_3_2_Freq100_uid61_bh7_uid62_Out0_copy63; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid66_In0 <= "" & bh7_w5_0 & bh7_w5_2 & bh7_w5_3 & bh7_w5_4;
   Compressor_14_3_Freq100_uid65_bh7_uid66_In1 <= "" & bh7_w6_0;
   bh7_w5_6 <= Compressor_14_3_Freq100_uid65_bh7_uid66_Out0(0);
   bh7_w6_5 <= Compressor_14_3_Freq100_uid65_bh7_uid66_Out0(1);
   bh7_w7_5 <= Compressor_14_3_Freq100_uid65_bh7_uid66_Out0(2);
   Compressor_14_3_Freq100_uid65_uid66: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid66_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid66_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid66_Out0_copy67);
   Compressor_14_3_Freq100_uid65_bh7_uid66_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid66_Out0_copy67; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid68_In0 <= "" & bh7_w6_2 & bh7_w6_3 & bh7_w6_4 & bh7_w6_1;
   Compressor_14_3_Freq100_uid65_bh7_uid68_In1 <= "" & bh7_w7_2;
   bh7_w6_6 <= Compressor_14_3_Freq100_uid65_bh7_uid68_Out0(0);
   bh7_w7_6 <= Compressor_14_3_Freq100_uid65_bh7_uid68_Out0(1);
   bh7_w8_5 <= Compressor_14_3_Freq100_uid65_bh7_uid68_Out0(2);
   Compressor_14_3_Freq100_uid65_uid68: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid68_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid68_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid68_Out0_copy69);
   Compressor_14_3_Freq100_uid65_bh7_uid68_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid68_Out0_copy69; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid70_In0 <= "" & bh7_w7_4 & bh7_w7_0 & bh7_w7_1 & bh7_w7_3;
   Compressor_14_3_Freq100_uid65_bh7_uid70_In1 <= "" & bh7_w8_2;
   bh7_w7_7 <= Compressor_14_3_Freq100_uid65_bh7_uid70_Out0(0);
   bh7_w8_6 <= Compressor_14_3_Freq100_uid65_bh7_uid70_Out0(1);
   bh7_w9_5 <= Compressor_14_3_Freq100_uid65_bh7_uid70_Out0(2);
   Compressor_14_3_Freq100_uid65_uid70: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid70_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid70_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid70_Out0_copy71);
   Compressor_14_3_Freq100_uid65_bh7_uid70_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid70_Out0_copy71; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid72_In0 <= "" & bh7_w8_4 & bh7_w8_0 & bh7_w8_1 & bh7_w8_3;
   Compressor_14_3_Freq100_uid65_bh7_uid72_In1 <= "" & bh7_w9_2;
   bh7_w8_7 <= Compressor_14_3_Freq100_uid65_bh7_uid72_Out0(0);
   bh7_w9_6 <= Compressor_14_3_Freq100_uid65_bh7_uid72_Out0(1);
   bh7_w10_3 <= Compressor_14_3_Freq100_uid65_bh7_uid72_Out0(2);
   Compressor_14_3_Freq100_uid65_uid72: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid72_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid72_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid72_Out0_copy73);
   Compressor_14_3_Freq100_uid65_bh7_uid72_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid72_Out0_copy73; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid74_In0 <= "" & bh7_w9_4 & bh7_w9_0 & bh7_w9_1 & bh7_w9_3;
   Compressor_14_3_Freq100_uid65_bh7_uid74_In1 <= "" & "0";
   bh7_w9_7 <= Compressor_14_3_Freq100_uid65_bh7_uid74_Out0(0);
   bh7_w10_4 <= Compressor_14_3_Freq100_uid65_bh7_uid74_Out0(1);
   bh7_w11_3 <= Compressor_14_3_Freq100_uid65_bh7_uid74_Out0(2);
   Compressor_14_3_Freq100_uid65_uid74: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid74_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid74_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid74_Out0_copy75);
   Compressor_14_3_Freq100_uid65_bh7_uid74_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid74_Out0_copy75; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq100_uid61_bh7_uid76_In0 <= "" & bh7_w10_0 & bh7_w10_1 & bh7_w10_2;
   bh7_w10_5 <= Compressor_3_2_Freq100_uid61_bh7_uid76_Out0(0);
   bh7_w11_4 <= Compressor_3_2_Freq100_uid61_bh7_uid76_Out0(1);
   Compressor_3_2_Freq100_uid61_uid76: Compressor_3_2_Freq100_uid61
      port map ( X0 => Compressor_3_2_Freq100_uid61_bh7_uid76_In0,
                 R => Compressor_3_2_Freq100_uid61_bh7_uid76_Out0_copy77);
   Compressor_3_2_Freq100_uid61_bh7_uid76_Out0 <= Compressor_3_2_Freq100_uid61_bh7_uid76_Out0_copy77; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq100_uid55_bh7_uid78_In0 <= "" & bh7_w11_0 & bh7_w11_1 & bh7_w11_2;
   Compressor_23_3_Freq100_uid55_bh7_uid78_In1 <= "" & bh7_w12_0 & bh7_w12_1;
   bh7_w11_5 <= Compressor_23_3_Freq100_uid55_bh7_uid78_Out0(0);
   bh7_w12_3 <= Compressor_23_3_Freq100_uid55_bh7_uid78_Out0(1);
   bh7_w13_1 <= Compressor_23_3_Freq100_uid55_bh7_uid78_Out0(2);
   Compressor_23_3_Freq100_uid55_uid78: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid78_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid78_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid78_Out0_copy79);
   Compressor_23_3_Freq100_uid55_bh7_uid78_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid78_Out0_copy79; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid80_In0 <= "" & bh7_w2_4 & bh7_w2_3 & "0" & "0";
   Compressor_14_3_Freq100_uid65_bh7_uid80_In1 <= "" & bh7_w3_2;
   bh7_w2_5 <= Compressor_14_3_Freq100_uid65_bh7_uid80_Out0(0);
   bh7_w3_3 <= Compressor_14_3_Freq100_uid65_bh7_uid80_Out0(1);
   bh7_w4_5 <= Compressor_14_3_Freq100_uid65_bh7_uid80_Out0(2);
   Compressor_14_3_Freq100_uid65_uid80: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid80_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid80_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid80_Out0_copy81);
   Compressor_14_3_Freq100_uid65_bh7_uid80_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid80_Out0_copy81; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq100_uid61_bh7_uid82_In0 <= "" & bh7_w4_3 & bh7_w4_4 & "0";
   bh7_w4_6 <= Compressor_3_2_Freq100_uid61_bh7_uid82_Out0(0);
   bh7_w5_7 <= Compressor_3_2_Freq100_uid61_bh7_uid82_Out0(1);
   Compressor_3_2_Freq100_uid61_uid82: Compressor_3_2_Freq100_uid61
      port map ( X0 => Compressor_3_2_Freq100_uid61_bh7_uid82_In0,
                 R => Compressor_3_2_Freq100_uid61_bh7_uid82_Out0_copy83);
   Compressor_3_2_Freq100_uid61_bh7_uid82_Out0 <= Compressor_3_2_Freq100_uid61_bh7_uid82_Out0_copy83; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq100_uid55_bh7_uid84_In0 <= "" & bh7_w5_1 & bh7_w5_6 & bh7_w5_5;
   Compressor_23_3_Freq100_uid55_bh7_uid84_In1 <= "" & bh7_w6_5 & bh7_w6_6;
   bh7_w5_8 <= Compressor_23_3_Freq100_uid55_bh7_uid84_Out0(0);
   bh7_w6_7 <= Compressor_23_3_Freq100_uid55_bh7_uid84_Out0(1);
   bh7_w7_8 <= Compressor_23_3_Freq100_uid55_bh7_uid84_Out0(2);
   Compressor_23_3_Freq100_uid55_uid84: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid84_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid84_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid84_Out0_copy85);
   Compressor_23_3_Freq100_uid55_bh7_uid84_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid84_Out0_copy85; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq100_uid55_bh7_uid86_In0 <= "" & bh7_w7_5 & bh7_w7_7 & bh7_w7_6;
   Compressor_23_3_Freq100_uid55_bh7_uid86_In1 <= "" & bh7_w8_7 & bh7_w8_6;
   bh7_w7_9 <= Compressor_23_3_Freq100_uid55_bh7_uid86_Out0(0);
   bh7_w8_8 <= Compressor_23_3_Freq100_uid55_bh7_uid86_Out0(1);
   bh7_w9_8 <= Compressor_23_3_Freq100_uid55_bh7_uid86_Out0(2);
   Compressor_23_3_Freq100_uid55_uid86: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid86_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid86_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid86_Out0_copy87);
   Compressor_23_3_Freq100_uid55_bh7_uid86_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid86_Out0_copy87; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq100_uid55_bh7_uid88_In0 <= "" & bh7_w9_7 & bh7_w9_6 & bh7_w9_5;
   Compressor_23_3_Freq100_uid55_bh7_uid88_In1 <= "" & bh7_w10_4 & bh7_w10_5;
   bh7_w9_9 <= Compressor_23_3_Freq100_uid55_bh7_uid88_Out0(0);
   bh7_w10_6 <= Compressor_23_3_Freq100_uid55_bh7_uid88_Out0(1);
   bh7_w11_6 <= Compressor_23_3_Freq100_uid55_bh7_uid88_Out0(2);
   Compressor_23_3_Freq100_uid55_uid88: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid88_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid88_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid88_Out0_copy89);
   Compressor_23_3_Freq100_uid55_bh7_uid88_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid88_Out0_copy89; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq100_uid55_bh7_uid90_In0 <= "" & bh7_w11_3 & bh7_w11_5 & bh7_w11_4;
   Compressor_23_3_Freq100_uid55_bh7_uid90_In1 <= "" & bh7_w12_2 & bh7_w12_3;
   bh7_w11_7 <= Compressor_23_3_Freq100_uid55_bh7_uid90_Out0(0);
   bh7_w12_4 <= Compressor_23_3_Freq100_uid55_bh7_uid90_Out0(1);
   bh7_w13_2 <= Compressor_23_3_Freq100_uid55_bh7_uid90_Out0(2);
   Compressor_23_3_Freq100_uid55_uid90: Compressor_23_3_Freq100_uid55
      port map ( X0 => Compressor_23_3_Freq100_uid55_bh7_uid90_In0,
                 X1 => Compressor_23_3_Freq100_uid55_bh7_uid90_In1,
                 R => Compressor_23_3_Freq100_uid55_bh7_uid90_Out0_copy91);
   Compressor_23_3_Freq100_uid55_bh7_uid90_Out0 <= Compressor_23_3_Freq100_uid55_bh7_uid90_Out0_copy91; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq100_uid65_bh7_uid92_In0 <= "" & bh7_w13_0 & bh7_w13_1 & "0" & "0";
   Compressor_14_3_Freq100_uid65_bh7_uid92_In1 <= "" & bh7_w14_0;
   bh7_w13_3 <= Compressor_14_3_Freq100_uid65_bh7_uid92_Out0(0);
   bh7_w14_1 <= Compressor_14_3_Freq100_uid65_bh7_uid92_Out0(1);
   bh7_w15_1 <= Compressor_14_3_Freq100_uid65_bh7_uid92_Out0(2);
   Compressor_14_3_Freq100_uid65_uid92: Compressor_14_3_Freq100_uid65
      port map ( X0 => Compressor_14_3_Freq100_uid65_bh7_uid92_In0,
                 X1 => Compressor_14_3_Freq100_uid65_bh7_uid92_In1,
                 R => Compressor_14_3_Freq100_uid65_bh7_uid92_Out0_copy93);
   Compressor_14_3_Freq100_uid65_bh7_uid92_Out0 <= Compressor_14_3_Freq100_uid65_bh7_uid92_Out0_copy93; -- output copy to hold a pipeline register if needed

   tmp_bitheapResult_bh7_3 <= bh7_w3_3 & bh7_w2_5 & bh7_w1_2 & bh7_w0_1;

   bitheapFinalAdd_bh7_In0 <= "" & bh7_w15_0 & bh7_w14_1 & bh7_w13_2 & bh7_w12_4 & bh7_w11_6 & bh7_w10_6 & bh7_w9_9 & bh7_w8_5 & bh7_w7_9 & bh7_w6_7 & bh7_w5_8 & bh7_w4_5;
   bitheapFinalAdd_bh7_In1 <= "" & bh7_w15_1 & "0" & bh7_w13_3 & "0" & bh7_w11_7 & bh7_w10_3 & bh7_w9_8 & bh7_w8_8 & bh7_w7_8 & "0" & bh7_w5_7 & bh7_w4_6;
   bitheapFinalAdd_bh7_Cin <= '0';

   bitheapFinalAdd_bh7: IntAdder_12_Freq100_uid95
      port map ( clk  => clk,
                 Cin => bitheapFinalAdd_bh7_Cin,
                 X => bitheapFinalAdd_bh7_In0,
                 Y => bitheapFinalAdd_bh7_In1,
                 R => bitheapFinalAdd_bh7_Out);
   bitheapResult_bh7 <= bitheapFinalAdd_bh7_Out(11 downto 0) & tmp_bitheapResult_bh7_3;
   R <= bitheapResult_bh7(15 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                         IntAdder_17_Freq100_uid98
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c0, 3.389000ns)Y: (c0, 0.000000ns)Cin: (c0, 4.499500ns)
--  approx. output signal timings: R: (c0, 5.689500ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_17_Freq100_uid98 is
    port (clk : in std_logic;
          X : in  std_logic_vector(16 downto 0);
          Y : in  std_logic_vector(16 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(16 downto 0)   );
end entity;

architecture arch of IntAdder_17_Freq100_uid98 is
signal Rtmp :  std_logic_vector(16 downto 0);
   -- timing of Rtmp: (c0, 5.689500ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                        FPMult_8_7_uid2_Freq100_uid3
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2021
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 10
-- Target frequency (MHz): 100
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 5.689500ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPMult_8_7_uid2_Freq100_uid3 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+7+2 downto 0);
          Y : in  std_logic_vector(8+7+2 downto 0);
          R : out  std_logic_vector(8+7+2 downto 0)   );
end entity;

architecture arch of FPMult_8_7_uid2_Freq100_uid3 is
   component IntMultiplier_8x8_16_Freq100_uid5 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(7 downto 0);
             Y : in  std_logic_vector(7 downto 0);
             R : out  std_logic_vector(15 downto 0)   );
   end component;

   component IntAdder_17_Freq100_uid98 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(16 downto 0);
             Y : in  std_logic_vector(16 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(16 downto 0)   );
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
signal sigX :  std_logic_vector(7 downto 0);
   -- timing of sigX: (c0, 0.000000ns)
signal sigY :  std_logic_vector(7 downto 0);
   -- timing of sigY: (c0, 0.000000ns)
signal sigProd :  std_logic_vector(15 downto 0);
   -- timing of sigProd: (c0, 2.846000ns)
signal excSel :  std_logic_vector(3 downto 0);
   -- timing of excSel: (c0, 0.000000ns)
signal exc :  std_logic_vector(1 downto 0);
   -- timing of exc: (c0, 0.043000ns)
signal norm :  std_logic;
   -- timing of norm: (c0, 2.846000ns)
signal expPostNorm :  std_logic_vector(9 downto 0);
   -- timing of expPostNorm: (c0, 2.846000ns)
signal sigProdExt :  std_logic_vector(15 downto 0);
   -- timing of sigProdExt: (c0, 3.389000ns)
signal expSig :  std_logic_vector(16 downto 0);
   -- timing of expSig: (c0, 3.389000ns)
signal sticky :  std_logic;
   -- timing of sticky: (c0, 3.389000ns)
signal guard :  std_logic;
   -- timing of guard: (c0, 3.956500ns)
signal round :  std_logic;
   -- timing of round: (c0, 4.499500ns)
signal expSigPostRound :  std_logic_vector(16 downto 0);
   -- timing of expSigPostRound: (c0, 5.689500ns)
signal excPostNorm :  std_logic_vector(1 downto 0);
   -- timing of excPostNorm: (c0, 5.689500ns)
signal finalExc :  std_logic_vector(1 downto 0);
   -- timing of finalExc: (c0, 5.689500ns)
begin
   sign <= X(15) xor Y(15);
   expX <= X(14 downto 7);
   expY <= Y(14 downto 7);
   expSumPreSub <= ("00" & expX) + ("00" & expY);
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub - bias;
   sigX <= "1" & X(6 downto 0);
   sigY <= "1" & Y(6 downto 0);
   SignificandMultiplication: IntMultiplier_8x8_16_Freq100_uid5
      port map ( clk  => clk,
                 X => sigX,
                 Y => sigY,
                 R => sigProd);
   excSel <= X(17 downto 16) & Y(17 downto 16);
   with excSel  select  
   exc <= "00" when  "0000" | "0001" | "0100", 
          "01" when "0101",
          "10" when "0110" | "1001" | "1010" ,
          "11" when others;
   norm <= sigProd(15);
   -- exponent update
   expPostNorm <= expSum + ("000000000" & norm);
   -- significand normalization shift
   sigProdExt <= sigProd(14 downto 0) & "0" when norm='1' else
                         sigProd(13 downto 0) & "00";
   expSig <= expPostNorm & sigProdExt(15 downto 9);
   sticky <= sigProdExt(8);
   guard <= '0' when sigProdExt(7 downto 0)="00000000" else '1';
   round <= sticky and ( (guard and not(sigProdExt(9))) or (sigProdExt(9) ))  ;
   RoundingAdder: IntAdder_17_Freq100_uid98
      port map ( clk  => clk,
                 Cin => round,
                 X => expSig,
                 Y => "00000000000000000",
                 R => expSigPostRound);
   with expSigPostRound(16 downto 15)  select 
   excPostNorm <=  "01"  when  "00",
                               "10"             when "01", 
                               "00"             when "11"|"10",
                               "11"             when others;
   with exc  select  
   finalExc <= exc when  "11"|"10"|"00",
                       excPostNorm when others; 
   R <= finalExc & sign & expSigPostRound(14 downto 0);
end architecture;

