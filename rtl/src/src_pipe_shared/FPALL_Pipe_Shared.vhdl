--------------------------------------------------------------------------------
--                         FPALL_Pipe_Shared
-- VHDL generated for Kintex7 @ 100MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2021
--------------------------------------------------------------------------------
-- Pipelined version with shared resources
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPALL_Pipe_Shared is
    port (clk : in std_logic;
          opcode : in std_logic_vector(1 downto 0);
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPALL_Pipe_Shared is
   
   -- Pipelined Components
   component FPAdd_Pipe_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          
          expFrac_out : out std_logic_vector(33 downto 0);
          round_out : out std_logic;
          RoundedExpFrac_in : in std_logic_vector(33 downto 0);
          
          fracAdder_X_out : out std_logic_vector(26 downto 0);
          fracAdder_Y_out : out std_logic_vector(26 downto 0);
          fracAdder_Cin_out : out std_logic;
          fracAdder_R_in : in std_logic_vector(26 downto 0)
          );
   end component;

   component FPMult_Pipe_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          
          expSig_out : out std_logic_vector(32 downto 0);
          round_out : out std_logic;
          expSigPostRound_in : in std_logic_vector(32 downto 0);
          
          expAdder_X_out : out std_logic_vector(26 downto 0);
          expAdder_Y_out : out std_logic_vector(26 downto 0);
          expAdder_Cin_out : out std_logic;
          expAdder_R_in : in std_logic_vector(26 downto 0)          
          );
   end component;

   component FPDivSqrt_8_23_Freq100 is
    port (
        clk : in std_logic;
        op  : in std_logic; -- 0: div, 1: sqrt
        X   : in  std_logic_vector(8+23+2 downto 0);
        Y   : in  std_logic_vector(8+23+2 downto 0);
        R   : out std_logic_vector(8+23+2 downto 0);
          expfrac_out : out std_logic_vector(32 downto 0);
          round_out : out std_logic;
          expfracR_in : in std_logic_vector(32 downto 0)       
    );
   end component;

   -- Shared Resources
   component IntAdder_34_Freq100_uid11 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(33 downto 0);
             Y : in  std_logic_vector(33 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(33 downto 0)   );
   end component;

   component IntAdder_27_Freq100_uid6 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(26 downto 0);
             Y : in  std_logic_vector(26 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(26 downto 0)   );
   end component;

   -- Signals
   
   -- FPAdd
   signal add_R, add_R_d1 : std_logic_vector(33 downto 0);
   signal add_expFrac : std_logic_vector(33 downto 0);
   signal add_round : std_logic;
   signal add_RoundedExpFrac : std_logic_vector(33 downto 0);
   signal add_fracAdder_X, add_fracAdder_Y : std_logic_vector(26 downto 0);
   signal add_fracAdder_Cin : std_logic;
   signal add_fracAdder_R : std_logic_vector(26 downto 0);

   -- FPMult
   signal mul_R, mul_R_d1, mul_R_d2 : std_logic_vector(33 downto 0);
   signal mul_expSig : std_logic_vector(32 downto 0);
   signal mul_round : std_logic;
   signal mul_expSigPostRound : std_logic_vector(32 downto 0);
   signal mul_expAdder_X, mul_expAdder_Y : std_logic_vector(26 downto 0);
   signal mul_expAdder_Cin : std_logic;
   signal mul_expAdder_R : std_logic_vector(26 downto 0);

   -- FPDivSqrt (New implementation with internal pipeline sharing)
   signal divsqrt_R : std_logic_vector(33 downto 0);
   signal divsqrt_expfrac: std_logic_vector(32 downto 0);
   signal divsqrt_round: std_logic;
   signal divsqrt_expfracR: std_logic_vector(32 downto 0);
   signal divsqrt_op : std_logic;
   
   -- Shared Rounding Adder
   signal ra_X, ra_Y, ra_R : std_logic_vector(33 downto 0);
   signal ra_Cin : std_logic;
   
   -- Shared Adders 27
   signal sa_X, sa_Y, sa_R : std_logic_vector(26 downto 0);
   signal sa_Cin : std_logic;
   
   -- Pipeline Control
   signal opcode_d1, opcode_d2 : std_logic_vector(1 downto 0);
   
