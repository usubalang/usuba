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
    let x1_ = ((lnot (a4_))) in 
    let x2_ = ((lnot (a1_))) in 
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
    let x17_ = ((lnot (x14_))) in 
    let x18_ = (x17_) land (x3_) in 
    let x19_ = (a2_) lor (x18_) in 
    let x20_ = ((x16_) land ((lnot (x19_)))) lor (((lnot (x16_))) land (x19_)) in 
    let x21_ = (a5_) lor (x20_) in 
    let x22_ = ((x13_) land ((lnot (x21_)))) lor (((lnot (x13_))) land (x21_)) in 
    let out4_ = x22_ in 
    let x23_ = (a3_) lor (x4_) in 
    let x24_ = ((lnot (x23_))) in 
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
    let x1_ = ((lnot (a5_))) in 
    let x2_ = ((lnot (a1_))) in 
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
    let x1_ = ((lnot (a5_))) in 
    let x2_ = ((lnot (a6_))) in 
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
    let x1_ = ((lnot (a1_))) in 
    let x2_ = ((lnot (a3_))) in 
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
    let x25_ = ((lnot (x13_))) in 
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
    let x1_ = ((lnot (a6_))) in 
    let x2_ = ((lnot (a3_))) in 
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
    let x14_ = ((lnot (x4_))) in 
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
    let x32_ = ((lnot (x31_))) in 
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
    let x1_ = ((lnot (a2_))) in 
    let x2_ = ((lnot (a5_))) in 
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
    let x30_ = ((lnot (x26_))) in 
    let x31_ = (a6_) lor (x29_) in 
    let x32_ = ((lnot (x31_))) in 
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
    let x1_ = ((lnot (a2_))) in 
    let x2_ = ((lnot (a5_))) in 
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
    let x1_ = ((lnot (a1_))) in 
    let x2_ = ((lnot (a4_))) in 
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
    let x24_ = ((lnot (a3_))) in 
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
    let x47_ = ((lnot (x7_))) in 
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



let xor48_ ((a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,a_20,a_21,a_22,a_23,a_24,a_25,a_26,a_27,a_28,a_29,a_30,a_31,a_32,a_33,a_34,a_35,a_36,a_37,a_38,a_39,a_40,a_41,a_42,a_43,a_44,a_45,a_46,a_47,a_48),(b_1,b_2,b_3,b_4,b_5,b_6,b_7,b_8,b_9,b_10,b_11,b_12,b_13,b_14,b_15,b_16,b_17,b_18,b_19,b_20,b_21,b_22,b_23,b_24,b_25,b_26,b_27,b_28,b_29,b_30,b_31,b_32,b_33,b_34,b_35,b_36,b_37,b_38,b_39,b_40,b_41,b_42,b_43,b_44,b_45,b_46,b_47,b_48)) = 
    let out_1 = ((a_1) land ((lnot (b_1)))) lor (((lnot (a_1))) land (b_1)) in 
    let out_2 = ((a_2) land ((lnot (b_2)))) lor (((lnot (a_2))) land (b_2)) in 
    let out_3 = ((a_3) land ((lnot (b_3)))) lor (((lnot (a_3))) land (b_3)) in 
    let out_4 = ((a_4) land ((lnot (b_4)))) lor (((lnot (a_4))) land (b_4)) in 
    let out_5 = ((a_5) land ((lnot (b_5)))) lor (((lnot (a_5))) land (b_5)) in 
    let out_6 = ((a_6) land ((lnot (b_6)))) lor (((lnot (a_6))) land (b_6)) in 
    let out_7 = ((a_7) land ((lnot (b_7)))) lor (((lnot (a_7))) land (b_7)) in 
    let out_8 = ((a_8) land ((lnot (b_8)))) lor (((lnot (a_8))) land (b_8)) in 
    let out_9 = ((a_9) land ((lnot (b_9)))) lor (((lnot (a_9))) land (b_9)) in 
    let out_10 = ((a_10) land ((lnot (b_10)))) lor (((lnot (a_10))) land (b_10)) in 
    let out_11 = ((a_11) land ((lnot (b_11)))) lor (((lnot (a_11))) land (b_11)) in 
    let out_12 = ((a_12) land ((lnot (b_12)))) lor (((lnot (a_12))) land (b_12)) in 
    let out_13 = ((a_13) land ((lnot (b_13)))) lor (((lnot (a_13))) land (b_13)) in 
    let out_14 = ((a_14) land ((lnot (b_14)))) lor (((lnot (a_14))) land (b_14)) in 
    let out_15 = ((a_15) land ((lnot (b_15)))) lor (((lnot (a_15))) land (b_15)) in 
    let out_16 = ((a_16) land ((lnot (b_16)))) lor (((lnot (a_16))) land (b_16)) in 
    let out_17 = ((a_17) land ((lnot (b_17)))) lor (((lnot (a_17))) land (b_17)) in 
    let out_18 = ((a_18) land ((lnot (b_18)))) lor (((lnot (a_18))) land (b_18)) in 
    let out_19 = ((a_19) land ((lnot (b_19)))) lor (((lnot (a_19))) land (b_19)) in 
    let out_20 = ((a_20) land ((lnot (b_20)))) lor (((lnot (a_20))) land (b_20)) in 
    let out_21 = ((a_21) land ((lnot (b_21)))) lor (((lnot (a_21))) land (b_21)) in 
    let out_22 = ((a_22) land ((lnot (b_22)))) lor (((lnot (a_22))) land (b_22)) in 
    let out_23 = ((a_23) land ((lnot (b_23)))) lor (((lnot (a_23))) land (b_23)) in 
    let out_24 = ((a_24) land ((lnot (b_24)))) lor (((lnot (a_24))) land (b_24)) in 
    let out_25 = ((a_25) land ((lnot (b_25)))) lor (((lnot (a_25))) land (b_25)) in 
    let out_26 = ((a_26) land ((lnot (b_26)))) lor (((lnot (a_26))) land (b_26)) in 
    let out_27 = ((a_27) land ((lnot (b_27)))) lor (((lnot (a_27))) land (b_27)) in 
    let out_28 = ((a_28) land ((lnot (b_28)))) lor (((lnot (a_28))) land (b_28)) in 
    let out_29 = ((a_29) land ((lnot (b_29)))) lor (((lnot (a_29))) land (b_29)) in 
    let out_30 = ((a_30) land ((lnot (b_30)))) lor (((lnot (a_30))) land (b_30)) in 
    let out_31 = ((a_31) land ((lnot (b_31)))) lor (((lnot (a_31))) land (b_31)) in 
    let out_32 = ((a_32) land ((lnot (b_32)))) lor (((lnot (a_32))) land (b_32)) in 
    let out_33 = ((a_33) land ((lnot (b_33)))) lor (((lnot (a_33))) land (b_33)) in 
    let out_34 = ((a_34) land ((lnot (b_34)))) lor (((lnot (a_34))) land (b_34)) in 
    let out_35 = ((a_35) land ((lnot (b_35)))) lor (((lnot (a_35))) land (b_35)) in 
    let out_36 = ((a_36) land ((lnot (b_36)))) lor (((lnot (a_36))) land (b_36)) in 
    let out_37 = ((a_37) land ((lnot (b_37)))) lor (((lnot (a_37))) land (b_37)) in 
    let out_38 = ((a_38) land ((lnot (b_38)))) lor (((lnot (a_38))) land (b_38)) in 
    let out_39 = ((a_39) land ((lnot (b_39)))) lor (((lnot (a_39))) land (b_39)) in 
    let out_40 = ((a_40) land ((lnot (b_40)))) lor (((lnot (a_40))) land (b_40)) in 
    let out_41 = ((a_41) land ((lnot (b_41)))) lor (((lnot (a_41))) land (b_41)) in 
    let out_42 = ((a_42) land ((lnot (b_42)))) lor (((lnot (a_42))) land (b_42)) in 
    let out_43 = ((a_43) land ((lnot (b_43)))) lor (((lnot (a_43))) land (b_43)) in 
    let out_44 = ((a_44) land ((lnot (b_44)))) lor (((lnot (a_44))) land (b_44)) in 
    let out_45 = ((a_45) land ((lnot (b_45)))) lor (((lnot (a_45))) land (b_45)) in 
    let out_46 = ((a_46) land ((lnot (b_46)))) lor (((lnot (a_46))) land (b_46)) in 
    let out_47 = ((a_47) land ((lnot (b_47)))) lor (((lnot (a_47))) land (b_47)) in 
    let out_48 = ((a_48) land ((lnot (b_48)))) lor (((lnot (a_48))) land (b_48)) in 
    (out_1,out_2,out_3,out_4,out_5,out_6,out_7,out_8,out_9,out_10,out_11,out_12,out_13,out_14,out_15,out_16,out_17,out_18,out_19,out_20,out_21,out_22,out_23,out_24,out_25,out_26,out_27,out_28,out_29,out_30,out_31,out_32,out_33,out_34,out_35,out_36,out_37,out_38,out_39,out_40,out_41,out_42,out_43,out_44,out_45,out_46,out_47,out_48)



