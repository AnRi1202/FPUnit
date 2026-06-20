/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : U-2022.12
// Date      : Fri Jun 19 06:20:04 2026
/////////////////////////////////////////////////////////////


module AbsComparator ( fmt, operandX, operandY, swap );
  input [1:0] fmt;
  input [31:0] operandX;
  input [31:0] operandY;
  output [3:0] swap;
  wire   n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89;

  INV_X1 U47 ( .A(fmt[1]), .ZN(n15) );
  NOR2_X1 U48 ( .A1(fmt[0]), .A2(n15), .ZN(n73) );
  INV_X1 U49 ( .A(operandX[7]), .ZN(n29) );
  NOR3_X1 U50 ( .A1(operandY[7]), .A2(n73), .A3(n29), .ZN(n32) );
  INV_X1 U51 ( .A(operandY[5]), .ZN(n26) );
  INV_X1 U52 ( .A(operandY[3]), .ZN(n22) );
  INV_X1 U53 ( .A(operandX[1]), .ZN(n16) );
  OAI21_X1 U54 ( .B1(operandY[1]), .B2(n16), .A(operandY[0]), .ZN(n18) );
  INV_X1 U55 ( .A(operandY[1]), .ZN(n17) );
  OAI22_X1 U56 ( .A1(operandX[0]), .A2(n18), .B1(operandX[1]), .B2(n17), .ZN(
        n20) );
  INV_X1 U57 ( .A(operandX[2]), .ZN(n19) );
  AOI222_X1 U58 ( .A1(operandY[2]), .A2(n20), .B1(operandY[2]), .B2(n19), .C1(
        n20), .C2(n19), .ZN(n21) );
  AOI222_X1 U59 ( .A1(operandX[3]), .A2(n22), .B1(operandX[3]), .B2(n21), .C1(
        n22), .C2(n21), .ZN(n24) );
  INV_X1 U60 ( .A(operandX[4]), .ZN(n23) );
  AOI222_X1 U61 ( .A1(operandY[4]), .A2(n24), .B1(operandY[4]), .B2(n23), .C1(
        n24), .C2(n23), .ZN(n25) );
  AOI222_X1 U62 ( .A1(operandX[5]), .A2(n26), .B1(operandX[5]), .B2(n25), .C1(
        n26), .C2(n25), .ZN(n28) );
  INV_X1 U63 ( .A(operandX[6]), .ZN(n27) );
  AOI222_X1 U64 ( .A1(operandY[6]), .A2(n28), .B1(operandY[6]), .B2(n27), .C1(
        n28), .C2(n27), .ZN(n31) );
  NAND2_X1 U65 ( .A1(operandY[7]), .A2(n29), .ZN(n30) );
  OAI22_X1 U66 ( .A1(n32), .A2(n31), .B1(n73), .B2(n30), .ZN(swap[0]) );
  NOR2_X1 U67 ( .A1(fmt[0]), .A2(fmt[1]), .ZN(n52) );
  AND2_X1 U68 ( .A1(n52), .A2(operandX[15]), .ZN(n51) );
  NAND2_X1 U69 ( .A1(n52), .A2(operandY[15]), .ZN(n50) );
  INV_X1 U70 ( .A(operandY[13]), .ZN(n46) );
  INV_X1 U71 ( .A(operandY[11]), .ZN(n42) );
  INV_X1 U72 ( .A(operandX[8]), .ZN(n33) );
  OAI21_X1 U73 ( .B1(operandY[8]), .B2(n33), .A(swap[0]), .ZN(n35) );
  INV_X1 U74 ( .A(operandY[8]), .ZN(n34) );
  OAI22_X1 U75 ( .A1(n73), .A2(n35), .B1(operandX[8]), .B2(n34), .ZN(n36) );
  NOR2_X1 U76 ( .A1(n36), .A2(operandY[9]), .ZN(n38) );
  NAND2_X1 U77 ( .A1(n36), .A2(operandY[9]), .ZN(n37) );
  OAI21_X1 U78 ( .B1(operandX[9]), .B2(n38), .A(n37), .ZN(n40) );
  INV_X1 U79 ( .A(operandX[10]), .ZN(n39) );
  AOI222_X1 U80 ( .A1(operandY[10]), .A2(n40), .B1(operandY[10]), .B2(n39), 
        .C1(n40), .C2(n39), .ZN(n41) );
  AOI222_X1 U81 ( .A1(operandX[11]), .A2(n42), .B1(operandX[11]), .B2(n41), 
        .C1(n42), .C2(n41), .ZN(n44) );
  INV_X1 U82 ( .A(operandX[12]), .ZN(n43) );
  AOI222_X1 U83 ( .A1(operandY[12]), .A2(n44), .B1(operandY[12]), .B2(n43), 
        .C1(n44), .C2(n43), .ZN(n45) );
  AOI222_X1 U84 ( .A1(operandX[13]), .A2(n46), .B1(operandX[13]), .B2(n45), 
        .C1(n46), .C2(n45), .ZN(n48) );
  INV_X1 U85 ( .A(operandX[14]), .ZN(n47) );
  AOI222_X1 U86 ( .A1(operandY[14]), .A2(n48), .B1(operandY[14]), .B2(n47), 
        .C1(n48), .C2(n47), .ZN(n49) );
  AOI222_X1 U87 ( .A1(n51), .A2(n50), .B1(n51), .B2(n49), .C1(n50), .C2(n49), 
        .ZN(swap[1]) );
  INV_X1 U88 ( .A(operandX[23]), .ZN(n69) );
  NOR3_X1 U89 ( .A1(operandY[23]), .A2(n73), .A3(n69), .ZN(n72) );
  INV_X1 U90 ( .A(operandY[21]), .ZN(n66) );
  INV_X1 U91 ( .A(operandY[19]), .ZN(n62) );
  INV_X1 U92 ( .A(operandY[16]), .ZN(n55) );
  INV_X1 U93 ( .A(operandX[16]), .ZN(n53) );
  OAI211_X1 U94 ( .C1(operandY[16]), .C2(n53), .A(swap[1]), .B(n52), .ZN(n54)
         );
  OAI21_X1 U95 ( .B1(operandX[16]), .B2(n55), .A(n54), .ZN(n56) );
  NOR2_X1 U96 ( .A1(n56), .A2(operandY[17]), .ZN(n58) );
  NAND2_X1 U97 ( .A1(n56), .A2(operandY[17]), .ZN(n57) );
  OAI21_X1 U98 ( .B1(operandX[17]), .B2(n58), .A(n57), .ZN(n60) );
  INV_X1 U99 ( .A(operandX[18]), .ZN(n59) );
  AOI222_X1 U100 ( .A1(operandY[18]), .A2(n60), .B1(operandY[18]), .B2(n59), 
        .C1(n60), .C2(n59), .ZN(n61) );
  AOI222_X1 U101 ( .A1(operandX[19]), .A2(n62), .B1(operandX[19]), .B2(n61), 
        .C1(n62), .C2(n61), .ZN(n64) );
  INV_X1 U102 ( .A(operandX[20]), .ZN(n63) );
  AOI222_X1 U103 ( .A1(operandY[20]), .A2(n64), .B1(operandY[20]), .B2(n63), 
        .C1(n64), .C2(n63), .ZN(n65) );
  AOI222_X1 U104 ( .A1(operandX[21]), .A2(n66), .B1(operandX[21]), .B2(n65), 
        .C1(n66), .C2(n65), .ZN(n68) );
  INV_X1 U105 ( .A(operandX[22]), .ZN(n67) );
  AOI222_X1 U106 ( .A1(operandY[22]), .A2(n68), .B1(operandY[22]), .B2(n67), 
        .C1(n68), .C2(n67), .ZN(n71) );
  NAND2_X1 U107 ( .A1(operandY[23]), .A2(n69), .ZN(n70) );
  OAI22_X1 U108 ( .A1(n72), .A2(n71), .B1(n73), .B2(n70), .ZN(swap[2]) );
  INV_X1 U109 ( .A(operandY[30]), .ZN(n89) );
  INV_X1 U110 ( .A(operandY[28]), .ZN(n85) );
  INV_X1 U111 ( .A(operandY[26]), .ZN(n81) );
  INV_X1 U112 ( .A(n73), .ZN(n74) );
  NAND2_X1 U113 ( .A1(swap[2]), .A2(n74), .ZN(n77) );
  NAND2_X1 U114 ( .A1(operandX[24]), .A2(n77), .ZN(n75) );
  NAND2_X1 U115 ( .A1(operandY[24]), .A2(n75), .ZN(n76) );
  OAI21_X1 U116 ( .B1(operandX[24]), .B2(n77), .A(n76), .ZN(n79) );
  INV_X1 U117 ( .A(operandX[25]), .ZN(n78) );
  AOI222_X1 U118 ( .A1(operandY[25]), .A2(n79), .B1(operandY[25]), .B2(n78), 
        .C1(n79), .C2(n78), .ZN(n80) );
  AOI222_X1 U119 ( .A1(operandX[26]), .A2(n81), .B1(operandX[26]), .B2(n80), 
        .C1(n81), .C2(n80), .ZN(n83) );
  INV_X1 U120 ( .A(operandX[27]), .ZN(n82) );
  AOI222_X1 U121 ( .A1(operandY[27]), .A2(n83), .B1(operandY[27]), .B2(n82), 
        .C1(n83), .C2(n82), .ZN(n84) );
  AOI222_X1 U122 ( .A1(operandX[28]), .A2(n85), .B1(operandX[28]), .B2(n84), 
        .C1(n85), .C2(n84), .ZN(n87) );
  INV_X1 U123 ( .A(operandX[29]), .ZN(n86) );
  AOI222_X1 U124 ( .A1(operandY[29]), .A2(n87), .B1(operandY[29]), .B2(n86), 
        .C1(n87), .C2(n86), .ZN(n88) );
  AOI222_X1 U125 ( .A1(operandX[30]), .A2(n89), .B1(operandX[30]), .B2(n88), 
        .C1(n89), .C2(n88), .ZN(swap[3]) );
endmodule

