library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity f400_fracadd_origin is
    port(
        clk: in std_logic;
        op: in std_logic_vector(2 downto 0); -- add, mult, div, sqrt, bfadd, bfmult
        X: in std_logic_vector(33 downto 0);
        Y: in std_logic_vector(33 downto 0);
        R: out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of f400_fracadd_origin is 
    component FPAdd_8_23_Freq400_uid2 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            Y : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPAdd_8_7_Freq400_uid2 is 
    port (clk : in std_logic;
          X : in  std_logic_vector(8+7+2 downto 0);
          Y : in  std_logic_vector(8+7+2 downto 0);
          R : out  std_logic_vector(8+7+2 downto 0)   );
    end component;

    signal add_R : std_logic_vector(33 downto 0);
    signal X_bf_l : std_logic_vector(17 downto 0);
    signal Y_bf_l : std_logic_vector(17 downto 0); 
    signal bfadd_R : std_logic_vector(33 downto 0);
    signal bfadd_R_h,bfadd_R_l: std_logic_vector(17 downto 0);

    begin
    -- FP32 units
    U_ADD: FPAdd_8_23_Freq400_uid2
    port map(clk=>clk, X=>X, Y=>Y, R=>add_R);

    -- upper lane
    U_BFADD_H: FPAdd_8_7_Freq400_uid2
    port map(
        clk => clk,
        X   => X(33 downto 16),
        Y   => Y(33 downto 16),
        R   => bfadd_R_h
    );
    
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);

    -- lower lane
    U_BFADD_L: FPAdd_8_7_Freq400_uid2
    port map(
        clk => clk,
        X => X_bf_l,
        Y => Y_bf_l,
        R   => bfadd_R_l
    );

    -- pack result
    bfadd_R  <= bfadd_R_h & bfadd_R_l(15 downto 0);

    with op select
    R <= add_R    when "000",
        bfadd_R  when "100",
        (others => '0') when others;
end architecture;
