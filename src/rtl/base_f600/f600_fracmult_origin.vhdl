library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity f600_fracmult_origin is
    port(
        clk: in std_logic;
        op: in std_logic_vector(2 downto 0); -- add, mult, div, sqrt, bfadd, bfmult
        X: in std_logic_vector(33 downto 0);
        Y: in std_logic_vector(33 downto 0);
        R: out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of f600_fracmult_origin is 
    component FPMult_8_23_uid2_Freq600_uid3 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            Y : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPMult_8_7_uid2_Freq600_uid3 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+7+2 downto 0);
            Y : in  std_logic_vector(8+7+2 downto 0);
            R : out  std_logic_vector(8+7+2 downto 0)   );
    end component;

    signal mul_R : std_logic_vector(33 downto 0);
    signal X_bf_l : std_logic_vector(17 downto 0);
    signal Y_bf_l : std_logic_vector(17 downto 0); 
    signal bfmult_R : std_logic_vector(33 downto 0);
    signal bfmult_R_h,bfmult_R_l: std_logic_vector(17 downto 0);

    begin
    -- FP32 units
    U_MUL: FPMult_8_23_uid2_Freq600_uid3
    port map(clk=>clk, X=>X, Y=>Y, R=>mul_R);

    -- upper lane
    U_BFMULT_H: FPMult_8_7_uid2_Freq600_uid3
    port map(
        clk => clk,
        X   => X(33 downto 16),
        Y   => Y(33 downto 16),
        R   => bfmult_R_h
    );
    
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);

    -- lower lane
    U_BFMULT_L: FPMult_8_7_uid2_Freq600_uid3
    port map(
        clk => clk,
        X => X_bf_l,
        Y => Y_bf_l,
        R   => bfmult_R_l
    );

    -- pack result
    bfmult_R <= bfmult_R_h & bfmult_R_l(15 downto 0);

    with op select
    R <= mul_R    when "001",
        bfmult_R when "101",
        (others => '0') when others;
end architecture;
