library ieee;
use ieee.std_logic_1164.all;

-- =================================================================================
-- Retiming Wrapper for FPALL_origin (FloPoCo-based Baseline)
--
-- Instantiates FPALL_origin and appends NUM_PIPE pipeline (shift-register) stages
-- on the output, giving Synopsys DC freedom to retime registers across the
-- combinational logic inside the sub-modules.
--
-- This mirrors the role of area_opt_ret.sv for the v1_area_opt design.
--
-- Generic:
--   NUM_OPS  : forwarded to FPALL_origin (see FPALL_origin.vhdl for mapping)
--   NUM_PIPE : number of output register stages (depth for retiming)
-- =================================================================================

entity FPALL_origin_ret is
    generic (
        NUM_OPS  : integer := 6; -- forwarded to FPALL_origin
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

architecture arch of FPALL_origin_ret is

    component FPALL_origin is
        generic (NUM_OPS : integer := 6);
        port (
            clk    : in  std_logic;
            opcode : in  std_logic_vector(2 downto 0);
            X      : in  std_logic_vector(33 downto 0);
            Y      : in  std_logic_vector(33 downto 0);
            R      : out std_logic_vector(33 downto 0)
        );
    end component;

    signal R_inner : std_logic_vector(33 downto 0);

    -- Shift-register array: index 0 is the first stage after R_inner
    type pipe_array_t is array (0 to NUM_PIPE - 1) of std_logic_vector(33 downto 0);
    signal R_pipe : pipe_array_t := (others => (others => '0'));

begin

    -- Instantiate the core FloPoCo baseline
    U_CORE : FPALL_origin
        generic map (NUM_OPS => NUM_OPS)
        port map (
            clk    => clk,
            opcode => opcode,
            X      => X,
            Y      => Y,
            R      => R_inner
        );

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
