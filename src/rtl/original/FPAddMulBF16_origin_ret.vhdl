library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Retiming Wrapper for FPAdd + FPMult + BF16 Add x2 + BF16 Mult x2 (6ops cluster)
--
-- Opcode: 000=FP32 Add, 001=FP32 Mul, 100=BF16 Add (2 lanes), 101=BF16 Mult (2 lanes)
--
-- Generic:
--   NUM_PIPE : number of output register stages (depth for retiming)
-- =================================================================================

entity FPAddMulBF16_origin_ret is
    generic (
        NUM_PIPE : integer := 1
    );
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0);
        X      : in  std_logic_vector(33 downto 0);
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPAddMulBF16_origin_ret is

    component FPAdd_8_23_Freq1_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPMult_8_23_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPAdd_8_7_Freq1_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;
    component FPMult_8_7_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(17 downto 0); R : out std_logic_vector(17 downto 0));
    end component;

    signal add_R, mul_R, bfadd_R, bfmult_R, R_inner : std_logic_vector(33 downto 0);
    signal bfadd_h, bfadd_l, bfmul_h, bfmul_l : std_logic_vector(17 downto 0);
    signal X_bf_l, Y_bf_l : std_logic_vector(17 downto 0);
    type pipe_array_t is array (0 to NUM_PIPE - 1) of std_logic_vector(33 downto 0);
    signal R_pipe : pipe_array_t := (others => (others => '0'));

begin

    -- FP32 Add
    U_ADD : FPAdd_8_23_Freq1_uid2 port map (clk => clk, X => X, Y => Y, R => add_R);

    -- FP32 Mul
    U_MUL : FPMult_8_23_uid2_Freq1_uid3 port map (clk => clk, X => X, Y => Y, R => mul_R);

    -- BF16 Add x2
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);
    U_BFADD_H : FPAdd_8_7_Freq1_uid2 port map (clk => clk, X => X(33 downto 16), Y => Y(33 downto 16), R => bfadd_h);
    U_BFADD_L : FPAdd_8_7_Freq1_uid2 port map (clk => clk, X => X_bf_l, Y => Y_bf_l, R => bfadd_l);
    bfadd_R <= bfadd_h & bfadd_l(15 downto 0);

    -- BF16 Mult x2
    U_BFMUL_H : FPMult_8_7_uid2_Freq1_uid3 port map (clk => clk, X => X(33 downto 16), Y => Y(33 downto 16), R => bfmul_h);
    U_BFMUL_L : FPMult_8_7_uid2_Freq1_uid3 port map (clk => clk, X => X_bf_l, Y => Y_bf_l, R => bfmul_l);
    bfmult_R <= bfmul_h & bfmul_l(15 downto 0);

    -- Mux: opcode(2)=1 -> BF16 (opcode(1)=0->BFAdd, 1->BFMul), else FP32 (opcode(0)=0->Add, 1->Mul)
    R_inner <= add_R   when opcode(2) = '0' and opcode(0) = '0' else
               mul_R   when opcode(2) = '0' and opcode(0) = '1' else
               bfadd_R when opcode(2) = '1' and opcode(1) = '0' else
               bfmult_R;

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
