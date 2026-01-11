library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all; 
entity tb_fpsqrt_kintex is
    generic(
        NUM_TESTS : positive := 10
    );
end tb_fpsqrt_kintex;

architecture behavior of tb_fpsqrt_kintex is
    component FPSqrt_8_23
    port(
        clk : in std_logic;
        X : in std_logic_vector(33 downto 0);
        R: in std_logic_vector(33 downto 0);
    );
    end component;

    signal clk: std_logic := '0';
    signal X : in std_logic_vector(33 downto 0): (others =>'0');
    signal R: in std_logic_vector(33 downto 0): (others => '0');

    constant clk_period: time := 10 ns;
    begin
        uut: FPSqrt_8_23 port map(
            clk => clk,
            X => X,
            R => R
        );
    
    generate_clock: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1' ;
        wait for clk_period/2;
    end process;


    drive_input: process
        variable seed1, seed2: positive; -- for uniform
        variable rand_val : real;

        variable expected_real :real;
        variable result_real :real;


        begin 
        wait for 100ns;
        for i in 1 to NUM_TESTS loop
            uniform(seed1, seed2, rand_val);
        end loop;
    end process;

end behavior;

