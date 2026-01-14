library ieee;
use ieee.std_logic_1164.all;



entity bit_ff is
    port(
        p: in std_logic;
        clk: in std_logic;
        d: out std_logic
    );
end entity;

architecture arch of bit_ff is 
begin
    process(clk) begin
        if rising_edge(clk) then 
            d <= p;
        end if; 
    end process;
end architecture;