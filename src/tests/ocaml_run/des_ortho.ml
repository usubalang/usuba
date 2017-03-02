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


let convert4 ((in11,in12,in13,in14,in15,in16,in17,in18,in19,in110,in111,in112,in113,in114,in115,in116,in117,in118,in119,in120,in121,in122,in123,in124,in125,in126,in127,in128,in129,in130,in131,in132),(in21,in22,in23,in24,in25,in26,in27,in28,in29,in210,in211,in212,in213,in214,in215,in216,in217,in218,in219,in220,in221,in222,in223,in224,in225,in226,in227,in228,in229,in230,in231,in232)) = 
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



let convert5 ((in11,in12,in13,in14,in15,in16)) = 
    let out11 = in11 in 
    let out21 = in12 in 
    let out31 = in13 in 
    let out41 = in14 in 
    let out51 = in15 in 
    let out61 = in16 in 
    ((out11),(out21),(out31),(out41),(out51),(out61))



let convert6 ((in11,in12,in13,in14),(in21,in22,in23,in24),(in31,in32,in33,in34),(in41,in42,in43,in44),(in51,in52,in53,in54),(in61,in62,in63,in64),(in71,in72,in73,in74),(in81,in82,in83,in84)) = 
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



let des_ ((plaintext_1,plaintext_2,plaintext_3,plaintext_4,plaintext_5,plaintext_6,plaintext_7,plaintext_8,plaintext_9,plaintext_10,plaintext_11,plaintext_12,plaintext_13,plaintext_14,plaintext_15,plaintext_16,plaintext_17,plaintext_18,plaintext_19,plaintext_20,plaintext_21,plaintext_22,plaintext_23,plaintext_24,plaintext_25,plaintext_26,plaintext_27,plaintext_28,plaintext_29,plaintext_30,plaintext_31,plaintext_32,plaintext_33,plaintext_34,plaintext_35,plaintext_36,plaintext_37,plaintext_38,plaintext_39,plaintext_40,plaintext_41,plaintext_42,plaintext_43,plaintext_44,plaintext_45,plaintext_46,plaintext_47,plaintext_48,plaintext_49,plaintext_50,plaintext_51,plaintext_52,plaintext_53,plaintext_54,plaintext_55,plaintext_56,plaintext_57,plaintext_58,plaintext_59,plaintext_60,plaintext_61,plaintext_62,plaintext_63,plaintext_64),(key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64)) = 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = init_p_ (id ((plaintext_1,plaintext_2,plaintext_3,plaintext_4,plaintext_5,plaintext_6,plaintext_7,plaintext_8,plaintext_9,plaintext_10,plaintext_11,plaintext_12,plaintext_13,plaintext_14,plaintext_15,plaintext_16,plaintext_17,plaintext_18,plaintext_19,plaintext_20,plaintext_21,plaintext_22,plaintext_23,plaintext_24,plaintext_25,plaintext_26,plaintext_27,plaintext_28,plaintext_29,plaintext_30,plaintext_31,plaintext_32,plaintext_33,plaintext_34,plaintext_35,plaintext_36,plaintext_37,plaintext_38,plaintext_39,plaintext_40,plaintext_41,plaintext_42,plaintext_43,plaintext_44,plaintext_45,plaintext_46,plaintext_47,plaintext_48,plaintext_49,plaintext_50,plaintext_51,plaintext_52,plaintext_53,plaintext_54,plaintext_55,plaintext_56,plaintext_57,plaintext_58,plaintext_59,plaintext_60,plaintext_61,plaintext_62,plaintext_63,plaintext_64))) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey1_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey2_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey3_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey4_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey5_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey6_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey7_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey8_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey9_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey10_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey11_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey12_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey13_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey14_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey15_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48) = expand_ (id ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32))) in 
    let (roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48) = roundkey16_ (id ((key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,key_11,key_12,key_13,key_14,key_15,key_16,key_17,key_18,key_19,key_20,key_21,key_22,key_23,key_24,key_25,key_26,key_27,key_28,key_29,key_30,key_31,key_32,key_33,key_34,key_35,key_36,key_37,key_38,key_39,key_40,key_41,key_42,key_43,key_44,key_45,key_46,key_47,key_48,key_49,key_50,key_51,key_52,key_53,key_54,key_55,key_56,key_57,key_58,key_59,key_60,key_61,key_62,key_63,key_64))) in 
    let (s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s3_1,s3_2,s3_3,s3_4,s3_5,s3_6,s4_1,s4_2,s4_3,s4_4,s4_5,s4_6,s5_1,s5_2,s5_3,s5_4,s5_5,s5_6,s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s8_1,s8_2,s8_3,s8_4,s8_5,s8_6) = xor48_ (id ((expanded_1,expanded_2,expanded_3,expanded_4,expanded_5,expanded_6,expanded_7,expanded_8,expanded_9,expanded_10,expanded_11,expanded_12,expanded_13,expanded_14,expanded_15,expanded_16,expanded_17,expanded_18,expanded_19,expanded_20,expanded_21,expanded_22,expanded_23,expanded_24,expanded_25,expanded_26,expanded_27,expanded_28,expanded_29,expanded_30,expanded_31,expanded_32,expanded_33,expanded_34,expanded_35,expanded_36,expanded_37,expanded_38,expanded_39,expanded_40,expanded_41,expanded_42,expanded_43,expanded_44,expanded_45,expanded_46,expanded_47,expanded_48),(roundkey_1,roundkey_2,roundkey_3,roundkey_4,roundkey_5,roundkey_6,roundkey_7,roundkey_8,roundkey_9,roundkey_10,roundkey_11,roundkey_12,roundkey_13,roundkey_14,roundkey_15,roundkey_16,roundkey_17,roundkey_18,roundkey_19,roundkey_20,roundkey_21,roundkey_22,roundkey_23,roundkey_24,roundkey_25,roundkey_26,roundkey_27,roundkey_28,roundkey_29,roundkey_30,roundkey_31,roundkey_32,roundkey_33,roundkey_34,roundkey_35,roundkey_36,roundkey_37,roundkey_38,roundkey_39,roundkey_40,roundkey_41,roundkey_42,roundkey_43,roundkey_44,roundkey_45,roundkey_46,roundkey_47,roundkey_48))) in 
    let (c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32) = permut_ (convert6 (sbox_1_ (convert5 ((s1_1,s1_2,s1_3,s1_4,s1_5,s1_6))),sbox_2_ (convert5 ((s2_1,s2_2,s2_3,s2_4,s2_5,s2_6))),sbox_3_ (convert5 ((s3_1,s3_2,s3_3,s3_4,s3_5,s3_6))),sbox_4_ (convert5 ((s4_1,s4_2,s4_3,s4_4,s4_5,s4_6))),sbox_5_ (convert5 ((s5_1,s5_2,s5_3,s5_4,s5_5,s5_6))),sbox_6_ (convert5 ((s6_1,s6_2,s6_3,s6_4,s6_5,s6_6))),sbox_7_ (convert5 ((s7_1,s7_2,s7_3,s7_4,s7_5,s7_6))),sbox_8_ (convert5 ((s8_1,s8_2,s8_3,s8_4,s8_5,s8_6))))) in 
    let (xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) = xor32_ (id ((left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32),(c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32))) in 
    let (left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32,right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32) = (right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32,xored_1,xored_2,xored_3,xored_4,xored_5,xored_6,xored_7,xored_8,xored_9,xored_10,xored_11,xored_12,xored_13,xored_14,xored_15,xored_16,xored_17,xored_18,xored_19,xored_20,xored_21,xored_22,xored_23,xored_24,xored_25,xored_26,xored_27,xored_28,xored_29,xored_30,xored_31,xored_32) in 
    let (ciphered_1,ciphered_2,ciphered_3,ciphered_4,ciphered_5,ciphered_6,ciphered_7,ciphered_8,ciphered_9,ciphered_10,ciphered_11,ciphered_12,ciphered_13,ciphered_14,ciphered_15,ciphered_16,ciphered_17,ciphered_18,ciphered_19,ciphered_20,ciphered_21,ciphered_22,ciphered_23,ciphered_24,ciphered_25,ciphered_26,ciphered_27,ciphered_28,ciphered_29,ciphered_30,ciphered_31,ciphered_32,ciphered_33,ciphered_34,ciphered_35,ciphered_36,ciphered_37,ciphered_38,ciphered_39,ciphered_40,ciphered_41,ciphered_42,ciphered_43,ciphered_44,ciphered_45,ciphered_46,ciphered_47,ciphered_48,ciphered_49,ciphered_50,ciphered_51,ciphered_52,ciphered_53,ciphered_54,ciphered_55,ciphered_56,ciphered_57,ciphered_58,ciphered_59,ciphered_60,ciphered_61,ciphered_62,ciphered_63,ciphered_64) = final_p_ (convert4 ((right_1,right_2,right_3,right_4,right_5,right_6,right_7,right_8,right_9,right_10,right_11,right_12,right_13,right_14,right_15,right_16,right_17,right_18,right_19,right_20,right_21,right_22,right_23,right_24,right_25,right_26,right_27,right_28,right_29,right_30,right_31,right_32),(left_1,left_2,left_3,left_4,left_5,left_6,left_7,left_8,left_9,left_10,left_11,left_12,left_13,left_14,left_15,left_16,left_17,left_18,left_19,left_20,left_21,left_22,left_23,left_24,left_25,left_26,left_27,left_28,left_29,left_30,left_31,left_32))) in 
    (ciphered_1,ciphered_2,ciphered_3,ciphered_4,ciphered_5,ciphered_6,ciphered_7,ciphered_8,ciphered_9,ciphered_10,ciphered_11,ciphered_12,ciphered_13,ciphered_14,ciphered_15,ciphered_16,ciphered_17,ciphered_18,ciphered_19,ciphered_20,ciphered_21,ciphered_22,ciphered_23,ciphered_24,ciphered_25,ciphered_26,ciphered_27,ciphered_28,ciphered_29,ciphered_30,ciphered_31,ciphered_32,ciphered_33,ciphered_34,ciphered_35,ciphered_36,ciphered_37,ciphered_38,ciphered_39,ciphered_40,ciphered_41,ciphered_42,ciphered_43,ciphered_44,ciphered_45,ciphered_46,ciphered_47,ciphered_48,ciphered_49,ciphered_50,ciphered_51,ciphered_52,ciphered_53,ciphered_54,ciphered_55,ciphered_56,ciphered_57,ciphered_58,ciphered_59,ciphered_60,ciphered_61,ciphered_62,ciphered_63,ciphered_64)


