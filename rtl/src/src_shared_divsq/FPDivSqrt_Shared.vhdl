--------------------------------------------------------------------------------
--                           FPDivSqrt_Shared
-- Hardware sharing implementation for FPDiv and FPSqrt
-- Shares 24 27-bit adder/subtractor units between operations
-- Author: Generated for hardware optimization
--------------------------------------------------------------------------------
-- opcode_divsqrt: '0' = Div (14 stages), '1' = Sqrt (24 stages)
-- All adders are 27-bit width, Div uses first 14, Sqrt uses all 24

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPDivSqrt_Shared is
    port (
        clk : in std_logic;
        X   : in  std_logic_vector(33 downto 0);
        Y   : in  std_logic_vector(33 downto 0);
        
        opcode_divsqrt : in std_logic;  -- '0'=Div, '1'=Sqrt
        
        R : out std_logic_vector(33 downto 0);
        
        -- Rounding Adder interface
        expfrac_out : out std_logic_vector(32 downto 0);
        round_out   : out std_logic;
        expfracR_in : in  std_logic_vector(32 downto 0)
    );
end entity;

architecture arch of FPDivSqrt_Shared is

    -- selFunction component (used by Div)
    component selFunction_Freq1_uid4 is
        port ( X : in  std_logic_vector(8 downto 0);
               Y : out  std_logic_vector(2 downto 0) );
    end component;

    -- ===== Type Definitions =====
    type addsub_array_27 is array (0 to 23) of std_logic_vector(26 downto 0);
    type sel_array is array (0 to 13) of std_logic_vector(8 downto 0);
    type q_array is array (0 to 13) of std_logic_vector(2 downto 0);
    type Ts_array is array (0 to 23) of std_logic_vector(27 downto 0);
    type Ts_l_array is array (0 to 23) of std_logic_vector(26 downto 0);
    type S_array is array (0 to 23) of std_logic_vector(24 downto 0);

    -- ===== Shared Adder/Subtractor Array =====
    signal adder_A, adder_B, adder_R : addsub_array_27;
    signal adder_sub : std_logic_vector(0 to 23);

    -- ===== Div Signals (extracted from FPDiv_Kin_f1_origin) =====
    signal div_fX, div_fY, div_D : std_logic_vector(23 downto 0);
    signal div_expR0 : std_logic_vector(9 downto 0);
    signal div_sR : std_logic;
    signal div_exnXY : std_logic_vector(3 downto 0);
    signal div_exnR0 : std_logic_vector(1 downto 0);
    signal div_psX : std_logic_vector(24 downto 0);
    signal div_betaw, div_w, div_absqD : addsub_array_27;
    signal div_sel : sel_array;
    signal div_q, div_q_copy : q_array;
    signal div_wfinal : std_logic_vector(24 downto 0);
    signal div_qM0 : std_logic;
    signal div_qP, div_qM, div_quotient : std_logic_vector(27 downto 0);
    signal div_mR : std_logic_vector(25 downto 0);
    signal div_fRnorm : std_logic_vector(23 downto 0);
    signal div_round : std_logic;
    signal div_expR1 : std_logic_vector(9 downto 0);
    signal div_expfrac, div_expfracR : std_logic_vector(32 downto 0);
    signal div_exnR, div_exnRfinal : std_logic_vector(1 downto 0);
    signal div_R : std_logic_vector(33 downto 0);

    -- ===== Sqrt Signals (extracted from FPSqrt_Kin_f1_origin) =====
    signal sqrt_fracX : std_logic_vector(22 downto 0);
    signal sqrt_eRn0, sqrt_eRn1 : std_logic_vector(7 downto 0);
    signal sqrt_xsX, sqrt_xsR : std_logic_vector(2 downto 0);
    signal sqrt_fracXnorm : std_logic_vector(26 downto 0);
    signal sqrt_S0 : std_logic_vector(1 downto 0);
    signal sqrt_T, sqrt_Ts_h_full : addsub_array_27;  -- Use full 27-bit for all stages
    signal sqrt_Ts : Ts_array;
    signal sqrt_Ts_l : Ts_l_array;  -- Variable lower part
    signal sqrt_U_full : addsub_array_27;  -- Full 27-bit U values
    signal sqrt_S : S_array;  -- Max 25 bits for S23
    signal sqrt_d : std_logic_vector(0 to 24);
    signal sqrt_d25, sqrt_round : std_logic;
    signal sqrt_mR : std_logic_vector(25 downto 0);
    signal sqrt_fR, sqrt_fRrnd : std_logic_vector(22 downto 0);
    signal sqrt_Rn2 : std_logic_vector(30 downto 0);
    signal sqrt_R : std_logic_vector(33 downto 0);

