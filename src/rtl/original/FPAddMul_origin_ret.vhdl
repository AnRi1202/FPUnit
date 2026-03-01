library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Retiming Wrapper for FPAdd + FPMult (FloPoCo-based Baseline)
--
-- Instantiates FPAdd and FPMult, muxes by opcode(0), and appends NUM_PIPE
-- pipeline (shift-register) stages on the output for retiming.
--
-- Opcode: 000=Add, 001=Mul (opcode(0) selects: 0->Add, 1->Mul)
--
-- Generic:
--   NUM_PIPE : number of output register stages (depth for retiming)
-- =================================================================================

entity FPAddMul_origin_ret is
    generic (
        NUM_PIPE : integer := 1  -- pipeline depth for retiming
    );
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0);
        X      : in  std_logic_vector(33 downto 0);
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPAddMul_origin_ret is

    component FPAdd_8_23_Freq1_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPMult_8_23_uid2_Freq1_uid3 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;

    signal add_R, mul_R, R_inner : std_logic_vector(33 downto 0);

    type pipe_array_t is array (0 to NUM_PIPE - 1) of std_logic_vector(33 downto 0);
    signal R_pipe : pipe_array_t := (others => (others => '0'));

begin

    -- FP32 Add
    U_ADD : FPAdd_8_23_Freq1_uid2 port map (clk => clk, X => X, Y => Y, R => add_R);

    -- FP32 Mul
    U_MUL : FPMult_8_23_uid2_Freq1_uid3 port map (clk => clk, X => X, Y => Y, R => mul_R);

    -- Mux: opcode(0)=0 -> Add, opcode(0)=1 -> Mul
    R_inner <= add_R when opcode(0) = '0' else mul_R;

    -- Pipeline (shift-register) for retiming
    GEN_PIPE_0: if NUM_PIPE = 0 generate
        -- No extra registers: pass through directly
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
