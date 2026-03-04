library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Retiming Wrapper for FPMult (FloPoCo-based Baseline)
-- FP32 Mult + BF16 Mult x2 (upper/lower lane). Opcode selects output.
-- Op: 001=FP32 Mult, 101=BF16 Mult (2 lanes packed)
-- =================================================================================

entity FPMult_origin_ret is
    generic (
        NUM_PIPE : integer := 1
    );
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0);  -- 001=FP32 Mult, 101=BF16 Mult
        X      : in  std_logic_vector(33 downto 0);
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPMult_origin_ret is
    component FPMult_8_23_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPMult_8_7_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;

    signal mul_R, bfmult_R, R_inner : std_logic_vector(33 downto 0);
    signal bfmult_R_h, bfmult_R_l : std_logic_vector(17 downto 0);
    signal X_bf_l, Y_bf_l : std_logic_vector(17 downto 0);
    type pipe_array_t is array (0 to NUM_PIPE - 1) of std_logic_vector(33 downto 0);
    signal R_pipe : pipe_array_t := (others => (others => '0'));

begin
    -- FP32 Mult
    U_MUL : FPMult_8_23_uid2_Freq1_uid3 port map (clk => clk, X => X, Y => Y, R => mul_R);

    -- BF16 Mult x2 (upper lane [33:16], lower lane [15:0] with "00" pad)
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);
    U_BFMUL_H : FPMult_8_7_uid2_Freq1_uid3 port map (clk => clk, X => X(33 downto 16), Y => Y(33 downto 16), R => bfmult_R_h);
    U_BFMUL_L : FPMult_8_7_uid2_Freq1_uid3 port map (clk => clk, X => X_bf_l, Y => Y_bf_l, R => bfmult_R_l);
    bfmult_R <= bfmult_R_h & bfmult_R_l(15 downto 0);

    -- Mux: opcode(2)=1 -> BF16, else FP32
    R_inner <= mul_R when opcode(2) = '0' else bfmult_R;

    GEN_PIPE_0: if NUM_PIPE = 0 generate
        R <= R_inner;
    end generate;

    GEN_PIPE_N: if NUM_PIPE > 0 generate
        process(clk)
        begin
            if rising_edge(clk) then
                R_pipe(0) <= R_inner;
                GEN_STAGES: for i in 1 to NUM_PIPE - 1 loop
                    R_pipe(i) <= R_pipe(i - 1);
                end loop;
            end if;
        end process;
        R <= R_pipe(NUM_PIPE - 1);
    end generate;

end architecture;
