library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Unified Floating-Point Unit Wrapper (FloPoCo-based Baseline)
-- Supports 2, 4, or 6 operations based on NUM_OPS generic.
--
-- Opcode Mapping (3rd bit for BF16, lower 2 bits match FPALL_shared):
--   000: Add (FP32)
--   001: Mul (FP32)
--   010: Sqrt (FP32)
--   011: Div (FP32)
--   100: BFAdd (BF16 x 2)
--   101: BFMul (BF16 x 2)
-- =================================================================================

entity FPALL_origin is
    generic (
        NUM_OPS : integer := 6 -- 2: Add/Mul, 4: +Sqrt/Div, 6: +BF16
    );
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0); 
        X      : in  std_logic_vector(33 downto 0); -- FloPoCo 34-bit format
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPALL_origin is
    -- FP32 Components
    component FPAdd_8_23_Freq1_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPMult_8_23_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPSqrt_8_23 is
        port (clk : in std_logic; X : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPDiv_8_23_Freq1_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;

    -- BF16 Components (8 exponent, 7 fraction, 2 exceptions = 17 bits -> vector(17 downto 0) is 18 bits)
    component FPAdd_8_7_Freq1_uid2 is 
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;
    component FPMult_8_7_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;

    signal add_R, mul_R, sqrt_R, div_R : std_logic_vector(33 downto 0) := (others => '0');
    signal bfadd_R, bfmult_R : std_logic_vector(33 downto 0) := (others => '0');
    signal bfadd_h, bfadd_l, bfmul_h, bfmul_l : std_logic_vector(17 downto 0) := (others => '0');
    signal X_bf_l, Y_bf_l : std_logic_vector(17 downto 0);
    
begin
    -- FP32 Add/Mul (Always instantiated for comparison consistency)
    U_ADD: FPAdd_8_23_Freq1_uid2 port map(clk=>clk, X=>X, Y=>Y, R=>add_R);
    U_MUL: FPMult_8_23_uid2_Freq1_uid3 port map(clk=>clk, X=>X, Y=>Y, R=>mul_R);

    -- Sqrt/Div (Present for NUM_OPS >= 4)
    GEN_SQRT_DIV: if NUM_OPS >= 4 generate
        U_SQRT: FPSqrt_8_23 port map(clk=>clk, X=>X, R=>sqrt_R);
        U_DIV:  FPDiv_8_23_Freq1_uid2 port map(clk=>clk, X=>X, Y=>Y, R=>div_R);
    end generate;

    -- BF16 Ops (Present for NUM_OPS >= 6)
    GEN_BF16: if NUM_OPS >= 6 generate
        X_bf_l <= "00" & X(15 downto 0);
        Y_bf_l <= "00" & Y(15 downto 0);
        -- Upper lane [33:16]
        U_BFADD_H: FPAdd_8_7_Freq1_uid2 port map(clk=>clk, X=>X(33 downto 16), Y=>Y(33 downto 16), R=>bfadd_h);
        U_BFMUL_H: FPMult_8_7_uid2_Freq1_uid3 port map(clk=>clk, X=>X(33 downto 16), Y=>Y(33 downto 16), R=>bfmul_h);
        -- Lower lane [15:0] + 2 bits exception padding
        U_BFADD_L: FPAdd_8_7_Freq1_uid2 port map(clk=>clk, X=>X_bf_l, Y=>Y_bf_l, R=>bfadd_l);
        U_BFMUL_L: FPMult_8_7_uid2_Freq1_uid3 port map(clk=>clk, X=>X_bf_l, Y=>Y_bf_l, R=>bfmul_l);
        
        bfadd_R  <= bfadd_h  & bfadd_l(15 downto 0);
        bfmult_R <= bfmul_h & bfmul_l(15 downto 0);
    end generate;

    -- Opcode Mux
    with opcode select
        R <= add_R    when "000",
             mul_R    when "001",
             sqrt_R   when "010",
             div_R    when "011",
             bfadd_R  when "100",
             bfmult_R when "101",
             (others => '0') when others;
end architecture;