--------------------------------------------------------------------------------
--                         FPALL_Pipe_Shared_Wrapper
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2021
--------------------------------------------------------------------------------
-- Wrapper to expose single-op interface using Generic OpCode
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPALL_Pipe_Shared_Wrapper is
    generic (
        OP_CODE_GEN : std_logic_vector(1 downto 0) := "00" -- Default Add
    );
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPALL_Pipe_Shared_Wrapper is
   
   component FPALL_Pipe_Shared is
    port (clk : in std_logic;
          opcode : in std_logic_vector(1 downto 0);
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
   end component;

begin

   U_SHARED_UNIT: FPALL_Pipe_Shared
   port map (
      clk => clk,
      opcode => OP_CODE_GEN,
      X => X,
      Y => Y,
      R => R
   );

end architecture;
