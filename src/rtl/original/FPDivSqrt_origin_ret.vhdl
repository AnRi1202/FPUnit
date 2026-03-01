library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Retiming Wrapper for FPDiv + FPSqrt (FloPoCo-based Baseline)
--
-- Instantiates FPDiv and FPSqrt, muxes by opcode(0), and appends NUM_PIPE
-- pipeline (shift-register) stages on the output for retiming.
--
-- Opcode: 010=Sqrt, 011=Div (opcode(0) selects: 0->Sqrt, 1->Div)
--
-- Generic:
--   NUM_PIPE : number of output register stages (depth for retiming)
-- =================================================================================

entity FPDivSqrt_origin_ret is
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

architecture arch of FPDivSqrt_origin_ret is

    component FPSqrt_8_23 is
        port (clk : in std_logic; X : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;
    component FPDiv_8_23_Freq1_uid2 is
        port (clk : in std_logic; X, Y : in std_logic_vector(33 downto 0); R : out std_logic_vector(33 downto 0));
    end component;

    signal sqrt_R, div_R, R_inner : std_logic_vector(33 downto 0);

    type pipe_array_t is array (0 to NUM_PIPE - 1) of std_logic_vector(33 downto 0);
    signal R_pipe : pipe_array_t := (others => (others => '0'));

begin

    -- FP32 Sqrt (X only)
    U_SQRT : FPSqrt_8_23 port map (clk => clk, X => X, R => sqrt_R);

    -- FP32 Div (X, Y)
    U_DIV : FPDiv_8_23_Freq1_uid2 port map (clk => clk, X => X, Y => Y, R => div_R);

    -- Mux: opcode(0)=0 -> Sqrt, opcode(0)=1 -> Div
    R_inner <= sqrt_R when opcode(0) = '0' else div_R;

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
