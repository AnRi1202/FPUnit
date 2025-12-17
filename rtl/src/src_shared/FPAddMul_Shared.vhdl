
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

--- new 

entity IntAdder_34_Freq1_uid11 is
    port (clk : in std_logic;
          X : in  std_logic_vector(33 downto 0);
          Y : in  std_logic_vector(33 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(33 downto 0)   );
end entity;

architecture arch of IntAdder_34_Freq1_uid11 is
signal Rtmp :  std_logic_vector(33 downto 0);
   -- timing of Rtmp: (c0, 15.518000ns)
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;




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


    --- addの引用
    component FPAdd_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            R : out  std_logic_vector(33 downto 0);
            expFrac_out : out std_logic_vector(33 downto 0);
            round_out : out std_logic;
            RoundedExpFrac_in : in std_logic_vector(33 downto 0)
        );
    end component;

    component FPMult_NoRA is
        port (
            clk : in std_logic;
            X : in  std_logic_vector(33 downto 0);
            Y : in  std_logic_vector(33 downto 0);
            expSig_out : out std_logic_vector(32 downto 0);
            round_out : out std_logic
        );
    end component;
    
    component IntAdder_34_Freq1_uid11 is
       port ( clk : in std_logic;
              X : in  std_logic_vector(33 downto 0);
              Y : in  std_logic_vector(33 downto 0);
              Cin : in  std_logic;
              R : out  std_logic_vector(33 downto 0)   );
    end component;

    signal add_R, mul_R : std_logic_vector(33 downto 0);
    
    -- Add signals
    signal add_expFrac : std_logic_vector(33 downto 0);
    signal add_round : std_logic;
    signal add_ResultBack : std_logic_vector(33 downto 0);
    
    -- Mul signals
    signal mul_expSig : std_logic_vector(32 downto 0);
    signal mul_round : std_logic;
    signal mul_ResultBack : std_logic_vector(32 downto 0);
    
    -- Shared Adder signals
    signal ra_X : std_logic_vector(33 downto 0);
    signal ra_Cin : std_logic;
    signal ra_R : std_logic_vector(33 downto 0);

begin

    -- Instantiate FPAdd (No RA)
    U_ADD: FPAdd_NoRA
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => add_R, --result
        expFrac_out => add_expFrac, -- 出し入れされる
        round_out => add_round,
        RoundedExpFrac_in => add_ResultBack
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
        expSigPostRound_in => mul_ResultBack
    );
    
    -- Multiplex inputs to Shared Rounding Adder
    -- If opcode=0 (Add): X=add_expFrac, Cin=add_round
    -- If opcode=1 (Mul): X=pad(mul_expSig), Cin=mul_round
    -- Note: FPMult 33 bit adder inputs were: X=expSig, Y=0.
    -- We map expSig to lower 33 bits? 
    -- FPMult RA: expSig (33 bits) -> RoundingAdder(33 bits).
    -- We use 34 bit adder. X = "0" & mul_expSig?
    
    ra_X <= add_expFrac when opcode='0' else ('0' & mul_expSig);
    ra_Cin <= add_round when opcode='0' else mul_round;
    
    -- Shared Rounding Adder (34 bits)
    U_SHARED_RA: IntAdder_34_Freq1_uid11
    port map (
        clk => clk,
        X => ra_X,
        Y => (others => '0'), -- +0
        Cin => ra_Cin,
        R => ra_R
    );
    
    -- Route outputs back
    -- Add expects 34 bits
    add_ResultBack <= ra_R;
    
    -- Mul expects 33 bits.
    -- Since we padded MSB with 0, the result should fit in lower 33 bits
    -- (unless overflow, but original design 33 bit adder logic implies it fits or overflow led to bit 33 which we drop?
    --  Actually in FPMult original, R is 33 bits. Input X is 33 bits. 
    --  It seems safe to take lower 33 bits).
    mul_ResultBack <= ra_R(32 downto 0);
    
    -- Final Output Mux
    R <= add_R when opcode='0' else mul_R; -- ここもmux

end architecture;
