library ieee;
use ieee.std_logic_1164.all;

entity bit_mux is
    port(
        clk: in std_logic;
        sel: in std_logic;
        in0: in std_logic;
        in1: in std_logic;
        dout: out std_logic
    );
end entity;

architecture arch of bit_mux is 
begin
    dout <= in0 when sel = '0' else in1;
end architecture;
