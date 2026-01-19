--------------------------------------------------------------------------------
--                           FPDiv_NoRA
-- VHDL generated for Kintex7 @ 1MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Maxime Christ, Florent de Dinechin (2015)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1000
-- Target frequency (MHz): 1
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPDiv_NoRA is
    port (clk : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          round_out : out std_logic;
          expfrac_out: out std_logic_vector(32 downto 0);
          expfracR_in : in std_logic_vector(32 downto 0)
          );
end entity;

architecture arch of FPDiv_NoRA is
   component selFunction_Freq1_uid4 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : out  std_logic_vector(2 downto 0)   );
   end component;

signal fX :  std_logic_vector(23 downto 0);
signal fY :  std_logic_vector(23 downto 0);
signal expR0 :  std_logic_vector(9 downto 0);
signal sR :  std_logic;
signal exnXY :  std_logic_vector(3 downto 0);
signal exnR0 :  std_logic_vector(1 downto 0);
signal D :  std_logic_vector(23 downto 0);
signal psX :  std_logic_vector(24 downto 0);
signal betaw14 :  std_logic_vector(26 downto 0);
signal sel14 :  std_logic_vector(8 downto 0);
signal q14 :  std_logic_vector(2 downto 0);
signal q14_copy5 :  std_logic_vector(2 downto 0);
signal absq14D :  std_logic_vector(26 downto 0);
signal w13 :  std_logic_vector(26 downto 0);
signal betaw13 :  std_logic_vector(26 downto 0);
signal sel13 :  std_logic_vector(8 downto 0);
signal q13 :  std_logic_vector(2 downto 0);
signal q13_copy6 :  std_logic_vector(2 downto 0);
signal absq13D :  std_logic_vector(26 downto 0);
signal w12 :  std_logic_vector(26 downto 0);
signal betaw12 :  std_logic_vector(26 downto 0);
signal sel12 :  std_logic_vector(8 downto 0);
signal q12 :  std_logic_vector(2 downto 0);
signal q12_copy7 :  std_logic_vector(2 downto 0);
signal absq12D :  std_logic_vector(26 downto 0);
signal w11 :  std_logic_vector(26 downto 0);
signal betaw11 :  std_logic_vector(26 downto 0);
signal sel11 :  std_logic_vector(8 downto 0);
signal q11 :  std_logic_vector(2 downto 0);
signal q11_copy8 :  std_logic_vector(2 downto 0);
signal absq11D :  std_logic_vector(26 downto 0);
signal w10 :  std_logic_vector(26 downto 0);
signal betaw10 :  std_logic_vector(26 downto 0);
signal sel10 :  std_logic_vector(8 downto 0);
signal q10 :  std_logic_vector(2 downto 0);
signal q10_copy9 :  std_logic_vector(2 downto 0);
signal absq10D :  std_logic_vector(26 downto 0);
signal w9 :  std_logic_vector(26 downto 0);
signal betaw9 :  std_logic_vector(26 downto 0);
signal sel9 :  std_logic_vector(8 downto 0);
signal q9 :  std_logic_vector(2 downto 0);
signal q9_copy10 :  std_logic_vector(2 downto 0);
signal absq9D :  std_logic_vector(26 downto 0);
signal w8 :  std_logic_vector(26 downto 0);
signal betaw8 :  std_logic_vector(26 downto 0);
signal sel8 :  std_logic_vector(8 downto 0);
signal q8 :  std_logic_vector(2 downto 0);
signal q8_copy11 :  std_logic_vector(2 downto 0);
signal absq8D :  std_logic_vector(26 downto 0);
signal w7 :  std_logic_vector(26 downto 0);
signal betaw7 :  std_logic_vector(26 downto 0);
signal sel7 :  std_logic_vector(8 downto 0);
signal q7 :  std_logic_vector(2 downto 0);
signal q7_copy12 :  std_logic_vector(2 downto 0);
signal absq7D :  std_logic_vector(26 downto 0);
signal w6 :  std_logic_vector(26 downto 0);
signal betaw6 :  std_logic_vector(26 downto 0);
signal sel6 :  std_logic_vector(8 downto 0);
signal q6 :  std_logic_vector(2 downto 0);
signal q6_copy13 :  std_logic_vector(2 downto 0);
signal absq6D :  std_logic_vector(26 downto 0);
signal w5 :  std_logic_vector(26 downto 0);
signal betaw5 :  std_logic_vector(26 downto 0);
signal sel5 :  std_logic_vector(8 downto 0);
signal q5 :  std_logic_vector(2 downto 0);
signal q5_copy14 :  std_logic_vector(2 downto 0);
signal absq5D :  std_logic_vector(26 downto 0);
signal w4 :  std_logic_vector(26 downto 0);
signal betaw4 :  std_logic_vector(26 downto 0);
signal sel4 :  std_logic_vector(8 downto 0);
signal q4 :  std_logic_vector(2 downto 0);
signal q4_copy15 :  std_logic_vector(2 downto 0);
signal absq4D :  std_logic_vector(26 downto 0);
signal w3 :  std_logic_vector(26 downto 0);
signal betaw3 :  std_logic_vector(26 downto 0);
signal sel3 :  std_logic_vector(8 downto 0);
signal q3 :  std_logic_vector(2 downto 0);
signal q3_copy16 :  std_logic_vector(2 downto 0);
signal absq3D :  std_logic_vector(26 downto 0);
signal w2 :  std_logic_vector(26 downto 0);
signal betaw2 :  std_logic_vector(26 downto 0);
signal sel2 :  std_logic_vector(8 downto 0);
signal q2 :  std_logic_vector(2 downto 0);
signal q2_copy17 :  std_logic_vector(2 downto 0);
signal absq2D :  std_logic_vector(26 downto 0);
signal w1 :  std_logic_vector(26 downto 0);
signal betaw1 :  std_logic_vector(26 downto 0);
signal sel1 :  std_logic_vector(8 downto 0);
signal q1 :  std_logic_vector(2 downto 0);
signal q1_copy18 :  std_logic_vector(2 downto 0);
signal absq1D :  std_logic_vector(26 downto 0);
signal w0 :  std_logic_vector(26 downto 0);
signal wfinal :  std_logic_vector(24 downto 0);
signal qM0 :  std_logic;
signal qP14 :  std_logic_vector(1 downto 0);
signal qM14 :  std_logic_vector(1 downto 0);
signal qP13 :  std_logic_vector(1 downto 0);
signal qM13 :  std_logic_vector(1 downto 0);
signal qP12 :  std_logic_vector(1 downto 0);
signal qM12 :  std_logic_vector(1 downto 0);
signal qP11 :  std_logic_vector(1 downto 0);
signal qM11 :  std_logic_vector(1 downto 0);
signal qP10 :  std_logic_vector(1 downto 0);
signal qM10 :  std_logic_vector(1 downto 0);
signal qP9 :  std_logic_vector(1 downto 0);
signal qM9 :  std_logic_vector(1 downto 0);
signal qP8 :  std_logic_vector(1 downto 0);
signal qM8 :  std_logic_vector(1 downto 0);
signal qP7 :  std_logic_vector(1 downto 0);
signal qM7 :  std_logic_vector(1 downto 0);
signal qP6 :  std_logic_vector(1 downto 0);
signal qM6 :  std_logic_vector(1 downto 0);
signal qP5 :  std_logic_vector(1 downto 0);
signal qM5 :  std_logic_vector(1 downto 0);
signal qP4 :  std_logic_vector(1 downto 0);
signal qM4 :  std_logic_vector(1 downto 0);
signal qP3 :  std_logic_vector(1 downto 0);
signal qM3 :  std_logic_vector(1 downto 0);
signal qP2 :  std_logic_vector(1 downto 0);
signal qM2 :  std_logic_vector(1 downto 0);
signal qP1 :  std_logic_vector(1 downto 0);
signal qM1 :  std_logic_vector(1 downto 0);
signal qP :  std_logic_vector(27 downto 0);
signal qM :  std_logic_vector(27 downto 0);
signal quotient :  std_logic_vector(27 downto 0);
signal mR :  std_logic_vector(25 downto 0);
signal fRnorm :  std_logic_vector(23 downto 0);
signal round :  std_logic;
signal expR1 :  std_logic_vector(9 downto 0);
signal expfrac :  std_logic_vector(32 downto 0);
signal expfracR :  std_logic_vector(32 downto 0);
signal exnR :  std_logic_vector(1 downto 0);
signal exnRfinal :  std_logic_vector(1 downto 0);
begin
   fX <= "1" & X(22 downto 0);
   fY <= "1" & Y(22 downto 0);
   expR0 <= ("00" & X(30 downto 23)) - ("00" & Y(30 downto 23));
   sR <= X(31) xor Y(31);
   exnXY <= X(33 downto 32) & Y(33 downto 32);
   with exnXY  select 
      exnR0 <= 
         "01"	 when "0101",
         "00"	 when "0001" | "0010" | "0110",
         "10"	 when "0100" | "1000" | "1001",
         "11"	 when others;

   D <= fY ;
   psX <= "0" & fX ;
   betaw14 <=  "00" & psX;
   sel14 <= betaw14(26 downto 21) & D(22 downto 20);
   SelFunctionTable14: selFunction_Freq1_uid4
      port map ( X => sel14,
                 Y => q14_copy5);
   q14 <= q14_copy5;

   with q14  select 
      absq14D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q14(2)  select
   w13<= betaw14 - absq14D when '0',
         betaw14 + absq14D when others;

   betaw13 <= w13(24 downto 0) & "00";
   sel13 <= betaw13(26 downto 21) & D(22 downto 20);
   SelFunctionTable13: selFunction_Freq1_uid4
      port map ( X => sel13,
                 Y => q13_copy6);
   q13 <= q13_copy6;

   with q13  select 
      absq13D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q13(2)  select 
   w12<= betaw13 - absq13D when '0',
         betaw13 + absq13D when others;

   betaw12 <= w12(24 downto 0) & "00";
   sel12 <= betaw12(26 downto 21) & D(22 downto 20);
   SelFunctionTable12: selFunction_Freq1_uid4
      port map ( X => sel12,
                 Y => q12_copy7);
   q12 <= q12_copy7;

   with q12  select 
      absq12D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q12(2)  select 
   w11<= betaw12 - absq12D when '0',
         betaw12 + absq12D when others;

   betaw11 <= w11(24 downto 0) & "00";
   sel11 <= betaw11(26 downto 21) & D(22 downto 20);
   SelFunctionTable11: selFunction_Freq1_uid4
      port map ( X => sel11,
                 Y => q11_copy8);
   q11 <= q11_copy8;

   with q11  select 
      absq11D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q11(2)  select 
   w10<= betaw11 - absq11D when '0',
         betaw11 + absq11D when others;

   betaw10 <= w10(24 downto 0) & "00";
   sel10 <= betaw10(26 downto 21) & D(22 downto 20);
   SelFunctionTable10: selFunction_Freq1_uid4
      port map ( X => sel10,
                 Y => q10_copy9);
   q10 <= q10_copy9;

   with q10  select 
      absq10D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q10(2)  select 
   w9<= betaw10 - absq10D when '0',
         betaw10 + absq10D when others;

   betaw9 <= w9(24 downto 0) & "00";
   sel9 <= betaw9(26 downto 21) & D(22 downto 20);
   SelFunctionTable9: selFunction_Freq1_uid4
      port map ( X => sel9,
                 Y => q9_copy10);
   q9 <= q9_copy10;

   with q9  select 
      absq9D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q9(2)  select 
   w8<= betaw9 - absq9D when '0',
         betaw9 + absq9D when others;

   betaw8 <= w8(24 downto 0) & "00";
   sel8 <= betaw8(26 downto 21) & D(22 downto 20);
   SelFunctionTable8: selFunction_Freq1_uid4
      port map ( X => sel8,
                 Y => q8_copy11);
   q8 <= q8_copy11;

   with q8  select 
      absq8D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q8(2)  select 
   w7<= betaw8 - absq8D when '0',
         betaw8 + absq8D when others;

   betaw7 <= w7(24 downto 0) & "00";
   sel7 <= betaw7(26 downto 21) & D(22 downto 20);
   SelFunctionTable7: selFunction_Freq1_uid4
      port map ( X => sel7,
                 Y => q7_copy12);
   q7 <= q7_copy12;

   with q7  select 
      absq7D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q7(2)  select 
   w6<= betaw7 - absq7D when '0',
         betaw7 + absq7D when others;

   betaw6 <= w6(24 downto 0) & "00";
   sel6 <= betaw6(26 downto 21) & D(22 downto 20);
   SelFunctionTable6: selFunction_Freq1_uid4
      port map ( X => sel6,
                 Y => q6_copy13);
   q6 <= q6_copy13;

   with q6  select 
      absq6D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q6(2)  select 
   w5<= betaw6 - absq6D when '0',
         betaw6 + absq6D when others;

   betaw5 <= w5(24 downto 0) & "00";
   sel5 <= betaw5(26 downto 21) & D(22 downto 20);
   SelFunctionTable5: selFunction_Freq1_uid4
      port map ( X => sel5,
                 Y => q5_copy14);
   q5 <= q5_copy14;

   with q5  select 
      absq5D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q5(2)  select 
   w4<= betaw5 - absq5D when '0',
         betaw5 + absq5D when others;

   betaw4 <= w4(24 downto 0) & "00";
   sel4 <= betaw4(26 downto 21) & D(22 downto 20);
   SelFunctionTable4: selFunction_Freq1_uid4
      port map ( X => sel4,
                 Y => q4_copy15);
   q4 <= q4_copy15;

   with q4  select 
      absq4D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q4(2)  select 
   w3<= betaw4 - absq4D when '0',
         betaw4 + absq4D when others;

   betaw3 <= w3(24 downto 0) & "00";
   sel3 <= betaw3(26 downto 21) & D(22 downto 20);
   SelFunctionTable3: selFunction_Freq1_uid4
      port map ( X => sel3,
                 Y => q3_copy16);
   q3 <= q3_copy16;

   with q3  select 
      absq3D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q3(2)  select 
   w2<= betaw3 - absq3D when '0',
         betaw3 + absq3D when others;

   betaw2 <= w2(24 downto 0) & "00";
   sel2 <= betaw2(26 downto 21) & D(22 downto 20);
   SelFunctionTable2: selFunction_Freq1_uid4
      port map ( X => sel2,
                 Y => q2_copy17);
   q2 <= q2_copy17;

   with q2  select 
      absq2D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q2(2)  select 
   w1<= betaw2 - absq2D when '0',
         betaw2 + absq2D when others;

   betaw1 <= w1(24 downto 0) & "00";
   sel1 <= betaw1(26 downto 21) & D(22 downto 20);
   SelFunctionTable1: selFunction_Freq1_uid4
      port map ( X => sel1,
                 Y => q1_copy18);
   q1 <= q1_copy18;

   with q1  select 
      absq1D <= 
         "000" & D				 when "001" | "111",
         "00" & D & "0"		   when "010" | "110",
         (26 downto 0 => '0')	 when others;

   with q1(2)  select 
   w0<= betaw1 - absq1D when '0',
         betaw1 + absq1D when others;

   wfinal <= w0(24 downto 0);
   qM0 <= wfinal(24);
   qP14 <=      q14(1 downto 0);
   qM14 <=      q14(2) & "0";
   qP13 <=      q13(1 downto 0);
   qM13 <=      q13(2) & "0";
   qP12 <=      q12(1 downto 0);
   qM12 <=      q12(2) & "0";
   qP11 <=      q11(1 downto 0);
   qM11 <=      q11(2) & "0";
   qP10 <=      q10(1 downto 0);
   qM10 <=      q10(2) & "0";
   qP9 <=      q9(1 downto 0);
   qM9 <=      q9(2) & "0";
   qP8 <=      q8(1 downto 0);
   qM8 <=      q8(2) & "0";
   qP7 <=      q7(1 downto 0);
   qM7 <=      q7(2) & "0";
   qP6 <=      q6(1 downto 0);
   qM6 <=      q6(2) & "0";
   qP5 <=      q5(1 downto 0);
   qM5 <=      q5(2) & "0";
   qP4 <=      q4(1 downto 0);
   qM4 <=      q4(2) & "0";
   qP3 <=      q3(1 downto 0);
   qM3 <=      q3(2) & "0";
   qP2 <=      q2(1 downto 0);
   qM2 <=      q2(2) & "0";
   qP1 <=      q1(1 downto 0);
   qM1 <=      q1(2) & "0";
   qP <= qP14 & qP13 & qP12 & qP11 & qP10 & qP9 & qP8 & qP7 & qP6 & qP5 & qP4 & qP3 & qP2 & qP1;
   qM <= qM14(0) & qM13 & qM12 & qM11 & qM10 & qM9 & qM8 & qM7 & qM6 & qM5 & qM4 & qM3 & qM2 & qM1 & qM0;
   quotient <= qP - qM;
   mR <= quotient(26 downto 1);
   fRnorm <=    mR(24 downto 1)  when mR(25)= '1'
           else mR(23 downto 0);
   round <= fRnorm(0); 
   expR1 <= expR0 + ("000" & (6 downto 1 => '1') & mR(25));
   expfrac <= expR1 & fRnorm(23 downto 1) ;
   
   -- Output to shared rounding adder
   expfrac_out <= expfrac;
   round_out <= round;
   
   -- Input from shared rounding adder
   expfracR <= expfracR_in;
   
   exnR <=      "00"  when expfracR(32) = '1'
           else "10"  when  expfracR(32 downto 31) =  "01"
           else "01";
   with exnR0  select 
      exnRfinal <= 
         exnR   when "01",
         exnR0  when others;
   R <= exnRfinal & sR & expfracR(30 downto 0);
end architecture;
