--------------------------------------------------------------------------------
--                          MultTable_Freq200_uid14
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid14 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid14 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid19
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid19 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid19 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid24
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid24 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid24 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid31
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid31 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid31 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid36
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid36 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid36 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid43
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid43 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid43 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid48
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid48 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid48 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid57
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid57 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid57 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid62
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid62 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid62 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid69
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid69 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid69 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid74
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid74 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid74 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid83
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid83 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid83 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid88
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid88 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid88 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid95
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid95 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid95 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid100
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid100 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid100 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                          MultTable_Freq200_uid109
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X
-- Output signals: Y
--  approx. input signal timings: X: (c0, 0.000000ns)
--  approx. output signal timings: Y: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity MultTable_Freq200_uid109 is
    port (X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of MultTable_Freq200_uid109 is
signal Y0 :  std_logic_vector(5 downto 0);
   -- timing of Y0: (c0, 0.328000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
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
--                       Compressor_23_3_Freq200_uid117
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X1 X0
-- Output signals: R
--  approx. input signal timings: X1: (c0, 0.000000ns)X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_23_3_Freq200_uid117 is
    port (X1 : in  std_logic_vector(1 downto 0);
          X0 : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_23_3_Freq200_uid117 is
signal X :  std_logic_vector(4 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(2 downto 0);
   -- timing of R0: (c0, 0.215000ns)
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
--                       Compressor_14_3_Freq200_uid135
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X1 X0
-- Output signals: R
--  approx. input signal timings: X1: (c0, 0.000000ns)X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_14_3_Freq200_uid135 is
    port (X1 : in  std_logic_vector(0 downto 0);
          X0 : in  std_logic_vector(3 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_14_3_Freq200_uid135 is
signal X :  std_logic_vector(4 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(2 downto 0);
   -- timing of R0: (c0, 0.215000ns)
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
--                       Compressor_3_2_Freq200_uid141
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X0
-- Output signals: R
--  approx. input signal timings: X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_3_2_Freq200_uid141 is
    port (X0 : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of Compressor_3_2_Freq200_uid141 is
signal X :  std_logic_vector(2 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(1 downto 0);
   -- timing of R0: (c0, 0.215000ns)
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
--                       Compressor_6_3_Freq200_uid155
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X0
-- Output signals: R
--  approx. input signal timings: X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_6_3_Freq200_uid155 is
    port (X0 : in  std_logic_vector(5 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_6_3_Freq200_uid155 is
signal X :  std_logic_vector(5 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(2 downto 0);
   -- timing of R0: (c0, 0.328000ns)
begin
   X <= X0 ;

   with X  select  R0 <= 
      "000" when "000000",
      "001" when "000001" | "000010" | "000100" | "001000" | "010000" | "100000",
      "010" when "000011" | "000101" | "000110" | "001001" | "001010" | "001100" | "010001" | "010010" | "010100" | "011000" | "100001" | "100010" | "100100" | "101000" | "110000",
      "011" when "000111" | "001011" | "001101" | "001110" | "010011" | "010101" | "010110" | "011001" | "011010" | "011100" | "100011" | "100101" | "100110" | "101001" | "101010" | "101100" | "110001" | "110010" | "110100" | "111000",
      "100" when "001111" | "010111" | "011011" | "011101" | "011110" | "100111" | "101011" | "101101" | "101110" | "110011" | "110101" | "110110" | "111001" | "111010" | "111100",
      "101" when "011111" | "101111" | "110111" | "111011" | "111101" | "111110",
      "110" when "111111",
      "---" when others;
   R <= R0;
end architecture;

--------------------------------------------------------------------------------
--                       Compressor_5_3_Freq200_uid159
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X0
-- Output signals: R
--  approx. input signal timings: X0: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_5_3_Freq200_uid159 is
    port (X0 : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_5_3_Freq200_uid159 is
signal X :  std_logic_vector(4 downto 0);
   -- timing of X: (c0, 0.000000ns)
signal R0 :  std_logic_vector(2 downto 0);
   -- timing of R0: (c0, 0.215000ns)
begin
   X <= X0 ;

   with X  select  R0 <= 
      "000" when "00000",
      "001" when "00001" | "00010" | "00100" | "01000" | "10000",
      "010" when "00011" | "00101" | "00110" | "01001" | "01010" | "01100" | "10001" | "10010" | "10100" | "11000",
      "011" when "00111" | "01011" | "01101" | "01110" | "10011" | "10101" | "10110" | "11001" | "11010" | "11100",
      "100" when "01111" | "10111" | "11011" | "11101" | "11110",
      "101" when "11111",
      "---" when others;
   R <= R0;
end architecture;

--------------------------------------------------------------------------------
--                        DSPBlock_24x17_Freq200_uid10
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
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

entity DSPBlock_24x17_Freq200_uid10 is
    port (clk : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(16 downto 0);
          R : out  std_logic_vector(40 downto 0)   );
end entity;

architecture arch of DSPBlock_24x17_Freq200_uid10 is
signal Mfull :  std_logic_vector(40 downto 0);
   -- timing of Mfull: (c0, 0.000000ns)
signal M :  std_logic_vector(40 downto 0);
   -- timing of M: (c0, 0.000000ns)
begin
   Mfull <= std_logic_vector(unsigned(X) * unsigned(Y)); -- multiplier
   M <= Mfull(40 downto 0);
   R <= M;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid12
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid12 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid12 is
   component MultTable_Freq200_uid14 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy15 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy15: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid14
      port map ( X => Xtable,
                 Y => Y1_copy15);
   Y1 <= Y1_copy15; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid17
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid17 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid17 is
   component MultTable_Freq200_uid19 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy20 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy20: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid19
      port map ( X => Xtable,
                 Y => Y1_copy20);
   Y1 <= Y1_copy20; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid22
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid22 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid22 is
   component MultTable_Freq200_uid24 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy25 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy25: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid24
      port map ( X => Xtable,
                 Y => Y1_copy25);
   Y1 <= Y1_copy25; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid27
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid27 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid27 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid29
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid29 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid29 is
   component MultTable_Freq200_uid31 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy32 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy32: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid31
      port map ( X => Xtable,
                 Y => Y1_copy32);
   Y1 <= Y1_copy32; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid34
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid34 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid34 is
   component MultTable_Freq200_uid36 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy37 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy37: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid36
      port map ( X => Xtable,
                 Y => Y1_copy37);
   Y1 <= Y1_copy37; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid39
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid39 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid39 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid41
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid41 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid41 is
   component MultTable_Freq200_uid43 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy44 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy44: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid43
      port map ( X => Xtable,
                 Y => Y1_copy44);
   Y1 <= Y1_copy44; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid46
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid46 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid46 is
   component MultTable_Freq200_uid48 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy49 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy49: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid48
      port map ( X => Xtable,
                 Y => Y1_copy49);
   Y1 <= Y1_copy49; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid51
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid51 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid51 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid53
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid53 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid53 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid55
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid55 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid55 is
   component MultTable_Freq200_uid57 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy58 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy58: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid57
      port map ( X => Xtable,
                 Y => Y1_copy58);
   Y1 <= Y1_copy58; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid60
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid60 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid60 is
   component MultTable_Freq200_uid62 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy63 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy63: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid62
      port map ( X => Xtable,
                 Y => Y1_copy63);
   Y1 <= Y1_copy63; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid65
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid65 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid65 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid67
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid67 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid67 is
   component MultTable_Freq200_uid69 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy70 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy70: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid69
      port map ( X => Xtable,
                 Y => Y1_copy70);
   Y1 <= Y1_copy70; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid72
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid72 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid72 is
   component MultTable_Freq200_uid74 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy75 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy75: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid74
      port map ( X => Xtable,
                 Y => Y1_copy75);
   Y1 <= Y1_copy75; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid77
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid77 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid77 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid79
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid79 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid79 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid81
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid81 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid81 is
   component MultTable_Freq200_uid83 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy84 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy84: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid83
      port map ( X => Xtable,
                 Y => Y1_copy84);
   Y1 <= Y1_copy84; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid86
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid86 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid86 is
   component MultTable_Freq200_uid88 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy89 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy89: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid88
      port map ( X => Xtable,
                 Y => Y1_copy89);
   Y1 <= Y1_copy89; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_2x1_Freq200_uid91
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid91 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid91 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid93
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid93 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid93 is
   component MultTable_Freq200_uid95 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy96 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy96: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid95
      port map ( X => Xtable,
                 Y => Y1_copy96);
   Y1 <= Y1_copy96; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                     IntMultiplierLUT_3x3_Freq200_uid98
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid98 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid98 is
   component MultTable_Freq200_uid100 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy101 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy101: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid100
      port map ( X => Xtable,
                 Y => Y1_copy101);
   Y1 <= Y1_copy101; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                    IntMultiplierLUT_2x1_Freq200_uid103
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid103 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid103 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                    IntMultiplierLUT_2x1_Freq200_uid105
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid105 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid105 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                    IntMultiplierLUT_3x3_Freq200_uid107
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.328000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_3x3_Freq200_uid107 is
    port (clk : in std_logic;
          X : in  std_logic_vector(2 downto 0);
          Y : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_3x3_Freq200_uid107 is
   component MultTable_Freq200_uid109 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(5 downto 0)   );
   end component;

signal Xtable :  std_logic_vector(5 downto 0);
   -- timing of Xtable: (c0, 0.000000ns)
signal Y1 :  std_logic_vector(5 downto 0);
   -- timing of Y1: (c0, 0.328000ns)
signal Y1_copy110 :  std_logic_vector(5 downto 0);
   -- timing of Y1_copy110: (c0, 0.000000ns)
begin
Xtable <= Y & X;
   R <= Y1;
   TableMult: MultTable_Freq200_uid109
      port map ( X => Xtable,
                 Y => Y1_copy110);
   Y1 <= Y1_copy110; -- output copy to hold a pipeline register if needed
end architecture;

--------------------------------------------------------------------------------
--                    IntMultiplierLUT_2x1_Freq200_uid112
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid112 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid112 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                    IntMultiplierLUT_2x1_Freq200_uid114
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 0.215000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiplierLUT_2x1_Freq200_uid114 is
    port (clk : in std_logic;
          X : in  std_logic_vector(1 downto 0);
          Y : in  std_logic_vector(0 downto 0);
          R : out  std_logic_vector(1 downto 0)   );
end entity;

architecture arch of IntMultiplierLUT_2x1_Freq200_uid114 is
signal replicated :  std_logic_vector(1 downto 0);
   -- timing of replicated: (c0, 0.000000ns)
signal prod :  std_logic_vector(1 downto 0);
   -- timing of prod: (c0, 0.215000ns)
begin
   replicated <= (1 downto 0 => Y(0));
   prod <= X and replicated;
   R <= prod;
end architecture;

--------------------------------------------------------------------------------
--                         IntAdder_41_Freq200_uid261
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c0, 1.188000ns)Y: (c0, 1.188000ns)Cin: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 1.850000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_41_Freq200_uid261 is
    port (clk : in std_logic;
          X : in  std_logic_vector(40 downto 0);
          Y : in  std_logic_vector(40 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(40 downto 0)   );
end entity;

architecture arch of IntAdder_41_Freq200_uid261 is
signal Rtmp :  std_logic_vector(40 downto 0);
   -- timing of Rtmp: (c0, 1.850000ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                    IntMultiplier_24x24_48_Freq200_uid5
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Martin Kumm, Florent de Dinechin, Andreas Böttcher, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012-
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 1.850000ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_24x24_48_Freq200_uid5 is
    port (clk : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(23 downto 0);
          R : out  std_logic_vector(47 downto 0)   );
end entity;

architecture arch of IntMultiplier_24x24_48_Freq200_uid5 is
   component DSPBlock_24x17_Freq200_uid10 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(16 downto 0);
             R : out  std_logic_vector(40 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid12 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid17 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid22 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid27 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid29 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid34 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid39 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid41 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid46 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid51 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid53 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid55 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid60 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid65 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid67 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid72 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid77 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid79 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid81 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid86 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid91 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid93 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid98 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid103 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid105 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_3x3_Freq200_uid107 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(2 downto 0);
             Y : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid112 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component IntMultiplierLUT_2x1_Freq200_uid114 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(1 downto 0);
             Y : in  std_logic_vector(0 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component Compressor_23_3_Freq200_uid117 is
      port ( X1 : in  std_logic_vector(1 downto 0);
             X0 : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component Compressor_14_3_Freq200_uid135 is
      port ( X1 : in  std_logic_vector(0 downto 0);
             X0 : in  std_logic_vector(3 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component Compressor_3_2_Freq200_uid141 is
      port ( X0 : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(1 downto 0)   );
   end component;

   component Compressor_6_3_Freq200_uid155 is
      port ( X0 : in  std_logic_vector(5 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component Compressor_5_3_Freq200_uid159 is
      port ( X0 : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component IntAdder_41_Freq200_uid261 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(40 downto 0);
             Y : in  std_logic_vector(40 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(40 downto 0)   );
   end component;

signal XX_m6 :  std_logic_vector(23 downto 0);
   -- timing of XX_m6: (c0, 0.000000ns)
signal YY_m6 :  std_logic_vector(23 downto 0);
   -- timing of YY_m6: (c0, 0.000000ns)
signal t8_tile_0_X :  std_logic_vector(23 downto 0);
   -- timing of t8_tile_0_X: (c0, 0.000000ns)
signal t8_tile_0_Y :  std_logic_vector(16 downto 0);
   -- timing of t8_tile_0_Y: (c0, 0.000000ns)
signal t8_tile_0_output :  std_logic_vector(40 downto 0);
   -- timing of t8_tile_0_output: (c0, 0.000000ns)
signal t8_tile_0_filtered_output :  unsigned(40-0 downto 0);
   -- timing of t8_tile_0_filtered_output: (c0, 0.000000ns)
signal bh7_w7_0 :  std_logic;
   -- timing of bh7_w7_0: (c0, 0.000000ns)
signal bh7_w8_0 :  std_logic;
   -- timing of bh7_w8_0: (c0, 0.000000ns)
signal bh7_w9_0 :  std_logic;
   -- timing of bh7_w9_0: (c0, 0.000000ns)
signal bh7_w10_0 :  std_logic;
   -- timing of bh7_w10_0: (c0, 0.000000ns)
signal bh7_w11_0 :  std_logic;
   -- timing of bh7_w11_0: (c0, 0.000000ns)
signal bh7_w12_0 :  std_logic;
   -- timing of bh7_w12_0: (c0, 0.000000ns)
signal bh7_w13_0 :  std_logic;
   -- timing of bh7_w13_0: (c0, 0.000000ns)
signal bh7_w14_0 :  std_logic;
   -- timing of bh7_w14_0: (c0, 0.000000ns)
signal bh7_w15_0 :  std_logic;
   -- timing of bh7_w15_0: (c0, 0.000000ns)
signal bh7_w16_0 :  std_logic;
   -- timing of bh7_w16_0: (c0, 0.000000ns)
signal bh7_w17_0 :  std_logic;
   -- timing of bh7_w17_0: (c0, 0.000000ns)
signal bh7_w18_0 :  std_logic;
   -- timing of bh7_w18_0: (c0, 0.000000ns)
signal bh7_w19_0 :  std_logic;
   -- timing of bh7_w19_0: (c0, 0.000000ns)
signal bh7_w20_0 :  std_logic;
   -- timing of bh7_w20_0: (c0, 0.000000ns)
signal bh7_w21_0 :  std_logic;
   -- timing of bh7_w21_0: (c0, 0.000000ns)
signal bh7_w22_0 :  std_logic;
   -- timing of bh7_w22_0: (c0, 0.000000ns)
signal bh7_w23_0 :  std_logic;
   -- timing of bh7_w23_0: (c0, 0.000000ns)
signal bh7_w24_0 :  std_logic;
   -- timing of bh7_w24_0: (c0, 0.000000ns)
signal bh7_w25_0 :  std_logic;
   -- timing of bh7_w25_0: (c0, 0.000000ns)
signal bh7_w26_0 :  std_logic;
   -- timing of bh7_w26_0: (c0, 0.000000ns)
signal bh7_w27_0 :  std_logic;
   -- timing of bh7_w27_0: (c0, 0.000000ns)
signal bh7_w28_0 :  std_logic;
   -- timing of bh7_w28_0: (c0, 0.000000ns)
signal bh7_w29_0 :  std_logic;
   -- timing of bh7_w29_0: (c0, 0.000000ns)
signal bh7_w30_0 :  std_logic;
   -- timing of bh7_w30_0: (c0, 0.000000ns)
signal bh7_w31_0 :  std_logic;
   -- timing of bh7_w31_0: (c0, 0.000000ns)
signal bh7_w32_0 :  std_logic;
   -- timing of bh7_w32_0: (c0, 0.000000ns)
signal bh7_w33_0 :  std_logic;
   -- timing of bh7_w33_0: (c0, 0.000000ns)
signal bh7_w34_0 :  std_logic;
   -- timing of bh7_w34_0: (c0, 0.000000ns)
signal bh7_w35_0 :  std_logic;
   -- timing of bh7_w35_0: (c0, 0.000000ns)
signal bh7_w36_0 :  std_logic;
   -- timing of bh7_w36_0: (c0, 0.000000ns)
signal bh7_w37_0 :  std_logic;
   -- timing of bh7_w37_0: (c0, 0.000000ns)
signal bh7_w38_0 :  std_logic;
   -- timing of bh7_w38_0: (c0, 0.000000ns)
signal bh7_w39_0 :  std_logic;
   -- timing of bh7_w39_0: (c0, 0.000000ns)
signal bh7_w40_0 :  std_logic;
   -- timing of bh7_w40_0: (c0, 0.000000ns)
signal bh7_w41_0 :  std_logic;
   -- timing of bh7_w41_0: (c0, 0.000000ns)
signal bh7_w42_0 :  std_logic;
   -- timing of bh7_w42_0: (c0, 0.000000ns)
signal bh7_w43_0 :  std_logic;
   -- timing of bh7_w43_0: (c0, 0.000000ns)
signal bh7_w44_0 :  std_logic;
   -- timing of bh7_w44_0: (c0, 0.000000ns)
signal bh7_w45_0 :  std_logic;
   -- timing of bh7_w45_0: (c0, 0.000000ns)
signal bh7_w46_0 :  std_logic;
   -- timing of bh7_w46_0: (c0, 0.000000ns)
signal bh7_w47_0 :  std_logic;
   -- timing of bh7_w47_0: (c0, 0.000000ns)
signal t8_tile_1_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_1_X: (c0, 0.000000ns)
signal t8_tile_1_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_1_Y: (c0, 0.000000ns)
signal t8_tile_1_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_1_output: (c0, 0.328000ns)
signal t8_tile_1_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_1_filtered_output: (c0, 0.328000ns)
signal bh7_w25_1 :  std_logic;
   -- timing of bh7_w25_1: (c0, 0.328000ns)
signal bh7_w26_1 :  std_logic;
   -- timing of bh7_w26_1: (c0, 0.328000ns)
signal bh7_w27_1 :  std_logic;
   -- timing of bh7_w27_1: (c0, 0.328000ns)
signal bh7_w28_1 :  std_logic;
   -- timing of bh7_w28_1: (c0, 0.328000ns)
signal bh7_w29_1 :  std_logic;
   -- timing of bh7_w29_1: (c0, 0.328000ns)
signal bh7_w30_1 :  std_logic;
   -- timing of bh7_w30_1: (c0, 0.328000ns)
signal t8_tile_2_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_2_X: (c0, 0.000000ns)
signal t8_tile_2_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_2_Y: (c0, 0.000000ns)
signal t8_tile_2_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_2_output: (c0, 0.328000ns)
signal t8_tile_2_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_2_filtered_output: (c0, 0.328000ns)
signal bh7_w22_1 :  std_logic;
   -- timing of bh7_w22_1: (c0, 0.328000ns)
signal bh7_w23_1 :  std_logic;
   -- timing of bh7_w23_1: (c0, 0.328000ns)
signal bh7_w24_1 :  std_logic;
   -- timing of bh7_w24_1: (c0, 0.328000ns)
signal bh7_w25_2 :  std_logic;
   -- timing of bh7_w25_2: (c0, 0.328000ns)
signal bh7_w26_2 :  std_logic;
   -- timing of bh7_w26_2: (c0, 0.328000ns)
signal bh7_w27_2 :  std_logic;
   -- timing of bh7_w27_2: (c0, 0.328000ns)
signal t8_tile_3_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_3_X: (c0, 0.000000ns)
signal t8_tile_3_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_3_Y: (c0, 0.000000ns)
signal t8_tile_3_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_3_output: (c0, 0.328000ns)
signal t8_tile_3_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_3_filtered_output: (c0, 0.328000ns)
signal bh7_w22_2 :  std_logic;
   -- timing of bh7_w22_2: (c0, 0.328000ns)
signal bh7_w23_2 :  std_logic;
   -- timing of bh7_w23_2: (c0, 0.328000ns)
signal bh7_w24_2 :  std_logic;
   -- timing of bh7_w24_2: (c0, 0.328000ns)
signal bh7_w25_3 :  std_logic;
   -- timing of bh7_w25_3: (c0, 0.328000ns)
signal bh7_w26_3 :  std_logic;
   -- timing of bh7_w26_3: (c0, 0.328000ns)
signal bh7_w27_3 :  std_logic;
   -- timing of bh7_w27_3: (c0, 0.328000ns)
signal t8_tile_4_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_4_X: (c0, 0.000000ns)
signal t8_tile_4_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_4_Y: (c0, 0.000000ns)
signal t8_tile_4_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_4_output: (c0, 0.215000ns)
signal t8_tile_4_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_4_filtered_output: (c0, 0.215000ns)
signal bh7_w22_3 :  std_logic;
   -- timing of bh7_w22_3: (c0, 0.215000ns)
signal bh7_w23_3 :  std_logic;
   -- timing of bh7_w23_3: (c0, 0.215000ns)
signal t8_tile_5_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_5_X: (c0, 0.000000ns)
signal t8_tile_5_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_5_Y: (c0, 0.000000ns)
signal t8_tile_5_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_5_output: (c0, 0.328000ns)
signal t8_tile_5_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_5_filtered_output: (c0, 0.328000ns)
signal bh7_w19_1 :  std_logic;
   -- timing of bh7_w19_1: (c0, 0.328000ns)
signal bh7_w20_1 :  std_logic;
   -- timing of bh7_w20_1: (c0, 0.328000ns)
signal bh7_w21_1 :  std_logic;
   -- timing of bh7_w21_1: (c0, 0.328000ns)
signal bh7_w22_4 :  std_logic;
   -- timing of bh7_w22_4: (c0, 0.328000ns)
signal bh7_w23_4 :  std_logic;
   -- timing of bh7_w23_4: (c0, 0.328000ns)
signal bh7_w24_3 :  std_logic;
   -- timing of bh7_w24_3: (c0, 0.328000ns)
signal t8_tile_6_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_6_X: (c0, 0.000000ns)
signal t8_tile_6_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_6_Y: (c0, 0.000000ns)
signal t8_tile_6_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_6_output: (c0, 0.328000ns)
signal t8_tile_6_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_6_filtered_output: (c0, 0.328000ns)
signal bh7_w19_2 :  std_logic;
   -- timing of bh7_w19_2: (c0, 0.328000ns)
signal bh7_w20_2 :  std_logic;
   -- timing of bh7_w20_2: (c0, 0.328000ns)
signal bh7_w21_2 :  std_logic;
   -- timing of bh7_w21_2: (c0, 0.328000ns)
signal bh7_w22_5 :  std_logic;
   -- timing of bh7_w22_5: (c0, 0.328000ns)
signal bh7_w23_5 :  std_logic;
   -- timing of bh7_w23_5: (c0, 0.328000ns)
signal bh7_w24_4 :  std_logic;
   -- timing of bh7_w24_4: (c0, 0.328000ns)
signal t8_tile_7_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_7_X: (c0, 0.000000ns)
signal t8_tile_7_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_7_Y: (c0, 0.000000ns)
signal t8_tile_7_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_7_output: (c0, 0.215000ns)
signal t8_tile_7_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_7_filtered_output: (c0, 0.215000ns)
signal bh7_w20_3 :  std_logic;
   -- timing of bh7_w20_3: (c0, 0.215000ns)
signal bh7_w21_3 :  std_logic;
   -- timing of bh7_w21_3: (c0, 0.215000ns)
signal t8_tile_8_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_8_X: (c0, 0.000000ns)
signal t8_tile_8_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_8_Y: (c0, 0.000000ns)
signal t8_tile_8_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_8_output: (c0, 0.328000ns)
signal t8_tile_8_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_8_filtered_output: (c0, 0.328000ns)
signal bh7_w16_1 :  std_logic;
   -- timing of bh7_w16_1: (c0, 0.328000ns)
signal bh7_w17_1 :  std_logic;
   -- timing of bh7_w17_1: (c0, 0.328000ns)
signal bh7_w18_1 :  std_logic;
   -- timing of bh7_w18_1: (c0, 0.328000ns)
signal bh7_w19_3 :  std_logic;
   -- timing of bh7_w19_3: (c0, 0.328000ns)
signal bh7_w20_4 :  std_logic;
   -- timing of bh7_w20_4: (c0, 0.328000ns)
signal bh7_w21_4 :  std_logic;
   -- timing of bh7_w21_4: (c0, 0.328000ns)
signal t8_tile_9_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_9_X: (c0, 0.000000ns)
signal t8_tile_9_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_9_Y: (c0, 0.000000ns)
signal t8_tile_9_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_9_output: (c0, 0.328000ns)
signal t8_tile_9_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_9_filtered_output: (c0, 0.328000ns)
signal bh7_w16_2 :  std_logic;
   -- timing of bh7_w16_2: (c0, 0.328000ns)
signal bh7_w17_2 :  std_logic;
   -- timing of bh7_w17_2: (c0, 0.328000ns)
signal bh7_w18_2 :  std_logic;
   -- timing of bh7_w18_2: (c0, 0.328000ns)
signal bh7_w19_4 :  std_logic;
   -- timing of bh7_w19_4: (c0, 0.328000ns)
signal bh7_w20_5 :  std_logic;
   -- timing of bh7_w20_5: (c0, 0.328000ns)
signal bh7_w21_5 :  std_logic;
   -- timing of bh7_w21_5: (c0, 0.328000ns)
signal t8_tile_10_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_10_X: (c0, 0.000000ns)
signal t8_tile_10_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_10_Y: (c0, 0.000000ns)
signal t8_tile_10_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_10_output: (c0, 0.215000ns)
signal t8_tile_10_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_10_filtered_output: (c0, 0.215000ns)
signal bh7_w18_3 :  std_logic;
   -- timing of bh7_w18_3: (c0, 0.215000ns)
signal bh7_w19_5 :  std_logic;
   -- timing of bh7_w19_5: (c0, 0.215000ns)
signal t8_tile_11_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_11_X: (c0, 0.000000ns)
signal t8_tile_11_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_11_Y: (c0, 0.000000ns)
signal t8_tile_11_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_11_output: (c0, 0.215000ns)
signal t8_tile_11_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_11_filtered_output: (c0, 0.215000ns)
signal bh7_w16_3 :  std_logic;
   -- timing of bh7_w16_3: (c0, 0.215000ns)
signal bh7_w17_3 :  std_logic;
   -- timing of bh7_w17_3: (c0, 0.215000ns)
signal t8_tile_12_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_12_X: (c0, 0.000000ns)
signal t8_tile_12_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_12_Y: (c0, 0.000000ns)
signal t8_tile_12_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_12_output: (c0, 0.328000ns)
signal t8_tile_12_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_12_filtered_output: (c0, 0.328000ns)
signal bh7_w13_1 :  std_logic;
   -- timing of bh7_w13_1: (c0, 0.328000ns)
signal bh7_w14_1 :  std_logic;
   -- timing of bh7_w14_1: (c0, 0.328000ns)
signal bh7_w15_1 :  std_logic;
   -- timing of bh7_w15_1: (c0, 0.328000ns)
signal bh7_w16_4 :  std_logic;
   -- timing of bh7_w16_4: (c0, 0.328000ns)
signal bh7_w17_4 :  std_logic;
   -- timing of bh7_w17_4: (c0, 0.328000ns)
signal bh7_w18_4 :  std_logic;
   -- timing of bh7_w18_4: (c0, 0.328000ns)
signal t8_tile_13_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_13_X: (c0, 0.000000ns)
signal t8_tile_13_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_13_Y: (c0, 0.000000ns)
signal t8_tile_13_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_13_output: (c0, 0.328000ns)
signal t8_tile_13_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_13_filtered_output: (c0, 0.328000ns)
signal bh7_w13_2 :  std_logic;
   -- timing of bh7_w13_2: (c0, 0.328000ns)
signal bh7_w14_2 :  std_logic;
   -- timing of bh7_w14_2: (c0, 0.328000ns)
signal bh7_w15_2 :  std_logic;
   -- timing of bh7_w15_2: (c0, 0.328000ns)
signal bh7_w16_5 :  std_logic;
   -- timing of bh7_w16_5: (c0, 0.328000ns)
signal bh7_w17_5 :  std_logic;
   -- timing of bh7_w17_5: (c0, 0.328000ns)
signal bh7_w18_5 :  std_logic;
   -- timing of bh7_w18_5: (c0, 0.328000ns)
signal t8_tile_14_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_14_X: (c0, 0.000000ns)
signal t8_tile_14_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_14_Y: (c0, 0.000000ns)
signal t8_tile_14_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_14_output: (c0, 0.215000ns)
signal t8_tile_14_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_14_filtered_output: (c0, 0.215000ns)
signal bh7_w14_3 :  std_logic;
   -- timing of bh7_w14_3: (c0, 0.215000ns)
signal bh7_w15_3 :  std_logic;
   -- timing of bh7_w15_3: (c0, 0.215000ns)
signal t8_tile_15_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_15_X: (c0, 0.000000ns)
signal t8_tile_15_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_15_Y: (c0, 0.000000ns)
signal t8_tile_15_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_15_output: (c0, 0.328000ns)
signal t8_tile_15_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_15_filtered_output: (c0, 0.328000ns)
signal bh7_w10_1 :  std_logic;
   -- timing of bh7_w10_1: (c0, 0.328000ns)
signal bh7_w11_1 :  std_logic;
   -- timing of bh7_w11_1: (c0, 0.328000ns)
signal bh7_w12_1 :  std_logic;
   -- timing of bh7_w12_1: (c0, 0.328000ns)
signal bh7_w13_3 :  std_logic;
   -- timing of bh7_w13_3: (c0, 0.328000ns)
signal bh7_w14_4 :  std_logic;
   -- timing of bh7_w14_4: (c0, 0.328000ns)
signal bh7_w15_4 :  std_logic;
   -- timing of bh7_w15_4: (c0, 0.328000ns)
signal t8_tile_16_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_16_X: (c0, 0.000000ns)
signal t8_tile_16_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_16_Y: (c0, 0.000000ns)
signal t8_tile_16_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_16_output: (c0, 0.328000ns)
signal t8_tile_16_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_16_filtered_output: (c0, 0.328000ns)
signal bh7_w10_2 :  std_logic;
   -- timing of bh7_w10_2: (c0, 0.328000ns)
signal bh7_w11_2 :  std_logic;
   -- timing of bh7_w11_2: (c0, 0.328000ns)
signal bh7_w12_2 :  std_logic;
   -- timing of bh7_w12_2: (c0, 0.328000ns)
signal bh7_w13_4 :  std_logic;
   -- timing of bh7_w13_4: (c0, 0.328000ns)
signal bh7_w14_5 :  std_logic;
   -- timing of bh7_w14_5: (c0, 0.328000ns)
signal bh7_w15_5 :  std_logic;
   -- timing of bh7_w15_5: (c0, 0.328000ns)
signal t8_tile_17_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_17_X: (c0, 0.000000ns)
signal t8_tile_17_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_17_Y: (c0, 0.000000ns)
signal t8_tile_17_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_17_output: (c0, 0.215000ns)
signal t8_tile_17_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_17_filtered_output: (c0, 0.215000ns)
signal bh7_w12_3 :  std_logic;
   -- timing of bh7_w12_3: (c0, 0.215000ns)
signal bh7_w13_5 :  std_logic;
   -- timing of bh7_w13_5: (c0, 0.215000ns)
signal t8_tile_18_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_18_X: (c0, 0.000000ns)
signal t8_tile_18_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_18_Y: (c0, 0.000000ns)
signal t8_tile_18_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_18_output: (c0, 0.215000ns)
signal t8_tile_18_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_18_filtered_output: (c0, 0.215000ns)
signal bh7_w10_3 :  std_logic;
   -- timing of bh7_w10_3: (c0, 0.215000ns)
signal bh7_w11_3 :  std_logic;
   -- timing of bh7_w11_3: (c0, 0.215000ns)
signal t8_tile_19_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_19_X: (c0, 0.000000ns)
signal t8_tile_19_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_19_Y: (c0, 0.000000ns)
signal t8_tile_19_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_19_output: (c0, 0.328000ns)
signal t8_tile_19_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_19_filtered_output: (c0, 0.328000ns)
signal bh7_w7_1 :  std_logic;
   -- timing of bh7_w7_1: (c0, 0.328000ns)
signal bh7_w8_1 :  std_logic;
   -- timing of bh7_w8_1: (c0, 0.328000ns)
signal bh7_w9_1 :  std_logic;
   -- timing of bh7_w9_1: (c0, 0.328000ns)
signal bh7_w10_4 :  std_logic;
   -- timing of bh7_w10_4: (c0, 0.328000ns)
signal bh7_w11_4 :  std_logic;
   -- timing of bh7_w11_4: (c0, 0.328000ns)
signal bh7_w12_4 :  std_logic;
   -- timing of bh7_w12_4: (c0, 0.328000ns)
signal t8_tile_20_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_20_X: (c0, 0.000000ns)
signal t8_tile_20_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_20_Y: (c0, 0.000000ns)
signal t8_tile_20_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_20_output: (c0, 0.328000ns)
signal t8_tile_20_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_20_filtered_output: (c0, 0.328000ns)
signal bh7_w7_2 :  std_logic;
   -- timing of bh7_w7_2: (c0, 0.328000ns)
signal bh7_w8_2 :  std_logic;
   -- timing of bh7_w8_2: (c0, 0.328000ns)
signal bh7_w9_2 :  std_logic;
   -- timing of bh7_w9_2: (c0, 0.328000ns)
signal bh7_w10_5 :  std_logic;
   -- timing of bh7_w10_5: (c0, 0.328000ns)
signal bh7_w11_5 :  std_logic;
   -- timing of bh7_w11_5: (c0, 0.328000ns)
signal bh7_w12_5 :  std_logic;
   -- timing of bh7_w12_5: (c0, 0.328000ns)
signal t8_tile_21_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_21_X: (c0, 0.000000ns)
signal t8_tile_21_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_21_Y: (c0, 0.000000ns)
signal t8_tile_21_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_21_output: (c0, 0.215000ns)
signal t8_tile_21_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_21_filtered_output: (c0, 0.215000ns)
signal bh7_w8_3 :  std_logic;
   -- timing of bh7_w8_3: (c0, 0.215000ns)
signal bh7_w9_3 :  std_logic;
   -- timing of bh7_w9_3: (c0, 0.215000ns)
signal t8_tile_22_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_22_X: (c0, 0.000000ns)
signal t8_tile_22_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_22_Y: (c0, 0.000000ns)
signal t8_tile_22_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_22_output: (c0, 0.328000ns)
signal t8_tile_22_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_22_filtered_output: (c0, 0.328000ns)
signal bh7_w4_0 :  std_logic;
   -- timing of bh7_w4_0: (c0, 0.328000ns)
signal bh7_w5_0 :  std_logic;
   -- timing of bh7_w5_0: (c0, 0.328000ns)
signal bh7_w6_0 :  std_logic;
   -- timing of bh7_w6_0: (c0, 0.328000ns)
signal bh7_w7_3 :  std_logic;
   -- timing of bh7_w7_3: (c0, 0.328000ns)
signal bh7_w8_4 :  std_logic;
   -- timing of bh7_w8_4: (c0, 0.328000ns)
signal bh7_w9_4 :  std_logic;
   -- timing of bh7_w9_4: (c0, 0.328000ns)
signal t8_tile_23_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_23_X: (c0, 0.000000ns)
signal t8_tile_23_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_23_Y: (c0, 0.000000ns)
signal t8_tile_23_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_23_output: (c0, 0.328000ns)
signal t8_tile_23_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_23_filtered_output: (c0, 0.328000ns)
signal bh7_w4_1 :  std_logic;
   -- timing of bh7_w4_1: (c0, 0.328000ns)
signal bh7_w5_1 :  std_logic;
   -- timing of bh7_w5_1: (c0, 0.328000ns)
signal bh7_w6_1 :  std_logic;
   -- timing of bh7_w6_1: (c0, 0.328000ns)
signal bh7_w7_4 :  std_logic;
   -- timing of bh7_w7_4: (c0, 0.328000ns)
signal bh7_w8_5 :  std_logic;
   -- timing of bh7_w8_5: (c0, 0.328000ns)
signal bh7_w9_5 :  std_logic;
   -- timing of bh7_w9_5: (c0, 0.328000ns)
signal t8_tile_24_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_24_X: (c0, 0.000000ns)
signal t8_tile_24_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_24_Y: (c0, 0.000000ns)
signal t8_tile_24_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_24_output: (c0, 0.215000ns)
signal t8_tile_24_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_24_filtered_output: (c0, 0.215000ns)
signal bh7_w6_2 :  std_logic;
   -- timing of bh7_w6_2: (c0, 0.215000ns)
signal bh7_w7_5 :  std_logic;
   -- timing of bh7_w7_5: (c0, 0.215000ns)
signal t8_tile_25_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_25_X: (c0, 0.000000ns)
signal t8_tile_25_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_25_Y: (c0, 0.000000ns)
signal t8_tile_25_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_25_output: (c0, 0.215000ns)
signal t8_tile_25_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_25_filtered_output: (c0, 0.215000ns)
signal bh7_w4_2 :  std_logic;
   -- timing of bh7_w4_2: (c0, 0.215000ns)
signal bh7_w5_2 :  std_logic;
   -- timing of bh7_w5_2: (c0, 0.215000ns)
signal t8_tile_26_X :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_26_X: (c0, 0.000000ns)
signal t8_tile_26_Y :  std_logic_vector(2 downto 0);
   -- timing of t8_tile_26_Y: (c0, 0.000000ns)
signal t8_tile_26_output :  std_logic_vector(5 downto 0);
   -- timing of t8_tile_26_output: (c0, 0.328000ns)
signal t8_tile_26_filtered_output :  unsigned(5-0 downto 0);
   -- timing of t8_tile_26_filtered_output: (c0, 0.328000ns)
signal bh7_w1_0 :  std_logic;
   -- timing of bh7_w1_0: (c0, 0.328000ns)
signal bh7_w2_0 :  std_logic;
   -- timing of bh7_w2_0: (c0, 0.328000ns)
signal bh7_w3_0 :  std_logic;
   -- timing of bh7_w3_0: (c0, 0.328000ns)
signal bh7_w4_3 :  std_logic;
   -- timing of bh7_w4_3: (c0, 0.328000ns)
signal bh7_w5_3 :  std_logic;
   -- timing of bh7_w5_3: (c0, 0.328000ns)
signal bh7_w6_3 :  std_logic;
   -- timing of bh7_w6_3: (c0, 0.328000ns)
signal t8_tile_27_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_27_X: (c0, 0.000000ns)
signal t8_tile_27_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_27_Y: (c0, 0.000000ns)
signal t8_tile_27_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_27_output: (c0, 0.215000ns)
signal t8_tile_27_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_27_filtered_output: (c0, 0.215000ns)
signal bh7_w2_1 :  std_logic;
   -- timing of bh7_w2_1: (c0, 0.215000ns)
signal bh7_w3_1 :  std_logic;
   -- timing of bh7_w3_1: (c0, 0.215000ns)
signal t8_tile_28_X :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_28_X: (c0, 0.000000ns)
signal t8_tile_28_Y :  std_logic_vector(0 downto 0);
   -- timing of t8_tile_28_Y: (c0, 0.000000ns)
signal t8_tile_28_output :  std_logic_vector(1 downto 0);
   -- timing of t8_tile_28_output: (c0, 0.215000ns)
signal t8_tile_28_filtered_output :  unsigned(1-0 downto 0);
   -- timing of t8_tile_28_filtered_output: (c0, 0.215000ns)
signal bh7_w0_0 :  std_logic;
   -- timing of bh7_w0_0: (c0, 0.215000ns)
signal bh7_w1_1 :  std_logic;
   -- timing of bh7_w1_1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid118_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid118_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid118_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid118_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid118_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid118_Out0: (c0, 0.430000ns)
signal bh7_w7_6 :  std_logic;
   -- timing of bh7_w7_6: (c0, 0.430000ns)
signal bh7_w8_6 :  std_logic;
   -- timing of bh7_w8_6: (c0, 0.430000ns)
signal bh7_w9_6 :  std_logic;
   -- timing of bh7_w9_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid118_Out0_copy119 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid118_Out0_copy119: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid120_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid120_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid120_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid120_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid120_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid120_Out0: (c0, 0.430000ns)
signal bh7_w9_7 :  std_logic;
   -- timing of bh7_w9_7: (c0, 0.430000ns)
signal bh7_w10_6 :  std_logic;
   -- timing of bh7_w10_6: (c0, 0.430000ns)
signal bh7_w11_6 :  std_logic;
   -- timing of bh7_w11_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid120_Out0_copy121 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid120_Out0_copy121: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid122_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid122_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid122_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid122_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid122_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid122_Out0: (c0, 0.430000ns)
signal bh7_w11_7 :  std_logic;
   -- timing of bh7_w11_7: (c0, 0.430000ns)
signal bh7_w12_6 :  std_logic;
   -- timing of bh7_w12_6: (c0, 0.430000ns)
signal bh7_w13_6 :  std_logic;
   -- timing of bh7_w13_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid122_Out0_copy123 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid122_Out0_copy123: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid124_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid124_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid124_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid124_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid124_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid124_Out0: (c0, 0.430000ns)
signal bh7_w13_7 :  std_logic;
   -- timing of bh7_w13_7: (c0, 0.430000ns)
signal bh7_w14_6 :  std_logic;
   -- timing of bh7_w14_6: (c0, 0.430000ns)
signal bh7_w15_6 :  std_logic;
   -- timing of bh7_w15_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid124_Out0_copy125 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid124_Out0_copy125: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid126_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid126_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid126_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid126_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid126_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid126_Out0: (c0, 0.430000ns)
signal bh7_w15_7 :  std_logic;
   -- timing of bh7_w15_7: (c0, 0.430000ns)
signal bh7_w16_6 :  std_logic;
   -- timing of bh7_w16_6: (c0, 0.430000ns)
signal bh7_w17_6 :  std_logic;
   -- timing of bh7_w17_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid126_Out0_copy127 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid126_Out0_copy127: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid128_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid128_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid128_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid128_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid128_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid128_Out0: (c0, 0.430000ns)
signal bh7_w17_7 :  std_logic;
   -- timing of bh7_w17_7: (c0, 0.430000ns)
signal bh7_w18_6 :  std_logic;
   -- timing of bh7_w18_6: (c0, 0.430000ns)
signal bh7_w19_6 :  std_logic;
   -- timing of bh7_w19_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid128_Out0_copy129 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid128_Out0_copy129: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid130_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid130_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid130_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid130_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid130_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid130_Out0: (c0, 0.430000ns)
signal bh7_w19_7 :  std_logic;
   -- timing of bh7_w19_7: (c0, 0.430000ns)
signal bh7_w20_6 :  std_logic;
   -- timing of bh7_w20_6: (c0, 0.430000ns)
signal bh7_w21_6 :  std_logic;
   -- timing of bh7_w21_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid130_Out0_copy131 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid130_Out0_copy131: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid132_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid132_In0: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid132_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid132_In1: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid132_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid132_Out0: (c0, 0.430000ns)
signal bh7_w21_7 :  std_logic;
   -- timing of bh7_w21_7: (c0, 0.430000ns)
signal bh7_w22_6 :  std_logic;
   -- timing of bh7_w22_6: (c0, 0.430000ns)
signal bh7_w23_6 :  std_logic;
   -- timing of bh7_w23_6: (c0, 0.430000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid132_Out0_copy133 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid132_Out0_copy133: (c0, 0.215000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid136_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid136_In0: (c0, 0.215000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid136_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid136_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid136_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid136_Out0: (c0, 0.430000ns)
signal bh7_w23_7 :  std_logic;
   -- timing of bh7_w23_7: (c0, 0.430000ns)
signal bh7_w24_5 :  std_logic;
   -- timing of bh7_w24_5: (c0, 0.430000ns)
signal bh7_w25_4 :  std_logic;
   -- timing of bh7_w25_4: (c0, 0.430000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid136_Out0_copy137 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid136_Out0_copy137: (c0, 0.215000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid138_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid138_In0: (c0, 0.328000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid138_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid138_In1: (c0, 0.328000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid138_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid138_Out0: (c0, 0.543000ns)
signal bh7_w1_2 :  std_logic;
   -- timing of bh7_w1_2: (c0, 0.543000ns)
signal bh7_w2_2 :  std_logic;
   -- timing of bh7_w2_2: (c0, 0.543000ns)
signal bh7_w3_2 :  std_logic;
   -- timing of bh7_w3_2: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid138_Out0_copy139 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid138_Out0_copy139: (c0, 0.328000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid142_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid142_In0: (c0, 0.328000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid142_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid142_Out0: (c0, 0.543000ns)
signal bh7_w3_3 :  std_logic;
   -- timing of bh7_w3_3: (c0, 0.543000ns)
signal bh7_w4_4 :  std_logic;
   -- timing of bh7_w4_4: (c0, 0.543000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid142_Out0_copy143 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid142_Out0_copy143: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid144_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid144_In0: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid144_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid144_In1: (c0, 0.215000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid144_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid144_Out0: (c0, 0.543000ns)
signal bh7_w4_5 :  std_logic;
   -- timing of bh7_w4_5: (c0, 0.543000ns)
signal bh7_w5_4 :  std_logic;
   -- timing of bh7_w5_4: (c0, 0.543000ns)
signal bh7_w6_4 :  std_logic;
   -- timing of bh7_w6_4: (c0, 0.543000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid144_Out0_copy145 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid144_Out0_copy145: (c0, 0.328000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid146_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid146_In0: (c0, 0.328000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid146_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid146_Out0: (c0, 0.543000ns)
signal bh7_w5_5 :  std_logic;
   -- timing of bh7_w5_5: (c0, 0.543000ns)
signal bh7_w6_5 :  std_logic;
   -- timing of bh7_w6_5: (c0, 0.543000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid146_Out0_copy147 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid146_Out0_copy147: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid148_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid148_In0: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid148_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid148_In1: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid148_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid148_Out0: (c0, 0.543000ns)
signal bh7_w6_6 :  std_logic;
   -- timing of bh7_w6_6: (c0, 0.543000ns)
signal bh7_w7_7 :  std_logic;
   -- timing of bh7_w7_7: (c0, 0.543000ns)
signal bh7_w8_7 :  std_logic;
   -- timing of bh7_w8_7: (c0, 0.543000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid148_Out0_copy149 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid148_Out0_copy149: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid150_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid150_In0: (c0, 0.430000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid150_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid150_In1: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid150_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid150_Out0: (c0, 0.645000ns)
signal bh7_w7_8 :  std_logic;
   -- timing of bh7_w7_8: (c0, 0.645000ns)
signal bh7_w8_8 :  std_logic;
   -- timing of bh7_w8_8: (c0, 0.645000ns)
signal bh7_w9_8 :  std_logic;
   -- timing of bh7_w9_8: (c0, 0.645000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid150_Out0_copy151 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid150_Out0_copy151: (c0, 0.430000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid152_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid152_In0: (c0, 0.328000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid152_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid152_Out0: (c0, 0.543000ns)
signal bh7_w8_9 :  std_logic;
   -- timing of bh7_w8_9: (c0, 0.543000ns)
signal bh7_w9_9 :  std_logic;
   -- timing of bh7_w9_9: (c0, 0.543000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid152_Out0_copy153 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid152_Out0_copy153: (c0, 0.328000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid156_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid156_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid156_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid156_Out0: (c0, 0.758000ns)
signal bh7_w9_10 :  std_logic;
   -- timing of bh7_w9_10: (c0, 0.758000ns)
signal bh7_w10_7 :  std_logic;
   -- timing of bh7_w10_7: (c0, 0.758000ns)
signal bh7_w11_8 :  std_logic;
   -- timing of bh7_w11_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid156_Out0_copy157 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid156_Out0_copy157: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid160_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid160_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid160_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid160_Out0: (c0, 0.645000ns)
signal bh7_w10_8 :  std_logic;
   -- timing of bh7_w10_8: (c0, 0.645000ns)
signal bh7_w11_9 :  std_logic;
   -- timing of bh7_w11_9: (c0, 0.645000ns)
signal bh7_w12_7 :  std_logic;
   -- timing of bh7_w12_7: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid160_Out0_copy161 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid160_Out0_copy161: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid162_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid162_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid162_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid162_Out0: (c0, 0.758000ns)
signal bh7_w11_10 :  std_logic;
   -- timing of bh7_w11_10: (c0, 0.758000ns)
signal bh7_w12_8 :  std_logic;
   -- timing of bh7_w12_8: (c0, 0.758000ns)
signal bh7_w13_8 :  std_logic;
   -- timing of bh7_w13_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid162_Out0_copy163 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid162_Out0_copy163: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid164_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid164_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid164_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid164_Out0: (c0, 0.645000ns)
signal bh7_w12_9 :  std_logic;
   -- timing of bh7_w12_9: (c0, 0.645000ns)
signal bh7_w13_9 :  std_logic;
   -- timing of bh7_w13_9: (c0, 0.645000ns)
signal bh7_w14_7 :  std_logic;
   -- timing of bh7_w14_7: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid164_Out0_copy165 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid164_Out0_copy165: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid166_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid166_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid166_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid166_Out0: (c0, 0.758000ns)
signal bh7_w13_10 :  std_logic;
   -- timing of bh7_w13_10: (c0, 0.758000ns)
signal bh7_w14_8 :  std_logic;
   -- timing of bh7_w14_8: (c0, 0.758000ns)
signal bh7_w15_8 :  std_logic;
   -- timing of bh7_w15_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid166_Out0_copy167 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid166_Out0_copy167: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid168_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid168_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid168_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid168_Out0: (c0, 0.645000ns)
signal bh7_w14_9 :  std_logic;
   -- timing of bh7_w14_9: (c0, 0.645000ns)
signal bh7_w15_9 :  std_logic;
   -- timing of bh7_w15_9: (c0, 0.645000ns)
signal bh7_w16_7 :  std_logic;
   -- timing of bh7_w16_7: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid168_Out0_copy169 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid168_Out0_copy169: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid170_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid170_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid170_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid170_Out0: (c0, 0.758000ns)
signal bh7_w15_10 :  std_logic;
   -- timing of bh7_w15_10: (c0, 0.758000ns)
signal bh7_w16_8 :  std_logic;
   -- timing of bh7_w16_8: (c0, 0.758000ns)
signal bh7_w17_8 :  std_logic;
   -- timing of bh7_w17_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid170_Out0_copy171 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid170_Out0_copy171: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid172_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid172_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid172_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid172_Out0: (c0, 0.645000ns)
signal bh7_w16_9 :  std_logic;
   -- timing of bh7_w16_9: (c0, 0.645000ns)
signal bh7_w17_9 :  std_logic;
   -- timing of bh7_w17_9: (c0, 0.645000ns)
signal bh7_w18_7 :  std_logic;
   -- timing of bh7_w18_7: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid172_Out0_copy173 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid172_Out0_copy173: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid174_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid174_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid174_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid174_Out0: (c0, 0.758000ns)
signal bh7_w17_10 :  std_logic;
   -- timing of bh7_w17_10: (c0, 0.758000ns)
signal bh7_w18_8 :  std_logic;
   -- timing of bh7_w18_8: (c0, 0.758000ns)
signal bh7_w19_8 :  std_logic;
   -- timing of bh7_w19_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid174_Out0_copy175 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid174_Out0_copy175: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid176_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid176_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid176_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid176_Out0: (c0, 0.645000ns)
signal bh7_w18_9 :  std_logic;
   -- timing of bh7_w18_9: (c0, 0.645000ns)
signal bh7_w19_9 :  std_logic;
   -- timing of bh7_w19_9: (c0, 0.645000ns)
signal bh7_w20_7 :  std_logic;
   -- timing of bh7_w20_7: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid176_Out0_copy177 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid176_Out0_copy177: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid178_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid178_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid178_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid178_Out0: (c0, 0.758000ns)
signal bh7_w19_10 :  std_logic;
   -- timing of bh7_w19_10: (c0, 0.758000ns)
signal bh7_w20_8 :  std_logic;
   -- timing of bh7_w20_8: (c0, 0.758000ns)
signal bh7_w21_8 :  std_logic;
   -- timing of bh7_w21_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid178_Out0_copy179 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid178_Out0_copy179: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid180_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid180_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid180_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid180_Out0: (c0, 0.645000ns)
signal bh7_w20_9 :  std_logic;
   -- timing of bh7_w20_9: (c0, 0.645000ns)
signal bh7_w21_9 :  std_logic;
   -- timing of bh7_w21_9: (c0, 0.645000ns)
signal bh7_w22_7 :  std_logic;
   -- timing of bh7_w22_7: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid180_Out0_copy181 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid180_Out0_copy181: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid182_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid182_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid182_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid182_Out0: (c0, 0.758000ns)
signal bh7_w21_10 :  std_logic;
   -- timing of bh7_w21_10: (c0, 0.758000ns)
signal bh7_w22_8 :  std_logic;
   -- timing of bh7_w22_8: (c0, 0.758000ns)
signal bh7_w23_8 :  std_logic;
   -- timing of bh7_w23_8: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid182_Out0_copy183 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid182_Out0_copy183: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid184_In0 :  std_logic_vector(4 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid184_In0: (c0, 0.430000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid184_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid184_Out0: (c0, 0.645000ns)
signal bh7_w22_9 :  std_logic;
   -- timing of bh7_w22_9: (c0, 0.645000ns)
signal bh7_w23_9 :  std_logic;
   -- timing of bh7_w23_9: (c0, 0.645000ns)
signal bh7_w24_6 :  std_logic;
   -- timing of bh7_w24_6: (c0, 0.645000ns)
signal Compressor_5_3_Freq200_uid159_bh7_uid184_Out0_copy185 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_5_3_Freq200_uid159_bh7_uid184_Out0_copy185: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid186_In0 :  std_logic_vector(5 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid186_In0: (c0, 0.430000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid186_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid186_Out0: (c0, 0.758000ns)
signal bh7_w23_10 :  std_logic;
   -- timing of bh7_w23_10: (c0, 0.758000ns)
signal bh7_w24_7 :  std_logic;
   -- timing of bh7_w24_7: (c0, 0.758000ns)
signal bh7_w25_5 :  std_logic;
   -- timing of bh7_w25_5: (c0, 0.758000ns)
signal Compressor_6_3_Freq200_uid155_bh7_uid186_Out0_copy187 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_6_3_Freq200_uid155_bh7_uid186_Out0_copy187: (c0, 0.430000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid188_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid188_In0: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid188_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid188_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid188_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid188_Out0: (c0, 0.543000ns)
signal bh7_w24_8 :  std_logic;
   -- timing of bh7_w24_8: (c0, 0.543000ns)
signal bh7_w25_6 :  std_logic;
   -- timing of bh7_w25_6: (c0, 0.543000ns)
signal bh7_w26_4 :  std_logic;
   -- timing of bh7_w26_4: (c0, 0.543000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid188_Out0_copy189 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid188_Out0_copy189: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid190_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid190_In0: (c0, 0.430000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid190_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid190_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid190_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid190_Out0: (c0, 0.645000ns)
signal bh7_w25_7 :  std_logic;
   -- timing of bh7_w25_7: (c0, 0.645000ns)
signal bh7_w26_5 :  std_logic;
   -- timing of bh7_w26_5: (c0, 0.645000ns)
signal bh7_w27_4 :  std_logic;
   -- timing of bh7_w27_4: (c0, 0.645000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid190_Out0_copy191 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid190_Out0_copy191: (c0, 0.430000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid192_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid192_In0: (c0, 0.328000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid192_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid192_Out0: (c0, 0.543000ns)
signal bh7_w26_6 :  std_logic;
   -- timing of bh7_w26_6: (c0, 0.543000ns)
signal bh7_w27_5 :  std_logic;
   -- timing of bh7_w27_5: (c0, 0.543000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid192_Out0_copy193 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid192_Out0_copy193: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid194_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid194_In0: (c0, 0.328000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid194_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid194_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid194_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid194_Out0: (c0, 0.543000ns)
signal bh7_w27_6 :  std_logic;
   -- timing of bh7_w27_6: (c0, 0.543000ns)
signal bh7_w28_2 :  std_logic;
   -- timing of bh7_w28_2: (c0, 0.543000ns)
signal bh7_w29_2 :  std_logic;
   -- timing of bh7_w29_2: (c0, 0.543000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid194_Out0_copy195 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid194_Out0_copy195: (c0, 0.328000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid196_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid196_In0: (c0, 0.328000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid196_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid196_In1: (c0, 0.328000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid196_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid196_Out0: (c0, 0.543000ns)
signal bh7_w29_3 :  std_logic;
   -- timing of bh7_w29_3: (c0, 0.543000ns)
signal bh7_w30_2 :  std_logic;
   -- timing of bh7_w30_2: (c0, 0.543000ns)
signal bh7_w31_1 :  std_logic;
   -- timing of bh7_w31_1: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid196_Out0_copy197 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid196_Out0_copy197: (c0, 0.328000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid198_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid198_In0: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid198_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid198_In1: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid198_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid198_Out0: (c0, 0.758000ns)
signal bh7_w3_4 :  std_logic;
   -- timing of bh7_w3_4: (c0, 0.758000ns)
signal bh7_w4_6 :  std_logic;
   -- timing of bh7_w4_6: (c0, 0.758000ns)
signal bh7_w5_6 :  std_logic;
   -- timing of bh7_w5_6: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid198_Out0_copy199 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid198_Out0_copy199: (c0, 0.543000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid200_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid200_In0: (c0, 0.543000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid200_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid200_Out0: (c0, 0.758000ns)
signal bh7_w5_7 :  std_logic;
   -- timing of bh7_w5_7: (c0, 0.758000ns)
signal bh7_w6_7 :  std_logic;
   -- timing of bh7_w6_7: (c0, 0.758000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid200_Out0_copy201 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid200_Out0_copy201: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid202_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid202_In0: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid202_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid202_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid202_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid202_Out0: (c0, 0.860000ns)
signal bh7_w6_8 :  std_logic;
   -- timing of bh7_w6_8: (c0, 0.860000ns)
signal bh7_w7_9 :  std_logic;
   -- timing of bh7_w7_9: (c0, 0.860000ns)
signal bh7_w8_10 :  std_logic;
   -- timing of bh7_w8_10: (c0, 0.860000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid202_Out0_copy203 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid202_Out0_copy203: (c0, 0.645000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid204_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid204_In0: (c0, 0.645000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid204_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid204_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid204_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid204_Out0: (c0, 0.860000ns)
signal bh7_w8_11 :  std_logic;
   -- timing of bh7_w8_11: (c0, 0.860000ns)
signal bh7_w9_11 :  std_logic;
   -- timing of bh7_w9_11: (c0, 0.860000ns)
signal bh7_w10_9 :  std_logic;
   -- timing of bh7_w10_9: (c0, 0.860000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid204_Out0_copy205 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid204_Out0_copy205: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid206_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid206_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid206_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid206_In1: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid206_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid206_Out0: (c0, 0.973000ns)
signal bh7_w9_12 :  std_logic;
   -- timing of bh7_w9_12: (c0, 0.973000ns)
signal bh7_w10_10 :  std_logic;
   -- timing of bh7_w10_10: (c0, 0.973000ns)
signal bh7_w11_11 :  std_logic;
   -- timing of bh7_w11_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid206_Out0_copy207 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid206_Out0_copy207: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid208_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid208_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid208_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid208_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid208_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid208_Out0: (c0, 0.973000ns)
signal bh7_w11_12 :  std_logic;
   -- timing of bh7_w11_12: (c0, 0.973000ns)
signal bh7_w12_10 :  std_logic;
   -- timing of bh7_w12_10: (c0, 0.973000ns)
signal bh7_w13_11 :  std_logic;
   -- timing of bh7_w13_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid208_Out0_copy209 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid208_Out0_copy209: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid210_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid210_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid210_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid210_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid210_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid210_Out0: (c0, 0.973000ns)
signal bh7_w13_12 :  std_logic;
   -- timing of bh7_w13_12: (c0, 0.973000ns)
signal bh7_w14_10 :  std_logic;
   -- timing of bh7_w14_10: (c0, 0.973000ns)
signal bh7_w15_11 :  std_logic;
   -- timing of bh7_w15_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid210_Out0_copy211 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid210_Out0_copy211: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid212_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid212_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid212_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid212_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid212_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid212_Out0: (c0, 0.973000ns)
signal bh7_w15_12 :  std_logic;
   -- timing of bh7_w15_12: (c0, 0.973000ns)
signal bh7_w16_10 :  std_logic;
   -- timing of bh7_w16_10: (c0, 0.973000ns)
signal bh7_w17_11 :  std_logic;
   -- timing of bh7_w17_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid212_Out0_copy213 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid212_Out0_copy213: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid214_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid214_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid214_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid214_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid214_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid214_Out0: (c0, 0.973000ns)
signal bh7_w17_12 :  std_logic;
   -- timing of bh7_w17_12: (c0, 0.973000ns)
signal bh7_w18_10 :  std_logic;
   -- timing of bh7_w18_10: (c0, 0.973000ns)
signal bh7_w19_11 :  std_logic;
   -- timing of bh7_w19_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid214_Out0_copy215 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid214_Out0_copy215: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid216_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid216_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid216_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid216_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid216_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid216_Out0: (c0, 0.973000ns)
signal bh7_w19_12 :  std_logic;
   -- timing of bh7_w19_12: (c0, 0.973000ns)
signal bh7_w20_10 :  std_logic;
   -- timing of bh7_w20_10: (c0, 0.973000ns)
signal bh7_w21_11 :  std_logic;
   -- timing of bh7_w21_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid216_Out0_copy217 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid216_Out0_copy217: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid218_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid218_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid218_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid218_In1: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid218_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid218_Out0: (c0, 0.973000ns)
signal bh7_w21_12 :  std_logic;
   -- timing of bh7_w21_12: (c0, 0.973000ns)
signal bh7_w22_10 :  std_logic;
   -- timing of bh7_w22_10: (c0, 0.973000ns)
signal bh7_w23_11 :  std_logic;
   -- timing of bh7_w23_11: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid218_Out0_copy219 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid218_Out0_copy219: (c0, 0.758000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid220_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid220_In0: (c0, 0.758000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid220_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid220_Out0: (c0, 0.973000ns)
signal bh7_w23_12 :  std_logic;
   -- timing of bh7_w23_12: (c0, 0.973000ns)
signal bh7_w24_9 :  std_logic;
   -- timing of bh7_w24_9: (c0, 0.973000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid220_Out0_copy221 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid220_Out0_copy221: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid222_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid222_In0: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid222_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid222_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid222_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid222_Out0: (c0, 0.973000ns)
signal bh7_w24_10 :  std_logic;
   -- timing of bh7_w24_10: (c0, 0.973000ns)
signal bh7_w25_8 :  std_logic;
   -- timing of bh7_w25_8: (c0, 0.973000ns)
signal bh7_w26_7 :  std_logic;
   -- timing of bh7_w26_7: (c0, 0.973000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid222_Out0_copy223 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid222_Out0_copy223: (c0, 0.758000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid224_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid224_In0: (c0, 0.758000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid224_Out0 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid224_Out0: (c0, 0.973000ns)
signal bh7_w25_9 :  std_logic;
   -- timing of bh7_w25_9: (c0, 0.973000ns)
signal bh7_w26_8 :  std_logic;
   -- timing of bh7_w26_8: (c0, 0.973000ns)
signal Compressor_3_2_Freq200_uid141_bh7_uid224_Out0_copy225 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_3_2_Freq200_uid141_bh7_uid224_Out0_copy225: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid226_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid226_In0: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid226_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid226_In1: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid226_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid226_Out0: (c0, 0.860000ns)
signal bh7_w26_9 :  std_logic;
   -- timing of bh7_w26_9: (c0, 0.860000ns)
signal bh7_w27_7 :  std_logic;
   -- timing of bh7_w27_7: (c0, 0.860000ns)
signal bh7_w28_3 :  std_logic;
   -- timing of bh7_w28_3: (c0, 0.860000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid226_Out0_copy227 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid226_Out0_copy227: (c0, 0.645000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid228_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid228_In0: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid228_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid228_In1: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid228_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid228_Out0: (c0, 0.758000ns)
signal bh7_w28_4 :  std_logic;
   -- timing of bh7_w28_4: (c0, 0.758000ns)
signal bh7_w29_4 :  std_logic;
   -- timing of bh7_w29_4: (c0, 0.758000ns)
signal bh7_w30_3 :  std_logic;
   -- timing of bh7_w30_3: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid228_Out0_copy229 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid228_Out0_copy229: (c0, 0.543000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid230_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid230_In0: (c0, 0.543000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid230_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid230_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid230_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid230_Out0: (c0, 0.758000ns)
signal bh7_w31_2 :  std_logic;
   -- timing of bh7_w31_2: (c0, 0.758000ns)
signal bh7_w32_1 :  std_logic;
   -- timing of bh7_w32_1: (c0, 0.758000ns)
signal bh7_w33_1 :  std_logic;
   -- timing of bh7_w33_1: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid230_Out0_copy231 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid230_Out0_copy231: (c0, 0.543000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid232_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid232_In0: (c0, 0.758000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid232_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid232_In1: (c0, 0.860000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid232_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid232_Out0: (c0, 1.075000ns)
signal bh7_w5_8 :  std_logic;
   -- timing of bh7_w5_8: (c0, 1.075000ns)
signal bh7_w6_9 :  std_logic;
   -- timing of bh7_w6_9: (c0, 1.075000ns)
signal bh7_w7_10 :  std_logic;
   -- timing of bh7_w7_10: (c0, 1.075000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid232_Out0_copy233 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid232_Out0_copy233: (c0, 0.860000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid234_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid234_In0: (c0, 0.860000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid234_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid234_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid234_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid234_Out0: (c0, 1.188000ns)
signal bh7_w8_12 :  std_logic;
   -- timing of bh7_w8_12: (c0, 1.188000ns)
signal bh7_w9_13 :  std_logic;
   -- timing of bh7_w9_13: (c0, 1.188000ns)
signal bh7_w10_11 :  std_logic;
   -- timing of bh7_w10_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid234_Out0_copy235 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid234_Out0_copy235: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid236_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid236_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid236_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid236_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid236_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid236_Out0: (c0, 1.188000ns)
signal bh7_w10_12 :  std_logic;
   -- timing of bh7_w10_12: (c0, 1.188000ns)
signal bh7_w11_13 :  std_logic;
   -- timing of bh7_w11_13: (c0, 1.188000ns)
signal bh7_w12_11 :  std_logic;
   -- timing of bh7_w12_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid236_Out0_copy237 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid236_Out0_copy237: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid238_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid238_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid238_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid238_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid238_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid238_Out0: (c0, 1.188000ns)
signal bh7_w12_12 :  std_logic;
   -- timing of bh7_w12_12: (c0, 1.188000ns)
signal bh7_w13_13 :  std_logic;
   -- timing of bh7_w13_13: (c0, 1.188000ns)
signal bh7_w14_11 :  std_logic;
   -- timing of bh7_w14_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid238_Out0_copy239 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid238_Out0_copy239: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid240_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid240_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid240_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid240_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid240_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid240_Out0: (c0, 1.188000ns)
signal bh7_w14_12 :  std_logic;
   -- timing of bh7_w14_12: (c0, 1.188000ns)
signal bh7_w15_13 :  std_logic;
   -- timing of bh7_w15_13: (c0, 1.188000ns)
signal bh7_w16_11 :  std_logic;
   -- timing of bh7_w16_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid240_Out0_copy241 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid240_Out0_copy241: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid242_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid242_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid242_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid242_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid242_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid242_Out0: (c0, 1.188000ns)
signal bh7_w16_12 :  std_logic;
   -- timing of bh7_w16_12: (c0, 1.188000ns)
signal bh7_w17_13 :  std_logic;
   -- timing of bh7_w17_13: (c0, 1.188000ns)
signal bh7_w18_11 :  std_logic;
   -- timing of bh7_w18_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid242_Out0_copy243 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid242_Out0_copy243: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid244_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid244_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid244_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid244_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid244_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid244_Out0: (c0, 1.188000ns)
signal bh7_w18_12 :  std_logic;
   -- timing of bh7_w18_12: (c0, 1.188000ns)
signal bh7_w19_13 :  std_logic;
   -- timing of bh7_w19_13: (c0, 1.188000ns)
signal bh7_w20_11 :  std_logic;
   -- timing of bh7_w20_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid244_Out0_copy245 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid244_Out0_copy245: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid246_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid246_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid246_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid246_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid246_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid246_Out0: (c0, 1.188000ns)
signal bh7_w20_12 :  std_logic;
   -- timing of bh7_w20_12: (c0, 1.188000ns)
signal bh7_w21_13 :  std_logic;
   -- timing of bh7_w21_13: (c0, 1.188000ns)
signal bh7_w22_11 :  std_logic;
   -- timing of bh7_w22_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid246_Out0_copy247 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid246_Out0_copy247: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid248_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid248_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid248_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid248_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid248_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid248_Out0: (c0, 1.188000ns)
signal bh7_w22_12 :  std_logic;
   -- timing of bh7_w22_12: (c0, 1.188000ns)
signal bh7_w23_13 :  std_logic;
   -- timing of bh7_w23_13: (c0, 1.188000ns)
signal bh7_w24_11 :  std_logic;
   -- timing of bh7_w24_11: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid248_Out0_copy249 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid248_Out0_copy249: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid250_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid250_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid250_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid250_In1: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid250_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid250_Out0: (c0, 1.188000ns)
signal bh7_w24_12 :  std_logic;
   -- timing of bh7_w24_12: (c0, 1.188000ns)
signal bh7_w25_10 :  std_logic;
   -- timing of bh7_w25_10: (c0, 1.188000ns)
signal bh7_w26_10 :  std_logic;
   -- timing of bh7_w26_10: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid250_Out0_copy251 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid250_Out0_copy251: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid252_In0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid252_In0: (c0, 0.973000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid252_In1 :  std_logic_vector(1 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid252_In1: (c0, 0.860000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid252_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid252_Out0: (c0, 1.188000ns)
signal bh7_w26_11 :  std_logic;
   -- timing of bh7_w26_11: (c0, 1.188000ns)
signal bh7_w27_8 :  std_logic;
   -- timing of bh7_w27_8: (c0, 1.188000ns)
signal bh7_w28_5 :  std_logic;
   -- timing of bh7_w28_5: (c0, 1.188000ns)
signal Compressor_23_3_Freq200_uid117_bh7_uid252_Out0_copy253 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_23_3_Freq200_uid117_bh7_uid252_Out0_copy253: (c0, 0.973000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid254_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid254_In0: (c0, 0.860000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid254_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid254_In1: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid254_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid254_Out0: (c0, 1.075000ns)
signal bh7_w28_6 :  std_logic;
   -- timing of bh7_w28_6: (c0, 1.075000ns)
signal bh7_w29_5 :  std_logic;
   -- timing of bh7_w29_5: (c0, 1.075000ns)
signal bh7_w30_4 :  std_logic;
   -- timing of bh7_w30_4: (c0, 1.075000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid254_Out0_copy255 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid254_Out0_copy255: (c0, 0.860000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid256_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid256_In0: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid256_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid256_In1: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid256_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid256_Out0: (c0, 0.973000ns)
signal bh7_w30_5 :  std_logic;
   -- timing of bh7_w30_5: (c0, 0.973000ns)
signal bh7_w31_3 :  std_logic;
   -- timing of bh7_w31_3: (c0, 0.973000ns)
signal bh7_w32_2 :  std_logic;
   -- timing of bh7_w32_2: (c0, 0.973000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid256_Out0_copy257 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid256_Out0_copy257: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid258_In0 :  std_logic_vector(3 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid258_In0: (c0, 0.758000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid258_In1 :  std_logic_vector(0 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid258_In1: (c0, 0.000000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid258_Out0 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid258_Out0: (c0, 0.973000ns)
signal bh7_w33_2 :  std_logic;
   -- timing of bh7_w33_2: (c0, 0.973000ns)
signal bh7_w34_1 :  std_logic;
   -- timing of bh7_w34_1: (c0, 0.973000ns)
signal bh7_w35_1 :  std_logic;
   -- timing of bh7_w35_1: (c0, 0.973000ns)
signal Compressor_14_3_Freq200_uid135_bh7_uid258_Out0_copy259 :  std_logic_vector(2 downto 0);
   -- timing of Compressor_14_3_Freq200_uid135_bh7_uid258_Out0_copy259: (c0, 0.758000ns)
signal tmp_bitheapResult_bh7_6 :  std_logic_vector(6 downto 0);
   -- timing of tmp_bitheapResult_bh7_6: (c0, 1.075000ns)
signal bitheapFinalAdd_bh7_In0 :  std_logic_vector(40 downto 0);
   -- timing of bitheapFinalAdd_bh7_In0: (c0, 1.188000ns)
signal bitheapFinalAdd_bh7_In1 :  std_logic_vector(40 downto 0);
   -- timing of bitheapFinalAdd_bh7_In1: (c0, 1.188000ns)
signal bitheapFinalAdd_bh7_Cin :  std_logic;
   -- timing of bitheapFinalAdd_bh7_Cin: (c0, 0.000000ns)
signal bitheapFinalAdd_bh7_Out :  std_logic_vector(40 downto 0);
   -- timing of bitheapFinalAdd_bh7_Out: (c0, 1.850000ns)
signal bitheapResult_bh7 :  std_logic_vector(47 downto 0);
   -- timing of bitheapResult_bh7: (c0, 1.850000ns)
begin
   XX_m6 <= X ;
   YY_m6 <= Y ;
   t8_tile_0_X <= X(23 downto 0);
   t8_tile_0_Y <= Y(23 downto 7);
   t8_tile_0: DSPBlock_24x17_Freq200_uid10
      port map ( clk  => clk,
                 X => t8_tile_0_X,
                 Y => t8_tile_0_Y,
                 R => t8_tile_0_output);

   t8_tile_0_filtered_output <= unsigned(t8_tile_0_output(40 downto 0));
   bh7_w7_0 <= t8_tile_0_filtered_output(0);
   bh7_w8_0 <= t8_tile_0_filtered_output(1);
   bh7_w9_0 <= t8_tile_0_filtered_output(2);
   bh7_w10_0 <= t8_tile_0_filtered_output(3);
   bh7_w11_0 <= t8_tile_0_filtered_output(4);
   bh7_w12_0 <= t8_tile_0_filtered_output(5);
   bh7_w13_0 <= t8_tile_0_filtered_output(6);
   bh7_w14_0 <= t8_tile_0_filtered_output(7);
   bh7_w15_0 <= t8_tile_0_filtered_output(8);
   bh7_w16_0 <= t8_tile_0_filtered_output(9);
   bh7_w17_0 <= t8_tile_0_filtered_output(10);
   bh7_w18_0 <= t8_tile_0_filtered_output(11);
   bh7_w19_0 <= t8_tile_0_filtered_output(12);
   bh7_w20_0 <= t8_tile_0_filtered_output(13);
   bh7_w21_0 <= t8_tile_0_filtered_output(14);
   bh7_w22_0 <= t8_tile_0_filtered_output(15);
   bh7_w23_0 <= t8_tile_0_filtered_output(16);
   bh7_w24_0 <= t8_tile_0_filtered_output(17);
   bh7_w25_0 <= t8_tile_0_filtered_output(18);
   bh7_w26_0 <= t8_tile_0_filtered_output(19);
   bh7_w27_0 <= t8_tile_0_filtered_output(20);
   bh7_w28_0 <= t8_tile_0_filtered_output(21);
   bh7_w29_0 <= t8_tile_0_filtered_output(22);
   bh7_w30_0 <= t8_tile_0_filtered_output(23);
   bh7_w31_0 <= t8_tile_0_filtered_output(24);
   bh7_w32_0 <= t8_tile_0_filtered_output(25);
   bh7_w33_0 <= t8_tile_0_filtered_output(26);
   bh7_w34_0 <= t8_tile_0_filtered_output(27);
   bh7_w35_0 <= t8_tile_0_filtered_output(28);
   bh7_w36_0 <= t8_tile_0_filtered_output(29);
   bh7_w37_0 <= t8_tile_0_filtered_output(30);
   bh7_w38_0 <= t8_tile_0_filtered_output(31);
   bh7_w39_0 <= t8_tile_0_filtered_output(32);
   bh7_w40_0 <= t8_tile_0_filtered_output(33);
   bh7_w41_0 <= t8_tile_0_filtered_output(34);
   bh7_w42_0 <= t8_tile_0_filtered_output(35);
   bh7_w43_0 <= t8_tile_0_filtered_output(36);
   bh7_w44_0 <= t8_tile_0_filtered_output(37);
   bh7_w45_0 <= t8_tile_0_filtered_output(38);
   bh7_w46_0 <= t8_tile_0_filtered_output(39);
   bh7_w47_0 <= t8_tile_0_filtered_output(40);
   t8_tile_1_X <= X(23 downto 21);
   t8_tile_1_Y <= Y(6 downto 4);
   t8_tile_1: IntMultiplierLUT_3x3_Freq200_uid12
      port map ( clk  => clk,
                 X => t8_tile_1_X,
                 Y => t8_tile_1_Y,
                 R => t8_tile_1_output);

   t8_tile_1_filtered_output <= unsigned(t8_tile_1_output(5 downto 0));
   bh7_w25_1 <= t8_tile_1_filtered_output(0);
   bh7_w26_1 <= t8_tile_1_filtered_output(1);
   bh7_w27_1 <= t8_tile_1_filtered_output(2);
   bh7_w28_1 <= t8_tile_1_filtered_output(3);
   bh7_w29_1 <= t8_tile_1_filtered_output(4);
   bh7_w30_1 <= t8_tile_1_filtered_output(5);
   t8_tile_2_X <= X(23 downto 21);
   t8_tile_2_Y <= Y(3 downto 1);
   t8_tile_2: IntMultiplierLUT_3x3_Freq200_uid17
      port map ( clk  => clk,
                 X => t8_tile_2_X,
                 Y => t8_tile_2_Y,
                 R => t8_tile_2_output);

   t8_tile_2_filtered_output <= unsigned(t8_tile_2_output(5 downto 0));
   bh7_w22_1 <= t8_tile_2_filtered_output(0);
   bh7_w23_1 <= t8_tile_2_filtered_output(1);
   bh7_w24_1 <= t8_tile_2_filtered_output(2);
   bh7_w25_2 <= t8_tile_2_filtered_output(3);
   bh7_w26_2 <= t8_tile_2_filtered_output(4);
   bh7_w27_2 <= t8_tile_2_filtered_output(5);
   t8_tile_3_X <= X(20 downto 18);
   t8_tile_3_Y <= Y(6 downto 4);
   t8_tile_3: IntMultiplierLUT_3x3_Freq200_uid22
      port map ( clk  => clk,
                 X => t8_tile_3_X,
                 Y => t8_tile_3_Y,
                 R => t8_tile_3_output);

   t8_tile_3_filtered_output <= unsigned(t8_tile_3_output(5 downto 0));
   bh7_w22_2 <= t8_tile_3_filtered_output(0);
   bh7_w23_2 <= t8_tile_3_filtered_output(1);
   bh7_w24_2 <= t8_tile_3_filtered_output(2);
   bh7_w25_3 <= t8_tile_3_filtered_output(3);
   bh7_w26_3 <= t8_tile_3_filtered_output(4);
   bh7_w27_3 <= t8_tile_3_filtered_output(5);
   t8_tile_4_X <= X(23 downto 22);
   t8_tile_4_Y <= Y(0 downto 0);
   t8_tile_4: IntMultiplierLUT_2x1_Freq200_uid27
      port map ( clk  => clk,
                 X => t8_tile_4_X,
                 Y => t8_tile_4_Y,
                 R => t8_tile_4_output);

   t8_tile_4_filtered_output <= unsigned(t8_tile_4_output(1 downto 0));
   bh7_w22_3 <= t8_tile_4_filtered_output(0);
   bh7_w23_3 <= t8_tile_4_filtered_output(1);
   t8_tile_5_X <= X(20 downto 18);
   t8_tile_5_Y <= Y(3 downto 1);
   t8_tile_5: IntMultiplierLUT_3x3_Freq200_uid29
      port map ( clk  => clk,
                 X => t8_tile_5_X,
                 Y => t8_tile_5_Y,
                 R => t8_tile_5_output);

   t8_tile_5_filtered_output <= unsigned(t8_tile_5_output(5 downto 0));
   bh7_w19_1 <= t8_tile_5_filtered_output(0);
   bh7_w20_1 <= t8_tile_5_filtered_output(1);
   bh7_w21_1 <= t8_tile_5_filtered_output(2);
   bh7_w22_4 <= t8_tile_5_filtered_output(3);
   bh7_w23_4 <= t8_tile_5_filtered_output(4);
   bh7_w24_3 <= t8_tile_5_filtered_output(5);
   t8_tile_6_X <= X(17 downto 15);
   t8_tile_6_Y <= Y(6 downto 4);
   t8_tile_6: IntMultiplierLUT_3x3_Freq200_uid34
      port map ( clk  => clk,
                 X => t8_tile_6_X,
                 Y => t8_tile_6_Y,
                 R => t8_tile_6_output);

   t8_tile_6_filtered_output <= unsigned(t8_tile_6_output(5 downto 0));
   bh7_w19_2 <= t8_tile_6_filtered_output(0);
   bh7_w20_2 <= t8_tile_6_filtered_output(1);
   bh7_w21_2 <= t8_tile_6_filtered_output(2);
   bh7_w22_5 <= t8_tile_6_filtered_output(3);
   bh7_w23_5 <= t8_tile_6_filtered_output(4);
   bh7_w24_4 <= t8_tile_6_filtered_output(5);
   t8_tile_7_X <= X(21 downto 20);
   t8_tile_7_Y <= Y(0 downto 0);
   t8_tile_7: IntMultiplierLUT_2x1_Freq200_uid39
      port map ( clk  => clk,
                 X => t8_tile_7_X,
                 Y => t8_tile_7_Y,
                 R => t8_tile_7_output);

   t8_tile_7_filtered_output <= unsigned(t8_tile_7_output(1 downto 0));
   bh7_w20_3 <= t8_tile_7_filtered_output(0);
   bh7_w21_3 <= t8_tile_7_filtered_output(1);
   t8_tile_8_X <= X(17 downto 15);
   t8_tile_8_Y <= Y(3 downto 1);
   t8_tile_8: IntMultiplierLUT_3x3_Freq200_uid41
      port map ( clk  => clk,
                 X => t8_tile_8_X,
                 Y => t8_tile_8_Y,
                 R => t8_tile_8_output);

   t8_tile_8_filtered_output <= unsigned(t8_tile_8_output(5 downto 0));
   bh7_w16_1 <= t8_tile_8_filtered_output(0);
   bh7_w17_1 <= t8_tile_8_filtered_output(1);
   bh7_w18_1 <= t8_tile_8_filtered_output(2);
   bh7_w19_3 <= t8_tile_8_filtered_output(3);
   bh7_w20_4 <= t8_tile_8_filtered_output(4);
   bh7_w21_4 <= t8_tile_8_filtered_output(5);
   t8_tile_9_X <= X(14 downto 12);
   t8_tile_9_Y <= Y(6 downto 4);
   t8_tile_9: IntMultiplierLUT_3x3_Freq200_uid46
      port map ( clk  => clk,
                 X => t8_tile_9_X,
                 Y => t8_tile_9_Y,
                 R => t8_tile_9_output);

   t8_tile_9_filtered_output <= unsigned(t8_tile_9_output(5 downto 0));
   bh7_w16_2 <= t8_tile_9_filtered_output(0);
   bh7_w17_2 <= t8_tile_9_filtered_output(1);
   bh7_w18_2 <= t8_tile_9_filtered_output(2);
   bh7_w19_4 <= t8_tile_9_filtered_output(3);
   bh7_w20_5 <= t8_tile_9_filtered_output(4);
   bh7_w21_5 <= t8_tile_9_filtered_output(5);
   t8_tile_10_X <= X(19 downto 18);
   t8_tile_10_Y <= Y(0 downto 0);
   t8_tile_10: IntMultiplierLUT_2x1_Freq200_uid51
      port map ( clk  => clk,
                 X => t8_tile_10_X,
                 Y => t8_tile_10_Y,
                 R => t8_tile_10_output);

   t8_tile_10_filtered_output <= unsigned(t8_tile_10_output(1 downto 0));
   bh7_w18_3 <= t8_tile_10_filtered_output(0);
   bh7_w19_5 <= t8_tile_10_filtered_output(1);
   t8_tile_11_X <= X(17 downto 16);
   t8_tile_11_Y <= Y(0 downto 0);
   t8_tile_11: IntMultiplierLUT_2x1_Freq200_uid53
      port map ( clk  => clk,
                 X => t8_tile_11_X,
                 Y => t8_tile_11_Y,
                 R => t8_tile_11_output);

   t8_tile_11_filtered_output <= unsigned(t8_tile_11_output(1 downto 0));
   bh7_w16_3 <= t8_tile_11_filtered_output(0);
   bh7_w17_3 <= t8_tile_11_filtered_output(1);
   t8_tile_12_X <= X(14 downto 12);
   t8_tile_12_Y <= Y(3 downto 1);
   t8_tile_12: IntMultiplierLUT_3x3_Freq200_uid55
      port map ( clk  => clk,
                 X => t8_tile_12_X,
                 Y => t8_tile_12_Y,
                 R => t8_tile_12_output);

   t8_tile_12_filtered_output <= unsigned(t8_tile_12_output(5 downto 0));
   bh7_w13_1 <= t8_tile_12_filtered_output(0);
   bh7_w14_1 <= t8_tile_12_filtered_output(1);
   bh7_w15_1 <= t8_tile_12_filtered_output(2);
   bh7_w16_4 <= t8_tile_12_filtered_output(3);
   bh7_w17_4 <= t8_tile_12_filtered_output(4);
   bh7_w18_4 <= t8_tile_12_filtered_output(5);
   t8_tile_13_X <= X(11 downto 9);
   t8_tile_13_Y <= Y(6 downto 4);
   t8_tile_13: IntMultiplierLUT_3x3_Freq200_uid60
      port map ( clk  => clk,
                 X => t8_tile_13_X,
                 Y => t8_tile_13_Y,
                 R => t8_tile_13_output);

   t8_tile_13_filtered_output <= unsigned(t8_tile_13_output(5 downto 0));
   bh7_w13_2 <= t8_tile_13_filtered_output(0);
   bh7_w14_2 <= t8_tile_13_filtered_output(1);
   bh7_w15_2 <= t8_tile_13_filtered_output(2);
   bh7_w16_5 <= t8_tile_13_filtered_output(3);
   bh7_w17_5 <= t8_tile_13_filtered_output(4);
   bh7_w18_5 <= t8_tile_13_filtered_output(5);
   t8_tile_14_X <= X(15 downto 14);
   t8_tile_14_Y <= Y(0 downto 0);
   t8_tile_14: IntMultiplierLUT_2x1_Freq200_uid65
      port map ( clk  => clk,
                 X => t8_tile_14_X,
                 Y => t8_tile_14_Y,
                 R => t8_tile_14_output);

   t8_tile_14_filtered_output <= unsigned(t8_tile_14_output(1 downto 0));
   bh7_w14_3 <= t8_tile_14_filtered_output(0);
   bh7_w15_3 <= t8_tile_14_filtered_output(1);
   t8_tile_15_X <= X(11 downto 9);
   t8_tile_15_Y <= Y(3 downto 1);
   t8_tile_15: IntMultiplierLUT_3x3_Freq200_uid67
      port map ( clk  => clk,
                 X => t8_tile_15_X,
                 Y => t8_tile_15_Y,
                 R => t8_tile_15_output);

   t8_tile_15_filtered_output <= unsigned(t8_tile_15_output(5 downto 0));
   bh7_w10_1 <= t8_tile_15_filtered_output(0);
   bh7_w11_1 <= t8_tile_15_filtered_output(1);
   bh7_w12_1 <= t8_tile_15_filtered_output(2);
   bh7_w13_3 <= t8_tile_15_filtered_output(3);
   bh7_w14_4 <= t8_tile_15_filtered_output(4);
   bh7_w15_4 <= t8_tile_15_filtered_output(5);
   t8_tile_16_X <= X(8 downto 6);
   t8_tile_16_Y <= Y(6 downto 4);
   t8_tile_16: IntMultiplierLUT_3x3_Freq200_uid72
      port map ( clk  => clk,
                 X => t8_tile_16_X,
                 Y => t8_tile_16_Y,
                 R => t8_tile_16_output);

   t8_tile_16_filtered_output <= unsigned(t8_tile_16_output(5 downto 0));
   bh7_w10_2 <= t8_tile_16_filtered_output(0);
   bh7_w11_2 <= t8_tile_16_filtered_output(1);
   bh7_w12_2 <= t8_tile_16_filtered_output(2);
   bh7_w13_4 <= t8_tile_16_filtered_output(3);
   bh7_w14_5 <= t8_tile_16_filtered_output(4);
   bh7_w15_5 <= t8_tile_16_filtered_output(5);
   t8_tile_17_X <= X(13 downto 12);
   t8_tile_17_Y <= Y(0 downto 0);
   t8_tile_17: IntMultiplierLUT_2x1_Freq200_uid77
      port map ( clk  => clk,
                 X => t8_tile_17_X,
                 Y => t8_tile_17_Y,
                 R => t8_tile_17_output);

   t8_tile_17_filtered_output <= unsigned(t8_tile_17_output(1 downto 0));
   bh7_w12_3 <= t8_tile_17_filtered_output(0);
   bh7_w13_5 <= t8_tile_17_filtered_output(1);
   t8_tile_18_X <= X(11 downto 10);
   t8_tile_18_Y <= Y(0 downto 0);
   t8_tile_18: IntMultiplierLUT_2x1_Freq200_uid79
      port map ( clk  => clk,
                 X => t8_tile_18_X,
                 Y => t8_tile_18_Y,
                 R => t8_tile_18_output);

   t8_tile_18_filtered_output <= unsigned(t8_tile_18_output(1 downto 0));
   bh7_w10_3 <= t8_tile_18_filtered_output(0);
   bh7_w11_3 <= t8_tile_18_filtered_output(1);
   t8_tile_19_X <= X(8 downto 6);
   t8_tile_19_Y <= Y(3 downto 1);
   t8_tile_19: IntMultiplierLUT_3x3_Freq200_uid81
      port map ( clk  => clk,
                 X => t8_tile_19_X,
                 Y => t8_tile_19_Y,
                 R => t8_tile_19_output);

   t8_tile_19_filtered_output <= unsigned(t8_tile_19_output(5 downto 0));
   bh7_w7_1 <= t8_tile_19_filtered_output(0);
   bh7_w8_1 <= t8_tile_19_filtered_output(1);
   bh7_w9_1 <= t8_tile_19_filtered_output(2);
   bh7_w10_4 <= t8_tile_19_filtered_output(3);
   bh7_w11_4 <= t8_tile_19_filtered_output(4);
   bh7_w12_4 <= t8_tile_19_filtered_output(5);
   t8_tile_20_X <= X(5 downto 3);
   t8_tile_20_Y <= Y(6 downto 4);
   t8_tile_20: IntMultiplierLUT_3x3_Freq200_uid86
      port map ( clk  => clk,
                 X => t8_tile_20_X,
                 Y => t8_tile_20_Y,
                 R => t8_tile_20_output);

   t8_tile_20_filtered_output <= unsigned(t8_tile_20_output(5 downto 0));
   bh7_w7_2 <= t8_tile_20_filtered_output(0);
   bh7_w8_2 <= t8_tile_20_filtered_output(1);
   bh7_w9_2 <= t8_tile_20_filtered_output(2);
   bh7_w10_5 <= t8_tile_20_filtered_output(3);
   bh7_w11_5 <= t8_tile_20_filtered_output(4);
   bh7_w12_5 <= t8_tile_20_filtered_output(5);
   t8_tile_21_X <= X(9 downto 8);
   t8_tile_21_Y <= Y(0 downto 0);
   t8_tile_21: IntMultiplierLUT_2x1_Freq200_uid91
      port map ( clk  => clk,
                 X => t8_tile_21_X,
                 Y => t8_tile_21_Y,
                 R => t8_tile_21_output);

   t8_tile_21_filtered_output <= unsigned(t8_tile_21_output(1 downto 0));
   bh7_w8_3 <= t8_tile_21_filtered_output(0);
   bh7_w9_3 <= t8_tile_21_filtered_output(1);
   t8_tile_22_X <= X(5 downto 3);
   t8_tile_22_Y <= Y(3 downto 1);
   t8_tile_22: IntMultiplierLUT_3x3_Freq200_uid93
      port map ( clk  => clk,
                 X => t8_tile_22_X,
                 Y => t8_tile_22_Y,
                 R => t8_tile_22_output);

   t8_tile_22_filtered_output <= unsigned(t8_tile_22_output(5 downto 0));
   bh7_w4_0 <= t8_tile_22_filtered_output(0);
   bh7_w5_0 <= t8_tile_22_filtered_output(1);
   bh7_w6_0 <= t8_tile_22_filtered_output(2);
   bh7_w7_3 <= t8_tile_22_filtered_output(3);
   bh7_w8_4 <= t8_tile_22_filtered_output(4);
   bh7_w9_4 <= t8_tile_22_filtered_output(5);
   t8_tile_23_X <= X(2 downto 0);
   t8_tile_23_Y <= Y(6 downto 4);
   t8_tile_23: IntMultiplierLUT_3x3_Freq200_uid98
      port map ( clk  => clk,
                 X => t8_tile_23_X,
                 Y => t8_tile_23_Y,
                 R => t8_tile_23_output);

   t8_tile_23_filtered_output <= unsigned(t8_tile_23_output(5 downto 0));
   bh7_w4_1 <= t8_tile_23_filtered_output(0);
   bh7_w5_1 <= t8_tile_23_filtered_output(1);
   bh7_w6_1 <= t8_tile_23_filtered_output(2);
   bh7_w7_4 <= t8_tile_23_filtered_output(3);
   bh7_w8_5 <= t8_tile_23_filtered_output(4);
   bh7_w9_5 <= t8_tile_23_filtered_output(5);
   t8_tile_24_X <= X(7 downto 6);
   t8_tile_24_Y <= Y(0 downto 0);
   t8_tile_24: IntMultiplierLUT_2x1_Freq200_uid103
      port map ( clk  => clk,
                 X => t8_tile_24_X,
                 Y => t8_tile_24_Y,
                 R => t8_tile_24_output);

   t8_tile_24_filtered_output <= unsigned(t8_tile_24_output(1 downto 0));
   bh7_w6_2 <= t8_tile_24_filtered_output(0);
   bh7_w7_5 <= t8_tile_24_filtered_output(1);
   t8_tile_25_X <= X(5 downto 4);
   t8_tile_25_Y <= Y(0 downto 0);
   t8_tile_25: IntMultiplierLUT_2x1_Freq200_uid105
      port map ( clk  => clk,
                 X => t8_tile_25_X,
                 Y => t8_tile_25_Y,
                 R => t8_tile_25_output);

   t8_tile_25_filtered_output <= unsigned(t8_tile_25_output(1 downto 0));
   bh7_w4_2 <= t8_tile_25_filtered_output(0);
   bh7_w5_2 <= t8_tile_25_filtered_output(1);
   t8_tile_26_X <= X(2 downto 0);
   t8_tile_26_Y <= Y(3 downto 1);
   t8_tile_26: IntMultiplierLUT_3x3_Freq200_uid107
      port map ( clk  => clk,
                 X => t8_tile_26_X,
                 Y => t8_tile_26_Y,
                 R => t8_tile_26_output);

   t8_tile_26_filtered_output <= unsigned(t8_tile_26_output(5 downto 0));
   bh7_w1_0 <= t8_tile_26_filtered_output(0);
   bh7_w2_0 <= t8_tile_26_filtered_output(1);
   bh7_w3_0 <= t8_tile_26_filtered_output(2);
   bh7_w4_3 <= t8_tile_26_filtered_output(3);
   bh7_w5_3 <= t8_tile_26_filtered_output(4);
   bh7_w6_3 <= t8_tile_26_filtered_output(5);
   t8_tile_27_X <= X(3 downto 2);
   t8_tile_27_Y <= Y(0 downto 0);
   t8_tile_27: IntMultiplierLUT_2x1_Freq200_uid112
      port map ( clk  => clk,
                 X => t8_tile_27_X,
                 Y => t8_tile_27_Y,
                 R => t8_tile_27_output);

   t8_tile_27_filtered_output <= unsigned(t8_tile_27_output(1 downto 0));
   bh7_w2_1 <= t8_tile_27_filtered_output(0);
   bh7_w3_1 <= t8_tile_27_filtered_output(1);
   t8_tile_28_X <= X(1 downto 0);
   t8_tile_28_Y <= Y(0 downto 0);
   t8_tile_28: IntMultiplierLUT_2x1_Freq200_uid114
      port map ( clk  => clk,
                 X => t8_tile_28_X,
                 Y => t8_tile_28_Y,
                 R => t8_tile_28_output);

   t8_tile_28_filtered_output <= unsigned(t8_tile_28_output(1 downto 0));
   bh7_w0_0 <= t8_tile_28_filtered_output(0);
   bh7_w1_1 <= t8_tile_28_filtered_output(1);

   -- Adding the constant bits 
      -- All the constant bits are zero, nothing to add


   Compressor_23_3_Freq200_uid117_bh7_uid118_In0 <= "" & bh7_w7_0 & bh7_w7_5 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid118_In1 <= "" & bh7_w8_0 & bh7_w8_3;
   bh7_w7_6 <= Compressor_23_3_Freq200_uid117_bh7_uid118_Out0(0);
   bh7_w8_6 <= Compressor_23_3_Freq200_uid117_bh7_uid118_Out0(1);
   bh7_w9_6 <= Compressor_23_3_Freq200_uid117_bh7_uid118_Out0(2);
   Compressor_23_3_Freq200_uid117_uid118: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid118_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid118_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid118_Out0_copy119);
   Compressor_23_3_Freq200_uid117_bh7_uid118_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid118_Out0_copy119; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid120_In0 <= "" & bh7_w9_0 & bh7_w9_3 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid120_In1 <= "" & bh7_w10_0 & bh7_w10_3;
   bh7_w9_7 <= Compressor_23_3_Freq200_uid117_bh7_uid120_Out0(0);
   bh7_w10_6 <= Compressor_23_3_Freq200_uid117_bh7_uid120_Out0(1);
   bh7_w11_6 <= Compressor_23_3_Freq200_uid117_bh7_uid120_Out0(2);
   Compressor_23_3_Freq200_uid117_uid120: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid120_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid120_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid120_Out0_copy121);
   Compressor_23_3_Freq200_uid117_bh7_uid120_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid120_Out0_copy121; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid122_In0 <= "" & bh7_w11_0 & bh7_w11_3 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid122_In1 <= "" & bh7_w12_0 & bh7_w12_3;
   bh7_w11_7 <= Compressor_23_3_Freq200_uid117_bh7_uid122_Out0(0);
   bh7_w12_6 <= Compressor_23_3_Freq200_uid117_bh7_uid122_Out0(1);
   bh7_w13_6 <= Compressor_23_3_Freq200_uid117_bh7_uid122_Out0(2);
   Compressor_23_3_Freq200_uid117_uid122: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid122_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid122_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid122_Out0_copy123);
   Compressor_23_3_Freq200_uid117_bh7_uid122_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid122_Out0_copy123; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid124_In0 <= "" & bh7_w13_0 & bh7_w13_5 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid124_In1 <= "" & bh7_w14_0 & bh7_w14_3;
   bh7_w13_7 <= Compressor_23_3_Freq200_uid117_bh7_uid124_Out0(0);
   bh7_w14_6 <= Compressor_23_3_Freq200_uid117_bh7_uid124_Out0(1);
   bh7_w15_6 <= Compressor_23_3_Freq200_uid117_bh7_uid124_Out0(2);
   Compressor_23_3_Freq200_uid117_uid124: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid124_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid124_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid124_Out0_copy125);
   Compressor_23_3_Freq200_uid117_bh7_uid124_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid124_Out0_copy125; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid126_In0 <= "" & bh7_w15_0 & bh7_w15_3 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid126_In1 <= "" & bh7_w16_0 & bh7_w16_3;
   bh7_w15_7 <= Compressor_23_3_Freq200_uid117_bh7_uid126_Out0(0);
   bh7_w16_6 <= Compressor_23_3_Freq200_uid117_bh7_uid126_Out0(1);
   bh7_w17_6 <= Compressor_23_3_Freq200_uid117_bh7_uid126_Out0(2);
   Compressor_23_3_Freq200_uid117_uid126: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid126_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid126_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid126_Out0_copy127);
   Compressor_23_3_Freq200_uid117_bh7_uid126_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid126_Out0_copy127; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid128_In0 <= "" & bh7_w17_0 & bh7_w17_3 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid128_In1 <= "" & bh7_w18_0 & bh7_w18_3;
   bh7_w17_7 <= Compressor_23_3_Freq200_uid117_bh7_uid128_Out0(0);
   bh7_w18_6 <= Compressor_23_3_Freq200_uid117_bh7_uid128_Out0(1);
   bh7_w19_6 <= Compressor_23_3_Freq200_uid117_bh7_uid128_Out0(2);
   Compressor_23_3_Freq200_uid117_uid128: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid128_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid128_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid128_Out0_copy129);
   Compressor_23_3_Freq200_uid117_bh7_uid128_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid128_Out0_copy129; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid130_In0 <= "" & bh7_w19_0 & bh7_w19_5 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid130_In1 <= "" & bh7_w20_0 & bh7_w20_3;
   bh7_w19_7 <= Compressor_23_3_Freq200_uid117_bh7_uid130_Out0(0);
   bh7_w20_6 <= Compressor_23_3_Freq200_uid117_bh7_uid130_Out0(1);
   bh7_w21_6 <= Compressor_23_3_Freq200_uid117_bh7_uid130_Out0(2);
   Compressor_23_3_Freq200_uid117_uid130: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid130_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid130_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid130_Out0_copy131);
   Compressor_23_3_Freq200_uid117_bh7_uid130_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid130_Out0_copy131; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid132_In0 <= "" & bh7_w21_0 & bh7_w21_3 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid132_In1 <= "" & bh7_w22_0 & bh7_w22_3;
   bh7_w21_7 <= Compressor_23_3_Freq200_uid117_bh7_uid132_Out0(0);
   bh7_w22_6 <= Compressor_23_3_Freq200_uid117_bh7_uid132_Out0(1);
   bh7_w23_6 <= Compressor_23_3_Freq200_uid117_bh7_uid132_Out0(2);
   Compressor_23_3_Freq200_uid117_uid132: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid132_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid132_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid132_Out0_copy133);
   Compressor_23_3_Freq200_uid117_bh7_uid132_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid132_Out0_copy133; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid136_In0 <= "" & bh7_w23_0 & bh7_w23_3 & "0" & "0";
   Compressor_14_3_Freq200_uid135_bh7_uid136_In1 <= "" & bh7_w24_0;
   bh7_w23_7 <= Compressor_14_3_Freq200_uid135_bh7_uid136_Out0(0);
   bh7_w24_5 <= Compressor_14_3_Freq200_uid135_bh7_uid136_Out0(1);
   bh7_w25_4 <= Compressor_14_3_Freq200_uid135_bh7_uid136_Out0(2);
   Compressor_14_3_Freq200_uid135_uid136: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid136_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid136_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid136_Out0_copy137);
   Compressor_14_3_Freq200_uid135_bh7_uid136_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid136_Out0_copy137; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid138_In0 <= "" & bh7_w1_1 & bh7_w1_0 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid138_In1 <= "" & bh7_w2_1 & bh7_w2_0;
   bh7_w1_2 <= Compressor_23_3_Freq200_uid117_bh7_uid138_Out0(0);
   bh7_w2_2 <= Compressor_23_3_Freq200_uid117_bh7_uid138_Out0(1);
   bh7_w3_2 <= Compressor_23_3_Freq200_uid117_bh7_uid138_Out0(2);
   Compressor_23_3_Freq200_uid117_uid138: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid138_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid138_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid138_Out0_copy139);
   Compressor_23_3_Freq200_uid117_bh7_uid138_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid138_Out0_copy139; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid142_In0 <= "" & bh7_w3_1 & bh7_w3_0 & "0";
   bh7_w3_3 <= Compressor_3_2_Freq200_uid141_bh7_uid142_Out0(0);
   bh7_w4_4 <= Compressor_3_2_Freq200_uid141_bh7_uid142_Out0(1);
   Compressor_3_2_Freq200_uid141_uid142: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid142_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid142_Out0_copy143);
   Compressor_3_2_Freq200_uid141_bh7_uid142_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid142_Out0_copy143; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid144_In0 <= "" & bh7_w4_2 & bh7_w4_0 & bh7_w4_1 & bh7_w4_3;
   Compressor_14_3_Freq200_uid135_bh7_uid144_In1 <= "" & bh7_w5_2;
   bh7_w4_5 <= Compressor_14_3_Freq200_uid135_bh7_uid144_Out0(0);
   bh7_w5_4 <= Compressor_14_3_Freq200_uid135_bh7_uid144_Out0(1);
   bh7_w6_4 <= Compressor_14_3_Freq200_uid135_bh7_uid144_Out0(2);
   Compressor_14_3_Freq200_uid135_uid144: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid144_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid144_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid144_Out0_copy145);
   Compressor_14_3_Freq200_uid135_bh7_uid144_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid144_Out0_copy145; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid146_In0 <= "" & bh7_w5_0 & bh7_w5_1 & bh7_w5_3;
   bh7_w5_5 <= Compressor_3_2_Freq200_uid141_bh7_uid146_Out0(0);
   bh7_w6_5 <= Compressor_3_2_Freq200_uid141_bh7_uid146_Out0(1);
   Compressor_3_2_Freq200_uid141_uid146: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid146_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid146_Out0_copy147);
   Compressor_3_2_Freq200_uid141_bh7_uid146_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid146_Out0_copy147; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid148_In0 <= "" & bh7_w6_2 & bh7_w6_0 & bh7_w6_1 & bh7_w6_3;
   Compressor_14_3_Freq200_uid135_bh7_uid148_In1 <= "" & bh7_w7_1;
   bh7_w6_6 <= Compressor_14_3_Freq200_uid135_bh7_uid148_Out0(0);
   bh7_w7_7 <= Compressor_14_3_Freq200_uid135_bh7_uid148_Out0(1);
   bh7_w8_7 <= Compressor_14_3_Freq200_uid135_bh7_uid148_Out0(2);
   Compressor_14_3_Freq200_uid135_uid148: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid148_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid148_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid148_Out0_copy149);
   Compressor_14_3_Freq200_uid135_bh7_uid148_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid148_Out0_copy149; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid150_In0 <= "" & bh7_w7_2 & bh7_w7_3 & bh7_w7_4 & bh7_w7_6;
   Compressor_14_3_Freq200_uid135_bh7_uid150_In1 <= "" & bh7_w8_1;
   bh7_w7_8 <= Compressor_14_3_Freq200_uid135_bh7_uid150_Out0(0);
   bh7_w8_8 <= Compressor_14_3_Freq200_uid135_bh7_uid150_Out0(1);
   bh7_w9_8 <= Compressor_14_3_Freq200_uid135_bh7_uid150_Out0(2);
   Compressor_14_3_Freq200_uid135_uid150: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid150_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid150_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid150_Out0_copy151);
   Compressor_14_3_Freq200_uid135_bh7_uid150_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid150_Out0_copy151; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid152_In0 <= "" & bh7_w8_2 & bh7_w8_4 & bh7_w8_5;
   bh7_w8_9 <= Compressor_3_2_Freq200_uid141_bh7_uid152_Out0(0);
   bh7_w9_9 <= Compressor_3_2_Freq200_uid141_bh7_uid152_Out0(1);
   Compressor_3_2_Freq200_uid141_uid152: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid152_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid152_Out0_copy153);
   Compressor_3_2_Freq200_uid141_bh7_uid152_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid152_Out0_copy153; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid156_In0 <= "" & bh7_w9_1 & bh7_w9_2 & bh7_w9_4 & bh7_w9_5 & bh7_w9_7 & bh7_w9_6;
   bh7_w9_10 <= Compressor_6_3_Freq200_uid155_bh7_uid156_Out0(0);
   bh7_w10_7 <= Compressor_6_3_Freq200_uid155_bh7_uid156_Out0(1);
   bh7_w11_8 <= Compressor_6_3_Freq200_uid155_bh7_uid156_Out0(2);
   Compressor_6_3_Freq200_uid155_uid156: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid156_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid156_Out0_copy157);
   Compressor_6_3_Freq200_uid155_bh7_uid156_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid156_Out0_copy157; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid160_In0 <= "" & bh7_w10_1 & bh7_w10_2 & bh7_w10_4 & bh7_w10_5 & bh7_w10_6;
   bh7_w10_8 <= Compressor_5_3_Freq200_uid159_bh7_uid160_Out0(0);
   bh7_w11_9 <= Compressor_5_3_Freq200_uid159_bh7_uid160_Out0(1);
   bh7_w12_7 <= Compressor_5_3_Freq200_uid159_bh7_uid160_Out0(2);
   Compressor_5_3_Freq200_uid159_uid160: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid160_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid160_Out0_copy161);
   Compressor_5_3_Freq200_uid159_bh7_uid160_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid160_Out0_copy161; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid162_In0 <= "" & bh7_w11_1 & bh7_w11_2 & bh7_w11_4 & bh7_w11_5 & bh7_w11_7 & bh7_w11_6;
   bh7_w11_10 <= Compressor_6_3_Freq200_uid155_bh7_uid162_Out0(0);
   bh7_w12_8 <= Compressor_6_3_Freq200_uid155_bh7_uid162_Out0(1);
   bh7_w13_8 <= Compressor_6_3_Freq200_uid155_bh7_uid162_Out0(2);
   Compressor_6_3_Freq200_uid155_uid162: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid162_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid162_Out0_copy163);
   Compressor_6_3_Freq200_uid155_bh7_uid162_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid162_Out0_copy163; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid164_In0 <= "" & bh7_w12_1 & bh7_w12_2 & bh7_w12_4 & bh7_w12_5 & bh7_w12_6;
   bh7_w12_9 <= Compressor_5_3_Freq200_uid159_bh7_uid164_Out0(0);
   bh7_w13_9 <= Compressor_5_3_Freq200_uid159_bh7_uid164_Out0(1);
   bh7_w14_7 <= Compressor_5_3_Freq200_uid159_bh7_uid164_Out0(2);
   Compressor_5_3_Freq200_uid159_uid164: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid164_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid164_Out0_copy165);
   Compressor_5_3_Freq200_uid159_bh7_uid164_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid164_Out0_copy165; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid166_In0 <= "" & bh7_w13_1 & bh7_w13_2 & bh7_w13_3 & bh7_w13_4 & bh7_w13_7 & bh7_w13_6;
   bh7_w13_10 <= Compressor_6_3_Freq200_uid155_bh7_uid166_Out0(0);
   bh7_w14_8 <= Compressor_6_3_Freq200_uid155_bh7_uid166_Out0(1);
   bh7_w15_8 <= Compressor_6_3_Freq200_uid155_bh7_uid166_Out0(2);
   Compressor_6_3_Freq200_uid155_uid166: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid166_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid166_Out0_copy167);
   Compressor_6_3_Freq200_uid155_bh7_uid166_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid166_Out0_copy167; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid168_In0 <= "" & bh7_w14_1 & bh7_w14_2 & bh7_w14_4 & bh7_w14_5 & bh7_w14_6;
   bh7_w14_9 <= Compressor_5_3_Freq200_uid159_bh7_uid168_Out0(0);
   bh7_w15_9 <= Compressor_5_3_Freq200_uid159_bh7_uid168_Out0(1);
   bh7_w16_7 <= Compressor_5_3_Freq200_uid159_bh7_uid168_Out0(2);
   Compressor_5_3_Freq200_uid159_uid168: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid168_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid168_Out0_copy169);
   Compressor_5_3_Freq200_uid159_bh7_uid168_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid168_Out0_copy169; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid170_In0 <= "" & bh7_w15_1 & bh7_w15_2 & bh7_w15_4 & bh7_w15_5 & bh7_w15_7 & bh7_w15_6;
   bh7_w15_10 <= Compressor_6_3_Freq200_uid155_bh7_uid170_Out0(0);
   bh7_w16_8 <= Compressor_6_3_Freq200_uid155_bh7_uid170_Out0(1);
   bh7_w17_8 <= Compressor_6_3_Freq200_uid155_bh7_uid170_Out0(2);
   Compressor_6_3_Freq200_uid155_uid170: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid170_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid170_Out0_copy171);
   Compressor_6_3_Freq200_uid155_bh7_uid170_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid170_Out0_copy171; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid172_In0 <= "" & bh7_w16_1 & bh7_w16_2 & bh7_w16_4 & bh7_w16_5 & bh7_w16_6;
   bh7_w16_9 <= Compressor_5_3_Freq200_uid159_bh7_uid172_Out0(0);
   bh7_w17_9 <= Compressor_5_3_Freq200_uid159_bh7_uid172_Out0(1);
   bh7_w18_7 <= Compressor_5_3_Freq200_uid159_bh7_uid172_Out0(2);
   Compressor_5_3_Freq200_uid159_uid172: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid172_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid172_Out0_copy173);
   Compressor_5_3_Freq200_uid159_bh7_uid172_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid172_Out0_copy173; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid174_In0 <= "" & bh7_w17_1 & bh7_w17_2 & bh7_w17_4 & bh7_w17_5 & bh7_w17_7 & bh7_w17_6;
   bh7_w17_10 <= Compressor_6_3_Freq200_uid155_bh7_uid174_Out0(0);
   bh7_w18_8 <= Compressor_6_3_Freq200_uid155_bh7_uid174_Out0(1);
   bh7_w19_8 <= Compressor_6_3_Freq200_uid155_bh7_uid174_Out0(2);
   Compressor_6_3_Freq200_uid155_uid174: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid174_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid174_Out0_copy175);
   Compressor_6_3_Freq200_uid155_bh7_uid174_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid174_Out0_copy175; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid176_In0 <= "" & bh7_w18_1 & bh7_w18_2 & bh7_w18_4 & bh7_w18_5 & bh7_w18_6;
   bh7_w18_9 <= Compressor_5_3_Freq200_uid159_bh7_uid176_Out0(0);
   bh7_w19_9 <= Compressor_5_3_Freq200_uid159_bh7_uid176_Out0(1);
   bh7_w20_7 <= Compressor_5_3_Freq200_uid159_bh7_uid176_Out0(2);
   Compressor_5_3_Freq200_uid159_uid176: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid176_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid176_Out0_copy177);
   Compressor_5_3_Freq200_uid159_bh7_uid176_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid176_Out0_copy177; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid178_In0 <= "" & bh7_w19_1 & bh7_w19_2 & bh7_w19_3 & bh7_w19_4 & bh7_w19_7 & bh7_w19_6;
   bh7_w19_10 <= Compressor_6_3_Freq200_uid155_bh7_uid178_Out0(0);
   bh7_w20_8 <= Compressor_6_3_Freq200_uid155_bh7_uid178_Out0(1);
   bh7_w21_8 <= Compressor_6_3_Freq200_uid155_bh7_uid178_Out0(2);
   Compressor_6_3_Freq200_uid155_uid178: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid178_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid178_Out0_copy179);
   Compressor_6_3_Freq200_uid155_bh7_uid178_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid178_Out0_copy179; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid180_In0 <= "" & bh7_w20_1 & bh7_w20_2 & bh7_w20_4 & bh7_w20_5 & bh7_w20_6;
   bh7_w20_9 <= Compressor_5_3_Freq200_uid159_bh7_uid180_Out0(0);
   bh7_w21_9 <= Compressor_5_3_Freq200_uid159_bh7_uid180_Out0(1);
   bh7_w22_7 <= Compressor_5_3_Freq200_uid159_bh7_uid180_Out0(2);
   Compressor_5_3_Freq200_uid159_uid180: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid180_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid180_Out0_copy181);
   Compressor_5_3_Freq200_uid159_bh7_uid180_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid180_Out0_copy181; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid182_In0 <= "" & bh7_w21_1 & bh7_w21_2 & bh7_w21_4 & bh7_w21_5 & bh7_w21_7 & bh7_w21_6;
   bh7_w21_10 <= Compressor_6_3_Freq200_uid155_bh7_uid182_Out0(0);
   bh7_w22_8 <= Compressor_6_3_Freq200_uid155_bh7_uid182_Out0(1);
   bh7_w23_8 <= Compressor_6_3_Freq200_uid155_bh7_uid182_Out0(2);
   Compressor_6_3_Freq200_uid155_uid182: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid182_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid182_Out0_copy183);
   Compressor_6_3_Freq200_uid155_bh7_uid182_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid182_Out0_copy183; -- output copy to hold a pipeline register if needed


   Compressor_5_3_Freq200_uid159_bh7_uid184_In0 <= "" & bh7_w22_1 & bh7_w22_2 & bh7_w22_4 & bh7_w22_5 & bh7_w22_6;
   bh7_w22_9 <= Compressor_5_3_Freq200_uid159_bh7_uid184_Out0(0);
   bh7_w23_9 <= Compressor_5_3_Freq200_uid159_bh7_uid184_Out0(1);
   bh7_w24_6 <= Compressor_5_3_Freq200_uid159_bh7_uid184_Out0(2);
   Compressor_5_3_Freq200_uid159_uid184: Compressor_5_3_Freq200_uid159
      port map ( X0 => Compressor_5_3_Freq200_uid159_bh7_uid184_In0,
                 R => Compressor_5_3_Freq200_uid159_bh7_uid184_Out0_copy185);
   Compressor_5_3_Freq200_uid159_bh7_uid184_Out0 <= Compressor_5_3_Freq200_uid159_bh7_uid184_Out0_copy185; -- output copy to hold a pipeline register if needed


   Compressor_6_3_Freq200_uid155_bh7_uid186_In0 <= "" & bh7_w23_1 & bh7_w23_2 & bh7_w23_4 & bh7_w23_5 & bh7_w23_7 & bh7_w23_6;
   bh7_w23_10 <= Compressor_6_3_Freq200_uid155_bh7_uid186_Out0(0);
   bh7_w24_7 <= Compressor_6_3_Freq200_uid155_bh7_uid186_Out0(1);
   bh7_w25_5 <= Compressor_6_3_Freq200_uid155_bh7_uid186_Out0(2);
   Compressor_6_3_Freq200_uid155_uid186: Compressor_6_3_Freq200_uid155
      port map ( X0 => Compressor_6_3_Freq200_uid155_bh7_uid186_In0,
                 R => Compressor_6_3_Freq200_uid155_bh7_uid186_Out0_copy187);
   Compressor_6_3_Freq200_uid155_bh7_uid186_Out0 <= Compressor_6_3_Freq200_uid155_bh7_uid186_Out0_copy187; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid188_In0 <= "" & bh7_w24_1 & bh7_w24_2 & bh7_w24_3 & bh7_w24_4;
   Compressor_14_3_Freq200_uid135_bh7_uid188_In1 <= "" & bh7_w25_0;
   bh7_w24_8 <= Compressor_14_3_Freq200_uid135_bh7_uid188_Out0(0);
   bh7_w25_6 <= Compressor_14_3_Freq200_uid135_bh7_uid188_Out0(1);
   bh7_w26_4 <= Compressor_14_3_Freq200_uid135_bh7_uid188_Out0(2);
   Compressor_14_3_Freq200_uid135_uid188: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid188_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid188_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid188_Out0_copy189);
   Compressor_14_3_Freq200_uid135_bh7_uid188_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid188_Out0_copy189; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid190_In0 <= "" & bh7_w25_1 & bh7_w25_2 & bh7_w25_3 & bh7_w25_4;
   Compressor_14_3_Freq200_uid135_bh7_uid190_In1 <= "" & bh7_w26_0;
   bh7_w25_7 <= Compressor_14_3_Freq200_uid135_bh7_uid190_Out0(0);
   bh7_w26_5 <= Compressor_14_3_Freq200_uid135_bh7_uid190_Out0(1);
   bh7_w27_4 <= Compressor_14_3_Freq200_uid135_bh7_uid190_Out0(2);
   Compressor_14_3_Freq200_uid135_uid190: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid190_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid190_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid190_Out0_copy191);
   Compressor_14_3_Freq200_uid135_bh7_uid190_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid190_Out0_copy191; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid192_In0 <= "" & bh7_w26_1 & bh7_w26_2 & bh7_w26_3;
   bh7_w26_6 <= Compressor_3_2_Freq200_uid141_bh7_uid192_Out0(0);
   bh7_w27_5 <= Compressor_3_2_Freq200_uid141_bh7_uid192_Out0(1);
   Compressor_3_2_Freq200_uid141_uid192: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid192_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid192_Out0_copy193);
   Compressor_3_2_Freq200_uid141_bh7_uid192_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid192_Out0_copy193; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid194_In0 <= "" & bh7_w27_0 & bh7_w27_1 & bh7_w27_2 & bh7_w27_3;
   Compressor_14_3_Freq200_uid135_bh7_uid194_In1 <= "" & bh7_w28_0;
   bh7_w27_6 <= Compressor_14_3_Freq200_uid135_bh7_uid194_Out0(0);
   bh7_w28_2 <= Compressor_14_3_Freq200_uid135_bh7_uid194_Out0(1);
   bh7_w29_2 <= Compressor_14_3_Freq200_uid135_bh7_uid194_Out0(2);
   Compressor_14_3_Freq200_uid135_uid194: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid194_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid194_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid194_Out0_copy195);
   Compressor_14_3_Freq200_uid135_bh7_uid194_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid194_Out0_copy195; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid196_In0 <= "" & bh7_w29_0 & bh7_w29_1 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid196_In1 <= "" & bh7_w30_0 & bh7_w30_1;
   bh7_w29_3 <= Compressor_23_3_Freq200_uid117_bh7_uid196_Out0(0);
   bh7_w30_2 <= Compressor_23_3_Freq200_uid117_bh7_uid196_Out0(1);
   bh7_w31_1 <= Compressor_23_3_Freq200_uid117_bh7_uid196_Out0(2);
   Compressor_23_3_Freq200_uid117_uid196: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid196_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid196_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid196_Out0_copy197);
   Compressor_23_3_Freq200_uid117_bh7_uid196_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid196_Out0_copy197; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid198_In0 <= "" & bh7_w3_3 & bh7_w3_2 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid198_In1 <= "" & bh7_w4_5 & bh7_w4_4;
   bh7_w3_4 <= Compressor_23_3_Freq200_uid117_bh7_uid198_Out0(0);
   bh7_w4_6 <= Compressor_23_3_Freq200_uid117_bh7_uid198_Out0(1);
   bh7_w5_6 <= Compressor_23_3_Freq200_uid117_bh7_uid198_Out0(2);
   Compressor_23_3_Freq200_uid117_uid198: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid198_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid198_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid198_Out0_copy199);
   Compressor_23_3_Freq200_uid117_bh7_uid198_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid198_Out0_copy199; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid200_In0 <= "" & bh7_w5_5 & bh7_w5_4 & "0";
   bh7_w5_7 <= Compressor_3_2_Freq200_uid141_bh7_uid200_Out0(0);
   bh7_w6_7 <= Compressor_3_2_Freq200_uid141_bh7_uid200_Out0(1);
   Compressor_3_2_Freq200_uid141_uid200: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid200_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid200_Out0_copy201);
   Compressor_3_2_Freq200_uid141_bh7_uid200_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid200_Out0_copy201; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid202_In0 <= "" & bh7_w6_6 & bh7_w6_5 & bh7_w6_4;
   Compressor_23_3_Freq200_uid117_bh7_uid202_In1 <= "" & bh7_w7_7 & bh7_w7_8;
   bh7_w6_8 <= Compressor_23_3_Freq200_uid117_bh7_uid202_Out0(0);
   bh7_w7_9 <= Compressor_23_3_Freq200_uid117_bh7_uid202_Out0(1);
   bh7_w8_10 <= Compressor_23_3_Freq200_uid117_bh7_uid202_Out0(2);
   Compressor_23_3_Freq200_uid117_uid202: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid202_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid202_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid202_Out0_copy203);
   Compressor_23_3_Freq200_uid117_bh7_uid202_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid202_Out0_copy203; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid204_In0 <= "" & bh7_w8_6 & bh7_w8_9 & bh7_w8_7 & bh7_w8_8;
   Compressor_14_3_Freq200_uid135_bh7_uid204_In1 <= "" & "0";
   bh7_w8_11 <= Compressor_14_3_Freq200_uid135_bh7_uid204_Out0(0);
   bh7_w9_11 <= Compressor_14_3_Freq200_uid135_bh7_uid204_Out0(1);
   bh7_w10_9 <= Compressor_14_3_Freq200_uid135_bh7_uid204_Out0(2);
   Compressor_14_3_Freq200_uid135_uid204: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid204_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid204_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid204_Out0_copy205);
   Compressor_14_3_Freq200_uid135_bh7_uid204_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid204_Out0_copy205; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid206_In0 <= "" & bh7_w9_9 & bh7_w9_8 & bh7_w9_10;
   Compressor_23_3_Freq200_uid117_bh7_uid206_In1 <= "" & bh7_w10_8 & bh7_w10_7;
   bh7_w9_12 <= Compressor_23_3_Freq200_uid117_bh7_uid206_Out0(0);
   bh7_w10_10 <= Compressor_23_3_Freq200_uid117_bh7_uid206_Out0(1);
   bh7_w11_11 <= Compressor_23_3_Freq200_uid117_bh7_uid206_Out0(2);
   Compressor_23_3_Freq200_uid117_uid206: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid206_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid206_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid206_Out0_copy207);
   Compressor_23_3_Freq200_uid117_bh7_uid206_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid206_Out0_copy207; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid208_In0 <= "" & bh7_w11_9 & bh7_w11_10 & bh7_w11_8;
   Compressor_23_3_Freq200_uid117_bh7_uid208_In1 <= "" & bh7_w12_9 & bh7_w12_7;
   bh7_w11_12 <= Compressor_23_3_Freq200_uid117_bh7_uid208_Out0(0);
   bh7_w12_10 <= Compressor_23_3_Freq200_uid117_bh7_uid208_Out0(1);
   bh7_w13_11 <= Compressor_23_3_Freq200_uid117_bh7_uid208_Out0(2);
   Compressor_23_3_Freq200_uid117_uid208: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid208_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid208_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid208_Out0_copy209);
   Compressor_23_3_Freq200_uid117_bh7_uid208_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid208_Out0_copy209; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid210_In0 <= "" & bh7_w13_9 & bh7_w13_10 & bh7_w13_8;
   Compressor_23_3_Freq200_uid117_bh7_uid210_In1 <= "" & bh7_w14_9 & bh7_w14_7;
   bh7_w13_12 <= Compressor_23_3_Freq200_uid117_bh7_uid210_Out0(0);
   bh7_w14_10 <= Compressor_23_3_Freq200_uid117_bh7_uid210_Out0(1);
   bh7_w15_11 <= Compressor_23_3_Freq200_uid117_bh7_uid210_Out0(2);
   Compressor_23_3_Freq200_uid117_uid210: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid210_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid210_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid210_Out0_copy211);
   Compressor_23_3_Freq200_uid117_bh7_uid210_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid210_Out0_copy211; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid212_In0 <= "" & bh7_w15_9 & bh7_w15_10 & bh7_w15_8;
   Compressor_23_3_Freq200_uid117_bh7_uid212_In1 <= "" & bh7_w16_9 & bh7_w16_7;
   bh7_w15_12 <= Compressor_23_3_Freq200_uid117_bh7_uid212_Out0(0);
   bh7_w16_10 <= Compressor_23_3_Freq200_uid117_bh7_uid212_Out0(1);
   bh7_w17_11 <= Compressor_23_3_Freq200_uid117_bh7_uid212_Out0(2);
   Compressor_23_3_Freq200_uid117_uid212: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid212_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid212_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid212_Out0_copy213);
   Compressor_23_3_Freq200_uid117_bh7_uid212_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid212_Out0_copy213; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid214_In0 <= "" & bh7_w17_9 & bh7_w17_10 & bh7_w17_8;
   Compressor_23_3_Freq200_uid117_bh7_uid214_In1 <= "" & bh7_w18_9 & bh7_w18_7;
   bh7_w17_12 <= Compressor_23_3_Freq200_uid117_bh7_uid214_Out0(0);
   bh7_w18_10 <= Compressor_23_3_Freq200_uid117_bh7_uid214_Out0(1);
   bh7_w19_11 <= Compressor_23_3_Freq200_uid117_bh7_uid214_Out0(2);
   Compressor_23_3_Freq200_uid117_uid214: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid214_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid214_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid214_Out0_copy215);
   Compressor_23_3_Freq200_uid117_bh7_uid214_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid214_Out0_copy215; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid216_In0 <= "" & bh7_w19_9 & bh7_w19_10 & bh7_w19_8;
   Compressor_23_3_Freq200_uid117_bh7_uid216_In1 <= "" & bh7_w20_9 & bh7_w20_7;
   bh7_w19_12 <= Compressor_23_3_Freq200_uid117_bh7_uid216_Out0(0);
   bh7_w20_10 <= Compressor_23_3_Freq200_uid117_bh7_uid216_Out0(1);
   bh7_w21_11 <= Compressor_23_3_Freq200_uid117_bh7_uid216_Out0(2);
   Compressor_23_3_Freq200_uid117_uid216: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid216_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid216_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid216_Out0_copy217);
   Compressor_23_3_Freq200_uid117_bh7_uid216_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid216_Out0_copy217; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid218_In0 <= "" & bh7_w21_9 & bh7_w21_10 & bh7_w21_8;
   Compressor_23_3_Freq200_uid117_bh7_uid218_In1 <= "" & bh7_w22_9 & bh7_w22_7;
   bh7_w21_12 <= Compressor_23_3_Freq200_uid117_bh7_uid218_Out0(0);
   bh7_w22_10 <= Compressor_23_3_Freq200_uid117_bh7_uid218_Out0(1);
   bh7_w23_11 <= Compressor_23_3_Freq200_uid117_bh7_uid218_Out0(2);
   Compressor_23_3_Freq200_uid117_uid218: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid218_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid218_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid218_Out0_copy219);
   Compressor_23_3_Freq200_uid117_bh7_uid218_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid218_Out0_copy219; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid220_In0 <= "" & bh7_w23_9 & bh7_w23_10 & bh7_w23_8;
   bh7_w23_12 <= Compressor_3_2_Freq200_uid141_bh7_uid220_Out0(0);
   bh7_w24_9 <= Compressor_3_2_Freq200_uid141_bh7_uid220_Out0(1);
   Compressor_3_2_Freq200_uid141_uid220: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid220_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid220_Out0_copy221);
   Compressor_3_2_Freq200_uid141_bh7_uid220_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid220_Out0_copy221; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid222_In0 <= "" & bh7_w24_5 & bh7_w24_8 & bh7_w24_6 & bh7_w24_7;
   Compressor_14_3_Freq200_uid135_bh7_uid222_In1 <= "" & "0";
   bh7_w24_10 <= Compressor_14_3_Freq200_uid135_bh7_uid222_Out0(0);
   bh7_w25_8 <= Compressor_14_3_Freq200_uid135_bh7_uid222_Out0(1);
   bh7_w26_7 <= Compressor_14_3_Freq200_uid135_bh7_uid222_Out0(2);
   Compressor_14_3_Freq200_uid135_uid222: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid222_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid222_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid222_Out0_copy223);
   Compressor_14_3_Freq200_uid135_bh7_uid222_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid222_Out0_copy223; -- output copy to hold a pipeline register if needed


   Compressor_3_2_Freq200_uid141_bh7_uid224_In0 <= "" & bh7_w25_6 & bh7_w25_7 & bh7_w25_5;
   bh7_w25_9 <= Compressor_3_2_Freq200_uid141_bh7_uid224_Out0(0);
   bh7_w26_8 <= Compressor_3_2_Freq200_uid141_bh7_uid224_Out0(1);
   Compressor_3_2_Freq200_uid141_uid224: Compressor_3_2_Freq200_uid141
      port map ( X0 => Compressor_3_2_Freq200_uid141_bh7_uid224_In0,
                 R => Compressor_3_2_Freq200_uid141_bh7_uid224_Out0_copy225);
   Compressor_3_2_Freq200_uid141_bh7_uid224_Out0 <= Compressor_3_2_Freq200_uid141_bh7_uid224_Out0_copy225; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid226_In0 <= "" & bh7_w26_6 & bh7_w26_4 & bh7_w26_5;
   Compressor_23_3_Freq200_uid117_bh7_uid226_In1 <= "" & bh7_w27_6 & bh7_w27_5;
   bh7_w26_9 <= Compressor_23_3_Freq200_uid117_bh7_uid226_Out0(0);
   bh7_w27_7 <= Compressor_23_3_Freq200_uid117_bh7_uid226_Out0(1);
   bh7_w28_3 <= Compressor_23_3_Freq200_uid117_bh7_uid226_Out0(2);
   Compressor_23_3_Freq200_uid117_uid226: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid226_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid226_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid226_Out0_copy227);
   Compressor_23_3_Freq200_uid117_bh7_uid226_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid226_Out0_copy227; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid228_In0 <= "" & bh7_w28_1 & bh7_w28_2 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid228_In1 <= "" & bh7_w29_3 & bh7_w29_2;
   bh7_w28_4 <= Compressor_23_3_Freq200_uid117_bh7_uid228_Out0(0);
   bh7_w29_4 <= Compressor_23_3_Freq200_uid117_bh7_uid228_Out0(1);
   bh7_w30_3 <= Compressor_23_3_Freq200_uid117_bh7_uid228_Out0(2);
   Compressor_23_3_Freq200_uid117_uid228: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid228_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid228_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid228_Out0_copy229);
   Compressor_23_3_Freq200_uid117_bh7_uid228_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid228_Out0_copy229; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid230_In0 <= "" & bh7_w31_0 & bh7_w31_1 & "0" & "0";
   Compressor_14_3_Freq200_uid135_bh7_uid230_In1 <= "" & bh7_w32_0;
   bh7_w31_2 <= Compressor_14_3_Freq200_uid135_bh7_uid230_Out0(0);
   bh7_w32_1 <= Compressor_14_3_Freq200_uid135_bh7_uid230_Out0(1);
   bh7_w33_1 <= Compressor_14_3_Freq200_uid135_bh7_uid230_Out0(2);
   Compressor_14_3_Freq200_uid135_uid230: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid230_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid230_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid230_Out0_copy231);
   Compressor_14_3_Freq200_uid135_bh7_uid230_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid230_Out0_copy231; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid232_In0 <= "" & bh7_w5_7 & bh7_w5_6 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid232_In1 <= "" & bh7_w6_7 & bh7_w6_8;
   bh7_w5_8 <= Compressor_23_3_Freq200_uid117_bh7_uid232_Out0(0);
   bh7_w6_9 <= Compressor_23_3_Freq200_uid117_bh7_uid232_Out0(1);
   bh7_w7_10 <= Compressor_23_3_Freq200_uid117_bh7_uid232_Out0(2);
   Compressor_23_3_Freq200_uid117_uid232: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid232_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid232_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid232_Out0_copy233);
   Compressor_23_3_Freq200_uid117_bh7_uid232_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid232_Out0_copy233; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid234_In0 <= "" & bh7_w8_11 & bh7_w8_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid234_In1 <= "" & bh7_w9_11 & bh7_w9_12;
   bh7_w8_12 <= Compressor_23_3_Freq200_uid117_bh7_uid234_Out0(0);
   bh7_w9_13 <= Compressor_23_3_Freq200_uid117_bh7_uid234_Out0(1);
   bh7_w10_11 <= Compressor_23_3_Freq200_uid117_bh7_uid234_Out0(2);
   Compressor_23_3_Freq200_uid117_uid234: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid234_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid234_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid234_Out0_copy235);
   Compressor_23_3_Freq200_uid117_bh7_uid234_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid234_Out0_copy235; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid236_In0 <= "" & bh7_w10_9 & bh7_w10_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid236_In1 <= "" & bh7_w11_12 & bh7_w11_11;
   bh7_w10_12 <= Compressor_23_3_Freq200_uid117_bh7_uid236_Out0(0);
   bh7_w11_13 <= Compressor_23_3_Freq200_uid117_bh7_uid236_Out0(1);
   bh7_w12_11 <= Compressor_23_3_Freq200_uid117_bh7_uid236_Out0(2);
   Compressor_23_3_Freq200_uid117_uid236: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid236_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid236_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid236_Out0_copy237);
   Compressor_23_3_Freq200_uid117_bh7_uid236_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid236_Out0_copy237; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid238_In0 <= "" & bh7_w12_8 & bh7_w12_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid238_In1 <= "" & bh7_w13_12 & bh7_w13_11;
   bh7_w12_12 <= Compressor_23_3_Freq200_uid117_bh7_uid238_Out0(0);
   bh7_w13_13 <= Compressor_23_3_Freq200_uid117_bh7_uid238_Out0(1);
   bh7_w14_11 <= Compressor_23_3_Freq200_uid117_bh7_uid238_Out0(2);
   Compressor_23_3_Freq200_uid117_uid238: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid238_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid238_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid238_Out0_copy239);
   Compressor_23_3_Freq200_uid117_bh7_uid238_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid238_Out0_copy239; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid240_In0 <= "" & bh7_w14_8 & bh7_w14_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid240_In1 <= "" & bh7_w15_12 & bh7_w15_11;
   bh7_w14_12 <= Compressor_23_3_Freq200_uid117_bh7_uid240_Out0(0);
   bh7_w15_13 <= Compressor_23_3_Freq200_uid117_bh7_uid240_Out0(1);
   bh7_w16_11 <= Compressor_23_3_Freq200_uid117_bh7_uid240_Out0(2);
   Compressor_23_3_Freq200_uid117_uid240: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid240_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid240_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid240_Out0_copy241);
   Compressor_23_3_Freq200_uid117_bh7_uid240_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid240_Out0_copy241; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid242_In0 <= "" & bh7_w16_8 & bh7_w16_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid242_In1 <= "" & bh7_w17_12 & bh7_w17_11;
   bh7_w16_12 <= Compressor_23_3_Freq200_uid117_bh7_uid242_Out0(0);
   bh7_w17_13 <= Compressor_23_3_Freq200_uid117_bh7_uid242_Out0(1);
   bh7_w18_11 <= Compressor_23_3_Freq200_uid117_bh7_uid242_Out0(2);
   Compressor_23_3_Freq200_uid117_uid242: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid242_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid242_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid242_Out0_copy243);
   Compressor_23_3_Freq200_uid117_bh7_uid242_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid242_Out0_copy243; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid244_In0 <= "" & bh7_w18_8 & bh7_w18_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid244_In1 <= "" & bh7_w19_12 & bh7_w19_11;
   bh7_w18_12 <= Compressor_23_3_Freq200_uid117_bh7_uid244_Out0(0);
   bh7_w19_13 <= Compressor_23_3_Freq200_uid117_bh7_uid244_Out0(1);
   bh7_w20_11 <= Compressor_23_3_Freq200_uid117_bh7_uid244_Out0(2);
   Compressor_23_3_Freq200_uid117_uid244: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid244_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid244_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid244_Out0_copy245);
   Compressor_23_3_Freq200_uid117_bh7_uid244_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid244_Out0_copy245; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid246_In0 <= "" & bh7_w20_8 & bh7_w20_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid246_In1 <= "" & bh7_w21_12 & bh7_w21_11;
   bh7_w20_12 <= Compressor_23_3_Freq200_uid117_bh7_uid246_Out0(0);
   bh7_w21_13 <= Compressor_23_3_Freq200_uid117_bh7_uid246_Out0(1);
   bh7_w22_11 <= Compressor_23_3_Freq200_uid117_bh7_uid246_Out0(2);
   Compressor_23_3_Freq200_uid117_uid246: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid246_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid246_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid246_Out0_copy247);
   Compressor_23_3_Freq200_uid117_bh7_uid246_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid246_Out0_copy247; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid248_In0 <= "" & bh7_w22_8 & bh7_w22_10 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid248_In1 <= "" & bh7_w23_12 & bh7_w23_11;
   bh7_w22_12 <= Compressor_23_3_Freq200_uid117_bh7_uid248_Out0(0);
   bh7_w23_13 <= Compressor_23_3_Freq200_uid117_bh7_uid248_Out0(1);
   bh7_w24_11 <= Compressor_23_3_Freq200_uid117_bh7_uid248_Out0(2);
   Compressor_23_3_Freq200_uid117_uid248: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid248_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid248_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid248_Out0_copy249);
   Compressor_23_3_Freq200_uid117_bh7_uid248_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid248_Out0_copy249; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid250_In0 <= "" & bh7_w24_10 & bh7_w24_9 & "0";
   Compressor_23_3_Freq200_uid117_bh7_uid250_In1 <= "" & bh7_w25_8 & bh7_w25_9;
   bh7_w24_12 <= Compressor_23_3_Freq200_uid117_bh7_uid250_Out0(0);
   bh7_w25_10 <= Compressor_23_3_Freq200_uid117_bh7_uid250_Out0(1);
   bh7_w26_10 <= Compressor_23_3_Freq200_uid117_bh7_uid250_Out0(2);
   Compressor_23_3_Freq200_uid117_uid250: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid250_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid250_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid250_Out0_copy251);
   Compressor_23_3_Freq200_uid117_bh7_uid250_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid250_Out0_copy251; -- output copy to hold a pipeline register if needed


   Compressor_23_3_Freq200_uid117_bh7_uid252_In0 <= "" & bh7_w26_7 & bh7_w26_9 & bh7_w26_8;
   Compressor_23_3_Freq200_uid117_bh7_uid252_In1 <= "" & bh7_w27_4 & bh7_w27_7;
   bh7_w26_11 <= Compressor_23_3_Freq200_uid117_bh7_uid252_Out0(0);
   bh7_w27_8 <= Compressor_23_3_Freq200_uid117_bh7_uid252_Out0(1);
   bh7_w28_5 <= Compressor_23_3_Freq200_uid117_bh7_uid252_Out0(2);
   Compressor_23_3_Freq200_uid117_uid252: Compressor_23_3_Freq200_uid117
      port map ( X0 => Compressor_23_3_Freq200_uid117_bh7_uid252_In0,
                 X1 => Compressor_23_3_Freq200_uid117_bh7_uid252_In1,
                 R => Compressor_23_3_Freq200_uid117_bh7_uid252_Out0_copy253);
   Compressor_23_3_Freq200_uid117_bh7_uid252_Out0 <= Compressor_23_3_Freq200_uid117_bh7_uid252_Out0_copy253; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid254_In0 <= "" & bh7_w28_4 & bh7_w28_3 & "0" & "0";
   Compressor_14_3_Freq200_uid135_bh7_uid254_In1 <= "" & bh7_w29_4;
   bh7_w28_6 <= Compressor_14_3_Freq200_uid135_bh7_uid254_Out0(0);
   bh7_w29_5 <= Compressor_14_3_Freq200_uid135_bh7_uid254_Out0(1);
   bh7_w30_4 <= Compressor_14_3_Freq200_uid135_bh7_uid254_Out0(2);
   Compressor_14_3_Freq200_uid135_uid254: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid254_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid254_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid254_Out0_copy255);
   Compressor_14_3_Freq200_uid135_bh7_uid254_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid254_Out0_copy255; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid256_In0 <= "" & bh7_w30_2 & bh7_w30_3 & "0" & "0";
   Compressor_14_3_Freq200_uid135_bh7_uid256_In1 <= "" & bh7_w31_2;
   bh7_w30_5 <= Compressor_14_3_Freq200_uid135_bh7_uid256_Out0(0);
   bh7_w31_3 <= Compressor_14_3_Freq200_uid135_bh7_uid256_Out0(1);
   bh7_w32_2 <= Compressor_14_3_Freq200_uid135_bh7_uid256_Out0(2);
   Compressor_14_3_Freq200_uid135_uid256: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid256_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid256_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid256_Out0_copy257);
   Compressor_14_3_Freq200_uid135_bh7_uid256_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid256_Out0_copy257; -- output copy to hold a pipeline register if needed


   Compressor_14_3_Freq200_uid135_bh7_uid258_In0 <= "" & bh7_w33_0 & bh7_w33_1 & "0" & "0";
   Compressor_14_3_Freq200_uid135_bh7_uid258_In1 <= "" & bh7_w34_0;
   bh7_w33_2 <= Compressor_14_3_Freq200_uid135_bh7_uid258_Out0(0);
   bh7_w34_1 <= Compressor_14_3_Freq200_uid135_bh7_uid258_Out0(1);
   bh7_w35_1 <= Compressor_14_3_Freq200_uid135_bh7_uid258_Out0(2);
   Compressor_14_3_Freq200_uid135_uid258: Compressor_14_3_Freq200_uid135
      port map ( X0 => Compressor_14_3_Freq200_uid135_bh7_uid258_In0,
                 X1 => Compressor_14_3_Freq200_uid135_bh7_uid258_In1,
                 R => Compressor_14_3_Freq200_uid135_bh7_uid258_Out0_copy259);
   Compressor_14_3_Freq200_uid135_bh7_uid258_Out0 <= Compressor_14_3_Freq200_uid135_bh7_uid258_Out0_copy259; -- output copy to hold a pipeline register if needed

   tmp_bitheapResult_bh7_6 <= bh7_w6_9 & bh7_w5_8 & bh7_w4_6 & bh7_w3_4 & bh7_w2_2 & bh7_w1_2 & bh7_w0_0;

   bitheapFinalAdd_bh7_In0 <= "" & bh7_w47_0 & bh7_w46_0 & bh7_w45_0 & bh7_w44_0 & bh7_w43_0 & bh7_w42_0 & bh7_w41_0 & bh7_w40_0 & bh7_w39_0 & bh7_w38_0 & bh7_w37_0 & bh7_w36_0 & bh7_w35_0 & bh7_w34_1 & bh7_w33_2 & bh7_w32_1 & bh7_w31_3 & bh7_w30_5 & bh7_w29_5 & bh7_w28_5 & bh7_w27_8 & bh7_w26_10 & bh7_w25_10 & bh7_w24_12 & bh7_w23_13 & bh7_w22_12 & bh7_w21_13 & bh7_w20_12 & bh7_w19_13 & bh7_w18_12 & bh7_w17_13 & bh7_w16_12 & bh7_w15_13 & bh7_w14_12 & bh7_w13_13 & bh7_w12_11 & bh7_w11_13 & bh7_w10_11 & bh7_w9_13 & bh7_w8_12 & bh7_w7_9;
   bitheapFinalAdd_bh7_In1 <= "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & bh7_w35_1 & "0" & "0" & bh7_w32_2 & "0" & bh7_w30_4 & "0" & bh7_w28_6 & "0" & bh7_w26_11 & "0" & bh7_w24_11 & "0" & bh7_w22_11 & "0" & bh7_w20_11 & "0" & bh7_w18_11 & "0" & bh7_w16_11 & "0" & bh7_w14_11 & "0" & bh7_w12_12 & "0" & bh7_w10_12 & "0" & "0" & bh7_w7_10;
   bitheapFinalAdd_bh7_Cin <= '0';

   bitheapFinalAdd_bh7: IntAdder_41_Freq200_uid261
      port map ( clk  => clk,
                 Cin => bitheapFinalAdd_bh7_Cin,
                 X => bitheapFinalAdd_bh7_In0,
                 Y => bitheapFinalAdd_bh7_In1,
                 R => bitheapFinalAdd_bh7_Out);
   bitheapResult_bh7 <= bitheapFinalAdd_bh7_Out(40 downto 0) & tmp_bitheapResult_bh7_6;
   R <= bitheapResult_bh7(47 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                         IntAdder_33_Freq200_uid264
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y Cin
-- Output signals: R
--  approx. input signal timings: X: (c0, 2.065000ns)Y: (c0, 0.000000ns)Cin: (c0, 2.502500ns)
--  approx. output signal timings: R: (c0, 3.123500ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_33_Freq200_uid264 is
    port (clk : in std_logic;
          X : in  std_logic_vector(32 downto 0);
          Y : in  std_logic_vector(32 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(32 downto 0)   );
end entity;

architecture arch of IntAdder_33_Freq200_uid264 is
signal Rtmp :  std_logic_vector(32 downto 0);
   -- timing of Rtmp: (c0, 3.123500ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                       FPMult_8_23_uid2_Freq200_uid3
-- VHDL generated for VirtexUltrascalePlus @ 200MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2021
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 5
-- Target frequency (MHz): 200
-- Input signals: X Y
-- Output signals: R
--  approx. input signal timings: X: (c0, 0.000000ns)Y: (c0, 0.000000ns)
--  approx. output signal timings: R: (c0, 3.123500ns)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPMult_8_23_uid2_Freq200_uid3 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPMult_8_23_uid2_Freq200_uid3 is
   component IntMultiplier_24x24_48_Freq200_uid5 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;

   component IntAdder_33_Freq200_uid264 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(32 downto 0);
             Y : in  std_logic_vector(32 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(32 downto 0)   );
   end component;

signal sign :  std_logic;
   -- timing of sign: (c0, 0.035000ns)
signal expX :  std_logic_vector(7 downto 0);
   -- timing of expX: (c0, 0.000000ns)
signal expY :  std_logic_vector(7 downto 0);
   -- timing of expY: (c0, 0.000000ns)
signal expSumPreSub :  std_logic_vector(9 downto 0);
   -- timing of expSumPreSub: (c0, 0.498000ns)
signal bias :  std_logic_vector(9 downto 0);
   -- timing of bias: (c0, 0.000000ns)
signal expSum :  std_logic_vector(9 downto 0);
   -- timing of expSum: (c0, 0.996000ns)
signal sigX :  std_logic_vector(23 downto 0);
   -- timing of sigX: (c0, 0.000000ns)
signal sigY :  std_logic_vector(23 downto 0);
   -- timing of sigY: (c0, 0.000000ns)
signal sigProd :  std_logic_vector(47 downto 0);
   -- timing of sigProd: (c0, 1.850000ns)
signal excSel :  std_logic_vector(3 downto 0);
   -- timing of excSel: (c0, 0.000000ns)
signal exc :  std_logic_vector(1 downto 0);
   -- timing of exc: (c0, 0.035000ns)
signal norm :  std_logic;
   -- timing of norm: (c0, 1.850000ns)
signal expPostNorm :  std_logic_vector(9 downto 0);
   -- timing of expPostNorm: (c0, 1.850000ns)
signal sigProdExt :  std_logic_vector(47 downto 0);
   -- timing of sigProdExt: (c0, 2.065000ns)
signal expSig :  std_logic_vector(32 downto 0);
   -- timing of expSig: (c0, 2.065000ns)
signal sticky :  std_logic;
   -- timing of sticky: (c0, 2.065000ns)
signal guard :  std_logic;
   -- timing of guard: (c0, 2.287500ns)
signal round :  std_logic;
   -- timing of round: (c0, 2.502500ns)
signal expSigPostRound :  std_logic_vector(32 downto 0);
   -- timing of expSigPostRound: (c0, 3.123500ns)
signal excPostNorm :  std_logic_vector(1 downto 0);
   -- timing of excPostNorm: (c0, 3.123500ns)
signal finalExc :  std_logic_vector(1 downto 0);
   -- timing of finalExc: (c0, 3.123500ns)
begin
   sign <= X(31) xor Y(31);
   expX <= X(30 downto 23);
   expY <= Y(30 downto 23);
   expSumPreSub <= ("00" & expX) + ("00" & expY);
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub - bias;
   sigX <= "1" & X(22 downto 0);
   sigY <= "1" & Y(22 downto 0);
   SignificandMultiplication: IntMultiplier_24x24_48_Freq200_uid5
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
   RoundingAdder: IntAdder_33_Freq200_uid264
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
   with exc  select  
   finalExc <= exc when  "11"|"10"|"00",
                       excPostNorm when others; 
   R <= finalExc & sign & expSigPostRound(30 downto 0);
end architecture;