let main plaintext_stream key_stream = 
  let cpt = ref 0 in
  let stack_ciphered = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_ciphered.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let plaintext = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          plaintext.(i) <- Stream.next plaintext_stream
        done;
        let plaintext' = convert_ortho 64 plaintext in
        let (plaintext1,plaintext2,plaintext3,plaintext4,plaintext5,plaintext6,plaintext7,plaintext8,plaintext9,plaintext10,plaintext11,plaintext12,plaintext13,plaintext14,plaintext15,plaintext16,plaintext17,plaintext18,plaintext19,plaintext20,plaintext21,plaintext22,plaintext23,plaintext24,plaintext25,plaintext26,plaintext27,plaintext28,plaintext29,plaintext30,plaintext31,plaintext32,plaintext33,plaintext34,plaintext35,plaintext36,plaintext37,plaintext38,plaintext39,plaintext40,plaintext41,plaintext42,plaintext43,plaintext44,plaintext45,plaintext46,plaintext47,plaintext48,plaintext49,plaintext50,plaintext51,plaintext52,plaintext53,plaintext54,plaintext55,plaintext56,plaintext57,plaintext58,plaintext59,plaintext60,plaintext61,plaintext62,plaintext63,plaintext64) = (plaintext'.(0),plaintext'.(1),plaintext'.(2),plaintext'.(3),plaintext'.(4),plaintext'.(5),plaintext'.(6),plaintext'.(7),plaintext'.(8),plaintext'.(9),plaintext'.(10),plaintext'.(11),plaintext'.(12),plaintext'.(13),plaintext'.(14),plaintext'.(15),plaintext'.(16),plaintext'.(17),plaintext'.(18),plaintext'.(19),plaintext'.(20),plaintext'.(21),plaintext'.(22),plaintext'.(23),plaintext'.(24),plaintext'.(25),plaintext'.(26),plaintext'.(27),plaintext'.(28),plaintext'.(29),plaintext'.(30),plaintext'.(31),plaintext'.(32),plaintext'.(33),plaintext'.(34),plaintext'.(35),plaintext'.(36),plaintext'.(37),plaintext'.(38),plaintext'.(39),plaintext'.(40),plaintext'.(41),plaintext'.(42),plaintext'.(43),plaintext'.(44),plaintext'.(45),plaintext'.(46),plaintext'.(47),plaintext'.(48),plaintext'.(49),plaintext'.(50),plaintext'.(51),plaintext'.(52),plaintext'.(53),plaintext'.(54),plaintext'.(55),plaintext'.(56),plaintext'.(57),plaintext'.(58),plaintext'.(59),plaintext'.(60),plaintext'.(61),plaintext'.(62),plaintext'.(63)) in

        let key = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          key.(i) <- Stream.next key_stream
        done;
        let key' = convert_ortho 64 key in
        let (key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17,key18,key19,key20,key21,key22,key23,key24,key25,key26,key27,key28,key29,key30,key31,key32,key33,key34,key35,key36,key37,key38,key39,key40,key41,key42,key43,key44,key45,key46,key47,key48,key49,key50,key51,key52,key53,key54,key55,key56,key57,key58,key59,key60,key61,key62,key63,key64) = (key'.(0),key'.(1),key'.(2),key'.(3),key'.(4),key'.(5),key'.(6),key'.(7),key'.(8),key'.(9),key'.(10),key'.(11),key'.(12),key'.(13),key'.(14),key'.(15),key'.(16),key'.(17),key'.(18),key'.(19),key'.(20),key'.(21),key'.(22),key'.(23),key'.(24),key'.(25),key'.(26),key'.(27),key'.(28),key'.(29),key'.(30),key'.(31),key'.(32),key'.(33),key'.(34),key'.(35),key'.(36),key'.(37),key'.(38),key'.(39),key'.(40),key'.(41),key'.(42),key'.(43),key'.(44),key'.(45),key'.(46),key'.(47),key'.(48),key'.(49),key'.(50),key'.(51),key'.(52),key'.(53),key'.(54),key'.(55),key'.(56),key'.(57),key'.(58),key'.(59),key'.(60),key'.(61),key'.(62),key'.(63)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12,ret13,ret14,ret15,ret16,ret17,ret18,ret19,ret20,ret21,ret22,ret23,ret24,ret25,ret26,ret27,ret28,ret29,ret30,ret31,ret32,ret33,ret34,ret35,ret36,ret37,ret38,ret39,ret40,ret41,ret42,ret43,ret44,ret45,ret46,ret47,ret48,ret49,ret50,ret51,ret52,ret53,ret54,ret55,ret56,ret57,ret58,ret59,ret60,ret61,ret62,ret63,ret64) = des_ ((plaintext1,plaintext2,plaintext3,plaintext4,plaintext5,plaintext6,plaintext7,plaintext8,plaintext9,plaintext10,plaintext11,plaintext12,plaintext13,plaintext14,plaintext15,plaintext16,plaintext17,plaintext18,plaintext19,plaintext20,plaintext21,plaintext22,plaintext23,plaintext24,plaintext25,plaintext26,plaintext27,plaintext28,plaintext29,plaintext30,plaintext31,plaintext32,plaintext33,plaintext34,plaintext35,plaintext36,plaintext37,plaintext38,plaintext39,plaintext40,plaintext41,plaintext42,plaintext43,plaintext44,plaintext45,plaintext46,plaintext47,plaintext48,plaintext49,plaintext50,plaintext51,plaintext52,plaintext53,plaintext54,plaintext55,plaintext56,plaintext57,plaintext58,plaintext59,plaintext60,plaintext61,plaintext62,plaintext63,plaintext64),(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17,key18,key19,key20,key21,key22,key23,key24,key25,key26,key27,key28,key29,key30,key31,key32,key33,key34,key35,key36,key37,key38,key39,key40,key41,key42,key43,key44,key45,key46,key47,key48,key49,key50,key51,key52,key53,key54,key55,key56,key57,key58,key59,key60,key61,key62,key63,key64)) in
        let ciphered = Array.make 64 0 in
        ciphered.(1) <- ret1;
        ciphered.(2) <- ret2;
        ciphered.(3) <- ret3;
        ciphered.(4) <- ret4;
        ciphered.(5) <- ret5;
        ciphered.(6) <- ret6;
        ciphered.(7) <- ret7;
        ciphered.(8) <- ret8;
        ciphered.(9) <- ret9;
        ciphered.(10) <- ret10;
        ciphered.(11) <- ret11;
        ciphered.(12) <- ret12;
        ciphered.(13) <- ret13;
        ciphered.(14) <- ret14;
        ciphered.(15) <- ret15;
        ciphered.(16) <- ret16;
        ciphered.(17) <- ret17;
        ciphered.(18) <- ret18;
        ciphered.(19) <- ret19;
        ciphered.(20) <- ret20;
        ciphered.(21) <- ret21;
        ciphered.(22) <- ret22;
        ciphered.(23) <- ret23;
        ciphered.(24) <- ret24;
        ciphered.(25) <- ret25;
        ciphered.(26) <- ret26;
        ciphered.(27) <- ret27;
        ciphered.(28) <- ret28;
        ciphered.(29) <- ret29;
        ciphered.(30) <- ret30;
        ciphered.(31) <- ret31;
        ciphered.(32) <- ret32;
        ciphered.(33) <- ret33;
        ciphered.(34) <- ret34;
        ciphered.(35) <- ret35;
        ciphered.(36) <- ret36;
        ciphered.(37) <- ret37;
        ciphered.(38) <- ret38;
        ciphered.(39) <- ret39;
        ciphered.(40) <- ret40;
        ciphered.(41) <- ret41;
        ciphered.(42) <- ret42;
        ciphered.(43) <- ret43;
        ciphered.(44) <- ret44;
        ciphered.(45) <- ret45;
        ciphered.(46) <- ret46;
        ciphered.(47) <- ret47;
        ciphered.(48) <- ret48;
        ciphered.(49) <- ret49;
        ciphered.(50) <- ret50;
        ciphered.(51) <- ret51;
        ciphered.(52) <- ret52;
        ciphered.(53) <- ret53;
        ciphered.(54) <- ret54;
        ciphered.(55) <- ret55;
        ciphered.(56) <- ret56;
        ciphered.(57) <- ret57;
        ciphered.(58) <- ret58;
        ciphered.(59) <- ret59;
        ciphered.(60) <- ret60;
        ciphered.(61) <- ret61;
        ciphered.(62) <- ret62;
        ciphered.(63) <- ret63;
        ciphered.(64) <- ret64;
        stack_ciphered := convert_unortho ciphered;

        cpt := 0;
        let return = Some (!stack_ciphered.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