let xor32_ ((a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,a_20,a_21,a_22,a_23,a_24,a_25,a_26,a_27,a_28,a_29,a_30,a_31,a_32),(b_1,b_2,b_3,b_4,b_5,b_6,b_7,b_8,b_9,b_10,b_11,b_12,b_13,b_14,b_15,b_16,b_17,b_18,b_19,b_20,b_21,b_22,b_23,b_24,b_25,b_26,b_27,b_28,b_29,b_30,b_31,b_32)) = 
    let out_1 = ((a_1) land ((lnot (b_1)))) lor (((lnot (a_1))) land (b_1)) in 
    let out_2 = ((a_2) land ((lnot (b_2)))) lor (((lnot (a_2))) land (b_2)) in 
    let out_3 = ((a_3) land ((lnot (b_3)))) lor (((lnot (a_3))) land (b_3)) in 
    let out_4 = ((a_4) land ((lnot (b_4)))) lor (((lnot (a_4))) land (b_4)) in 
    let out_5 = ((a_5) land ((lnot (b_5)))) lor (((lnot (a_5))) land (b_5)) in 
    let out_6 = ((a_6) land ((lnot (b_6)))) lor (((lnot (a_6))) land (b_6)) in 
    let out_7 = ((a_7) land ((lnot (b_7)))) lor (((lnot (a_7))) land (b_7)) in 
    let out_8 = ((a_8) land ((lnot (b_8)))) lor (((lnot (a_8))) land (b_8)) in 
    let out_9 = ((a_9) land ((lnot (b_9)))) lor (((lnot (a_9))) land (b_9)) in 
    let out_10 = ((a_10) land ((lnot (b_10)))) lor (((lnot (a_10))) land (b_10)) in 
    let out_11 = ((a_11) land ((lnot (b_11)))) lor (((lnot (a_11))) land (b_11)) in 
    let out_12 = ((a_12) land ((lnot (b_12)))) lor (((lnot (a_12))) land (b_12)) in 
    let out_13 = ((a_13) land ((lnot (b_13)))) lor (((lnot (a_13))) land (b_13)) in 
    let out_14 = ((a_14) land ((lnot (b_14)))) lor (((lnot (a_14))) land (b_14)) in 
    let out_15 = ((a_15) land ((lnot (b_15)))) lor (((lnot (a_15))) land (b_15)) in 
    let out_16 = ((a_16) land ((lnot (b_16)))) lor (((lnot (a_16))) land (b_16)) in 
    let out_17 = ((a_17) land ((lnot (b_17)))) lor (((lnot (a_17))) land (b_17)) in 
    let out_18 = ((a_18) land ((lnot (b_18)))) lor (((lnot (a_18))) land (b_18)) in 
    let out_19 = ((a_19) land ((lnot (b_19)))) lor (((lnot (a_19))) land (b_19)) in 
    let out_20 = ((a_20) land ((lnot (b_20)))) lor (((lnot (a_20))) land (b_20)) in 
    let out_21 = ((a_21) land ((lnot (b_21)))) lor (((lnot (a_21))) land (b_21)) in 
    let out_22 = ((a_22) land ((lnot (b_22)))) lor (((lnot (a_22))) land (b_22)) in 
    let out_23 = ((a_23) land ((lnot (b_23)))) lor (((lnot (a_23))) land (b_23)) in 
    let out_24 = ((a_24) land ((lnot (b_24)))) lor (((lnot (a_24))) land (b_24)) in 
    let out_25 = ((a_25) land ((lnot (b_25)))) lor (((lnot (a_25))) land (b_25)) in 
    let out_26 = ((a_26) land ((lnot (b_26)))) lor (((lnot (a_26))) land (b_26)) in 
    let out_27 = ((a_27) land ((lnot (b_27)))) lor (((lnot (a_27))) land (b_27)) in 
    let out_28 = ((a_28) land ((lnot (b_28)))) lor (((lnot (a_28))) land (b_28)) in 
    let out_29 = ((a_29) land ((lnot (b_29)))) lor (((lnot (a_29))) land (b_29)) in 
    let out_30 = ((a_30) land ((lnot (b_30)))) lor (((lnot (a_30))) land (b_30)) in 
    let out_31 = ((a_31) land ((lnot (b_31)))) lor (((lnot (a_31))) land (b_31)) in 
    let out_32 = ((a_32) land ((lnot (b_32)))) lor (((lnot (a_32))) land (b_32)) in 
    (out_1,out_2,out_3,out_4,out_5,out_6,out_7,out_8,out_9,out_10,out_11,out_12,out_13,out_14,out_15,out_16,out_17,out_18,out_19,out_20,out_21,out_22,out_23,out_24,out_25,out_26,out_27,out_28,out_29,out_30,out_31,out_32)



