/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : U-2022.12
// Date      : Fri Jun 19 16:32:41 2026
/////////////////////////////////////////////////////////////


module BarrelShifter ( fmt, operandX, shiftAmount, result, sticky );
  input [1:0] fmt;
  input [23:0] operandX;
  input [11:0] shiftAmount;
  output [25:0] result;
  output [3:0] sticky;
  wire   n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208,
         n209, n210, n211, n212, n213, n214, n215, n216, n217, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297,
         n298, n299, n300, n301, n302, n303, n304, n305, n306, n307, n308,
         n309, n310, n311, n312, n313, n314, n315, n316, n317, n318, n319,
         n320, n321, n322, n323, n324, n325, n326, n327, n328, n329, n330,
         n331, n332, n333, n334, n335, n336, n337, n338, n339, n340, n341,
         n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352,
         n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, n363,
         n364, n365, n366, n367, n368, n369, n370, n371, n372;

  AOI22_X2 U217 ( .A1(shiftAmount[4]), .A2(n205), .B1(shiftAmount[3]), .B2(
        n195), .ZN(n283) );
  AOI21_X2 U218 ( .B1(n361), .B2(shiftAmount[7]), .A(n202), .ZN(n322) );
  INV_X1 U219 ( .A(fmt[0]), .ZN(n189) );
  CLKBUF_X1 U220 ( .A(n361), .Z(n367) );
  INV_X1 U221 ( .A(n235), .ZN(n361) );
  NAND2_X1 U222 ( .A1(n189), .A2(fmt[1]), .ZN(n235) );
  NOR2_X1 U223 ( .A1(fmt[1]), .A2(fmt[0]), .ZN(n205) );
  NOR2_X1 U224 ( .A1(n189), .A2(fmt[1]), .ZN(n246) );
  AOI22_X1 U225 ( .A1(n205), .A2(shiftAmount[0]), .B1(shiftAmount[4]), .B2(
        n246), .ZN(n187) );
  INV_X1 U226 ( .A(n187), .ZN(n216) );
  AOI21_X1 U227 ( .B1(n367), .B2(shiftAmount[9]), .A(n216), .ZN(n301) );
  INV_X1 U228 ( .A(n301), .ZN(n304) );
  AOI22_X1 U229 ( .A1(n301), .A2(operandX[21]), .B1(operandX[22]), .B2(n304), 
        .ZN(n308) );
  AOI22_X1 U230 ( .A1(n205), .A2(shiftAmount[1]), .B1(n246), .B2(
        shiftAmount[5]), .ZN(n188) );
  INV_X1 U231 ( .A(n188), .ZN(n202) );
  AOI21_X1 U232 ( .B1(n367), .B2(shiftAmount[10]), .A(n202), .ZN(n227) );
  INV_X1 U233 ( .A(fmt[1]), .ZN(n195) );
  OAI211_X1 U234 ( .C1(shiftAmount[4]), .C2(shiftAmount[3]), .A(n189), .B(n195), .ZN(n190) );
  INV_X1 U235 ( .A(n190), .ZN(n191) );
  AOI21_X1 U236 ( .B1(n246), .B2(shiftAmount[7]), .A(n191), .ZN(n241) );
  INV_X1 U237 ( .A(n241), .ZN(n228) );
  AOI22_X1 U238 ( .A1(n205), .A2(shiftAmount[2]), .B1(shiftAmount[6]), .B2(
        n246), .ZN(n192) );
  INV_X1 U239 ( .A(n192), .ZN(n212) );
  AOI211_X1 U240 ( .C1(n367), .C2(shiftAmount[11]), .A(n228), .B(n212), .ZN(
        n231) );
  NAND2_X1 U241 ( .A1(n227), .A2(n231), .ZN(n310) );
  INV_X1 U242 ( .A(n227), .ZN(n296) );
  NAND2_X1 U243 ( .A1(n231), .A2(n296), .ZN(n307) );
  NAND2_X1 U244 ( .A1(operandX[23]), .A2(n301), .ZN(n311) );
  OAI22_X1 U245 ( .A1(n308), .A2(n310), .B1(n307), .B2(n311), .ZN(n226) );
  AND2_X1 U246 ( .A1(n235), .A2(n226), .ZN(result[23]) );
  AOI22_X1 U247 ( .A1(n301), .A2(operandX[22]), .B1(operandX[23]), .B2(n304), 
        .ZN(n309) );
  AOI22_X1 U248 ( .A1(n301), .A2(operandX[20]), .B1(operandX[21]), .B2(n304), 
        .ZN(n193) );
  OAI22_X1 U249 ( .A1(n309), .A2(n307), .B1(n310), .B2(n193), .ZN(n225) );
  AND2_X1 U250 ( .A1(n235), .A2(n225), .ZN(result[22]) );
  NAND2_X1 U251 ( .A1(shiftAmount[0]), .A2(n195), .ZN(n207) );
  INV_X1 U252 ( .A(n207), .ZN(n208) );
  AOI21_X1 U253 ( .B1(shiftAmount[3]), .B2(n367), .A(n208), .ZN(n337) );
  AOI22_X1 U254 ( .A1(n195), .A2(shiftAmount[1]), .B1(shiftAmount[4]), .B2(
        n361), .ZN(n332) );
  AOI22_X1 U255 ( .A1(n195), .A2(shiftAmount[2]), .B1(shiftAmount[5]), .B2(
        n367), .ZN(n197) );
  NAND2_X1 U256 ( .A1(shiftAmount[3]), .A2(n195), .ZN(n194) );
  NOR2_X1 U257 ( .A1(n205), .A2(n194), .ZN(n276) );
  AOI22_X1 U258 ( .A1(operandX[13]), .A2(n276), .B1(n283), .B2(operandX[5]), 
        .ZN(n339) );
  AOI22_X1 U259 ( .A1(operandX[17]), .A2(n276), .B1(n283), .B2(operandX[9]), 
        .ZN(n204) );
  INV_X1 U260 ( .A(n197), .ZN(n286) );
  AOI22_X1 U261 ( .A1(n197), .A2(n339), .B1(n204), .B2(n286), .ZN(n362) );
  AOI22_X1 U262 ( .A1(operandX[15]), .A2(n276), .B1(n283), .B2(operandX[7]), 
        .ZN(n353) );
  INV_X1 U263 ( .A(operandX[11]), .ZN(n196) );
  INV_X1 U264 ( .A(n205), .ZN(n266) );
  NAND2_X1 U265 ( .A1(n266), .A2(n286), .ZN(n200) );
  OR2_X1 U266 ( .A1(n228), .A2(n200), .ZN(n203) );
  OAI22_X1 U267 ( .A1(n353), .A2(n286), .B1(n196), .B2(n203), .ZN(n331) );
  INV_X1 U268 ( .A(n332), .ZN(n329) );
  AOI22_X1 U269 ( .A1(n332), .A2(n362), .B1(n331), .B2(n329), .ZN(n290) );
  AOI22_X1 U270 ( .A1(operandX[14]), .A2(n276), .B1(n283), .B2(operandX[6]), 
        .ZN(n346) );
  NAND2_X1 U271 ( .A1(n283), .A2(operandX[10]), .ZN(n199) );
  AOI22_X1 U272 ( .A1(n197), .A2(n346), .B1(n199), .B2(n286), .ZN(n288) );
  INV_X1 U273 ( .A(operandX[12]), .ZN(n198) );
  AOI22_X1 U274 ( .A1(operandX[16]), .A2(n276), .B1(n283), .B2(operandX[8]), 
        .ZN(n275) );
  OAI22_X1 U275 ( .A1(n198), .A2(n203), .B1(n286), .B2(n275), .ZN(n210) );
  AOI22_X1 U276 ( .A1(n332), .A2(n288), .B1(n210), .B2(n329), .ZN(n333) );
  INV_X1 U277 ( .A(n337), .ZN(n334) );
  AOI22_X1 U278 ( .A1(n337), .A2(n290), .B1(n333), .B2(n334), .ZN(n292) );
  AND2_X1 U279 ( .A1(n292), .A2(n235), .ZN(result[7]) );
  NAND2_X1 U280 ( .A1(n241), .A2(operandX[14]), .ZN(n252) );
  OAI22_X1 U281 ( .A1(n252), .A2(n200), .B1(n286), .B2(n199), .ZN(n209) );
  AOI21_X1 U282 ( .B1(n361), .B2(shiftAmount[8]), .A(n212), .ZN(n255) );
  INV_X1 U283 ( .A(n255), .ZN(n211) );
  OAI221_X1 U284 ( .B1(n255), .B2(operandX[16]), .C1(n211), .C2(operandX[12]), 
        .A(n241), .ZN(n258) );
  OAI21_X1 U285 ( .B1(n258), .B2(n205), .A(n329), .ZN(n201) );
  OAI21_X1 U286 ( .B1(n329), .B2(n209), .A(n201), .ZN(n250) );
  INV_X1 U287 ( .A(n322), .ZN(n317) );
  OAI221_X1 U288 ( .B1(n255), .B2(operandX[15]), .C1(n211), .C2(operandX[11]), 
        .A(n241), .ZN(n238) );
  OAI221_X1 U289 ( .B1(n211), .B2(operandX[13]), .C1(n255), .C2(operandX[17]), 
        .A(n241), .ZN(n259) );
  OAI22_X1 U290 ( .A1(n317), .A2(n238), .B1(n259), .B2(n322), .ZN(n262) );
  NAND3_X1 U291 ( .A1(n266), .A2(n262), .A3(n334), .ZN(n249) );
  AOI221_X1 U292 ( .B1(n250), .B2(n249), .C1(n334), .C2(n249), .A(n361), .ZN(
        result[12]) );
  INV_X1 U293 ( .A(operandX[13]), .ZN(n277) );
  OAI22_X1 U294 ( .A1(n204), .A2(n286), .B1(n277), .B2(n203), .ZN(n330) );
  OAI21_X1 U295 ( .B1(n238), .B2(n205), .A(n329), .ZN(n206) );
  OAI21_X1 U296 ( .B1(n329), .B2(n330), .A(n206), .ZN(n248) );
  AOI221_X1 U297 ( .B1(n208), .B2(n250), .C1(n207), .C2(n248), .A(n367), .ZN(
        result[11]) );
  OAI22_X1 U298 ( .A1(n329), .A2(n210), .B1(n209), .B2(n332), .ZN(n335) );
  OR2_X1 U299 ( .A1(n334), .A2(n335), .ZN(n247) );
  AOI221_X1 U300 ( .B1(n337), .B2(n247), .C1(n248), .C2(n247), .A(n361), .ZN(
        result[10]) );
  NOR2_X1 U302 ( .A1(n228), .A2(n211), .ZN(n251) );
  NOR2_X1 U303 ( .A1(n255), .A2(n235), .ZN(n253) );
  AOI22_X1 U304 ( .A1(operandX[17]), .A2(n251), .B1(n253), .B2(operandX[21]), 
        .ZN(n315) );
  INV_X1 U305 ( .A(n315), .ZN(n215) );
  AOI21_X1 U306 ( .B1(n367), .B2(shiftAmount[11]), .A(n212), .ZN(n213) );
  NOR2_X1 U307 ( .A1(n213), .A2(n228), .ZN(n217) );
  AOI22_X1 U308 ( .A1(operandX[19]), .A2(n231), .B1(n217), .B2(operandX[23]), 
        .ZN(n297) );
  NOR2_X1 U309 ( .A1(n322), .A2(n297), .ZN(n214) );
  AOI22_X1 U310 ( .A1(n215), .A2(n322), .B1(n361), .B2(n214), .ZN(n326) );
  AOI21_X1 U311 ( .B1(n361), .B2(shiftAmount[6]), .A(n216), .ZN(n328) );
  INV_X1 U312 ( .A(n328), .ZN(n325) );
  AOI22_X1 U313 ( .A1(operandX[18]), .A2(n231), .B1(n217), .B2(operandX[22]), 
        .ZN(n320) );
  INV_X1 U314 ( .A(operandX[20]), .ZN(n302) );
  OAI22_X1 U315 ( .A1(n320), .A2(n296), .B1(n302), .B2(n307), .ZN(n234) );
  INV_X1 U316 ( .A(n234), .ZN(n300) );
  OAI33_X1 U317 ( .A1(1'b0), .A2(n326), .A3(n325), .B1(n328), .B2(n300), .B3(
        n235), .ZN(result[19]) );
  NAND2_X1 U318 ( .A1(fmt[1]), .A2(fmt[0]), .ZN(n220) );
  NAND2_X1 U319 ( .A1(n220), .A2(shiftAmount[1]), .ZN(n363) );
  NAND2_X1 U320 ( .A1(n220), .A2(shiftAmount[2]), .ZN(n340) );
  OAI21_X1 U321 ( .B1(n363), .B2(n340), .A(n283), .ZN(n219) );
  INV_X1 U322 ( .A(n283), .ZN(n341) );
  AOI22_X1 U323 ( .A1(operandX[3]), .A2(n219), .B1(operandX[4]), .B2(n341), 
        .ZN(n224) );
  NAND2_X1 U324 ( .A1(n220), .A2(shiftAmount[0]), .ZN(n369) );
  INV_X1 U325 ( .A(n369), .ZN(n372) );
  INV_X1 U326 ( .A(n340), .ZN(n268) );
  OAI221_X1 U327 ( .B1(n268), .B2(operandX[0]), .C1(n340), .C2(operandX[4]), 
        .A(n283), .ZN(n347) );
  NOR2_X1 U328 ( .A1(n347), .A2(n363), .ZN(n342) );
  OAI221_X1 U329 ( .B1(n340), .B2(n369), .C1(n340), .C2(n363), .A(n283), .ZN(
        n221) );
  AOI22_X1 U330 ( .A1(n372), .A2(n342), .B1(operandX[2]), .B2(n221), .ZN(n223)
         );
  NAND2_X1 U331 ( .A1(n340), .A2(n283), .ZN(n350) );
  OAI21_X1 U332 ( .B1(operandX[0]), .B2(operandX[1]), .A(n350), .ZN(n222) );
  NAND3_X1 U333 ( .A1(n224), .A2(n223), .A3(n222), .ZN(sticky[0]) );
  NOR2_X1 U334 ( .A1(n226), .A2(n225), .ZN(n237) );
  AOI21_X1 U335 ( .B1(n297), .B2(n320), .A(n227), .ZN(n233) );
  NOR4_X1 U336 ( .A1(operandX[20]), .A2(operandX[19]), .A3(operandX[18]), .A4(
        operandX[21]), .ZN(n230) );
  OAI21_X1 U337 ( .B1(operandX[23]), .B2(operandX[22]), .A(n228), .ZN(n229) );
  OAI21_X1 U338 ( .B1(n231), .B2(n230), .A(n229), .ZN(n232) );
  AOI211_X1 U339 ( .C1(n304), .C2(n234), .A(n233), .B(n232), .ZN(n236) );
  AOI22_X1 U340 ( .A1(n367), .A2(n237), .B1(n236), .B2(n235), .ZN(sticky[3])
         );
  AOI21_X1 U341 ( .B1(n238), .B2(n258), .A(n322), .ZN(n245) );
  NOR3_X1 U342 ( .A1(operandX[13]), .A2(operandX[11]), .A3(operandX[12]), .ZN(
        n240) );
  NOR4_X1 U343 ( .A1(operandX[17]), .A2(operandX[15]), .A3(operandX[16]), .A4(
        operandX[14]), .ZN(n239) );
  AOI222_X1 U344 ( .A1(n241), .A2(n240), .B1(n241), .B2(n255), .C1(n240), .C2(
        n239), .ZN(n244) );
  INV_X1 U345 ( .A(n262), .ZN(n242) );
  OAI22_X1 U346 ( .A1(n255), .A2(n252), .B1(n328), .B2(n242), .ZN(n243) );
  NOR3_X1 U347 ( .A1(n245), .A2(n244), .A3(n243), .ZN(n267) );
  NOR2_X1 U348 ( .A1(n367), .A2(n246), .ZN(n270) );
  NAND4_X1 U349 ( .A1(n250), .A2(n249), .A3(n248), .A4(n247), .ZN(n264) );
  AOI22_X1 U350 ( .A1(operandX[15]), .A2(n251), .B1(n253), .B2(operandX[19]), 
        .ZN(n316) );
  AOI22_X1 U351 ( .A1(operandX[16]), .A2(n251), .B1(n253), .B2(operandX[20]), 
        .ZN(n313) );
  AOI22_X1 U352 ( .A1(n328), .A2(n316), .B1(n313), .B2(n325), .ZN(n257) );
  INV_X1 U353 ( .A(n252), .ZN(n254) );
  AOI22_X1 U354 ( .A1(n255), .A2(n254), .B1(n253), .B2(operandX[18]), .ZN(n312) );
  OAI221_X1 U355 ( .B1(n328), .B2(n312), .C1(n325), .C2(n259), .A(n322), .ZN(
        n256) );
  OAI21_X1 U356 ( .B1(n322), .B2(n257), .A(n256), .ZN(n273) );
  AOI22_X1 U357 ( .A1(n322), .A2(n258), .B1(n312), .B2(n317), .ZN(n261) );
  AOI22_X1 U358 ( .A1(n322), .A2(n259), .B1(n316), .B2(n317), .ZN(n260) );
  AOI22_X1 U359 ( .A1(n328), .A2(n261), .B1(n260), .B2(n325), .ZN(n272) );
  AOI22_X1 U360 ( .A1(n328), .A2(n262), .B1(n261), .B2(n325), .ZN(n271) );
  NAND3_X1 U361 ( .A1(n273), .A2(n272), .A3(n271), .ZN(n263) );
  AOI21_X1 U362 ( .B1(n361), .B2(n264), .A(n263), .ZN(n265) );
  OAI22_X1 U363 ( .A1(n267), .A2(n266), .B1(n270), .B2(n265), .ZN(sticky[2])
         );
  INV_X1 U364 ( .A(operandX[4]), .ZN(n269) );
  NAND2_X1 U365 ( .A1(n361), .A2(n268), .ZN(n352) );
  OAI22_X1 U366 ( .A1(n269), .A2(n350), .B1(n352), .B2(n275), .ZN(n357) );
  AND2_X1 U367 ( .A1(n363), .A2(n357), .ZN(n366) );
  NAND2_X1 U368 ( .A1(n366), .A2(n369), .ZN(n289) );
  NOR2_X1 U369 ( .A1(n367), .A2(n289), .ZN(result[6]) );
  INV_X1 U370 ( .A(n270), .ZN(n274) );
  NOR2_X1 U371 ( .A1(n274), .A2(n271), .ZN(result[13]) );
  NOR2_X1 U372 ( .A1(n274), .A2(n272), .ZN(result[14]) );
  NOR2_X1 U373 ( .A1(n274), .A2(n273), .ZN(result[15]) );
  INV_X1 U374 ( .A(n275), .ZN(n287) );
  INV_X1 U375 ( .A(n276), .ZN(n279) );
  NOR2_X1 U376 ( .A1(operandX[15]), .A2(operandX[14]), .ZN(n278) );
  NOR3_X1 U377 ( .A1(operandX[7]), .A2(operandX[5]), .A3(operandX[6]), .ZN(
        n280) );
  OAI221_X1 U378 ( .B1(n279), .B2(n278), .C1(n279), .C2(n277), .A(n280), .ZN(
        n285) );
  INV_X1 U379 ( .A(n280), .ZN(n281) );
  NOR4_X1 U380 ( .A1(operandX[10]), .A2(operandX[9]), .A3(operandX[8]), .A4(
        n281), .ZN(n282) );
  OAI22_X1 U381 ( .A1(n337), .A2(n290), .B1(n283), .B2(n282), .ZN(n284) );
  AOI221_X1 U382 ( .B1(n287), .B2(n286), .C1(n285), .C2(n286), .A(n284), .ZN(
        n295) );
  OAI21_X1 U383 ( .B1(n362), .B2(n288), .A(n329), .ZN(n294) );
  INV_X1 U384 ( .A(n363), .ZN(n360) );
  NAND2_X1 U385 ( .A1(n288), .A2(n360), .ZN(n365) );
  OAI221_X1 U386 ( .B1(n372), .B2(n365), .C1(n369), .C2(n290), .A(n289), .ZN(
        n291) );
  OAI21_X1 U387 ( .B1(n292), .B2(n291), .A(n367), .ZN(n293) );
  OAI221_X1 U388 ( .B1(n361), .B2(n295), .C1(n367), .C2(n294), .A(n293), .ZN(
        sticky[1]) );
  INV_X1 U389 ( .A(n307), .ZN(n298) );
  NOR2_X1 U390 ( .A1(n297), .A2(n296), .ZN(n305) );
  AOI21_X1 U391 ( .B1(n298), .B2(operandX[21]), .A(n305), .ZN(n299) );
  AOI22_X1 U392 ( .A1(n301), .A2(n300), .B1(n299), .B2(n304), .ZN(result[20])
         );
  OAI21_X1 U393 ( .B1(n302), .B2(n310), .A(n304), .ZN(n303) );
  OAI21_X1 U394 ( .B1(n305), .B2(n304), .A(n303), .ZN(n306) );
  OAI21_X1 U395 ( .B1(n308), .B2(n307), .A(n306), .ZN(result[21]) );
  NOR2_X1 U396 ( .A1(n309), .A2(n310), .ZN(result[24]) );
  NOR2_X1 U397 ( .A1(n311), .A2(n310), .ZN(result[25]) );
  INV_X1 U398 ( .A(n312), .ZN(n314) );
  INV_X1 U399 ( .A(n313), .ZN(n323) );
  AOI22_X1 U400 ( .A1(n322), .A2(n314), .B1(n323), .B2(n317), .ZN(n319) );
  OAI22_X1 U401 ( .A1(n317), .A2(n316), .B1(n315), .B2(n322), .ZN(n318) );
  INV_X1 U402 ( .A(n318), .ZN(n324) );
  AOI22_X1 U403 ( .A1(n328), .A2(n319), .B1(n324), .B2(n325), .ZN(result[16])
         );
  NOR2_X1 U404 ( .A1(n322), .A2(n320), .ZN(n321) );
  AOI22_X1 U405 ( .A1(n323), .A2(n322), .B1(n361), .B2(n321), .ZN(n327) );
  AOI22_X1 U406 ( .A1(n328), .A2(n324), .B1(n327), .B2(n325), .ZN(result[17])
         );
  AOI22_X1 U407 ( .A1(n328), .A2(n327), .B1(n326), .B2(n325), .ZN(result[18])
         );
  AOI22_X1 U408 ( .A1(n332), .A2(n331), .B1(n330), .B2(n329), .ZN(n336) );
  AOI22_X1 U409 ( .A1(n337), .A2(n333), .B1(n336), .B2(n334), .ZN(result[8])
         );
  AOI22_X1 U410 ( .A1(n337), .A2(n336), .B1(n335), .B2(n334), .ZN(result[9])
         );
  INV_X1 U411 ( .A(operandX[1]), .ZN(n338) );
  OAI22_X1 U412 ( .A1(n339), .A2(n352), .B1(n338), .B2(n350), .ZN(n354) );
  NOR3_X1 U413 ( .A1(n360), .A2(n341), .A3(n340), .ZN(n343) );
  AOI22_X1 U414 ( .A1(n360), .A2(n354), .B1(operandX[3]), .B2(n343), .ZN(n349)
         );
  AOI21_X1 U415 ( .B1(n343), .B2(operandX[2]), .A(n342), .ZN(n344) );
  AOI22_X1 U416 ( .A1(n372), .A2(n349), .B1(n344), .B2(n369), .ZN(result[0])
         );
  INV_X1 U417 ( .A(operandX[2]), .ZN(n345) );
  OAI22_X1 U418 ( .A1(n346), .A2(n352), .B1(n345), .B2(n350), .ZN(n356) );
  INV_X1 U419 ( .A(n347), .ZN(n348) );
  AOI22_X1 U420 ( .A1(n360), .A2(n356), .B1(n348), .B2(n363), .ZN(n355) );
  AOI22_X1 U421 ( .A1(n372), .A2(n355), .B1(n349), .B2(n369), .ZN(result[1])
         );
  INV_X1 U422 ( .A(operandX[3]), .ZN(n351) );
  OAI22_X1 U423 ( .A1(n353), .A2(n352), .B1(n351), .B2(n350), .ZN(n359) );
  AOI22_X1 U424 ( .A1(n360), .A2(n359), .B1(n354), .B2(n363), .ZN(n358) );
  AOI22_X1 U425 ( .A1(n372), .A2(n358), .B1(n355), .B2(n369), .ZN(result[2])
         );
  AOI22_X1 U426 ( .A1(n360), .A2(n357), .B1(n356), .B2(n363), .ZN(n364) );
  AOI22_X1 U427 ( .A1(n372), .A2(n364), .B1(n358), .B2(n369), .ZN(result[3])
         );
  OAI222_X1 U428 ( .A1(n363), .A2(n362), .B1(n363), .B2(n361), .C1(n360), .C2(
        n359), .ZN(n370) );
  AOI22_X1 U429 ( .A1(n372), .A2(n370), .B1(n364), .B2(n369), .ZN(result[4])
         );
  INV_X1 U430 ( .A(n365), .ZN(n368) );
  AOI21_X1 U431 ( .B1(n368), .B2(n367), .A(n366), .ZN(n371) );
  AOI22_X1 U432 ( .A1(n372), .A2(n371), .B1(n370), .B2(n369), .ZN(result[5])
         );
endmodule

