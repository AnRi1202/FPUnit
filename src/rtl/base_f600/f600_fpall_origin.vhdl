library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Unified Floating-Point Unit Wrapper (FloPoCo-based Baseline - F600)
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

entity f600_fpall_origin is
    generic (
        NUM_OPS : integer := 6 -- 1:Add, 3:Mul, 2:Add/Mul, 4:All_FP32, 5:Add_FP32_BF16, 6:All, 7:Mul_FP32_BF16
    );
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0); 
        X      : in  std_logic_vector(33 downto 0); -- FloPoCo 34-bit format
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of f600_fpall_origin is
    -- FP32 Components (Freq600)
    component FPAdd_8_23_Freq600_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPMult_8_23_uid2_Freq600_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPSqrt_8_23 is
        port (clk : in std_logic; X : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPDiv_8_23_Freq600_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;

    -- BF16 Components (Freq600)
    component FPAdd_8_7_Freq600_uid2 is 
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;
    component FPMult_8_7_uid2_Freq600_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;

    signal add_R, mul_R, sqrt_R, div_R : std_logic_vector(33 downto 0) := (others => '0');
    signal bfadd_R, bfmult_R : std_logic_vector(33 downto 0) := (others => '0');
    signal bfadd_h, bfadd_l, bfmul_h, bfmul_l : std_logic_vector(17 downto 0) := (others => '0');
    signal X_bf_l, Y_bf_l : std_logic_vector(17 downto 0);
    
begin
    -- FP32 Add (Present unless Mul Only modes: 3 or 7)
    GEN_ADD: if NUM_OPS /= 3 and NUM_OPS /= 7 generate
        U_ADD: FPAdd_8_23_Freq600_uid2 port map(clk=>clk, X=>X, Y=>Y, R=>add_R);
    end generate;
    GEN_NO_ADD: if NUM_OPS = 3 or NUM_OPS = 7 generate
        add_R <= (others => '0');
    end generate;

    -- FP32 Mul (Present unless Add Only modes: 1 or 5)
    GEN_MUL: if NUM_OPS /= 1 and NUM_OPS /= 5 generate
        U_MUL: FPMult_8_23_uid2_Freq600_uid3 port map(clk=>clk, X=>X, Y=>Y, R=>mul_R);
    end generate;
    GEN_NO_MUL: if NUM_OPS = 1 or NUM_OPS = 5 generate
        mul_R <= (others => '0');
    end generate;

    -- Sqrt/Div (Present for NUM_OPS 4 (mixed) or 6 (all))
    GEN_SQRT_DIV: if NUM_OPS = 4 or NUM_OPS = 6 generate
        U_SQRT: FPSqrt_8_23 port map(clk=>clk, X=>X, R=>sqrt_R);
        U_DIV:  FPDiv_8_23_Freq600_uid2 port map(clk=>clk, X=>X, Y=>Y, R=>div_R);
    end generate;
    GEN_NO_SQRT_DIV: if NUM_OPS /= 4 and NUM_OPS /= 6 generate
        sqrt_R <= (others => '0');
        div_R  <= (others => '0');
    end generate;

    -- BF16 Ops (Present for 5, 6, 7)
    GEN_BF16: if NUM_OPS >= 5 generate
        X_bf_l <= "00" & X(15 downto 0);
        Y_bf_l <= "00" & Y(15 downto 0);

        -- BF16 ADD (Modes 5 and 6)
        GEN_BF_ADD: if NUM_OPS = 5 or NUM_OPS = 6 generate
            -- Upper lane [33:16]
            U_BFADD_H: FPAdd_8_7_Freq600_uid2 port map(clk=>clk, X=>X(33 downto 16), Y=>Y(33 downto 16), R=>bfadd_h);
            -- Lower lane [15:0]
            U_BFADD_L: FPAdd_8_7_Freq600_uid2 port map(clk=>clk, X=>X_bf_l, Y=>Y_bf_l, R=>bfadd_l);
            bfadd_R  <= bfadd_h  & bfadd_l(15 downto 0);
        end generate;
        
        GEN_NO_BF_ADD: if NUM_OPS = 7 generate
            bfadd_R <= (others => '0');
            bfadd_h <= (others => '0');
            bfadd_l <= (others => '0');
        end generate;

        -- BF16 MUL (Modes 6 and 7)
        GEN_BF_MUL: if NUM_OPS = 6 or NUM_OPS = 7 generate
            -- Upper lane [33:16]
            U_BFMUL_H: FPMult_8_7_uid2_Freq600_uid3 port map(clk=>clk, X=>X(33 downto 16), Y=>Y(33 downto 16), R=>bfmul_h);
            -- Lower lane [15:0]
            U_BFMUL_L: FPMult_8_7_uid2_Freq600_uid3 port map(clk=>clk, X=>X_bf_l, Y=>Y_bf_l, R=>bfmul_l);
            bfmult_R <= bfmul_h & bfmul_l(15 downto 0);
        end generate;

        GEN_NO_BF_MUL: if NUM_OPS = 5 generate
            bfmult_R <= (others => '0');
            bfmul_h  <= (others => '0');
            bfmul_l  <= (others => '0');
        end generate;
    end generate;
    
    GEN_NO_BF16: if NUM_OPS < 5 generate
         bfadd_R <= (others => '0');
         bfmult_R <= (others => '0');
    end generate;

    -- Output Logic based on NUM_OPS
    -- If only one operation is active, bypass the mux.
    GEN_OUT_1: if NUM_OPS = 1 generate
        R <= add_R;
    end generate;

    GEN_OUT_3: if NUM_OPS = 3 generate
        R <= mul_R;
    end generate;

    GEN_OUT_5: if NUM_OPS = 5 generate
        -- Add & BFAdd
        with opcode select
            R <= add_R    when "000",
                 bfadd_R  when "100",
                 (others => '0') when others;
    end generate;

    GEN_OUT_7: if NUM_OPS = 7 generate
        -- Mul & BFMul
        with opcode select
            R <= mul_R    when "001",
                 bfmult_R when "101",
                 (others => '0') when others;
    end generate;
    
    -- For mixed operations (2, 4, 6), use the Full Mux
    GEN_OUT_MUX: if NUM_OPS = 2 or NUM_OPS = 4 or NUM_OPS = 6 generate
        with opcode select
            R <= add_R    when "000",
                 mul_R    when "001",
                 sqrt_R   when "010",
                 div_R    when "011",
                 bfadd_R  when "100",
                 bfmult_R when "101",
                 (others => '0') when others;
    end generate;
end architecture;
