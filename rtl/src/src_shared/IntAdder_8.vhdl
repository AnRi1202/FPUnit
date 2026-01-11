library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IntAdder_8 is
    port(
        clk : in std_logic;
        in0: in std_logic_vector(7 downto 0);
        in1: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
    );
end IntAdder_8;

architecture arch of IntAdder_8 is
    begin
        output <= in0 + in1;
end architecture;