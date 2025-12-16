
library ieee;
use ieee.std_logic_1164.all;

entity Mux34 is
    port (
        clk : in std_logic; -- Including clk to match synthesis constraints context, though strict mux is comb
        sel : in std_logic;
        A   : in std_logic_vector(33 downto 0);
        B   : in std_logic_vector(33 downto 0);
        Y   : out std_logic_vector(33 downto 0)
    );
end entity;

architecture rtl of Mux34 is
begin
    Y <= A when sel = '0' else B;
end architecture;
