library ieee;
use ieee.std_logic_1164.all;

entity FPALL_Shared_Wrapper is
    generic (
        OP_CODE_GEN : std_logic_vector(1 downto 0) := "00" -- 00: Add, 01: Mul, 10: Sqrt, 11: Div
    );
    port (
        clk : in std_logic;
        X : in std_logic_vector(33 downto 0);
        Y : in std_logic_vector(33 downto 0) := (others => '0');
        R : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPALL_Shared_Wrapper is
    component FPALL_Shared_divsq is
        port (
            clk : in std_logic;
            opcode : in std_logic_vector(1 downto 0);
            X : in std_logic_vector(33 downto 0);
            Y : in std_logic_vector(33 downto 0);
            R : out std_logic_vector(33 downto 0)
        );
    end component;
begin
    U_SHARED: FPALL_Shared_divsq
    port map (
        clk => clk,
        opcode => OP_CODE_GEN,
        X => X,
        Y => Y,
        R => R
    );
end architecture;
