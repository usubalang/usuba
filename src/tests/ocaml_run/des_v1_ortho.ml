let id x = x

let convert_ortho (size: int) (input: int64 array) : int array =
  let out = Array.make size 0 in
  for i = 0 to Array.length input - 1 do
    for j = 0 to size-1 do
      let b = Int64.to_int (Int64.logand (Int64.shift_right input.(i) j) Int64.one) in
      out.(j) <- out.(j) lor (b lsl i)
    done
  done;
  out
 

let convert_unortho (input: int array) : int64 array =
  let out = Array.make 63 Int64.zero in
  for i = 0 to Array.length input - 1 do
    for j = 0 to 62 do
      let b = Int64.of_int (input.(i) lsr j land 1) in
      out.(j) <- Int64.logor out.(j) (Int64.shift_left b i)
    done
  done;
  out


let convert4 ((in11,in12,in13,in14,in15,in16)) = 
    let out11 = in11 in 
    let out21 = in12 in 
    let out31 = in13 in 
    let out41 = in14 in 
    let out51 = in15 in 
    let out61 = in16 in 
    ((out11),(out21),(out31),(out41),(out51),(out61))



let convert5 ((in11,in12,in13,in14),(in21,in22,in23,in24),(in31,in32,in33,in34),(in41,in42,in43,in44),(in51,in52,in53,in54),(in61,in62,in63,in64),(in71,in72,in73,in74),(in81,in82,in83,in84)) = 
    let out11 = in11 in 
    let out12 = in12 in 
    let out13 = in13 in 
    let out14 = in14 in 
    let out15 = in21 in 
    let out16 = in22 in 
    let out17 = in23 in 
    let out18 = in24 in 
    let out19 = in31 in 
    let out110 = in32 in 
    let out111 = in33 in 
    let out112 = in34 in 
    let out113 = in41 in 
    let out114 = in42 in 
    let out115 = in43 in 
    let out116 = in44 in 
    let out117 = in51 in 
    let out118 = in52 in 
    let out119 = in53 in 
    let out120 = in54 in 
    let out121 = in61 in 
    let out122 = in62 in 
    let out123 = in63 in 
    let out124 = in64 in 
    let out125 = in71 in 
    let out126 = in72 in 
    let out127 = in73 in 
    let out128 = in74 in 
    let out129 = in81 in 
    let out130 = in82 in 
    let out131 = in83 in 
    let out132 = in84 in 
    ((out11,out12,out13,out14,out15,out16,out17,out18,out19,out110,out111,out112,out113,out114,out115,out116,out117,out118,out119,out120,out121,out122,out123,out124,out125,out126,out127,out128,out129,out130,out131,out132))



let convert6 ((in11,in12,in13,in14,in15,in16,in17,in18,in19,in110,in111,in112,in113,in114,in115,in116,in117,in118,in119,in120,in121,in122,in123,in124,in125,in126,in127,in128,in129,in130,in131,in132),(in21,in22,in23,in24,in25,in26,in27,in28,in29,in210,in211,in212,in213,in214,in215,in216,in217,in218,in219,in220,in221,in222,in223,in224,in225,in226,in227,in228,in229,in230,in231,in232)) = 
    let out11 = in11 in 
    let out12 = in12 in 
    let out13 = in13 in 
    let out14 = in14 in 
    let out15 = in15 in 
    let out16 = in16 in 
    let out17 = in17 in 
    let out18 = in18 in 
    let out19 = in19 in 
    let out110 = in110 in 
    let out111 = in111 in 
    let out112 = in112 in 
    let out113 = in113 in 
    let out114 = in114 in 
    let out115 = in115 in 
    let out116 = in116 in 
    let out117 = in117 in 
    let out118 = in118 in 
    let out119 = in119 in 
    let out120 = in120 in 
    let out121 = in121 in 
    let out122 = in122 in 
    let out123 = in123 in 
    let out124 = in124 in 
    let out125 = in125 in 
    let out126 = in126 in 
    let out127 = in127 in 
    let out128 = in128 in 
    let out129 = in129 in 
    let out130 = in130 in 
    let out131 = in131 in 
    let out132 = in132 in 
    let out133 = in21 in 
    let out134 = in22 in 
    let out135 = in23 in 
    let out136 = in24 in 
    let out137 = in25 in 
    let out138 = in26 in 
    let out139 = in27 in 
    let out140 = in28 in 
    let out141 = in29 in 
    let out142 = in210 in 
    let out143 = in211 in 
    let out144 = in212 in 
    let out145 = in213 in 
    let out146 = in214 in 
    let out147 = in215 in 
    let out148 = in216 in 
    let out149 = in217 in 
    let out150 = in218 in 
    let out151 = in219 in 
    let out152 = in220 in 
    let out153 = in221 in 
    let out154 = in222 in 
    let out155 = in223 in 
    let out156 = in224 in 
    let out157 = in225 in 
    let out158 = in226 in 
    let out159 = in227 in 
    let out160 = in228 in 
    let out161 = in229 in 
    let out162 = in230 in 
    let out163 = in231 in 
    let out164 = in232 in 
    ((out11,out12,out13,out14,out15,out16,out17,out18,out19,out110,out111,out112,out113,out114,out115,out116,out117,out118,out119,out120,out121,out122,out123,out124,out125,out126,out127,out128,out129,out130,out131,out132,out133,out134,out135,out136,out137,out138,out139,out140,out141,out142,out143,out144,out145,out146,out147,out148,out149,out150,out151,out152,out153,out154,out155,out156,out157,out158,out159,out160,out161,out162,out163,out164))



let sbox_1_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a4_)) in 
    let x2_ = (lnot (a1_)) in 
    let x3_ = ((a4_) land ((lnot (a3_)))) lor (((lnot (a4_))) land (a3_)) in 
    let x4_ = ((x3_) land ((lnot (x2_)))) lor (((lnot (x3_))) land (x2_)) in 
    let x5_ = (a3_) lor (x2_) in 
    let x6_ = (x5_) land (x1_) in 
    let x7_ = (a6_) lor (x6_) in 
    let x8_ = ((x4_) land ((lnot (x7_)))) lor (((lnot (x4_))) land (x7_)) in 
    let x9_ = (x1_) lor (x2_) in 
    let x10_ = (a6_) land (x9_) in 
    let x11_ = ((x7_) land ((lnot (x10_)))) lor (((lnot (x7_))) land (x10_)) in 
    let x12_ = (a2_) lor (x11_) in 
    let x13_ = ((x8_) land ((lnot (x12_)))) lor (((lnot (x8_))) land (x12_)) in 
    let x14_ = ((x9_) land ((lnot (x13_)))) lor (((lnot (x9_))) land (x13_)) in 
    let x15_ = (a6_) lor (x14_) in 
    let x16_ = ((x1_) land ((lnot (x15_)))) lor (((lnot (x1_))) land (x15_)) in 
    let x17_ = (lnot (x14_)) in 
    let x18_ = (x17_) land (x3_) in 
    let x19_ = (a2_) lor (x18_) in 
    let x20_ = ((x16_) land ((lnot (x19_)))) lor (((lnot (x16_))) land (x19_)) in 
    let x21_ = (a5_) lor (x20_) in 
    let x22_ = ((x13_) land ((lnot (x21_)))) lor (((lnot (x13_))) land (x21_)) in 
    let out4_ = x22_ in 
    let x23_ = (a3_) lor (x4_) in 
    let x24_ = (lnot (x23_)) in 
    let x25_ = (a6_) lor (x24_) in 
    let x26_ = ((x6_) land ((lnot (x25_)))) lor (((lnot (x6_))) land (x25_)) in 
    let x27_ = (x1_) land (x8_) in 
    let x28_ = (a2_) lor (x27_) in 
    let x29_ = ((x26_) land ((lnot (x28_)))) lor (((lnot (x26_))) land (x28_)) in 
    let x30_ = (x1_) lor (x8_) in 
    let x31_ = ((x30_) land ((lnot (x6_)))) lor (((lnot (x30_))) land (x6_)) in 
    let x32_ = (x5_) land (x14_) in 
    let x33_ = ((x32_) land ((lnot (x8_)))) lor (((lnot (x32_))) land (x8_)) in 
    let x34_ = (a2_) land (x33_) in 
    let x35_ = ((x31_) land ((lnot (x34_)))) lor (((lnot (x31_))) land (x34_)) in 
    let x36_ = (a5_) lor (x35_) in 
    let x37_ = ((x29_) land ((lnot (x36_)))) lor (((lnot (x29_))) land (x36_)) in 
    let out1_ = x37_ in 
    let x38_ = (a3_) land (x10_) in 
    let x39_ = (x38_) lor (x4_) in 
    let x40_ = (a3_) land (x33_) in 
    let x41_ = ((x40_) land ((lnot (x25_)))) lor (((lnot (x40_))) land (x25_)) in 
    let x42_ = (a2_) lor (x41_) in 
    let x43_ = ((x39_) land ((lnot (x42_)))) lor (((lnot (x39_))) land (x42_)) in 
    let x44_ = (a3_) lor (x26_) in 
    let x45_ = ((x44_) land ((lnot (x14_)))) lor (((lnot (x44_))) land (x14_)) in 
    let x46_ = (a1_) lor (x8_) in 
    let x47_ = ((x46_) land ((lnot (x20_)))) lor (((lnot (x46_))) land (x20_)) in 
    let x48_ = (a2_) lor (x47_) in 
    let x49_ = ((x45_) land ((lnot (x48_)))) lor (((lnot (x45_))) land (x48_)) in 
    let x50_ = (a5_) land (x49_) in 
    let x51_ = ((x43_) land ((lnot (x50_)))) lor (((lnot (x43_))) land (x50_)) in 
    let out2_ = x51_ in 
    let x52_ = ((x8_) land ((lnot (x40_)))) lor (((lnot (x8_))) land (x40_)) in 
    let x53_ = ((a3_) land ((lnot (x11_)))) lor (((lnot (a3_))) land (x11_)) in 
    let x54_ = (x53_) land (x5_) in 
    let x55_ = (a2_) lor (x54_) in 
    let x56_ = ((x52_) land ((lnot (x55_)))) lor (((lnot (x52_))) land (x55_)) in 
    let x57_ = (a6_) lor (x4_) in 
    let x58_ = ((x57_) land ((lnot (x38_)))) lor (((lnot (x57_))) land (x38_)) in 
    let x59_ = (x13_) land (x56_) in 
    let x60_ = (a2_) land (x59_) in 
    let x61_ = ((x58_) land ((lnot (x60_)))) lor (((lnot (x58_))) land (x60_)) in 
    let x62_ = (a5_) land (x61_) in 
    let x63_ = ((x56_) land ((lnot (x62_)))) lor (((lnot (x56_))) land (x62_)) in 
    let out3_ = x63_ in 
    (out1_,out2_,out3_,out4_)



let sbox_2_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a5_)) in 
    let x2_ = (lnot (a1_)) in 
    let x3_ = ((a5_) land ((lnot (a6_)))) lor (((lnot (a5_))) land (a6_)) in 
    let x4_ = ((x3_) land ((lnot (x2_)))) lor (((lnot (x3_))) land (x2_)) in 
    let x5_ = ((x4_) land ((lnot (a2_)))) lor (((lnot (x4_))) land (a2_)) in 
    let x6_ = (a6_) lor (x1_) in 
    let x7_ = (x6_) lor (x2_) in 
    let x8_ = (a2_) land (x7_) in 
    let x9_ = ((a6_) land ((lnot (x8_)))) lor (((lnot (a6_))) land (x8_)) in 
    let x10_ = (a3_) land (x9_) in 
    let x11_ = ((x5_) land ((lnot (x10_)))) lor (((lnot (x5_))) land (x10_)) in 
    let x12_ = (a2_) land (x9_) in 
    let x13_ = ((a5_) land ((lnot (x6_)))) lor (((lnot (a5_))) land (x6_)) in 
    let x14_ = (a3_) lor (x13_) in 
    let x15_ = ((x12_) land ((lnot (x14_)))) lor (((lnot (x12_))) land (x14_)) in 
    let x16_ = (a4_) land (x15_) in 
    let x17_ = ((x11_) land ((lnot (x16_)))) lor (((lnot (x11_))) land (x16_)) in 
    let out2_ = x17_ in 
    let x18_ = (a5_) lor (a1_) in 
    let x19_ = (a6_) lor (x18_) in 
    let x20_ = ((x13_) land ((lnot (x19_)))) lor (((lnot (x13_))) land (x19_)) in 
    let x21_ = ((x20_) land ((lnot (a2_)))) lor (((lnot (x20_))) land (a2_)) in 
    let x22_ = (a6_) lor (x4_) in 
    let x23_ = (x22_) land (x17_) in 
    let x24_ = (a3_) lor (x23_) in 
    let x25_ = ((x21_) land ((lnot (x24_)))) lor (((lnot (x21_))) land (x24_)) in 
    let x26_ = (a6_) lor (x2_) in 
    let x27_ = (a5_) land (x2_) in 
    let x28_ = (a2_) lor (x27_) in 
    let x29_ = ((x26_) land ((lnot (x28_)))) lor (((lnot (x26_))) land (x28_)) in 
    let x30_ = ((x3_) land ((lnot (x27_)))) lor (((lnot (x3_))) land (x27_)) in 
    let x31_ = ((x2_) land ((lnot (x19_)))) lor (((lnot (x2_))) land (x19_)) in 
    let x32_ = (a2_) land (x31_) in 
    let x33_ = ((x30_) land ((lnot (x32_)))) lor (((lnot (x30_))) land (x32_)) in 
    let x34_ = (a3_) land (x33_) in 
    let x35_ = ((x29_) land ((lnot (x34_)))) lor (((lnot (x29_))) land (x34_)) in 
    let x36_ = (a4_) lor (x35_) in 
    let x37_ = ((x25_) land ((lnot (x36_)))) lor (((lnot (x25_))) land (x36_)) in 
    let out3_ = x37_ in 
    let x38_ = (x21_) land (x32_) in 
    let x39_ = ((x38_) land ((lnot (x5_)))) lor (((lnot (x38_))) land (x5_)) in 
    let x40_ = (a1_) lor (x15_) in 
    let x41_ = ((x40_) land ((lnot (x13_)))) lor (((lnot (x40_))) land (x13_)) in 
    let x42_ = (a3_) lor (x41_) in 
    let x43_ = ((x39_) land ((lnot (x42_)))) lor (((lnot (x39_))) land (x42_)) in 
    let x44_ = (x28_) lor (x41_) in 
    let x45_ = (a4_) land (x44_) in 
    let x46_ = ((x43_) land ((lnot (x45_)))) lor (((lnot (x43_))) land (x45_)) in 
    let out1_ = x46_ in 
    let x47_ = (x19_) land (x21_) in 
    let x48_ = ((x47_) land ((lnot (x26_)))) lor (((lnot (x47_))) land (x26_)) in 
    let x49_ = (a2_) land (x33_) in 
    let x50_ = ((x49_) land ((lnot (x21_)))) lor (((lnot (x49_))) land (x21_)) in 
    let x51_ = (a3_) land (x50_) in 
    let x52_ = ((x48_) land ((lnot (x51_)))) lor (((lnot (x48_))) land (x51_)) in 
    let x53_ = (x18_) land (x28_) in 
    let x54_ = (x53_) land (x50_) in 
    let x55_ = (a4_) lor (x54_) in 
    let x56_ = ((x52_) land ((lnot (x55_)))) lor (((lnot (x52_))) land (x55_)) in 
    let out4_ = x56_ in 
    (out1_,out2_,out3_,out4_)



let sbox_3_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a5_)) in 
    let x2_ = (lnot (a6_)) in 
    let x3_ = (a5_) land (a3_) in 
    let x4_ = ((x3_) land ((lnot (a6_)))) lor (((lnot (x3_))) land (a6_)) in 
    let x5_ = (a4_) land (x1_) in 
    let x6_ = ((x4_) land ((lnot (x5_)))) lor (((lnot (x4_))) land (x5_)) in 
    let x7_ = ((x6_) land ((lnot (a2_)))) lor (((lnot (x6_))) land (a2_)) in 
    let x8_ = (a3_) land (x1_) in 
    let x9_ = ((a5_) land ((lnot (x2_)))) lor (((lnot (a5_))) land (x2_)) in 
    let x10_ = (a4_) lor (x9_) in 
    let x11_ = ((x8_) land ((lnot (x10_)))) lor (((lnot (x8_))) land (x10_)) in 
    let x12_ = (x7_) land (x11_) in 
    let x13_ = ((a5_) land ((lnot (x11_)))) lor (((lnot (a5_))) land (x11_)) in 
    let x14_ = (x13_) lor (x7_) in 
    let x15_ = (a4_) land (x14_) in 
    let x16_ = ((x12_) land ((lnot (x15_)))) lor (((lnot (x12_))) land (x15_)) in 
    let x17_ = (a2_) land (x16_) in 
    let x18_ = ((x11_) land ((lnot (x17_)))) lor (((lnot (x11_))) land (x17_)) in 
    let x19_ = (a1_) land (x18_) in 
    let x20_ = ((x7_) land ((lnot (x19_)))) lor (((lnot (x7_))) land (x19_)) in 
    let out4_ = x20_ in 
    let x21_ = ((a3_) land ((lnot (a4_)))) lor (((lnot (a3_))) land (a4_)) in 
    let x22_ = ((x21_) land ((lnot (x9_)))) lor (((lnot (x21_))) land (x9_)) in 
    let x23_ = (x2_) lor (x4_) in 
    let x24_ = ((x23_) land ((lnot (x8_)))) lor (((lnot (x23_))) land (x8_)) in 
    let x25_ = (a2_) lor (x24_) in 
    let x26_ = ((x22_) land ((lnot (x25_)))) lor (((lnot (x22_))) land (x25_)) in 
    let x27_ = ((a6_) land ((lnot (x23_)))) lor (((lnot (a6_))) land (x23_)) in 
    let x28_ = (x27_) lor (a4_) in 
    let x29_ = ((a3_) land ((lnot (x15_)))) lor (((lnot (a3_))) land (x15_)) in 
    let x30_ = (x29_) lor (x5_) in 
    let x31_ = (a2_) lor (x30_) in 
    let x32_ = ((x28_) land ((lnot (x31_)))) lor (((lnot (x28_))) land (x31_)) in 
    let x33_ = (a1_) lor (x32_) in 
    let x34_ = ((x26_) land ((lnot (x33_)))) lor (((lnot (x26_))) land (x33_)) in 
    let out1_ = x34_ in 
    let x35_ = ((a3_) land ((lnot (x9_)))) lor (((lnot (a3_))) land (x9_)) in 
    let x36_ = (x35_) lor (x5_) in 
    let x37_ = (x4_) lor (x29_) in 
    let x38_ = ((x37_) land ((lnot (a4_)))) lor (((lnot (x37_))) land (a4_)) in 
    let x39_ = (a2_) lor (x38_) in 
    let x40_ = ((x36_) land ((lnot (x39_)))) lor (((lnot (x36_))) land (x39_)) in 
    let x41_ = (a6_) land (x11_) in 
    let x42_ = (x41_) lor (x6_) in 
    let x43_ = ((x34_) land ((lnot (x38_)))) lor (((lnot (x34_))) land (x38_)) in 
    let x44_ = ((x43_) land ((lnot (x41_)))) lor (((lnot (x43_))) land (x41_)) in 
    let x45_ = (a2_) land (x44_) in 
    let x46_ = ((x42_) land ((lnot (x45_)))) lor (((lnot (x42_))) land (x45_)) in 
    let x47_ = (a1_) lor (x46_) in 
    let x48_ = ((x40_) land ((lnot (x47_)))) lor (((lnot (x40_))) land (x47_)) in 
    let out3_ = x48_ in 
    let x49_ = (x2_) lor (x38_) in 
    let x50_ = ((x49_) land ((lnot (x13_)))) lor (((lnot (x49_))) land (x13_)) in 
    let x51_ = ((x27_) land ((lnot (x28_)))) lor (((lnot (x27_))) land (x28_)) in 
    let x52_ = (a2_) lor (x51_) in 
    let x53_ = ((x50_) land ((lnot (x52_)))) lor (((lnot (x50_))) land (x52_)) in 
    let x54_ = (x12_) land (x23_) in 
    let x55_ = (x54_) land (x52_) in 
    let x56_ = (a1_) lor (x55_) in 
    let x57_ = ((x53_) land ((lnot (x56_)))) lor (((lnot (x53_))) land (x56_)) in 
    let out2_ = x57_ in 
    (out1_,out2_,out3_,out4_)



let sbox_4_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a1_)) in 
    let x2_ = (lnot (a3_)) in 
    let x3_ = (a1_) lor (a3_) in 
    let x4_ = (a5_) land (x3_) in 
    let x5_ = ((x1_) land ((lnot (x4_)))) lor (((lnot (x1_))) land (x4_)) in 
    let x6_ = (a2_) lor (a3_) in 
    let x7_ = ((x5_) land ((lnot (x6_)))) lor (((lnot (x5_))) land (x6_)) in 
    let x8_ = (a1_) land (a5_) in 
    let x9_ = ((x8_) land ((lnot (x3_)))) lor (((lnot (x8_))) land (x3_)) in 
    let x10_ = (a2_) land (x9_) in 
    let x11_ = ((a5_) land ((lnot (x10_)))) lor (((lnot (a5_))) land (x10_)) in 
    let x12_ = (a4_) land (x11_) in 
    let x13_ = ((x7_) land ((lnot (x12_)))) lor (((lnot (x7_))) land (x12_)) in 
    let x14_ = ((x2_) land ((lnot (x4_)))) lor (((lnot (x2_))) land (x4_)) in 
    let x15_ = (a2_) land (x14_) in 
    let x16_ = ((x9_) land ((lnot (x15_)))) lor (((lnot (x9_))) land (x15_)) in 
    let x17_ = (x5_) land (x14_) in 
    let x18_ = ((a5_) land ((lnot (x2_)))) lor (((lnot (a5_))) land (x2_)) in 
    let x19_ = (a2_) lor (x18_) in 
    let x20_ = ((x17_) land ((lnot (x19_)))) lor (((lnot (x17_))) land (x19_)) in 
    let x21_ = (a4_) lor (x20_) in 
    let x22_ = ((x16_) land ((lnot (x21_)))) lor (((lnot (x16_))) land (x21_)) in 
    let x23_ = (a6_) land (x22_) in 
    let x24_ = ((x13_) land ((lnot (x23_)))) lor (((lnot (x13_))) land (x23_)) in 
    let out2_ = x24_ in 
    let x25_ = (lnot (x13_)) in 
    let x26_ = (a6_) lor (x22_) in 
    let x27_ = ((x25_) land ((lnot (x26_)))) lor (((lnot (x25_))) land (x26_)) in 
    let out1_ = x27_ in 
    let x28_ = (a2_) land (x11_) in 
    let x29_ = ((x28_) land ((lnot (x17_)))) lor (((lnot (x28_))) land (x17_)) in 
    let x30_ = ((a3_) land ((lnot (x10_)))) lor (((lnot (a3_))) land (x10_)) in 
    let x31_ = ((x30_) land ((lnot (x19_)))) lor (((lnot (x30_))) land (x19_)) in 
    let x32_ = (a4_) land (x31_) in 
    let x33_ = ((x29_) land ((lnot (x32_)))) lor (((lnot (x29_))) land (x32_)) in 
    let x34_ = ((x25_) land ((lnot (x33_)))) lor (((lnot (x25_))) land (x33_)) in 
    let x35_ = (a2_) land (x34_) in 
    let x36_ = ((x24_) land ((lnot (x35_)))) lor (((lnot (x24_))) land (x35_)) in 
    let x37_ = (a4_) lor (x34_) in 
    let x38_ = ((x36_) land ((lnot (x37_)))) lor (((lnot (x36_))) land (x37_)) in 
    let x39_ = (a6_) land (x38_) in 
    let x40_ = ((x33_) land ((lnot (x39_)))) lor (((lnot (x33_))) land (x39_)) in 
    let out4_ = x40_ in 
    let x41_ = ((x26_) land ((lnot (x38_)))) lor (((lnot (x26_))) land (x38_)) in 
    let x42_ = ((x41_) land ((lnot (x40_)))) lor (((lnot (x41_))) land (x40_)) in 
    let out3_ = x42_ in 
    (out1_,out2_,out3_,out4_)



let sbox_5_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a6_)) in 
    let x2_ = (lnot (a3_)) in 
    let x3_ = (x1_) lor (x2_) in 
    let x4_ = ((x3_) land ((lnot (a4_)))) lor (((lnot (x3_))) land (a4_)) in 
    let x5_ = (a1_) land (x3_) in 
    let x6_ = ((x4_) land ((lnot (x5_)))) lor (((lnot (x4_))) land (x5_)) in 
    let x7_ = (a6_) lor (a4_) in 
    let x8_ = ((x7_) land ((lnot (a3_)))) lor (((lnot (x7_))) land (a3_)) in 
    let x9_ = (a3_) lor (x7_) in 
    let x10_ = (a1_) lor (x9_) in 
    let x11_ = ((x8_) land ((lnot (x10_)))) lor (((lnot (x8_))) land (x10_)) in 
    let x12_ = (a5_) land (x11_) in 
    let x13_ = ((x6_) land ((lnot (x12_)))) lor (((lnot (x6_))) land (x12_)) in 
    let x14_ = (lnot (x4_)) in 
    let x15_ = (x14_) land (a6_) in 
    let x16_ = (a1_) lor (x15_) in 
    let x17_ = ((x8_) land ((lnot (x16_)))) lor (((lnot (x8_))) land (x16_)) in 
    let x18_ = (a5_) lor (x17_) in 
    let x19_ = ((x10_) land ((lnot (x18_)))) lor (((lnot (x10_))) land (x18_)) in 
    let x20_ = (a2_) lor (x19_) in 
    let x21_ = ((x13_) land ((lnot (x20_)))) lor (((lnot (x13_))) land (x20_)) in 
    let out3_ = x21_ in 
    let x22_ = (x2_) lor (x15_) in 
    let x23_ = ((x22_) land ((lnot (a6_)))) lor (((lnot (x22_))) land (a6_)) in 
    let x24_ = ((a4_) land ((lnot (x22_)))) lor (((lnot (a4_))) land (x22_)) in 
    let x25_ = (a1_) land (x24_) in 
    let x26_ = ((x23_) land ((lnot (x25_)))) lor (((lnot (x23_))) land (x25_)) in 
    let x27_ = ((a1_) land ((lnot (x11_)))) lor (((lnot (a1_))) land (x11_)) in 
    let x28_ = (x27_) land (x22_) in 
    let x29_ = (a5_) lor (x28_) in 
    let x30_ = ((x26_) land ((lnot (x29_)))) lor (((lnot (x26_))) land (x29_)) in 
    let x31_ = (a4_) lor (x27_) in 
    let x32_ = (lnot (x31_)) in 
    let x33_ = (a2_) lor (x32_) in 
    let x34_ = ((x30_) land ((lnot (x33_)))) lor (((lnot (x30_))) land (x33_)) in 
    let out2_ = x34_ in 
    let x35_ = ((x2_) land ((lnot (x15_)))) lor (((lnot (x2_))) land (x15_)) in 
    let x36_ = (a1_) land (x35_) in 
    let x37_ = ((x14_) land ((lnot (x36_)))) lor (((lnot (x14_))) land (x36_)) in 
    let x38_ = ((x5_) land ((lnot (x7_)))) lor (((lnot (x5_))) land (x7_)) in 
    let x39_ = (x38_) land (x34_) in 
    let x40_ = (a5_) lor (x39_) in 
    let x41_ = ((x37_) land ((lnot (x40_)))) lor (((lnot (x37_))) land (x40_)) in 
    let x42_ = ((x2_) land ((lnot (x5_)))) lor (((lnot (x2_))) land (x5_)) in 
    let x43_ = (x42_) land (x16_) in 
    let x44_ = (x4_) land (x27_) in 
    let x45_ = (a5_) land (x44_) in 
    let x46_ = ((x43_) land ((lnot (x45_)))) lor (((lnot (x43_))) land (x45_)) in 
    let x47_ = (a2_) lor (x46_) in 
    let x48_ = ((x41_) land ((lnot (x47_)))) lor (((lnot (x41_))) land (x47_)) in 
    let out1_ = x48_ in 
    let x49_ = (x24_) land (x48_) in 
    let x50_ = ((x49_) land ((lnot (x5_)))) lor (((lnot (x49_))) land (x5_)) in 
    let x51_ = ((x11_) land ((lnot (x30_)))) lor (((lnot (x11_))) land (x30_)) in 
    let x52_ = (x51_) lor (x50_) in 
    let x53_ = (a5_) land (x52_) in 
    let x54_ = ((x50_) land ((lnot (x53_)))) lor (((lnot (x50_))) land (x53_)) in 
    let x55_ = ((x14_) land ((lnot (x19_)))) lor (((lnot (x14_))) land (x19_)) in 
    let x56_ = ((x55_) land ((lnot (x34_)))) lor (((lnot (x55_))) land (x34_)) in 
    let x57_ = ((x4_) land ((lnot (x16_)))) lor (((lnot (x4_))) land (x16_)) in 
    let x58_ = (x57_) land (x30_) in 
    let x59_ = (a5_) land (x58_) in 
    let x60_ = ((x56_) land ((lnot (x59_)))) lor (((lnot (x56_))) land (x59_)) in 
    let x61_ = (a2_) lor (x60_) in 
    let x62_ = ((x54_) land ((lnot (x61_)))) lor (((lnot (x54_))) land (x61_)) in 
    let out4_ = x62_ in 
    (out1_,out2_,out3_,out4_)



let sbox_6_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a2_)) in 
    let x2_ = (lnot (a5_)) in 
    let x3_ = ((a2_) land ((lnot (a6_)))) lor (((lnot (a2_))) land (a6_)) in 
    let x4_ = ((x3_) land ((lnot (x2_)))) lor (((lnot (x3_))) land (x2_)) in 
    let x5_ = ((x4_) land ((lnot (a1_)))) lor (((lnot (x4_))) land (a1_)) in 
    let x6_ = (a5_) land (a6_) in 
    let x7_ = (x6_) lor (x1_) in 
    let x8_ = (a5_) land (x5_) in 
    let x9_ = (a1_) land (x8_) in 
    let x10_ = ((x7_) land ((lnot (x9_)))) lor (((lnot (x7_))) land (x9_)) in 
    let x11_ = (a4_) land (x10_) in 
    let x12_ = ((x5_) land ((lnot (x11_)))) lor (((lnot (x5_))) land (x11_)) in 
    let x13_ = ((a6_) land ((lnot (x10_)))) lor (((lnot (a6_))) land (x10_)) in 
    let x14_ = (x13_) land (a1_) in 
    let x15_ = (a2_) land (a6_) in 
    let x16_ = ((x15_) land ((lnot (a5_)))) lor (((lnot (x15_))) land (a5_)) in 
    let x17_ = (a1_) land (x16_) in 
    let x18_ = ((x2_) land ((lnot (x17_)))) lor (((lnot (x2_))) land (x17_)) in 
    let x19_ = (a4_) lor (x18_) in 
    let x20_ = ((x14_) land ((lnot (x19_)))) lor (((lnot (x14_))) land (x19_)) in 
    let x21_ = (a3_) land (x20_) in 
    let x22_ = ((x12_) land ((lnot (x21_)))) lor (((lnot (x12_))) land (x21_)) in 
    let out2_ = x22_ in 
    let x23_ = ((a6_) land ((lnot (x18_)))) lor (((lnot (a6_))) land (x18_)) in 
    let x24_ = (a1_) land (x23_) in 
    let x25_ = ((a5_) land ((lnot (x24_)))) lor (((lnot (a5_))) land (x24_)) in 
    let x26_ = ((a2_) land ((lnot (x17_)))) lor (((lnot (a2_))) land (x17_)) in 
    let x27_ = (x26_) lor (x6_) in 
    let x28_ = (a4_) land (x27_) in 
    let x29_ = ((x25_) land ((lnot (x28_)))) lor (((lnot (x25_))) land (x28_)) in 
    let x30_ = (lnot (x26_)) in 
    let x31_ = (a6_) lor (x29_) in 
    let x32_ = (lnot (x31_)) in 
    let x33_ = (a4_) land (x32_) in 
    let x34_ = ((x30_) land ((lnot (x33_)))) lor (((lnot (x30_))) land (x33_)) in 
    let x35_ = (a3_) land (x34_) in 
    let x36_ = ((x29_) land ((lnot (x35_)))) lor (((lnot (x29_))) land (x35_)) in 
    let out4_ = x36_ in 
    let x37_ = ((x6_) land ((lnot (x34_)))) lor (((lnot (x6_))) land (x34_)) in 
    let x38_ = (a5_) land (x23_) in 
    let x39_ = ((x38_) land ((lnot (x5_)))) lor (((lnot (x38_))) land (x5_)) in 
    let x40_ = (a4_) lor (x39_) in 
    let x41_ = ((x37_) land ((lnot (x40_)))) lor (((lnot (x37_))) land (x40_)) in 
    let x42_ = (x16_) lor (x24_) in 
    let x43_ = ((x42_) land ((lnot (x1_)))) lor (((lnot (x42_))) land (x1_)) in 
    let x44_ = ((x15_) land ((lnot (x24_)))) lor (((lnot (x15_))) land (x24_)) in 
    let x45_ = ((x44_) land ((lnot (x31_)))) lor (((lnot (x44_))) land (x31_)) in 
    let x46_ = (a4_) lor (x45_) in 
    let x47_ = ((x43_) land ((lnot (x46_)))) lor (((lnot (x43_))) land (x46_)) in 
    let x48_ = (a3_) lor (x47_) in 
    let x49_ = ((x41_) land ((lnot (x48_)))) lor (((lnot (x41_))) land (x48_)) in 
    let out1_ = x49_ in 
    let x50_ = (x5_) lor (x38_) in 
    let x51_ = ((x50_) land ((lnot (x6_)))) lor (((lnot (x50_))) land (x6_)) in 
    let x52_ = (x8_) land (x31_) in 
    let x53_ = (a4_) lor (x52_) in 
    let x54_ = ((x51_) land ((lnot (x53_)))) lor (((lnot (x51_))) land (x53_)) in 
    let x55_ = (x30_) land (x43_) in 
    let x56_ = (a3_) lor (x55_) in 
    let x57_ = ((x54_) land ((lnot (x56_)))) lor (((lnot (x54_))) land (x56_)) in 
    let out3_ = x57_ in 
    (out1_,out2_,out3_,out4_)



let sbox_7_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a2_)) in 
    let x2_ = (lnot (a5_)) in 
    let x3_ = (a2_) land (a4_) in 
    let x4_ = ((x3_) land ((lnot (a5_)))) lor (((lnot (x3_))) land (a5_)) in 
    let x5_ = ((x4_) land ((lnot (a3_)))) lor (((lnot (x4_))) land (a3_)) in 
    let x6_ = (a4_) land (x4_) in 
    let x7_ = ((x6_) land ((lnot (a2_)))) lor (((lnot (x6_))) land (a2_)) in 
    let x8_ = (a3_) land (x7_) in 
    let x9_ = ((a1_) land ((lnot (x8_)))) lor (((lnot (a1_))) land (x8_)) in 
    let x10_ = (a6_) lor (x9_) in 
    let x11_ = ((x5_) land ((lnot (x10_)))) lor (((lnot (x5_))) land (x10_)) in 
    let x12_ = (a4_) land (x2_) in 
    let x13_ = (x12_) lor (a2_) in 
    let x14_ = (a2_) lor (x2_) in 
    let x15_ = (a3_) land (x14_) in 
    let x16_ = ((x13_) land ((lnot (x15_)))) lor (((lnot (x13_))) land (x15_)) in 
    let x17_ = ((x6_) land ((lnot (x11_)))) lor (((lnot (x6_))) land (x11_)) in 
    let x18_ = (a6_) lor (x17_) in 
    let x19_ = ((x16_) land ((lnot (x18_)))) lor (((lnot (x16_))) land (x18_)) in 
    let x20_ = (a1_) land (x19_) in 
    let x21_ = ((x11_) land ((lnot (x20_)))) lor (((lnot (x11_))) land (x20_)) in 
    let out1_ = x21_ in 
    let x22_ = (a2_) lor (x21_) in 
    let x23_ = ((x22_) land ((lnot (x6_)))) lor (((lnot (x22_))) land (x6_)) in 
    let x24_ = ((x23_) land ((lnot (x15_)))) lor (((lnot (x23_))) land (x15_)) in 
    let x25_ = ((x5_) land ((lnot (x6_)))) lor (((lnot (x5_))) land (x6_)) in 
    let x26_ = (x25_) lor (x12_) in 
    let x27_ = (a6_) lor (x26_) in 
    let x28_ = ((x24_) land ((lnot (x27_)))) lor (((lnot (x24_))) land (x27_)) in 
    let x29_ = (x1_) land (x19_) in 
    let x30_ = (x23_) land (x26_) in 
    let x31_ = (a6_) land (x30_) in 
    let x32_ = ((x29_) land ((lnot (x31_)))) lor (((lnot (x29_))) land (x31_)) in 
    let x33_ = (a1_) lor (x32_) in 
    let x34_ = ((x28_) land ((lnot (x33_)))) lor (((lnot (x28_))) land (x33_)) in 
    let out4_ = x34_ in 
    let x35_ = (a4_) land (x16_) in 
    let x36_ = (x35_) lor (x1_) in 
    let x37_ = (a6_) land (x36_) in 
    let x38_ = ((x11_) land ((lnot (x37_)))) lor (((lnot (x11_))) land (x37_)) in 
    let x39_ = (a4_) land (x13_) in 
    let x40_ = (a3_) lor (x7_) in 
    let x41_ = ((x39_) land ((lnot (x40_)))) lor (((lnot (x39_))) land (x40_)) in 
    let x42_ = (x1_) lor (x24_) in 
    let x43_ = (a6_) lor (x42_) in 
    let x44_ = ((x41_) land ((lnot (x43_)))) lor (((lnot (x41_))) land (x43_)) in 
    let x45_ = (a1_) lor (x44_) in 
    let x46_ = ((x38_) land ((lnot (x45_)))) lor (((lnot (x38_))) land (x45_)) in 
    let out2_ = x46_ in 
    let x47_ = ((x8_) land ((lnot (x44_)))) lor (((lnot (x8_))) land (x44_)) in 
    let x48_ = ((x6_) land ((lnot (x15_)))) lor (((lnot (x6_))) land (x15_)) in 
    let x49_ = (a6_) lor (x48_) in 
    let x50_ = ((x47_) land ((lnot (x49_)))) lor (((lnot (x47_))) land (x49_)) in 
    let x51_ = ((x19_) land ((lnot (x44_)))) lor (((lnot (x19_))) land (x44_)) in 
    let x52_ = ((a4_) land ((lnot (x25_)))) lor (((lnot (a4_))) land (x25_)) in 
    let x53_ = (x52_) land (x46_) in 
    let x54_ = (a6_) land (x53_) in 
    let x55_ = ((x51_) land ((lnot (x54_)))) lor (((lnot (x51_))) land (x54_)) in 
    let x56_ = (a1_) lor (x55_) in 
    let x57_ = ((x50_) land ((lnot (x56_)))) lor (((lnot (x50_))) land (x56_)) in 
    let out3_ = x57_ in 
    (out1_,out2_,out3_,out4_)



let sbox_8_ (a1_,a2_,a3_,a4_,a5_,a6_) = 
    let x1_ = (lnot (a1_)) in 
    let x2_ = (lnot (a4_)) in 
    let x3_ = ((a3_) land ((lnot (x1_)))) lor (((lnot (a3_))) land (x1_)) in 
    let x4_ = (a3_) lor (x1_) in 
    let x5_ = ((x4_) land ((lnot (x2_)))) lor (((lnot (x4_))) land (x2_)) in 
    let x6_ = (a5_) lor (x5_) in 
    let x7_ = ((x3_) land ((lnot (x6_)))) lor (((lnot (x3_))) land (x6_)) in 
    let x8_ = (x1_) lor (x5_) in 
    let x9_ = ((x2_) land ((lnot (x8_)))) lor (((lnot (x2_))) land (x8_)) in 
    let x10_ = (a5_) land (x9_) in 
    let x11_ = ((x8_) land ((lnot (x10_)))) lor (((lnot (x8_))) land (x10_)) in 
    let x12_ = (a2_) land (x11_) in 
    let x13_ = ((x7_) land ((lnot (x12_)))) lor (((lnot (x7_))) land (x12_)) in 
    let x14_ = ((x6_) land ((lnot (x9_)))) lor (((lnot (x6_))) land (x9_)) in 
    let x15_ = (x3_) land (x9_) in 
    let x16_ = (a5_) land (x8_) in 
    let x17_ = ((x15_) land ((lnot (x16_)))) lor (((lnot (x15_))) land (x16_)) in 
    let x18_ = (a2_) lor (x17_) in 
    let x19_ = ((x14_) land ((lnot (x18_)))) lor (((lnot (x14_))) land (x18_)) in 
    let x20_ = (a6_) lor (x19_) in 
    let x21_ = ((x13_) land ((lnot (x20_)))) lor (((lnot (x13_))) land (x20_)) in 
    let out1_ = x21_ in 
    let x22_ = (a5_) lor (x3_) in 
    let x23_ = (x22_) land (x2_) in 
    let x24_ = (lnot (a3_)) in 
    let x25_ = (x24_) land (x8_) in 
    let x26_ = (a5_) land (x4_) in 
    let x27_ = ((x25_) land ((lnot (x26_)))) lor (((lnot (x25_))) land (x26_)) in 
    let x28_ = (a2_) lor (x27_) in 
    let x29_ = ((x23_) land ((lnot (x28_)))) lor (((lnot (x23_))) land (x28_)) in 
    let x30_ = (a6_) land (x29_) in 
    let x31_ = ((x13_) land ((lnot (x30_)))) lor (((lnot (x13_))) land (x30_)) in 
    let out4_ = x31_ in 
    let x32_ = ((x5_) land ((lnot (x6_)))) lor (((lnot (x5_))) land (x6_)) in 
    let x33_ = ((x32_) land ((lnot (x22_)))) lor (((lnot (x32_))) land (x22_)) in 
    let x34_ = (a4_) lor (x13_) in 
    let x35_ = (a2_) land (x34_) in 
    let x36_ = ((x33_) land ((lnot (x35_)))) lor (((lnot (x33_))) land (x35_)) in 
    let x37_ = (a1_) land (x33_) in 
    let x38_ = ((x37_) land ((lnot (x8_)))) lor (((lnot (x37_))) land (x8_)) in 
    let x39_ = ((a1_) land ((lnot (x23_)))) lor (((lnot (a1_))) land (x23_)) in 
    let x40_ = (x39_) land (x7_) in 
    let x41_ = (a2_) land (x40_) in 
    let x42_ = ((x38_) land ((lnot (x41_)))) lor (((lnot (x38_))) land (x41_)) in 
    let x43_ = (a6_) lor (x42_) in 
    let x44_ = ((x36_) land ((lnot (x43_)))) lor (((lnot (x36_))) land (x43_)) in 
    let out3_ = x44_ in 
    let x45_ = ((a1_) land ((lnot (x10_)))) lor (((lnot (a1_))) land (x10_)) in 
    let x46_ = ((x45_) land ((lnot (x22_)))) lor (((lnot (x45_))) land (x22_)) in 
    let x47_ = (lnot (x7_)) in 
    let x48_ = (x47_) land (x8_) in 
    let x49_ = (a2_) lor (x48_) in 
    let x50_ = ((x46_) land ((lnot (x49_)))) lor (((lnot (x46_))) land (x49_)) in 
    let x51_ = ((x19_) land ((lnot (x29_)))) lor (((lnot (x19_))) land (x29_)) in 
    let x52_ = (x51_) lor (x38_) in 
    let x53_ = (a6_) land (x52_) in 
    let x54_ = ((x50_) land ((lnot (x53_)))) lor (((lnot (x50_))) land (x53_)) in 
    let out2_ = x54_ in 
    (out1_,out2_,out3_,out4_)



let expand_ ((a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,a_20,a_21,a_22,a_23,a_24,a_25,a_26,a_27,a_28,a_29,a_30,a_31,a_32)) = 
    let out_1 = a_32 in 
    let out_2 = a_1 in 
    let out_3 = a_2 in 
    let out_4 = a_3 in 
    let out_5 = a_4 in 
    let out_6 = a_5 in 
    let out_7 = a_4 in 
    let out_8 = a_5 in 
    let out_9 = a_6 in 
    let out_10 = a_7 in 
    let out_11 = a_8 in 
    let out_12 = a_9 in 
    let out_13 = a_8 in 
    let out_14 = a_9 in 
    let out_15 = a_10 in 
    let out_16 = a_11 in 
    let out_17 = a_12 in 
    let out_18 = a_13 in 
    let out_19 = a_12 in 
    let out_20 = a_13 in 
    let out_21 = a_14 in 
    let out_22 = a_15 in 
    let out_23 = a_16 in 
    let out_24 = a_17 in 
    let out_25 = a_16 in 
    let out_26 = a_17 in 
    let out_27 = a_18 in 
    let out_28 = a_19 in 
    let out_29 = a_20 in 
    let out_30 = a_21 in 
    let out_31 = a_20 in 
    let out_32 = a_21 in 
    let out_33 = a_22 in 
    let out_34 = a_23 in 
    let out_35 = a_24 in 
    let out_36 = a_25 in 
    let out_37 = a_24 in 
    let out_38 = a_25 in 
    let out_39 = a_26 in 
    let out_40 = a_27 in 
    let out_41 = a_28 in 
    let out_42 = a_29 in 
    let out_43 = a_28 in 
    let out_44 = a_29 in 
    let out_45 = a_30 in 
    let out_46 = a_31 in 
    let out_47 = a_32 in 
    let out_48 = a_1 in 
    (out_1,out_2,out_3,out_4,out_5,out_6,out_7,out_8,out_9,out_10,out_11,out_12,out_13,out_14,out_15,out_16,out_17,out_18,out_19,out_20,out_21,out_22,out_23,out_24,out_25,out_26,out_27,out_28,out_29,out_30,out_31,out_32,out_33,out_34,out_35,out_36,out_37,out_38,out_39,out_40,out_41,out_42,out_43,out_44,out_45,out_46,out_47,out_48)



let init_p_ ((a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,a_20,a_21,a_22,a_23,a_24,a_25,a_26,a_27,a_28,a_29,a_30,a_31,a_32,a_33,a_34,a_35,a_36,a_37,a_38,a_39,a_40,a_41,a_42,a_43,a_44,a_45,a_46,a_47,a_48,a_49,a_50,a_51,a_52,a_53,a_54,a_55,a_56,a_57,a_58,a_59,a_60,a_61,a_62,a_63,a_64)) = 
    let out_1 = a_58 in 
    let out_2 = a_50 in 
    let out_3 = a_42 in 
    let out_4 = a_34 in 
    let out_5 = a_26 in 
    let out_6 = a_18 in 
    let out_7 = a_10 in 
    let out_8 = a_2 in 
    let out_9 = a_60 in 
    let out_10 = a_52 in 
    let out_11 = a_44 in 
    let out_12 = a_36 in 
    let out_13 = a_28 in 
    let out_14 = a_20 in 
    let out_15 = a_12 in 
    let out_16 = a_4 in 
    let out_17 = a_62 in 
    let out_18 = a_54 in 
    let out_19 = a_46 in 
    let out_20 = a_38 in 
    let out_21 = a_30 in 
    let out_22 = a_22 in 
    let out_23 = a_14 in 
    let out_24 = a_6 in 
    let out_25 = a_64 in 
    let out_26 = a_56 in 
    let out_27 = a_48 in 
    let out_28 = a_40 in 
    let out_29 = a_32 in 
    let out_30 = a_24 in 
    let out_31 = a_16 in 
    let out_32 = a_8 in 
    let out_33 = a_57 in 
    let out_34 = a_49 in 
    let out_35 = a_41 in 
    let out_36 = a_33 in 
    let out_37 = a_25 in 
    let out_38 = a_17 in 
    let out_39 = a_9 in 
    let out_40 = a_1 in 
    let out_41 = a_59 in 
    let out_42 = a_51 in 
    let out_43 = a_43 in 
    let out_44 = a_35 in 
    let out_45 = a_27 in 
    let out_46 = a_19 in 
    let out_47 = a_11 in 
    let out_48 = a_3 in 
    let out_49 = a_61 in 
    let out_50 = a_53 in 
    let out_51 = a_45 in 
    let out_52 = a_37 in 
    let out_53 = a_29 in 
    let out_54 = a_21 in 
    let out_55 = a_13 in 
    let out_56 = a_5 in 
    let out_57 = a_63 in 
    let out_58 = a_55 in 
    let out_59 = a_47 in 
    let out_60 = a_39 in 
    let out_61 = a_31 in 
    let out_62 = a_23 in 
    let out_63 = a_15 in 
    let out_64 = a_7 in 
    (out_1,out_2,out_3,out_4,out_5,out_6,out_7,out_8,out_9,out_10,out_11,out_12,out_13,out_14,out_15,out_16,out_17,out_18,out_19,out_20,out_21,out_22,out_23,out_24,out_25,out_26,out_27,out_28,out_29,out_30,out_31,out_32,out_33,out_34,out_35,out_36,out_37,out_38,out_39,out_40,out_41,out_42,out_43,out_44,out_45,out_46,out_47,out_48,out_49,out_50,out_51,out_52,out_53,out_54,out_55,out_56,out_57,out_58,out_59,out_60,out_61,out_62,out_63,out_64)



let final_p_ ((a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,a_20,a_21,a_22,a_23,a_24,a_25,a_26,a_27,a_28,a_29,a_30,a_31,a_32,a_33,a_34,a_35,a_36,a_37,a_38,a_39,a_40,a_41,a_42,a_43,a_44,a_45,a_46,a_47,a_48,a_49,a_50,a_51,a_52,a_53,a_54,a_55,a_56,a_57,a_58,a_59,a_60,a_61,a_62,a_63,a_64)) = 
    let out_1 = a_40 in 
    let out_2 = a_8 in 
    let out_3 = a_48 in 
    let out_4 = a_16 in 
    let out_5 = a_56 in 
    let out_6 = a_24 in 
    let out_7 = a_64 in 
    let out_8 = a_32 in 
    let out_9 = a_39 in 
    let out_10 = a_7 in 
    let out_11 = a_47 in 
    let out_12 = a_15 in 
    let out_13 = a_55 in 
    let out_14 = a_23 in 
    let out_15 = a_63 in 
    let out_16 = a_31 in 
    let out_17 = a_38 in 
    let out_18 = a_6 in 
    let out_19 = a_46 in 
    let out_20 = a_14 in 
    let out_21 = a_54 in 
    let out_22 = a_22 in 
    let out_23 = a_62 in 
    let out_24 = a_30 in 
    let out_25 = a_37 in 
    let out_26 = a_5 in 
    let out_27 = a_45 in 
    let out_28 = a_13 in 
    let out_29 = a_53 in 
    let out_30 = a_21 in 
    let out_31 = a_61 in 
    let out_32 = a_29 in 
    let out_33 = a_36 in 
    let out_34 = a_4 in 
    let out_35 = a_44 in 
    let out_36 = a_12 in 
    let out_37 = a_52 in 
    let out_38 = a_20 in 
    let out_39 = a_60 in 
    let out_40 = a_28 in 
    let out_41 = a_35 in 
    let out_42 = a_3 in 
    let out_43 = a_43 in 
    let out_44 = a_11 in 
    let out_45 = a_51 in 
    let out_46 = a_19 in 
    let out_47 = a_59 in 
    let out_48 = a_27 in 
    let out_49 = a_34 in 
    let out_50 = a_2 in 
    let out_51 = a_42 in 
    let out_52 = a_10 in 
    let out_53 = a_50 in 
    let out_54 = a_18 in 
    let out_55 = a_58 in 
    let out_56 = a_26 in 
    let out_57 = a_33 in 
    let out_58 = a_1 in 
    let out_59 = a_41 in 
    let out_60 = a_9 in 
    let out_61 = a_49 in 
    let out_62 = a_17 in 
    let out_63 = a_57 in 
    let out_64 = a_25 in 
    (out_1,out_2,out_3,out_4,out_5,out_6,out_7,out_8,out_9,out_10,out_11,out_12,out_13,out_14,out_15,out_16,out_17,out_18,out_19,out_20,out_21,out_22,out_23,out_24,out_25,out_26,out_27,out_28,out_29,out_30,out_31,out_32,out_33,out_34,out_35,out_36,out_37,out_38,out_39,out_40,out_41,out_42,out_43,out_44,out_45,out_46,out_47,out_48,out_49,out_50,out_51,out_52,out_53,out_54,out_55,out_56,out_57,out_58,out_59,out_60,out_61,out_62,out_63,out_64)



let permut_ ((a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,a_20,a_21,a_22,a_23,a_24,a_25,a_26,a_27,a_28,a_29,a_30,a_31,a_32)) = 
    let out_1 = a_16 in 
    let out_2 = a_7 in 
    let out_3 = a_20 in 
    let out_4 = a_21 in 
    let out_5 = a_29 in 
    let out_6 = a_12 in 
    let out_7 = a_28 in 
    let out_8 = a_17 in 
    let out_9 = a_1 in 
    let out_10 = a_15 in 
    let out_11 = a_23 in 
    let out_12 = a_26 in 
    let out_13 = a_5 in 
    let out_14 = a_18 in 
    let out_15 = a_31 in 
    let out_16 = a_10 in 
    let out_17 = a_2 in 
    let out_18 = a_8 in 
    let out_19 = a_24 in 
    let out_20 = a_14 in 
    let out_21 = a_32 in 
    let out_22 = a_27 in 
    let out_23 = a_3 in 
    let out_24 = a_9 in 
    let out_25 = a_19 in 
    let out_26 = a_13 in 
    let out_27 = a_30 in 
    let out_28 = a_6 in 
    let out_29 = a_22 in 
    let out_30 = a_11 in 
    let out_31 = a_4 in 
    let out_32 = a_25 in 
    (out_1,out_2,out_3,out_4,out_5,out_6,out_7,out_8,out_9,out_10,out_11,out_12,out_13,out_14,out_15,out_16,out_17,out_18,out_19,out_20,out_21,out_22,out_23,out_24,out_25,out_26,out_27,out_28,out_29,out_30,out_31,out_32)



let roundkey1_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_10 in 
    let roundkey_2 = key_51 in 
    let roundkey_3 = key_34 in 
    let roundkey_4 = key_60 in 
    let roundkey_5 = key_49 in 
    let roundkey_6 = key_17 in 
    let roundkey_7 = key_33 in 
    let roundkey_8 = key_57 in 
    let roundkey_9 = key_2 in 
    let roundkey_10 = key_9 in 
    let roundkey_11 = key_19 in 
    let roundkey_12 = key_42 in 
    let roundkey_13 = key_3 in 
    let roundkey_14 = key_35 in 
    let roundkey_15 = key_26 in 
    let roundkey_16 = key_25 in 
    let roundkey_17 = key_44 in 
    let roundkey_18 = key_58 in 
    let roundkey_19 = key_59 in 
    let roundkey_20 = key_1 in 
    let roundkey_21 = key_36 in 
    let roundkey_22 = key_27 in 
    let roundkey_23 = key_18 in 
    let roundkey_24 = key_41 in 
    let roundkey_25 = key_22 in 
    let roundkey_26 = key_28 in 
    let roundkey_27 = key_39 in 
    let roundkey_28 = key_54 in 
    let roundkey_29 = key_37 in 
    let roundkey_30 = key_4 in 
    let roundkey_31 = key_47 in 
    let roundkey_32 = key_30 in 
    let roundkey_33 = key_5 in 
    let roundkey_34 = key_53 in 
    let roundkey_35 = key_23 in 
    let roundkey_36 = key_29 in 
    let roundkey_37 = key_61 in 
    let roundkey_38 = key_21 in 
    let roundkey_39 = key_38 in 
    let roundkey_40 = key_63 in 
    let roundkey_41 = key_15 in 
    let roundkey_42 = key_20 in 
    let roundkey_43 = key_45 in 
    let roundkey_44 = key_14 in 
    let roundkey_45 = key_13 in 
    let roundkey_46 = key_62 in 
    let roundkey_47 = key_55 in 
    let roundkey_48 = key_31 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey2_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_2 in 
    let roundkey_2 = key_43 in 
    let roundkey_3 = key_26 in 
    let roundkey_4 = key_52 in 
    let roundkey_5 = key_41 in 
    let roundkey_6 = key_9 in 
    let roundkey_7 = key_25 in 
    let roundkey_8 = key_49 in 
    let roundkey_9 = key_59 in 
    let roundkey_10 = key_1 in 
    let roundkey_11 = key_11 in 
    let roundkey_12 = key_34 in 
    let roundkey_13 = key_60 in 
    let roundkey_14 = key_27 in 
    let roundkey_15 = key_18 in 
    let roundkey_16 = key_17 in 
    let roundkey_17 = key_36 in 
    let roundkey_18 = key_50 in 
    let roundkey_19 = key_51 in 
    let roundkey_20 = key_58 in 
    let roundkey_21 = key_57 in 
    let roundkey_22 = key_19 in 
    let roundkey_23 = key_10 in 
    let roundkey_24 = key_33 in 
    let roundkey_25 = key_14 in 
    let roundkey_26 = key_20 in 
    let roundkey_27 = key_31 in 
    let roundkey_28 = key_46 in 
    let roundkey_29 = key_29 in 
    let roundkey_30 = key_63 in 
    let roundkey_31 = key_39 in 
    let roundkey_32 = key_22 in 
    let roundkey_33 = key_28 in 
    let roundkey_34 = key_45 in 
    let roundkey_35 = key_15 in 
    let roundkey_36 = key_21 in 
    let roundkey_37 = key_53 in 
    let roundkey_38 = key_13 in 
    let roundkey_39 = key_30 in 
    let roundkey_40 = key_55 in 
    let roundkey_41 = key_7 in 
    let roundkey_42 = key_12 in 
    let roundkey_43 = key_37 in 
    let roundkey_44 = key_6 in 
    let roundkey_45 = key_5 in 
    let roundkey_46 = key_54 in 
    let roundkey_47 = key_47 in 
    let roundkey_48 = key_23 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey3_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_51 in 
    let roundkey_2 = key_27 in 
    let roundkey_3 = key_10 in 
    let roundkey_4 = key_36 in 
    let roundkey_5 = key_25 in 
    let roundkey_6 = key_58 in 
    let roundkey_7 = key_9 in 
    let roundkey_8 = key_33 in 
    let roundkey_9 = key_43 in 
    let roundkey_10 = key_50 in 
    let roundkey_11 = key_60 in 
    let roundkey_12 = key_18 in 
    let roundkey_13 = key_44 in 
    let roundkey_14 = key_11 in 
    let roundkey_15 = key_2 in 
    let roundkey_16 = key_1 in 
    let roundkey_17 = key_49 in 
    let roundkey_18 = key_34 in 
    let roundkey_19 = key_35 in 
    let roundkey_20 = key_42 in 
    let roundkey_21 = key_41 in 
    let roundkey_22 = key_3 in 
    let roundkey_23 = key_59 in 
    let roundkey_24 = key_17 in 
    let roundkey_25 = key_61 in 
    let roundkey_26 = key_4 in 
    let roundkey_27 = key_15 in 
    let roundkey_28 = key_30 in 
    let roundkey_29 = key_13 in 
    let roundkey_30 = key_47 in 
    let roundkey_31 = key_23 in 
    let roundkey_32 = key_6 in 
    let roundkey_33 = key_12 in 
    let roundkey_34 = key_29 in 
    let roundkey_35 = key_62 in 
    let roundkey_36 = key_5 in 
    let roundkey_37 = key_37 in 
    let roundkey_38 = key_28 in 
    let roundkey_39 = key_14 in 
    let roundkey_40 = key_39 in 
    let roundkey_41 = key_54 in 
    let roundkey_42 = key_63 in 
    let roundkey_43 = key_21 in 
    let roundkey_44 = key_53 in 
    let roundkey_45 = key_20 in 
    let roundkey_46 = key_38 in 
    let roundkey_47 = key_31 in 
    let roundkey_48 = key_7 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey4_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_35 in 
    let roundkey_2 = key_11 in 
    let roundkey_3 = key_59 in 
    let roundkey_4 = key_49 in 
    let roundkey_5 = key_9 in 
    let roundkey_6 = key_42 in 
    let roundkey_7 = key_58 in 
    let roundkey_8 = key_17 in 
    let roundkey_9 = key_27 in 
    let roundkey_10 = key_34 in 
    let roundkey_11 = key_44 in 
    let roundkey_12 = key_2 in 
    let roundkey_13 = key_57 in 
    let roundkey_14 = key_60 in 
    let roundkey_15 = key_51 in 
    let roundkey_16 = key_50 in 
    let roundkey_17 = key_33 in 
    let roundkey_18 = key_18 in 
    let roundkey_19 = key_19 in 
    let roundkey_20 = key_26 in 
    let roundkey_21 = key_25 in 
    let roundkey_22 = key_52 in 
    let roundkey_23 = key_43 in 
    let roundkey_24 = key_1 in 
    let roundkey_25 = key_45 in 
    let roundkey_26 = key_55 in 
    let roundkey_27 = key_62 in 
    let roundkey_28 = key_14 in 
    let roundkey_29 = key_28 in 
    let roundkey_30 = key_31 in 
    let roundkey_31 = key_7 in 
    let roundkey_32 = key_53 in 
    let roundkey_33 = key_63 in 
    let roundkey_34 = key_13 in 
    let roundkey_35 = key_46 in 
    let roundkey_36 = key_20 in 
    let roundkey_37 = key_21 in 
    let roundkey_38 = key_12 in 
    let roundkey_39 = key_61 in 
    let roundkey_40 = key_23 in 
    let roundkey_41 = key_38 in 
    let roundkey_42 = key_47 in 
    let roundkey_43 = key_5 in 
    let roundkey_44 = key_37 in 
    let roundkey_45 = key_4 in 
    let roundkey_46 = key_22 in 
    let roundkey_47 = key_15 in 
    let roundkey_48 = key_54 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey5_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_19 in 
    let roundkey_2 = key_60 in 
    let roundkey_3 = key_43 in 
    let roundkey_4 = key_33 in 
    let roundkey_5 = key_58 in 
    let roundkey_6 = key_26 in 
    let roundkey_7 = key_42 in 
    let roundkey_8 = key_1 in 
    let roundkey_9 = key_11 in 
    let roundkey_10 = key_18 in 
    let roundkey_11 = key_57 in 
    let roundkey_12 = key_51 in 
    let roundkey_13 = key_41 in 
    let roundkey_14 = key_44 in 
    let roundkey_15 = key_35 in 
    let roundkey_16 = key_34 in 
    let roundkey_17 = key_17 in 
    let roundkey_18 = key_2 in 
    let roundkey_19 = key_3 in 
    let roundkey_20 = key_10 in 
    let roundkey_21 = key_9 in 
    let roundkey_22 = key_36 in 
    let roundkey_23 = key_27 in 
    let roundkey_24 = key_50 in 
    let roundkey_25 = key_29 in 
    let roundkey_26 = key_39 in 
    let roundkey_27 = key_46 in 
    let roundkey_28 = key_61 in 
    let roundkey_29 = key_12 in 
    let roundkey_30 = key_15 in 
    let roundkey_31 = key_54 in 
    let roundkey_32 = key_37 in 
    let roundkey_33 = key_47 in 
    let roundkey_34 = key_28 in 
    let roundkey_35 = key_30 in 
    let roundkey_36 = key_4 in 
    let roundkey_37 = key_5 in 
    let roundkey_38 = key_63 in 
    let roundkey_39 = key_45 in 
    let roundkey_40 = key_7 in 
    let roundkey_41 = key_22 in 
    let roundkey_42 = key_31 in 
    let roundkey_43 = key_20 in 
    let roundkey_44 = key_21 in 
    let roundkey_45 = key_55 in 
    let roundkey_46 = key_6 in 
    let roundkey_47 = key_62 in 
    let roundkey_48 = key_38 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey6_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_3 in 
    let roundkey_2 = key_44 in 
    let roundkey_3 = key_27 in 
    let roundkey_4 = key_17 in 
    let roundkey_5 = key_42 in 
    let roundkey_6 = key_10 in 
    let roundkey_7 = key_26 in 
    let roundkey_8 = key_50 in 
    let roundkey_9 = key_60 in 
    let roundkey_10 = key_2 in 
    let roundkey_11 = key_41 in 
    let roundkey_12 = key_35 in 
    let roundkey_13 = key_25 in 
    let roundkey_14 = key_57 in 
    let roundkey_15 = key_19 in 
    let roundkey_16 = key_18 in 
    let roundkey_17 = key_1 in 
    let roundkey_18 = key_51 in 
    let roundkey_19 = key_52 in 
    let roundkey_20 = key_59 in 
    let roundkey_21 = key_58 in 
    let roundkey_22 = key_49 in 
    let roundkey_23 = key_11 in 
    let roundkey_24 = key_34 in 
    let roundkey_25 = key_13 in 
    let roundkey_26 = key_23 in 
    let roundkey_27 = key_30 in 
    let roundkey_28 = key_45 in 
    let roundkey_29 = key_63 in 
    let roundkey_30 = key_62 in 
    let roundkey_31 = key_38 in 
    let roundkey_32 = key_21 in 
    let roundkey_33 = key_31 in 
    let roundkey_34 = key_12 in 
    let roundkey_35 = key_14 in 
    let roundkey_36 = key_55 in 
    let roundkey_37 = key_20 in 
    let roundkey_38 = key_47 in 
    let roundkey_39 = key_29 in 
    let roundkey_40 = key_54 in 
    let roundkey_41 = key_6 in 
    let roundkey_42 = key_15 in 
    let roundkey_43 = key_4 in 
    let roundkey_44 = key_5 in 
    let roundkey_45 = key_39 in 
    let roundkey_46 = key_53 in 
    let roundkey_47 = key_46 in 
    let roundkey_48 = key_22 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey7_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_52 in 
    let roundkey_2 = key_57 in 
    let roundkey_3 = key_11 in 
    let roundkey_4 = key_1 in 
    let roundkey_5 = key_26 in 
    let roundkey_6 = key_59 in 
    let roundkey_7 = key_10 in 
    let roundkey_8 = key_34 in 
    let roundkey_9 = key_44 in 
    let roundkey_10 = key_51 in 
    let roundkey_11 = key_25 in 
    let roundkey_12 = key_19 in 
    let roundkey_13 = key_9 in 
    let roundkey_14 = key_41 in 
    let roundkey_15 = key_3 in 
    let roundkey_16 = key_2 in 
    let roundkey_17 = key_50 in 
    let roundkey_18 = key_35 in 
    let roundkey_19 = key_36 in 
    let roundkey_20 = key_43 in 
    let roundkey_21 = key_42 in 
    let roundkey_22 = key_33 in 
    let roundkey_23 = key_60 in 
    let roundkey_24 = key_18 in 
    let roundkey_25 = key_28 in 
    let roundkey_26 = key_7 in 
    let roundkey_27 = key_14 in 
    let roundkey_28 = key_29 in 
    let roundkey_29 = key_47 in 
    let roundkey_30 = key_46 in 
    let roundkey_31 = key_22 in 
    let roundkey_32 = key_5 in 
    let roundkey_33 = key_15 in 
    let roundkey_34 = key_63 in 
    let roundkey_35 = key_61 in 
    let roundkey_36 = key_39 in 
    let roundkey_37 = key_4 in 
    let roundkey_38 = key_31 in 
    let roundkey_39 = key_13 in 
    let roundkey_40 = key_38 in 
    let roundkey_41 = key_53 in 
    let roundkey_42 = key_62 in 
    let roundkey_43 = key_55 in 
    let roundkey_44 = key_20 in 
    let roundkey_45 = key_23 in 
    let roundkey_46 = key_37 in 
    let roundkey_47 = key_30 in 
    let roundkey_48 = key_6 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey8_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_36 in 
    let roundkey_2 = key_41 in 
    let roundkey_3 = key_60 in 
    let roundkey_4 = key_50 in 
    let roundkey_5 = key_10 in 
    let roundkey_6 = key_43 in 
    let roundkey_7 = key_59 in 
    let roundkey_8 = key_18 in 
    let roundkey_9 = key_57 in 
    let roundkey_10 = key_35 in 
    let roundkey_11 = key_9 in 
    let roundkey_12 = key_3 in 
    let roundkey_13 = key_58 in 
    let roundkey_14 = key_25 in 
    let roundkey_15 = key_52 in 
    let roundkey_16 = key_51 in 
    let roundkey_17 = key_34 in 
    let roundkey_18 = key_19 in 
    let roundkey_19 = key_49 in 
    let roundkey_20 = key_27 in 
    let roundkey_21 = key_26 in 
    let roundkey_22 = key_17 in 
    let roundkey_23 = key_44 in 
    let roundkey_24 = key_2 in 
    let roundkey_25 = key_12 in 
    let roundkey_26 = key_54 in 
    let roundkey_27 = key_61 in 
    let roundkey_28 = key_13 in 
    let roundkey_29 = key_31 in 
    let roundkey_30 = key_30 in 
    let roundkey_31 = key_6 in 
    let roundkey_32 = key_20 in 
    let roundkey_33 = key_62 in 
    let roundkey_34 = key_47 in 
    let roundkey_35 = key_45 in 
    let roundkey_36 = key_23 in 
    let roundkey_37 = key_55 in 
    let roundkey_38 = key_15 in 
    let roundkey_39 = key_28 in 
    let roundkey_40 = key_22 in 
    let roundkey_41 = key_37 in 
    let roundkey_42 = key_46 in 
    let roundkey_43 = key_39 in 
    let roundkey_44 = key_4 in 
    let roundkey_45 = key_7 in 
    let roundkey_46 = key_21 in 
    let roundkey_47 = key_14 in 
    let roundkey_48 = key_53 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey9_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_57 in 
    let roundkey_2 = key_33 in 
    let roundkey_3 = key_52 in 
    let roundkey_4 = key_42 in 
    let roundkey_5 = key_2 in 
    let roundkey_6 = key_35 in 
    let roundkey_7 = key_51 in 
    let roundkey_8 = key_10 in 
    let roundkey_9 = key_49 in 
    let roundkey_10 = key_27 in 
    let roundkey_11 = key_1 in 
    let roundkey_12 = key_60 in 
    let roundkey_13 = key_50 in 
    let roundkey_14 = key_17 in 
    let roundkey_15 = key_44 in 
    let roundkey_16 = key_43 in 
    let roundkey_17 = key_26 in 
    let roundkey_18 = key_11 in 
    let roundkey_19 = key_41 in 
    let roundkey_20 = key_19 in 
    let roundkey_21 = key_18 in 
    let roundkey_22 = key_9 in 
    let roundkey_23 = key_36 in 
    let roundkey_24 = key_59 in 
    let roundkey_25 = key_4 in 
    let roundkey_26 = key_46 in 
    let roundkey_27 = key_53 in 
    let roundkey_28 = key_5 in 
    let roundkey_29 = key_23 in 
    let roundkey_30 = key_22 in 
    let roundkey_31 = key_61 in 
    let roundkey_32 = key_12 in 
    let roundkey_33 = key_54 in 
    let roundkey_34 = key_39 in 
    let roundkey_35 = key_37 in 
    let roundkey_36 = key_15 in 
    let roundkey_37 = key_47 in 
    let roundkey_38 = key_7 in 
    let roundkey_39 = key_20 in 
    let roundkey_40 = key_14 in 
    let roundkey_41 = key_29 in 
    let roundkey_42 = key_38 in 
    let roundkey_43 = key_31 in 
    let roundkey_44 = key_63 in 
    let roundkey_45 = key_62 in 
    let roundkey_46 = key_13 in 
    let roundkey_47 = key_6 in 
    let roundkey_48 = key_45 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey10_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_41 in 
    let roundkey_2 = key_17 in 
    let roundkey_3 = key_36 in 
    let roundkey_4 = key_26 in 
    let roundkey_5 = key_51 in 
    let roundkey_6 = key_19 in 
    let roundkey_7 = key_35 in 
    let roundkey_8 = key_59 in 
    let roundkey_9 = key_33 in 
    let roundkey_10 = key_11 in 
    let roundkey_11 = key_50 in 
    let roundkey_12 = key_44 in 
    let roundkey_13 = key_34 in 
    let roundkey_14 = key_1 in 
    let roundkey_15 = key_57 in 
    let roundkey_16 = key_27 in 
    let roundkey_17 = key_10 in 
    let roundkey_18 = key_60 in 
    let roundkey_19 = key_25 in 
    let roundkey_20 = key_3 in 
    let roundkey_21 = key_2 in 
    let roundkey_22 = key_58 in 
    let roundkey_23 = key_49 in 
    let roundkey_24 = key_43 in 
    let roundkey_25 = key_55 in 
    let roundkey_26 = key_30 in 
    let roundkey_27 = key_37 in 
    let roundkey_28 = key_20 in 
    let roundkey_29 = key_7 in 
    let roundkey_30 = key_6 in 
    let roundkey_31 = key_45 in 
    let roundkey_32 = key_63 in 
    let roundkey_33 = key_38 in 
    let roundkey_34 = key_23 in 
    let roundkey_35 = key_21 in 
    let roundkey_36 = key_62 in 
    let roundkey_37 = key_31 in 
    let roundkey_38 = key_54 in 
    let roundkey_39 = key_4 in 
    let roundkey_40 = key_61 in 
    let roundkey_41 = key_13 in 
    let roundkey_42 = key_22 in 
    let roundkey_43 = key_15 in 
    let roundkey_44 = key_47 in 
    let roundkey_45 = key_46 in 
    let roundkey_46 = key_28 in 
    let roundkey_47 = key_53 in 
    let roundkey_48 = key_29 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey11_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_25 in 
    let roundkey_2 = key_1 in 
    let roundkey_3 = key_49 in 
    let roundkey_4 = key_10 in 
    let roundkey_5 = key_35 in 
    let roundkey_6 = key_3 in 
    let roundkey_7 = key_19 in 
    let roundkey_8 = key_43 in 
    let roundkey_9 = key_17 in 
    let roundkey_10 = key_60 in 
    let roundkey_11 = key_34 in 
    let roundkey_12 = key_57 in 
    let roundkey_13 = key_18 in 
    let roundkey_14 = key_50 in 
    let roundkey_15 = key_41 in 
    let roundkey_16 = key_11 in 
    let roundkey_17 = key_59 in 
    let roundkey_18 = key_44 in 
    let roundkey_19 = key_9 in 
    let roundkey_20 = key_52 in 
    let roundkey_21 = key_51 in 
    let roundkey_22 = key_42 in 
    let roundkey_23 = key_33 in 
    let roundkey_24 = key_27 in 
    let roundkey_25 = key_39 in 
    let roundkey_26 = key_14 in 
    let roundkey_27 = key_21 in 
    let roundkey_28 = key_4 in 
    let roundkey_29 = key_54 in 
    let roundkey_30 = key_53 in 
    let roundkey_31 = key_29 in 
    let roundkey_32 = key_47 in 
    let roundkey_33 = key_22 in 
    let roundkey_34 = key_7 in 
    let roundkey_35 = key_5 in 
    let roundkey_36 = key_46 in 
    let roundkey_37 = key_15 in 
    let roundkey_38 = key_38 in 
    let roundkey_39 = key_55 in 
    let roundkey_40 = key_45 in 
    let roundkey_41 = key_28 in 
    let roundkey_42 = key_6 in 
    let roundkey_43 = key_62 in 
    let roundkey_44 = key_31 in 
    let roundkey_45 = key_30 in 
    let roundkey_46 = key_12 in 
    let roundkey_47 = key_37 in 
    let roundkey_48 = key_13 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey12_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_9 in 
    let roundkey_2 = key_50 in 
    let roundkey_3 = key_33 in 
    let roundkey_4 = key_59 in 
    let roundkey_5 = key_19 in 
    let roundkey_6 = key_52 in 
    let roundkey_7 = key_3 in 
    let roundkey_8 = key_27 in 
    let roundkey_9 = key_1 in 
    let roundkey_10 = key_44 in 
    let roundkey_11 = key_18 in 
    let roundkey_12 = key_41 in 
    let roundkey_13 = key_2 in 
    let roundkey_14 = key_34 in 
    let roundkey_15 = key_25 in 
    let roundkey_16 = key_60 in 
    let roundkey_17 = key_43 in 
    let roundkey_18 = key_57 in 
    let roundkey_19 = key_58 in 
    let roundkey_20 = key_36 in 
    let roundkey_21 = key_35 in 
    let roundkey_22 = key_26 in 
    let roundkey_23 = key_17 in 
    let roundkey_24 = key_11 in 
    let roundkey_25 = key_23 in 
    let roundkey_26 = key_61 in 
    let roundkey_27 = key_5 in 
    let roundkey_28 = key_55 in 
    let roundkey_29 = key_38 in 
    let roundkey_30 = key_37 in 
    let roundkey_31 = key_13 in 
    let roundkey_32 = key_31 in 
    let roundkey_33 = key_6 in 
    let roundkey_34 = key_54 in 
    let roundkey_35 = key_20 in 
    let roundkey_36 = key_30 in 
    let roundkey_37 = key_62 in 
    let roundkey_38 = key_22 in 
    let roundkey_39 = key_39 in 
    let roundkey_40 = key_29 in 
    let roundkey_41 = key_12 in 
    let roundkey_42 = key_53 in 
    let roundkey_43 = key_46 in 
    let roundkey_44 = key_15 in 
    let roundkey_45 = key_14 in 
    let roundkey_46 = key_63 in 
    let roundkey_47 = key_21 in 
    let roundkey_48 = key_28 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey13_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_58 in 
    let roundkey_2 = key_34 in 
    let roundkey_3 = key_17 in 
    let roundkey_4 = key_43 in 
    let roundkey_5 = key_3 in 
    let roundkey_6 = key_36 in 
    let roundkey_7 = key_52 in 
    let roundkey_8 = key_11 in 
    let roundkey_9 = key_50 in 
    let roundkey_10 = key_57 in 
    let roundkey_11 = key_2 in 
    let roundkey_12 = key_25 in 
    let roundkey_13 = key_51 in 
    let roundkey_14 = key_18 in 
    let roundkey_15 = key_9 in 
    let roundkey_16 = key_44 in 
    let roundkey_17 = key_27 in 
    let roundkey_18 = key_41 in 
    let roundkey_19 = key_42 in 
    let roundkey_20 = key_49 in 
    let roundkey_21 = key_19 in 
    let roundkey_22 = key_10 in 
    let roundkey_23 = key_1 in 
    let roundkey_24 = key_60 in 
    let roundkey_25 = key_7 in 
    let roundkey_26 = key_45 in 
    let roundkey_27 = key_20 in 
    let roundkey_28 = key_39 in 
    let roundkey_29 = key_22 in 
    let roundkey_30 = key_21 in 
    let roundkey_31 = key_28 in 
    let roundkey_32 = key_15 in 
    let roundkey_33 = key_53 in 
    let roundkey_34 = key_38 in 
    let roundkey_35 = key_4 in 
    let roundkey_36 = key_14 in 
    let roundkey_37 = key_46 in 
    let roundkey_38 = key_6 in 
    let roundkey_39 = key_23 in 
    let roundkey_40 = key_13 in 
    let roundkey_41 = key_63 in 
    let roundkey_42 = key_37 in 
    let roundkey_43 = key_30 in 
    let roundkey_44 = key_62 in 
    let roundkey_45 = key_61 in 
    let roundkey_46 = key_47 in 
    let roundkey_47 = key_5 in 
    let roundkey_48 = key_12 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey14_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_42 in 
    let roundkey_2 = key_18 in 
    let roundkey_3 = key_1 in 
    let roundkey_4 = key_27 in 
    let roundkey_5 = key_52 in 
    let roundkey_6 = key_49 in 
    let roundkey_7 = key_36 in 
    let roundkey_8 = key_60 in 
    let roundkey_9 = key_34 in 
    let roundkey_10 = key_41 in 
    let roundkey_11 = key_51 in 
    let roundkey_12 = key_9 in 
    let roundkey_13 = key_35 in 
    let roundkey_14 = key_2 in 
    let roundkey_15 = key_58 in 
    let roundkey_16 = key_57 in 
    let roundkey_17 = key_11 in 
    let roundkey_18 = key_25 in 
    let roundkey_19 = key_26 in 
    let roundkey_20 = key_33 in 
    let roundkey_21 = key_3 in 
    let roundkey_22 = key_59 in 
    let roundkey_23 = key_50 in 
    let roundkey_24 = key_44 in 
    let roundkey_25 = key_54 in 
    let roundkey_26 = key_29 in 
    let roundkey_27 = key_4 in 
    let roundkey_28 = key_23 in 
    let roundkey_29 = key_6 in 
    let roundkey_30 = key_5 in 
    let roundkey_31 = key_12 in 
    let roundkey_32 = key_62 in 
    let roundkey_33 = key_37 in 
    let roundkey_34 = key_22 in 
    let roundkey_35 = key_55 in 
    let roundkey_36 = key_61 in 
    let roundkey_37 = key_30 in 
    let roundkey_38 = key_53 in 
    let roundkey_39 = key_7 in 
    let roundkey_40 = key_28 in 
    let roundkey_41 = key_47 in 
    let roundkey_42 = key_21 in 
    let roundkey_43 = key_14 in 
    let roundkey_44 = key_46 in 
    let roundkey_45 = key_45 in 
    let roundkey_46 = key_31 in 
    let roundkey_47 = key_20 in 
    let roundkey_48 = key_63 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey15_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_26 in 
    let roundkey_2 = key_2 in 
    let roundkey_3 = key_50 in 
    let roundkey_4 = key_11 in 
    let roundkey_5 = key_36 in 
    let roundkey_6 = key_33 in 
    let roundkey_7 = key_49 in 
    let roundkey_8 = key_44 in 
    let roundkey_9 = key_18 in 
    let roundkey_10 = key_25 in 
    let roundkey_11 = key_35 in 
    let roundkey_12 = key_58 in 
    let roundkey_13 = key_19 in 
    let roundkey_14 = key_51 in 
    let roundkey_15 = key_42 in 
    let roundkey_16 = key_41 in 
    let roundkey_17 = key_60 in 
    let roundkey_18 = key_9 in 
    let roundkey_19 = key_10 in 
    let roundkey_20 = key_17 in 
    let roundkey_21 = key_52 in 
    let roundkey_22 = key_43 in 
    let roundkey_23 = key_34 in 
    let roundkey_24 = key_57 in 
    let roundkey_25 = key_38 in 
    let roundkey_26 = key_13 in 
    let roundkey_27 = key_55 in 
    let roundkey_28 = key_7 in 
    let roundkey_29 = key_53 in 
    let roundkey_30 = key_20 in 
    let roundkey_31 = key_63 in 
    let roundkey_32 = key_46 in 
    let roundkey_33 = key_21 in 
    let roundkey_34 = key_6 in 
    let roundkey_35 = key_39 in 
    let roundkey_36 = key_45 in 
    let roundkey_37 = key_14 in 
    let roundkey_38 = key_37 in 
    let roundkey_39 = key_54 in 
    let roundkey_40 = key_12 in 
    let roundkey_41 = key_31 in 
    let roundkey_42 = key_5 in 
    let roundkey_43 = key_61 in 
    let roundkey_44 = key_30 in 
    let roundkey_45 = key_29 in 
    let roundkey_46 = key_15 in 
    let roundkey_47 = key_4 in 
    let roundkey_48 = key_47 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey16_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_1 = key_18 in 
    let roundkey_2 = key_59 in 
    let roundkey_3 = key_42 in 
    let roundkey_4 = key_3 in 
    let roundkey_5 = key_57 in 
    let roundkey_6 = key_25 in 
    let roundkey_7 = key_41 in 
    let roundkey_8 = key_36 in 
    let roundkey_9 = key_10 in 
    let roundkey_10 = key_17 in 
    let roundkey_11 = key_27 in 
    let roundkey_12 = key_50 in 
    let roundkey_13 = key_11 in 
    let roundkey_14 = key_43 in 
    let roundkey_15 = key_34 in 
    let roundkey_16 = key_33 in 
    let roundkey_17 = key_52 in 
    let roundkey_18 = key_1 in 
    let roundkey_19 = key_2 in 
    let roundkey_20 = key_9 in 
    let roundkey_21 = key_44 in 
    let roundkey_22 = key_35 in 
    let roundkey_23 = key_26 in 
    let roundkey_24 = key_49 in 
    let roundkey_25 = key_30 in 
    let roundkey_26 = key_5 in 
    let roundkey_27 = key_47 in 
    let roundkey_28 = key_62 in 
    let roundkey_29 = key_45 in 
    let roundkey_30 = key_12 in 
    let roundkey_31 = key_55 in 
    let roundkey_32 = key_38 in 
    let roundkey_33 = key_13 in 
    let roundkey_34 = key_61 in 
    let roundkey_35 = key_31 in 
    let roundkey_36 = key_37 in 
    let roundkey_37 = key_6 in 
    let roundkey_38 = key_29 in 
    let roundkey_39 = key_46 in 
    let roundkey_40 = key_4 in 
    let roundkey_41 = key_23 in 
    let roundkey_42 = key_28 in 
    let roundkey_43 = key_53 in 
    let roundkey_44 = key_22 in 
    let roundkey_45 = key_21 in 
    let roundkey_46 = key_7 in 
    let roundkey_47 = key_63 in 
    let roundkey_48 = key_39 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let des_single1_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp11,tmp12,tmp13,tmp14,tmp15,tmp16,tmp17,tmp18,tmp19,tmp110,tmp111,tmp112,tmp113,tmp114,tmp115,tmp116,tmp117,tmp118,tmp119,tmp120,tmp121,tmp122,tmp123,tmp124,tmp125,tmp126,tmp127,tmp128,tmp129,tmp130,tmp131,tmp132,tmp133,tmp134,tmp135,tmp136,tmp137,tmp138,tmp139,tmp140,tmp141,tmp142,tmp143,tmp144,tmp145,tmp146,tmp147,tmp148) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp21,tmp22,tmp23,tmp24,tmp25,tmp26,tmp27,tmp28,tmp29,tmp210,tmp211,tmp212,tmp213,tmp214,tmp215,tmp216,tmp217,tmp218,tmp219,tmp220,tmp221,tmp222,tmp223,tmp224,tmp225,tmp226,tmp227,tmp228,tmp229,tmp230,tmp231,tmp232,tmp233,tmp234,tmp235,tmp236,tmp237,tmp238,tmp239,tmp240,tmp241,tmp242,tmp243,tmp244,tmp245,tmp246,tmp247,tmp248) = roundkey1_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp11) land ((lnot (tmp21)))) lor (((lnot (tmp11))) land (tmp21)),((tmp12) land ((lnot (tmp22)))) lor (((lnot (tmp12))) land (tmp22)),((tmp13) land ((lnot (tmp23)))) lor (((lnot (tmp13))) land (tmp23)),((tmp14) land ((lnot (tmp24)))) lor (((lnot (tmp14))) land (tmp24)),((tmp15) land ((lnot (tmp25)))) lor (((lnot (tmp15))) land (tmp25)),((tmp16) land ((lnot (tmp26)))) lor (((lnot (tmp16))) land (tmp26)),((tmp17) land ((lnot (tmp27)))) lor (((lnot (tmp17))) land (tmp27)),((tmp18) land ((lnot (tmp28)))) lor (((lnot (tmp18))) land (tmp28)),((tmp19) land ((lnot (tmp29)))) lor (((lnot (tmp19))) land (tmp29)),((tmp110) land ((lnot (tmp210)))) lor (((lnot (tmp110))) land (tmp210)),((tmp111) land ((lnot (tmp211)))) lor (((lnot (tmp111))) land (tmp211)),((tmp112) land ((lnot (tmp212)))) lor (((lnot (tmp112))) land (tmp212)),((tmp113) land ((lnot (tmp213)))) lor (((lnot (tmp113))) land (tmp213)),((tmp114) land ((lnot (tmp214)))) lor (((lnot (tmp114))) land (tmp214)),((tmp115) land ((lnot (tmp215)))) lor (((lnot (tmp115))) land (tmp215)),((tmp116) land ((lnot (tmp216)))) lor (((lnot (tmp116))) land (tmp216)),((tmp117) land ((lnot (tmp217)))) lor (((lnot (tmp117))) land (tmp217)),((tmp118) land ((lnot (tmp218)))) lor (((lnot (tmp118))) land (tmp218)),((tmp119) land ((lnot (tmp219)))) lor (((lnot (tmp119))) land (tmp219)),((tmp120) land ((lnot (tmp220)))) lor (((lnot (tmp120))) land (tmp220)),((tmp121) land ((lnot (tmp221)))) lor (((lnot (tmp121))) land (tmp221)),((tmp122) land ((lnot (tmp222)))) lor (((lnot (tmp122))) land (tmp222)),((tmp123) land ((lnot (tmp223)))) lor (((lnot (tmp123))) land (tmp223)),((tmp124) land ((lnot (tmp224)))) lor (((lnot (tmp124))) land (tmp224)),((tmp125) land ((lnot (tmp225)))) lor (((lnot (tmp125))) land (tmp225)),((tmp126) land ((lnot (tmp226)))) lor (((lnot (tmp126))) land (tmp226)),((tmp127) land ((lnot (tmp227)))) lor (((lnot (tmp127))) land (tmp227)),((tmp128) land ((lnot (tmp228)))) lor (((lnot (tmp128))) land (tmp228)),((tmp129) land ((lnot (tmp229)))) lor (((lnot (tmp129))) land (tmp229)),((tmp130) land ((lnot (tmp230)))) lor (((lnot (tmp130))) land (tmp230)),((tmp131) land ((lnot (tmp231)))) lor (((lnot (tmp131))) land (tmp231)),((tmp132) land ((lnot (tmp232)))) lor (((lnot (tmp132))) land (tmp232)),((tmp133) land ((lnot (tmp233)))) lor (((lnot (tmp133))) land (tmp233)),((tmp134) land ((lnot (tmp234)))) lor (((lnot (tmp134))) land (tmp234)),((tmp135) land ((lnot (tmp235)))) lor (((lnot (tmp135))) land (tmp235)),((tmp136) land ((lnot (tmp236)))) lor (((lnot (tmp136))) land (tmp236)),((tmp137) land ((lnot (tmp237)))) lor (((lnot (tmp137))) land (tmp237)),((tmp138) land ((lnot (tmp238)))) lor (((lnot (tmp138))) land (tmp238)),((tmp139) land ((lnot (tmp239)))) lor (((lnot (tmp139))) land (tmp239)),((tmp140) land ((lnot (tmp240)))) lor (((lnot (tmp140))) land (tmp240)),((tmp141) land ((lnot (tmp241)))) lor (((lnot (tmp141))) land (tmp241)),((tmp142) land ((lnot (tmp242)))) lor (((lnot (tmp142))) land (tmp242)),((tmp143) land ((lnot (tmp243)))) lor (((lnot (tmp143))) land (tmp243)),((tmp144) land ((lnot (tmp244)))) lor (((lnot (tmp144))) land (tmp244)),((tmp145) land ((lnot (tmp245)))) lor (((lnot (tmp145))) land (tmp245)),((tmp146) land ((lnot (tmp246)))) lor (((lnot (tmp146))) land (tmp246)),((tmp147) land ((lnot (tmp247)))) lor (((lnot (tmp147))) land (tmp247)),((tmp148) land ((lnot (tmp248)))) lor (((lnot (tmp148))) land (tmp248))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp31,tmp32,tmp33,tmp34,tmp35,tmp36,tmp37,tmp38,tmp39,tmp310,tmp311,tmp312,tmp313,tmp314,tmp315,tmp316,tmp317,tmp318,tmp319,tmp320,tmp321,tmp322,tmp323,tmp324,tmp325,tmp326,tmp327,tmp328,tmp329,tmp330,tmp331,tmp332) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp41,tmp42,tmp43,tmp44,tmp45,tmp46,tmp47,tmp48,tmp49,tmp410,tmp411,tmp412,tmp413,tmp414,tmp415,tmp416,tmp417,tmp418,tmp419,tmp420,tmp421,tmp422,tmp423,tmp424,tmp425,tmp426,tmp427,tmp428,tmp429,tmp430,tmp431,tmp432) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp31) land ((lnot (tmp41)))) lor (((lnot (tmp31))) land (tmp41)),((tmp32) land ((lnot (tmp42)))) lor (((lnot (tmp32))) land (tmp42)),((tmp33) land ((lnot (tmp43)))) lor (((lnot (tmp33))) land (tmp43)),((tmp34) land ((lnot (tmp44)))) lor (((lnot (tmp34))) land (tmp44)),((tmp35) land ((lnot (tmp45)))) lor (((lnot (tmp35))) land (tmp45)),((tmp36) land ((lnot (tmp46)))) lor (((lnot (tmp36))) land (tmp46)),((tmp37) land ((lnot (tmp47)))) lor (((lnot (tmp37))) land (tmp47)),((tmp38) land ((lnot (tmp48)))) lor (((lnot (tmp38))) land (tmp48)),((tmp39) land ((lnot (tmp49)))) lor (((lnot (tmp39))) land (tmp49)),((tmp310) land ((lnot (tmp410)))) lor (((lnot (tmp310))) land (tmp410)),((tmp311) land ((lnot (tmp411)))) lor (((lnot (tmp311))) land (tmp411)),((tmp312) land ((lnot (tmp412)))) lor (((lnot (tmp312))) land (tmp412)),((tmp313) land ((lnot (tmp413)))) lor (((lnot (tmp313))) land (tmp413)),((tmp314) land ((lnot (tmp414)))) lor (((lnot (tmp314))) land (tmp414)),((tmp315) land ((lnot (tmp415)))) lor (((lnot (tmp315))) land (tmp415)),((tmp316) land ((lnot (tmp416)))) lor (((lnot (tmp316))) land (tmp416)),((tmp317) land ((lnot (tmp417)))) lor (((lnot (tmp317))) land (tmp417)),((tmp318) land ((lnot (tmp418)))) lor (((lnot (tmp318))) land (tmp418)),((tmp319) land ((lnot (tmp419)))) lor (((lnot (tmp319))) land (tmp419)),((tmp320) land ((lnot (tmp420)))) lor (((lnot (tmp320))) land (tmp420)),((tmp321) land ((lnot (tmp421)))) lor (((lnot (tmp321))) land (tmp421)),((tmp322) land ((lnot (tmp422)))) lor (((lnot (tmp322))) land (tmp422)),((tmp323) land ((lnot (tmp423)))) lor (((lnot (tmp323))) land (tmp423)),((tmp324) land ((lnot (tmp424)))) lor (((lnot (tmp324))) land (tmp424)),((tmp325) land ((lnot (tmp425)))) lor (((lnot (tmp325))) land (tmp425)),((tmp326) land ((lnot (tmp426)))) lor (((lnot (tmp326))) land (tmp426)),((tmp327) land ((lnot (tmp427)))) lor (((lnot (tmp327))) land (tmp427)),((tmp328) land ((lnot (tmp428)))) lor (((lnot (tmp328))) land (tmp428)),((tmp329) land ((lnot (tmp429)))) lor (((lnot (tmp329))) land (tmp429)),((tmp330) land ((lnot (tmp430)))) lor (((lnot (tmp330))) land (tmp430)),((tmp331) land ((lnot (tmp431)))) lor (((lnot (tmp331))) land (tmp431)),((tmp332) land ((lnot (tmp432)))) lor (((lnot (tmp332))) land (tmp432))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single2_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp51,tmp52,tmp53,tmp54,tmp55,tmp56,tmp57,tmp58,tmp59,tmp510,tmp511,tmp512,tmp513,tmp514,tmp515,tmp516,tmp517,tmp518,tmp519,tmp520,tmp521,tmp522,tmp523,tmp524,tmp525,tmp526,tmp527,tmp528,tmp529,tmp530,tmp531,tmp532,tmp533,tmp534,tmp535,tmp536,tmp537,tmp538,tmp539,tmp540,tmp541,tmp542,tmp543,tmp544,tmp545,tmp546,tmp547,tmp548) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp61,tmp62,tmp63,tmp64,tmp65,tmp66,tmp67,tmp68,tmp69,tmp610,tmp611,tmp612,tmp613,tmp614,tmp615,tmp616,tmp617,tmp618,tmp619,tmp620,tmp621,tmp622,tmp623,tmp624,tmp625,tmp626,tmp627,tmp628,tmp629,tmp630,tmp631,tmp632,tmp633,tmp634,tmp635,tmp636,tmp637,tmp638,tmp639,tmp640,tmp641,tmp642,tmp643,tmp644,tmp645,tmp646,tmp647,tmp648) = roundkey2_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp51) land ((lnot (tmp61)))) lor (((lnot (tmp51))) land (tmp61)),((tmp52) land ((lnot (tmp62)))) lor (((lnot (tmp52))) land (tmp62)),((tmp53) land ((lnot (tmp63)))) lor (((lnot (tmp53))) land (tmp63)),((tmp54) land ((lnot (tmp64)))) lor (((lnot (tmp54))) land (tmp64)),((tmp55) land ((lnot (tmp65)))) lor (((lnot (tmp55))) land (tmp65)),((tmp56) land ((lnot (tmp66)))) lor (((lnot (tmp56))) land (tmp66)),((tmp57) land ((lnot (tmp67)))) lor (((lnot (tmp57))) land (tmp67)),((tmp58) land ((lnot (tmp68)))) lor (((lnot (tmp58))) land (tmp68)),((tmp59) land ((lnot (tmp69)))) lor (((lnot (tmp59))) land (tmp69)),((tmp510) land ((lnot (tmp610)))) lor (((lnot (tmp510))) land (tmp610)),((tmp511) land ((lnot (tmp611)))) lor (((lnot (tmp511))) land (tmp611)),((tmp512) land ((lnot (tmp612)))) lor (((lnot (tmp512))) land (tmp612)),((tmp513) land ((lnot (tmp613)))) lor (((lnot (tmp513))) land (tmp613)),((tmp514) land ((lnot (tmp614)))) lor (((lnot (tmp514))) land (tmp614)),((tmp515) land ((lnot (tmp615)))) lor (((lnot (tmp515))) land (tmp615)),((tmp516) land ((lnot (tmp616)))) lor (((lnot (tmp516))) land (tmp616)),((tmp517) land ((lnot (tmp617)))) lor (((lnot (tmp517))) land (tmp617)),((tmp518) land ((lnot (tmp618)))) lor (((lnot (tmp518))) land (tmp618)),((tmp519) land ((lnot (tmp619)))) lor (((lnot (tmp519))) land (tmp619)),((tmp520) land ((lnot (tmp620)))) lor (((lnot (tmp520))) land (tmp620)),((tmp521) land ((lnot (tmp621)))) lor (((lnot (tmp521))) land (tmp621)),((tmp522) land ((lnot (tmp622)))) lor (((lnot (tmp522))) land (tmp622)),((tmp523) land ((lnot (tmp623)))) lor (((lnot (tmp523))) land (tmp623)),((tmp524) land ((lnot (tmp624)))) lor (((lnot (tmp524))) land (tmp624)),((tmp525) land ((lnot (tmp625)))) lor (((lnot (tmp525))) land (tmp625)),((tmp526) land ((lnot (tmp626)))) lor (((lnot (tmp526))) land (tmp626)),((tmp527) land ((lnot (tmp627)))) lor (((lnot (tmp527))) land (tmp627)),((tmp528) land ((lnot (tmp628)))) lor (((lnot (tmp528))) land (tmp628)),((tmp529) land ((lnot (tmp629)))) lor (((lnot (tmp529))) land (tmp629)),((tmp530) land ((lnot (tmp630)))) lor (((lnot (tmp530))) land (tmp630)),((tmp531) land ((lnot (tmp631)))) lor (((lnot (tmp531))) land (tmp631)),((tmp532) land ((lnot (tmp632)))) lor (((lnot (tmp532))) land (tmp632)),((tmp533) land ((lnot (tmp633)))) lor (((lnot (tmp533))) land (tmp633)),((tmp534) land ((lnot (tmp634)))) lor (((lnot (tmp534))) land (tmp634)),((tmp535) land ((lnot (tmp635)))) lor (((lnot (tmp535))) land (tmp635)),((tmp536) land ((lnot (tmp636)))) lor (((lnot (tmp536))) land (tmp636)),((tmp537) land ((lnot (tmp637)))) lor (((lnot (tmp537))) land (tmp637)),((tmp538) land ((lnot (tmp638)))) lor (((lnot (tmp538))) land (tmp638)),((tmp539) land ((lnot (tmp639)))) lor (((lnot (tmp539))) land (tmp639)),((tmp540) land ((lnot (tmp640)))) lor (((lnot (tmp540))) land (tmp640)),((tmp541) land ((lnot (tmp641)))) lor (((lnot (tmp541))) land (tmp641)),((tmp542) land ((lnot (tmp642)))) lor (((lnot (tmp542))) land (tmp642)),((tmp543) land ((lnot (tmp643)))) lor (((lnot (tmp543))) land (tmp643)),((tmp544) land ((lnot (tmp644)))) lor (((lnot (tmp544))) land (tmp644)),((tmp545) land ((lnot (tmp645)))) lor (((lnot (tmp545))) land (tmp645)),((tmp546) land ((lnot (tmp646)))) lor (((lnot (tmp546))) land (tmp646)),((tmp547) land ((lnot (tmp647)))) lor (((lnot (tmp547))) land (tmp647)),((tmp548) land ((lnot (tmp648)))) lor (((lnot (tmp548))) land (tmp648))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp71,tmp72,tmp73,tmp74,tmp75,tmp76,tmp77,tmp78,tmp79,tmp710,tmp711,tmp712,tmp713,tmp714,tmp715,tmp716,tmp717,tmp718,tmp719,tmp720,tmp721,tmp722,tmp723,tmp724,tmp725,tmp726,tmp727,tmp728,tmp729,tmp730,tmp731,tmp732) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp81,tmp82,tmp83,tmp84,tmp85,tmp86,tmp87,tmp88,tmp89,tmp810,tmp811,tmp812,tmp813,tmp814,tmp815,tmp816,tmp817,tmp818,tmp819,tmp820,tmp821,tmp822,tmp823,tmp824,tmp825,tmp826,tmp827,tmp828,tmp829,tmp830,tmp831,tmp832) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp71) land ((lnot (tmp81)))) lor (((lnot (tmp71))) land (tmp81)),((tmp72) land ((lnot (tmp82)))) lor (((lnot (tmp72))) land (tmp82)),((tmp73) land ((lnot (tmp83)))) lor (((lnot (tmp73))) land (tmp83)),((tmp74) land ((lnot (tmp84)))) lor (((lnot (tmp74))) land (tmp84)),((tmp75) land ((lnot (tmp85)))) lor (((lnot (tmp75))) land (tmp85)),((tmp76) land ((lnot (tmp86)))) lor (((lnot (tmp76))) land (tmp86)),((tmp77) land ((lnot (tmp87)))) lor (((lnot (tmp77))) land (tmp87)),((tmp78) land ((lnot (tmp88)))) lor (((lnot (tmp78))) land (tmp88)),((tmp79) land ((lnot (tmp89)))) lor (((lnot (tmp79))) land (tmp89)),((tmp710) land ((lnot (tmp810)))) lor (((lnot (tmp710))) land (tmp810)),((tmp711) land ((lnot (tmp811)))) lor (((lnot (tmp711))) land (tmp811)),((tmp712) land ((lnot (tmp812)))) lor (((lnot (tmp712))) land (tmp812)),((tmp713) land ((lnot (tmp813)))) lor (((lnot (tmp713))) land (tmp813)),((tmp714) land ((lnot (tmp814)))) lor (((lnot (tmp714))) land (tmp814)),((tmp715) land ((lnot (tmp815)))) lor (((lnot (tmp715))) land (tmp815)),((tmp716) land ((lnot (tmp816)))) lor (((lnot (tmp716))) land (tmp816)),((tmp717) land ((lnot (tmp817)))) lor (((lnot (tmp717))) land (tmp817)),((tmp718) land ((lnot (tmp818)))) lor (((lnot (tmp718))) land (tmp818)),((tmp719) land ((lnot (tmp819)))) lor (((lnot (tmp719))) land (tmp819)),((tmp720) land ((lnot (tmp820)))) lor (((lnot (tmp720))) land (tmp820)),((tmp721) land ((lnot (tmp821)))) lor (((lnot (tmp721))) land (tmp821)),((tmp722) land ((lnot (tmp822)))) lor (((lnot (tmp722))) land (tmp822)),((tmp723) land ((lnot (tmp823)))) lor (((lnot (tmp723))) land (tmp823)),((tmp724) land ((lnot (tmp824)))) lor (((lnot (tmp724))) land (tmp824)),((tmp725) land ((lnot (tmp825)))) lor (((lnot (tmp725))) land (tmp825)),((tmp726) land ((lnot (tmp826)))) lor (((lnot (tmp726))) land (tmp826)),((tmp727) land ((lnot (tmp827)))) lor (((lnot (tmp727))) land (tmp827)),((tmp728) land ((lnot (tmp828)))) lor (((lnot (tmp728))) land (tmp828)),((tmp729) land ((lnot (tmp829)))) lor (((lnot (tmp729))) land (tmp829)),((tmp730) land ((lnot (tmp830)))) lor (((lnot (tmp730))) land (tmp830)),((tmp731) land ((lnot (tmp831)))) lor (((lnot (tmp731))) land (tmp831)),((tmp732) land ((lnot (tmp832)))) lor (((lnot (tmp732))) land (tmp832))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single3_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp91,tmp92,tmp93,tmp94,tmp95,tmp96,tmp97,tmp98,tmp99,tmp910,tmp911,tmp912,tmp913,tmp914,tmp915,tmp916,tmp917,tmp918,tmp919,tmp920,tmp921,tmp922,tmp923,tmp924,tmp925,tmp926,tmp927,tmp928,tmp929,tmp930,tmp931,tmp932,tmp933,tmp934,tmp935,tmp936,tmp937,tmp938,tmp939,tmp940,tmp941,tmp942,tmp943,tmp944,tmp945,tmp946,tmp947,tmp948) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp101,tmp102,tmp103,tmp104,tmp105,tmp106,tmp107,tmp108,tmp109,tmp1010,tmp1011,tmp1012,tmp1013,tmp1014,tmp1015,tmp1016,tmp1017,tmp1018,tmp1019,tmp1020,tmp1021,tmp1022,tmp1023,tmp1024,tmp1025,tmp1026,tmp1027,tmp1028,tmp1029,tmp1030,tmp1031,tmp1032,tmp1033,tmp1034,tmp1035,tmp1036,tmp1037,tmp1038,tmp1039,tmp1040,tmp1041,tmp1042,tmp1043,tmp1044,tmp1045,tmp1046,tmp1047,tmp1048) = roundkey3_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp91) land ((lnot (tmp101)))) lor (((lnot (tmp91))) land (tmp101)),((tmp92) land ((lnot (tmp102)))) lor (((lnot (tmp92))) land (tmp102)),((tmp93) land ((lnot (tmp103)))) lor (((lnot (tmp93))) land (tmp103)),((tmp94) land ((lnot (tmp104)))) lor (((lnot (tmp94))) land (tmp104)),((tmp95) land ((lnot (tmp105)))) lor (((lnot (tmp95))) land (tmp105)),((tmp96) land ((lnot (tmp106)))) lor (((lnot (tmp96))) land (tmp106)),((tmp97) land ((lnot (tmp107)))) lor (((lnot (tmp97))) land (tmp107)),((tmp98) land ((lnot (tmp108)))) lor (((lnot (tmp98))) land (tmp108)),((tmp99) land ((lnot (tmp109)))) lor (((lnot (tmp99))) land (tmp109)),((tmp910) land ((lnot (tmp1010)))) lor (((lnot (tmp910))) land (tmp1010)),((tmp911) land ((lnot (tmp1011)))) lor (((lnot (tmp911))) land (tmp1011)),((tmp912) land ((lnot (tmp1012)))) lor (((lnot (tmp912))) land (tmp1012)),((tmp913) land ((lnot (tmp1013)))) lor (((lnot (tmp913))) land (tmp1013)),((tmp914) land ((lnot (tmp1014)))) lor (((lnot (tmp914))) land (tmp1014)),((tmp915) land ((lnot (tmp1015)))) lor (((lnot (tmp915))) land (tmp1015)),((tmp916) land ((lnot (tmp1016)))) lor (((lnot (tmp916))) land (tmp1016)),((tmp917) land ((lnot (tmp1017)))) lor (((lnot (tmp917))) land (tmp1017)),((tmp918) land ((lnot (tmp1018)))) lor (((lnot (tmp918))) land (tmp1018)),((tmp919) land ((lnot (tmp1019)))) lor (((lnot (tmp919))) land (tmp1019)),((tmp920) land ((lnot (tmp1020)))) lor (((lnot (tmp920))) land (tmp1020)),((tmp921) land ((lnot (tmp1021)))) lor (((lnot (tmp921))) land (tmp1021)),((tmp922) land ((lnot (tmp1022)))) lor (((lnot (tmp922))) land (tmp1022)),((tmp923) land ((lnot (tmp1023)))) lor (((lnot (tmp923))) land (tmp1023)),((tmp924) land ((lnot (tmp1024)))) lor (((lnot (tmp924))) land (tmp1024)),((tmp925) land ((lnot (tmp1025)))) lor (((lnot (tmp925))) land (tmp1025)),((tmp926) land ((lnot (tmp1026)))) lor (((lnot (tmp926))) land (tmp1026)),((tmp927) land ((lnot (tmp1027)))) lor (((lnot (tmp927))) land (tmp1027)),((tmp928) land ((lnot (tmp1028)))) lor (((lnot (tmp928))) land (tmp1028)),((tmp929) land ((lnot (tmp1029)))) lor (((lnot (tmp929))) land (tmp1029)),((tmp930) land ((lnot (tmp1030)))) lor (((lnot (tmp930))) land (tmp1030)),((tmp931) land ((lnot (tmp1031)))) lor (((lnot (tmp931))) land (tmp1031)),((tmp932) land ((lnot (tmp1032)))) lor (((lnot (tmp932))) land (tmp1032)),((tmp933) land ((lnot (tmp1033)))) lor (((lnot (tmp933))) land (tmp1033)),((tmp934) land ((lnot (tmp1034)))) lor (((lnot (tmp934))) land (tmp1034)),((tmp935) land ((lnot (tmp1035)))) lor (((lnot (tmp935))) land (tmp1035)),((tmp936) land ((lnot (tmp1036)))) lor (((lnot (tmp936))) land (tmp1036)),((tmp937) land ((lnot (tmp1037)))) lor (((lnot (tmp937))) land (tmp1037)),((tmp938) land ((lnot (tmp1038)))) lor (((lnot (tmp938))) land (tmp1038)),((tmp939) land ((lnot (tmp1039)))) lor (((lnot (tmp939))) land (tmp1039)),((tmp940) land ((lnot (tmp1040)))) lor (((lnot (tmp940))) land (tmp1040)),((tmp941) land ((lnot (tmp1041)))) lor (((lnot (tmp941))) land (tmp1041)),((tmp942) land ((lnot (tmp1042)))) lor (((lnot (tmp942))) land (tmp1042)),((tmp943) land ((lnot (tmp1043)))) lor (((lnot (tmp943))) land (tmp1043)),((tmp944) land ((lnot (tmp1044)))) lor (((lnot (tmp944))) land (tmp1044)),((tmp945) land ((lnot (tmp1045)))) lor (((lnot (tmp945))) land (tmp1045)),((tmp946) land ((lnot (tmp1046)))) lor (((lnot (tmp946))) land (tmp1046)),((tmp947) land ((lnot (tmp1047)))) lor (((lnot (tmp947))) land (tmp1047)),((tmp948) land ((lnot (tmp1048)))) lor (((lnot (tmp948))) land (tmp1048))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp111,tmp112,tmp113,tmp114,tmp115,tmp116,tmp117,tmp118,tmp119,tmp1110,tmp1111,tmp1112,tmp1113,tmp1114,tmp1115,tmp1116,tmp1117,tmp1118,tmp1119,tmp1120,tmp1121,tmp1122,tmp1123,tmp1124,tmp1125,tmp1126,tmp1127,tmp1128,tmp1129,tmp1130,tmp1131,tmp1132) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp121,tmp122,tmp123,tmp124,tmp125,tmp126,tmp127,tmp128,tmp129,tmp1210,tmp1211,tmp1212,tmp1213,tmp1214,tmp1215,tmp1216,tmp1217,tmp1218,tmp1219,tmp1220,tmp1221,tmp1222,tmp1223,tmp1224,tmp1225,tmp1226,tmp1227,tmp1228,tmp1229,tmp1230,tmp1231,tmp1232) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp111) land ((lnot (tmp121)))) lor (((lnot (tmp111))) land (tmp121)),((tmp112) land ((lnot (tmp122)))) lor (((lnot (tmp112))) land (tmp122)),((tmp113) land ((lnot (tmp123)))) lor (((lnot (tmp113))) land (tmp123)),((tmp114) land ((lnot (tmp124)))) lor (((lnot (tmp114))) land (tmp124)),((tmp115) land ((lnot (tmp125)))) lor (((lnot (tmp115))) land (tmp125)),((tmp116) land ((lnot (tmp126)))) lor (((lnot (tmp116))) land (tmp126)),((tmp117) land ((lnot (tmp127)))) lor (((lnot (tmp117))) land (tmp127)),((tmp118) land ((lnot (tmp128)))) lor (((lnot (tmp118))) land (tmp128)),((tmp119) land ((lnot (tmp129)))) lor (((lnot (tmp119))) land (tmp129)),((tmp1110) land ((lnot (tmp1210)))) lor (((lnot (tmp1110))) land (tmp1210)),((tmp1111) land ((lnot (tmp1211)))) lor (((lnot (tmp1111))) land (tmp1211)),((tmp1112) land ((lnot (tmp1212)))) lor (((lnot (tmp1112))) land (tmp1212)),((tmp1113) land ((lnot (tmp1213)))) lor (((lnot (tmp1113))) land (tmp1213)),((tmp1114) land ((lnot (tmp1214)))) lor (((lnot (tmp1114))) land (tmp1214)),((tmp1115) land ((lnot (tmp1215)))) lor (((lnot (tmp1115))) land (tmp1215)),((tmp1116) land ((lnot (tmp1216)))) lor (((lnot (tmp1116))) land (tmp1216)),((tmp1117) land ((lnot (tmp1217)))) lor (((lnot (tmp1117))) land (tmp1217)),((tmp1118) land ((lnot (tmp1218)))) lor (((lnot (tmp1118))) land (tmp1218)),((tmp1119) land ((lnot (tmp1219)))) lor (((lnot (tmp1119))) land (tmp1219)),((tmp1120) land ((lnot (tmp1220)))) lor (((lnot (tmp1120))) land (tmp1220)),((tmp1121) land ((lnot (tmp1221)))) lor (((lnot (tmp1121))) land (tmp1221)),((tmp1122) land ((lnot (tmp1222)))) lor (((lnot (tmp1122))) land (tmp1222)),((tmp1123) land ((lnot (tmp1223)))) lor (((lnot (tmp1123))) land (tmp1223)),((tmp1124) land ((lnot (tmp1224)))) lor (((lnot (tmp1124))) land (tmp1224)),((tmp1125) land ((lnot (tmp1225)))) lor (((lnot (tmp1125))) land (tmp1225)),((tmp1126) land ((lnot (tmp1226)))) lor (((lnot (tmp1126))) land (tmp1226)),((tmp1127) land ((lnot (tmp1227)))) lor (((lnot (tmp1127))) land (tmp1227)),((tmp1128) land ((lnot (tmp1228)))) lor (((lnot (tmp1128))) land (tmp1228)),((tmp1129) land ((lnot (tmp1229)))) lor (((lnot (tmp1129))) land (tmp1229)),((tmp1130) land ((lnot (tmp1230)))) lor (((lnot (tmp1130))) land (tmp1230)),((tmp1131) land ((lnot (tmp1231)))) lor (((lnot (tmp1131))) land (tmp1231)),((tmp1132) land ((lnot (tmp1232)))) lor (((lnot (tmp1132))) land (tmp1232))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single4_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp131,tmp132,tmp133,tmp134,tmp135,tmp136,tmp137,tmp138,tmp139,tmp1310,tmp1311,tmp1312,tmp1313,tmp1314,tmp1315,tmp1316,tmp1317,tmp1318,tmp1319,tmp1320,tmp1321,tmp1322,tmp1323,tmp1324,tmp1325,tmp1326,tmp1327,tmp1328,tmp1329,tmp1330,tmp1331,tmp1332,tmp1333,tmp1334,tmp1335,tmp1336,tmp1337,tmp1338,tmp1339,tmp1340,tmp1341,tmp1342,tmp1343,tmp1344,tmp1345,tmp1346,tmp1347,tmp1348) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp141,tmp142,tmp143,tmp144,tmp145,tmp146,tmp147,tmp148,tmp149,tmp1410,tmp1411,tmp1412,tmp1413,tmp1414,tmp1415,tmp1416,tmp1417,tmp1418,tmp1419,tmp1420,tmp1421,tmp1422,tmp1423,tmp1424,tmp1425,tmp1426,tmp1427,tmp1428,tmp1429,tmp1430,tmp1431,tmp1432,tmp1433,tmp1434,tmp1435,tmp1436,tmp1437,tmp1438,tmp1439,tmp1440,tmp1441,tmp1442,tmp1443,tmp1444,tmp1445,tmp1446,tmp1447,tmp1448) = roundkey4_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp131) land ((lnot (tmp141)))) lor (((lnot (tmp131))) land (tmp141)),((tmp132) land ((lnot (tmp142)))) lor (((lnot (tmp132))) land (tmp142)),((tmp133) land ((lnot (tmp143)))) lor (((lnot (tmp133))) land (tmp143)),((tmp134) land ((lnot (tmp144)))) lor (((lnot (tmp134))) land (tmp144)),((tmp135) land ((lnot (tmp145)))) lor (((lnot (tmp135))) land (tmp145)),((tmp136) land ((lnot (tmp146)))) lor (((lnot (tmp136))) land (tmp146)),((tmp137) land ((lnot (tmp147)))) lor (((lnot (tmp137))) land (tmp147)),((tmp138) land ((lnot (tmp148)))) lor (((lnot (tmp138))) land (tmp148)),((tmp139) land ((lnot (tmp149)))) lor (((lnot (tmp139))) land (tmp149)),((tmp1310) land ((lnot (tmp1410)))) lor (((lnot (tmp1310))) land (tmp1410)),((tmp1311) land ((lnot (tmp1411)))) lor (((lnot (tmp1311))) land (tmp1411)),((tmp1312) land ((lnot (tmp1412)))) lor (((lnot (tmp1312))) land (tmp1412)),((tmp1313) land ((lnot (tmp1413)))) lor (((lnot (tmp1313))) land (tmp1413)),((tmp1314) land ((lnot (tmp1414)))) lor (((lnot (tmp1314))) land (tmp1414)),((tmp1315) land ((lnot (tmp1415)))) lor (((lnot (tmp1315))) land (tmp1415)),((tmp1316) land ((lnot (tmp1416)))) lor (((lnot (tmp1316))) land (tmp1416)),((tmp1317) land ((lnot (tmp1417)))) lor (((lnot (tmp1317))) land (tmp1417)),((tmp1318) land ((lnot (tmp1418)))) lor (((lnot (tmp1318))) land (tmp1418)),((tmp1319) land ((lnot (tmp1419)))) lor (((lnot (tmp1319))) land (tmp1419)),((tmp1320) land ((lnot (tmp1420)))) lor (((lnot (tmp1320))) land (tmp1420)),((tmp1321) land ((lnot (tmp1421)))) lor (((lnot (tmp1321))) land (tmp1421)),((tmp1322) land ((lnot (tmp1422)))) lor (((lnot (tmp1322))) land (tmp1422)),((tmp1323) land ((lnot (tmp1423)))) lor (((lnot (tmp1323))) land (tmp1423)),((tmp1324) land ((lnot (tmp1424)))) lor (((lnot (tmp1324))) land (tmp1424)),((tmp1325) land ((lnot (tmp1425)))) lor (((lnot (tmp1325))) land (tmp1425)),((tmp1326) land ((lnot (tmp1426)))) lor (((lnot (tmp1326))) land (tmp1426)),((tmp1327) land ((lnot (tmp1427)))) lor (((lnot (tmp1327))) land (tmp1427)),((tmp1328) land ((lnot (tmp1428)))) lor (((lnot (tmp1328))) land (tmp1428)),((tmp1329) land ((lnot (tmp1429)))) lor (((lnot (tmp1329))) land (tmp1429)),((tmp1330) land ((lnot (tmp1430)))) lor (((lnot (tmp1330))) land (tmp1430)),((tmp1331) land ((lnot (tmp1431)))) lor (((lnot (tmp1331))) land (tmp1431)),((tmp1332) land ((lnot (tmp1432)))) lor (((lnot (tmp1332))) land (tmp1432)),((tmp1333) land ((lnot (tmp1433)))) lor (((lnot (tmp1333))) land (tmp1433)),((tmp1334) land ((lnot (tmp1434)))) lor (((lnot (tmp1334))) land (tmp1434)),((tmp1335) land ((lnot (tmp1435)))) lor (((lnot (tmp1335))) land (tmp1435)),((tmp1336) land ((lnot (tmp1436)))) lor (((lnot (tmp1336))) land (tmp1436)),((tmp1337) land ((lnot (tmp1437)))) lor (((lnot (tmp1337))) land (tmp1437)),((tmp1338) land ((lnot (tmp1438)))) lor (((lnot (tmp1338))) land (tmp1438)),((tmp1339) land ((lnot (tmp1439)))) lor (((lnot (tmp1339))) land (tmp1439)),((tmp1340) land ((lnot (tmp1440)))) lor (((lnot (tmp1340))) land (tmp1440)),((tmp1341) land ((lnot (tmp1441)))) lor (((lnot (tmp1341))) land (tmp1441)),((tmp1342) land ((lnot (tmp1442)))) lor (((lnot (tmp1342))) land (tmp1442)),((tmp1343) land ((lnot (tmp1443)))) lor (((lnot (tmp1343))) land (tmp1443)),((tmp1344) land ((lnot (tmp1444)))) lor (((lnot (tmp1344))) land (tmp1444)),((tmp1345) land ((lnot (tmp1445)))) lor (((lnot (tmp1345))) land (tmp1445)),((tmp1346) land ((lnot (tmp1446)))) lor (((lnot (tmp1346))) land (tmp1446)),((tmp1347) land ((lnot (tmp1447)))) lor (((lnot (tmp1347))) land (tmp1447)),((tmp1348) land ((lnot (tmp1448)))) lor (((lnot (tmp1348))) land (tmp1448))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp151,tmp152,tmp153,tmp154,tmp155,tmp156,tmp157,tmp158,tmp159,tmp1510,tmp1511,tmp1512,tmp1513,tmp1514,tmp1515,tmp1516,tmp1517,tmp1518,tmp1519,tmp1520,tmp1521,tmp1522,tmp1523,tmp1524,tmp1525,tmp1526,tmp1527,tmp1528,tmp1529,tmp1530,tmp1531,tmp1532) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp161,tmp162,tmp163,tmp164,tmp165,tmp166,tmp167,tmp168,tmp169,tmp1610,tmp1611,tmp1612,tmp1613,tmp1614,tmp1615,tmp1616,tmp1617,tmp1618,tmp1619,tmp1620,tmp1621,tmp1622,tmp1623,tmp1624,tmp1625,tmp1626,tmp1627,tmp1628,tmp1629,tmp1630,tmp1631,tmp1632) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp151) land ((lnot (tmp161)))) lor (((lnot (tmp151))) land (tmp161)),((tmp152) land ((lnot (tmp162)))) lor (((lnot (tmp152))) land (tmp162)),((tmp153) land ((lnot (tmp163)))) lor (((lnot (tmp153))) land (tmp163)),((tmp154) land ((lnot (tmp164)))) lor (((lnot (tmp154))) land (tmp164)),((tmp155) land ((lnot (tmp165)))) lor (((lnot (tmp155))) land (tmp165)),((tmp156) land ((lnot (tmp166)))) lor (((lnot (tmp156))) land (tmp166)),((tmp157) land ((lnot (tmp167)))) lor (((lnot (tmp157))) land (tmp167)),((tmp158) land ((lnot (tmp168)))) lor (((lnot (tmp158))) land (tmp168)),((tmp159) land ((lnot (tmp169)))) lor (((lnot (tmp159))) land (tmp169)),((tmp1510) land ((lnot (tmp1610)))) lor (((lnot (tmp1510))) land (tmp1610)),((tmp1511) land ((lnot (tmp1611)))) lor (((lnot (tmp1511))) land (tmp1611)),((tmp1512) land ((lnot (tmp1612)))) lor (((lnot (tmp1512))) land (tmp1612)),((tmp1513) land ((lnot (tmp1613)))) lor (((lnot (tmp1513))) land (tmp1613)),((tmp1514) land ((lnot (tmp1614)))) lor (((lnot (tmp1514))) land (tmp1614)),((tmp1515) land ((lnot (tmp1615)))) lor (((lnot (tmp1515))) land (tmp1615)),((tmp1516) land ((lnot (tmp1616)))) lor (((lnot (tmp1516))) land (tmp1616)),((tmp1517) land ((lnot (tmp1617)))) lor (((lnot (tmp1517))) land (tmp1617)),((tmp1518) land ((lnot (tmp1618)))) lor (((lnot (tmp1518))) land (tmp1618)),((tmp1519) land ((lnot (tmp1619)))) lor (((lnot (tmp1519))) land (tmp1619)),((tmp1520) land ((lnot (tmp1620)))) lor (((lnot (tmp1520))) land (tmp1620)),((tmp1521) land ((lnot (tmp1621)))) lor (((lnot (tmp1521))) land (tmp1621)),((tmp1522) land ((lnot (tmp1622)))) lor (((lnot (tmp1522))) land (tmp1622)),((tmp1523) land ((lnot (tmp1623)))) lor (((lnot (tmp1523))) land (tmp1623)),((tmp1524) land ((lnot (tmp1624)))) lor (((lnot (tmp1524))) land (tmp1624)),((tmp1525) land ((lnot (tmp1625)))) lor (((lnot (tmp1525))) land (tmp1625)),((tmp1526) land ((lnot (tmp1626)))) lor (((lnot (tmp1526))) land (tmp1626)),((tmp1527) land ((lnot (tmp1627)))) lor (((lnot (tmp1527))) land (tmp1627)),((tmp1528) land ((lnot (tmp1628)))) lor (((lnot (tmp1528))) land (tmp1628)),((tmp1529) land ((lnot (tmp1629)))) lor (((lnot (tmp1529))) land (tmp1629)),((tmp1530) land ((lnot (tmp1630)))) lor (((lnot (tmp1530))) land (tmp1630)),((tmp1531) land ((lnot (tmp1631)))) lor (((lnot (tmp1531))) land (tmp1631)),((tmp1532) land ((lnot (tmp1632)))) lor (((lnot (tmp1532))) land (tmp1632))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single5_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp171,tmp172,tmp173,tmp174,tmp175,tmp176,tmp177,tmp178,tmp179,tmp1710,tmp1711,tmp1712,tmp1713,tmp1714,tmp1715,tmp1716,tmp1717,tmp1718,tmp1719,tmp1720,tmp1721,tmp1722,tmp1723,tmp1724,tmp1725,tmp1726,tmp1727,tmp1728,tmp1729,tmp1730,tmp1731,tmp1732,tmp1733,tmp1734,tmp1735,tmp1736,tmp1737,tmp1738,tmp1739,tmp1740,tmp1741,tmp1742,tmp1743,tmp1744,tmp1745,tmp1746,tmp1747,tmp1748) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp181,tmp182,tmp183,tmp184,tmp185,tmp186,tmp187,tmp188,tmp189,tmp1810,tmp1811,tmp1812,tmp1813,tmp1814,tmp1815,tmp1816,tmp1817,tmp1818,tmp1819,tmp1820,tmp1821,tmp1822,tmp1823,tmp1824,tmp1825,tmp1826,tmp1827,tmp1828,tmp1829,tmp1830,tmp1831,tmp1832,tmp1833,tmp1834,tmp1835,tmp1836,tmp1837,tmp1838,tmp1839,tmp1840,tmp1841,tmp1842,tmp1843,tmp1844,tmp1845,tmp1846,tmp1847,tmp1848) = roundkey5_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp171) land ((lnot (tmp181)))) lor (((lnot (tmp171))) land (tmp181)),((tmp172) land ((lnot (tmp182)))) lor (((lnot (tmp172))) land (tmp182)),((tmp173) land ((lnot (tmp183)))) lor (((lnot (tmp173))) land (tmp183)),((tmp174) land ((lnot (tmp184)))) lor (((lnot (tmp174))) land (tmp184)),((tmp175) land ((lnot (tmp185)))) lor (((lnot (tmp175))) land (tmp185)),((tmp176) land ((lnot (tmp186)))) lor (((lnot (tmp176))) land (tmp186)),((tmp177) land ((lnot (tmp187)))) lor (((lnot (tmp177))) land (tmp187)),((tmp178) land ((lnot (tmp188)))) lor (((lnot (tmp178))) land (tmp188)),((tmp179) land ((lnot (tmp189)))) lor (((lnot (tmp179))) land (tmp189)),((tmp1710) land ((lnot (tmp1810)))) lor (((lnot (tmp1710))) land (tmp1810)),((tmp1711) land ((lnot (tmp1811)))) lor (((lnot (tmp1711))) land (tmp1811)),((tmp1712) land ((lnot (tmp1812)))) lor (((lnot (tmp1712))) land (tmp1812)),((tmp1713) land ((lnot (tmp1813)))) lor (((lnot (tmp1713))) land (tmp1813)),((tmp1714) land ((lnot (tmp1814)))) lor (((lnot (tmp1714))) land (tmp1814)),((tmp1715) land ((lnot (tmp1815)))) lor (((lnot (tmp1715))) land (tmp1815)),((tmp1716) land ((lnot (tmp1816)))) lor (((lnot (tmp1716))) land (tmp1816)),((tmp1717) land ((lnot (tmp1817)))) lor (((lnot (tmp1717))) land (tmp1817)),((tmp1718) land ((lnot (tmp1818)))) lor (((lnot (tmp1718))) land (tmp1818)),((tmp1719) land ((lnot (tmp1819)))) lor (((lnot (tmp1719))) land (tmp1819)),((tmp1720) land ((lnot (tmp1820)))) lor (((lnot (tmp1720))) land (tmp1820)),((tmp1721) land ((lnot (tmp1821)))) lor (((lnot (tmp1721))) land (tmp1821)),((tmp1722) land ((lnot (tmp1822)))) lor (((lnot (tmp1722))) land (tmp1822)),((tmp1723) land ((lnot (tmp1823)))) lor (((lnot (tmp1723))) land (tmp1823)),((tmp1724) land ((lnot (tmp1824)))) lor (((lnot (tmp1724))) land (tmp1824)),((tmp1725) land ((lnot (tmp1825)))) lor (((lnot (tmp1725))) land (tmp1825)),((tmp1726) land ((lnot (tmp1826)))) lor (((lnot (tmp1726))) land (tmp1826)),((tmp1727) land ((lnot (tmp1827)))) lor (((lnot (tmp1727))) land (tmp1827)),((tmp1728) land ((lnot (tmp1828)))) lor (((lnot (tmp1728))) land (tmp1828)),((tmp1729) land ((lnot (tmp1829)))) lor (((lnot (tmp1729))) land (tmp1829)),((tmp1730) land ((lnot (tmp1830)))) lor (((lnot (tmp1730))) land (tmp1830)),((tmp1731) land ((lnot (tmp1831)))) lor (((lnot (tmp1731))) land (tmp1831)),((tmp1732) land ((lnot (tmp1832)))) lor (((lnot (tmp1732))) land (tmp1832)),((tmp1733) land ((lnot (tmp1833)))) lor (((lnot (tmp1733))) land (tmp1833)),((tmp1734) land ((lnot (tmp1834)))) lor (((lnot (tmp1734))) land (tmp1834)),((tmp1735) land ((lnot (tmp1835)))) lor (((lnot (tmp1735))) land (tmp1835)),((tmp1736) land ((lnot (tmp1836)))) lor (((lnot (tmp1736))) land (tmp1836)),((tmp1737) land ((lnot (tmp1837)))) lor (((lnot (tmp1737))) land (tmp1837)),((tmp1738) land ((lnot (tmp1838)))) lor (((lnot (tmp1738))) land (tmp1838)),((tmp1739) land ((lnot (tmp1839)))) lor (((lnot (tmp1739))) land (tmp1839)),((tmp1740) land ((lnot (tmp1840)))) lor (((lnot (tmp1740))) land (tmp1840)),((tmp1741) land ((lnot (tmp1841)))) lor (((lnot (tmp1741))) land (tmp1841)),((tmp1742) land ((lnot (tmp1842)))) lor (((lnot (tmp1742))) land (tmp1842)),((tmp1743) land ((lnot (tmp1843)))) lor (((lnot (tmp1743))) land (tmp1843)),((tmp1744) land ((lnot (tmp1844)))) lor (((lnot (tmp1744))) land (tmp1844)),((tmp1745) land ((lnot (tmp1845)))) lor (((lnot (tmp1745))) land (tmp1845)),((tmp1746) land ((lnot (tmp1846)))) lor (((lnot (tmp1746))) land (tmp1846)),((tmp1747) land ((lnot (tmp1847)))) lor (((lnot (tmp1747))) land (tmp1847)),((tmp1748) land ((lnot (tmp1848)))) lor (((lnot (tmp1748))) land (tmp1848))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp191,tmp192,tmp193,tmp194,tmp195,tmp196,tmp197,tmp198,tmp199,tmp1910,tmp1911,tmp1912,tmp1913,tmp1914,tmp1915,tmp1916,tmp1917,tmp1918,tmp1919,tmp1920,tmp1921,tmp1922,tmp1923,tmp1924,tmp1925,tmp1926,tmp1927,tmp1928,tmp1929,tmp1930,tmp1931,tmp1932) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp201,tmp202,tmp203,tmp204,tmp205,tmp206,tmp207,tmp208,tmp209,tmp2010,tmp2011,tmp2012,tmp2013,tmp2014,tmp2015,tmp2016,tmp2017,tmp2018,tmp2019,tmp2020,tmp2021,tmp2022,tmp2023,tmp2024,tmp2025,tmp2026,tmp2027,tmp2028,tmp2029,tmp2030,tmp2031,tmp2032) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp191) land ((lnot (tmp201)))) lor (((lnot (tmp191))) land (tmp201)),((tmp192) land ((lnot (tmp202)))) lor (((lnot (tmp192))) land (tmp202)),((tmp193) land ((lnot (tmp203)))) lor (((lnot (tmp193))) land (tmp203)),((tmp194) land ((lnot (tmp204)))) lor (((lnot (tmp194))) land (tmp204)),((tmp195) land ((lnot (tmp205)))) lor (((lnot (tmp195))) land (tmp205)),((tmp196) land ((lnot (tmp206)))) lor (((lnot (tmp196))) land (tmp206)),((tmp197) land ((lnot (tmp207)))) lor (((lnot (tmp197))) land (tmp207)),((tmp198) land ((lnot (tmp208)))) lor (((lnot (tmp198))) land (tmp208)),((tmp199) land ((lnot (tmp209)))) lor (((lnot (tmp199))) land (tmp209)),((tmp1910) land ((lnot (tmp2010)))) lor (((lnot (tmp1910))) land (tmp2010)),((tmp1911) land ((lnot (tmp2011)))) lor (((lnot (tmp1911))) land (tmp2011)),((tmp1912) land ((lnot (tmp2012)))) lor (((lnot (tmp1912))) land (tmp2012)),((tmp1913) land ((lnot (tmp2013)))) lor (((lnot (tmp1913))) land (tmp2013)),((tmp1914) land ((lnot (tmp2014)))) lor (((lnot (tmp1914))) land (tmp2014)),((tmp1915) land ((lnot (tmp2015)))) lor (((lnot (tmp1915))) land (tmp2015)),((tmp1916) land ((lnot (tmp2016)))) lor (((lnot (tmp1916))) land (tmp2016)),((tmp1917) land ((lnot (tmp2017)))) lor (((lnot (tmp1917))) land (tmp2017)),((tmp1918) land ((lnot (tmp2018)))) lor (((lnot (tmp1918))) land (tmp2018)),((tmp1919) land ((lnot (tmp2019)))) lor (((lnot (tmp1919))) land (tmp2019)),((tmp1920) land ((lnot (tmp2020)))) lor (((lnot (tmp1920))) land (tmp2020)),((tmp1921) land ((lnot (tmp2021)))) lor (((lnot (tmp1921))) land (tmp2021)),((tmp1922) land ((lnot (tmp2022)))) lor (((lnot (tmp1922))) land (tmp2022)),((tmp1923) land ((lnot (tmp2023)))) lor (((lnot (tmp1923))) land (tmp2023)),((tmp1924) land ((lnot (tmp2024)))) lor (((lnot (tmp1924))) land (tmp2024)),((tmp1925) land ((lnot (tmp2025)))) lor (((lnot (tmp1925))) land (tmp2025)),((tmp1926) land ((lnot (tmp2026)))) lor (((lnot (tmp1926))) land (tmp2026)),((tmp1927) land ((lnot (tmp2027)))) lor (((lnot (tmp1927))) land (tmp2027)),((tmp1928) land ((lnot (tmp2028)))) lor (((lnot (tmp1928))) land (tmp2028)),((tmp1929) land ((lnot (tmp2029)))) lor (((lnot (tmp1929))) land (tmp2029)),((tmp1930) land ((lnot (tmp2030)))) lor (((lnot (tmp1930))) land (tmp2030)),((tmp1931) land ((lnot (tmp2031)))) lor (((lnot (tmp1931))) land (tmp2031)),((tmp1932) land ((lnot (tmp2032)))) lor (((lnot (tmp1932))) land (tmp2032))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single6_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp211,tmp212,tmp213,tmp214,tmp215,tmp216,tmp217,tmp218,tmp219,tmp2110,tmp2111,tmp2112,tmp2113,tmp2114,tmp2115,tmp2116,tmp2117,tmp2118,tmp2119,tmp2120,tmp2121,tmp2122,tmp2123,tmp2124,tmp2125,tmp2126,tmp2127,tmp2128,tmp2129,tmp2130,tmp2131,tmp2132,tmp2133,tmp2134,tmp2135,tmp2136,tmp2137,tmp2138,tmp2139,tmp2140,tmp2141,tmp2142,tmp2143,tmp2144,tmp2145,tmp2146,tmp2147,tmp2148) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp221,tmp222,tmp223,tmp224,tmp225,tmp226,tmp227,tmp228,tmp229,tmp2210,tmp2211,tmp2212,tmp2213,tmp2214,tmp2215,tmp2216,tmp2217,tmp2218,tmp2219,tmp2220,tmp2221,tmp2222,tmp2223,tmp2224,tmp2225,tmp2226,tmp2227,tmp2228,tmp2229,tmp2230,tmp2231,tmp2232,tmp2233,tmp2234,tmp2235,tmp2236,tmp2237,tmp2238,tmp2239,tmp2240,tmp2241,tmp2242,tmp2243,tmp2244,tmp2245,tmp2246,tmp2247,tmp2248) = roundkey6_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp211) land ((lnot (tmp221)))) lor (((lnot (tmp211))) land (tmp221)),((tmp212) land ((lnot (tmp222)))) lor (((lnot (tmp212))) land (tmp222)),((tmp213) land ((lnot (tmp223)))) lor (((lnot (tmp213))) land (tmp223)),((tmp214) land ((lnot (tmp224)))) lor (((lnot (tmp214))) land (tmp224)),((tmp215) land ((lnot (tmp225)))) lor (((lnot (tmp215))) land (tmp225)),((tmp216) land ((lnot (tmp226)))) lor (((lnot (tmp216))) land (tmp226)),((tmp217) land ((lnot (tmp227)))) lor (((lnot (tmp217))) land (tmp227)),((tmp218) land ((lnot (tmp228)))) lor (((lnot (tmp218))) land (tmp228)),((tmp219) land ((lnot (tmp229)))) lor (((lnot (tmp219))) land (tmp229)),((tmp2110) land ((lnot (tmp2210)))) lor (((lnot (tmp2110))) land (tmp2210)),((tmp2111) land ((lnot (tmp2211)))) lor (((lnot (tmp2111))) land (tmp2211)),((tmp2112) land ((lnot (tmp2212)))) lor (((lnot (tmp2112))) land (tmp2212)),((tmp2113) land ((lnot (tmp2213)))) lor (((lnot (tmp2113))) land (tmp2213)),((tmp2114) land ((lnot (tmp2214)))) lor (((lnot (tmp2114))) land (tmp2214)),((tmp2115) land ((lnot (tmp2215)))) lor (((lnot (tmp2115))) land (tmp2215)),((tmp2116) land ((lnot (tmp2216)))) lor (((lnot (tmp2116))) land (tmp2216)),((tmp2117) land ((lnot (tmp2217)))) lor (((lnot (tmp2117))) land (tmp2217)),((tmp2118) land ((lnot (tmp2218)))) lor (((lnot (tmp2118))) land (tmp2218)),((tmp2119) land ((lnot (tmp2219)))) lor (((lnot (tmp2119))) land (tmp2219)),((tmp2120) land ((lnot (tmp2220)))) lor (((lnot (tmp2120))) land (tmp2220)),((tmp2121) land ((lnot (tmp2221)))) lor (((lnot (tmp2121))) land (tmp2221)),((tmp2122) land ((lnot (tmp2222)))) lor (((lnot (tmp2122))) land (tmp2222)),((tmp2123) land ((lnot (tmp2223)))) lor (((lnot (tmp2123))) land (tmp2223)),((tmp2124) land ((lnot (tmp2224)))) lor (((lnot (tmp2124))) land (tmp2224)),((tmp2125) land ((lnot (tmp2225)))) lor (((lnot (tmp2125))) land (tmp2225)),((tmp2126) land ((lnot (tmp2226)))) lor (((lnot (tmp2126))) land (tmp2226)),((tmp2127) land ((lnot (tmp2227)))) lor (((lnot (tmp2127))) land (tmp2227)),((tmp2128) land ((lnot (tmp2228)))) lor (((lnot (tmp2128))) land (tmp2228)),((tmp2129) land ((lnot (tmp2229)))) lor (((lnot (tmp2129))) land (tmp2229)),((tmp2130) land ((lnot (tmp2230)))) lor (((lnot (tmp2130))) land (tmp2230)),((tmp2131) land ((lnot (tmp2231)))) lor (((lnot (tmp2131))) land (tmp2231)),((tmp2132) land ((lnot (tmp2232)))) lor (((lnot (tmp2132))) land (tmp2232)),((tmp2133) land ((lnot (tmp2233)))) lor (((lnot (tmp2133))) land (tmp2233)),((tmp2134) land ((lnot (tmp2234)))) lor (((lnot (tmp2134))) land (tmp2234)),((tmp2135) land ((lnot (tmp2235)))) lor (((lnot (tmp2135))) land (tmp2235)),((tmp2136) land ((lnot (tmp2236)))) lor (((lnot (tmp2136))) land (tmp2236)),((tmp2137) land ((lnot (tmp2237)))) lor (((lnot (tmp2137))) land (tmp2237)),((tmp2138) land ((lnot (tmp2238)))) lor (((lnot (tmp2138))) land (tmp2238)),((tmp2139) land ((lnot (tmp2239)))) lor (((lnot (tmp2139))) land (tmp2239)),((tmp2140) land ((lnot (tmp2240)))) lor (((lnot (tmp2140))) land (tmp2240)),((tmp2141) land ((lnot (tmp2241)))) lor (((lnot (tmp2141))) land (tmp2241)),((tmp2142) land ((lnot (tmp2242)))) lor (((lnot (tmp2142))) land (tmp2242)),((tmp2143) land ((lnot (tmp2243)))) lor (((lnot (tmp2143))) land (tmp2243)),((tmp2144) land ((lnot (tmp2244)))) lor (((lnot (tmp2144))) land (tmp2244)),((tmp2145) land ((lnot (tmp2245)))) lor (((lnot (tmp2145))) land (tmp2245)),((tmp2146) land ((lnot (tmp2246)))) lor (((lnot (tmp2146))) land (tmp2246)),((tmp2147) land ((lnot (tmp2247)))) lor (((lnot (tmp2147))) land (tmp2247)),((tmp2148) land ((lnot (tmp2248)))) lor (((lnot (tmp2148))) land (tmp2248))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp231,tmp232,tmp233,tmp234,tmp235,tmp236,tmp237,tmp238,tmp239,tmp2310,tmp2311,tmp2312,tmp2313,tmp2314,tmp2315,tmp2316,tmp2317,tmp2318,tmp2319,tmp2320,tmp2321,tmp2322,tmp2323,tmp2324,tmp2325,tmp2326,tmp2327,tmp2328,tmp2329,tmp2330,tmp2331,tmp2332) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp241,tmp242,tmp243,tmp244,tmp245,tmp246,tmp247,tmp248,tmp249,tmp2410,tmp2411,tmp2412,tmp2413,tmp2414,tmp2415,tmp2416,tmp2417,tmp2418,tmp2419,tmp2420,tmp2421,tmp2422,tmp2423,tmp2424,tmp2425,tmp2426,tmp2427,tmp2428,tmp2429,tmp2430,tmp2431,tmp2432) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp231) land ((lnot (tmp241)))) lor (((lnot (tmp231))) land (tmp241)),((tmp232) land ((lnot (tmp242)))) lor (((lnot (tmp232))) land (tmp242)),((tmp233) land ((lnot (tmp243)))) lor (((lnot (tmp233))) land (tmp243)),((tmp234) land ((lnot (tmp244)))) lor (((lnot (tmp234))) land (tmp244)),((tmp235) land ((lnot (tmp245)))) lor (((lnot (tmp235))) land (tmp245)),((tmp236) land ((lnot (tmp246)))) lor (((lnot (tmp236))) land (tmp246)),((tmp237) land ((lnot (tmp247)))) lor (((lnot (tmp237))) land (tmp247)),((tmp238) land ((lnot (tmp248)))) lor (((lnot (tmp238))) land (tmp248)),((tmp239) land ((lnot (tmp249)))) lor (((lnot (tmp239))) land (tmp249)),((tmp2310) land ((lnot (tmp2410)))) lor (((lnot (tmp2310))) land (tmp2410)),((tmp2311) land ((lnot (tmp2411)))) lor (((lnot (tmp2311))) land (tmp2411)),((tmp2312) land ((lnot (tmp2412)))) lor (((lnot (tmp2312))) land (tmp2412)),((tmp2313) land ((lnot (tmp2413)))) lor (((lnot (tmp2313))) land (tmp2413)),((tmp2314) land ((lnot (tmp2414)))) lor (((lnot (tmp2314))) land (tmp2414)),((tmp2315) land ((lnot (tmp2415)))) lor (((lnot (tmp2315))) land (tmp2415)),((tmp2316) land ((lnot (tmp2416)))) lor (((lnot (tmp2316))) land (tmp2416)),((tmp2317) land ((lnot (tmp2417)))) lor (((lnot (tmp2317))) land (tmp2417)),((tmp2318) land ((lnot (tmp2418)))) lor (((lnot (tmp2318))) land (tmp2418)),((tmp2319) land ((lnot (tmp2419)))) lor (((lnot (tmp2319))) land (tmp2419)),((tmp2320) land ((lnot (tmp2420)))) lor (((lnot (tmp2320))) land (tmp2420)),((tmp2321) land ((lnot (tmp2421)))) lor (((lnot (tmp2321))) land (tmp2421)),((tmp2322) land ((lnot (tmp2422)))) lor (((lnot (tmp2322))) land (tmp2422)),((tmp2323) land ((lnot (tmp2423)))) lor (((lnot (tmp2323))) land (tmp2423)),((tmp2324) land ((lnot (tmp2424)))) lor (((lnot (tmp2324))) land (tmp2424)),((tmp2325) land ((lnot (tmp2425)))) lor (((lnot (tmp2325))) land (tmp2425)),((tmp2326) land ((lnot (tmp2426)))) lor (((lnot (tmp2326))) land (tmp2426)),((tmp2327) land ((lnot (tmp2427)))) lor (((lnot (tmp2327))) land (tmp2427)),((tmp2328) land ((lnot (tmp2428)))) lor (((lnot (tmp2328))) land (tmp2428)),((tmp2329) land ((lnot (tmp2429)))) lor (((lnot (tmp2329))) land (tmp2429)),((tmp2330) land ((lnot (tmp2430)))) lor (((lnot (tmp2330))) land (tmp2430)),((tmp2331) land ((lnot (tmp2431)))) lor (((lnot (tmp2331))) land (tmp2431)),((tmp2332) land ((lnot (tmp2432)))) lor (((lnot (tmp2332))) land (tmp2432))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single7_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp251,tmp252,tmp253,tmp254,tmp255,tmp256,tmp257,tmp258,tmp259,tmp2510,tmp2511,tmp2512,tmp2513,tmp2514,tmp2515,tmp2516,tmp2517,tmp2518,tmp2519,tmp2520,tmp2521,tmp2522,tmp2523,tmp2524,tmp2525,tmp2526,tmp2527,tmp2528,tmp2529,tmp2530,tmp2531,tmp2532,tmp2533,tmp2534,tmp2535,tmp2536,tmp2537,tmp2538,tmp2539,tmp2540,tmp2541,tmp2542,tmp2543,tmp2544,tmp2545,tmp2546,tmp2547,tmp2548) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp261,tmp262,tmp263,tmp264,tmp265,tmp266,tmp267,tmp268,tmp269,tmp2610,tmp2611,tmp2612,tmp2613,tmp2614,tmp2615,tmp2616,tmp2617,tmp2618,tmp2619,tmp2620,tmp2621,tmp2622,tmp2623,tmp2624,tmp2625,tmp2626,tmp2627,tmp2628,tmp2629,tmp2630,tmp2631,tmp2632,tmp2633,tmp2634,tmp2635,tmp2636,tmp2637,tmp2638,tmp2639,tmp2640,tmp2641,tmp2642,tmp2643,tmp2644,tmp2645,tmp2646,tmp2647,tmp2648) = roundkey7_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp251) land ((lnot (tmp261)))) lor (((lnot (tmp251))) land (tmp261)),((tmp252) land ((lnot (tmp262)))) lor (((lnot (tmp252))) land (tmp262)),((tmp253) land ((lnot (tmp263)))) lor (((lnot (tmp253))) land (tmp263)),((tmp254) land ((lnot (tmp264)))) lor (((lnot (tmp254))) land (tmp264)),((tmp255) land ((lnot (tmp265)))) lor (((lnot (tmp255))) land (tmp265)),((tmp256) land ((lnot (tmp266)))) lor (((lnot (tmp256))) land (tmp266)),((tmp257) land ((lnot (tmp267)))) lor (((lnot (tmp257))) land (tmp267)),((tmp258) land ((lnot (tmp268)))) lor (((lnot (tmp258))) land (tmp268)),((tmp259) land ((lnot (tmp269)))) lor (((lnot (tmp259))) land (tmp269)),((tmp2510) land ((lnot (tmp2610)))) lor (((lnot (tmp2510))) land (tmp2610)),((tmp2511) land ((lnot (tmp2611)))) lor (((lnot (tmp2511))) land (tmp2611)),((tmp2512) land ((lnot (tmp2612)))) lor (((lnot (tmp2512))) land (tmp2612)),((tmp2513) land ((lnot (tmp2613)))) lor (((lnot (tmp2513))) land (tmp2613)),((tmp2514) land ((lnot (tmp2614)))) lor (((lnot (tmp2514))) land (tmp2614)),((tmp2515) land ((lnot (tmp2615)))) lor (((lnot (tmp2515))) land (tmp2615)),((tmp2516) land ((lnot (tmp2616)))) lor (((lnot (tmp2516))) land (tmp2616)),((tmp2517) land ((lnot (tmp2617)))) lor (((lnot (tmp2517))) land (tmp2617)),((tmp2518) land ((lnot (tmp2618)))) lor (((lnot (tmp2518))) land (tmp2618)),((tmp2519) land ((lnot (tmp2619)))) lor (((lnot (tmp2519))) land (tmp2619)),((tmp2520) land ((lnot (tmp2620)))) lor (((lnot (tmp2520))) land (tmp2620)),((tmp2521) land ((lnot (tmp2621)))) lor (((lnot (tmp2521))) land (tmp2621)),((tmp2522) land ((lnot (tmp2622)))) lor (((lnot (tmp2522))) land (tmp2622)),((tmp2523) land ((lnot (tmp2623)))) lor (((lnot (tmp2523))) land (tmp2623)),((tmp2524) land ((lnot (tmp2624)))) lor (((lnot (tmp2524))) land (tmp2624)),((tmp2525) land ((lnot (tmp2625)))) lor (((lnot (tmp2525))) land (tmp2625)),((tmp2526) land ((lnot (tmp2626)))) lor (((lnot (tmp2526))) land (tmp2626)),((tmp2527) land ((lnot (tmp2627)))) lor (((lnot (tmp2527))) land (tmp2627)),((tmp2528) land ((lnot (tmp2628)))) lor (((lnot (tmp2528))) land (tmp2628)),((tmp2529) land ((lnot (tmp2629)))) lor (((lnot (tmp2529))) land (tmp2629)),((tmp2530) land ((lnot (tmp2630)))) lor (((lnot (tmp2530))) land (tmp2630)),((tmp2531) land ((lnot (tmp2631)))) lor (((lnot (tmp2531))) land (tmp2631)),((tmp2532) land ((lnot (tmp2632)))) lor (((lnot (tmp2532))) land (tmp2632)),((tmp2533) land ((lnot (tmp2633)))) lor (((lnot (tmp2533))) land (tmp2633)),((tmp2534) land ((lnot (tmp2634)))) lor (((lnot (tmp2534))) land (tmp2634)),((tmp2535) land ((lnot (tmp2635)))) lor (((lnot (tmp2535))) land (tmp2635)),((tmp2536) land ((lnot (tmp2636)))) lor (((lnot (tmp2536))) land (tmp2636)),((tmp2537) land ((lnot (tmp2637)))) lor (((lnot (tmp2537))) land (tmp2637)),((tmp2538) land ((lnot (tmp2638)))) lor (((lnot (tmp2538))) land (tmp2638)),((tmp2539) land ((lnot (tmp2639)))) lor (((lnot (tmp2539))) land (tmp2639)),((tmp2540) land ((lnot (tmp2640)))) lor (((lnot (tmp2540))) land (tmp2640)),((tmp2541) land ((lnot (tmp2641)))) lor (((lnot (tmp2541))) land (tmp2641)),((tmp2542) land ((lnot (tmp2642)))) lor (((lnot (tmp2542))) land (tmp2642)),((tmp2543) land ((lnot (tmp2643)))) lor (((lnot (tmp2543))) land (tmp2643)),((tmp2544) land ((lnot (tmp2644)))) lor (((lnot (tmp2544))) land (tmp2644)),((tmp2545) land ((lnot (tmp2645)))) lor (((lnot (tmp2545))) land (tmp2645)),((tmp2546) land ((lnot (tmp2646)))) lor (((lnot (tmp2546))) land (tmp2646)),((tmp2547) land ((lnot (tmp2647)))) lor (((lnot (tmp2547))) land (tmp2647)),((tmp2548) land ((lnot (tmp2648)))) lor (((lnot (tmp2548))) land (tmp2648))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp271,tmp272,tmp273,tmp274,tmp275,tmp276,tmp277,tmp278,tmp279,tmp2710,tmp2711,tmp2712,tmp2713,tmp2714,tmp2715,tmp2716,tmp2717,tmp2718,tmp2719,tmp2720,tmp2721,tmp2722,tmp2723,tmp2724,tmp2725,tmp2726,tmp2727,tmp2728,tmp2729,tmp2730,tmp2731,tmp2732) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp281,tmp282,tmp283,tmp284,tmp285,tmp286,tmp287,tmp288,tmp289,tmp2810,tmp2811,tmp2812,tmp2813,tmp2814,tmp2815,tmp2816,tmp2817,tmp2818,tmp2819,tmp2820,tmp2821,tmp2822,tmp2823,tmp2824,tmp2825,tmp2826,tmp2827,tmp2828,tmp2829,tmp2830,tmp2831,tmp2832) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp271) land ((lnot (tmp281)))) lor (((lnot (tmp271))) land (tmp281)),((tmp272) land ((lnot (tmp282)))) lor (((lnot (tmp272))) land (tmp282)),((tmp273) land ((lnot (tmp283)))) lor (((lnot (tmp273))) land (tmp283)),((tmp274) land ((lnot (tmp284)))) lor (((lnot (tmp274))) land (tmp284)),((tmp275) land ((lnot (tmp285)))) lor (((lnot (tmp275))) land (tmp285)),((tmp276) land ((lnot (tmp286)))) lor (((lnot (tmp276))) land (tmp286)),((tmp277) land ((lnot (tmp287)))) lor (((lnot (tmp277))) land (tmp287)),((tmp278) land ((lnot (tmp288)))) lor (((lnot (tmp278))) land (tmp288)),((tmp279) land ((lnot (tmp289)))) lor (((lnot (tmp279))) land (tmp289)),((tmp2710) land ((lnot (tmp2810)))) lor (((lnot (tmp2710))) land (tmp2810)),((tmp2711) land ((lnot (tmp2811)))) lor (((lnot (tmp2711))) land (tmp2811)),((tmp2712) land ((lnot (tmp2812)))) lor (((lnot (tmp2712))) land (tmp2812)),((tmp2713) land ((lnot (tmp2813)))) lor (((lnot (tmp2713))) land (tmp2813)),((tmp2714) land ((lnot (tmp2814)))) lor (((lnot (tmp2714))) land (tmp2814)),((tmp2715) land ((lnot (tmp2815)))) lor (((lnot (tmp2715))) land (tmp2815)),((tmp2716) land ((lnot (tmp2816)))) lor (((lnot (tmp2716))) land (tmp2816)),((tmp2717) land ((lnot (tmp2817)))) lor (((lnot (tmp2717))) land (tmp2817)),((tmp2718) land ((lnot (tmp2818)))) lor (((lnot (tmp2718))) land (tmp2818)),((tmp2719) land ((lnot (tmp2819)))) lor (((lnot (tmp2719))) land (tmp2819)),((tmp2720) land ((lnot (tmp2820)))) lor (((lnot (tmp2720))) land (tmp2820)),((tmp2721) land ((lnot (tmp2821)))) lor (((lnot (tmp2721))) land (tmp2821)),((tmp2722) land ((lnot (tmp2822)))) lor (((lnot (tmp2722))) land (tmp2822)),((tmp2723) land ((lnot (tmp2823)))) lor (((lnot (tmp2723))) land (tmp2823)),((tmp2724) land ((lnot (tmp2824)))) lor (((lnot (tmp2724))) land (tmp2824)),((tmp2725) land ((lnot (tmp2825)))) lor (((lnot (tmp2725))) land (tmp2825)),((tmp2726) land ((lnot (tmp2826)))) lor (((lnot (tmp2726))) land (tmp2826)),((tmp2727) land ((lnot (tmp2827)))) lor (((lnot (tmp2727))) land (tmp2827)),((tmp2728) land ((lnot (tmp2828)))) lor (((lnot (tmp2728))) land (tmp2828)),((tmp2729) land ((lnot (tmp2829)))) lor (((lnot (tmp2729))) land (tmp2829)),((tmp2730) land ((lnot (tmp2830)))) lor (((lnot (tmp2730))) land (tmp2830)),((tmp2731) land ((lnot (tmp2831)))) lor (((lnot (tmp2731))) land (tmp2831)),((tmp2732) land ((lnot (tmp2832)))) lor (((lnot (tmp2732))) land (tmp2832))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single8_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp291,tmp292,tmp293,tmp294,tmp295,tmp296,tmp297,tmp298,tmp299,tmp2910,tmp2911,tmp2912,tmp2913,tmp2914,tmp2915,tmp2916,tmp2917,tmp2918,tmp2919,tmp2920,tmp2921,tmp2922,tmp2923,tmp2924,tmp2925,tmp2926,tmp2927,tmp2928,tmp2929,tmp2930,tmp2931,tmp2932,tmp2933,tmp2934,tmp2935,tmp2936,tmp2937,tmp2938,tmp2939,tmp2940,tmp2941,tmp2942,tmp2943,tmp2944,tmp2945,tmp2946,tmp2947,tmp2948) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp301,tmp302,tmp303,tmp304,tmp305,tmp306,tmp307,tmp308,tmp309,tmp3010,tmp3011,tmp3012,tmp3013,tmp3014,tmp3015,tmp3016,tmp3017,tmp3018,tmp3019,tmp3020,tmp3021,tmp3022,tmp3023,tmp3024,tmp3025,tmp3026,tmp3027,tmp3028,tmp3029,tmp3030,tmp3031,tmp3032,tmp3033,tmp3034,tmp3035,tmp3036,tmp3037,tmp3038,tmp3039,tmp3040,tmp3041,tmp3042,tmp3043,tmp3044,tmp3045,tmp3046,tmp3047,tmp3048) = roundkey8_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp291) land ((lnot (tmp301)))) lor (((lnot (tmp291))) land (tmp301)),((tmp292) land ((lnot (tmp302)))) lor (((lnot (tmp292))) land (tmp302)),((tmp293) land ((lnot (tmp303)))) lor (((lnot (tmp293))) land (tmp303)),((tmp294) land ((lnot (tmp304)))) lor (((lnot (tmp294))) land (tmp304)),((tmp295) land ((lnot (tmp305)))) lor (((lnot (tmp295))) land (tmp305)),((tmp296) land ((lnot (tmp306)))) lor (((lnot (tmp296))) land (tmp306)),((tmp297) land ((lnot (tmp307)))) lor (((lnot (tmp297))) land (tmp307)),((tmp298) land ((lnot (tmp308)))) lor (((lnot (tmp298))) land (tmp308)),((tmp299) land ((lnot (tmp309)))) lor (((lnot (tmp299))) land (tmp309)),((tmp2910) land ((lnot (tmp3010)))) lor (((lnot (tmp2910))) land (tmp3010)),((tmp2911) land ((lnot (tmp3011)))) lor (((lnot (tmp2911))) land (tmp3011)),((tmp2912) land ((lnot (tmp3012)))) lor (((lnot (tmp2912))) land (tmp3012)),((tmp2913) land ((lnot (tmp3013)))) lor (((lnot (tmp2913))) land (tmp3013)),((tmp2914) land ((lnot (tmp3014)))) lor (((lnot (tmp2914))) land (tmp3014)),((tmp2915) land ((lnot (tmp3015)))) lor (((lnot (tmp2915))) land (tmp3015)),((tmp2916) land ((lnot (tmp3016)))) lor (((lnot (tmp2916))) land (tmp3016)),((tmp2917) land ((lnot (tmp3017)))) lor (((lnot (tmp2917))) land (tmp3017)),((tmp2918) land ((lnot (tmp3018)))) lor (((lnot (tmp2918))) land (tmp3018)),((tmp2919) land ((lnot (tmp3019)))) lor (((lnot (tmp2919))) land (tmp3019)),((tmp2920) land ((lnot (tmp3020)))) lor (((lnot (tmp2920))) land (tmp3020)),((tmp2921) land ((lnot (tmp3021)))) lor (((lnot (tmp2921))) land (tmp3021)),((tmp2922) land ((lnot (tmp3022)))) lor (((lnot (tmp2922))) land (tmp3022)),((tmp2923) land ((lnot (tmp3023)))) lor (((lnot (tmp2923))) land (tmp3023)),((tmp2924) land ((lnot (tmp3024)))) lor (((lnot (tmp2924))) land (tmp3024)),((tmp2925) land ((lnot (tmp3025)))) lor (((lnot (tmp2925))) land (tmp3025)),((tmp2926) land ((lnot (tmp3026)))) lor (((lnot (tmp2926))) land (tmp3026)),((tmp2927) land ((lnot (tmp3027)))) lor (((lnot (tmp2927))) land (tmp3027)),((tmp2928) land ((lnot (tmp3028)))) lor (((lnot (tmp2928))) land (tmp3028)),((tmp2929) land ((lnot (tmp3029)))) lor (((lnot (tmp2929))) land (tmp3029)),((tmp2930) land ((lnot (tmp3030)))) lor (((lnot (tmp2930))) land (tmp3030)),((tmp2931) land ((lnot (tmp3031)))) lor (((lnot (tmp2931))) land (tmp3031)),((tmp2932) land ((lnot (tmp3032)))) lor (((lnot (tmp2932))) land (tmp3032)),((tmp2933) land ((lnot (tmp3033)))) lor (((lnot (tmp2933))) land (tmp3033)),((tmp2934) land ((lnot (tmp3034)))) lor (((lnot (tmp2934))) land (tmp3034)),((tmp2935) land ((lnot (tmp3035)))) lor (((lnot (tmp2935))) land (tmp3035)),((tmp2936) land ((lnot (tmp3036)))) lor (((lnot (tmp2936))) land (tmp3036)),((tmp2937) land ((lnot (tmp3037)))) lor (((lnot (tmp2937))) land (tmp3037)),((tmp2938) land ((lnot (tmp3038)))) lor (((lnot (tmp2938))) land (tmp3038)),((tmp2939) land ((lnot (tmp3039)))) lor (((lnot (tmp2939))) land (tmp3039)),((tmp2940) land ((lnot (tmp3040)))) lor (((lnot (tmp2940))) land (tmp3040)),((tmp2941) land ((lnot (tmp3041)))) lor (((lnot (tmp2941))) land (tmp3041)),((tmp2942) land ((lnot (tmp3042)))) lor (((lnot (tmp2942))) land (tmp3042)),((tmp2943) land ((lnot (tmp3043)))) lor (((lnot (tmp2943))) land (tmp3043)),((tmp2944) land ((lnot (tmp3044)))) lor (((lnot (tmp2944))) land (tmp3044)),((tmp2945) land ((lnot (tmp3045)))) lor (((lnot (tmp2945))) land (tmp3045)),((tmp2946) land ((lnot (tmp3046)))) lor (((lnot (tmp2946))) land (tmp3046)),((tmp2947) land ((lnot (tmp3047)))) lor (((lnot (tmp2947))) land (tmp3047)),((tmp2948) land ((lnot (tmp3048)))) lor (((lnot (tmp2948))) land (tmp3048))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp311,tmp312,tmp313,tmp314,tmp315,tmp316,tmp317,tmp318,tmp319,tmp3110,tmp3111,tmp3112,tmp3113,tmp3114,tmp3115,tmp3116,tmp3117,tmp3118,tmp3119,tmp3120,tmp3121,tmp3122,tmp3123,tmp3124,tmp3125,tmp3126,tmp3127,tmp3128,tmp3129,tmp3130,tmp3131,tmp3132) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp321,tmp322,tmp323,tmp324,tmp325,tmp326,tmp327,tmp328,tmp329,tmp3210,tmp3211,tmp3212,tmp3213,tmp3214,tmp3215,tmp3216,tmp3217,tmp3218,tmp3219,tmp3220,tmp3221,tmp3222,tmp3223,tmp3224,tmp3225,tmp3226,tmp3227,tmp3228,tmp3229,tmp3230,tmp3231,tmp3232) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp311) land ((lnot (tmp321)))) lor (((lnot (tmp311))) land (tmp321)),((tmp312) land ((lnot (tmp322)))) lor (((lnot (tmp312))) land (tmp322)),((tmp313) land ((lnot (tmp323)))) lor (((lnot (tmp313))) land (tmp323)),((tmp314) land ((lnot (tmp324)))) lor (((lnot (tmp314))) land (tmp324)),((tmp315) land ((lnot (tmp325)))) lor (((lnot (tmp315))) land (tmp325)),((tmp316) land ((lnot (tmp326)))) lor (((lnot (tmp316))) land (tmp326)),((tmp317) land ((lnot (tmp327)))) lor (((lnot (tmp317))) land (tmp327)),((tmp318) land ((lnot (tmp328)))) lor (((lnot (tmp318))) land (tmp328)),((tmp319) land ((lnot (tmp329)))) lor (((lnot (tmp319))) land (tmp329)),((tmp3110) land ((lnot (tmp3210)))) lor (((lnot (tmp3110))) land (tmp3210)),((tmp3111) land ((lnot (tmp3211)))) lor (((lnot (tmp3111))) land (tmp3211)),((tmp3112) land ((lnot (tmp3212)))) lor (((lnot (tmp3112))) land (tmp3212)),((tmp3113) land ((lnot (tmp3213)))) lor (((lnot (tmp3113))) land (tmp3213)),((tmp3114) land ((lnot (tmp3214)))) lor (((lnot (tmp3114))) land (tmp3214)),((tmp3115) land ((lnot (tmp3215)))) lor (((lnot (tmp3115))) land (tmp3215)),((tmp3116) land ((lnot (tmp3216)))) lor (((lnot (tmp3116))) land (tmp3216)),((tmp3117) land ((lnot (tmp3217)))) lor (((lnot (tmp3117))) land (tmp3217)),((tmp3118) land ((lnot (tmp3218)))) lor (((lnot (tmp3118))) land (tmp3218)),((tmp3119) land ((lnot (tmp3219)))) lor (((lnot (tmp3119))) land (tmp3219)),((tmp3120) land ((lnot (tmp3220)))) lor (((lnot (tmp3120))) land (tmp3220)),((tmp3121) land ((lnot (tmp3221)))) lor (((lnot (tmp3121))) land (tmp3221)),((tmp3122) land ((lnot (tmp3222)))) lor (((lnot (tmp3122))) land (tmp3222)),((tmp3123) land ((lnot (tmp3223)))) lor (((lnot (tmp3123))) land (tmp3223)),((tmp3124) land ((lnot (tmp3224)))) lor (((lnot (tmp3124))) land (tmp3224)),((tmp3125) land ((lnot (tmp3225)))) lor (((lnot (tmp3125))) land (tmp3225)),((tmp3126) land ((lnot (tmp3226)))) lor (((lnot (tmp3126))) land (tmp3226)),((tmp3127) land ((lnot (tmp3227)))) lor (((lnot (tmp3127))) land (tmp3227)),((tmp3128) land ((lnot (tmp3228)))) lor (((lnot (tmp3128))) land (tmp3228)),((tmp3129) land ((lnot (tmp3229)))) lor (((lnot (tmp3129))) land (tmp3229)),((tmp3130) land ((lnot (tmp3230)))) lor (((lnot (tmp3130))) land (tmp3230)),((tmp3131) land ((lnot (tmp3231)))) lor (((lnot (tmp3131))) land (tmp3231)),((tmp3132) land ((lnot (tmp3232)))) lor (((lnot (tmp3132))) land (tmp3232))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single9_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp331,tmp332,tmp333,tmp334,tmp335,tmp336,tmp337,tmp338,tmp339,tmp3310,tmp3311,tmp3312,tmp3313,tmp3314,tmp3315,tmp3316,tmp3317,tmp3318,tmp3319,tmp3320,tmp3321,tmp3322,tmp3323,tmp3324,tmp3325,tmp3326,tmp3327,tmp3328,tmp3329,tmp3330,tmp3331,tmp3332,tmp3333,tmp3334,tmp3335,tmp3336,tmp3337,tmp3338,tmp3339,tmp3340,tmp3341,tmp3342,tmp3343,tmp3344,tmp3345,tmp3346,tmp3347,tmp3348) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp341,tmp342,tmp343,tmp344,tmp345,tmp346,tmp347,tmp348,tmp349,tmp3410,tmp3411,tmp3412,tmp3413,tmp3414,tmp3415,tmp3416,tmp3417,tmp3418,tmp3419,tmp3420,tmp3421,tmp3422,tmp3423,tmp3424,tmp3425,tmp3426,tmp3427,tmp3428,tmp3429,tmp3430,tmp3431,tmp3432,tmp3433,tmp3434,tmp3435,tmp3436,tmp3437,tmp3438,tmp3439,tmp3440,tmp3441,tmp3442,tmp3443,tmp3444,tmp3445,tmp3446,tmp3447,tmp3448) = roundkey9_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp331) land ((lnot (tmp341)))) lor (((lnot (tmp331))) land (tmp341)),((tmp332) land ((lnot (tmp342)))) lor (((lnot (tmp332))) land (tmp342)),((tmp333) land ((lnot (tmp343)))) lor (((lnot (tmp333))) land (tmp343)),((tmp334) land ((lnot (tmp344)))) lor (((lnot (tmp334))) land (tmp344)),((tmp335) land ((lnot (tmp345)))) lor (((lnot (tmp335))) land (tmp345)),((tmp336) land ((lnot (tmp346)))) lor (((lnot (tmp336))) land (tmp346)),((tmp337) land ((lnot (tmp347)))) lor (((lnot (tmp337))) land (tmp347)),((tmp338) land ((lnot (tmp348)))) lor (((lnot (tmp338))) land (tmp348)),((tmp339) land ((lnot (tmp349)))) lor (((lnot (tmp339))) land (tmp349)),((tmp3310) land ((lnot (tmp3410)))) lor (((lnot (tmp3310))) land (tmp3410)),((tmp3311) land ((lnot (tmp3411)))) lor (((lnot (tmp3311))) land (tmp3411)),((tmp3312) land ((lnot (tmp3412)))) lor (((lnot (tmp3312))) land (tmp3412)),((tmp3313) land ((lnot (tmp3413)))) lor (((lnot (tmp3313))) land (tmp3413)),((tmp3314) land ((lnot (tmp3414)))) lor (((lnot (tmp3314))) land (tmp3414)),((tmp3315) land ((lnot (tmp3415)))) lor (((lnot (tmp3315))) land (tmp3415)),((tmp3316) land ((lnot (tmp3416)))) lor (((lnot (tmp3316))) land (tmp3416)),((tmp3317) land ((lnot (tmp3417)))) lor (((lnot (tmp3317))) land (tmp3417)),((tmp3318) land ((lnot (tmp3418)))) lor (((lnot (tmp3318))) land (tmp3418)),((tmp3319) land ((lnot (tmp3419)))) lor (((lnot (tmp3319))) land (tmp3419)),((tmp3320) land ((lnot (tmp3420)))) lor (((lnot (tmp3320))) land (tmp3420)),((tmp3321) land ((lnot (tmp3421)))) lor (((lnot (tmp3321))) land (tmp3421)),((tmp3322) land ((lnot (tmp3422)))) lor (((lnot (tmp3322))) land (tmp3422)),((tmp3323) land ((lnot (tmp3423)))) lor (((lnot (tmp3323))) land (tmp3423)),((tmp3324) land ((lnot (tmp3424)))) lor (((lnot (tmp3324))) land (tmp3424)),((tmp3325) land ((lnot (tmp3425)))) lor (((lnot (tmp3325))) land (tmp3425)),((tmp3326) land ((lnot (tmp3426)))) lor (((lnot (tmp3326))) land (tmp3426)),((tmp3327) land ((lnot (tmp3427)))) lor (((lnot (tmp3327))) land (tmp3427)),((tmp3328) land ((lnot (tmp3428)))) lor (((lnot (tmp3328))) land (tmp3428)),((tmp3329) land ((lnot (tmp3429)))) lor (((lnot (tmp3329))) land (tmp3429)),((tmp3330) land ((lnot (tmp3430)))) lor (((lnot (tmp3330))) land (tmp3430)),((tmp3331) land ((lnot (tmp3431)))) lor (((lnot (tmp3331))) land (tmp3431)),((tmp3332) land ((lnot (tmp3432)))) lor (((lnot (tmp3332))) land (tmp3432)),((tmp3333) land ((lnot (tmp3433)))) lor (((lnot (tmp3333))) land (tmp3433)),((tmp3334) land ((lnot (tmp3434)))) lor (((lnot (tmp3334))) land (tmp3434)),((tmp3335) land ((lnot (tmp3435)))) lor (((lnot (tmp3335))) land (tmp3435)),((tmp3336) land ((lnot (tmp3436)))) lor (((lnot (tmp3336))) land (tmp3436)),((tmp3337) land ((lnot (tmp3437)))) lor (((lnot (tmp3337))) land (tmp3437)),((tmp3338) land ((lnot (tmp3438)))) lor (((lnot (tmp3338))) land (tmp3438)),((tmp3339) land ((lnot (tmp3439)))) lor (((lnot (tmp3339))) land (tmp3439)),((tmp3340) land ((lnot (tmp3440)))) lor (((lnot (tmp3340))) land (tmp3440)),((tmp3341) land ((lnot (tmp3441)))) lor (((lnot (tmp3341))) land (tmp3441)),((tmp3342) land ((lnot (tmp3442)))) lor (((lnot (tmp3342))) land (tmp3442)),((tmp3343) land ((lnot (tmp3443)))) lor (((lnot (tmp3343))) land (tmp3443)),((tmp3344) land ((lnot (tmp3444)))) lor (((lnot (tmp3344))) land (tmp3444)),((tmp3345) land ((lnot (tmp3445)))) lor (((lnot (tmp3345))) land (tmp3445)),((tmp3346) land ((lnot (tmp3446)))) lor (((lnot (tmp3346))) land (tmp3446)),((tmp3347) land ((lnot (tmp3447)))) lor (((lnot (tmp3347))) land (tmp3447)),((tmp3348) land ((lnot (tmp3448)))) lor (((lnot (tmp3348))) land (tmp3448))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp351,tmp352,tmp353,tmp354,tmp355,tmp356,tmp357,tmp358,tmp359,tmp3510,tmp3511,tmp3512,tmp3513,tmp3514,tmp3515,tmp3516,tmp3517,tmp3518,tmp3519,tmp3520,tmp3521,tmp3522,tmp3523,tmp3524,tmp3525,tmp3526,tmp3527,tmp3528,tmp3529,tmp3530,tmp3531,tmp3532) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp361,tmp362,tmp363,tmp364,tmp365,tmp366,tmp367,tmp368,tmp369,tmp3610,tmp3611,tmp3612,tmp3613,tmp3614,tmp3615,tmp3616,tmp3617,tmp3618,tmp3619,tmp3620,tmp3621,tmp3622,tmp3623,tmp3624,tmp3625,tmp3626,tmp3627,tmp3628,tmp3629,tmp3630,tmp3631,tmp3632) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp351) land ((lnot (tmp361)))) lor (((lnot (tmp351))) land (tmp361)),((tmp352) land ((lnot (tmp362)))) lor (((lnot (tmp352))) land (tmp362)),((tmp353) land ((lnot (tmp363)))) lor (((lnot (tmp353))) land (tmp363)),((tmp354) land ((lnot (tmp364)))) lor (((lnot (tmp354))) land (tmp364)),((tmp355) land ((lnot (tmp365)))) lor (((lnot (tmp355))) land (tmp365)),((tmp356) land ((lnot (tmp366)))) lor (((lnot (tmp356))) land (tmp366)),((tmp357) land ((lnot (tmp367)))) lor (((lnot (tmp357))) land (tmp367)),((tmp358) land ((lnot (tmp368)))) lor (((lnot (tmp358))) land (tmp368)),((tmp359) land ((lnot (tmp369)))) lor (((lnot (tmp359))) land (tmp369)),((tmp3510) land ((lnot (tmp3610)))) lor (((lnot (tmp3510))) land (tmp3610)),((tmp3511) land ((lnot (tmp3611)))) lor (((lnot (tmp3511))) land (tmp3611)),((tmp3512) land ((lnot (tmp3612)))) lor (((lnot (tmp3512))) land (tmp3612)),((tmp3513) land ((lnot (tmp3613)))) lor (((lnot (tmp3513))) land (tmp3613)),((tmp3514) land ((lnot (tmp3614)))) lor (((lnot (tmp3514))) land (tmp3614)),((tmp3515) land ((lnot (tmp3615)))) lor (((lnot (tmp3515))) land (tmp3615)),((tmp3516) land ((lnot (tmp3616)))) lor (((lnot (tmp3516))) land (tmp3616)),((tmp3517) land ((lnot (tmp3617)))) lor (((lnot (tmp3517))) land (tmp3617)),((tmp3518) land ((lnot (tmp3618)))) lor (((lnot (tmp3518))) land (tmp3618)),((tmp3519) land ((lnot (tmp3619)))) lor (((lnot (tmp3519))) land (tmp3619)),((tmp3520) land ((lnot (tmp3620)))) lor (((lnot (tmp3520))) land (tmp3620)),((tmp3521) land ((lnot (tmp3621)))) lor (((lnot (tmp3521))) land (tmp3621)),((tmp3522) land ((lnot (tmp3622)))) lor (((lnot (tmp3522))) land (tmp3622)),((tmp3523) land ((lnot (tmp3623)))) lor (((lnot (tmp3523))) land (tmp3623)),((tmp3524) land ((lnot (tmp3624)))) lor (((lnot (tmp3524))) land (tmp3624)),((tmp3525) land ((lnot (tmp3625)))) lor (((lnot (tmp3525))) land (tmp3625)),((tmp3526) land ((lnot (tmp3626)))) lor (((lnot (tmp3526))) land (tmp3626)),((tmp3527) land ((lnot (tmp3627)))) lor (((lnot (tmp3527))) land (tmp3627)),((tmp3528) land ((lnot (tmp3628)))) lor (((lnot (tmp3528))) land (tmp3628)),((tmp3529) land ((lnot (tmp3629)))) lor (((lnot (tmp3529))) land (tmp3629)),((tmp3530) land ((lnot (tmp3630)))) lor (((lnot (tmp3530))) land (tmp3630)),((tmp3531) land ((lnot (tmp3631)))) lor (((lnot (tmp3531))) land (tmp3631)),((tmp3532) land ((lnot (tmp3632)))) lor (((lnot (tmp3532))) land (tmp3632))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single10_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp371,tmp372,tmp373,tmp374,tmp375,tmp376,tmp377,tmp378,tmp379,tmp3710,tmp3711,tmp3712,tmp3713,tmp3714,tmp3715,tmp3716,tmp3717,tmp3718,tmp3719,tmp3720,tmp3721,tmp3722,tmp3723,tmp3724,tmp3725,tmp3726,tmp3727,tmp3728,tmp3729,tmp3730,tmp3731,tmp3732,tmp3733,tmp3734,tmp3735,tmp3736,tmp3737,tmp3738,tmp3739,tmp3740,tmp3741,tmp3742,tmp3743,tmp3744,tmp3745,tmp3746,tmp3747,tmp3748) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp381,tmp382,tmp383,tmp384,tmp385,tmp386,tmp387,tmp388,tmp389,tmp3810,tmp3811,tmp3812,tmp3813,tmp3814,tmp3815,tmp3816,tmp3817,tmp3818,tmp3819,tmp3820,tmp3821,tmp3822,tmp3823,tmp3824,tmp3825,tmp3826,tmp3827,tmp3828,tmp3829,tmp3830,tmp3831,tmp3832,tmp3833,tmp3834,tmp3835,tmp3836,tmp3837,tmp3838,tmp3839,tmp3840,tmp3841,tmp3842,tmp3843,tmp3844,tmp3845,tmp3846,tmp3847,tmp3848) = roundkey10_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp371) land ((lnot (tmp381)))) lor (((lnot (tmp371))) land (tmp381)),((tmp372) land ((lnot (tmp382)))) lor (((lnot (tmp372))) land (tmp382)),((tmp373) land ((lnot (tmp383)))) lor (((lnot (tmp373))) land (tmp383)),((tmp374) land ((lnot (tmp384)))) lor (((lnot (tmp374))) land (tmp384)),((tmp375) land ((lnot (tmp385)))) lor (((lnot (tmp375))) land (tmp385)),((tmp376) land ((lnot (tmp386)))) lor (((lnot (tmp376))) land (tmp386)),((tmp377) land ((lnot (tmp387)))) lor (((lnot (tmp377))) land (tmp387)),((tmp378) land ((lnot (tmp388)))) lor (((lnot (tmp378))) land (tmp388)),((tmp379) land ((lnot (tmp389)))) lor (((lnot (tmp379))) land (tmp389)),((tmp3710) land ((lnot (tmp3810)))) lor (((lnot (tmp3710))) land (tmp3810)),((tmp3711) land ((lnot (tmp3811)))) lor (((lnot (tmp3711))) land (tmp3811)),((tmp3712) land ((lnot (tmp3812)))) lor (((lnot (tmp3712))) land (tmp3812)),((tmp3713) land ((lnot (tmp3813)))) lor (((lnot (tmp3713))) land (tmp3813)),((tmp3714) land ((lnot (tmp3814)))) lor (((lnot (tmp3714))) land (tmp3814)),((tmp3715) land ((lnot (tmp3815)))) lor (((lnot (tmp3715))) land (tmp3815)),((tmp3716) land ((lnot (tmp3816)))) lor (((lnot (tmp3716))) land (tmp3816)),((tmp3717) land ((lnot (tmp3817)))) lor (((lnot (tmp3717))) land (tmp3817)),((tmp3718) land ((lnot (tmp3818)))) lor (((lnot (tmp3718))) land (tmp3818)),((tmp3719) land ((lnot (tmp3819)))) lor (((lnot (tmp3719))) land (tmp3819)),((tmp3720) land ((lnot (tmp3820)))) lor (((lnot (tmp3720))) land (tmp3820)),((tmp3721) land ((lnot (tmp3821)))) lor (((lnot (tmp3721))) land (tmp3821)),((tmp3722) land ((lnot (tmp3822)))) lor (((lnot (tmp3722))) land (tmp3822)),((tmp3723) land ((lnot (tmp3823)))) lor (((lnot (tmp3723))) land (tmp3823)),((tmp3724) land ((lnot (tmp3824)))) lor (((lnot (tmp3724))) land (tmp3824)),((tmp3725) land ((lnot (tmp3825)))) lor (((lnot (tmp3725))) land (tmp3825)),((tmp3726) land ((lnot (tmp3826)))) lor (((lnot (tmp3726))) land (tmp3826)),((tmp3727) land ((lnot (tmp3827)))) lor (((lnot (tmp3727))) land (tmp3827)),((tmp3728) land ((lnot (tmp3828)))) lor (((lnot (tmp3728))) land (tmp3828)),((tmp3729) land ((lnot (tmp3829)))) lor (((lnot (tmp3729))) land (tmp3829)),((tmp3730) land ((lnot (tmp3830)))) lor (((lnot (tmp3730))) land (tmp3830)),((tmp3731) land ((lnot (tmp3831)))) lor (((lnot (tmp3731))) land (tmp3831)),((tmp3732) land ((lnot (tmp3832)))) lor (((lnot (tmp3732))) land (tmp3832)),((tmp3733) land ((lnot (tmp3833)))) lor (((lnot (tmp3733))) land (tmp3833)),((tmp3734) land ((lnot (tmp3834)))) lor (((lnot (tmp3734))) land (tmp3834)),((tmp3735) land ((lnot (tmp3835)))) lor (((lnot (tmp3735))) land (tmp3835)),((tmp3736) land ((lnot (tmp3836)))) lor (((lnot (tmp3736))) land (tmp3836)),((tmp3737) land ((lnot (tmp3837)))) lor (((lnot (tmp3737))) land (tmp3837)),((tmp3738) land ((lnot (tmp3838)))) lor (((lnot (tmp3738))) land (tmp3838)),((tmp3739) land ((lnot (tmp3839)))) lor (((lnot (tmp3739))) land (tmp3839)),((tmp3740) land ((lnot (tmp3840)))) lor (((lnot (tmp3740))) land (tmp3840)),((tmp3741) land ((lnot (tmp3841)))) lor (((lnot (tmp3741))) land (tmp3841)),((tmp3742) land ((lnot (tmp3842)))) lor (((lnot (tmp3742))) land (tmp3842)),((tmp3743) land ((lnot (tmp3843)))) lor (((lnot (tmp3743))) land (tmp3843)),((tmp3744) land ((lnot (tmp3844)))) lor (((lnot (tmp3744))) land (tmp3844)),((tmp3745) land ((lnot (tmp3845)))) lor (((lnot (tmp3745))) land (tmp3845)),((tmp3746) land ((lnot (tmp3846)))) lor (((lnot (tmp3746))) land (tmp3846)),((tmp3747) land ((lnot (tmp3847)))) lor (((lnot (tmp3747))) land (tmp3847)),((tmp3748) land ((lnot (tmp3848)))) lor (((lnot (tmp3748))) land (tmp3848))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp391,tmp392,tmp393,tmp394,tmp395,tmp396,tmp397,tmp398,tmp399,tmp3910,tmp3911,tmp3912,tmp3913,tmp3914,tmp3915,tmp3916,tmp3917,tmp3918,tmp3919,tmp3920,tmp3921,tmp3922,tmp3923,tmp3924,tmp3925,tmp3926,tmp3927,tmp3928,tmp3929,tmp3930,tmp3931,tmp3932) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp401,tmp402,tmp403,tmp404,tmp405,tmp406,tmp407,tmp408,tmp409,tmp4010,tmp4011,tmp4012,tmp4013,tmp4014,tmp4015,tmp4016,tmp4017,tmp4018,tmp4019,tmp4020,tmp4021,tmp4022,tmp4023,tmp4024,tmp4025,tmp4026,tmp4027,tmp4028,tmp4029,tmp4030,tmp4031,tmp4032) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp391) land ((lnot (tmp401)))) lor (((lnot (tmp391))) land (tmp401)),((tmp392) land ((lnot (tmp402)))) lor (((lnot (tmp392))) land (tmp402)),((tmp393) land ((lnot (tmp403)))) lor (((lnot (tmp393))) land (tmp403)),((tmp394) land ((lnot (tmp404)))) lor (((lnot (tmp394))) land (tmp404)),((tmp395) land ((lnot (tmp405)))) lor (((lnot (tmp395))) land (tmp405)),((tmp396) land ((lnot (tmp406)))) lor (((lnot (tmp396))) land (tmp406)),((tmp397) land ((lnot (tmp407)))) lor (((lnot (tmp397))) land (tmp407)),((tmp398) land ((lnot (tmp408)))) lor (((lnot (tmp398))) land (tmp408)),((tmp399) land ((lnot (tmp409)))) lor (((lnot (tmp399))) land (tmp409)),((tmp3910) land ((lnot (tmp4010)))) lor (((lnot (tmp3910))) land (tmp4010)),((tmp3911) land ((lnot (tmp4011)))) lor (((lnot (tmp3911))) land (tmp4011)),((tmp3912) land ((lnot (tmp4012)))) lor (((lnot (tmp3912))) land (tmp4012)),((tmp3913) land ((lnot (tmp4013)))) lor (((lnot (tmp3913))) land (tmp4013)),((tmp3914) land ((lnot (tmp4014)))) lor (((lnot (tmp3914))) land (tmp4014)),((tmp3915) land ((lnot (tmp4015)))) lor (((lnot (tmp3915))) land (tmp4015)),((tmp3916) land ((lnot (tmp4016)))) lor (((lnot (tmp3916))) land (tmp4016)),((tmp3917) land ((lnot (tmp4017)))) lor (((lnot (tmp3917))) land (tmp4017)),((tmp3918) land ((lnot (tmp4018)))) lor (((lnot (tmp3918))) land (tmp4018)),((tmp3919) land ((lnot (tmp4019)))) lor (((lnot (tmp3919))) land (tmp4019)),((tmp3920) land ((lnot (tmp4020)))) lor (((lnot (tmp3920))) land (tmp4020)),((tmp3921) land ((lnot (tmp4021)))) lor (((lnot (tmp3921))) land (tmp4021)),((tmp3922) land ((lnot (tmp4022)))) lor (((lnot (tmp3922))) land (tmp4022)),((tmp3923) land ((lnot (tmp4023)))) lor (((lnot (tmp3923))) land (tmp4023)),((tmp3924) land ((lnot (tmp4024)))) lor (((lnot (tmp3924))) land (tmp4024)),((tmp3925) land ((lnot (tmp4025)))) lor (((lnot (tmp3925))) land (tmp4025)),((tmp3926) land ((lnot (tmp4026)))) lor (((lnot (tmp3926))) land (tmp4026)),((tmp3927) land ((lnot (tmp4027)))) lor (((lnot (tmp3927))) land (tmp4027)),((tmp3928) land ((lnot (tmp4028)))) lor (((lnot (tmp3928))) land (tmp4028)),((tmp3929) land ((lnot (tmp4029)))) lor (((lnot (tmp3929))) land (tmp4029)),((tmp3930) land ((lnot (tmp4030)))) lor (((lnot (tmp3930))) land (tmp4030)),((tmp3931) land ((lnot (tmp4031)))) lor (((lnot (tmp3931))) land (tmp4031)),((tmp3932) land ((lnot (tmp4032)))) lor (((lnot (tmp3932))) land (tmp4032))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single11_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp411,tmp412,tmp413,tmp414,tmp415,tmp416,tmp417,tmp418,tmp419,tmp4110,tmp4111,tmp4112,tmp4113,tmp4114,tmp4115,tmp4116,tmp4117,tmp4118,tmp4119,tmp4120,tmp4121,tmp4122,tmp4123,tmp4124,tmp4125,tmp4126,tmp4127,tmp4128,tmp4129,tmp4130,tmp4131,tmp4132,tmp4133,tmp4134,tmp4135,tmp4136,tmp4137,tmp4138,tmp4139,tmp4140,tmp4141,tmp4142,tmp4143,tmp4144,tmp4145,tmp4146,tmp4147,tmp4148) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp421,tmp422,tmp423,tmp424,tmp425,tmp426,tmp427,tmp428,tmp429,tmp4210,tmp4211,tmp4212,tmp4213,tmp4214,tmp4215,tmp4216,tmp4217,tmp4218,tmp4219,tmp4220,tmp4221,tmp4222,tmp4223,tmp4224,tmp4225,tmp4226,tmp4227,tmp4228,tmp4229,tmp4230,tmp4231,tmp4232,tmp4233,tmp4234,tmp4235,tmp4236,tmp4237,tmp4238,tmp4239,tmp4240,tmp4241,tmp4242,tmp4243,tmp4244,tmp4245,tmp4246,tmp4247,tmp4248) = roundkey11_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp411) land ((lnot (tmp421)))) lor (((lnot (tmp411))) land (tmp421)),((tmp412) land ((lnot (tmp422)))) lor (((lnot (tmp412))) land (tmp422)),((tmp413) land ((lnot (tmp423)))) lor (((lnot (tmp413))) land (tmp423)),((tmp414) land ((lnot (tmp424)))) lor (((lnot (tmp414))) land (tmp424)),((tmp415) land ((lnot (tmp425)))) lor (((lnot (tmp415))) land (tmp425)),((tmp416) land ((lnot (tmp426)))) lor (((lnot (tmp416))) land (tmp426)),((tmp417) land ((lnot (tmp427)))) lor (((lnot (tmp417))) land (tmp427)),((tmp418) land ((lnot (tmp428)))) lor (((lnot (tmp418))) land (tmp428)),((tmp419) land ((lnot (tmp429)))) lor (((lnot (tmp419))) land (tmp429)),((tmp4110) land ((lnot (tmp4210)))) lor (((lnot (tmp4110))) land (tmp4210)),((tmp4111) land ((lnot (tmp4211)))) lor (((lnot (tmp4111))) land (tmp4211)),((tmp4112) land ((lnot (tmp4212)))) lor (((lnot (tmp4112))) land (tmp4212)),((tmp4113) land ((lnot (tmp4213)))) lor (((lnot (tmp4113))) land (tmp4213)),((tmp4114) land ((lnot (tmp4214)))) lor (((lnot (tmp4114))) land (tmp4214)),((tmp4115) land ((lnot (tmp4215)))) lor (((lnot (tmp4115))) land (tmp4215)),((tmp4116) land ((lnot (tmp4216)))) lor (((lnot (tmp4116))) land (tmp4216)),((tmp4117) land ((lnot (tmp4217)))) lor (((lnot (tmp4117))) land (tmp4217)),((tmp4118) land ((lnot (tmp4218)))) lor (((lnot (tmp4118))) land (tmp4218)),((tmp4119) land ((lnot (tmp4219)))) lor (((lnot (tmp4119))) land (tmp4219)),((tmp4120) land ((lnot (tmp4220)))) lor (((lnot (tmp4120))) land (tmp4220)),((tmp4121) land ((lnot (tmp4221)))) lor (((lnot (tmp4121))) land (tmp4221)),((tmp4122) land ((lnot (tmp4222)))) lor (((lnot (tmp4122))) land (tmp4222)),((tmp4123) land ((lnot (tmp4223)))) lor (((lnot (tmp4123))) land (tmp4223)),((tmp4124) land ((lnot (tmp4224)))) lor (((lnot (tmp4124))) land (tmp4224)),((tmp4125) land ((lnot (tmp4225)))) lor (((lnot (tmp4125))) land (tmp4225)),((tmp4126) land ((lnot (tmp4226)))) lor (((lnot (tmp4126))) land (tmp4226)),((tmp4127) land ((lnot (tmp4227)))) lor (((lnot (tmp4127))) land (tmp4227)),((tmp4128) land ((lnot (tmp4228)))) lor (((lnot (tmp4128))) land (tmp4228)),((tmp4129) land ((lnot (tmp4229)))) lor (((lnot (tmp4129))) land (tmp4229)),((tmp4130) land ((lnot (tmp4230)))) lor (((lnot (tmp4130))) land (tmp4230)),((tmp4131) land ((lnot (tmp4231)))) lor (((lnot (tmp4131))) land (tmp4231)),((tmp4132) land ((lnot (tmp4232)))) lor (((lnot (tmp4132))) land (tmp4232)),((tmp4133) land ((lnot (tmp4233)))) lor (((lnot (tmp4133))) land (tmp4233)),((tmp4134) land ((lnot (tmp4234)))) lor (((lnot (tmp4134))) land (tmp4234)),((tmp4135) land ((lnot (tmp4235)))) lor (((lnot (tmp4135))) land (tmp4235)),((tmp4136) land ((lnot (tmp4236)))) lor (((lnot (tmp4136))) land (tmp4236)),((tmp4137) land ((lnot (tmp4237)))) lor (((lnot (tmp4137))) land (tmp4237)),((tmp4138) land ((lnot (tmp4238)))) lor (((lnot (tmp4138))) land (tmp4238)),((tmp4139) land ((lnot (tmp4239)))) lor (((lnot (tmp4139))) land (tmp4239)),((tmp4140) land ((lnot (tmp4240)))) lor (((lnot (tmp4140))) land (tmp4240)),((tmp4141) land ((lnot (tmp4241)))) lor (((lnot (tmp4141))) land (tmp4241)),((tmp4142) land ((lnot (tmp4242)))) lor (((lnot (tmp4142))) land (tmp4242)),((tmp4143) land ((lnot (tmp4243)))) lor (((lnot (tmp4143))) land (tmp4243)),((tmp4144) land ((lnot (tmp4244)))) lor (((lnot (tmp4144))) land (tmp4244)),((tmp4145) land ((lnot (tmp4245)))) lor (((lnot (tmp4145))) land (tmp4245)),((tmp4146) land ((lnot (tmp4246)))) lor (((lnot (tmp4146))) land (tmp4246)),((tmp4147) land ((lnot (tmp4247)))) lor (((lnot (tmp4147))) land (tmp4247)),((tmp4148) land ((lnot (tmp4248)))) lor (((lnot (tmp4148))) land (tmp4248))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp431,tmp432,tmp433,tmp434,tmp435,tmp436,tmp437,tmp438,tmp439,tmp4310,tmp4311,tmp4312,tmp4313,tmp4314,tmp4315,tmp4316,tmp4317,tmp4318,tmp4319,tmp4320,tmp4321,tmp4322,tmp4323,tmp4324,tmp4325,tmp4326,tmp4327,tmp4328,tmp4329,tmp4330,tmp4331,tmp4332) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp441,tmp442,tmp443,tmp444,tmp445,tmp446,tmp447,tmp448,tmp449,tmp4410,tmp4411,tmp4412,tmp4413,tmp4414,tmp4415,tmp4416,tmp4417,tmp4418,tmp4419,tmp4420,tmp4421,tmp4422,tmp4423,tmp4424,tmp4425,tmp4426,tmp4427,tmp4428,tmp4429,tmp4430,tmp4431,tmp4432) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp431) land ((lnot (tmp441)))) lor (((lnot (tmp431))) land (tmp441)),((tmp432) land ((lnot (tmp442)))) lor (((lnot (tmp432))) land (tmp442)),((tmp433) land ((lnot (tmp443)))) lor (((lnot (tmp433))) land (tmp443)),((tmp434) land ((lnot (tmp444)))) lor (((lnot (tmp434))) land (tmp444)),((tmp435) land ((lnot (tmp445)))) lor (((lnot (tmp435))) land (tmp445)),((tmp436) land ((lnot (tmp446)))) lor (((lnot (tmp436))) land (tmp446)),((tmp437) land ((lnot (tmp447)))) lor (((lnot (tmp437))) land (tmp447)),((tmp438) land ((lnot (tmp448)))) lor (((lnot (tmp438))) land (tmp448)),((tmp439) land ((lnot (tmp449)))) lor (((lnot (tmp439))) land (tmp449)),((tmp4310) land ((lnot (tmp4410)))) lor (((lnot (tmp4310))) land (tmp4410)),((tmp4311) land ((lnot (tmp4411)))) lor (((lnot (tmp4311))) land (tmp4411)),((tmp4312) land ((lnot (tmp4412)))) lor (((lnot (tmp4312))) land (tmp4412)),((tmp4313) land ((lnot (tmp4413)))) lor (((lnot (tmp4313))) land (tmp4413)),((tmp4314) land ((lnot (tmp4414)))) lor (((lnot (tmp4314))) land (tmp4414)),((tmp4315) land ((lnot (tmp4415)))) lor (((lnot (tmp4315))) land (tmp4415)),((tmp4316) land ((lnot (tmp4416)))) lor (((lnot (tmp4316))) land (tmp4416)),((tmp4317) land ((lnot (tmp4417)))) lor (((lnot (tmp4317))) land (tmp4417)),((tmp4318) land ((lnot (tmp4418)))) lor (((lnot (tmp4318))) land (tmp4418)),((tmp4319) land ((lnot (tmp4419)))) lor (((lnot (tmp4319))) land (tmp4419)),((tmp4320) land ((lnot (tmp4420)))) lor (((lnot (tmp4320))) land (tmp4420)),((tmp4321) land ((lnot (tmp4421)))) lor (((lnot (tmp4321))) land (tmp4421)),((tmp4322) land ((lnot (tmp4422)))) lor (((lnot (tmp4322))) land (tmp4422)),((tmp4323) land ((lnot (tmp4423)))) lor (((lnot (tmp4323))) land (tmp4423)),((tmp4324) land ((lnot (tmp4424)))) lor (((lnot (tmp4324))) land (tmp4424)),((tmp4325) land ((lnot (tmp4425)))) lor (((lnot (tmp4325))) land (tmp4425)),((tmp4326) land ((lnot (tmp4426)))) lor (((lnot (tmp4326))) land (tmp4426)),((tmp4327) land ((lnot (tmp4427)))) lor (((lnot (tmp4327))) land (tmp4427)),((tmp4328) land ((lnot (tmp4428)))) lor (((lnot (tmp4328))) land (tmp4428)),((tmp4329) land ((lnot (tmp4429)))) lor (((lnot (tmp4329))) land (tmp4429)),((tmp4330) land ((lnot (tmp4430)))) lor (((lnot (tmp4330))) land (tmp4430)),((tmp4331) land ((lnot (tmp4431)))) lor (((lnot (tmp4331))) land (tmp4431)),((tmp4332) land ((lnot (tmp4432)))) lor (((lnot (tmp4332))) land (tmp4432))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single12_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp451,tmp452,tmp453,tmp454,tmp455,tmp456,tmp457,tmp458,tmp459,tmp4510,tmp4511,tmp4512,tmp4513,tmp4514,tmp4515,tmp4516,tmp4517,tmp4518,tmp4519,tmp4520,tmp4521,tmp4522,tmp4523,tmp4524,tmp4525,tmp4526,tmp4527,tmp4528,tmp4529,tmp4530,tmp4531,tmp4532,tmp4533,tmp4534,tmp4535,tmp4536,tmp4537,tmp4538,tmp4539,tmp4540,tmp4541,tmp4542,tmp4543,tmp4544,tmp4545,tmp4546,tmp4547,tmp4548) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp461,tmp462,tmp463,tmp464,tmp465,tmp466,tmp467,tmp468,tmp469,tmp4610,tmp4611,tmp4612,tmp4613,tmp4614,tmp4615,tmp4616,tmp4617,tmp4618,tmp4619,tmp4620,tmp4621,tmp4622,tmp4623,tmp4624,tmp4625,tmp4626,tmp4627,tmp4628,tmp4629,tmp4630,tmp4631,tmp4632,tmp4633,tmp4634,tmp4635,tmp4636,tmp4637,tmp4638,tmp4639,tmp4640,tmp4641,tmp4642,tmp4643,tmp4644,tmp4645,tmp4646,tmp4647,tmp4648) = roundkey12_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp451) land ((lnot (tmp461)))) lor (((lnot (tmp451))) land (tmp461)),((tmp452) land ((lnot (tmp462)))) lor (((lnot (tmp452))) land (tmp462)),((tmp453) land ((lnot (tmp463)))) lor (((lnot (tmp453))) land (tmp463)),((tmp454) land ((lnot (tmp464)))) lor (((lnot (tmp454))) land (tmp464)),((tmp455) land ((lnot (tmp465)))) lor (((lnot (tmp455))) land (tmp465)),((tmp456) land ((lnot (tmp466)))) lor (((lnot (tmp456))) land (tmp466)),((tmp457) land ((lnot (tmp467)))) lor (((lnot (tmp457))) land (tmp467)),((tmp458) land ((lnot (tmp468)))) lor (((lnot (tmp458))) land (tmp468)),((tmp459) land ((lnot (tmp469)))) lor (((lnot (tmp459))) land (tmp469)),((tmp4510) land ((lnot (tmp4610)))) lor (((lnot (tmp4510))) land (tmp4610)),((tmp4511) land ((lnot (tmp4611)))) lor (((lnot (tmp4511))) land (tmp4611)),((tmp4512) land ((lnot (tmp4612)))) lor (((lnot (tmp4512))) land (tmp4612)),((tmp4513) land ((lnot (tmp4613)))) lor (((lnot (tmp4513))) land (tmp4613)),((tmp4514) land ((lnot (tmp4614)))) lor (((lnot (tmp4514))) land (tmp4614)),((tmp4515) land ((lnot (tmp4615)))) lor (((lnot (tmp4515))) land (tmp4615)),((tmp4516) land ((lnot (tmp4616)))) lor (((lnot (tmp4516))) land (tmp4616)),((tmp4517) land ((lnot (tmp4617)))) lor (((lnot (tmp4517))) land (tmp4617)),((tmp4518) land ((lnot (tmp4618)))) lor (((lnot (tmp4518))) land (tmp4618)),((tmp4519) land ((lnot (tmp4619)))) lor (((lnot (tmp4519))) land (tmp4619)),((tmp4520) land ((lnot (tmp4620)))) lor (((lnot (tmp4520))) land (tmp4620)),((tmp4521) land ((lnot (tmp4621)))) lor (((lnot (tmp4521))) land (tmp4621)),((tmp4522) land ((lnot (tmp4622)))) lor (((lnot (tmp4522))) land (tmp4622)),((tmp4523) land ((lnot (tmp4623)))) lor (((lnot (tmp4523))) land (tmp4623)),((tmp4524) land ((lnot (tmp4624)))) lor (((lnot (tmp4524))) land (tmp4624)),((tmp4525) land ((lnot (tmp4625)))) lor (((lnot (tmp4525))) land (tmp4625)),((tmp4526) land ((lnot (tmp4626)))) lor (((lnot (tmp4526))) land (tmp4626)),((tmp4527) land ((lnot (tmp4627)))) lor (((lnot (tmp4527))) land (tmp4627)),((tmp4528) land ((lnot (tmp4628)))) lor (((lnot (tmp4528))) land (tmp4628)),((tmp4529) land ((lnot (tmp4629)))) lor (((lnot (tmp4529))) land (tmp4629)),((tmp4530) land ((lnot (tmp4630)))) lor (((lnot (tmp4530))) land (tmp4630)),((tmp4531) land ((lnot (tmp4631)))) lor (((lnot (tmp4531))) land (tmp4631)),((tmp4532) land ((lnot (tmp4632)))) lor (((lnot (tmp4532))) land (tmp4632)),((tmp4533) land ((lnot (tmp4633)))) lor (((lnot (tmp4533))) land (tmp4633)),((tmp4534) land ((lnot (tmp4634)))) lor (((lnot (tmp4534))) land (tmp4634)),((tmp4535) land ((lnot (tmp4635)))) lor (((lnot (tmp4535))) land (tmp4635)),((tmp4536) land ((lnot (tmp4636)))) lor (((lnot (tmp4536))) land (tmp4636)),((tmp4537) land ((lnot (tmp4637)))) lor (((lnot (tmp4537))) land (tmp4637)),((tmp4538) land ((lnot (tmp4638)))) lor (((lnot (tmp4538))) land (tmp4638)),((tmp4539) land ((lnot (tmp4639)))) lor (((lnot (tmp4539))) land (tmp4639)),((tmp4540) land ((lnot (tmp4640)))) lor (((lnot (tmp4540))) land (tmp4640)),((tmp4541) land ((lnot (tmp4641)))) lor (((lnot (tmp4541))) land (tmp4641)),((tmp4542) land ((lnot (tmp4642)))) lor (((lnot (tmp4542))) land (tmp4642)),((tmp4543) land ((lnot (tmp4643)))) lor (((lnot (tmp4543))) land (tmp4643)),((tmp4544) land ((lnot (tmp4644)))) lor (((lnot (tmp4544))) land (tmp4644)),((tmp4545) land ((lnot (tmp4645)))) lor (((lnot (tmp4545))) land (tmp4645)),((tmp4546) land ((lnot (tmp4646)))) lor (((lnot (tmp4546))) land (tmp4646)),((tmp4547) land ((lnot (tmp4647)))) lor (((lnot (tmp4547))) land (tmp4647)),((tmp4548) land ((lnot (tmp4648)))) lor (((lnot (tmp4548))) land (tmp4648))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp471,tmp472,tmp473,tmp474,tmp475,tmp476,tmp477,tmp478,tmp479,tmp4710,tmp4711,tmp4712,tmp4713,tmp4714,tmp4715,tmp4716,tmp4717,tmp4718,tmp4719,tmp4720,tmp4721,tmp4722,tmp4723,tmp4724,tmp4725,tmp4726,tmp4727,tmp4728,tmp4729,tmp4730,tmp4731,tmp4732) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp481,tmp482,tmp483,tmp484,tmp485,tmp486,tmp487,tmp488,tmp489,tmp4810,tmp4811,tmp4812,tmp4813,tmp4814,tmp4815,tmp4816,tmp4817,tmp4818,tmp4819,tmp4820,tmp4821,tmp4822,tmp4823,tmp4824,tmp4825,tmp4826,tmp4827,tmp4828,tmp4829,tmp4830,tmp4831,tmp4832) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp471) land ((lnot (tmp481)))) lor (((lnot (tmp471))) land (tmp481)),((tmp472) land ((lnot (tmp482)))) lor (((lnot (tmp472))) land (tmp482)),((tmp473) land ((lnot (tmp483)))) lor (((lnot (tmp473))) land (tmp483)),((tmp474) land ((lnot (tmp484)))) lor (((lnot (tmp474))) land (tmp484)),((tmp475) land ((lnot (tmp485)))) lor (((lnot (tmp475))) land (tmp485)),((tmp476) land ((lnot (tmp486)))) lor (((lnot (tmp476))) land (tmp486)),((tmp477) land ((lnot (tmp487)))) lor (((lnot (tmp477))) land (tmp487)),((tmp478) land ((lnot (tmp488)))) lor (((lnot (tmp478))) land (tmp488)),((tmp479) land ((lnot (tmp489)))) lor (((lnot (tmp479))) land (tmp489)),((tmp4710) land ((lnot (tmp4810)))) lor (((lnot (tmp4710))) land (tmp4810)),((tmp4711) land ((lnot (tmp4811)))) lor (((lnot (tmp4711))) land (tmp4811)),((tmp4712) land ((lnot (tmp4812)))) lor (((lnot (tmp4712))) land (tmp4812)),((tmp4713) land ((lnot (tmp4813)))) lor (((lnot (tmp4713))) land (tmp4813)),((tmp4714) land ((lnot (tmp4814)))) lor (((lnot (tmp4714))) land (tmp4814)),((tmp4715) land ((lnot (tmp4815)))) lor (((lnot (tmp4715))) land (tmp4815)),((tmp4716) land ((lnot (tmp4816)))) lor (((lnot (tmp4716))) land (tmp4816)),((tmp4717) land ((lnot (tmp4817)))) lor (((lnot (tmp4717))) land (tmp4817)),((tmp4718) land ((lnot (tmp4818)))) lor (((lnot (tmp4718))) land (tmp4818)),((tmp4719) land ((lnot (tmp4819)))) lor (((lnot (tmp4719))) land (tmp4819)),((tmp4720) land ((lnot (tmp4820)))) lor (((lnot (tmp4720))) land (tmp4820)),((tmp4721) land ((lnot (tmp4821)))) lor (((lnot (tmp4721))) land (tmp4821)),((tmp4722) land ((lnot (tmp4822)))) lor (((lnot (tmp4722))) land (tmp4822)),((tmp4723) land ((lnot (tmp4823)))) lor (((lnot (tmp4723))) land (tmp4823)),((tmp4724) land ((lnot (tmp4824)))) lor (((lnot (tmp4724))) land (tmp4824)),((tmp4725) land ((lnot (tmp4825)))) lor (((lnot (tmp4725))) land (tmp4825)),((tmp4726) land ((lnot (tmp4826)))) lor (((lnot (tmp4726))) land (tmp4826)),((tmp4727) land ((lnot (tmp4827)))) lor (((lnot (tmp4727))) land (tmp4827)),((tmp4728) land ((lnot (tmp4828)))) lor (((lnot (tmp4728))) land (tmp4828)),((tmp4729) land ((lnot (tmp4829)))) lor (((lnot (tmp4729))) land (tmp4829)),((tmp4730) land ((lnot (tmp4830)))) lor (((lnot (tmp4730))) land (tmp4830)),((tmp4731) land ((lnot (tmp4831)))) lor (((lnot (tmp4731))) land (tmp4831)),((tmp4732) land ((lnot (tmp4832)))) lor (((lnot (tmp4732))) land (tmp4832))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single13_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp491,tmp492,tmp493,tmp494,tmp495,tmp496,tmp497,tmp498,tmp499,tmp4910,tmp4911,tmp4912,tmp4913,tmp4914,tmp4915,tmp4916,tmp4917,tmp4918,tmp4919,tmp4920,tmp4921,tmp4922,tmp4923,tmp4924,tmp4925,tmp4926,tmp4927,tmp4928,tmp4929,tmp4930,tmp4931,tmp4932,tmp4933,tmp4934,tmp4935,tmp4936,tmp4937,tmp4938,tmp4939,tmp4940,tmp4941,tmp4942,tmp4943,tmp4944,tmp4945,tmp4946,tmp4947,tmp4948) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp501,tmp502,tmp503,tmp504,tmp505,tmp506,tmp507,tmp508,tmp509,tmp5010,tmp5011,tmp5012,tmp5013,tmp5014,tmp5015,tmp5016,tmp5017,tmp5018,tmp5019,tmp5020,tmp5021,tmp5022,tmp5023,tmp5024,tmp5025,tmp5026,tmp5027,tmp5028,tmp5029,tmp5030,tmp5031,tmp5032,tmp5033,tmp5034,tmp5035,tmp5036,tmp5037,tmp5038,tmp5039,tmp5040,tmp5041,tmp5042,tmp5043,tmp5044,tmp5045,tmp5046,tmp5047,tmp5048) = roundkey13_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp491) land ((lnot (tmp501)))) lor (((lnot (tmp491))) land (tmp501)),((tmp492) land ((lnot (tmp502)))) lor (((lnot (tmp492))) land (tmp502)),((tmp493) land ((lnot (tmp503)))) lor (((lnot (tmp493))) land (tmp503)),((tmp494) land ((lnot (tmp504)))) lor (((lnot (tmp494))) land (tmp504)),((tmp495) land ((lnot (tmp505)))) lor (((lnot (tmp495))) land (tmp505)),((tmp496) land ((lnot (tmp506)))) lor (((lnot (tmp496))) land (tmp506)),((tmp497) land ((lnot (tmp507)))) lor (((lnot (tmp497))) land (tmp507)),((tmp498) land ((lnot (tmp508)))) lor (((lnot (tmp498))) land (tmp508)),((tmp499) land ((lnot (tmp509)))) lor (((lnot (tmp499))) land (tmp509)),((tmp4910) land ((lnot (tmp5010)))) lor (((lnot (tmp4910))) land (tmp5010)),((tmp4911) land ((lnot (tmp5011)))) lor (((lnot (tmp4911))) land (tmp5011)),((tmp4912) land ((lnot (tmp5012)))) lor (((lnot (tmp4912))) land (tmp5012)),((tmp4913) land ((lnot (tmp5013)))) lor (((lnot (tmp4913))) land (tmp5013)),((tmp4914) land ((lnot (tmp5014)))) lor (((lnot (tmp4914))) land (tmp5014)),((tmp4915) land ((lnot (tmp5015)))) lor (((lnot (tmp4915))) land (tmp5015)),((tmp4916) land ((lnot (tmp5016)))) lor (((lnot (tmp4916))) land (tmp5016)),((tmp4917) land ((lnot (tmp5017)))) lor (((lnot (tmp4917))) land (tmp5017)),((tmp4918) land ((lnot (tmp5018)))) lor (((lnot (tmp4918))) land (tmp5018)),((tmp4919) land ((lnot (tmp5019)))) lor (((lnot (tmp4919))) land (tmp5019)),((tmp4920) land ((lnot (tmp5020)))) lor (((lnot (tmp4920))) land (tmp5020)),((tmp4921) land ((lnot (tmp5021)))) lor (((lnot (tmp4921))) land (tmp5021)),((tmp4922) land ((lnot (tmp5022)))) lor (((lnot (tmp4922))) land (tmp5022)),((tmp4923) land ((lnot (tmp5023)))) lor (((lnot (tmp4923))) land (tmp5023)),((tmp4924) land ((lnot (tmp5024)))) lor (((lnot (tmp4924))) land (tmp5024)),((tmp4925) land ((lnot (tmp5025)))) lor (((lnot (tmp4925))) land (tmp5025)),((tmp4926) land ((lnot (tmp5026)))) lor (((lnot (tmp4926))) land (tmp5026)),((tmp4927) land ((lnot (tmp5027)))) lor (((lnot (tmp4927))) land (tmp5027)),((tmp4928) land ((lnot (tmp5028)))) lor (((lnot (tmp4928))) land (tmp5028)),((tmp4929) land ((lnot (tmp5029)))) lor (((lnot (tmp4929))) land (tmp5029)),((tmp4930) land ((lnot (tmp5030)))) lor (((lnot (tmp4930))) land (tmp5030)),((tmp4931) land ((lnot (tmp5031)))) lor (((lnot (tmp4931))) land (tmp5031)),((tmp4932) land ((lnot (tmp5032)))) lor (((lnot (tmp4932))) land (tmp5032)),((tmp4933) land ((lnot (tmp5033)))) lor (((lnot (tmp4933))) land (tmp5033)),((tmp4934) land ((lnot (tmp5034)))) lor (((lnot (tmp4934))) land (tmp5034)),((tmp4935) land ((lnot (tmp5035)))) lor (((lnot (tmp4935))) land (tmp5035)),((tmp4936) land ((lnot (tmp5036)))) lor (((lnot (tmp4936))) land (tmp5036)),((tmp4937) land ((lnot (tmp5037)))) lor (((lnot (tmp4937))) land (tmp5037)),((tmp4938) land ((lnot (tmp5038)))) lor (((lnot (tmp4938))) land (tmp5038)),((tmp4939) land ((lnot (tmp5039)))) lor (((lnot (tmp4939))) land (tmp5039)),((tmp4940) land ((lnot (tmp5040)))) lor (((lnot (tmp4940))) land (tmp5040)),((tmp4941) land ((lnot (tmp5041)))) lor (((lnot (tmp4941))) land (tmp5041)),((tmp4942) land ((lnot (tmp5042)))) lor (((lnot (tmp4942))) land (tmp5042)),((tmp4943) land ((lnot (tmp5043)))) lor (((lnot (tmp4943))) land (tmp5043)),((tmp4944) land ((lnot (tmp5044)))) lor (((lnot (tmp4944))) land (tmp5044)),((tmp4945) land ((lnot (tmp5045)))) lor (((lnot (tmp4945))) land (tmp5045)),((tmp4946) land ((lnot (tmp5046)))) lor (((lnot (tmp4946))) land (tmp5046)),((tmp4947) land ((lnot (tmp5047)))) lor (((lnot (tmp4947))) land (tmp5047)),((tmp4948) land ((lnot (tmp5048)))) lor (((lnot (tmp4948))) land (tmp5048))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp511,tmp512,tmp513,tmp514,tmp515,tmp516,tmp517,tmp518,tmp519,tmp5110,tmp5111,tmp5112,tmp5113,tmp5114,tmp5115,tmp5116,tmp5117,tmp5118,tmp5119,tmp5120,tmp5121,tmp5122,tmp5123,tmp5124,tmp5125,tmp5126,tmp5127,tmp5128,tmp5129,tmp5130,tmp5131,tmp5132) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp521,tmp522,tmp523,tmp524,tmp525,tmp526,tmp527,tmp528,tmp529,tmp5210,tmp5211,tmp5212,tmp5213,tmp5214,tmp5215,tmp5216,tmp5217,tmp5218,tmp5219,tmp5220,tmp5221,tmp5222,tmp5223,tmp5224,tmp5225,tmp5226,tmp5227,tmp5228,tmp5229,tmp5230,tmp5231,tmp5232) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp511) land ((lnot (tmp521)))) lor (((lnot (tmp511))) land (tmp521)),((tmp512) land ((lnot (tmp522)))) lor (((lnot (tmp512))) land (tmp522)),((tmp513) land ((lnot (tmp523)))) lor (((lnot (tmp513))) land (tmp523)),((tmp514) land ((lnot (tmp524)))) lor (((lnot (tmp514))) land (tmp524)),((tmp515) land ((lnot (tmp525)))) lor (((lnot (tmp515))) land (tmp525)),((tmp516) land ((lnot (tmp526)))) lor (((lnot (tmp516))) land (tmp526)),((tmp517) land ((lnot (tmp527)))) lor (((lnot (tmp517))) land (tmp527)),((tmp518) land ((lnot (tmp528)))) lor (((lnot (tmp518))) land (tmp528)),((tmp519) land ((lnot (tmp529)))) lor (((lnot (tmp519))) land (tmp529)),((tmp5110) land ((lnot (tmp5210)))) lor (((lnot (tmp5110))) land (tmp5210)),((tmp5111) land ((lnot (tmp5211)))) lor (((lnot (tmp5111))) land (tmp5211)),((tmp5112) land ((lnot (tmp5212)))) lor (((lnot (tmp5112))) land (tmp5212)),((tmp5113) land ((lnot (tmp5213)))) lor (((lnot (tmp5113))) land (tmp5213)),((tmp5114) land ((lnot (tmp5214)))) lor (((lnot (tmp5114))) land (tmp5214)),((tmp5115) land ((lnot (tmp5215)))) lor (((lnot (tmp5115))) land (tmp5215)),((tmp5116) land ((lnot (tmp5216)))) lor (((lnot (tmp5116))) land (tmp5216)),((tmp5117) land ((lnot (tmp5217)))) lor (((lnot (tmp5117))) land (tmp5217)),((tmp5118) land ((lnot (tmp5218)))) lor (((lnot (tmp5118))) land (tmp5218)),((tmp5119) land ((lnot (tmp5219)))) lor (((lnot (tmp5119))) land (tmp5219)),((tmp5120) land ((lnot (tmp5220)))) lor (((lnot (tmp5120))) land (tmp5220)),((tmp5121) land ((lnot (tmp5221)))) lor (((lnot (tmp5121))) land (tmp5221)),((tmp5122) land ((lnot (tmp5222)))) lor (((lnot (tmp5122))) land (tmp5222)),((tmp5123) land ((lnot (tmp5223)))) lor (((lnot (tmp5123))) land (tmp5223)),((tmp5124) land ((lnot (tmp5224)))) lor (((lnot (tmp5124))) land (tmp5224)),((tmp5125) land ((lnot (tmp5225)))) lor (((lnot (tmp5125))) land (tmp5225)),((tmp5126) land ((lnot (tmp5226)))) lor (((lnot (tmp5126))) land (tmp5226)),((tmp5127) land ((lnot (tmp5227)))) lor (((lnot (tmp5127))) land (tmp5227)),((tmp5128) land ((lnot (tmp5228)))) lor (((lnot (tmp5128))) land (tmp5228)),((tmp5129) land ((lnot (tmp5229)))) lor (((lnot (tmp5129))) land (tmp5229)),((tmp5130) land ((lnot (tmp5230)))) lor (((lnot (tmp5130))) land (tmp5230)),((tmp5131) land ((lnot (tmp5231)))) lor (((lnot (tmp5131))) land (tmp5231)),((tmp5132) land ((lnot (tmp5232)))) lor (((lnot (tmp5132))) land (tmp5232))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single14_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp531,tmp532,tmp533,tmp534,tmp535,tmp536,tmp537,tmp538,tmp539,tmp5310,tmp5311,tmp5312,tmp5313,tmp5314,tmp5315,tmp5316,tmp5317,tmp5318,tmp5319,tmp5320,tmp5321,tmp5322,tmp5323,tmp5324,tmp5325,tmp5326,tmp5327,tmp5328,tmp5329,tmp5330,tmp5331,tmp5332,tmp5333,tmp5334,tmp5335,tmp5336,tmp5337,tmp5338,tmp5339,tmp5340,tmp5341,tmp5342,tmp5343,tmp5344,tmp5345,tmp5346,tmp5347,tmp5348) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp541,tmp542,tmp543,tmp544,tmp545,tmp546,tmp547,tmp548,tmp549,tmp5410,tmp5411,tmp5412,tmp5413,tmp5414,tmp5415,tmp5416,tmp5417,tmp5418,tmp5419,tmp5420,tmp5421,tmp5422,tmp5423,tmp5424,tmp5425,tmp5426,tmp5427,tmp5428,tmp5429,tmp5430,tmp5431,tmp5432,tmp5433,tmp5434,tmp5435,tmp5436,tmp5437,tmp5438,tmp5439,tmp5440,tmp5441,tmp5442,tmp5443,tmp5444,tmp5445,tmp5446,tmp5447,tmp5448) = roundkey14_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp531) land ((lnot (tmp541)))) lor (((lnot (tmp531))) land (tmp541)),((tmp532) land ((lnot (tmp542)))) lor (((lnot (tmp532))) land (tmp542)),((tmp533) land ((lnot (tmp543)))) lor (((lnot (tmp533))) land (tmp543)),((tmp534) land ((lnot (tmp544)))) lor (((lnot (tmp534))) land (tmp544)),((tmp535) land ((lnot (tmp545)))) lor (((lnot (tmp535))) land (tmp545)),((tmp536) land ((lnot (tmp546)))) lor (((lnot (tmp536))) land (tmp546)),((tmp537) land ((lnot (tmp547)))) lor (((lnot (tmp537))) land (tmp547)),((tmp538) land ((lnot (tmp548)))) lor (((lnot (tmp538))) land (tmp548)),((tmp539) land ((lnot (tmp549)))) lor (((lnot (tmp539))) land (tmp549)),((tmp5310) land ((lnot (tmp5410)))) lor (((lnot (tmp5310))) land (tmp5410)),((tmp5311) land ((lnot (tmp5411)))) lor (((lnot (tmp5311))) land (tmp5411)),((tmp5312) land ((lnot (tmp5412)))) lor (((lnot (tmp5312))) land (tmp5412)),((tmp5313) land ((lnot (tmp5413)))) lor (((lnot (tmp5313))) land (tmp5413)),((tmp5314) land ((lnot (tmp5414)))) lor (((lnot (tmp5314))) land (tmp5414)),((tmp5315) land ((lnot (tmp5415)))) lor (((lnot (tmp5315))) land (tmp5415)),((tmp5316) land ((lnot (tmp5416)))) lor (((lnot (tmp5316))) land (tmp5416)),((tmp5317) land ((lnot (tmp5417)))) lor (((lnot (tmp5317))) land (tmp5417)),((tmp5318) land ((lnot (tmp5418)))) lor (((lnot (tmp5318))) land (tmp5418)),((tmp5319) land ((lnot (tmp5419)))) lor (((lnot (tmp5319))) land (tmp5419)),((tmp5320) land ((lnot (tmp5420)))) lor (((lnot (tmp5320))) land (tmp5420)),((tmp5321) land ((lnot (tmp5421)))) lor (((lnot (tmp5321))) land (tmp5421)),((tmp5322) land ((lnot (tmp5422)))) lor (((lnot (tmp5322))) land (tmp5422)),((tmp5323) land ((lnot (tmp5423)))) lor (((lnot (tmp5323))) land (tmp5423)),((tmp5324) land ((lnot (tmp5424)))) lor (((lnot (tmp5324))) land (tmp5424)),((tmp5325) land ((lnot (tmp5425)))) lor (((lnot (tmp5325))) land (tmp5425)),((tmp5326) land ((lnot (tmp5426)))) lor (((lnot (tmp5326))) land (tmp5426)),((tmp5327) land ((lnot (tmp5427)))) lor (((lnot (tmp5327))) land (tmp5427)),((tmp5328) land ((lnot (tmp5428)))) lor (((lnot (tmp5328))) land (tmp5428)),((tmp5329) land ((lnot (tmp5429)))) lor (((lnot (tmp5329))) land (tmp5429)),((tmp5330) land ((lnot (tmp5430)))) lor (((lnot (tmp5330))) land (tmp5430)),((tmp5331) land ((lnot (tmp5431)))) lor (((lnot (tmp5331))) land (tmp5431)),((tmp5332) land ((lnot (tmp5432)))) lor (((lnot (tmp5332))) land (tmp5432)),((tmp5333) land ((lnot (tmp5433)))) lor (((lnot (tmp5333))) land (tmp5433)),((tmp5334) land ((lnot (tmp5434)))) lor (((lnot (tmp5334))) land (tmp5434)),((tmp5335) land ((lnot (tmp5435)))) lor (((lnot (tmp5335))) land (tmp5435)),((tmp5336) land ((lnot (tmp5436)))) lor (((lnot (tmp5336))) land (tmp5436)),((tmp5337) land ((lnot (tmp5437)))) lor (((lnot (tmp5337))) land (tmp5437)),((tmp5338) land ((lnot (tmp5438)))) lor (((lnot (tmp5338))) land (tmp5438)),((tmp5339) land ((lnot (tmp5439)))) lor (((lnot (tmp5339))) land (tmp5439)),((tmp5340) land ((lnot (tmp5440)))) lor (((lnot (tmp5340))) land (tmp5440)),((tmp5341) land ((lnot (tmp5441)))) lor (((lnot (tmp5341))) land (tmp5441)),((tmp5342) land ((lnot (tmp5442)))) lor (((lnot (tmp5342))) land (tmp5442)),((tmp5343) land ((lnot (tmp5443)))) lor (((lnot (tmp5343))) land (tmp5443)),((tmp5344) land ((lnot (tmp5444)))) lor (((lnot (tmp5344))) land (tmp5444)),((tmp5345) land ((lnot (tmp5445)))) lor (((lnot (tmp5345))) land (tmp5445)),((tmp5346) land ((lnot (tmp5446)))) lor (((lnot (tmp5346))) land (tmp5446)),((tmp5347) land ((lnot (tmp5447)))) lor (((lnot (tmp5347))) land (tmp5447)),((tmp5348) land ((lnot (tmp5448)))) lor (((lnot (tmp5348))) land (tmp5448))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp551,tmp552,tmp553,tmp554,tmp555,tmp556,tmp557,tmp558,tmp559,tmp5510,tmp5511,tmp5512,tmp5513,tmp5514,tmp5515,tmp5516,tmp5517,tmp5518,tmp5519,tmp5520,tmp5521,tmp5522,tmp5523,tmp5524,tmp5525,tmp5526,tmp5527,tmp5528,tmp5529,tmp5530,tmp5531,tmp5532) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp561,tmp562,tmp563,tmp564,tmp565,tmp566,tmp567,tmp568,tmp569,tmp5610,tmp5611,tmp5612,tmp5613,tmp5614,tmp5615,tmp5616,tmp5617,tmp5618,tmp5619,tmp5620,tmp5621,tmp5622,tmp5623,tmp5624,tmp5625,tmp5626,tmp5627,tmp5628,tmp5629,tmp5630,tmp5631,tmp5632) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp551) land ((lnot (tmp561)))) lor (((lnot (tmp551))) land (tmp561)),((tmp552) land ((lnot (tmp562)))) lor (((lnot (tmp552))) land (tmp562)),((tmp553) land ((lnot (tmp563)))) lor (((lnot (tmp553))) land (tmp563)),((tmp554) land ((lnot (tmp564)))) lor (((lnot (tmp554))) land (tmp564)),((tmp555) land ((lnot (tmp565)))) lor (((lnot (tmp555))) land (tmp565)),((tmp556) land ((lnot (tmp566)))) lor (((lnot (tmp556))) land (tmp566)),((tmp557) land ((lnot (tmp567)))) lor (((lnot (tmp557))) land (tmp567)),((tmp558) land ((lnot (tmp568)))) lor (((lnot (tmp558))) land (tmp568)),((tmp559) land ((lnot (tmp569)))) lor (((lnot (tmp559))) land (tmp569)),((tmp5510) land ((lnot (tmp5610)))) lor (((lnot (tmp5510))) land (tmp5610)),((tmp5511) land ((lnot (tmp5611)))) lor (((lnot (tmp5511))) land (tmp5611)),((tmp5512) land ((lnot (tmp5612)))) lor (((lnot (tmp5512))) land (tmp5612)),((tmp5513) land ((lnot (tmp5613)))) lor (((lnot (tmp5513))) land (tmp5613)),((tmp5514) land ((lnot (tmp5614)))) lor (((lnot (tmp5514))) land (tmp5614)),((tmp5515) land ((lnot (tmp5615)))) lor (((lnot (tmp5515))) land (tmp5615)),((tmp5516) land ((lnot (tmp5616)))) lor (((lnot (tmp5516))) land (tmp5616)),((tmp5517) land ((lnot (tmp5617)))) lor (((lnot (tmp5517))) land (tmp5617)),((tmp5518) land ((lnot (tmp5618)))) lor (((lnot (tmp5518))) land (tmp5618)),((tmp5519) land ((lnot (tmp5619)))) lor (((lnot (tmp5519))) land (tmp5619)),((tmp5520) land ((lnot (tmp5620)))) lor (((lnot (tmp5520))) land (tmp5620)),((tmp5521) land ((lnot (tmp5621)))) lor (((lnot (tmp5521))) land (tmp5621)),((tmp5522) land ((lnot (tmp5622)))) lor (((lnot (tmp5522))) land (tmp5622)),((tmp5523) land ((lnot (tmp5623)))) lor (((lnot (tmp5523))) land (tmp5623)),((tmp5524) land ((lnot (tmp5624)))) lor (((lnot (tmp5524))) land (tmp5624)),((tmp5525) land ((lnot (tmp5625)))) lor (((lnot (tmp5525))) land (tmp5625)),((tmp5526) land ((lnot (tmp5626)))) lor (((lnot (tmp5526))) land (tmp5626)),((tmp5527) land ((lnot (tmp5627)))) lor (((lnot (tmp5527))) land (tmp5627)),((tmp5528) land ((lnot (tmp5628)))) lor (((lnot (tmp5528))) land (tmp5628)),((tmp5529) land ((lnot (tmp5629)))) lor (((lnot (tmp5529))) land (tmp5629)),((tmp5530) land ((lnot (tmp5630)))) lor (((lnot (tmp5530))) land (tmp5630)),((tmp5531) land ((lnot (tmp5631)))) lor (((lnot (tmp5531))) land (tmp5631)),((tmp5532) land ((lnot (tmp5632)))) lor (((lnot (tmp5532))) land (tmp5632))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single15_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp571,tmp572,tmp573,tmp574,tmp575,tmp576,tmp577,tmp578,tmp579,tmp5710,tmp5711,tmp5712,tmp5713,tmp5714,tmp5715,tmp5716,tmp5717,tmp5718,tmp5719,tmp5720,tmp5721,tmp5722,tmp5723,tmp5724,tmp5725,tmp5726,tmp5727,tmp5728,tmp5729,tmp5730,tmp5731,tmp5732,tmp5733,tmp5734,tmp5735,tmp5736,tmp5737,tmp5738,tmp5739,tmp5740,tmp5741,tmp5742,tmp5743,tmp5744,tmp5745,tmp5746,tmp5747,tmp5748) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp581,tmp582,tmp583,tmp584,tmp585,tmp586,tmp587,tmp588,tmp589,tmp5810,tmp5811,tmp5812,tmp5813,tmp5814,tmp5815,tmp5816,tmp5817,tmp5818,tmp5819,tmp5820,tmp5821,tmp5822,tmp5823,tmp5824,tmp5825,tmp5826,tmp5827,tmp5828,tmp5829,tmp5830,tmp5831,tmp5832,tmp5833,tmp5834,tmp5835,tmp5836,tmp5837,tmp5838,tmp5839,tmp5840,tmp5841,tmp5842,tmp5843,tmp5844,tmp5845,tmp5846,tmp5847,tmp5848) = roundkey15_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp571) land ((lnot (tmp581)))) lor (((lnot (tmp571))) land (tmp581)),((tmp572) land ((lnot (tmp582)))) lor (((lnot (tmp572))) land (tmp582)),((tmp573) land ((lnot (tmp583)))) lor (((lnot (tmp573))) land (tmp583)),((tmp574) land ((lnot (tmp584)))) lor (((lnot (tmp574))) land (tmp584)),((tmp575) land ((lnot (tmp585)))) lor (((lnot (tmp575))) land (tmp585)),((tmp576) land ((lnot (tmp586)))) lor (((lnot (tmp576))) land (tmp586)),((tmp577) land ((lnot (tmp587)))) lor (((lnot (tmp577))) land (tmp587)),((tmp578) land ((lnot (tmp588)))) lor (((lnot (tmp578))) land (tmp588)),((tmp579) land ((lnot (tmp589)))) lor (((lnot (tmp579))) land (tmp589)),((tmp5710) land ((lnot (tmp5810)))) lor (((lnot (tmp5710))) land (tmp5810)),((tmp5711) land ((lnot (tmp5811)))) lor (((lnot (tmp5711))) land (tmp5811)),((tmp5712) land ((lnot (tmp5812)))) lor (((lnot (tmp5712))) land (tmp5812)),((tmp5713) land ((lnot (tmp5813)))) lor (((lnot (tmp5713))) land (tmp5813)),((tmp5714) land ((lnot (tmp5814)))) lor (((lnot (tmp5714))) land (tmp5814)),((tmp5715) land ((lnot (tmp5815)))) lor (((lnot (tmp5715))) land (tmp5815)),((tmp5716) land ((lnot (tmp5816)))) lor (((lnot (tmp5716))) land (tmp5816)),((tmp5717) land ((lnot (tmp5817)))) lor (((lnot (tmp5717))) land (tmp5817)),((tmp5718) land ((lnot (tmp5818)))) lor (((lnot (tmp5718))) land (tmp5818)),((tmp5719) land ((lnot (tmp5819)))) lor (((lnot (tmp5719))) land (tmp5819)),((tmp5720) land ((lnot (tmp5820)))) lor (((lnot (tmp5720))) land (tmp5820)),((tmp5721) land ((lnot (tmp5821)))) lor (((lnot (tmp5721))) land (tmp5821)),((tmp5722) land ((lnot (tmp5822)))) lor (((lnot (tmp5722))) land (tmp5822)),((tmp5723) land ((lnot (tmp5823)))) lor (((lnot (tmp5723))) land (tmp5823)),((tmp5724) land ((lnot (tmp5824)))) lor (((lnot (tmp5724))) land (tmp5824)),((tmp5725) land ((lnot (tmp5825)))) lor (((lnot (tmp5725))) land (tmp5825)),((tmp5726) land ((lnot (tmp5826)))) lor (((lnot (tmp5726))) land (tmp5826)),((tmp5727) land ((lnot (tmp5827)))) lor (((lnot (tmp5727))) land (tmp5827)),((tmp5728) land ((lnot (tmp5828)))) lor (((lnot (tmp5728))) land (tmp5828)),((tmp5729) land ((lnot (tmp5829)))) lor (((lnot (tmp5729))) land (tmp5829)),((tmp5730) land ((lnot (tmp5830)))) lor (((lnot (tmp5730))) land (tmp5830)),((tmp5731) land ((lnot (tmp5831)))) lor (((lnot (tmp5731))) land (tmp5831)),((tmp5732) land ((lnot (tmp5832)))) lor (((lnot (tmp5732))) land (tmp5832)),((tmp5733) land ((lnot (tmp5833)))) lor (((lnot (tmp5733))) land (tmp5833)),((tmp5734) land ((lnot (tmp5834)))) lor (((lnot (tmp5734))) land (tmp5834)),((tmp5735) land ((lnot (tmp5835)))) lor (((lnot (tmp5735))) land (tmp5835)),((tmp5736) land ((lnot (tmp5836)))) lor (((lnot (tmp5736))) land (tmp5836)),((tmp5737) land ((lnot (tmp5837)))) lor (((lnot (tmp5737))) land (tmp5837)),((tmp5738) land ((lnot (tmp5838)))) lor (((lnot (tmp5738))) land (tmp5838)),((tmp5739) land ((lnot (tmp5839)))) lor (((lnot (tmp5739))) land (tmp5839)),((tmp5740) land ((lnot (tmp5840)))) lor (((lnot (tmp5740))) land (tmp5840)),((tmp5741) land ((lnot (tmp5841)))) lor (((lnot (tmp5741))) land (tmp5841)),((tmp5742) land ((lnot (tmp5842)))) lor (((lnot (tmp5742))) land (tmp5842)),((tmp5743) land ((lnot (tmp5843)))) lor (((lnot (tmp5743))) land (tmp5843)),((tmp5744) land ((lnot (tmp5844)))) lor (((lnot (tmp5744))) land (tmp5844)),((tmp5745) land ((lnot (tmp5845)))) lor (((lnot (tmp5745))) land (tmp5845)),((tmp5746) land ((lnot (tmp5846)))) lor (((lnot (tmp5746))) land (tmp5846)),((tmp5747) land ((lnot (tmp5847)))) lor (((lnot (tmp5747))) land (tmp5847)),((tmp5748) land ((lnot (tmp5848)))) lor (((lnot (tmp5748))) land (tmp5848))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp591,tmp592,tmp593,tmp594,tmp595,tmp596,tmp597,tmp598,tmp599,tmp5910,tmp5911,tmp5912,tmp5913,tmp5914,tmp5915,tmp5916,tmp5917,tmp5918,tmp5919,tmp5920,tmp5921,tmp5922,tmp5923,tmp5924,tmp5925,tmp5926,tmp5927,tmp5928,tmp5929,tmp5930,tmp5931,tmp5932) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp601,tmp602,tmp603,tmp604,tmp605,tmp606,tmp607,tmp608,tmp609,tmp6010,tmp6011,tmp6012,tmp6013,tmp6014,tmp6015,tmp6016,tmp6017,tmp6018,tmp6019,tmp6020,tmp6021,tmp6022,tmp6023,tmp6024,tmp6025,tmp6026,tmp6027,tmp6028,tmp6029,tmp6030,tmp6031,tmp6032) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp591) land ((lnot (tmp601)))) lor (((lnot (tmp591))) land (tmp601)),((tmp592) land ((lnot (tmp602)))) lor (((lnot (tmp592))) land (tmp602)),((tmp593) land ((lnot (tmp603)))) lor (((lnot (tmp593))) land (tmp603)),((tmp594) land ((lnot (tmp604)))) lor (((lnot (tmp594))) land (tmp604)),((tmp595) land ((lnot (tmp605)))) lor (((lnot (tmp595))) land (tmp605)),((tmp596) land ((lnot (tmp606)))) lor (((lnot (tmp596))) land (tmp606)),((tmp597) land ((lnot (tmp607)))) lor (((lnot (tmp597))) land (tmp607)),((tmp598) land ((lnot (tmp608)))) lor (((lnot (tmp598))) land (tmp608)),((tmp599) land ((lnot (tmp609)))) lor (((lnot (tmp599))) land (tmp609)),((tmp5910) land ((lnot (tmp6010)))) lor (((lnot (tmp5910))) land (tmp6010)),((tmp5911) land ((lnot (tmp6011)))) lor (((lnot (tmp5911))) land (tmp6011)),((tmp5912) land ((lnot (tmp6012)))) lor (((lnot (tmp5912))) land (tmp6012)),((tmp5913) land ((lnot (tmp6013)))) lor (((lnot (tmp5913))) land (tmp6013)),((tmp5914) land ((lnot (tmp6014)))) lor (((lnot (tmp5914))) land (tmp6014)),((tmp5915) land ((lnot (tmp6015)))) lor (((lnot (tmp5915))) land (tmp6015)),((tmp5916) land ((lnot (tmp6016)))) lor (((lnot (tmp5916))) land (tmp6016)),((tmp5917) land ((lnot (tmp6017)))) lor (((lnot (tmp5917))) land (tmp6017)),((tmp5918) land ((lnot (tmp6018)))) lor (((lnot (tmp5918))) land (tmp6018)),((tmp5919) land ((lnot (tmp6019)))) lor (((lnot (tmp5919))) land (tmp6019)),((tmp5920) land ((lnot (tmp6020)))) lor (((lnot (tmp5920))) land (tmp6020)),((tmp5921) land ((lnot (tmp6021)))) lor (((lnot (tmp5921))) land (tmp6021)),((tmp5922) land ((lnot (tmp6022)))) lor (((lnot (tmp5922))) land (tmp6022)),((tmp5923) land ((lnot (tmp6023)))) lor (((lnot (tmp5923))) land (tmp6023)),((tmp5924) land ((lnot (tmp6024)))) lor (((lnot (tmp5924))) land (tmp6024)),((tmp5925) land ((lnot (tmp6025)))) lor (((lnot (tmp5925))) land (tmp6025)),((tmp5926) land ((lnot (tmp6026)))) lor (((lnot (tmp5926))) land (tmp6026)),((tmp5927) land ((lnot (tmp6027)))) lor (((lnot (tmp5927))) land (tmp6027)),((tmp5928) land ((lnot (tmp6028)))) lor (((lnot (tmp5928))) land (tmp6028)),((tmp5929) land ((lnot (tmp6029)))) lor (((lnot (tmp5929))) land (tmp6029)),((tmp5930) land ((lnot (tmp6030)))) lor (((lnot (tmp5930))) land (tmp6030)),((tmp5931) land ((lnot (tmp6031)))) lor (((lnot (tmp5931))) land (tmp6031)),((tmp5932) land ((lnot (tmp6032)))) lor (((lnot (tmp5932))) land (tmp6032))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single16_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (tmp611,tmp612,tmp613,tmp614,tmp615,tmp616,tmp617,tmp618,tmp619,tmp6110,tmp6111,tmp6112,tmp6113,tmp6114,tmp6115,tmp6116,tmp6117,tmp6118,tmp6119,tmp6120,tmp6121,tmp6122,tmp6123,tmp6124,tmp6125,tmp6126,tmp6127,tmp6128,tmp6129,tmp6130,tmp6131,tmp6132,tmp6133,tmp6134,tmp6135,tmp6136,tmp6137,tmp6138,tmp6139,tmp6140,tmp6141,tmp6142,tmp6143,tmp6144,tmp6145,tmp6146,tmp6147,tmp6148) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (tmp621,tmp622,tmp623,tmp624,tmp625,tmp626,tmp627,tmp628,tmp629,tmp6210,tmp6211,tmp6212,tmp6213,tmp6214,tmp6215,tmp6216,tmp6217,tmp6218,tmp6219,tmp6220,tmp6221,tmp6222,tmp6223,tmp6224,tmp6225,tmp6226,tmp6227,tmp6228,tmp6229,tmp6230,tmp6231,tmp6232,tmp6233,tmp6234,tmp6235,tmp6236,tmp6237,tmp6238,tmp6239,tmp6240,tmp6241,tmp6242,tmp6243,tmp6244,tmp6245,tmp6246,tmp6247,tmp6248) = roundkey16_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = (((tmp611) land ((lnot (tmp621)))) lor (((lnot (tmp611))) land (tmp621)),((tmp612) land ((lnot (tmp622)))) lor (((lnot (tmp612))) land (tmp622)),((tmp613) land ((lnot (tmp623)))) lor (((lnot (tmp613))) land (tmp623)),((tmp614) land ((lnot (tmp624)))) lor (((lnot (tmp614))) land (tmp624)),((tmp615) land ((lnot (tmp625)))) lor (((lnot (tmp615))) land (tmp625)),((tmp616) land ((lnot (tmp626)))) lor (((lnot (tmp616))) land (tmp626)),((tmp617) land ((lnot (tmp627)))) lor (((lnot (tmp617))) land (tmp627)),((tmp618) land ((lnot (tmp628)))) lor (((lnot (tmp618))) land (tmp628)),((tmp619) land ((lnot (tmp629)))) lor (((lnot (tmp619))) land (tmp629)),((tmp6110) land ((lnot (tmp6210)))) lor (((lnot (tmp6110))) land (tmp6210)),((tmp6111) land ((lnot (tmp6211)))) lor (((lnot (tmp6111))) land (tmp6211)),((tmp6112) land ((lnot (tmp6212)))) lor (((lnot (tmp6112))) land (tmp6212)),((tmp6113) land ((lnot (tmp6213)))) lor (((lnot (tmp6113))) land (tmp6213)),((tmp6114) land ((lnot (tmp6214)))) lor (((lnot (tmp6114))) land (tmp6214)),((tmp6115) land ((lnot (tmp6215)))) lor (((lnot (tmp6115))) land (tmp6215)),((tmp6116) land ((lnot (tmp6216)))) lor (((lnot (tmp6116))) land (tmp6216)),((tmp6117) land ((lnot (tmp6217)))) lor (((lnot (tmp6117))) land (tmp6217)),((tmp6118) land ((lnot (tmp6218)))) lor (((lnot (tmp6118))) land (tmp6218)),((tmp6119) land ((lnot (tmp6219)))) lor (((lnot (tmp6119))) land (tmp6219)),((tmp6120) land ((lnot (tmp6220)))) lor (((lnot (tmp6120))) land (tmp6220)),((tmp6121) land ((lnot (tmp6221)))) lor (((lnot (tmp6121))) land (tmp6221)),((tmp6122) land ((lnot (tmp6222)))) lor (((lnot (tmp6122))) land (tmp6222)),((tmp6123) land ((lnot (tmp6223)))) lor (((lnot (tmp6123))) land (tmp6223)),((tmp6124) land ((lnot (tmp6224)))) lor (((lnot (tmp6124))) land (tmp6224)),((tmp6125) land ((lnot (tmp6225)))) lor (((lnot (tmp6125))) land (tmp6225)),((tmp6126) land ((lnot (tmp6226)))) lor (((lnot (tmp6126))) land (tmp6226)),((tmp6127) land ((lnot (tmp6227)))) lor (((lnot (tmp6127))) land (tmp6227)),((tmp6128) land ((lnot (tmp6228)))) lor (((lnot (tmp6128))) land (tmp6228)),((tmp6129) land ((lnot (tmp6229)))) lor (((lnot (tmp6129))) land (tmp6229)),((tmp6130) land ((lnot (tmp6230)))) lor (((lnot (tmp6130))) land (tmp6230)),((tmp6131) land ((lnot (tmp6231)))) lor (((lnot (tmp6131))) land (tmp6231)),((tmp6132) land ((lnot (tmp6232)))) lor (((lnot (tmp6132))) land (tmp6232)),((tmp6133) land ((lnot (tmp6233)))) lor (((lnot (tmp6133))) land (tmp6233)),((tmp6134) land ((lnot (tmp6234)))) lor (((lnot (tmp6134))) land (tmp6234)),((tmp6135) land ((lnot (tmp6235)))) lor (((lnot (tmp6135))) land (tmp6235)),((tmp6136) land ((lnot (tmp6236)))) lor (((lnot (tmp6136))) land (tmp6236)),((tmp6137) land ((lnot (tmp6237)))) lor (((lnot (tmp6137))) land (tmp6237)),((tmp6138) land ((lnot (tmp6238)))) lor (((lnot (tmp6138))) land (tmp6238)),((tmp6139) land ((lnot (tmp6239)))) lor (((lnot (tmp6139))) land (tmp6239)),((tmp6140) land ((lnot (tmp6240)))) lor (((lnot (tmp6140))) land (tmp6240)),((tmp6141) land ((lnot (tmp6241)))) lor (((lnot (tmp6141))) land (tmp6241)),((tmp6142) land ((lnot (tmp6242)))) lor (((lnot (tmp6142))) land (tmp6242)),((tmp6143) land ((lnot (tmp6243)))) lor (((lnot (tmp6143))) land (tmp6243)),((tmp6144) land ((lnot (tmp6244)))) lor (((lnot (tmp6144))) land (tmp6244)),((tmp6145) land ((lnot (tmp6245)))) lor (((lnot (tmp6145))) land (tmp6245)),((tmp6146) land ((lnot (tmp6246)))) lor (((lnot (tmp6146))) land (tmp6246)),((tmp6147) land ((lnot (tmp6247)))) lor (((lnot (tmp6147))) land (tmp6247)),((tmp6148) land ((lnot (tmp6248)))) lor (((lnot (tmp6148))) land (tmp6248))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (tmp631,tmp632,tmp633,tmp634,tmp635,tmp636,tmp637,tmp638,tmp639,tmp6310,tmp6311,tmp6312,tmp6313,tmp6314,tmp6315,tmp6316,tmp6317,tmp6318,tmp6319,tmp6320,tmp6321,tmp6322,tmp6323,tmp6324,tmp6325,tmp6326,tmp6327,tmp6328,tmp6329,tmp6330,tmp6331,tmp6332) = (left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32) in 
    let (tmp641,tmp642,tmp643,tmp644,tmp645,tmp646,tmp647,tmp648,tmp649,tmp6410,tmp6411,tmp6412,tmp6413,tmp6414,tmp6415,tmp6416,tmp6417,tmp6418,tmp6419,tmp6420,tmp6421,tmp6422,tmp6423,tmp6424,tmp6425,tmp6426,tmp6427,tmp6428,tmp6429,tmp6430,tmp6431,tmp6432) = (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = (((tmp631) land ((lnot (tmp641)))) lor (((lnot (tmp631))) land (tmp641)),((tmp632) land ((lnot (tmp642)))) lor (((lnot (tmp632))) land (tmp642)),((tmp633) land ((lnot (tmp643)))) lor (((lnot (tmp633))) land (tmp643)),((tmp634) land ((lnot (tmp644)))) lor (((lnot (tmp634))) land (tmp644)),((tmp635) land ((lnot (tmp645)))) lor (((lnot (tmp635))) land (tmp645)),((tmp636) land ((lnot (tmp646)))) lor (((lnot (tmp636))) land (tmp646)),((tmp637) land ((lnot (tmp647)))) lor (((lnot (tmp637))) land (tmp647)),((tmp638) land ((lnot (tmp648)))) lor (((lnot (tmp638))) land (tmp648)),((tmp639) land ((lnot (tmp649)))) lor (((lnot (tmp639))) land (tmp649)),((tmp6310) land ((lnot (tmp6410)))) lor (((lnot (tmp6310))) land (tmp6410)),((tmp6311) land ((lnot (tmp6411)))) lor (((lnot (tmp6311))) land (tmp6411)),((tmp6312) land ((lnot (tmp6412)))) lor (((lnot (tmp6312))) land (tmp6412)),((tmp6313) land ((lnot (tmp6413)))) lor (((lnot (tmp6313))) land (tmp6413)),((tmp6314) land ((lnot (tmp6414)))) lor (((lnot (tmp6314))) land (tmp6414)),((tmp6315) land ((lnot (tmp6415)))) lor (((lnot (tmp6315))) land (tmp6415)),((tmp6316) land ((lnot (tmp6416)))) lor (((lnot (tmp6316))) land (tmp6416)),((tmp6317) land ((lnot (tmp6417)))) lor (((lnot (tmp6317))) land (tmp6417)),((tmp6318) land ((lnot (tmp6418)))) lor (((lnot (tmp6318))) land (tmp6418)),((tmp6319) land ((lnot (tmp6419)))) lor (((lnot (tmp6319))) land (tmp6419)),((tmp6320) land ((lnot (tmp6420)))) lor (((lnot (tmp6320))) land (tmp6420)),((tmp6321) land ((lnot (tmp6421)))) lor (((lnot (tmp6321))) land (tmp6421)),((tmp6322) land ((lnot (tmp6422)))) lor (((lnot (tmp6322))) land (tmp6422)),((tmp6323) land ((lnot (tmp6423)))) lor (((lnot (tmp6323))) land (tmp6423)),((tmp6324) land ((lnot (tmp6424)))) lor (((lnot (tmp6324))) land (tmp6424)),((tmp6325) land ((lnot (tmp6425)))) lor (((lnot (tmp6325))) land (tmp6425)),((tmp6326) land ((lnot (tmp6426)))) lor (((lnot (tmp6326))) land (tmp6426)),((tmp6327) land ((lnot (tmp6427)))) lor (((lnot (tmp6327))) land (tmp6427)),((tmp6328) land ((lnot (tmp6428)))) lor (((lnot (tmp6328))) land (tmp6428)),((tmp6329) land ((lnot (tmp6429)))) lor (((lnot (tmp6329))) land (tmp6429)),((tmp6330) land ((lnot (tmp6430)))) lor (((lnot (tmp6330))) land (tmp6430)),((tmp6331) land ((lnot (tmp6431)))) lor (((lnot (tmp6331))) land (tmp6431)),((tmp6332) land ((lnot (tmp6432)))) lor (((lnot (tmp6332))) land (tmp6432))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_ ((plaintext_1,plaintext_2,plaintext_3,plaintext_4,plaintext_5,plaintext_6,plaintext_7,plaintext_8,plaintext_9,plaintext_10,plaintext_11,plaintext_12,plaintext_13,plaintext_14,plaintext_15,plaintext_16,plaintext_17,plaintext_18,plaintext_19,plaintext_20,plaintext_21,plaintext_22,plaintext_23,plaintext_24,plaintext_25,plaintext_26,plaintext_27,plaintext_28,plaintext_29,plaintext_30,plaintext_31,plaintext_32,plaintext_33,plaintext_34,plaintext_35,plaintext_36,plaintext_37,plaintext_38,plaintext_39,plaintext_40,plaintext_41,plaintext_42,plaintext_43,plaintext_44,plaintext_45,plaintext_46,plaintext_47,plaintext_48,plaintext_49,plaintext_50,plaintext_51,plaintext_52,plaintext_53,plaintext_54,plaintext_55,plaintext_56,plaintext_57,plaintext_58,plaintext_59,plaintext_60,plaintext_61,plaintext_62,plaintext_63,plaintext_64),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (left_init_1,left_init_2,left_init_3,left_init_4,left_init_5,left_init_6,left_init_7,left_init_8,left_init_9,left_init_10,left_init_11,left_init_12,left_init_13,left_init_14,left_init_15,left_init_16,left_init_17,left_init_18,left_init_19,left_init_20,left_init_21,left_init_22,left_init_23,left_init_24,left_init_25,left_init_26,left_init_27,left_init_28,left_init_29,left_init_30,left_init_31,left_init_32,right_init_1,right_init_2,right_init_3,right_init_4,right_init_5,right_init_6,right_init_7,right_init_8,right_init_9,right_init_10,right_init_11,right_init_12,right_init_13,right_init_14,right_init_15,right_init_16,right_init_17,right_init_18,right_init_19,right_init_20,right_init_21,right_init_22,right_init_23,right_init_24,right_init_25,right_init_26,right_init_27,right_init_28,right_init_29,right_init_30,right_init_31,right_init_32) = init_p_ (id ((plaintext_1,plaintext_2,plaintext_3,plaintext_4,plaintext_5,plaintext_6,plaintext_7,plaintext_8,plaintext_9,plaintext_10,plaintext_11,plaintext_12,plaintext_13,plaintext_14,plaintext_15,plaintext_16,plaintext_17,plaintext_18,plaintext_19,plaintext_20,plaintext_21,plaintext_22,plaintext_23,plaintext_24,plaintext_25,plaintext_26,plaintext_27,plaintext_28,plaintext_29,plaintext_30,plaintext_31,plaintext_32,plaintext_33,plaintext_34,plaintext_35,plaintext_36,plaintext_37,plaintext_38,plaintext_39,plaintext_40,plaintext_41,plaintext_42,plaintext_43,plaintext_44,plaintext_45,plaintext_46,plaintext_47,plaintext_48,plaintext_49,plaintext_50,plaintext_51,plaintext_52,plaintext_53,plaintext_54,plaintext_55,plaintext_56,plaintext_57,plaintext_58,plaintext_59,plaintext_60,plaintext_61,plaintext_62,plaintext_63,plaintext_64))) in 
    let (left1_1,left1_2,left1_3,left1_4,left1_5,left1_6,left1_7,left1_8,left1_9,left1_10,left1_11,left1_12,left1_13,left1_14,left1_15,left1_16,left1_17,left1_18,left1_19,left1_20,left1_21,left1_22,left1_23,left1_24,left1_25,left1_26,left1_27,left1_28,left1_29,left1_30,left1_31,left1_32,right1_1,right1_2,right1_3,right1_4,right1_5,right1_6,right1_7,right1_8,right1_9,right1_10,right1_11,right1_12,right1_13,right1_14,right1_15,right1_16,right1_17,right1_18,right1_19,right1_20,right1_21,right1_22,right1_23,right1_24,right1_25,right1_26,right1_27,right1_28,right1_29,right1_30,right1_31,right1_32,key_tmp1_1,key_tmp1_2,key_tmp1_3,key_tmp1_4,key_tmp1_5,key_tmp1_6,key_tmp1_7,key_tmp1_8,key_tmp1_9,key_tmp1_10,key_tmp1_11,key_tmp1_12,key_tmp1_13,key_tmp1_14,key_tmp1_15,key_tmp1_16,key_tmp1_17,key_tmp1_18,key_tmp1_19,key_tmp1_20,key_tmp1_21,key_tmp1_22,key_tmp1_23,key_tmp1_24,key_tmp1_25,key_tmp1_26,key_tmp1_27,key_tmp1_28,key_tmp1_29,key_tmp1_30,key_tmp1_31,key_tmp1_32,key_tmp1_33,key_tmp1_34,key_tmp1_35,key_tmp1_36,key_tmp1_37,key_tmp1_38,key_tmp1_39,key_tmp1_40,key_tmp1_41,key_tmp1_42,key_tmp1_43,key_tmp1_44,key_tmp1_45,key_tmp1_46,key_tmp1_47,key_tmp1_48,key_tmp1_49,key_tmp1_50,key_tmp1_51,key_tmp1_52,key_tmp1_53,key_tmp1_54,key_tmp1_55,key_tmp1_56,key_tmp1_57,key_tmp1_58,key_tmp1_59,key_tmp1_60,key_tmp1_61,key_tmp1_62,key_tmp1_63,key_tmp1_64) = (left_init_1,left_init_2,left_init_3,left_init_4,left_init_5,left_init_6,left_init_7,left_init_8,left_init_9,left_init_10,left_init_11,left_init_12,left_init_13,left_init_14,left_init_15,left_init_16,left_init_17,left_init_18,left_init_19,left_init_20,left_init_21,left_init_22,left_init_23,left_init_24,left_init_25,left_init_26,left_init_27,left_init_28,left_init_29,left_init_30,left_init_31,left_init_32,right_init_1,right_init_2,right_init_3,right_init_4,right_init_5,right_init_6,right_init_7,right_init_8,right_init_9,right_init_10,right_init_11,right_init_12,right_init_13,right_init_14,right_init_15,right_init_16,right_init_17,right_init_18,right_init_19,right_init_20,right_init_21,right_init_22,right_init_23,right_init_24,right_init_25,right_init_26,right_init_27,right_init_28,right_init_29,right_init_30,right_init_31,right_init_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64) in 
    let (left2_1,left2_2,left2_3,left2_4,left2_5,left2_6,left2_7,left2_8,left2_9,left2_10,left2_11,left2_12,left2_13,left2_14,left2_15,left2_16,left2_17,left2_18,left2_19,left2_20,left2_21,left2_22,left2_23,left2_24,left2_25,left2_26,left2_27,left2_28,left2_29,left2_30,left2_31,left2_32,right2_1,right2_2,right2_3,right2_4,right2_5,right2_6,right2_7,right2_8,right2_9,right2_10,right2_11,right2_12,right2_13,right2_14,right2_15,right2_16,right2_17,right2_18,right2_19,right2_20,right2_21,right2_22,right2_23,right2_24,right2_25,right2_26,right2_27,right2_28,right2_29,right2_30,right2_31,right2_32,key_tmp2_1,key_tmp2_2,key_tmp2_3,key_tmp2_4,key_tmp2_5,key_tmp2_6,key_tmp2_7,key_tmp2_8,key_tmp2_9,key_tmp2_10,key_tmp2_11,key_tmp2_12,key_tmp2_13,key_tmp2_14,key_tmp2_15,key_tmp2_16,key_tmp2_17,key_tmp2_18,key_tmp2_19,key_tmp2_20,key_tmp2_21,key_tmp2_22,key_tmp2_23,key_tmp2_24,key_tmp2_25,key_tmp2_26,key_tmp2_27,key_tmp2_28,key_tmp2_29,key_tmp2_30,key_tmp2_31,key_tmp2_32,key_tmp2_33,key_tmp2_34,key_tmp2_35,key_tmp2_36,key_tmp2_37,key_tmp2_38,key_tmp2_39,key_tmp2_40,key_tmp2_41,key_tmp2_42,key_tmp2_43,key_tmp2_44,key_tmp2_45,key_tmp2_46,key_tmp2_47,key_tmp2_48,key_tmp2_49,key_tmp2_50,key_tmp2_51,key_tmp2_52,key_tmp2_53,key_tmp2_54,key_tmp2_55,key_tmp2_56,key_tmp2_57,key_tmp2_58,key_tmp2_59,key_tmp2_60,key_tmp2_61,key_tmp2_62,key_tmp2_63,key_tmp2_64) = des_single1_ (id ((left1_1,left1_2,left1_3,left1_4,left1_5,left1_6,left1_7,left1_8,left1_9,left1_10,left1_11,left1_12,left1_13,left1_14,left1_15,left1_16,left1_17,left1_18,left1_19,left1_20,left1_21,left1_22,left1_23,left1_24,left1_25,left1_26,left1_27,left1_28,left1_29,left1_30,left1_31,left1_32),(right1_1,right1_2,right1_3,right1_4,right1_5,right1_6,right1_7,right1_8,right1_9,right1_10,right1_11,right1_12,right1_13,right1_14,right1_15,right1_16,right1_17,right1_18,right1_19,right1_20,right1_21,right1_22,right1_23,right1_24,right1_25,right1_26,right1_27,right1_28,right1_29,right1_30,right1_31,right1_32),(key_tmp1_1,key_tmp1_2,key_tmp1_3,key_tmp1_4,key_tmp1_5,key_tmp1_6,key_tmp1_7,key_tmp1_8,key_tmp1_9,key_tmp1_10,key_tmp1_11,key_tmp1_12,key_tmp1_13,key_tmp1_14,key_tmp1_15,key_tmp1_16,key_tmp1_17,key_tmp1_18,key_tmp1_19,key_tmp1_20,key_tmp1_21,key_tmp1_22,key_tmp1_23,key_tmp1_24,key_tmp1_25,key_tmp1_26,key_tmp1_27,key_tmp1_28,key_tmp1_29,key_tmp1_30,key_tmp1_31,key_tmp1_32,key_tmp1_33,key_tmp1_34,key_tmp1_35,key_tmp1_36,key_tmp1_37,key_tmp1_38,key_tmp1_39,key_tmp1_40,key_tmp1_41,key_tmp1_42,key_tmp1_43,key_tmp1_44,key_tmp1_45,key_tmp1_46,key_tmp1_47,key_tmp1_48,key_tmp1_49,key_tmp1_50,key_tmp1_51,key_tmp1_52,key_tmp1_53,key_tmp1_54,key_tmp1_55,key_tmp1_56,key_tmp1_57,key_tmp1_58,key_tmp1_59,key_tmp1_60,key_tmp1_61,key_tmp1_62,key_tmp1_63,key_tmp1_64))) in 
    let (left3_1,left3_2,left3_3,left3_4,left3_5,left3_6,left3_7,left3_8,left3_9,left3_10,left3_11,left3_12,left3_13,left3_14,left3_15,left3_16,left3_17,left3_18,left3_19,left3_20,left3_21,left3_22,left3_23,left3_24,left3_25,left3_26,left3_27,left3_28,left3_29,left3_30,left3_31,left3_32,right3_1,right3_2,right3_3,right3_4,right3_5,right3_6,right3_7,right3_8,right3_9,right3_10,right3_11,right3_12,right3_13,right3_14,right3_15,right3_16,right3_17,right3_18,right3_19,right3_20,right3_21,right3_22,right3_23,right3_24,right3_25,right3_26,right3_27,right3_28,right3_29,right3_30,right3_31,right3_32,key_tmp3_1,key_tmp3_2,key_tmp3_3,key_tmp3_4,key_tmp3_5,key_tmp3_6,key_tmp3_7,key_tmp3_8,key_tmp3_9,key_tmp3_10,key_tmp3_11,key_tmp3_12,key_tmp3_13,key_tmp3_14,key_tmp3_15,key_tmp3_16,key_tmp3_17,key_tmp3_18,key_tmp3_19,key_tmp3_20,key_tmp3_21,key_tmp3_22,key_tmp3_23,key_tmp3_24,key_tmp3_25,key_tmp3_26,key_tmp3_27,key_tmp3_28,key_tmp3_29,key_tmp3_30,key_tmp3_31,key_tmp3_32,key_tmp3_33,key_tmp3_34,key_tmp3_35,key_tmp3_36,key_tmp3_37,key_tmp3_38,key_tmp3_39,key_tmp3_40,key_tmp3_41,key_tmp3_42,key_tmp3_43,key_tmp3_44,key_tmp3_45,key_tmp3_46,key_tmp3_47,key_tmp3_48,key_tmp3_49,key_tmp3_50,key_tmp3_51,key_tmp3_52,key_tmp3_53,key_tmp3_54,key_tmp3_55,key_tmp3_56,key_tmp3_57,key_tmp3_58,key_tmp3_59,key_tmp3_60,key_tmp3_61,key_tmp3_62,key_tmp3_63,key_tmp3_64) = des_single2_ (id ((left2_1,left2_2,left2_3,left2_4,left2_5,left2_6,left2_7,left2_8,left2_9,left2_10,left2_11,left2_12,left2_13,left2_14,left2_15,left2_16,left2_17,left2_18,left2_19,left2_20,left2_21,left2_22,left2_23,left2_24,left2_25,left2_26,left2_27,left2_28,left2_29,left2_30,left2_31,left2_32),(right2_1,right2_2,right2_3,right2_4,right2_5,right2_6,right2_7,right2_8,right2_9,right2_10,right2_11,right2_12,right2_13,right2_14,right2_15,right2_16,right2_17,right2_18,right2_19,right2_20,right2_21,right2_22,right2_23,right2_24,right2_25,right2_26,right2_27,right2_28,right2_29,right2_30,right2_31,right2_32),(key_tmp2_1,key_tmp2_2,key_tmp2_3,key_tmp2_4,key_tmp2_5,key_tmp2_6,key_tmp2_7,key_tmp2_8,key_tmp2_9,key_tmp2_10,key_tmp2_11,key_tmp2_12,key_tmp2_13,key_tmp2_14,key_tmp2_15,key_tmp2_16,key_tmp2_17,key_tmp2_18,key_tmp2_19,key_tmp2_20,key_tmp2_21,key_tmp2_22,key_tmp2_23,key_tmp2_24,key_tmp2_25,key_tmp2_26,key_tmp2_27,key_tmp2_28,key_tmp2_29,key_tmp2_30,key_tmp2_31,key_tmp2_32,key_tmp2_33,key_tmp2_34,key_tmp2_35,key_tmp2_36,key_tmp2_37,key_tmp2_38,key_tmp2_39,key_tmp2_40,key_tmp2_41,key_tmp2_42,key_tmp2_43,key_tmp2_44,key_tmp2_45,key_tmp2_46,key_tmp2_47,key_tmp2_48,key_tmp2_49,key_tmp2_50,key_tmp2_51,key_tmp2_52,key_tmp2_53,key_tmp2_54,key_tmp2_55,key_tmp2_56,key_tmp2_57,key_tmp2_58,key_tmp2_59,key_tmp2_60,key_tmp2_61,key_tmp2_62,key_tmp2_63,key_tmp2_64))) in 
    let (left4_1,left4_2,left4_3,left4_4,left4_5,left4_6,left4_7,left4_8,left4_9,left4_10,left4_11,left4_12,left4_13,left4_14,left4_15,left4_16,left4_17,left4_18,left4_19,left4_20,left4_21,left4_22,left4_23,left4_24,left4_25,left4_26,left4_27,left4_28,left4_29,left4_30,left4_31,left4_32,right4_1,right4_2,right4_3,right4_4,right4_5,right4_6,right4_7,right4_8,right4_9,right4_10,right4_11,right4_12,right4_13,right4_14,right4_15,right4_16,right4_17,right4_18,right4_19,right4_20,right4_21,right4_22,right4_23,right4_24,right4_25,right4_26,right4_27,right4_28,right4_29,right4_30,right4_31,right4_32,key_tmp4_1,key_tmp4_2,key_tmp4_3,key_tmp4_4,key_tmp4_5,key_tmp4_6,key_tmp4_7,key_tmp4_8,key_tmp4_9,key_tmp4_10,key_tmp4_11,key_tmp4_12,key_tmp4_13,key_tmp4_14,key_tmp4_15,key_tmp4_16,key_tmp4_17,key_tmp4_18,key_tmp4_19,key_tmp4_20,key_tmp4_21,key_tmp4_22,key_tmp4_23,key_tmp4_24,key_tmp4_25,key_tmp4_26,key_tmp4_27,key_tmp4_28,key_tmp4_29,key_tmp4_30,key_tmp4_31,key_tmp4_32,key_tmp4_33,key_tmp4_34,key_tmp4_35,key_tmp4_36,key_tmp4_37,key_tmp4_38,key_tmp4_39,key_tmp4_40,key_tmp4_41,key_tmp4_42,key_tmp4_43,key_tmp4_44,key_tmp4_45,key_tmp4_46,key_tmp4_47,key_tmp4_48,key_tmp4_49,key_tmp4_50,key_tmp4_51,key_tmp4_52,key_tmp4_53,key_tmp4_54,key_tmp4_55,key_tmp4_56,key_tmp4_57,key_tmp4_58,key_tmp4_59,key_tmp4_60,key_tmp4_61,key_tmp4_62,key_tmp4_63,key_tmp4_64) = des_single3_ (id ((left3_1,left3_2,left3_3,left3_4,left3_5,left3_6,left3_7,left3_8,left3_9,left3_10,left3_11,left3_12,left3_13,left3_14,left3_15,left3_16,left3_17,left3_18,left3_19,left3_20,left3_21,left3_22,left3_23,left3_24,left3_25,left3_26,left3_27,left3_28,left3_29,left3_30,left3_31,left3_32),(right3_1,right3_2,right3_3,right3_4,right3_5,right3_6,right3_7,right3_8,right3_9,right3_10,right3_11,right3_12,right3_13,right3_14,right3_15,right3_16,right3_17,right3_18,right3_19,right3_20,right3_21,right3_22,right3_23,right3_24,right3_25,right3_26,right3_27,right3_28,right3_29,right3_30,right3_31,right3_32),(key_tmp3_1,key_tmp3_2,key_tmp3_3,key_tmp3_4,key_tmp3_5,key_tmp3_6,key_tmp3_7,key_tmp3_8,key_tmp3_9,key_tmp3_10,key_tmp3_11,key_tmp3_12,key_tmp3_13,key_tmp3_14,key_tmp3_15,key_tmp3_16,key_tmp3_17,key_tmp3_18,key_tmp3_19,key_tmp3_20,key_tmp3_21,key_tmp3_22,key_tmp3_23,key_tmp3_24,key_tmp3_25,key_tmp3_26,key_tmp3_27,key_tmp3_28,key_tmp3_29,key_tmp3_30,key_tmp3_31,key_tmp3_32,key_tmp3_33,key_tmp3_34,key_tmp3_35,key_tmp3_36,key_tmp3_37,key_tmp3_38,key_tmp3_39,key_tmp3_40,key_tmp3_41,key_tmp3_42,key_tmp3_43,key_tmp3_44,key_tmp3_45,key_tmp3_46,key_tmp3_47,key_tmp3_48,key_tmp3_49,key_tmp3_50,key_tmp3_51,key_tmp3_52,key_tmp3_53,key_tmp3_54,key_tmp3_55,key_tmp3_56,key_tmp3_57,key_tmp3_58,key_tmp3_59,key_tmp3_60,key_tmp3_61,key_tmp3_62,key_tmp3_63,key_tmp3_64))) in 
    let (left5_1,left5_2,left5_3,left5_4,left5_5,left5_6,left5_7,left5_8,left5_9,left5_10,left5_11,left5_12,left5_13,left5_14,left5_15,left5_16,left5_17,left5_18,left5_19,left5_20,left5_21,left5_22,left5_23,left5_24,left5_25,left5_26,left5_27,left5_28,left5_29,left5_30,left5_31,left5_32,right5_1,right5_2,right5_3,right5_4,right5_5,right5_6,right5_7,right5_8,right5_9,right5_10,right5_11,right5_12,right5_13,right5_14,right5_15,right5_16,right5_17,right5_18,right5_19,right5_20,right5_21,right5_22,right5_23,right5_24,right5_25,right5_26,right5_27,right5_28,right5_29,right5_30,right5_31,right5_32,key_tmp5_1,key_tmp5_2,key_tmp5_3,key_tmp5_4,key_tmp5_5,key_tmp5_6,key_tmp5_7,key_tmp5_8,key_tmp5_9,key_tmp5_10,key_tmp5_11,key_tmp5_12,key_tmp5_13,key_tmp5_14,key_tmp5_15,key_tmp5_16,key_tmp5_17,key_tmp5_18,key_tmp5_19,key_tmp5_20,key_tmp5_21,key_tmp5_22,key_tmp5_23,key_tmp5_24,key_tmp5_25,key_tmp5_26,key_tmp5_27,key_tmp5_28,key_tmp5_29,key_tmp5_30,key_tmp5_31,key_tmp5_32,key_tmp5_33,key_tmp5_34,key_tmp5_35,key_tmp5_36,key_tmp5_37,key_tmp5_38,key_tmp5_39,key_tmp5_40,key_tmp5_41,key_tmp5_42,key_tmp5_43,key_tmp5_44,key_tmp5_45,key_tmp5_46,key_tmp5_47,key_tmp5_48,key_tmp5_49,key_tmp5_50,key_tmp5_51,key_tmp5_52,key_tmp5_53,key_tmp5_54,key_tmp5_55,key_tmp5_56,key_tmp5_57,key_tmp5_58,key_tmp5_59,key_tmp5_60,key_tmp5_61,key_tmp5_62,key_tmp5_63,key_tmp5_64) = des_single4_ (id ((left4_1,left4_2,left4_3,left4_4,left4_5,left4_6,left4_7,left4_8,left4_9,left4_10,left4_11,left4_12,left4_13,left4_14,left4_15,left4_16,left4_17,left4_18,left4_19,left4_20,left4_21,left4_22,left4_23,left4_24,left4_25,left4_26,left4_27,left4_28,left4_29,left4_30,left4_31,left4_32),(right4_1,right4_2,right4_3,right4_4,right4_5,right4_6,right4_7,right4_8,right4_9,right4_10,right4_11,right4_12,right4_13,right4_14,right4_15,right4_16,right4_17,right4_18,right4_19,right4_20,right4_21,right4_22,right4_23,right4_24,right4_25,right4_26,right4_27,right4_28,right4_29,right4_30,right4_31,right4_32),(key_tmp4_1,key_tmp4_2,key_tmp4_3,key_tmp4_4,key_tmp4_5,key_tmp4_6,key_tmp4_7,key_tmp4_8,key_tmp4_9,key_tmp4_10,key_tmp4_11,key_tmp4_12,key_tmp4_13,key_tmp4_14,key_tmp4_15,key_tmp4_16,key_tmp4_17,key_tmp4_18,key_tmp4_19,key_tmp4_20,key_tmp4_21,key_tmp4_22,key_tmp4_23,key_tmp4_24,key_tmp4_25,key_tmp4_26,key_tmp4_27,key_tmp4_28,key_tmp4_29,key_tmp4_30,key_tmp4_31,key_tmp4_32,key_tmp4_33,key_tmp4_34,key_tmp4_35,key_tmp4_36,key_tmp4_37,key_tmp4_38,key_tmp4_39,key_tmp4_40,key_tmp4_41,key_tmp4_42,key_tmp4_43,key_tmp4_44,key_tmp4_45,key_tmp4_46,key_tmp4_47,key_tmp4_48,key_tmp4_49,key_tmp4_50,key_tmp4_51,key_tmp4_52,key_tmp4_53,key_tmp4_54,key_tmp4_55,key_tmp4_56,key_tmp4_57,key_tmp4_58,key_tmp4_59,key_tmp4_60,key_tmp4_61,key_tmp4_62,key_tmp4_63,key_tmp4_64))) in 
    let (left6_1,left6_2,left6_3,left6_4,left6_5,left6_6,left6_7,left6_8,left6_9,left6_10,left6_11,left6_12,left6_13,left6_14,left6_15,left6_16,left6_17,left6_18,left6_19,left6_20,left6_21,left6_22,left6_23,left6_24,left6_25,left6_26,left6_27,left6_28,left6_29,left6_30,left6_31,left6_32,right6_1,right6_2,right6_3,right6_4,right6_5,right6_6,right6_7,right6_8,right6_9,right6_10,right6_11,right6_12,right6_13,right6_14,right6_15,right6_16,right6_17,right6_18,right6_19,right6_20,right6_21,right6_22,right6_23,right6_24,right6_25,right6_26,right6_27,right6_28,right6_29,right6_30,right6_31,right6_32,key_tmp6_1,key_tmp6_2,key_tmp6_3,key_tmp6_4,key_tmp6_5,key_tmp6_6,key_tmp6_7,key_tmp6_8,key_tmp6_9,key_tmp6_10,key_tmp6_11,key_tmp6_12,key_tmp6_13,key_tmp6_14,key_tmp6_15,key_tmp6_16,key_tmp6_17,key_tmp6_18,key_tmp6_19,key_tmp6_20,key_tmp6_21,key_tmp6_22,key_tmp6_23,key_tmp6_24,key_tmp6_25,key_tmp6_26,key_tmp6_27,key_tmp6_28,key_tmp6_29,key_tmp6_30,key_tmp6_31,key_tmp6_32,key_tmp6_33,key_tmp6_34,key_tmp6_35,key_tmp6_36,key_tmp6_37,key_tmp6_38,key_tmp6_39,key_tmp6_40,key_tmp6_41,key_tmp6_42,key_tmp6_43,key_tmp6_44,key_tmp6_45,key_tmp6_46,key_tmp6_47,key_tmp6_48,key_tmp6_49,key_tmp6_50,key_tmp6_51,key_tmp6_52,key_tmp6_53,key_tmp6_54,key_tmp6_55,key_tmp6_56,key_tmp6_57,key_tmp6_58,key_tmp6_59,key_tmp6_60,key_tmp6_61,key_tmp6_62,key_tmp6_63,key_tmp6_64) = des_single5_ (id ((left5_1,left5_2,left5_3,left5_4,left5_5,left5_6,left5_7,left5_8,left5_9,left5_10,left5_11,left5_12,left5_13,left5_14,left5_15,left5_16,left5_17,left5_18,left5_19,left5_20,left5_21,left5_22,left5_23,left5_24,left5_25,left5_26,left5_27,left5_28,left5_29,left5_30,left5_31,left5_32),(right5_1,right5_2,right5_3,right5_4,right5_5,right5_6,right5_7,right5_8,right5_9,right5_10,right5_11,right5_12,right5_13,right5_14,right5_15,right5_16,right5_17,right5_18,right5_19,right5_20,right5_21,right5_22,right5_23,right5_24,right5_25,right5_26,right5_27,right5_28,right5_29,right5_30,right5_31,right5_32),(key_tmp5_1,key_tmp5_2,key_tmp5_3,key_tmp5_4,key_tmp5_5,key_tmp5_6,key_tmp5_7,key_tmp5_8,key_tmp5_9,key_tmp5_10,key_tmp5_11,key_tmp5_12,key_tmp5_13,key_tmp5_14,key_tmp5_15,key_tmp5_16,key_tmp5_17,key_tmp5_18,key_tmp5_19,key_tmp5_20,key_tmp5_21,key_tmp5_22,key_tmp5_23,key_tmp5_24,key_tmp5_25,key_tmp5_26,key_tmp5_27,key_tmp5_28,key_tmp5_29,key_tmp5_30,key_tmp5_31,key_tmp5_32,key_tmp5_33,key_tmp5_34,key_tmp5_35,key_tmp5_36,key_tmp5_37,key_tmp5_38,key_tmp5_39,key_tmp5_40,key_tmp5_41,key_tmp5_42,key_tmp5_43,key_tmp5_44,key_tmp5_45,key_tmp5_46,key_tmp5_47,key_tmp5_48,key_tmp5_49,key_tmp5_50,key_tmp5_51,key_tmp5_52,key_tmp5_53,key_tmp5_54,key_tmp5_55,key_tmp5_56,key_tmp5_57,key_tmp5_58,key_tmp5_59,key_tmp5_60,key_tmp5_61,key_tmp5_62,key_tmp5_63,key_tmp5_64))) in 
    let (left7_1,left7_2,left7_3,left7_4,left7_5,left7_6,left7_7,left7_8,left7_9,left7_10,left7_11,left7_12,left7_13,left7_14,left7_15,left7_16,left7_17,left7_18,left7_19,left7_20,left7_21,left7_22,left7_23,left7_24,left7_25,left7_26,left7_27,left7_28,left7_29,left7_30,left7_31,left7_32,right7_1,right7_2,right7_3,right7_4,right7_5,right7_6,right7_7,right7_8,right7_9,right7_10,right7_11,right7_12,right7_13,right7_14,right7_15,right7_16,right7_17,right7_18,right7_19,right7_20,right7_21,right7_22,right7_23,right7_24,right7_25,right7_26,right7_27,right7_28,right7_29,right7_30,right7_31,right7_32,key_tmp7_1,key_tmp7_2,key_tmp7_3,key_tmp7_4,key_tmp7_5,key_tmp7_6,key_tmp7_7,key_tmp7_8,key_tmp7_9,key_tmp7_10,key_tmp7_11,key_tmp7_12,key_tmp7_13,key_tmp7_14,key_tmp7_15,key_tmp7_16,key_tmp7_17,key_tmp7_18,key_tmp7_19,key_tmp7_20,key_tmp7_21,key_tmp7_22,key_tmp7_23,key_tmp7_24,key_tmp7_25,key_tmp7_26,key_tmp7_27,key_tmp7_28,key_tmp7_29,key_tmp7_30,key_tmp7_31,key_tmp7_32,key_tmp7_33,key_tmp7_34,key_tmp7_35,key_tmp7_36,key_tmp7_37,key_tmp7_38,key_tmp7_39,key_tmp7_40,key_tmp7_41,key_tmp7_42,key_tmp7_43,key_tmp7_44,key_tmp7_45,key_tmp7_46,key_tmp7_47,key_tmp7_48,key_tmp7_49,key_tmp7_50,key_tmp7_51,key_tmp7_52,key_tmp7_53,key_tmp7_54,key_tmp7_55,key_tmp7_56,key_tmp7_57,key_tmp7_58,key_tmp7_59,key_tmp7_60,key_tmp7_61,key_tmp7_62,key_tmp7_63,key_tmp7_64) = des_single6_ (id ((left6_1,left6_2,left6_3,left6_4,left6_5,left6_6,left6_7,left6_8,left6_9,left6_10,left6_11,left6_12,left6_13,left6_14,left6_15,left6_16,left6_17,left6_18,left6_19,left6_20,left6_21,left6_22,left6_23,left6_24,left6_25,left6_26,left6_27,left6_28,left6_29,left6_30,left6_31,left6_32),(right6_1,right6_2,right6_3,right6_4,right6_5,right6_6,right6_7,right6_8,right6_9,right6_10,right6_11,right6_12,right6_13,right6_14,right6_15,right6_16,right6_17,right6_18,right6_19,right6_20,right6_21,right6_22,right6_23,right6_24,right6_25,right6_26,right6_27,right6_28,right6_29,right6_30,right6_31,right6_32),(key_tmp6_1,key_tmp6_2,key_tmp6_3,key_tmp6_4,key_tmp6_5,key_tmp6_6,key_tmp6_7,key_tmp6_8,key_tmp6_9,key_tmp6_10,key_tmp6_11,key_tmp6_12,key_tmp6_13,key_tmp6_14,key_tmp6_15,key_tmp6_16,key_tmp6_17,key_tmp6_18,key_tmp6_19,key_tmp6_20,key_tmp6_21,key_tmp6_22,key_tmp6_23,key_tmp6_24,key_tmp6_25,key_tmp6_26,key_tmp6_27,key_tmp6_28,key_tmp6_29,key_tmp6_30,key_tmp6_31,key_tmp6_32,key_tmp6_33,key_tmp6_34,key_tmp6_35,key_tmp6_36,key_tmp6_37,key_tmp6_38,key_tmp6_39,key_tmp6_40,key_tmp6_41,key_tmp6_42,key_tmp6_43,key_tmp6_44,key_tmp6_45,key_tmp6_46,key_tmp6_47,key_tmp6_48,key_tmp6_49,key_tmp6_50,key_tmp6_51,key_tmp6_52,key_tmp6_53,key_tmp6_54,key_tmp6_55,key_tmp6_56,key_tmp6_57,key_tmp6_58,key_tmp6_59,key_tmp6_60,key_tmp6_61,key_tmp6_62,key_tmp6_63,key_tmp6_64))) in 
    let (left8_1,left8_2,left8_3,left8_4,left8_5,left8_6,left8_7,left8_8,left8_9,left8_10,left8_11,left8_12,left8_13,left8_14,left8_15,left8_16,left8_17,left8_18,left8_19,left8_20,left8_21,left8_22,left8_23,left8_24,left8_25,left8_26,left8_27,left8_28,left8_29,left8_30,left8_31,left8_32,right8_1,right8_2,right8_3,right8_4,right8_5,right8_6,right8_7,right8_8,right8_9,right8_10,right8_11,right8_12,right8_13,right8_14,right8_15,right8_16,right8_17,right8_18,right8_19,right8_20,right8_21,right8_22,right8_23,right8_24,right8_25,right8_26,right8_27,right8_28,right8_29,right8_30,right8_31,right8_32,key_tmp8_1,key_tmp8_2,key_tmp8_3,key_tmp8_4,key_tmp8_5,key_tmp8_6,key_tmp8_7,key_tmp8_8,key_tmp8_9,key_tmp8_10,key_tmp8_11,key_tmp8_12,key_tmp8_13,key_tmp8_14,key_tmp8_15,key_tmp8_16,key_tmp8_17,key_tmp8_18,key_tmp8_19,key_tmp8_20,key_tmp8_21,key_tmp8_22,key_tmp8_23,key_tmp8_24,key_tmp8_25,key_tmp8_26,key_tmp8_27,key_tmp8_28,key_tmp8_29,key_tmp8_30,key_tmp8_31,key_tmp8_32,key_tmp8_33,key_tmp8_34,key_tmp8_35,key_tmp8_36,key_tmp8_37,key_tmp8_38,key_tmp8_39,key_tmp8_40,key_tmp8_41,key_tmp8_42,key_tmp8_43,key_tmp8_44,key_tmp8_45,key_tmp8_46,key_tmp8_47,key_tmp8_48,key_tmp8_49,key_tmp8_50,key_tmp8_51,key_tmp8_52,key_tmp8_53,key_tmp8_54,key_tmp8_55,key_tmp8_56,key_tmp8_57,key_tmp8_58,key_tmp8_59,key_tmp8_60,key_tmp8_61,key_tmp8_62,key_tmp8_63,key_tmp8_64) = des_single7_ (id ((left7_1,left7_2,left7_3,left7_4,left7_5,left7_6,left7_7,left7_8,left7_9,left7_10,left7_11,left7_12,left7_13,left7_14,left7_15,left7_16,left7_17,left7_18,left7_19,left7_20,left7_21,left7_22,left7_23,left7_24,left7_25,left7_26,left7_27,left7_28,left7_29,left7_30,left7_31,left7_32),(right7_1,right7_2,right7_3,right7_4,right7_5,right7_6,right7_7,right7_8,right7_9,right7_10,right7_11,right7_12,right7_13,right7_14,right7_15,right7_16,right7_17,right7_18,right7_19,right7_20,right7_21,right7_22,right7_23,right7_24,right7_25,right7_26,right7_27,right7_28,right7_29,right7_30,right7_31,right7_32),(key_tmp7_1,key_tmp7_2,key_tmp7_3,key_tmp7_4,key_tmp7_5,key_tmp7_6,key_tmp7_7,key_tmp7_8,key_tmp7_9,key_tmp7_10,key_tmp7_11,key_tmp7_12,key_tmp7_13,key_tmp7_14,key_tmp7_15,key_tmp7_16,key_tmp7_17,key_tmp7_18,key_tmp7_19,key_tmp7_20,key_tmp7_21,key_tmp7_22,key_tmp7_23,key_tmp7_24,key_tmp7_25,key_tmp7_26,key_tmp7_27,key_tmp7_28,key_tmp7_29,key_tmp7_30,key_tmp7_31,key_tmp7_32,key_tmp7_33,key_tmp7_34,key_tmp7_35,key_tmp7_36,key_tmp7_37,key_tmp7_38,key_tmp7_39,key_tmp7_40,key_tmp7_41,key_tmp7_42,key_tmp7_43,key_tmp7_44,key_tmp7_45,key_tmp7_46,key_tmp7_47,key_tmp7_48,key_tmp7_49,key_tmp7_50,key_tmp7_51,key_tmp7_52,key_tmp7_53,key_tmp7_54,key_tmp7_55,key_tmp7_56,key_tmp7_57,key_tmp7_58,key_tmp7_59,key_tmp7_60,key_tmp7_61,key_tmp7_62,key_tmp7_63,key_tmp7_64))) in 
    let (left9_1,left9_2,left9_3,left9_4,left9_5,left9_6,left9_7,left9_8,left9_9,left9_10,left9_11,left9_12,left9_13,left9_14,left9_15,left9_16,left9_17,left9_18,left9_19,left9_20,left9_21,left9_22,left9_23,left9_24,left9_25,left9_26,left9_27,left9_28,left9_29,left9_30,left9_31,left9_32,right9_1,right9_2,right9_3,right9_4,right9_5,right9_6,right9_7,right9_8,right9_9,right9_10,right9_11,right9_12,right9_13,right9_14,right9_15,right9_16,right9_17,right9_18,right9_19,right9_20,right9_21,right9_22,right9_23,right9_24,right9_25,right9_26,right9_27,right9_28,right9_29,right9_30,right9_31,right9_32,key_tmp9_1,key_tmp9_2,key_tmp9_3,key_tmp9_4,key_tmp9_5,key_tmp9_6,key_tmp9_7,key_tmp9_8,key_tmp9_9,key_tmp9_10,key_tmp9_11,key_tmp9_12,key_tmp9_13,key_tmp9_14,key_tmp9_15,key_tmp9_16,key_tmp9_17,key_tmp9_18,key_tmp9_19,key_tmp9_20,key_tmp9_21,key_tmp9_22,key_tmp9_23,key_tmp9_24,key_tmp9_25,key_tmp9_26,key_tmp9_27,key_tmp9_28,key_tmp9_29,key_tmp9_30,key_tmp9_31,key_tmp9_32,key_tmp9_33,key_tmp9_34,key_tmp9_35,key_tmp9_36,key_tmp9_37,key_tmp9_38,key_tmp9_39,key_tmp9_40,key_tmp9_41,key_tmp9_42,key_tmp9_43,key_tmp9_44,key_tmp9_45,key_tmp9_46,key_tmp9_47,key_tmp9_48,key_tmp9_49,key_tmp9_50,key_tmp9_51,key_tmp9_52,key_tmp9_53,key_tmp9_54,key_tmp9_55,key_tmp9_56,key_tmp9_57,key_tmp9_58,key_tmp9_59,key_tmp9_60,key_tmp9_61,key_tmp9_62,key_tmp9_63,key_tmp9_64) = des_single8_ (id ((left8_1,left8_2,left8_3,left8_4,left8_5,left8_6,left8_7,left8_8,left8_9,left8_10,left8_11,left8_12,left8_13,left8_14,left8_15,left8_16,left8_17,left8_18,left8_19,left8_20,left8_21,left8_22,left8_23,left8_24,left8_25,left8_26,left8_27,left8_28,left8_29,left8_30,left8_31,left8_32),(right8_1,right8_2,right8_3,right8_4,right8_5,right8_6,right8_7,right8_8,right8_9,right8_10,right8_11,right8_12,right8_13,right8_14,right8_15,right8_16,right8_17,right8_18,right8_19,right8_20,right8_21,right8_22,right8_23,right8_24,right8_25,right8_26,right8_27,right8_28,right8_29,right8_30,right8_31,right8_32),(key_tmp8_1,key_tmp8_2,key_tmp8_3,key_tmp8_4,key_tmp8_5,key_tmp8_6,key_tmp8_7,key_tmp8_8,key_tmp8_9,key_tmp8_10,key_tmp8_11,key_tmp8_12,key_tmp8_13,key_tmp8_14,key_tmp8_15,key_tmp8_16,key_tmp8_17,key_tmp8_18,key_tmp8_19,key_tmp8_20,key_tmp8_21,key_tmp8_22,key_tmp8_23,key_tmp8_24,key_tmp8_25,key_tmp8_26,key_tmp8_27,key_tmp8_28,key_tmp8_29,key_tmp8_30,key_tmp8_31,key_tmp8_32,key_tmp8_33,key_tmp8_34,key_tmp8_35,key_tmp8_36,key_tmp8_37,key_tmp8_38,key_tmp8_39,key_tmp8_40,key_tmp8_41,key_tmp8_42,key_tmp8_43,key_tmp8_44,key_tmp8_45,key_tmp8_46,key_tmp8_47,key_tmp8_48,key_tmp8_49,key_tmp8_50,key_tmp8_51,key_tmp8_52,key_tmp8_53,key_tmp8_54,key_tmp8_55,key_tmp8_56,key_tmp8_57,key_tmp8_58,key_tmp8_59,key_tmp8_60,key_tmp8_61,key_tmp8_62,key_tmp8_63,key_tmp8_64))) in 
    let (left10_1,left10_2,left10_3,left10_4,left10_5,left10_6,left10_7,left10_8,left10_9,left10_10,left10_11,left10_12,left10_13,left10_14,left10_15,left10_16,left10_17,left10_18,left10_19,left10_20,left10_21,left10_22,left10_23,left10_24,left10_25,left10_26,left10_27,left10_28,left10_29,left10_30,left10_31,left10_32,right10_1,right10_2,right10_3,right10_4,right10_5,right10_6,right10_7,right10_8,right10_9,right10_10,right10_11,right10_12,right10_13,right10_14,right10_15,right10_16,right10_17,right10_18,right10_19,right10_20,right10_21,right10_22,right10_23,right10_24,right10_25,right10_26,right10_27,right10_28,right10_29,right10_30,right10_31,right10_32,key_tmp10_1,key_tmp10_2,key_tmp10_3,key_tmp10_4,key_tmp10_5,key_tmp10_6,key_tmp10_7,key_tmp10_8,key_tmp10_9,key_tmp10_10,key_tmp10_11,key_tmp10_12,key_tmp10_13,key_tmp10_14,key_tmp10_15,key_tmp10_16,key_tmp10_17,key_tmp10_18,key_tmp10_19,key_tmp10_20,key_tmp10_21,key_tmp10_22,key_tmp10_23,key_tmp10_24,key_tmp10_25,key_tmp10_26,key_tmp10_27,key_tmp10_28,key_tmp10_29,key_tmp10_30,key_tmp10_31,key_tmp10_32,key_tmp10_33,key_tmp10_34,key_tmp10_35,key_tmp10_36,key_tmp10_37,key_tmp10_38,key_tmp10_39,key_tmp10_40,key_tmp10_41,key_tmp10_42,key_tmp10_43,key_tmp10_44,key_tmp10_45,key_tmp10_46,key_tmp10_47,key_tmp10_48,key_tmp10_49,key_tmp10_50,key_tmp10_51,key_tmp10_52,key_tmp10_53,key_tmp10_54,key_tmp10_55,key_tmp10_56,key_tmp10_57,key_tmp10_58,key_tmp10_59,key_tmp10_60,key_tmp10_61,key_tmp10_62,key_tmp10_63,key_tmp10_64) = des_single9_ (id ((left9_1,left9_2,left9_3,left9_4,left9_5,left9_6,left9_7,left9_8,left9_9,left9_10,left9_11,left9_12,left9_13,left9_14,left9_15,left9_16,left9_17,left9_18,left9_19,left9_20,left9_21,left9_22,left9_23,left9_24,left9_25,left9_26,left9_27,left9_28,left9_29,left9_30,left9_31,left9_32),(right9_1,right9_2,right9_3,right9_4,right9_5,right9_6,right9_7,right9_8,right9_9,right9_10,right9_11,right9_12,right9_13,right9_14,right9_15,right9_16,right9_17,right9_18,right9_19,right9_20,right9_21,right9_22,right9_23,right9_24,right9_25,right9_26,right9_27,right9_28,right9_29,right9_30,right9_31,right9_32),(key_tmp9_1,key_tmp9_2,key_tmp9_3,key_tmp9_4,key_tmp9_5,key_tmp9_6,key_tmp9_7,key_tmp9_8,key_tmp9_9,key_tmp9_10,key_tmp9_11,key_tmp9_12,key_tmp9_13,key_tmp9_14,key_tmp9_15,key_tmp9_16,key_tmp9_17,key_tmp9_18,key_tmp9_19,key_tmp9_20,key_tmp9_21,key_tmp9_22,key_tmp9_23,key_tmp9_24,key_tmp9_25,key_tmp9_26,key_tmp9_27,key_tmp9_28,key_tmp9_29,key_tmp9_30,key_tmp9_31,key_tmp9_32,key_tmp9_33,key_tmp9_34,key_tmp9_35,key_tmp9_36,key_tmp9_37,key_tmp9_38,key_tmp9_39,key_tmp9_40,key_tmp9_41,key_tmp9_42,key_tmp9_43,key_tmp9_44,key_tmp9_45,key_tmp9_46,key_tmp9_47,key_tmp9_48,key_tmp9_49,key_tmp9_50,key_tmp9_51,key_tmp9_52,key_tmp9_53,key_tmp9_54,key_tmp9_55,key_tmp9_56,key_tmp9_57,key_tmp9_58,key_tmp9_59,key_tmp9_60,key_tmp9_61,key_tmp9_62,key_tmp9_63,key_tmp9_64))) in 
    let (left11_1,left11_2,left11_3,left11_4,left11_5,left11_6,left11_7,left11_8,left11_9,left11_10,left11_11,left11_12,left11_13,left11_14,left11_15,left11_16,left11_17,left11_18,left11_19,left11_20,left11_21,left11_22,left11_23,left11_24,left11_25,left11_26,left11_27,left11_28,left11_29,left11_30,left11_31,left11_32,right11_1,right11_2,right11_3,right11_4,right11_5,right11_6,right11_7,right11_8,right11_9,right11_10,right11_11,right11_12,right11_13,right11_14,right11_15,right11_16,right11_17,right11_18,right11_19,right11_20,right11_21,right11_22,right11_23,right11_24,right11_25,right11_26,right11_27,right11_28,right11_29,right11_30,right11_31,right11_32,key_tmp11_1,key_tmp11_2,key_tmp11_3,key_tmp11_4,key_tmp11_5,key_tmp11_6,key_tmp11_7,key_tmp11_8,key_tmp11_9,key_tmp11_10,key_tmp11_11,key_tmp11_12,key_tmp11_13,key_tmp11_14,key_tmp11_15,key_tmp11_16,key_tmp11_17,key_tmp11_18,key_tmp11_19,key_tmp11_20,key_tmp11_21,key_tmp11_22,key_tmp11_23,key_tmp11_24,key_tmp11_25,key_tmp11_26,key_tmp11_27,key_tmp11_28,key_tmp11_29,key_tmp11_30,key_tmp11_31,key_tmp11_32,key_tmp11_33,key_tmp11_34,key_tmp11_35,key_tmp11_36,key_tmp11_37,key_tmp11_38,key_tmp11_39,key_tmp11_40,key_tmp11_41,key_tmp11_42,key_tmp11_43,key_tmp11_44,key_tmp11_45,key_tmp11_46,key_tmp11_47,key_tmp11_48,key_tmp11_49,key_tmp11_50,key_tmp11_51,key_tmp11_52,key_tmp11_53,key_tmp11_54,key_tmp11_55,key_tmp11_56,key_tmp11_57,key_tmp11_58,key_tmp11_59,key_tmp11_60,key_tmp11_61,key_tmp11_62,key_tmp11_63,key_tmp11_64) = des_single10_ (id ((left10_1,left10_2,left10_3,left10_4,left10_5,left10_6,left10_7,left10_8,left10_9,left10_10,left10_11,left10_12,left10_13,left10_14,left10_15,left10_16,left10_17,left10_18,left10_19,left10_20,left10_21,left10_22,left10_23,left10_24,left10_25,left10_26,left10_27,left10_28,left10_29,left10_30,left10_31,left10_32),(right10_1,right10_2,right10_3,right10_4,right10_5,right10_6,right10_7,right10_8,right10_9,right10_10,right10_11,right10_12,right10_13,right10_14,right10_15,right10_16,right10_17,right10_18,right10_19,right10_20,right10_21,right10_22,right10_23,right10_24,right10_25,right10_26,right10_27,right10_28,right10_29,right10_30,right10_31,right10_32),(key_tmp10_1,key_tmp10_2,key_tmp10_3,key_tmp10_4,key_tmp10_5,key_tmp10_6,key_tmp10_7,key_tmp10_8,key_tmp10_9,key_tmp10_10,key_tmp10_11,key_tmp10_12,key_tmp10_13,key_tmp10_14,key_tmp10_15,key_tmp10_16,key_tmp10_17,key_tmp10_18,key_tmp10_19,key_tmp10_20,key_tmp10_21,key_tmp10_22,key_tmp10_23,key_tmp10_24,key_tmp10_25,key_tmp10_26,key_tmp10_27,key_tmp10_28,key_tmp10_29,key_tmp10_30,key_tmp10_31,key_tmp10_32,key_tmp10_33,key_tmp10_34,key_tmp10_35,key_tmp10_36,key_tmp10_37,key_tmp10_38,key_tmp10_39,key_tmp10_40,key_tmp10_41,key_tmp10_42,key_tmp10_43,key_tmp10_44,key_tmp10_45,key_tmp10_46,key_tmp10_47,key_tmp10_48,key_tmp10_49,key_tmp10_50,key_tmp10_51,key_tmp10_52,key_tmp10_53,key_tmp10_54,key_tmp10_55,key_tmp10_56,key_tmp10_57,key_tmp10_58,key_tmp10_59,key_tmp10_60,key_tmp10_61,key_tmp10_62,key_tmp10_63,key_tmp10_64))) in 
    let (left12_1,left12_2,left12_3,left12_4,left12_5,left12_6,left12_7,left12_8,left12_9,left12_10,left12_11,left12_12,left12_13,left12_14,left12_15,left12_16,left12_17,left12_18,left12_19,left12_20,left12_21,left12_22,left12_23,left12_24,left12_25,left12_26,left12_27,left12_28,left12_29,left12_30,left12_31,left12_32,right12_1,right12_2,right12_3,right12_4,right12_5,right12_6,right12_7,right12_8,right12_9,right12_10,right12_11,right12_12,right12_13,right12_14,right12_15,right12_16,right12_17,right12_18,right12_19,right12_20,right12_21,right12_22,right12_23,right12_24,right12_25,right12_26,right12_27,right12_28,right12_29,right12_30,right12_31,right12_32,key_tmp12_1,key_tmp12_2,key_tmp12_3,key_tmp12_4,key_tmp12_5,key_tmp12_6,key_tmp12_7,key_tmp12_8,key_tmp12_9,key_tmp12_10,key_tmp12_11,key_tmp12_12,key_tmp12_13,key_tmp12_14,key_tmp12_15,key_tmp12_16,key_tmp12_17,key_tmp12_18,key_tmp12_19,key_tmp12_20,key_tmp12_21,key_tmp12_22,key_tmp12_23,key_tmp12_24,key_tmp12_25,key_tmp12_26,key_tmp12_27,key_tmp12_28,key_tmp12_29,key_tmp12_30,key_tmp12_31,key_tmp12_32,key_tmp12_33,key_tmp12_34,key_tmp12_35,key_tmp12_36,key_tmp12_37,key_tmp12_38,key_tmp12_39,key_tmp12_40,key_tmp12_41,key_tmp12_42,key_tmp12_43,key_tmp12_44,key_tmp12_45,key_tmp12_46,key_tmp12_47,key_tmp12_48,key_tmp12_49,key_tmp12_50,key_tmp12_51,key_tmp12_52,key_tmp12_53,key_tmp12_54,key_tmp12_55,key_tmp12_56,key_tmp12_57,key_tmp12_58,key_tmp12_59,key_tmp12_60,key_tmp12_61,key_tmp12_62,key_tmp12_63,key_tmp12_64) = des_single11_ (id ((left11_1,left11_2,left11_3,left11_4,left11_5,left11_6,left11_7,left11_8,left11_9,left11_10,left11_11,left11_12,left11_13,left11_14,left11_15,left11_16,left11_17,left11_18,left11_19,left11_20,left11_21,left11_22,left11_23,left11_24,left11_25,left11_26,left11_27,left11_28,left11_29,left11_30,left11_31,left11_32),(right11_1,right11_2,right11_3,right11_4,right11_5,right11_6,right11_7,right11_8,right11_9,right11_10,right11_11,right11_12,right11_13,right11_14,right11_15,right11_16,right11_17,right11_18,right11_19,right11_20,right11_21,right11_22,right11_23,right11_24,right11_25,right11_26,right11_27,right11_28,right11_29,right11_30,right11_31,right11_32),(key_tmp11_1,key_tmp11_2,key_tmp11_3,key_tmp11_4,key_tmp11_5,key_tmp11_6,key_tmp11_7,key_tmp11_8,key_tmp11_9,key_tmp11_10,key_tmp11_11,key_tmp11_12,key_tmp11_13,key_tmp11_14,key_tmp11_15,key_tmp11_16,key_tmp11_17,key_tmp11_18,key_tmp11_19,key_tmp11_20,key_tmp11_21,key_tmp11_22,key_tmp11_23,key_tmp11_24,key_tmp11_25,key_tmp11_26,key_tmp11_27,key_tmp11_28,key_tmp11_29,key_tmp11_30,key_tmp11_31,key_tmp11_32,key_tmp11_33,key_tmp11_34,key_tmp11_35,key_tmp11_36,key_tmp11_37,key_tmp11_38,key_tmp11_39,key_tmp11_40,key_tmp11_41,key_tmp11_42,key_tmp11_43,key_tmp11_44,key_tmp11_45,key_tmp11_46,key_tmp11_47,key_tmp11_48,key_tmp11_49,key_tmp11_50,key_tmp11_51,key_tmp11_52,key_tmp11_53,key_tmp11_54,key_tmp11_55,key_tmp11_56,key_tmp11_57,key_tmp11_58,key_tmp11_59,key_tmp11_60,key_tmp11_61,key_tmp11_62,key_tmp11_63,key_tmp11_64))) in 
    let (left13_1,left13_2,left13_3,left13_4,left13_5,left13_6,left13_7,left13_8,left13_9,left13_10,left13_11,left13_12,left13_13,left13_14,left13_15,left13_16,left13_17,left13_18,left13_19,left13_20,left13_21,left13_22,left13_23,left13_24,left13_25,left13_26,left13_27,left13_28,left13_29,left13_30,left13_31,left13_32,right13_1,right13_2,right13_3,right13_4,right13_5,right13_6,right13_7,right13_8,right13_9,right13_10,right13_11,right13_12,right13_13,right13_14,right13_15,right13_16,right13_17,right13_18,right13_19,right13_20,right13_21,right13_22,right13_23,right13_24,right13_25,right13_26,right13_27,right13_28,right13_29,right13_30,right13_31,right13_32,key_tmp13_1,key_tmp13_2,key_tmp13_3,key_tmp13_4,key_tmp13_5,key_tmp13_6,key_tmp13_7,key_tmp13_8,key_tmp13_9,key_tmp13_10,key_tmp13_11,key_tmp13_12,key_tmp13_13,key_tmp13_14,key_tmp13_15,key_tmp13_16,key_tmp13_17,key_tmp13_18,key_tmp13_19,key_tmp13_20,key_tmp13_21,key_tmp13_22,key_tmp13_23,key_tmp13_24,key_tmp13_25,key_tmp13_26,key_tmp13_27,key_tmp13_28,key_tmp13_29,key_tmp13_30,key_tmp13_31,key_tmp13_32,key_tmp13_33,key_tmp13_34,key_tmp13_35,key_tmp13_36,key_tmp13_37,key_tmp13_38,key_tmp13_39,key_tmp13_40,key_tmp13_41,key_tmp13_42,key_tmp13_43,key_tmp13_44,key_tmp13_45,key_tmp13_46,key_tmp13_47,key_tmp13_48,key_tmp13_49,key_tmp13_50,key_tmp13_51,key_tmp13_52,key_tmp13_53,key_tmp13_54,key_tmp13_55,key_tmp13_56,key_tmp13_57,key_tmp13_58,key_tmp13_59,key_tmp13_60,key_tmp13_61,key_tmp13_62,key_tmp13_63,key_tmp13_64) = des_single12_ (id ((left12_1,left12_2,left12_3,left12_4,left12_5,left12_6,left12_7,left12_8,left12_9,left12_10,left12_11,left12_12,left12_13,left12_14,left12_15,left12_16,left12_17,left12_18,left12_19,left12_20,left12_21,left12_22,left12_23,left12_24,left12_25,left12_26,left12_27,left12_28,left12_29,left12_30,left12_31,left12_32),(right12_1,right12_2,right12_3,right12_4,right12_5,right12_6,right12_7,right12_8,right12_9,right12_10,right12_11,right12_12,right12_13,right12_14,right12_15,right12_16,right12_17,right12_18,right12_19,right12_20,right12_21,right12_22,right12_23,right12_24,right12_25,right12_26,right12_27,right12_28,right12_29,right12_30,right12_31,right12_32),(key_tmp12_1,key_tmp12_2,key_tmp12_3,key_tmp12_4,key_tmp12_5,key_tmp12_6,key_tmp12_7,key_tmp12_8,key_tmp12_9,key_tmp12_10,key_tmp12_11,key_tmp12_12,key_tmp12_13,key_tmp12_14,key_tmp12_15,key_tmp12_16,key_tmp12_17,key_tmp12_18,key_tmp12_19,key_tmp12_20,key_tmp12_21,key_tmp12_22,key_tmp12_23,key_tmp12_24,key_tmp12_25,key_tmp12_26,key_tmp12_27,key_tmp12_28,key_tmp12_29,key_tmp12_30,key_tmp12_31,key_tmp12_32,key_tmp12_33,key_tmp12_34,key_tmp12_35,key_tmp12_36,key_tmp12_37,key_tmp12_38,key_tmp12_39,key_tmp12_40,key_tmp12_41,key_tmp12_42,key_tmp12_43,key_tmp12_44,key_tmp12_45,key_tmp12_46,key_tmp12_47,key_tmp12_48,key_tmp12_49,key_tmp12_50,key_tmp12_51,key_tmp12_52,key_tmp12_53,key_tmp12_54,key_tmp12_55,key_tmp12_56,key_tmp12_57,key_tmp12_58,key_tmp12_59,key_tmp12_60,key_tmp12_61,key_tmp12_62,key_tmp12_63,key_tmp12_64))) in 
    let (left14_1,left14_2,left14_3,left14_4,left14_5,left14_6,left14_7,left14_8,left14_9,left14_10,left14_11,left14_12,left14_13,left14_14,left14_15,left14_16,left14_17,left14_18,left14_19,left14_20,left14_21,left14_22,left14_23,left14_24,left14_25,left14_26,left14_27,left14_28,left14_29,left14_30,left14_31,left14_32,right14_1,right14_2,right14_3,right14_4,right14_5,right14_6,right14_7,right14_8,right14_9,right14_10,right14_11,right14_12,right14_13,right14_14,right14_15,right14_16,right14_17,right14_18,right14_19,right14_20,right14_21,right14_22,right14_23,right14_24,right14_25,right14_26,right14_27,right14_28,right14_29,right14_30,right14_31,right14_32,key_tmp14_1,key_tmp14_2,key_tmp14_3,key_tmp14_4,key_tmp14_5,key_tmp14_6,key_tmp14_7,key_tmp14_8,key_tmp14_9,key_tmp14_10,key_tmp14_11,key_tmp14_12,key_tmp14_13,key_tmp14_14,key_tmp14_15,key_tmp14_16,key_tmp14_17,key_tmp14_18,key_tmp14_19,key_tmp14_20,key_tmp14_21,key_tmp14_22,key_tmp14_23,key_tmp14_24,key_tmp14_25,key_tmp14_26,key_tmp14_27,key_tmp14_28,key_tmp14_29,key_tmp14_30,key_tmp14_31,key_tmp14_32,key_tmp14_33,key_tmp14_34,key_tmp14_35,key_tmp14_36,key_tmp14_37,key_tmp14_38,key_tmp14_39,key_tmp14_40,key_tmp14_41,key_tmp14_42,key_tmp14_43,key_tmp14_44,key_tmp14_45,key_tmp14_46,key_tmp14_47,key_tmp14_48,key_tmp14_49,key_tmp14_50,key_tmp14_51,key_tmp14_52,key_tmp14_53,key_tmp14_54,key_tmp14_55,key_tmp14_56,key_tmp14_57,key_tmp14_58,key_tmp14_59,key_tmp14_60,key_tmp14_61,key_tmp14_62,key_tmp14_63,key_tmp14_64) = des_single13_ (id ((left13_1,left13_2,left13_3,left13_4,left13_5,left13_6,left13_7,left13_8,left13_9,left13_10,left13_11,left13_12,left13_13,left13_14,left13_15,left13_16,left13_17,left13_18,left13_19,left13_20,left13_21,left13_22,left13_23,left13_24,left13_25,left13_26,left13_27,left13_28,left13_29,left13_30,left13_31,left13_32),(right13_1,right13_2,right13_3,right13_4,right13_5,right13_6,right13_7,right13_8,right13_9,right13_10,right13_11,right13_12,right13_13,right13_14,right13_15,right13_16,right13_17,right13_18,right13_19,right13_20,right13_21,right13_22,right13_23,right13_24,right13_25,right13_26,right13_27,right13_28,right13_29,right13_30,right13_31,right13_32),(key_tmp13_1,key_tmp13_2,key_tmp13_3,key_tmp13_4,key_tmp13_5,key_tmp13_6,key_tmp13_7,key_tmp13_8,key_tmp13_9,key_tmp13_10,key_tmp13_11,key_tmp13_12,key_tmp13_13,key_tmp13_14,key_tmp13_15,key_tmp13_16,key_tmp13_17,key_tmp13_18,key_tmp13_19,key_tmp13_20,key_tmp13_21,key_tmp13_22,key_tmp13_23,key_tmp13_24,key_tmp13_25,key_tmp13_26,key_tmp13_27,key_tmp13_28,key_tmp13_29,key_tmp13_30,key_tmp13_31,key_tmp13_32,key_tmp13_33,key_tmp13_34,key_tmp13_35,key_tmp13_36,key_tmp13_37,key_tmp13_38,key_tmp13_39,key_tmp13_40,key_tmp13_41,key_tmp13_42,key_tmp13_43,key_tmp13_44,key_tmp13_45,key_tmp13_46,key_tmp13_47,key_tmp13_48,key_tmp13_49,key_tmp13_50,key_tmp13_51,key_tmp13_52,key_tmp13_53,key_tmp13_54,key_tmp13_55,key_tmp13_56,key_tmp13_57,key_tmp13_58,key_tmp13_59,key_tmp13_60,key_tmp13_61,key_tmp13_62,key_tmp13_63,key_tmp13_64))) in 
    let (left15_1,left15_2,left15_3,left15_4,left15_5,left15_6,left15_7,left15_8,left15_9,left15_10,left15_11,left15_12,left15_13,left15_14,left15_15,left15_16,left15_17,left15_18,left15_19,left15_20,left15_21,left15_22,left15_23,left15_24,left15_25,left15_26,left15_27,left15_28,left15_29,left15_30,left15_31,left15_32,right15_1,right15_2,right15_3,right15_4,right15_5,right15_6,right15_7,right15_8,right15_9,right15_10,right15_11,right15_12,right15_13,right15_14,right15_15,right15_16,right15_17,right15_18,right15_19,right15_20,right15_21,right15_22,right15_23,right15_24,right15_25,right15_26,right15_27,right15_28,right15_29,right15_30,right15_31,right15_32,key_tmp15_1,key_tmp15_2,key_tmp15_3,key_tmp15_4,key_tmp15_5,key_tmp15_6,key_tmp15_7,key_tmp15_8,key_tmp15_9,key_tmp15_10,key_tmp15_11,key_tmp15_12,key_tmp15_13,key_tmp15_14,key_tmp15_15,key_tmp15_16,key_tmp15_17,key_tmp15_18,key_tmp15_19,key_tmp15_20,key_tmp15_21,key_tmp15_22,key_tmp15_23,key_tmp15_24,key_tmp15_25,key_tmp15_26,key_tmp15_27,key_tmp15_28,key_tmp15_29,key_tmp15_30,key_tmp15_31,key_tmp15_32,key_tmp15_33,key_tmp15_34,key_tmp15_35,key_tmp15_36,key_tmp15_37,key_tmp15_38,key_tmp15_39,key_tmp15_40,key_tmp15_41,key_tmp15_42,key_tmp15_43,key_tmp15_44,key_tmp15_45,key_tmp15_46,key_tmp15_47,key_tmp15_48,key_tmp15_49,key_tmp15_50,key_tmp15_51,key_tmp15_52,key_tmp15_53,key_tmp15_54,key_tmp15_55,key_tmp15_56,key_tmp15_57,key_tmp15_58,key_tmp15_59,key_tmp15_60,key_tmp15_61,key_tmp15_62,key_tmp15_63,key_tmp15_64) = des_single14_ (id ((left14_1,left14_2,left14_3,left14_4,left14_5,left14_6,left14_7,left14_8,left14_9,left14_10,left14_11,left14_12,left14_13,left14_14,left14_15,left14_16,left14_17,left14_18,left14_19,left14_20,left14_21,left14_22,left14_23,left14_24,left14_25,left14_26,left14_27,left14_28,left14_29,left14_30,left14_31,left14_32),(right14_1,right14_2,right14_3,right14_4,right14_5,right14_6,right14_7,right14_8,right14_9,right14_10,right14_11,right14_12,right14_13,right14_14,right14_15,right14_16,right14_17,right14_18,right14_19,right14_20,right14_21,right14_22,right14_23,right14_24,right14_25,right14_26,right14_27,right14_28,right14_29,right14_30,right14_31,right14_32),(key_tmp14_1,key_tmp14_2,key_tmp14_3,key_tmp14_4,key_tmp14_5,key_tmp14_6,key_tmp14_7,key_tmp14_8,key_tmp14_9,key_tmp14_10,key_tmp14_11,key_tmp14_12,key_tmp14_13,key_tmp14_14,key_tmp14_15,key_tmp14_16,key_tmp14_17,key_tmp14_18,key_tmp14_19,key_tmp14_20,key_tmp14_21,key_tmp14_22,key_tmp14_23,key_tmp14_24,key_tmp14_25,key_tmp14_26,key_tmp14_27,key_tmp14_28,key_tmp14_29,key_tmp14_30,key_tmp14_31,key_tmp14_32,key_tmp14_33,key_tmp14_34,key_tmp14_35,key_tmp14_36,key_tmp14_37,key_tmp14_38,key_tmp14_39,key_tmp14_40,key_tmp14_41,key_tmp14_42,key_tmp14_43,key_tmp14_44,key_tmp14_45,key_tmp14_46,key_tmp14_47,key_tmp14_48,key_tmp14_49,key_tmp14_50,key_tmp14_51,key_tmp14_52,key_tmp14_53,key_tmp14_54,key_tmp14_55,key_tmp14_56,key_tmp14_57,key_tmp14_58,key_tmp14_59,key_tmp14_60,key_tmp14_61,key_tmp14_62,key_tmp14_63,key_tmp14_64))) in 
    let (left16_1,left16_2,left16_3,left16_4,left16_5,left16_6,left16_7,left16_8,left16_9,left16_10,left16_11,left16_12,left16_13,left16_14,left16_15,left16_16,left16_17,left16_18,left16_19,left16_20,left16_21,left16_22,left16_23,left16_24,left16_25,left16_26,left16_27,left16_28,left16_29,left16_30,left16_31,left16_32,right16_1,right16_2,right16_3,right16_4,right16_5,right16_6,right16_7,right16_8,right16_9,right16_10,right16_11,right16_12,right16_13,right16_14,right16_15,right16_16,right16_17,right16_18,right16_19,right16_20,right16_21,right16_22,right16_23,right16_24,right16_25,right16_26,right16_27,right16_28,right16_29,right16_30,right16_31,right16_32,key_tmp16_1,key_tmp16_2,key_tmp16_3,key_tmp16_4,key_tmp16_5,key_tmp16_6,key_tmp16_7,key_tmp16_8,key_tmp16_9,key_tmp16_10,key_tmp16_11,key_tmp16_12,key_tmp16_13,key_tmp16_14,key_tmp16_15,key_tmp16_16,key_tmp16_17,key_tmp16_18,key_tmp16_19,key_tmp16_20,key_tmp16_21,key_tmp16_22,key_tmp16_23,key_tmp16_24,key_tmp16_25,key_tmp16_26,key_tmp16_27,key_tmp16_28,key_tmp16_29,key_tmp16_30,key_tmp16_31,key_tmp16_32,key_tmp16_33,key_tmp16_34,key_tmp16_35,key_tmp16_36,key_tmp16_37,key_tmp16_38,key_tmp16_39,key_tmp16_40,key_tmp16_41,key_tmp16_42,key_tmp16_43,key_tmp16_44,key_tmp16_45,key_tmp16_46,key_tmp16_47,key_tmp16_48,key_tmp16_49,key_tmp16_50,key_tmp16_51,key_tmp16_52,key_tmp16_53,key_tmp16_54,key_tmp16_55,key_tmp16_56,key_tmp16_57,key_tmp16_58,key_tmp16_59,key_tmp16_60,key_tmp16_61,key_tmp16_62,key_tmp16_63,key_tmp16_64) = des_single15_ (id ((left15_1,left15_2,left15_3,left15_4,left15_5,left15_6,left15_7,left15_8,left15_9,left15_10,left15_11,left15_12,left15_13,left15_14,left15_15,left15_16,left15_17,left15_18,left15_19,left15_20,left15_21,left15_22,left15_23,left15_24,left15_25,left15_26,left15_27,left15_28,left15_29,left15_30,left15_31,left15_32),(right15_1,right15_2,right15_3,right15_4,right15_5,right15_6,right15_7,right15_8,right15_9,right15_10,right15_11,right15_12,right15_13,right15_14,right15_15,right15_16,right15_17,right15_18,right15_19,right15_20,right15_21,right15_22,right15_23,right15_24,right15_25,right15_26,right15_27,right15_28,right15_29,right15_30,right15_31,right15_32),(key_tmp15_1,key_tmp15_2,key_tmp15_3,key_tmp15_4,key_tmp15_5,key_tmp15_6,key_tmp15_7,key_tmp15_8,key_tmp15_9,key_tmp15_10,key_tmp15_11,key_tmp15_12,key_tmp15_13,key_tmp15_14,key_tmp15_15,key_tmp15_16,key_tmp15_17,key_tmp15_18,key_tmp15_19,key_tmp15_20,key_tmp15_21,key_tmp15_22,key_tmp15_23,key_tmp15_24,key_tmp15_25,key_tmp15_26,key_tmp15_27,key_tmp15_28,key_tmp15_29,key_tmp15_30,key_tmp15_31,key_tmp15_32,key_tmp15_33,key_tmp15_34,key_tmp15_35,key_tmp15_36,key_tmp15_37,key_tmp15_38,key_tmp15_39,key_tmp15_40,key_tmp15_41,key_tmp15_42,key_tmp15_43,key_tmp15_44,key_tmp15_45,key_tmp15_46,key_tmp15_47,key_tmp15_48,key_tmp15_49,key_tmp15_50,key_tmp15_51,key_tmp15_52,key_tmp15_53,key_tmp15_54,key_tmp15_55,key_tmp15_56,key_tmp15_57,key_tmp15_58,key_tmp15_59,key_tmp15_60,key_tmp15_61,key_tmp15_62,key_tmp15_63,key_tmp15_64))) in 
    let (left17_1,left17_2,left17_3,left17_4,left17_5,left17_6,left17_7,left17_8,left17_9,left17_10,left17_11,left17_12,left17_13,left17_14,left17_15,left17_16,left17_17,left17_18,left17_19,left17_20,left17_21,left17_22,left17_23,left17_24,left17_25,left17_26,left17_27,left17_28,left17_29,left17_30,left17_31,left17_32,right17_1,right17_2,right17_3,right17_4,right17_5,right17_6,right17_7,right17_8,right17_9,right17_10,right17_11,right17_12,right17_13,right17_14,right17_15,right17_16,right17_17,right17_18,right17_19,right17_20,right17_21,right17_22,right17_23,right17_24,right17_25,right17_26,right17_27,right17_28,right17_29,right17_30,right17_31,right17_32,key_tmp17_1,key_tmp17_2,key_tmp17_3,key_tmp17_4,key_tmp17_5,key_tmp17_6,key_tmp17_7,key_tmp17_8,key_tmp17_9,key_tmp17_10,key_tmp17_11,key_tmp17_12,key_tmp17_13,key_tmp17_14,key_tmp17_15,key_tmp17_16,key_tmp17_17,key_tmp17_18,key_tmp17_19,key_tmp17_20,key_tmp17_21,key_tmp17_22,key_tmp17_23,key_tmp17_24,key_tmp17_25,key_tmp17_26,key_tmp17_27,key_tmp17_28,key_tmp17_29,key_tmp17_30,key_tmp17_31,key_tmp17_32,key_tmp17_33,key_tmp17_34,key_tmp17_35,key_tmp17_36,key_tmp17_37,key_tmp17_38,key_tmp17_39,key_tmp17_40,key_tmp17_41,key_tmp17_42,key_tmp17_43,key_tmp17_44,key_tmp17_45,key_tmp17_46,key_tmp17_47,key_tmp17_48,key_tmp17_49,key_tmp17_50,key_tmp17_51,key_tmp17_52,key_tmp17_53,key_tmp17_54,key_tmp17_55,key_tmp17_56,key_tmp17_57,key_tmp17_58,key_tmp17_59,key_tmp17_60,key_tmp17_61,key_tmp17_62,key_tmp17_63,key_tmp17_64) = des_single16_ (id ((left16_1,left16_2,left16_3,left16_4,left16_5,left16_6,left16_7,left16_8,left16_9,left16_10,left16_11,left16_12,left16_13,left16_14,left16_15,left16_16,left16_17,left16_18,left16_19,left16_20,left16_21,left16_22,left16_23,left16_24,left16_25,left16_26,left16_27,left16_28,left16_29,left16_30,left16_31,left16_32),(right16_1,right16_2,right16_3,right16_4,right16_5,right16_6,right16_7,right16_8,right16_9,right16_10,right16_11,right16_12,right16_13,right16_14,right16_15,right16_16,right16_17,right16_18,right16_19,right16_20,right16_21,right16_22,right16_23,right16_24,right16_25,right16_26,right16_27,right16_28,right16_29,right16_30,right16_31,right16_32),(key_tmp16_1,key_tmp16_2,key_tmp16_3,key_tmp16_4,key_tmp16_5,key_tmp16_6,key_tmp16_7,key_tmp16_8,key_tmp16_9,key_tmp16_10,key_tmp16_11,key_tmp16_12,key_tmp16_13,key_tmp16_14,key_tmp16_15,key_tmp16_16,key_tmp16_17,key_tmp16_18,key_tmp16_19,key_tmp16_20,key_tmp16_21,key_tmp16_22,key_tmp16_23,key_tmp16_24,key_tmp16_25,key_tmp16_26,key_tmp16_27,key_tmp16_28,key_tmp16_29,key_tmp16_30,key_tmp16_31,key_tmp16_32,key_tmp16_33,key_tmp16_34,key_tmp16_35,key_tmp16_36,key_tmp16_37,key_tmp16_38,key_tmp16_39,key_tmp16_40,key_tmp16_41,key_tmp16_42,key_tmp16_43,key_tmp16_44,key_tmp16_45,key_tmp16_46,key_tmp16_47,key_tmp16_48,key_tmp16_49,key_tmp16_50,key_tmp16_51,key_tmp16_52,key_tmp16_53,key_tmp16_54,key_tmp16_55,key_tmp16_56,key_tmp16_57,key_tmp16_58,key_tmp16_59,key_tmp16_60,key_tmp16_61,key_tmp16_62,key_tmp16_63,key_tmp16_64))) in 
    let (ciphered_1,ciphered_2,ciphered_3,ciphered_4,ciphered_5,ciphered_6,ciphered_7,ciphered_8,ciphered_9,ciphered_10,ciphered_11,ciphered_12,ciphered_13,ciphered_14,ciphered_15,ciphered_16,ciphered_17,ciphered_18,ciphered_19,ciphered_20,ciphered_21,ciphered_22,ciphered_23,ciphered_24,ciphered_25,ciphered_26,ciphered_27,ciphered_28,ciphered_29,ciphered_30,ciphered_31,ciphered_32,ciphered_33,ciphered_34,ciphered_35,ciphered_36,ciphered_37,ciphered_38,ciphered_39,ciphered_40,ciphered_41,ciphered_42,ciphered_43,ciphered_44,ciphered_45,ciphered_46,ciphered_47,ciphered_48,ciphered_49,ciphered_50,ciphered_51,ciphered_52,ciphered_53,ciphered_54,ciphered_55,ciphered_56,ciphered_57,ciphered_58,ciphered_59,ciphered_60,ciphered_61,ciphered_62,ciphered_63,ciphered_64) = final_p_ (convert6 ((right17_1,right17_2,right17_3,right17_4,right17_5,right17_6,right17_7,right17_8,right17_9,right17_10,right17_11,right17_12,right17_13,right17_14,right17_15,right17_16,right17_17,right17_18,right17_19,right17_20,right17_21,right17_22,right17_23,right17_24,right17_25,right17_26,right17_27,right17_28,right17_29,right17_30,right17_31,right17_32),(left17_1,left17_2,left17_3,left17_4,left17_5,left17_6,left17_7,left17_8,left17_9,left17_10,left17_11,left17_12,left17_13,left17_14,left17_15,left17_16,left17_17,left17_18,left17_19,left17_20,left17_21,left17_22,left17_23,left17_24,left17_25,left17_26,left17_27,left17_28,left17_29,left17_30,left17_31,left17_32))) in 
    (ciphered_1,ciphered_2,ciphered_3,ciphered_4,ciphered_5,ciphered_6,ciphered_7,ciphered_8,ciphered_9,ciphered_10,ciphered_11,ciphered_12,ciphered_13,ciphered_14,ciphered_15,ciphered_16,ciphered_17,ciphered_18,ciphered_19,ciphered_20,ciphered_21,ciphered_22,ciphered_23,ciphered_24,ciphered_25,ciphered_26,ciphered_27,ciphered_28,ciphered_29,ciphered_30,ciphered_31,ciphered_32,ciphered_33,ciphered_34,ciphered_35,ciphered_36,ciphered_37,ciphered_38,ciphered_39,ciphered_40,ciphered_41,ciphered_42,ciphered_43,ciphered_44,ciphered_45,ciphered_46,ciphered_47,ciphered_48,ciphered_49,ciphered_50,ciphered_51,ciphered_52,ciphered_53,ciphered_54,ciphered_55,ciphered_56,ciphered_57,ciphered_58,ciphered_59,ciphered_60,ciphered_61,ciphered_62,ciphered_63,ciphered_64)


let main plaintext_stream key_stream = 
  let cpt = ref 64 in
  let stack_ciphered_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_ciphered_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let plaintext_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          plaintext_.(i) <- Stream.next plaintext_stream
        done;
        let plaintext_' = convert_ortho 64 plaintext_ in
        let (plaintext_1,plaintext_2,plaintext_3,plaintext_4,plaintext_5,plaintext_6,plaintext_7,plaintext_8,plaintext_9,plaintext_10,plaintext_11,plaintext_12,plaintext_13,plaintext_14,plaintext_15,plaintext_16,plaintext_17,plaintext_18,plaintext_19,plaintext_20,plaintext_21,plaintext_22,plaintext_23,plaintext_24,plaintext_25,plaintext_26,plaintext_27,plaintext_28,plaintext_29,plaintext_30,plaintext_31,plaintext_32,plaintext_33,plaintext_34,plaintext_35,plaintext_36,plaintext_37,plaintext_38,plaintext_39,plaintext_40,plaintext_41,plaintext_42,plaintext_43,plaintext_44,plaintext_45,plaintext_46,plaintext_47,plaintext_48,plaintext_49,plaintext_50,plaintext_51,plaintext_52,plaintext_53,plaintext_54,plaintext_55,plaintext_56,plaintext_57,plaintext_58,plaintext_59,plaintext_60,plaintext_61,plaintext_62,plaintext_63,plaintext_64) = (plaintext_'.(0),plaintext_'.(1),plaintext_'.(2),plaintext_'.(3),plaintext_'.(4),plaintext_'.(5),plaintext_'.(6),plaintext_'.(7),plaintext_'.(8),plaintext_'.(9),plaintext_'.(10),plaintext_'.(11),plaintext_'.(12),plaintext_'.(13),plaintext_'.(14),plaintext_'.(15),plaintext_'.(16),plaintext_'.(17),plaintext_'.(18),plaintext_'.(19),plaintext_'.(20),plaintext_'.(21),plaintext_'.(22),plaintext_'.(23),plaintext_'.(24),plaintext_'.(25),plaintext_'.(26),plaintext_'.(27),plaintext_'.(28),plaintext_'.(29),plaintext_'.(30),plaintext_'.(31),plaintext_'.(32),plaintext_'.(33),plaintext_'.(34),plaintext_'.(35),plaintext_'.(36),plaintext_'.(37),plaintext_'.(38),plaintext_'.(39),plaintext_'.(40),plaintext_'.(41),plaintext_'.(42),plaintext_'.(43),plaintext_'.(44),plaintext_'.(45),plaintext_'.(46),plaintext_'.(47),plaintext_'.(48),plaintext_'.(49),plaintext_'.(50),plaintext_'.(51),plaintext_'.(52),plaintext_'.(53),plaintext_'.(54),plaintext_'.(55),plaintext_'.(56),plaintext_'.(57),plaintext_'.(58),plaintext_'.(59),plaintext_'.(60),plaintext_'.(61),plaintext_'.(62),plaintext_'.(63)) in

        let key_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          key_.(i) <- Stream.next key_stream
        done;
        let key_' = convert_ortho 64 key_ in
        let (key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64) = (key_'.(0),key_'.(1),key_'.(2),key_'.(3),key_'.(4),key_'.(5),key_'.(6),key_'.(7),key_'.(8),key_'.(9),key_'.(10),key_'.(11),key_'.(12),key_'.(13),key_'.(14),key_'.(15),key_'.(16),key_'.(17),key_'.(18),key_'.(19),key_'.(20),key_'.(21),key_'.(22),key_'.(23),key_'.(24),key_'.(25),key_'.(26),key_'.(27),key_'.(28),key_'.(29),key_'.(30),key_'.(31),key_'.(32),key_'.(33),key_'.(34),key_'.(35),key_'.(36),key_'.(37),key_'.(38),key_'.(39),key_'.(40),key_'.(41),key_'.(42),key_'.(43),key_'.(44),key_'.(45),key_'.(46),key_'.(47),key_'.(48),key_'.(49),key_'.(50),key_'.(51),key_'.(52),key_'.(53),key_'.(54),key_'.(55),key_'.(56),key_'.(57),key_'.(58),key_'.(59),key_'.(60),key_'.(61),key_'.(62),key_'.(63)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12,ret13,ret14,ret15,ret16,ret17,ret18,ret19,ret20,ret21,ret22,ret23,ret24,ret25,ret26,ret27,ret28,ret29,ret30,ret31,ret32,ret33,ret34,ret35,ret36,ret37,ret38,ret39,ret40,ret41,ret42,ret43,ret44,ret45,ret46,ret47,ret48,ret49,ret50,ret51,ret52,ret53,ret54,ret55,ret56,ret57,ret58,ret59,ret60,ret61,ret62,ret63,ret64) = des_((plaintext_1,plaintext_2,plaintext_3,plaintext_4,plaintext_5,plaintext_6,plaintext_7,plaintext_8,plaintext_9,plaintext_10,plaintext_11,plaintext_12,plaintext_13,plaintext_14,plaintext_15,plaintext_16,plaintext_17,plaintext_18,plaintext_19,plaintext_20,plaintext_21,plaintext_22,plaintext_23,plaintext_24,plaintext_25,plaintext_26,plaintext_27,plaintext_28,plaintext_29,plaintext_30,plaintext_31,plaintext_32,plaintext_33,plaintext_34,plaintext_35,plaintext_36,plaintext_37,plaintext_38,plaintext_39,plaintext_40,plaintext_41,plaintext_42,plaintext_43,plaintext_44,plaintext_45,plaintext_46,plaintext_47,plaintext_48,plaintext_49,plaintext_50,plaintext_51,plaintext_52,plaintext_53,plaintext_54,plaintext_55,plaintext_56,plaintext_57,plaintext_58,plaintext_59,plaintext_60,plaintext_61,plaintext_62,plaintext_63,plaintext_64),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) in
        let ciphered_ = Array.make 64 0 in
        ciphered_.(1) <- ret1;
        ciphered_.(2) <- ret2;
        ciphered_.(3) <- ret3;
        ciphered_.(4) <- ret4;
        ciphered_.(5) <- ret5;
        ciphered_.(6) <- ret6;
        ciphered_.(7) <- ret7;
        ciphered_.(8) <- ret8;
        ciphered_.(9) <- ret9;
        ciphered_.(10) <- ret10;
        ciphered_.(11) <- ret11;
        ciphered_.(12) <- ret12;
        ciphered_.(13) <- ret13;
        ciphered_.(14) <- ret14;
        ciphered_.(15) <- ret15;
        ciphered_.(16) <- ret16;
        ciphered_.(17) <- ret17;
        ciphered_.(18) <- ret18;
        ciphered_.(19) <- ret19;
        ciphered_.(20) <- ret20;
        ciphered_.(21) <- ret21;
        ciphered_.(22) <- ret22;
        ciphered_.(23) <- ret23;
        ciphered_.(24) <- ret24;
        ciphered_.(25) <- ret25;
        ciphered_.(26) <- ret26;
        ciphered_.(27) <- ret27;
        ciphered_.(28) <- ret28;
        ciphered_.(29) <- ret29;
        ciphered_.(30) <- ret30;
        ciphered_.(31) <- ret31;
        ciphered_.(32) <- ret32;
        ciphered_.(33) <- ret33;
        ciphered_.(34) <- ret34;
        ciphered_.(35) <- ret35;
        ciphered_.(36) <- ret36;
        ciphered_.(37) <- ret37;
        ciphered_.(38) <- ret38;
        ciphered_.(39) <- ret39;
        ciphered_.(40) <- ret40;
        ciphered_.(41) <- ret41;
        ciphered_.(42) <- ret42;
        ciphered_.(43) <- ret43;
        ciphered_.(44) <- ret44;
        ciphered_.(45) <- ret45;
        ciphered_.(46) <- ret46;
        ciphered_.(47) <- ret47;
        ciphered_.(48) <- ret48;
        ciphered_.(49) <- ret49;
        ciphered_.(50) <- ret50;
        ciphered_.(51) <- ret51;
        ciphered_.(52) <- ret52;
        ciphered_.(53) <- ret53;
        ciphered_.(54) <- ret54;
        ciphered_.(55) <- ret55;
        ciphered_.(56) <- ret56;
        ciphered_.(57) <- ret57;
        ciphered_.(58) <- ret58;
        ciphered_.(59) <- ret59;
        ciphered_.(60) <- ret60;
        ciphered_.(61) <- ret61;
        ciphered_.(62) <- ret62;
        ciphered_.(63) <- ret63;
        ciphered_.(64) <- ret64;
        stack_ciphered_ := convert_unortho ciphered_;

        cpt := 0;
        let return = Some (!stack_ciphered_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
