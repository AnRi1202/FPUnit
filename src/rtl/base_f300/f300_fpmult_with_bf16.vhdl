-- ===========================================================================
-- FPMult (retimed IntMult) + BF16 Mul x2 wrapper  (Freq300 MHz)
-- Opcode 001: FP32 Mul  (34-bit FloPoCo format)
-- Opcode 101: BF16 Mul  upper lane [33:16] & lower lane [15:0]
-- ===========================================================================
library ieee;
use ieee.std_logic_1164.all;

entity f300_fpmult_with_bf16 is
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0);
        X      : in  std_logic_vector(33 downto 0);
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of f300_fpmult_with_bf16 is
    -- FP32 Multiplier (nomult shell – IntMult provided as retimed netlist)
    component FPMult_8_23_uid2_Freq300_uid3 is
        port (clk : in std_logic;
              X, Y : in  std_logic_vector(33 downto 0);
              R    : out std_logic_vector(33 downto 0));
    end component;

    -- BF16 Multiplier (9-bit mantissa, 8-bit exponent -> 18-bit FloPoCo format)
    component FPMult_8_7_uid2_Freq300_uid3 is
        port (clk : in std_logic;
              X, Y : in  std_logic_vector(17 downto 0);
              R    : out std_logic_vector(17 downto 0));
    end component;

    signal fp32_R              : std_logic_vector(33 downto 0) := (others => '0');
    signal bfmul_h_R, bfmul_l_R : std_logic_vector(17 downto 0) := (others => '0');
    signal bf16_R              : std_logic_vector(33 downto 0) := (others => '0');
    signal X_bf_l, Y_bf_l     : std_logic_vector(17 downto 0);

begin
    -- FP32 Multiplier (retimed IntMult netlist merged via link)
    U_FP32MUL: FPMult_8_23_uid2_Freq300_uid3
        port map (clk => clk, X => X, Y => Y, R => fp32_R);

    -- BF16 Lanes (upper = bits[33:16], lower = bits[15:0])
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);

    U_BFMUL_H: FPMult_8_7_uid2_Freq300_uid3
        port map (clk => clk, X => X(33 downto 16), Y => Y(33 downto 16), R => bfmul_h_R);
    U_BFMUL_L: FPMult_8_7_uid2_Freq300_uid3
        port map (clk => clk, X => X_bf_l,          Y => Y_bf_l,          R => bfmul_l_R);
    bf16_R <= bfmul_h_R & bfmul_l_R(15 downto 0);

    -- Output mux
    with opcode select
        R <= fp32_R  when "001",
             bf16_R  when "101",
             (others => '0') when others;
end architecture;
