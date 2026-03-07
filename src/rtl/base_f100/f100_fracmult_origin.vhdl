library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


-- exc removed: 32-bit IEEE format. mult: * (no DSP)
entity f100_fracmult_origin is
    port(
        clk: in std_logic;
        op: in std_logic_vector(2 downto 0); -- add, mult, div, sqrt, bfadd, bfmult
        X: in std_logic_vector(31 downto 0);
        Y: in std_logic_vector(31 downto 0);
        R: out std_logic_vector(31 downto 0)
    );
end entity;



architecture arch of f100_fracmult_origin is 
    component FPAdd_8_23_Freq100_uid2 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            Y : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPMult_8_23_uid2_Freq100_uid3 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            Y : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPSqrt_8_23 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPDiv_8_23_Freq100_uid2 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
    end component; 

    component FPAdd_8_7_Freq100_uid2 is 
    port (clk : in std_logic;
          X : in  std_logic_vector(8+7+2 downto 0);
          Y : in  std_logic_vector(8+7+2 downto 0);
          R : out  std_logic_vector(8+7+2 downto 0)   );
    end component;

    component FPMult_8_7_uid2_Freq100_uid3 is
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

    signal mul_R : std_logic_vector(33 downto 0);
    signal bfmult_R : std_logic_vector(33 downto 0);
    signal bfmult_R_h,bfmult_R_l: std_logic_vector(17 downto 0);

    signal sqrt_R: std_logic_vector(33 downto 0);
    signal div_R : std_logic_vector(33 downto 0);
    signal fpc_X, fpc_Y : std_logic_vector(33 downto 0);
    signal fpc_X_upper, fpc_Y_upper : std_logic_vector(17 downto 0);

    begin
    fpc_X <= "01" & X;  fpc_Y <= "01" & Y;
    fpc_X_upper <= "01" & X(31 downto 16);  fpc_Y_upper <= "01" & Y(31 downto 16);
    -- FP32 units
    U_ADD: FPAdd_8_23_Freq100_uid2
    port map(clk=>clk, X=>fpc_X, Y=>fpc_Y, R=>add_R);

    U_MUL: FPMult_8_23_uid2_Freq100_uid3
    port map(clk=>clk, X=>fpc_X, Y=>fpc_Y, R=>mul_R);

    U_SQRT: FPSqrt_8_23
    port map(clk=>clk, X=>fpc_X, R=>sqrt_R);

    U_DIV: FPDiv_8_23_Freq100_uid2
    port map(clk=>clk, X=>fpc_X, Y=>fpc_Y, R=>div_R);

    -- upper lane [31:16], pad exc=01
    U_BFADD_H: FPAdd_8_7_Freq100_uid2
    port map(clk => clk, X => fpc_X_upper, Y => fpc_Y_upper, R => bfadd_R_h);
    
    U_BFMULT_H: FPMult_8_7_uid2_Freq100_uid3
    port map(clk => clk, X => fpc_X_upper, Y => fpc_Y_upper, R => bfmult_R_h);
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);

    -- lower lane
    U_BFADD_L: FPAdd_8_7_Freq100_uid2
    port map(
        clk => clk,
        X => X_bf_l,
        Y => Y_bf_l,
        R   => bfadd_R_l
    );

    U_BFMULT_L: FPMult_8_7_uid2_Freq100_uid3
    port map(
        clk => clk,
        X => X_bf_l,
        Y => Y_bf_l,
        R   => bfmult_R_l
    );
    -- pack result
    bfadd_R  <= bfadd_R_h & bfadd_R_l(15 downto 0);
    bfmult_R <= bfmult_R_h & bfmult_R_l(15 downto 0);

    with op select
    R <= mul_R(31 downto 0)    when "001",
        div_R(31 downto 0)    when "010",
        sqrt_R(31 downto 0)   when "011",
        bfadd_R(31 downto 0)  when "100",
        bfmult_R(31 downto 0) when "101",
        (others => '0') when others;
end architecture;


