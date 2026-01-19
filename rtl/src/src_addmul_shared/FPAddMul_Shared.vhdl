
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

entity FPAddMul_Shared is
    port (
        clk : in std_logic;
        opcode : in std_logic; -- 0: Add, 1: Mul
        X : in std_logic_vector(33 downto 0);
        Y : in std_logic_vector(33 downto 0);
        R : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPAddMul_Shared is

    component FPAdd_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            -- expFrac_out : out std_logic_vector(33 downto 0);
            -- round_out : out std_logic;
            -- RoundedExpFrac_in : in std_logic_vector(33 downto 0);
            fracAdder_X_out : out std_logic_vector(26 downto 0);
            fracAdder_Y_out : out std_logic_vector(26 downto 0);
            fracAdder_Cin_out : out std_logic;
            fracAdder_R_in : in std_logic_vector(26 downto 0)
        );
    end component;

    component FPMult_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            -- expSig_out : out std_logic_vector(32 downto 0);
            -- round_out : out std_logic;
            -- expSigPostRound_in : in std_logic_vector(32 downto 0);
            expAdder_X_out : out std_logic_vector(7 downto 0);
            expAdder_Y_out : out std_logic_vector(7 downto 0);
            expAdder_Cin_out : out std_logic;
            expAdder_R_in : in std_logic_vector(26 downto 0)
        );
    end component;

    
    -- component IntAdder_34_Freq1_uid11 is
    --    port ( clk : in std_logic;
    --           X : in  std_logic_vector(33 downto 0);
    --           Y : in  std_logic_vector(33 downto 0);
    --           Cin : in  std_logic;
    --           R : out  std_logic_vector(33 downto 0)   );
    -- end component;

    component IntAdder_27_Freq1_uid6 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(26 downto 0);
              Y : in  std_logic_vector(26 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(26 downto 0)   );
    end component;
    
    -- Add signals
    signal add_R : std_logic_vector(33 downto 0);
    -- signal add_expFrac : std_logic_vector(33 downto 0);
    -- signal add_round : std_logic;
    -- signal add_ResultBack : std_logic_vector(33 downto 0);
    
    -- Mul signals
    signal mul_R : std_logic_vector(33 downto 0);
    -- signal mul_expSig : std_logic_vector(32 downto 0);
    -- signal mul_round : std_logic;
    -- signal mul_ResultBack : std_logic_vector(32 downto 0);
    
    -- -- Shared Adder signals
    -- signal ra_X : std_logic_vector(33 downto 0);
    -- signal ra_Cin : std_logic;
    -- signal ra_R : std_logic_vector(33 downto 0);

    -- Shared IntAdder_27 signals
    signal add_fracAdder_X : std_logic_vector(26 downto 0);
    signal add_fracAdder_Y : std_logic_vector(26 downto 0);
    signal add_fracAdder_Cin : std_logic;
    signal add_fracAdder_R : std_logic_vector(26 downto 0);
    
    signal mul_expAdder_X : std_logic_vector(7 downto 0);
    signal mul_expAdder_Y : std_logic_vector(7 downto 0);
    signal mul_expAdder_Cin : std_logic;
    signal mul_expAdder_R : std_logic_vector(26 downto 0);
    
    signal ia27_X : std_logic_vector(26 downto 0);
    signal ia27_Y : std_logic_vector(26 downto 0);
    signal ia27_Cin : std_logic;
    signal ia27_R : std_logic_vector(26 downto 0);


begin

    -- Instantiate FPAdd (No RA)
    U_ADD: FPAdd_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => add_R,
        -- expFrac_out => add_expFrac,
        -- round_out => add_round,
        -- RoundedExpFrac_in => add_ResultBack,
        fracAdder_X_out => add_fracAdder_X,
        fracAdder_Y_out => add_fracAdder_Y,
        fracAdder_Cin_out => add_fracAdder_Cin,
        fracAdder_R_in => add_fracAdder_R
    );

    -- Instantiate FPMult (No RA)
    U_MUL: FPMult_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => mul_R,
        -- expSig_out => mul_expSig,
        -- round_out => mul_round,
        -- expSigPostRound_in => mul_ResultBack,
        expAdder_X_out => mul_expAdder_X,
        expAdder_Y_out => mul_expAdder_Y,
        expAdder_Cin_out => mul_expAdder_Cin,
        expAdder_R_in => mul_expAdder_R
    );

    -- ra_X(33) <= add_expFrac(33);
    -- ra_X(32 downto 0) <= add_expFrac(32 downto 0) when opcode='0' else 
    --                     mul_expSig(32 downto 0);

    -- ra_Cin <= add_round when opcode='0' else mul_round;

    -- Multiplex inputs to Shared IntAdder_27
    -- opcode: 00=Add (fracAdder), 01=Mul (expAdder), others unused
    ia27_X(26 downto 9) <= add_fracAdder_X(26 downto 9);
    ia27_X(8 downto 0) <= add_fracAdder_X (8 downto 0) when opcode='0' else
              '0' & mul_expAdder_X; -- when opcode="01"
    ia27_Y(26 downto 9) <= add_fracAdder_Y(26 downto 9);
    ia27_Y(8 downto 0)<= add_fracAdder_Y(8 downto 0) when opcode='0' else
              '0' & mul_expAdder_Y; -- when opcode="01"
    
    ia27_Cin <= add_fracAdder_Cin when opcode='0' else
                mul_expAdder_Cin; -- when opcode="01"
    
    -- Shared IntAdder_27 for Add frac addition and Mult exp addition
    U_SHARED_IA27: IntAdder_27_Freq1_uid6
    port map (
        clk => clk,
        X => ia27_X,
        Y => ia27_Y,
        Cin => ia27_Cin,
        R => ia27_R
    );

    -- Route shared adder output back
    add_fracAdder_R <= ia27_R;
    mul_expAdder_R <= ia27_R;

    -- -- Shared Rounding Adder (34 bits)
    -- U_SHARED_RA: IntAdder_34_Freq1_uid11
    -- port map (
    --     clk => clk,
    --     X => ra_X,
    --     Y => (others => '0'), -- +0
    --     Cin => ra_Cin,
    --     R => ra_R
    -- );
    
    -- -- Route outputs back
    -- -- Add expects 34 bits
    -- add_ResultBack <= ra_R;
    
    -- -- Mul expects 33 bits
    -- mul_ResultBack <= ra_R(32 downto 0);

    -- Final Output Mux
    R <= add_R when opcode='0' else mul_R;

end architecture;

