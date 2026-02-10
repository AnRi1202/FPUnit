
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

entity f500_fpall_origin is
    port (
        clk : in std_logic;
        opcode : in std_logic_vector(1 downto 0); -- 00: Add, 01: Mul, 10: Sqrt, 11: Div
        X : in std_logic_vector(33 downto 0);
        Y : in std_logic_vector(33 downto 0);
        R : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of f500_fpall_origin is
    component FPAdd_8_23_Freq500_uid2 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            Y : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPMult_8_23_uid2_Freq500_uid3 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            Y : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPSqrt_8_23 is
        port (clk : in std_logic;
            X : in  std_logic_vector(8+23+2 downto 0);
            R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    component FPDiv_8_23_Freq500_uid2 is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
    end component; 


    signal add_R : std_logic_vector(33 downto 0);
    signal mul_R : std_logic_vector(33 downto 0);
    signal sqrt_R: std_logic_vector(33 downto 0);
    signal div_R : std_logic_vector(33 downto 0);

begin

    -- Instantiate FPAdd
    U_ADD: FPAdd_8_23_Freq500_uid2
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => add_R
    );

    -- Instantiate FPMult
    U_MUL: FPMult_8_23_uid2_Freq500_uid3
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => mul_R
    );

    -- Instantiate FPSqrt
    U_SQRT: FPSqrt_8_23
    port map (
        clk => clk,
        X => X,
        R => sqrt_R
    );

    -- Instantiate FPDiv
    U_DIV: FPDiv_8_23_Freq500_uid2
    port map (
        clk => clk,
        X => X,
        Y => Y,
        R => div_R
    );

    R <= add_R when opcode="00" else 
         mul_R when opcode="01" else
         sqrt_R when opcode="10" else
         div_R;
end architecture;