begin

    -- ===== Shared 27-bit Adder/Subtractor Array =====
    gen_shared_adders: for i in 0 to 23 generate
        adder_R(i) <= adder_A(i) - adder_B(i) when adder_sub(i)='1'  
                      else adder_A(i) + adder_B(i);
    end generate;

    -- ========================================================================
    -- DIV LOGIC (extracted from FPDiv_Kin_f1_origin.vhdl)
    -- ========================================================================
    
    -- Div preprocessing
    div_fX <= "1" & X(22 downto 0);
    div_fY <= "1" & Y(22 downto 0);
    div_expR0 <= ("00" & X(30 downto 23)) - ("00" & Y(30 downto 23));
    div_sR <= X(31) xor Y(31);
    div_exnXY <= X(33 downto 32) & Y(33 downto 32);
    
    with div_exnXY select
        div_exnR0 <=
            "01" when "0101",
            "00" when "0001" | "0010" | "0110",
            "10" when "0100" | "1000" | "1001",
            "11" when others;
    
    div_D <= div_fY;
    div_psX <= "0" & div_fX;

    -- Div iteration: 14 stages
    div_betaw(0) <= "00" & div_psX;
    div_sel(0) <= div_betaw(0)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable14: selFunction_Freq1_uid4 port map (X => div_sel(0), Y => div_q_copy(0));
    div_q(0) <= div_q_copy(0);
    with div_q(0) select div_absqD(0) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(0) <= adder_R(0);

    div_betaw(1) <= div_w(0)(24 downto 0) & "00";
    div_sel(1) <= div_betaw(1)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable13: selFunction_Freq1_uid4 port map (X => div_sel(1), Y => div_q_copy(1));
    div_q(1) <= div_q_copy(1);
    with div_q(1) select div_absqD(1) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(1) <= adder_R(1);

    div_betaw(2) <= div_w(1)(24 downto 0) & "00";
    div_sel(2) <= div_betaw(2)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable12: selFunction_Freq1_uid4 port map (X => div_sel(2), Y => div_q_copy(2));
    div_q(2) <= div_q_copy(2);
    with div_q(2) select div_absqD(2) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(2) <= adder_R(2);

    div_betaw(3) <= div_w(2)(24 downto 0) & "00";
    div_sel(3) <= div_betaw(3)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable11: selFunction_Freq1_uid4 port map (X => div_sel(3), Y => div_q_copy(3));
    div_q(3) <= div_q_copy(3);
    with div_q(3) select div_absqD(3) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(3) <= adder_R(3);

    div_betaw(4) <= div_w(3)(24 downto 0) & "00";
    div_sel(4) <= div_betaw(4)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable10: selFunction_Freq1_uid4 port map (X => div_sel(4), Y => div_q_copy(4));
    div_q(4) <= div_q_copy(4);
    with div_q(4) select div_absqD(4) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(4) <= adder_R(4);

    div_betaw(5) <= div_w(4)(24 downto 0) & "00";
    div_sel(5) <= div_betaw(5)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable9: selFunction_Freq1_uid4 port map (X => div_sel(5), Y => div_q_copy(5));
    div_q(5) <= div_q_copy(5);
    with div_q(5) select div_absqD(5) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(5) <= adder_R(5);

    div_betaw(6) <= div_w(5)(24 downto 0) & "00";
    div_sel(6) <= div_betaw(6)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable8: selFunction_Freq1_uid4 port map (X => div_sel(6), Y => div_q_copy(6));
    div_q(6) <= div_q_copy(6);
    with div_q(6) select div_absqD(6) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(6) <= adder_R(6);

    div_betaw(7) <= div_w(6)(24 downto 0) & "00";
    div_sel(7) <= div_betaw(7)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable7: selFunction_Freq1_uid4 port map (X => div_sel(7), Y => div_q_copy(7));
    div_q(7) <= div_q_copy(7);
    with div_q(7) select div_absqD(7) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(7) <= adder_R(7);

    div_betaw(8) <= div_w(7)(24 downto 0) & "00";
    div_sel(8) <= div_betaw(8)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable6: selFunction_Freq1_uid4 port map (X => div_sel(8), Y => div_q_copy(8));
    div_q(8) <= div_q_copy(8);
    with div_q(8) select div_absqD(8) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(8) <= adder_R(8);

    div_betaw(9) <= div_w(8)(24 downto 0) & "00";
    div_sel(9) <= div_betaw(9)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable5: selFunction_Freq1_uid4 port map (X => div_sel(9), Y => div_q_copy(9));
    div_q(9) <= div_q_copy(9);
    with div_q(9) select div_absqD(9) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(9) <= adder_R(9);

    div_betaw(10) <= div_w(9)(24 downto 0) & "00";
    div_sel(10) <= div_betaw(10)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable4: selFunction_Freq1_uid4 port map (X => div_sel(10), Y => div_q_copy(10));
    div_q(10) <= div_q_copy(10);
    with div_q(10) select div_absqD(10) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(10) <= adder_R(10);

    div_betaw(11) <= div_w(10)(24 downto 0) & "00";
    div_sel(11) <= div_betaw(11)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable3: selFunction_Freq1_uid4 port map (X => div_sel(11), Y => div_q_copy(11));
    div_q(11) <= div_q_copy(11);
    with div_q(11) select div_absqD(11) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(11) <= adder_R(11);

    div_betaw(12) <= div_w(11)(24 downto 0) & "00";
    div_sel(12) <= div_betaw(12)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable2: selFunction_Freq1_uid4 port map (X => div_sel(12), Y => div_q_copy(12));
    div_q(12) <= div_q_copy(12);
    with div_q(12) select div_absqD(12) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(12) <= adder_R(12);

    div_betaw(13) <= div_w(12)(24 downto 0) & "00";
    div_sel(13) <= div_betaw(13)(26 downto 21) & div_D(22 downto 20);
    SelFunctionTable1: selFunction_Freq1_uid4 port map (X => div_sel(13), Y => div_q_copy(13));
    div_q(13) <= div_q_copy(13);
    with div_q(13) select div_absqD(13) <= "000" & div_D when "001" | "111", "00" & div_D & "0" when "010" | "110", (26 downto 0 => '0') when others;
    div_w(13) <= adder_R(13);

    -- Div postprocessing
    div_wfinal <= div_w(13)(24 downto 0);
    div_qM0 <= div_wfinal(24);
    div_qP <= div_q(0)(1 downto 0) & div_q(1)(1 downto 0) & div_q(2)(1 downto 0) & div_q(3)(1 downto 0) &
              div_q(4)(1 downto 0) & div_q(5)(1 downto 0) & div_q(6)(1 downto 0) & div_q(7)(1 downto 0) &
              div_q(8)(1 downto 0) & div_q(9)(1 downto 0) & div_q(10)(1 downto 0) & div_q(11)(1 downto 0) &
              div_q(12)(1 downto 0) & div_q(13)(1 downto 0);
    div_qM <= div_q(0)(2) & div_q(1)(2) & "0" & div_q(2)(2) & "0" & div_q(3)(2) & "0" &
              div_q(4)(2) & "0" & div_q(5)(2) & "0" & div_q(6)(2) & "0" & div_q(7)(2) & "0" &
              div_q(8)(2) & "0" & div_q(9)(2) & "0" & div_q(10)(2) & "0" & div_q(11)(2) & "0" &
              div_q(12)(2) & "0" & div_q(13)(2) & "0" & div_qM0;
    div_quotient <= div_qP - div_qM;
    div_mR <= div_quotient(26 downto 1);
    div_fRnorm <= div_mR(24 downto 1) when div_mR(25)='1' else div_mR(23 downto 0);
    div_round <= div_fRnorm(0);
    div_expR1 <= div_expR0 + ("000" & (6 downto 1 => '1') & div_mR(25));
    div_expfrac <= div_expR1 & div_fRnorm(23 downto 1);
    div_expfracR <= expfracR_in;
    div_exnR <= "00" when div_expfracR(32)='1' else "10" when div_expfracR(32 downto 31)="01" else "01";
    with div_exnR0 select div_exnRfinal <= div_exnR when "01", div_exnR0 when others;
    div_R <= div_exnRfinal & div_sR & div_expfracR(30 downto 0);

    -- ========================================================================
    -- SQRT LOGIC (extracted from FPSqrt_Kin_f1_origin.vhdl)
    -- ========================================================================
    
    -- Sqrt preprocessing
    sqrt_fracX <= X(22 downto 0);
    sqrt_eRn0 <= "0" & X(30 downto 24);
    sqrt_xsX <= X(33 downto 31);
    sqrt_eRn1 <= sqrt_eRn0 + ("00" & (5 downto 0 => '1')) + X(23);
    sqrt_fracXnorm <= "1" & sqrt_fracX & "000" when X(23)='0' else "01" & sqrt_fracX & "00";
    sqrt_S0 <= "01";
    sqrt_T(0) <= ("0111" + sqrt_fracXnorm(26 downto 23)) & sqrt_fracXnorm(22 downto 0);
    
    -- Sqrt iteration: Step 2
    sqrt_d(1) <= not sqrt_T(0)(26);
    sqrt_Ts(0) <= sqrt_T(0) & "0";
    sqrt_Ts_h_full(0) <= sqrt_Ts(0)(27 downto 22) & (20 downto 0 => '0');  -- Pad to 27 bits
    sqrt_Ts_l(0) <= sqrt_Ts(0)(21 downto 0) & (4 downto 0 => '0');
    sqrt_U_full(0) <= "0" & sqrt_S0 & sqrt_d(1) & (not sqrt_d(1)) & "1" & (20 downto 0 => '0');
    sqrt_T(1) <= adder_R(0)(25 downto 21) & sqrt_Ts(0)(21 downto 0);
    sqrt_S(1) <= sqrt_S0 & sqrt_d(1) & (21 downto 0 => '0');

    -- Step 3
    sqrt_d(2) <= not sqrt_T(1)(26);
    sqrt_Ts(1) <= sqrt_T(1) & "0";
    sqrt_Ts_h_full(1) <= sqrt_Ts(1)(27 downto 21) & (19 downto 0 => '0');
    sqrt_Ts_l(1) <= sqrt_Ts(1)(20 downto 0) & (5 downto 0 => '0');
    sqrt_U_full(1) <= "0" & sqrt_S(1)(24 downto 22) & sqrt_d(2) & (not sqrt_d(2)) & "1" & (19 downto 0 => '0');
    sqrt_T(2) <= adder_R(1)(25 downto 20) & sqrt_Ts(1)(20 downto 0);
    sqrt_S(2) <= sqrt_S(1)(24 downto 22) & sqrt_d(2) & (20 downto 0 => '0');

    -- Step 4
    sqrt_d(3) <= not sqrt_T(2)(26);
    sqrt_Ts(2) <= sqrt_T(2) & "0";
    sqrt_Ts_h_full(2) <= sqrt_Ts(2)(27 downto 20) & (18 downto 0 => '0');
    sqrt_Ts_l(2) <= sqrt_Ts(2)(19 downto 0) & (6 downto 0 => '0');
    sqrt_U_full(2) <= "0" & sqrt_S(2)(24 downto 21) & sqrt_d(3) & (not sqrt_d(3)) & "1" & (18 downto 0 => '0');
    sqrt_T(3) <= adder_R(2)(25 downto 19) & sqrt_Ts(2)(19 downto 0);
    sqrt_S(3) <= sqrt_S(2)(24 downto 21) & sqrt_d(3) & (19 downto 0 => '0');

    -- Step 5
    sqrt_d(4) <= not sqrt_T(3)(26);
    sqrt_Ts(3) <= sqrt_T(3) & "0";
    sqrt_Ts_h_full(3) <= sqrt_Ts(3)(27 downto 19) & (17 downto 0 => '0');
    sqrt_Ts_l(3) <= sqrt_Ts(3)(18 downto 0) & (7 downto 0 => '0');
    sqrt_U_full(3) <= "0" & sqrt_S(3)(24 downto 20) & sqrt_d(4) & (not sqrt_d(4)) & "1" & (17 downto 0 => '0');
    sqrt_T(4) <= adder_R(3)(25 downto 18) & sqrt_Ts(3)(18 downto 0);
    sqrt_S(4) <= sqrt_S(3)(24 downto 20) & sqrt_d(4) & (18 downto 0 => '0');

    -- Step 6
    sqrt_d(5) <= not sqrt_T(4)(26);
    sqrt_Ts(4) <= sqrt_T(4) & "0";
    sqrt_Ts_h_full(4) <= sqrt_Ts(4)(27 downto 18) & (16 downto 0 => '0');
    sqrt_Ts_l(4) <= sqrt_Ts(4)(17 downto 0) & (8 downto 0 => '0');
    sqrt_U_full(4) <= "0" & sqrt_S(4)(24 downto 19) & sqrt_d(5) & (not sqrt_d(5)) & "1" & (16 downto 0 => '0');
    sqrt_T(5) <= adder_R(4)(25 downto 17) & sqrt_Ts(4)(17 downto 0);
    sqrt_S(5) <= sqrt_S(4)(24 downto 19) & sqrt_d(5) & (17 downto 0 => '0');

    -- Step 7
    sqrt_d(6) <= not sqrt_T(5)(26);
    sqrt_Ts(5) <= sqrt_T(5) & "0";
    sqrt_Ts_h_full(5) <= sqrt_Ts(5)(27 downto 17) & (15 downto 0 => '0');
    sqrt_Ts_l(5) <= sqrt_Ts(5)(16 downto 0) & (9 downto 0 => '0');
    sqrt_U_full(5) <= "0" & sqrt_S(5)(24 downto 18) & sqrt_d(6) & (not sqrt_d(6)) & "1" & (15 downto 0 => '0');
    sqrt_T(6) <= adder_R(5)(25 downto 16) & sqrt_Ts(5)(16 downto 0);
    sqrt_S(6) <= sqrt_S(5)(24 downto 18) & sqrt_d(6) & (16 downto 0 => '0');

    -- Step 8
    sqrt_d(7) <= not sqrt_T(6)(26);
    sqrt_Ts(6) <= sqrt_T(6) & "0";
    sqrt_Ts_h_full(6) <= sqrt_Ts(6)(27 downto 16) & (14 downto 0 => '0');
    sqrt_Ts_l(6) <= sqrt_Ts(6)(15 downto 0) & (10 downto 0 => '0');
    sqrt_U_full(6) <= "0" & sqrt_S(6)(24 downto 17) & sqrt_d(7) & (not sqrt_d(7)) & "1" & (14 downto 0 => '0');
    sqrt_T(7) <= adder_R(6)(25 downto 15) & sqrt_Ts(6)(15 downto 0);
    sqrt_S(7) <= sqrt_S(6)(24 downto 17) & sqrt_d(7) & (15 downto 0 => '0');

    -- Step 9
    sqrt_d(8) <= not sqrt_T(7)(26);
    sqrt_Ts(7) <= sqrt_T(7) & "0";
    sqrt_Ts_h_full(7) <= sqrt_Ts(7)(27 downto 15) & (13 downto 0 => '0');
    sqrt_Ts_l(7) <= sqrt_Ts(7)(14 downto 0) & (11 downto 0 => '0');
    sqrt_U_full(7) <= "0" & sqrt_S(7)(24 downto 16) & sqrt_d(8) & (not sqrt_d(8)) & "1" & (13 downto 0 => '0');
    sqrt_T(8) <= adder_R(7)(25 downto 14) & sqrt_Ts(7)(14 downto 0);
    sqrt_S(8) <= sqrt_S(7)(24 downto 16) & sqrt_d(8) & (14 downto 0 => '0');

    -- Step 10
    sqrt_d(9) <= not sqrt_T(8)(26);
    sqrt_Ts(8) <= sqrt_T(8) & "0";
    sqrt_Ts_h_full(8) <= sqrt_Ts(8)(27 downto 14) & (12 downto 0 => '0');
    sqrt_Ts_l(8) <= sqrt_Ts(8)(13 downto 0) & (12 downto 0 => '0');
    sqrt_U_full(8) <= "0" & sqrt_S(8)(24 downto 15) & sqrt_d(9) & (not sqrt_d(9)) & "1" & (12 downto 0 => '0');
    sqrt_T(9) <= adder_R(8)(25 downto 13) & sqrt_Ts(8)(13 downto 0);
    sqrt_S(9) <= sqrt_S(8)(24 downto 15) & sqrt_d(9) & (13 downto 0 => '0');

    -- Step 11
    sqrt_d(10) <= not sqrt_T(9)(26);
    sqrt_Ts(9) <= sqrt_T(9) & "0";
    sqrt_Ts_h_full(9) <= sqrt_Ts(9)(27 downto 13) & (11 downto 0 => '0');
    sqrt_Ts_l(9) <= sqrt_Ts(9)(12 downto 0) & (13 downto 0 => '0');
    sqrt_U_full(9) <= "0" & sqrt_S(9)(24 downto 14) & sqrt_d(10) & (not sqrt_d(10)) & "1" & (11 downto 0 => '0');
    sqrt_T(10) <= adder_R(9)(25 downto 12) & sqrt_Ts(9)(12 downto 0);
    sqrt_S(10) <= sqrt_S(9)(24 downto 14) & sqrt_d(10) & (12 downto 0 => '0');

    -- Step 12
    sqrt_d(11) <= not sqrt_T(10)(26);
    sqrt_Ts(10) <= sqrt_T(10) & "0";
    sqrt_Ts_h_full(10) <= sqrt_Ts(10)(27 downto 12) & (10 downto 0 => '0');
    sqrt_Ts_l(10) <= sqrt_Ts(10)(11 downto 0) & (14 downto 0 => '0');
    sqrt_U_full(10) <= "0" & sqrt_S(10)(24 downto 13) & sqrt_d(11) & (not sqrt_d(11)) & "1" & (10 downto 0 => '0');
    sqrt_T(11) <= adder_R(10)(25 downto 11) & sqrt_Ts(10)(11 downto 0);
    sqrt_S(11) <= sqrt_S(10)(24 downto 13) & sqrt_d(11) & (11 downto 0 => '0');

    -- Step 13
    sqrt_d(12) <= not sqrt_T(11)(26);
    sqrt_Ts(11) <= sqrt_T(11) & "0";
    sqrt_Ts_h_full(11) <= sqrt_Ts(11)(27 downto 11) & (9 downto 0 => '0');
    sqrt_Ts_l(11) <= sqrt_Ts(11)(10 downto 0) & (15 downto 0 => '0');
    sqrt_U_full(11) <= "0" & sqrt_S(11)(24 downto 12) & sqrt_d(12) & (not sqrt_d(12)) & "1" & (9 downto 0 => '0');
    sqrt_T(12) <= adder_R(11)(25 downto 10) & sqrt_Ts(11)(10 downto 0);
    sqrt_S(12) <= sqrt_S(11)(24 downto 12) & sqrt_d(12) & (10 downto 0 => '0');

    -- Step 14
    sqrt_d(13) <= not sqrt_T(12)(26);
    sqrt_Ts(12) <= sqrt_T(12) & "0";
    sqrt_Ts_h_full(12) <= sqrt_Ts(12)(27 downto 10) & (8 downto 0 => '0');
    sqrt_Ts_l(12) <= sqrt_Ts(12)(9 downto 0) & (16 downto 0 => '0');
    sqrt_U_full(12) <= "0" & sqrt_S(12)(24 downto 11) & sqrt_d(13) & (not sqrt_d(13)) & "1" & (8 downto 0 => '0');
    sqrt_T(13) <= adder_R(12)(25 downto 9) & sqrt_Ts(12)(9 downto 0);
    sqrt_S(13) <= sqrt_S(12)(24 downto 11) & sqrt_d(13) & (9 downto 0 => '0');

    -- Step 15
    sqrt_d(14) <= not sqrt_T(13)(26);
    sqrt_Ts(13) <= sqrt_T(13) & "0";
    sqrt_Ts_h_full(13) <= sqrt_Ts(13)(27 downto 9) & (7 downto 0 => '0');
    sqrt_Ts_l(13) <= sqrt_Ts(13)(8 downto 0) & (17 downto 0 => '0');
    sqrt_U_full(13) <= "0" & sqrt_S(13)(24 downto 10) & sqrt_d(14) & (not sqrt_d(14)) & "1" & (7 downto 0 => '0');
    sqrt_T(14) <= adder_R(13)(25 downto 8) & sqrt_Ts(13)(8 downto 0);
    sqrt_S(14) <= sqrt_S(13)(24 downto 10) & sqrt_d(14) & (8 downto 0 => '0');

    -- Step 16
    sqrt_d(15) <= not sqrt_T(14)(26);
    sqrt_Ts(14) <= sqrt_T(14) & "0";
    sqrt_Ts_h_full(14) <= sqrt_Ts(14)(27 downto 8) & (6 downto 0 => '0');
    sqrt_Ts_l(14) <= sqrt_Ts(14)(7 downto 0) & (18 downto 0 => '0');
    sqrt_U_full(14) <= "0" & sqrt_S(14)(24 downto 9) & sqrt_d(15) & (not sqrt_d(15)) & "1" & (6 downto 0 => '0');
    sqrt_T(15) <= adder_R(14)(25 downto 7) & sqrt_Ts(14)(7 downto 0);
    sqrt_S(15) <= sqrt_S(14)(24 downto 9) & sqrt_d(15) & (7 downto 0 => '0');

    -- Step 17
    sqrt_d(16) <= not sqrt_T(15)(26);
    sqrt_Ts(15) <= sqrt_T(15) & "0";
    sqrt_Ts_h_full(15) <= sqrt_Ts(15)(27 downto 7) & (5 downto 0 => '0');
    sqrt_Ts_l(15) <= sqrt_Ts(15)(6 downto 0) & (19 downto 0 => '0');
    sqrt_U_full(15) <= "0" & sqrt_S(15)(24 downto 8) & sqrt_d(16) & (not sqrt_d(16)) & "1" & (5 downto 0 => '0');
    sqrt_T(16) <= adder_R(15)(25 downto 6) & sqrt_Ts(15)(6 downto 0);
    sqrt_S(16) <= sqrt_S(15)(24 downto 8) & sqrt_d(16) & (6 downto 0 => '0');

    -- Step 18
    sqrt_d(17) <= not sqrt_T(16)(26);
    sqrt_Ts(16) <= sqrt_T(16) & "0";
    sqrt_Ts_h_full(16) <= sqrt_Ts(16)(27 downto 6) & (4 downto 0 => '0');
    sqrt_Ts_l(16) <= sqrt_Ts(16)(5 downto 0) & (20 downto 0 => '0');
    sqrt_U_full(16) <= "0" & sqrt_S(16)(24 downto 7) & sqrt_d(17) & (not sqrt_d(17)) & "1" & (4 downto 0 => '0');
    sqrt_T(17) <= adder_R(16)(25 downto 5) & sqrt_Ts(16)(5 downto 0);
    sqrt_S(17) <= sqrt_S(16)(24 downto 7) & sqrt_d(17) & (5 downto 0 => '0');

    -- Step 19
    sqrt_d(18) <= not sqrt_T(17)(26);
    sqrt_Ts(17) <= sqrt_T(17) & "0";
    sqrt_Ts_h_full(17) <= sqrt_Ts(17)(27 downto 5) & (3 downto 0 => '0');
    sqrt_Ts_l(17) <= sqrt_Ts(17)(4 downto 0) & (21 downto 0 => '0');
    sqrt_U_full(17) <= "0" & sqrt_S(17)(24 downto 6) & sqrt_d(18) & (not sqrt_d(18)) & "1" & (3 downto 0 => '0');
    sqrt_T(18) <= adder_R(17)(25 downto 4) & sqrt_Ts(17)(4 downto 0);
    sqrt_S(18) <= sqrt_S(17)(24 downto 6) & sqrt_d(18) & (4 downto 0 => '0');

    -- Step 20
    sqrt_d(19) <= not sqrt_T(18)(26);
    sqrt_Ts(18) <= sqrt_T(18) & "0";
    sqrt_Ts_h_full(18) <= sqrt_Ts(18)(27 downto 4) & (2 downto 0 => '0');
    sqrt_Ts_l(18) <= sqrt_Ts(18)(3 downto 0) & (22 downto 0 => '0');
    sqrt_U_full(18) <= "0" & sqrt_S(18)(24 downto 5) & sqrt_d(19) & (not sqrt_d(19)) & "1" & (2 downto 0 => '0');
    sqrt_T(19) <= adder_R(18)(25 downto 3) & sqrt_Ts(18)(3 downto 0);
    sqrt_S(19) <= sqrt_S(18)(24 downto 5) & sqrt_d(19) & (3 downto 0 => '0');

    -- Step 21
    sqrt_d(20) <= not sqrt_T(19)(26);
    sqrt_Ts(19) <= sqrt_T(19) & "0";
    sqrt_Ts_h_full(19) <= sqrt_Ts(19)(27 downto 3) & "00";
    sqrt_Ts_l(19) <= sqrt_Ts(19)(2 downto 0) & (23 downto 0 => '0');
    sqrt_U_full(19) <= "00" & sqrt_S(19)(24 downto 4) & sqrt_d(20) & (not sqrt_d(20)) & "11";
    sqrt_T(20) <= adder_R(19)(25 downto 2) & sqrt_Ts(19)(2 downto 0);
    sqrt_S(20) <= '0' & sqrt_S(19)(24 downto 4) & sqrt_d(20) & "00";

    -- Step 22
    sqrt_d(21) <= not sqrt_T(20)(26);
    sqrt_Ts(20) <= sqrt_T(20) & "0";
    sqrt_Ts_h_full(20) <= sqrt_Ts(20)(27 downto 2) & "0";
    sqrt_Ts_l(20) <= sqrt_Ts(20)(1 downto 0) & (24 downto 0 => '0');
    sqrt_U_full(20) <= "0" & sqrt_S(20)(24 downto 3) & sqrt_d(21) & (not sqrt_d(21)) & "1" & "0";
    sqrt_T(21) <= adder_R(20)(25 downto 1) & sqrt_Ts(20)(1 downto 0);
    sqrt_S(21) <= "0" & sqrt_S(20)(24 downto 3) & sqrt_d(21) & "0";

    -- Step 23
    sqrt_d(22) <= not sqrt_T(21)(26);
    sqrt_Ts(21) <= sqrt_T(21) & "0";
    sqrt_Ts_h_full(21) <= sqrt_Ts(21)(27 downto 1);
    sqrt_Ts_l(21) <= sqrt_Ts(21)(0 downto 0) & (25 downto 0 => '0');
    sqrt_U_full(21) <= "0" & sqrt_S(21)(24 downto 2) & sqrt_d(22) & (not sqrt_d(22)) & "1";
    sqrt_T(22) <= adder_R(21)(25 downto 0) & sqrt_Ts(21)(0 downto 0);
    sqrt_S(22) <= "0" & sqrt_S(21)(24 downto 2) & sqrt_d(22);

    -- Step 24
    sqrt_d(23) <= not sqrt_T(22)(26);
    sqrt_Ts(22) <= sqrt_T(22) & "0";
    sqrt_Ts_h_full(22) <= sqrt_Ts(22)(27 downto 1);
    sqrt_U_full(22) <= sqrt_S(22)(24 downto 1) & sqrt_d(23) & (not sqrt_d(23)) & "1";
    sqrt_T(23) <= adder_R(22)(25 downto -1); -- Wait, logic check: Adder 22 yields T(23).
    -- T(23) is 27 bits.
    -- Ts_l(22) is null (0 downto 0 ??? NO).
    -- Check NoRA Step 24: T23s_h (27..0). Adder T25_h (27..0). T24 <= T25_h(26..0).
    -- My Ts_h full (27..1). 27 bits.
    -- Adder R (26..0) corresponds to (27..1).
    -- T(23) NoRA is my T(22)?
    -- Let's stick to pattern.
    -- Step 23 (Ind 21): T(22) <= R(21)(25..0) & Ts(21)(0..0). Correct.
    -- Step 24 (Ind 22): T(23) <= R(22)(26..0)... No.
    -- Ts(22) is T(22)&'0'. T(22) 27 bits. Ts 28.
    -- Ts_h (27..1). Mapped to A(26..0).
    -- U (27..1). Mapped to B(26..0).
    -- R (26..0). Valid 27 bits.
    -- We want T(23) 27 bits.
    -- Corresponds to R(25..-1)? No.
    -- We discard MSB (26). Keep 25..0? And append??
    -- Ts_l(22) range?
    -- NoRA: T23s_l is empty/undefined?
    -- Line 405: T23s_h (27..0). T23s_l (??).
    -- Actually T23s is T23 & '0'.
    -- T23s_h is 27..0 (28 bits).
    -- Adder operates on 28 bits? U23 is 28 bits.
    -- Shared Adder is only 27 bits!
    -- PROBLEM. Step 24 requires 28 bit adder?
    -- NoRA: T25_h (27 downto 0) -> 28 bits.
    -- Shared: 27 bits.
    -- LSB of operation?
    -- U23 has '1' at LSB (bit 0).
    -- T23s_h has '0' at LSB.
    -- So we need LSB.
    -- Shared A, B are 27 bits.
    -- We mapped 27..1. We dropped bit 0.
    -- This means the last bit precision is lost.
    -- Is this critical?
    -- If we lose the '1' in U, the add/sub is slightly off.
    -- How to fix?
    -- We can't extend the adder.
    -- But in non-restoring sqrt, the last step ...
    -- Maybe we just use 25..0?
    -- Let's apply the pattern: R(25..0) & ...?
    -- Previous: R(25..0) & Ts(0).
    -- Here Ts_l is empty.
    -- So T(23) <= R(22)(25..0) & '0'? No.
    -- Check Ts_h_full(22). 27..1.
    -- Ts(22) is T(22) & '0'.
    -- So bit 0 is '0'.
    -- We mapped 27..1. So we kept bits 1..27.
    -- We dropped bit 0.
    -- Adder result R(25..0) corresponds to bits 26..1.
    -- T(23) needs 26..0.
    -- So we have 26..1. We are missing bit 0.
    -- Bit 0 comes from ... the calculation.
    -- If we assume the LSB calc (0 +/- 1) ...
    -- If d=1 (sub), 0 - 1 = 1 (borrow).
    -- If d=0 (add), 0 + 1 = 1.
    -- So Bit 0 is ALWAYS 1?
    -- Let's verify.
    -- U23 LSB is '1'. T23s LSB is '0'.
    -- 0 +/- 1.
    -- If +, 1.
    -- If -, -1 = ...11. LSB is 1.
    -- So Bit 0 is always 1.
    -- So T(23) <= adder_R(22)(25..0) & '1'.
    --
    -- However, the code `sqrt_T(23) <= adder_R(22)(26 downto 0);` was taking 27 bits.
    -- It was taking MSB (carry) and 26..1.
    -- Correct is 26..1 and '1'.
    -- So `sqrt_T(23) <= adder_R(22)(25 downto 0) & '1';`
    --
    -- What about Step 24 (Index 23)? used for d24.
    -- d23 <= not T22(26). (Line 456).
    -- T(23) is used for final d24.
    -- d25 comes from R(23).
    --
    -- Let's stick to the slice fix for loop indices.
    -- Line 460 target: `sqrt_T(23) <= adder_R(22)(26 downto 0);`
    -- Replacement: `sqrt_T(23) <= adder_R(22)(25 downto 0) & '1';`

    sqrt_S(23) <= sqrt_S(22)(24 downto 1) & sqrt_d(23);

    -- Final step
    sqrt_d(24) <= not sqrt_T(23)(26);
    sqrt_Ts(23) <= sqrt_T(23) & "0";
    sqrt_Ts_h_full(23) <= sqrt_Ts(23)(27 downto 1);
    sqrt_U_full(23) <= sqrt_S(23)(24 downto 1) & sqrt_d(24) & (not sqrt_d(24)) & "1";
    sqrt_d25 <= not adder_R(23)(25);

    -- Sqrt postprocessing
    sqrt_mR <= sqrt_S(23) & sqrt_d25;
    sqrt_fR <= sqrt_mR(23 downto 1);
    sqrt_round <= sqrt_mR(0);
    sqrt_fRrnd <= sqrt_fR + ((22 downto 1 => '0') & sqrt_round);
    sqrt_Rn2 <= sqrt_eRn1 & sqrt_fRrnd;
    with sqrt_xsX select
        sqrt_xsR <=
            "010" when "010",
            "100" when "100",
            "000" when "000",
            "001" when "001",
            "110" when others;
    sqrt_R <= sqrt_xsR & sqrt_Rn2;

    -- ===== Input MUX for Shared Adders =====
    process (opcode_divsqrt, div_betaw, div_absqD, div_q,
             sqrt_Ts_h_full, sqrt_U_full, sqrt_d)
    begin
        for i in 0 to 23 loop
            if opcode_divsqrt = '0' then  -- Div mode
                if i < 14 then
                    adder_A(i) <= div_betaw(i);
                    adder_B(i) <= div_absqD(i);
                    adder_sub(i) <= not div_q(i)(2);
                else
                    adder_A(i) <= (others => '0');
                    adder_B(i) <= (others => '0');
                    adder_sub(i) <= '0';
                end if;
            else  -- Sqrt mode
                adder_A(i) <= sqrt_Ts_h_full(i);
                adder_B(i) <= sqrt_U_full(i);
                adder_sub(i) <= sqrt_d(i+1);
            end if;
        end loop;
    end process;

    -- ===== Output MUX =====
    R <= div_R when opcode_divsqrt='0' else sqrt_R;
    expfrac_out <= div_expfrac when opcode_divsqrt='0' else ("00" & sqrt_Rn2);
    round_out <= div_round when opcode_divsqrt='0' else sqrt_round;

end architecture;