let roundkey1_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_31 in 
    let roundkey_47 = key_55 in 
    let roundkey_46 = key_62 in 
    let roundkey_45 = key_13 in 
    let roundkey_44 = key_14 in 
    let roundkey_43 = key_45 in 
    let roundkey_42 = key_20 in 
    let roundkey_41 = key_15 in 
    let roundkey_40 = key_63 in 
    let roundkey_39 = key_38 in 
    let roundkey_38 = key_21 in 
    let roundkey_37 = key_61 in 
    let roundkey_36 = key_29 in 
    let roundkey_35 = key_23 in 
    let roundkey_34 = key_53 in 
    let roundkey_33 = key_5 in 
    let roundkey_32 = key_30 in 
    let roundkey_31 = key_47 in 
    let roundkey_30 = key_4 in 
    let roundkey_29 = key_37 in 
    let roundkey_28 = key_54 in 
    let roundkey_27 = key_39 in 
    let roundkey_26 = key_28 in 
    let roundkey_25 = key_22 in 
    let roundkey_24 = key_41 in 
    let roundkey_23 = key_18 in 
    let roundkey_22 = key_27 in 
    let roundkey_21 = key_36 in 
    let roundkey_20 = key_1 in 
    let roundkey_19 = key_59 in 
    let roundkey_18 = key_58 in 
    let roundkey_17 = key_44 in 
    let roundkey_16 = key_25 in 
    let roundkey_15 = key_26 in 
    let roundkey_14 = key_35 in 
    let roundkey_13 = key_3 in 
    let roundkey_12 = key_42 in 
    let roundkey_11 = key_19 in 
    let roundkey_10 = key_9 in 
    let roundkey_9 = key_2 in 
    let roundkey_8 = key_57 in 
    let roundkey_7 = key_33 in 
    let roundkey_6 = key_17 in 
    let roundkey_5 = key_49 in 
    let roundkey_4 = key_60 in 
    let roundkey_3 = key_34 in 
    let roundkey_2 = key_51 in 
    let roundkey_1 = key_10 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey2_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_23 in 
    let roundkey_47 = key_47 in 
    let roundkey_46 = key_54 in 
    let roundkey_45 = key_5 in 
    let roundkey_44 = key_6 in 
    let roundkey_43 = key_37 in 
    let roundkey_42 = key_12 in 
    let roundkey_41 = key_7 in 
    let roundkey_40 = key_55 in 
    let roundkey_39 = key_30 in 
    let roundkey_38 = key_13 in 
    let roundkey_37 = key_53 in 
    let roundkey_36 = key_21 in 
    let roundkey_35 = key_15 in 
    let roundkey_34 = key_45 in 
    let roundkey_33 = key_28 in 
    let roundkey_32 = key_22 in 
    let roundkey_31 = key_39 in 
    let roundkey_30 = key_63 in 
    let roundkey_29 = key_29 in 
    let roundkey_28 = key_46 in 
    let roundkey_27 = key_31 in 
    let roundkey_26 = key_20 in 
    let roundkey_25 = key_14 in 
    let roundkey_24 = key_33 in 
    let roundkey_23 = key_10 in 
    let roundkey_22 = key_19 in 
    let roundkey_21 = key_57 in 
    let roundkey_20 = key_58 in 
    let roundkey_19 = key_51 in 
    let roundkey_18 = key_50 in 
    let roundkey_17 = key_36 in 
    let roundkey_16 = key_17 in 
    let roundkey_15 = key_18 in 
    let roundkey_14 = key_27 in 
    let roundkey_13 = key_60 in 
    let roundkey_12 = key_34 in 
    let roundkey_11 = key_11 in 
    let roundkey_10 = key_1 in 
    let roundkey_9 = key_59 in 
    let roundkey_8 = key_49 in 
    let roundkey_7 = key_25 in 
    let roundkey_6 = key_9 in 
    let roundkey_5 = key_41 in 
    let roundkey_4 = key_52 in 
    let roundkey_3 = key_26 in 
    let roundkey_2 = key_43 in 
    let roundkey_1 = key_2 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey3_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_7 in 
    let roundkey_47 = key_31 in 
    let roundkey_46 = key_38 in 
    let roundkey_45 = key_20 in 
    let roundkey_44 = key_53 in 
    let roundkey_43 = key_21 in 
    let roundkey_42 = key_63 in 
    let roundkey_41 = key_54 in 
    let roundkey_40 = key_39 in 
    let roundkey_39 = key_14 in 
    let roundkey_38 = key_28 in 
    let roundkey_37 = key_37 in 
    let roundkey_36 = key_5 in 
    let roundkey_35 = key_62 in 
    let roundkey_34 = key_29 in 
    let roundkey_33 = key_12 in 
    let roundkey_32 = key_6 in 
    let roundkey_31 = key_23 in 
    let roundkey_30 = key_47 in 
    let roundkey_29 = key_13 in 
    let roundkey_28 = key_30 in 
    let roundkey_27 = key_15 in 
    let roundkey_26 = key_4 in 
    let roundkey_25 = key_61 in 
    let roundkey_24 = key_17 in 
    let roundkey_23 = key_59 in 
    let roundkey_22 = key_3 in 
    let roundkey_21 = key_41 in 
    let roundkey_20 = key_42 in 
    let roundkey_19 = key_35 in 
    let roundkey_18 = key_34 in 
    let roundkey_17 = key_49 in 
    let roundkey_16 = key_1 in 
    let roundkey_15 = key_2 in 
    let roundkey_14 = key_11 in 
    let roundkey_13 = key_44 in 
    let roundkey_12 = key_18 in 
    let roundkey_11 = key_60 in 
    let roundkey_10 = key_50 in 
    let roundkey_9 = key_43 in 
    let roundkey_8 = key_33 in 
    let roundkey_7 = key_9 in 
    let roundkey_6 = key_58 in 
    let roundkey_5 = key_25 in 
    let roundkey_4 = key_36 in 
    let roundkey_3 = key_10 in 
    let roundkey_2 = key_27 in 
    let roundkey_1 = key_51 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey4_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_54 in 
    let roundkey_47 = key_15 in 
    let roundkey_46 = key_22 in 
    let roundkey_45 = key_4 in 
    let roundkey_44 = key_37 in 
    let roundkey_43 = key_5 in 
    let roundkey_42 = key_47 in 
    let roundkey_41 = key_38 in 
    let roundkey_40 = key_23 in 
    let roundkey_39 = key_61 in 
    let roundkey_38 = key_12 in 
    let roundkey_37 = key_21 in 
    let roundkey_36 = key_20 in 
    let roundkey_35 = key_46 in 
    let roundkey_34 = key_13 in 
    let roundkey_33 = key_63 in 
    let roundkey_32 = key_53 in 
    let roundkey_31 = key_7 in 
    let roundkey_30 = key_31 in 
    let roundkey_29 = key_28 in 
    let roundkey_28 = key_14 in 
    let roundkey_27 = key_62 in 
    let roundkey_26 = key_55 in 
    let roundkey_25 = key_45 in 
    let roundkey_24 = key_1 in 
    let roundkey_23 = key_43 in 
    let roundkey_22 = key_52 in 
    let roundkey_21 = key_25 in 
    let roundkey_20 = key_26 in 
    let roundkey_19 = key_19 in 
    let roundkey_18 = key_18 in 
    let roundkey_17 = key_33 in 
    let roundkey_16 = key_50 in 
    let roundkey_15 = key_51 in 
    let roundkey_14 = key_60 in 
    let roundkey_13 = key_57 in 
    let roundkey_12 = key_2 in 
    let roundkey_11 = key_44 in 
    let roundkey_10 = key_34 in 
    let roundkey_9 = key_27 in 
    let roundkey_8 = key_17 in 
    let roundkey_7 = key_58 in 
    let roundkey_6 = key_42 in 
    let roundkey_5 = key_9 in 
    let roundkey_4 = key_49 in 
    let roundkey_3 = key_59 in 
    let roundkey_2 = key_11 in 
    let roundkey_1 = key_35 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey5_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_38 in 
    let roundkey_47 = key_62 in 
    let roundkey_46 = key_6 in 
    let roundkey_45 = key_55 in 
    let roundkey_44 = key_21 in 
    let roundkey_43 = key_20 in 
    let roundkey_42 = key_31 in 
    let roundkey_41 = key_22 in 
    let roundkey_40 = key_7 in 
    let roundkey_39 = key_45 in 
    let roundkey_38 = key_63 in 
    let roundkey_37 = key_5 in 
    let roundkey_36 = key_4 in 
    let roundkey_35 = key_30 in 
    let roundkey_34 = key_28 in 
    let roundkey_33 = key_47 in 
    let roundkey_32 = key_37 in 
    let roundkey_31 = key_54 in 
    let roundkey_30 = key_15 in 
    let roundkey_29 = key_12 in 
    let roundkey_28 = key_61 in 
    let roundkey_27 = key_46 in 
    let roundkey_26 = key_39 in 
    let roundkey_25 = key_29 in 
    let roundkey_24 = key_50 in 
    let roundkey_23 = key_27 in 
    let roundkey_22 = key_36 in 
    let roundkey_21 = key_9 in 
    let roundkey_20 = key_10 in 
    let roundkey_19 = key_3 in 
    let roundkey_18 = key_2 in 
    let roundkey_17 = key_17 in 
    let roundkey_16 = key_34 in 
    let roundkey_15 = key_35 in 
    let roundkey_14 = key_44 in 
    let roundkey_13 = key_41 in 
    let roundkey_12 = key_51 in 
    let roundkey_11 = key_57 in 
    let roundkey_10 = key_18 in 
    let roundkey_9 = key_11 in 
    let roundkey_8 = key_1 in 
    let roundkey_7 = key_42 in 
    let roundkey_6 = key_26 in 
    let roundkey_5 = key_58 in 
    let roundkey_4 = key_33 in 
    let roundkey_3 = key_43 in 
    let roundkey_2 = key_60 in 
    let roundkey_1 = key_19 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey6_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_22 in 
    let roundkey_47 = key_46 in 
    let roundkey_46 = key_53 in 
    let roundkey_45 = key_39 in 
    let roundkey_44 = key_5 in 
    let roundkey_43 = key_4 in 
    let roundkey_42 = key_15 in 
    let roundkey_41 = key_6 in 
    let roundkey_40 = key_54 in 
    let roundkey_39 = key_29 in 
    let roundkey_38 = key_47 in 
    let roundkey_37 = key_20 in 
    let roundkey_36 = key_55 in 
    let roundkey_35 = key_14 in 
    let roundkey_34 = key_12 in 
    let roundkey_33 = key_31 in 
    let roundkey_32 = key_21 in 
    let roundkey_31 = key_38 in 
    let roundkey_30 = key_62 in 
    let roundkey_29 = key_63 in 
    let roundkey_28 = key_45 in 
    let roundkey_27 = key_30 in 
    let roundkey_26 = key_23 in 
    let roundkey_25 = key_13 in 
    let roundkey_24 = key_34 in 
    let roundkey_23 = key_11 in 
    let roundkey_22 = key_49 in 
    let roundkey_21 = key_58 in 
    let roundkey_20 = key_59 in 
    let roundkey_19 = key_52 in 
    let roundkey_18 = key_51 in 
    let roundkey_17 = key_1 in 
    let roundkey_16 = key_18 in 
    let roundkey_15 = key_19 in 
    let roundkey_14 = key_57 in 
    let roundkey_13 = key_25 in 
    let roundkey_12 = key_35 in 
    let roundkey_11 = key_41 in 
    let roundkey_10 = key_2 in 
    let roundkey_9 = key_60 in 
    let roundkey_8 = key_50 in 
    let roundkey_7 = key_26 in 
    let roundkey_6 = key_10 in 
    let roundkey_5 = key_42 in 
    let roundkey_4 = key_17 in 
    let roundkey_3 = key_27 in 
    let roundkey_2 = key_44 in 
    let roundkey_1 = key_3 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey7_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_6 in 
    let roundkey_47 = key_30 in 
    let roundkey_46 = key_37 in 
    let roundkey_45 = key_23 in 
    let roundkey_44 = key_20 in 
    let roundkey_43 = key_55 in 
    let roundkey_42 = key_62 in 
    let roundkey_41 = key_53 in 
    let roundkey_40 = key_38 in 
    let roundkey_39 = key_13 in 
    let roundkey_38 = key_31 in 
    let roundkey_37 = key_4 in 
    let roundkey_36 = key_39 in 
    let roundkey_35 = key_61 in 
    let roundkey_34 = key_63 in 
    let roundkey_33 = key_15 in 
    let roundkey_32 = key_5 in 
    let roundkey_31 = key_22 in 
    let roundkey_30 = key_46 in 
    let roundkey_29 = key_47 in 
    let roundkey_28 = key_29 in 
    let roundkey_27 = key_14 in 
    let roundkey_26 = key_7 in 
    let roundkey_25 = key_28 in 
    let roundkey_24 = key_18 in 
    let roundkey_23 = key_60 in 
    let roundkey_22 = key_33 in 
    let roundkey_21 = key_42 in 
    let roundkey_20 = key_43 in 
    let roundkey_19 = key_36 in 
    let roundkey_18 = key_35 in 
    let roundkey_17 = key_50 in 
    let roundkey_16 = key_2 in 
    let roundkey_15 = key_3 in 
    let roundkey_14 = key_41 in 
    let roundkey_13 = key_9 in 
    let roundkey_12 = key_19 in 
    let roundkey_11 = key_25 in 
    let roundkey_10 = key_51 in 
    let roundkey_9 = key_44 in 
    let roundkey_8 = key_34 in 
    let roundkey_7 = key_10 in 
    let roundkey_6 = key_59 in 
    let roundkey_5 = key_26 in 
    let roundkey_4 = key_1 in 
    let roundkey_3 = key_11 in 
    let roundkey_2 = key_57 in 
    let roundkey_1 = key_52 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey8_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_53 in 
    let roundkey_47 = key_14 in 
    let roundkey_46 = key_21 in 
    let roundkey_45 = key_7 in 
    let roundkey_44 = key_4 in 
    let roundkey_43 = key_39 in 
    let roundkey_42 = key_46 in 
    let roundkey_41 = key_37 in 
    let roundkey_40 = key_22 in 
    let roundkey_39 = key_28 in 
    let roundkey_38 = key_15 in 
    let roundkey_37 = key_55 in 
    let roundkey_36 = key_23 in 
    let roundkey_35 = key_45 in 
    let roundkey_34 = key_47 in 
    let roundkey_33 = key_62 in 
    let roundkey_32 = key_20 in 
    let roundkey_31 = key_6 in 
    let roundkey_30 = key_30 in 
    let roundkey_29 = key_31 in 
    let roundkey_28 = key_13 in 
    let roundkey_27 = key_61 in 
    let roundkey_26 = key_54 in 
    let roundkey_25 = key_12 in 
    let roundkey_24 = key_2 in 
    let roundkey_23 = key_44 in 
    let roundkey_22 = key_17 in 
    let roundkey_21 = key_26 in 
    let roundkey_20 = key_27 in 
    let roundkey_19 = key_49 in 
    let roundkey_18 = key_19 in 
    let roundkey_17 = key_34 in 
    let roundkey_16 = key_51 in 
    let roundkey_15 = key_52 in 
    let roundkey_14 = key_25 in 
    let roundkey_13 = key_58 in 
    let roundkey_12 = key_3 in 
    let roundkey_11 = key_9 in 
    let roundkey_10 = key_35 in 
    let roundkey_9 = key_57 in 
    let roundkey_8 = key_18 in 
    let roundkey_7 = key_59 in 
    let roundkey_6 = key_43 in 
    let roundkey_5 = key_10 in 
    let roundkey_4 = key_50 in 
    let roundkey_3 = key_60 in 
    let roundkey_2 = key_41 in 
    let roundkey_1 = key_36 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey9_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_45 in 
    let roundkey_47 = key_6 in 
    let roundkey_46 = key_13 in 
    let roundkey_45 = key_62 in 
    let roundkey_44 = key_63 in 
    let roundkey_43 = key_31 in 
    let roundkey_42 = key_38 in 
    let roundkey_41 = key_29 in 
    let roundkey_40 = key_14 in 
    let roundkey_39 = key_20 in 
    let roundkey_38 = key_7 in 
    let roundkey_37 = key_47 in 
    let roundkey_36 = key_15 in 
    let roundkey_35 = key_37 in 
    let roundkey_34 = key_39 in 
    let roundkey_33 = key_54 in 
    let roundkey_32 = key_12 in 
    let roundkey_31 = key_61 in 
    let roundkey_30 = key_22 in 
    let roundkey_29 = key_23 in 
    let roundkey_28 = key_5 in 
    let roundkey_27 = key_53 in 
    let roundkey_26 = key_46 in 
    let roundkey_25 = key_4 in 
    let roundkey_24 = key_59 in 
    let roundkey_23 = key_36 in 
    let roundkey_22 = key_9 in 
    let roundkey_21 = key_18 in 
    let roundkey_20 = key_19 in 
    let roundkey_19 = key_41 in 
    let roundkey_18 = key_11 in 
    let roundkey_17 = key_26 in 
    let roundkey_16 = key_43 in 
    let roundkey_15 = key_44 in 
    let roundkey_14 = key_17 in 
    let roundkey_13 = key_50 in 
    let roundkey_12 = key_60 in 
    let roundkey_11 = key_1 in 
    let roundkey_10 = key_27 in 
    let roundkey_9 = key_49 in 
    let roundkey_8 = key_10 in 
    let roundkey_7 = key_51 in 
    let roundkey_6 = key_35 in 
    let roundkey_5 = key_2 in 
    let roundkey_4 = key_42 in 
    let roundkey_3 = key_52 in 
    let roundkey_2 = key_33 in 
    let roundkey_1 = key_57 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey10_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_29 in 
    let roundkey_47 = key_53 in 
    let roundkey_46 = key_28 in 
    let roundkey_45 = key_46 in 
    let roundkey_44 = key_47 in 
    let roundkey_43 = key_15 in 
    let roundkey_42 = key_22 in 
    let roundkey_41 = key_13 in 
    let roundkey_40 = key_61 in 
    let roundkey_39 = key_4 in 
    let roundkey_38 = key_54 in 
    let roundkey_37 = key_31 in 
    let roundkey_36 = key_62 in 
    let roundkey_35 = key_21 in 
    let roundkey_34 = key_23 in 
    let roundkey_33 = key_38 in 
    let roundkey_32 = key_63 in 
    let roundkey_31 = key_45 in 
    let roundkey_30 = key_6 in 
    let roundkey_29 = key_7 in 
    let roundkey_28 = key_20 in 
    let roundkey_27 = key_37 in 
    let roundkey_26 = key_30 in 
    let roundkey_25 = key_55 in 
    let roundkey_24 = key_43 in 
    let roundkey_23 = key_49 in 
    let roundkey_22 = key_58 in 
    let roundkey_21 = key_2 in 
    let roundkey_20 = key_3 in 
    let roundkey_19 = key_25 in 
    let roundkey_18 = key_60 in 
    let roundkey_17 = key_10 in 
    let roundkey_16 = key_27 in 
    let roundkey_15 = key_57 in 
    let roundkey_14 = key_1 in 
    let roundkey_13 = key_34 in 
    let roundkey_12 = key_44 in 
    let roundkey_11 = key_50 in 
    let roundkey_10 = key_11 in 
    let roundkey_9 = key_33 in 
    let roundkey_8 = key_59 in 
    let roundkey_7 = key_35 in 
    let roundkey_6 = key_19 in 
    let roundkey_5 = key_51 in 
    let roundkey_4 = key_26 in 
    let roundkey_3 = key_36 in 
    let roundkey_2 = key_17 in 
    let roundkey_1 = key_41 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey11_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_13 in 
    let roundkey_47 = key_37 in 
    let roundkey_46 = key_12 in 
    let roundkey_45 = key_30 in 
    let roundkey_44 = key_31 in 
    let roundkey_43 = key_62 in 
    let roundkey_42 = key_6 in 
    let roundkey_41 = key_28 in 
    let roundkey_40 = key_45 in 
    let roundkey_39 = key_55 in 
    let roundkey_38 = key_38 in 
    let roundkey_37 = key_15 in 
    let roundkey_36 = key_46 in 
    let roundkey_35 = key_5 in 
    let roundkey_34 = key_7 in 
    let roundkey_33 = key_22 in 
    let roundkey_32 = key_47 in 
    let roundkey_31 = key_29 in 
    let roundkey_30 = key_53 in 
    let roundkey_29 = key_54 in 
    let roundkey_28 = key_4 in 
    let roundkey_27 = key_21 in 
    let roundkey_26 = key_14 in 
    let roundkey_25 = key_39 in 
    let roundkey_24 = key_27 in 
    let roundkey_23 = key_33 in 
    let roundkey_22 = key_42 in 
    let roundkey_21 = key_51 in 
    let roundkey_20 = key_52 in 
    let roundkey_19 = key_9 in 
    let roundkey_18 = key_44 in 
    let roundkey_17 = key_59 in 
    let roundkey_16 = key_11 in 
    let roundkey_15 = key_41 in 
    let roundkey_14 = key_50 in 
    let roundkey_13 = key_18 in 
    let roundkey_12 = key_57 in 
    let roundkey_11 = key_34 in 
    let roundkey_10 = key_60 in 
    let roundkey_9 = key_17 in 
    let roundkey_8 = key_43 in 
    let roundkey_7 = key_19 in 
    let roundkey_6 = key_3 in 
    let roundkey_5 = key_35 in 
    let roundkey_4 = key_10 in 
    let roundkey_3 = key_49 in 
    let roundkey_2 = key_1 in 
    let roundkey_1 = key_25 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey12_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_28 in 
    let roundkey_47 = key_21 in 
    let roundkey_46 = key_63 in 
    let roundkey_45 = key_14 in 
    let roundkey_44 = key_15 in 
    let roundkey_43 = key_46 in 
    let roundkey_42 = key_53 in 
    let roundkey_41 = key_12 in 
    let roundkey_40 = key_29 in 
    let roundkey_39 = key_39 in 
    let roundkey_38 = key_22 in 
    let roundkey_37 = key_62 in 
    let roundkey_36 = key_30 in 
    let roundkey_35 = key_20 in 
    let roundkey_34 = key_54 in 
    let roundkey_33 = key_6 in 
    let roundkey_32 = key_31 in 
    let roundkey_31 = key_13 in 
    let roundkey_30 = key_37 in 
    let roundkey_29 = key_38 in 
    let roundkey_28 = key_55 in 
    let roundkey_27 = key_5 in 
    let roundkey_26 = key_61 in 
    let roundkey_25 = key_23 in 
    let roundkey_24 = key_11 in 
    let roundkey_23 = key_17 in 
    let roundkey_22 = key_26 in 
    let roundkey_21 = key_35 in 
    let roundkey_20 = key_36 in 
    let roundkey_19 = key_58 in 
    let roundkey_18 = key_57 in 
    let roundkey_17 = key_43 in 
    let roundkey_16 = key_60 in 
    let roundkey_15 = key_25 in 
    let roundkey_14 = key_34 in 
    let roundkey_13 = key_2 in 
    let roundkey_12 = key_41 in 
    let roundkey_11 = key_18 in 
    let roundkey_10 = key_44 in 
    let roundkey_9 = key_1 in 
    let roundkey_8 = key_27 in 
    let roundkey_7 = key_3 in 
    let roundkey_6 = key_52 in 
    let roundkey_5 = key_19 in 
    let roundkey_4 = key_59 in 
    let roundkey_3 = key_33 in 
    let roundkey_2 = key_50 in 
    let roundkey_1 = key_9 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey13_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_12 in 
    let roundkey_47 = key_5 in 
    let roundkey_46 = key_47 in 
    let roundkey_45 = key_61 in 
    let roundkey_44 = key_62 in 
    let roundkey_43 = key_30 in 
    let roundkey_42 = key_37 in 
    let roundkey_41 = key_63 in 
    let roundkey_40 = key_13 in 
    let roundkey_39 = key_23 in 
    let roundkey_38 = key_6 in 
    let roundkey_37 = key_46 in 
    let roundkey_36 = key_14 in 
    let roundkey_35 = key_4 in 
    let roundkey_34 = key_38 in 
    let roundkey_33 = key_53 in 
    let roundkey_32 = key_15 in 
    let roundkey_31 = key_28 in 
    let roundkey_30 = key_21 in 
    let roundkey_29 = key_22 in 
    let roundkey_28 = key_39 in 
    let roundkey_27 = key_20 in 
    let roundkey_26 = key_45 in 
    let roundkey_25 = key_7 in 
    let roundkey_24 = key_60 in 
    let roundkey_23 = key_1 in 
    let roundkey_22 = key_10 in 
    let roundkey_21 = key_19 in 
    let roundkey_20 = key_49 in 
    let roundkey_19 = key_42 in 
    let roundkey_18 = key_41 in 
    let roundkey_17 = key_27 in 
    let roundkey_16 = key_44 in 
    let roundkey_15 = key_9 in 
    let roundkey_14 = key_18 in 
    let roundkey_13 = key_51 in 
    let roundkey_12 = key_25 in 
    let roundkey_11 = key_2 in 
    let roundkey_10 = key_57 in 
    let roundkey_9 = key_50 in 
    let roundkey_8 = key_11 in 
    let roundkey_7 = key_52 in 
    let roundkey_6 = key_36 in 
    let roundkey_5 = key_3 in 
    let roundkey_4 = key_43 in 
    let roundkey_3 = key_17 in 
    let roundkey_2 = key_34 in 
    let roundkey_1 = key_58 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey14_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_63 in 
    let roundkey_47 = key_20 in 
    let roundkey_46 = key_31 in 
    let roundkey_45 = key_45 in 
    let roundkey_44 = key_46 in 
    let roundkey_43 = key_14 in 
    let roundkey_42 = key_21 in 
    let roundkey_41 = key_47 in 
    let roundkey_40 = key_28 in 
    let roundkey_39 = key_7 in 
    let roundkey_38 = key_53 in 
    let roundkey_37 = key_30 in 
    let roundkey_36 = key_61 in 
    let roundkey_35 = key_55 in 
    let roundkey_34 = key_22 in 
    let roundkey_33 = key_37 in 
    let roundkey_32 = key_62 in 
    let roundkey_31 = key_12 in 
    let roundkey_30 = key_5 in 
    let roundkey_29 = key_6 in 
    let roundkey_28 = key_23 in 
    let roundkey_27 = key_4 in 
    let roundkey_26 = key_29 in 
    let roundkey_25 = key_54 in 
    let roundkey_24 = key_44 in 
    let roundkey_23 = key_50 in 
    let roundkey_22 = key_59 in 
    let roundkey_21 = key_3 in 
    let roundkey_20 = key_33 in 
    let roundkey_19 = key_26 in 
    let roundkey_18 = key_25 in 
    let roundkey_17 = key_11 in 
    let roundkey_16 = key_57 in 
    let roundkey_15 = key_58 in 
    let roundkey_14 = key_2 in 
    let roundkey_13 = key_35 in 
    let roundkey_12 = key_9 in 
    let roundkey_11 = key_51 in 
    let roundkey_10 = key_41 in 
    let roundkey_9 = key_34 in 
    let roundkey_8 = key_60 in 
    let roundkey_7 = key_36 in 
    let roundkey_6 = key_49 in 
    let roundkey_5 = key_52 in 
    let roundkey_4 = key_27 in 
    let roundkey_3 = key_1 in 
    let roundkey_2 = key_18 in 
    let roundkey_1 = key_42 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey15_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_47 in 
    let roundkey_47 = key_4 in 
    let roundkey_46 = key_15 in 
    let roundkey_45 = key_29 in 
    let roundkey_44 = key_30 in 
    let roundkey_43 = key_61 in 
    let roundkey_42 = key_5 in 
    let roundkey_41 = key_31 in 
    let roundkey_40 = key_12 in 
    let roundkey_39 = key_54 in 
    let roundkey_38 = key_37 in 
    let roundkey_37 = key_14 in 
    let roundkey_36 = key_45 in 
    let roundkey_35 = key_39 in 
    let roundkey_34 = key_6 in 
    let roundkey_33 = key_21 in 
    let roundkey_32 = key_46 in 
    let roundkey_31 = key_63 in 
    let roundkey_30 = key_20 in 
    let roundkey_29 = key_53 in 
    let roundkey_28 = key_7 in 
    let roundkey_27 = key_55 in 
    let roundkey_26 = key_13 in 
    let roundkey_25 = key_38 in 
    let roundkey_24 = key_57 in 
    let roundkey_23 = key_34 in 
    let roundkey_22 = key_43 in 
    let roundkey_21 = key_52 in 
    let roundkey_20 = key_17 in 
    let roundkey_19 = key_10 in 
    let roundkey_18 = key_9 in 
    let roundkey_17 = key_60 in 
    let roundkey_16 = key_41 in 
    let roundkey_15 = key_42 in 
    let roundkey_14 = key_51 in 
    let roundkey_13 = key_19 in 
    let roundkey_12 = key_58 in 
    let roundkey_11 = key_35 in 
    let roundkey_10 = key_25 in 
    let roundkey_9 = key_18 in 
    let roundkey_8 = key_44 in 
    let roundkey_7 = key_49 in 
    let roundkey_6 = key_33 in 
    let roundkey_5 = key_36 in 
    let roundkey_4 = key_11 in 
    let roundkey_3 = key_50 in 
    let roundkey_2 = key_2 in 
    let roundkey_1 = key_26 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let roundkey16_ ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let roundkey_48 = key_39 in 
    let roundkey_47 = key_63 in 
    let roundkey_46 = key_7 in 
    let roundkey_45 = key_21 in 
    let roundkey_44 = key_22 in 
    let roundkey_43 = key_53 in 
    let roundkey_42 = key_28 in 
    let roundkey_41 = key_23 in 
    let roundkey_40 = key_4 in 
    let roundkey_39 = key_46 in 
    let roundkey_38 = key_29 in 
    let roundkey_37 = key_6 in 
    let roundkey_36 = key_37 in 
    let roundkey_35 = key_31 in 
    let roundkey_34 = key_61 in 
    let roundkey_33 = key_13 in 
    let roundkey_32 = key_38 in 
    let roundkey_31 = key_55 in 
    let roundkey_30 = key_12 in 
    let roundkey_29 = key_45 in 
    let roundkey_28 = key_62 in 
    let roundkey_27 = key_47 in 
    let roundkey_26 = key_5 in 
    let roundkey_25 = key_30 in 
    let roundkey_24 = key_49 in 
    let roundkey_23 = key_26 in 
    let roundkey_22 = key_35 in 
    let roundkey_21 = key_44 in 
    let roundkey_20 = key_9 in 
    let roundkey_19 = key_2 in 
    let roundkey_18 = key_1 in 
    let roundkey_17 = key_52 in 
    let roundkey_16 = key_33 in 
    let roundkey_15 = key_34 in 
    let roundkey_14 = key_43 in 
    let roundkey_13 = key_11 in 
    let roundkey_12 = key_50 in 
    let roundkey_11 = key_27 in 
    let roundkey_10 = key_17 in 
    let roundkey_9 = key_10 in 
    let roundkey_8 = key_36 in 
    let roundkey_7 = key_41 in 
    let roundkey_6 = key_25 in 
    let roundkey_5 = key_57 in 
    let roundkey_4 = key_3 in 
    let roundkey_3 = key_42 in 
    let roundkey_2 = key_59 in 
    let roundkey_1 = key_18 in 
    (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48)



