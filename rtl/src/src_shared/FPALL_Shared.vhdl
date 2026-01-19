
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

entity FPALL_Shared is
    port (
        clk : in std_logic;
        opcode : in std_logic_vector(1 downto 0); -- 00: Add, 01: Mul, 10: Sqrt, 11: Div
        X : in std_logic_vector(33 downto 0);
        Y : in std_logic_vector(33 downto 0);
        R : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of FPALL_Shared is

    component FPAdd_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            expFrac_out : out std_logic_vector(33 downto 0);
            round_out : out std_logic;
            RoundedExpFrac_in : in std_logic_vector(33 downto 0);
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
            expSig_out : out std_logic_vector(32 downto 0);
            round_out : out std_logic;
            expSigPostRound_in : in std_logic_vector(32 downto 0);
            expAdder_X_out : out std_logic_vector(7 downto 0);
            expAdder_Y_out : out std_logic_vector(7 downto 0);
            expAdder_Cin_out : out std_logic;
            expAdder_R_in : in std_logic_vector(26 downto 0)
        );
    end component;

    component FPSqrt_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            round_out : out std_logic;
            expFrac_out: out std_logic_vector(22 downto 0);
            RoundedExpFrac_in : in std_logic_vector(22 downto 0)
        );
    end component;

    component FPDiv_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            round_out : out std_logic;
            expfrac_out: out std_logic_vector(32 downto 0);
            expfracR_in : in std_logic_vector(32 downto 0)
        );
    end component;
    
    component IntAdder_34_Freq1_uid11 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(33 downto 0);
              Y : in  std_logic_vector(33 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(33 downto 0)   );
    end component;
    
    component IntAdder_27_Freq1_uid6 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(26 downto 0);
              Y : in  std_logic_vector(26 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(26 downto 0)   );
    end component;

    -- Add signals
    signal add_R : std_logic_vector(33 downto 0);
    signal add_expFrac : std_logic_vector(33 downto 0);
    signal add_round : std_logic;
    signal add_ResultBack : std_logic_vector(33 downto 0);
    
    -- Mul signals
    signal mul_R : std_logic_vector(33 downto 0);
    signal mul_expSig : std_logic_vector(32 downto 0);
    signal mul_round : std_logic;
    signal mul_ResultBack : std_logic_vector(32 downto 0);

    -- Sqrt signals
    signal sqrt_R : std_logic_vector(33 downto 0);
    signal sqrt_expFrac : std_logic_vector(22 downto 0);
    signal sqrt_round : std_logic;
    signal sqrt_ResultBack : std_logic_vector(22 downto 0);

    -- Div signals
    signal div_R : std_logic_vector(33 downto 0);
    signal div_expfrac : std_logic_vector(32 downto 0);
    signal div_round : std_logic;
    signal div_ResultBack : std_logic_vector(32 downto 0);
    
    -- Shared Adder signals
    signal ra_X : std_logic_vector(33 downto 0);
    signal ra_Cin : std_logic;
    signal ra_R : std_logic_vector(33 downto 0);
    
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
        expFrac_out => add_expFrac,
        round_out => add_round,
        RoundedExpFrac_in => add_ResultBack,
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
        expSig_out => mul_expSig,
        round_out => mul_round,
        expSigPostRound_in => mul_ResultBack,
        expAdder_X_out => mul_expAdder_X,
        expAdder_Y_out => mul_expAdder_Y,
        expAdder_Cin_out => mul_expAdder_Cin,
        expAdder_R_in => mul_expAdder_R
    );

    -- Instantiate FPSqrt (No RA)
    U_SQRT: FPSqrt_NoRA
    port map (
        clk => clk,
        X => X,
        R => sqrt_R,
        expFrac_out => sqrt_expFrac,
        round_out => sqrt_round,
        RoundedExpFrac_in => sqrt_ResultBack
    );

    -- Instantiate FPDiv (No RA)
    U_DIV: FPDiv_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => div_R,
        expfrac_out => div_expfrac,
        round_out => div_round,
        expfracR_in => div_ResultBack
    );
    
    -- Multiplex inputs to Shared Rounding Adder
    -- opcode: 00=Add, 01=Mul, 10=Sqrt, 11=Div
    ra_X(33) <= add_expFrac(33);
    ra_X(32 downto 23) <= add_expFrac(32 downto 23) when opcode="00" else 
                        mul_expSig(32 downto 23) when opcode="01" else
                        div_expfrac(32 downto 23); -- 11 for Div

    ra_X(22 downto 0) <= add_expFrac(22 downto 0) when opcode="00" else 
            mul_expSig(22 downto 0) when opcode="01" else
            sqrt_expFrac when opcode="10" else
            div_expfrac(22 downto 0); -- 11 for Div
            
    ra_Cin <= add_round when opcode="00" else 
              mul_round when opcode="01" else
              sqrt_round when opcode="10" else
              div_round;
    
    -- Multiplex inputs to Shared IntAdder_27
    -- opcode: 00=Add (fracAdder), 01=Mul (expAdder), others unused
    ia27_X(26 downto 8) <= add_fracAdder_X(26 downto 8);
    ia27_X(7 downto 0) <= add_fracAdder_X (7 downto 0) when opcode="00" else
              mul_expAdder_X; -- when opcode="01"
    ia27_Y(26 downto 8) <= add_fracAdder_Y(26 downto 8);
    ia27_Y(7 downto 0)<= add_fracAdder_Y(7 downto 0) when opcode="00" else
              mul_expAdder_Y; -- when opcode="01"
    
    ia27_Cin <= add_fracAdder_Cin when opcode="00" else
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
    
    -- Route IntAdder_27 outputs back
    add_fracAdder_R <= ia27_R;
    mul_expAdder_R <= ia27_R;
    
    -- Shared Rounding Adder (34 bits)
    U_SHARED_RA: IntAdder_34_Freq1_uid11
    port map (
        clk => clk,
        X => ra_X,
        Y => (others => '0'),
        Cin => ra_Cin,
        R => ra_R
    );
    
    -- Route outputs back
    -- Add expects 34 bits
    add_ResultBack <= ra_R;
    
    -- Mul expects 33 bits
    mul_ResultBack <= ra_R(32 downto 0);
    
    -- Sqrt expects 34 bits
    sqrt_ResultBack <= ra_R(22 downto 0);

    -- Div expects 33 bits
    div_ResultBack <= ra_R(32 downto 0);
    
    -- Final Output Mux
    R <= add_R when opcode="00" else 
         mul_R when opcode="01" else
         sqrt_R when opcode="10" else
         div_R;

end architecture;