begin

   -- Track opcode for pipeline stages
   process(clk)
   begin
      if rising_edge(clk) then
         opcode_d1 <= opcode;
         opcode_d2 <= opcode_d1;
         
         -- Add (C1) -> d1(C2)
         add_R_d1 <= add_R;
      end if;
   end process;

   -- ========================
   -- Instantiations
   -- ========================
   
   U_FPADD: FPAdd_Pipe_NoRA
   port map(
      clk => clk,
      X => X, Y => Y, R => add_R,
      expFrac_out => add_expFrac,
      round_out => add_round,
      RoundedExpFrac_in => add_RoundedExpFrac,
      fracAdder_X_out => add_fracAdder_X,
      fracAdder_Y_out => add_fracAdder_Y,
      fracAdder_Cin_out => add_fracAdder_Cin,
      fracAdder_R_in => add_fracAdder_R
   );

   U_FPMULT: FPMult_Pipe_NoRA
   port map(
      clk => clk,
      X => X, Y => Y, R => mul_R,
      expSig_out => mul_expSig,
      round_out => mul_round,
      expSigPostRound_in => mul_expSigPostRound,
      expAdder_X_out => mul_expAdder_X,
      expAdder_Y_out => mul_expAdder_Y,
      expAdder_Cin_out => mul_expAdder_Cin,
      expAdder_R_in => mul_expAdder_R
   );
   
   -- Convert opcode to op signal: "11" (Div) -> '0', "10" (Sqrt) -> '1'
   divsqrt_op <= opcode(0);
   
   U_DIVSQRT: FPDivSqrt_8_23_Freq100
   port map (
      clk => clk,
      op => divsqrt_op,
      X => X, Y => Y, R => divsqrt_R,
      expfrac_out =>divsqrt_expfrac,
      round_out => divsqrt_round,
      expfracR_in => divsqrt_expfracR
   );

   -- ========================
   -- Shared Internal Adder (27-bit)
   -- ========================
   -- Used by FPAdd (Cycle 0) and FPMult (Cycle 0).
   sa_X <= add_fracAdder_X when opcode="00" else
           mul_expAdder_X when opcode="01" else
           (others => '0');

   sa_Y <= add_fracAdder_Y when opcode="00" else
           mul_expAdder_Y when opcode="01" else
           (others => '0');
           
   sa_Cin <= add_fracAdder_Cin when opcode="00" else
             mul_expAdder_Cin when opcode="01" else
             '0';

   U_SHARED_ADD_27: IntAdder_27_Freq100_uid6
   port map( clk=>clk, X=>sa_X, Y=>sa_Y, Cin=>sa_Cin, R=>sa_R );
   
   add_fracAdder_R <= sa_R;
   mul_expAdder_R <= sa_R;

   -- ========================
   -- Shared Rounding Adder (34-bit)
   -- ========================
   -- Requests: 
   -- FPMult (Cycle 0) -> opcode="01"
   -- FPAdd (Cycle 1) -> opcode_d1="00"
   -- Note: FPDivSqrt_8_23_Freq100 now handles its own rounding internally,
   -- so we only need to handle Add and Mult here.
   
   ra_X <= ('0' & mul_expSig) when opcode="01" else
           add_expFrac when opcode_d1="00" else
           ('0' & divsqrt_expfrac) when opcode_d2(1)='1' else
           (others => '0');
           
   ra_Y <= (others => '0'); 
   
   ra_Cin <= mul_round when opcode="01" else
             add_round when opcode_d1="00" else
             divsqrt_round when opcode_d2(1)='1' else
             '0';

   U_SHARED_RA_34: IntAdder_34_Freq100_uid11
   port map( clk=>clk, X=>ra_X, Y=>ra_Y, Cin=>ra_Cin, R=>ra_R );
   
   add_RoundedExpFrac <= ra_R;
   mul_expSigPostRound <= ra_R(32 downto 0);
   divsqrt_expfracR <= ra_R(32 downto 0);

   -- ========================
   -- Output Multiplexer (Cycle 2)
   -- ========================
   
   R <= mul_R    when opcode_d1="01" else
        add_R    when opcode_d1="00" else
        divsqrt_R when opcode_d2(1)='1' else -- 10 or 11
        (others => '0');

end architecture;