let des_single1_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey1_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single2_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey2_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single3_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey3_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single4_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey4_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single5_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey5_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single6_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey6_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single7_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey7_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single8_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey8_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single9_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey9_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single10_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey10_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single11_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey11_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single12_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey12_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single13_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey13_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single14_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey14_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single15_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey15_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32) = (right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    (left_out_1,left_out_2,left_out_3,left_out_4,left_out_5,left_out_6,left_out_7,left_out_8,left_out_9,left_out_10,left_out_11,left_out_12,left_out_13,left_out_14,left_out_15,left_out_16,left_out_17,left_out_18,left_out_19,left_out_20,left_out_21,left_out_22,left_out_23,left_out_24,left_out_25,left_out_26,left_out_27,left_out_28,left_out_29,left_out_30,left_out_31,left_out_32,right_out_1,right_out_2,right_out_3,right_out_4,right_out_5,right_out_6,right_out_7,right_out_8,right_out_9,right_out_10,right_out_11,right_out_12,right_out_13,right_out_14,right_out_15,right_out_16,right_out_17,right_out_18,right_out_19,right_out_20,right_out_21,right_out_22,right_out_23,right_out_24,right_out_25,right_out_26,right_out_27,right_out_28,right_out_29,right_out_30,right_out_31,right_out_32,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)



let des_single16_ ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_in_1,right_in_2,right_in_3,right_in_4,right_in_5,right_in_6,right_in_7,right_in_8,right_in_9,right_in_10,right_in_11,right_in_12,right_in_13,right_in_14,right_in_15,right_in_16,right_in_17,right_in_18,right_in_19,right_in_20,right_in_21,right_in_22,right_in_23,right_in_24,right_in_25,right_in_26,right_in_27,right_in_28,right_in_29,right_in_30,right_in_31,right_in_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey16_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert5 (sbox_1_ (convert4 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert4 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert4 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert4 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert4 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert4 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert4 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert4 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_in_1,left_in_2,left_in_3,left_in_4,left_in_5,left_in_6,left_in_7,left_in_8,left_in_9,left_in_10,left_in_11,left_in_12,left_in_13,left_in_14,left_in_15,left_in_16,left_in_17,left_in_18,left_in_19,left_in_20,left_in_21,left_in_22,left_in_23,left_in_24,left_in_25,left_in_26,left_in_27,left_in_28,left_in_29,left_in_30,left_in_31,left_in_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
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
