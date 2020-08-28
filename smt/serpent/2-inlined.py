
from pyboolector import *
from timeit import default_timer as timer

btor = Boolector()

# Inputs
plaintext_ = [ btor.Var(btor.BitVecSort(32), 'plaintext_[%d]' % (c0)) for c0 in range(4)]
keys_ = [[ btor.Var(btor.BitVecSort(32), 'keys_[%d][%d]' % (c0,c1)) for c1 in range(4)] for c0 in range(33)]


######################################################################
#                          Original program                          #
######################################################################

def orig_sbox_0_V32(a,b,c,d):


  t01 = b ^ c
  t02 = a | d
  t03 = a ^ b
  z = t02 ^ t01
  t05 = c | z
  t06 = a ^ d
  t07 = b | c
  t08 = d & t05
  t09 = t03 & t07
  y = t09 ^ t08
  t11 = t09 & y
  t12 = c ^ d
  t13 = t07 ^ t11
  t14 = b & t06
  t15 = t06 ^ t13
  w = ~ t15
  t17 = w ^ t14
  x = t12 ^ t17

  return (w,x,y,z)


def orig_sbox_1_V32(a,b,c,d):


  t01 = a | d
  t02 = c ^ d
  t03 = ~ b
  t04 = a ^ c
  t05 = a | t03
  t06 = d & t04
  t07 = t01 & t02
  t08 = b | t06
  y = t02 ^ t05
  t10 = t07 ^ t08
  t11 = t01 ^ t10
  t12 = y ^ t11
  t13 = b & d
  z = ~ t10
  x = t13 ^ t12
  t16 = t10 | x
  t17 = t05 & t16
  w = c ^ t17

  return (w,x,y,z)


def orig_sbox_2_V32(a,b,c,d):


  t01 = a | c
  t02 = a ^ b
  t03 = d ^ t01
  w = t02 ^ t03
  t05 = c ^ w
  t06 = b ^ t05
  t07 = b | t05
  t08 = t01 & t06
  t09 = t03 ^ t07
  t10 = t02 | t09
  x = t10 ^ t08
  t12 = a | d
  t13 = t09 ^ x
  t14 = b ^ t13
  z = ~ t09
  y = t12 ^ t14

  return (w,x,y,z)


def orig_sbox_3_V32(a,b,c,d):


  t01 = a ^ c
  t02 = a | d
  t03 = a & d
  t04 = t01 & t02
  t05 = b | t03
  t06 = a & b
  t07 = d ^ t04
  t08 = c | t06
  t09 = b ^ t07
  t10 = d & t05
  t11 = t02 ^ t10
  z = t08 ^ t09
  t13 = d | z
  t14 = a | t07
  t15 = b & t13
  y = t08 ^ t11
  w = t14 ^ t15
  x = t05 ^ t04

  return (w,x,y,z)


def orig_sbox_4_V32(a,b,c,d):


  t01 = a | b
  t02 = b | c
  t03 = a ^ t02
  t04 = b ^ d
  t05 = d | t03
  t06 = d & t01
  z = t03 ^ t06
  t08 = z & t04
  t09 = t04 & t05
  t10 = c ^ t06
  t11 = b & c
  t12 = t04 ^ t08
  t13 = t11 | t03
  t14 = t10 ^ t09
  t15 = a & t05
  t16 = t11 | t12
  y = t13 ^ t08
  x = t15 ^ t16
  w = ~ t14

  return (w,x,y,z)


def orig_sbox_5_V32(a,b,c,d):


  t01 = b ^ d
  t02 = b | d
  t03 = a & t01
  t04 = c ^ t02
  t05 = t03 ^ t04
  w = ~ t05
  t07 = a ^ t01
  t08 = d | w
  t09 = b | t05
  t10 = d ^ t08
  t11 = b | t07
  t12 = t03 | w
  t13 = t07 | t10
  t14 = t01 ^ t11
  y = t09 ^ t13
  x = t07 ^ t08
  z = t12 ^ t14

  return (w,x,y,z)


def orig_sbox_6_V32(a,b,c,d):


  t01 = a & d
  t02 = b ^ c
  t03 = a ^ d
  t04 = t01 ^ t02
  t05 = b | c
  x = ~ t04
  t07 = t03 & t05
  t08 = b & x
  t09 = a | c
  t10 = t07 ^ t08
  t11 = b | d
  t12 = c ^ t11
  t13 = t09 ^ t10
  y = ~ t13
  t15 = x & t03
  z = t12 ^ t07
  t17 = a ^ b
  t18 = y ^ t15
  w = t17 ^ t18

  return (w,x,y,z)


def orig_sbox_7_V32(a,b,c,d):


  t01 = a & c
  t02 = ~ d
  t03 = a & t02
  t04 = b | t01
  t05 = a & b
  t06 = c ^ t04
  z = t03 ^ t06
  t08 = c | z
  t09 = d | t05
  t10 = a ^ t08
  t11 = t04 & z
  x = t09 ^ t10
  t13 = b ^ x
  t14 = t01 ^ x
  t15 = c ^ t05
  t16 = t11 | t13
  t17 = t02 | t14
  w = t15 ^ t17
  y = a ^ t16

  return (w,x,y,z)


def orig_transform_V32(x_):
  out_ = [ None for _ in range(4)]


  _shadow_x_1_ = btor.Rol(x_[0],13)
  _shadow_x_2_ = btor.Rol(x_[2],3)
  _tmp1_ = x_[1] ^ _shadow_x_1_
  _shadow_x_3_ = _tmp1_ ^ _shadow_x_2_
  _tmp2_ = x_[3] ^ _shadow_x_2_
  _tmp3_ = _shadow_x_1_ << 3
  _shadow_x_4_ = _tmp2_ ^ _tmp3_
  _shadow_x_5_ = btor.Rol(_shadow_x_3_,1)
  _shadow_x_6_ = btor.Rol(_shadow_x_4_,7)
  _tmp4_ = _shadow_x_1_ ^ _shadow_x_5_
  _shadow_x_7_ = _tmp4_ ^ _shadow_x_6_
  _tmp5_ = _shadow_x_2_ ^ _shadow_x_6_
  _tmp6_ = _shadow_x_5_ << 7
  _shadow_x_8_ = _tmp5_ ^ _tmp6_
  _shadow_x_9_ = btor.Rol(_shadow_x_7_,5)
  _shadow_x_10_ = btor.Rol(_shadow_x_8_,22)
  out_[0] = _shadow_x_9_
  out_[1] = _shadow_x_5_
  out_[2] = _shadow_x_10_
  out_[3] = _shadow_x_6_

  return (out_)


def orig_Serpent_(plaintext_,keys_):
  ciphertext_ = [ None for _ in range(4)]

  tmp_ = [[ None for _ in range(4)] for _ in range(32)]
  _tmp70_ = [ None for _ in range(4)]
  _tmp69_ = [ None for _ in range(4)]
  _tmp68_ = [ None for _ in range(4)]
  _tmp67_ = [ None for _ in range(4)]
  _tmp66_ = [ None for _ in range(4)]
  _tmp65_ = [ None for _ in range(4)]
  _tmp64_ = [ None for _ in range(4)]
  _tmp63_ = [ None for _ in range(4)]
  _tmp62_ = [ None for _ in range(4)]
  _tmp61_ = [ None for _ in range(4)]
  _tmp60_ = [ None for _ in range(4)]
  _tmp59_ = [ None for _ in range(4)]
  _tmp58_ = [ None for _ in range(4)]
  _tmp57_ = [ None for _ in range(4)]
  _tmp56_ = [ None for _ in range(4)]
  _tmp55_ = [ None for _ in range(4)]
  _tmp54_ = [ None for _ in range(4)]
  _tmp53_ = [ None for _ in range(4)]
  _tmp52_ = [ None for _ in range(4)]
  _tmp51_ = [ None for _ in range(4)]
  _tmp50_ = [ None for _ in range(4)]
  _tmp49_ = [ None for _ in range(4)]
  _tmp48_ = [ None for _ in range(4)]
  _tmp47_ = [ None for _ in range(4)]
  _tmp46_ = [ None for _ in range(4)]
  _tmp45_ = [ None for _ in range(4)]
  _tmp44_ = [ None for _ in range(4)]
  _tmp43_ = [ None for _ in range(4)]
  _tmp42_ = [ None for _ in range(4)]
  _tmp41_ = [ None for _ in range(4)]
  _tmp40_ = [ None for _ in range(4)]
  _tmp39_ = [ None for _ in range(4)]
  _tmp38_ = [ None for _ in range(4)]
  _tmp37_ = [ None for _ in range(4)]
  _tmp36_ = [ None for _ in range(4)]
  _tmp35_ = [ None for _ in range(4)]
  _tmp34_ = [ None for _ in range(4)]
  _tmp33_ = [ None for _ in range(4)]
  _tmp32_ = [ None for _ in range(4)]
  _tmp31_ = [ None for _ in range(4)]
  _tmp30_ = [ None for _ in range(4)]
  _tmp29_ = [ None for _ in range(4)]
  _tmp28_ = [ None for _ in range(4)]
  _tmp27_ = [ None for _ in range(4)]
  _tmp26_ = [ None for _ in range(4)]
  _tmp25_ = [ None for _ in range(4)]
  _tmp24_ = [ None for _ in range(4)]
  _tmp23_ = [ None for _ in range(4)]
  _tmp22_ = [ None for _ in range(4)]
  _tmp21_ = [ None for _ in range(4)]
  _tmp20_ = [ None for _ in range(4)]
  _tmp19_ = [ None for _ in range(4)]
  _tmp18_ = [ None for _ in range(4)]
  _tmp17_ = [ None for _ in range(4)]
  _tmp16_ = [ None for _ in range(4)]
  _tmp15_ = [ None for _ in range(4)]
  _tmp14_ = [ None for _ in range(4)]
  _tmp13_ = [ None for _ in range(4)]
  _tmp12_ = [ None for _ in range(4)]
  _tmp11_ = [ None for _ in range(4)]
  _tmp10_ = [ None for _ in range(4)]
  _tmp9_ = [ None for _ in range(4)]
  _tmp8_ = [ None for _ in range(4)]
  _tmp7_ = [ None for _ in range(4)]

  _tmp7_[0] = plaintext_[0] ^ keys_[0][0]
  _tmp7_[1] = plaintext_[1] ^ keys_[0][1]
  _tmp7_[2] = plaintext_[2] ^ keys_[0][2]
  _tmp7_[3] = plaintext_[3] ^ keys_[0][3]
  (_tmp8_[0],_tmp8_[1],_tmp8_[2],_tmp8_[3]) = orig_sbox_0_V32(_tmp7_[0],_tmp7_[1],_tmp7_[2],_tmp7_[3])
  (tmp_[1]) = orig_transform_V32(_tmp8_)
  _tmp9_[0] = tmp_[1][0] ^ keys_[1][0]
  _tmp9_[1] = tmp_[1][1] ^ keys_[1][1]
  _tmp9_[2] = tmp_[1][2] ^ keys_[1][2]
  _tmp9_[3] = tmp_[1][3] ^ keys_[1][3]
  (_tmp10_[0],_tmp10_[1],_tmp10_[2],_tmp10_[3]) = orig_sbox_1_V32(_tmp9_[0],_tmp9_[1],_tmp9_[2],_tmp9_[3])
  (tmp_[2]) = orig_transform_V32(_tmp10_)
  _tmp11_[0] = tmp_[2][0] ^ keys_[2][0]
  _tmp11_[1] = tmp_[2][1] ^ keys_[2][1]
  _tmp11_[2] = tmp_[2][2] ^ keys_[2][2]
  _tmp11_[3] = tmp_[2][3] ^ keys_[2][3]
  (_tmp12_[0],_tmp12_[1],_tmp12_[2],_tmp12_[3]) = orig_sbox_2_V32(_tmp11_[0],_tmp11_[1],_tmp11_[2],_tmp11_[3])
  (tmp_[3]) = orig_transform_V32(_tmp12_)
  _tmp13_[0] = tmp_[3][0] ^ keys_[3][0]
  _tmp13_[1] = tmp_[3][1] ^ keys_[3][1]
  _tmp13_[2] = tmp_[3][2] ^ keys_[3][2]
  _tmp13_[3] = tmp_[3][3] ^ keys_[3][3]
  (_tmp14_[0],_tmp14_[1],_tmp14_[2],_tmp14_[3]) = orig_sbox_3_V32(_tmp13_[0],_tmp13_[1],_tmp13_[2],_tmp13_[3])
  (tmp_[4]) = orig_transform_V32(_tmp14_)
  _tmp15_[0] = tmp_[4][0] ^ keys_[4][0]
  _tmp15_[1] = tmp_[4][1] ^ keys_[4][1]
  _tmp15_[2] = tmp_[4][2] ^ keys_[4][2]
  _tmp15_[3] = tmp_[4][3] ^ keys_[4][3]
  (_tmp16_[0],_tmp16_[1],_tmp16_[2],_tmp16_[3]) = orig_sbox_4_V32(_tmp15_[0],_tmp15_[1],_tmp15_[2],_tmp15_[3])
  (tmp_[5]) = orig_transform_V32(_tmp16_)
  _tmp17_[0] = tmp_[5][0] ^ keys_[5][0]
  _tmp17_[1] = tmp_[5][1] ^ keys_[5][1]
  _tmp17_[2] = tmp_[5][2] ^ keys_[5][2]
  _tmp17_[3] = tmp_[5][3] ^ keys_[5][3]
  (_tmp18_[0],_tmp18_[1],_tmp18_[2],_tmp18_[3]) = orig_sbox_5_V32(_tmp17_[0],_tmp17_[1],_tmp17_[2],_tmp17_[3])
  (tmp_[6]) = orig_transform_V32(_tmp18_)
  _tmp19_[0] = tmp_[6][0] ^ keys_[6][0]
  _tmp19_[1] = tmp_[6][1] ^ keys_[6][1]
  _tmp19_[2] = tmp_[6][2] ^ keys_[6][2]
  _tmp19_[3] = tmp_[6][3] ^ keys_[6][3]
  (_tmp20_[0],_tmp20_[1],_tmp20_[2],_tmp20_[3]) = orig_sbox_6_V32(_tmp19_[0],_tmp19_[1],_tmp19_[2],_tmp19_[3])
  (tmp_[7]) = orig_transform_V32(_tmp20_)
  _tmp21_[0] = tmp_[7][0] ^ keys_[7][0]
  _tmp21_[1] = tmp_[7][1] ^ keys_[7][1]
  _tmp21_[2] = tmp_[7][2] ^ keys_[7][2]
  _tmp21_[3] = tmp_[7][3] ^ keys_[7][3]
  (_tmp22_[0],_tmp22_[1],_tmp22_[2],_tmp22_[3]) = orig_sbox_7_V32(_tmp21_[0],_tmp21_[1],_tmp21_[2],_tmp21_[3])
  (tmp_[8]) = orig_transform_V32(_tmp22_)
  _tmp23_[0] = tmp_[8][0] ^ keys_[8][0]
  _tmp23_[1] = tmp_[8][1] ^ keys_[8][1]
  _tmp23_[2] = tmp_[8][2] ^ keys_[8][2]
  _tmp23_[3] = tmp_[8][3] ^ keys_[8][3]
  (_tmp24_[0],_tmp24_[1],_tmp24_[2],_tmp24_[3]) = orig_sbox_0_V32(_tmp23_[0],_tmp23_[1],_tmp23_[2],_tmp23_[3])
  (tmp_[9]) = orig_transform_V32(_tmp24_)
  _tmp25_[0] = tmp_[9][0] ^ keys_[9][0]
  _tmp25_[1] = tmp_[9][1] ^ keys_[9][1]
  _tmp25_[2] = tmp_[9][2] ^ keys_[9][2]
  _tmp25_[3] = tmp_[9][3] ^ keys_[9][3]
  (_tmp26_[0],_tmp26_[1],_tmp26_[2],_tmp26_[3]) = orig_sbox_1_V32(_tmp25_[0],_tmp25_[1],_tmp25_[2],_tmp25_[3])
  (tmp_[10]) = orig_transform_V32(_tmp26_)
  _tmp27_[0] = tmp_[10][0] ^ keys_[10][0]
  _tmp27_[1] = tmp_[10][1] ^ keys_[10][1]
  _tmp27_[2] = tmp_[10][2] ^ keys_[10][2]
  _tmp27_[3] = tmp_[10][3] ^ keys_[10][3]
  (_tmp28_[0],_tmp28_[1],_tmp28_[2],_tmp28_[3]) = orig_sbox_2_V32(_tmp27_[0],_tmp27_[1],_tmp27_[2],_tmp27_[3])
  (tmp_[11]) = orig_transform_V32(_tmp28_)
  _tmp29_[0] = tmp_[11][0] ^ keys_[11][0]
  _tmp29_[1] = tmp_[11][1] ^ keys_[11][1]
  _tmp29_[2] = tmp_[11][2] ^ keys_[11][2]
  _tmp29_[3] = tmp_[11][3] ^ keys_[11][3]
  (_tmp30_[0],_tmp30_[1],_tmp30_[2],_tmp30_[3]) = orig_sbox_3_V32(_tmp29_[0],_tmp29_[1],_tmp29_[2],_tmp29_[3])
  (tmp_[12]) = orig_transform_V32(_tmp30_)
  _tmp31_[0] = tmp_[12][0] ^ keys_[12][0]
  _tmp31_[1] = tmp_[12][1] ^ keys_[12][1]
  _tmp31_[2] = tmp_[12][2] ^ keys_[12][2]
  _tmp31_[3] = tmp_[12][3] ^ keys_[12][3]
  (_tmp32_[0],_tmp32_[1],_tmp32_[2],_tmp32_[3]) = orig_sbox_4_V32(_tmp31_[0],_tmp31_[1],_tmp31_[2],_tmp31_[3])
  (tmp_[13]) = orig_transform_V32(_tmp32_)
  _tmp33_[0] = tmp_[13][0] ^ keys_[13][0]
  _tmp33_[1] = tmp_[13][1] ^ keys_[13][1]
  _tmp33_[2] = tmp_[13][2] ^ keys_[13][2]
  _tmp33_[3] = tmp_[13][3] ^ keys_[13][3]
  (_tmp34_[0],_tmp34_[1],_tmp34_[2],_tmp34_[3]) = orig_sbox_5_V32(_tmp33_[0],_tmp33_[1],_tmp33_[2],_tmp33_[3])
  (tmp_[14]) = orig_transform_V32(_tmp34_)
  _tmp35_[0] = tmp_[14][0] ^ keys_[14][0]
  _tmp35_[1] = tmp_[14][1] ^ keys_[14][1]
  _tmp35_[2] = tmp_[14][2] ^ keys_[14][2]
  _tmp35_[3] = tmp_[14][3] ^ keys_[14][3]
  (_tmp36_[0],_tmp36_[1],_tmp36_[2],_tmp36_[3]) = orig_sbox_6_V32(_tmp35_[0],_tmp35_[1],_tmp35_[2],_tmp35_[3])
  (tmp_[15]) = orig_transform_V32(_tmp36_)
  _tmp37_[0] = tmp_[15][0] ^ keys_[15][0]
  _tmp37_[1] = tmp_[15][1] ^ keys_[15][1]
  _tmp37_[2] = tmp_[15][2] ^ keys_[15][2]
  _tmp37_[3] = tmp_[15][3] ^ keys_[15][3]
  (_tmp38_[0],_tmp38_[1],_tmp38_[2],_tmp38_[3]) = orig_sbox_7_V32(_tmp37_[0],_tmp37_[1],_tmp37_[2],_tmp37_[3])
  (tmp_[16]) = orig_transform_V32(_tmp38_)
  _tmp39_[0] = tmp_[16][0] ^ keys_[16][0]
  _tmp39_[1] = tmp_[16][1] ^ keys_[16][1]
  _tmp39_[2] = tmp_[16][2] ^ keys_[16][2]
  _tmp39_[3] = tmp_[16][3] ^ keys_[16][3]
  (_tmp40_[0],_tmp40_[1],_tmp40_[2],_tmp40_[3]) = orig_sbox_0_V32(_tmp39_[0],_tmp39_[1],_tmp39_[2],_tmp39_[3])
  (tmp_[17]) = orig_transform_V32(_tmp40_)
  _tmp41_[0] = tmp_[17][0] ^ keys_[17][0]
  _tmp41_[1] = tmp_[17][1] ^ keys_[17][1]
  _tmp41_[2] = tmp_[17][2] ^ keys_[17][2]
  _tmp41_[3] = tmp_[17][3] ^ keys_[17][3]
  (_tmp42_[0],_tmp42_[1],_tmp42_[2],_tmp42_[3]) = orig_sbox_1_V32(_tmp41_[0],_tmp41_[1],_tmp41_[2],_tmp41_[3])
  (tmp_[18]) = orig_transform_V32(_tmp42_)
  _tmp43_[0] = tmp_[18][0] ^ keys_[18][0]
  _tmp43_[1] = tmp_[18][1] ^ keys_[18][1]
  _tmp43_[2] = tmp_[18][2] ^ keys_[18][2]
  _tmp43_[3] = tmp_[18][3] ^ keys_[18][3]
  (_tmp44_[0],_tmp44_[1],_tmp44_[2],_tmp44_[3]) = orig_sbox_2_V32(_tmp43_[0],_tmp43_[1],_tmp43_[2],_tmp43_[3])
  (tmp_[19]) = orig_transform_V32(_tmp44_)
  _tmp45_[0] = tmp_[19][0] ^ keys_[19][0]
  _tmp45_[1] = tmp_[19][1] ^ keys_[19][1]
  _tmp45_[2] = tmp_[19][2] ^ keys_[19][2]
  _tmp45_[3] = tmp_[19][3] ^ keys_[19][3]
  (_tmp46_[0],_tmp46_[1],_tmp46_[2],_tmp46_[3]) = orig_sbox_3_V32(_tmp45_[0],_tmp45_[1],_tmp45_[2],_tmp45_[3])
  (tmp_[20]) = orig_transform_V32(_tmp46_)
  _tmp47_[0] = tmp_[20][0] ^ keys_[20][0]
  _tmp47_[1] = tmp_[20][1] ^ keys_[20][1]
  _tmp47_[2] = tmp_[20][2] ^ keys_[20][2]
  _tmp47_[3] = tmp_[20][3] ^ keys_[20][3]
  (_tmp48_[0],_tmp48_[1],_tmp48_[2],_tmp48_[3]) = orig_sbox_4_V32(_tmp47_[0],_tmp47_[1],_tmp47_[2],_tmp47_[3])
  (tmp_[21]) = orig_transform_V32(_tmp48_)
  _tmp49_[0] = tmp_[21][0] ^ keys_[21][0]
  _tmp49_[1] = tmp_[21][1] ^ keys_[21][1]
  _tmp49_[2] = tmp_[21][2] ^ keys_[21][2]
  _tmp49_[3] = tmp_[21][3] ^ keys_[21][3]
  (_tmp50_[0],_tmp50_[1],_tmp50_[2],_tmp50_[3]) = orig_sbox_5_V32(_tmp49_[0],_tmp49_[1],_tmp49_[2],_tmp49_[3])
  (tmp_[22]) = orig_transform_V32(_tmp50_)
  _tmp51_[0] = tmp_[22][0] ^ keys_[22][0]
  _tmp51_[1] = tmp_[22][1] ^ keys_[22][1]
  _tmp51_[2] = tmp_[22][2] ^ keys_[22][2]
  _tmp51_[3] = tmp_[22][3] ^ keys_[22][3]
  (_tmp52_[0],_tmp52_[1],_tmp52_[2],_tmp52_[3]) = orig_sbox_6_V32(_tmp51_[0],_tmp51_[1],_tmp51_[2],_tmp51_[3])
  (tmp_[23]) = orig_transform_V32(_tmp52_)
  _tmp53_[0] = tmp_[23][0] ^ keys_[23][0]
  _tmp53_[1] = tmp_[23][1] ^ keys_[23][1]
  _tmp53_[2] = tmp_[23][2] ^ keys_[23][2]
  _tmp53_[3] = tmp_[23][3] ^ keys_[23][3]
  (_tmp54_[0],_tmp54_[1],_tmp54_[2],_tmp54_[3]) = orig_sbox_7_V32(_tmp53_[0],_tmp53_[1],_tmp53_[2],_tmp53_[3])
  (tmp_[24]) = orig_transform_V32(_tmp54_)
  _tmp55_[0] = tmp_[24][0] ^ keys_[24][0]
  _tmp55_[1] = tmp_[24][1] ^ keys_[24][1]
  _tmp55_[2] = tmp_[24][2] ^ keys_[24][2]
  _tmp55_[3] = tmp_[24][3] ^ keys_[24][3]
  (_tmp56_[0],_tmp56_[1],_tmp56_[2],_tmp56_[3]) = orig_sbox_0_V32(_tmp55_[0],_tmp55_[1],_tmp55_[2],_tmp55_[3])
  (tmp_[25]) = orig_transform_V32(_tmp56_)
  _tmp57_[0] = tmp_[25][0] ^ keys_[25][0]
  _tmp57_[1] = tmp_[25][1] ^ keys_[25][1]
  _tmp57_[2] = tmp_[25][2] ^ keys_[25][2]
  _tmp57_[3] = tmp_[25][3] ^ keys_[25][3]
  (_tmp58_[0],_tmp58_[1],_tmp58_[2],_tmp58_[3]) = orig_sbox_1_V32(_tmp57_[0],_tmp57_[1],_tmp57_[2],_tmp57_[3])
  (tmp_[26]) = orig_transform_V32(_tmp58_)
  _tmp59_[0] = tmp_[26][0] ^ keys_[26][0]
  _tmp59_[1] = tmp_[26][1] ^ keys_[26][1]
  _tmp59_[2] = tmp_[26][2] ^ keys_[26][2]
  _tmp59_[3] = tmp_[26][3] ^ keys_[26][3]
  (_tmp60_[0],_tmp60_[1],_tmp60_[2],_tmp60_[3]) = orig_sbox_2_V32(_tmp59_[0],_tmp59_[1],_tmp59_[2],_tmp59_[3])
  (tmp_[27]) = orig_transform_V32(_tmp60_)
  _tmp61_[0] = tmp_[27][0] ^ keys_[27][0]
  _tmp61_[1] = tmp_[27][1] ^ keys_[27][1]
  _tmp61_[2] = tmp_[27][2] ^ keys_[27][2]
  _tmp61_[3] = tmp_[27][3] ^ keys_[27][3]
  (_tmp62_[0],_tmp62_[1],_tmp62_[2],_tmp62_[3]) = orig_sbox_3_V32(_tmp61_[0],_tmp61_[1],_tmp61_[2],_tmp61_[3])
  (tmp_[28]) = orig_transform_V32(_tmp62_)
  _tmp63_[0] = tmp_[28][0] ^ keys_[28][0]
  _tmp63_[1] = tmp_[28][1] ^ keys_[28][1]
  _tmp63_[2] = tmp_[28][2] ^ keys_[28][2]
  _tmp63_[3] = tmp_[28][3] ^ keys_[28][3]
  (_tmp64_[0],_tmp64_[1],_tmp64_[2],_tmp64_[3]) = orig_sbox_4_V32(_tmp63_[0],_tmp63_[1],_tmp63_[2],_tmp63_[3])
  (tmp_[29]) = orig_transform_V32(_tmp64_)
  _tmp65_[0] = tmp_[29][0] ^ keys_[29][0]
  _tmp65_[1] = tmp_[29][1] ^ keys_[29][1]
  _tmp65_[2] = tmp_[29][2] ^ keys_[29][2]
  _tmp65_[3] = tmp_[29][3] ^ keys_[29][3]
  (_tmp66_[0],_tmp66_[1],_tmp66_[2],_tmp66_[3]) = orig_sbox_5_V32(_tmp65_[0],_tmp65_[1],_tmp65_[2],_tmp65_[3])
  (tmp_[30]) = orig_transform_V32(_tmp66_)
  _tmp67_[0] = tmp_[30][0] ^ keys_[30][0]
  _tmp67_[1] = tmp_[30][1] ^ keys_[30][1]
  _tmp67_[2] = tmp_[30][2] ^ keys_[30][2]
  _tmp67_[3] = tmp_[30][3] ^ keys_[30][3]
  (_tmp68_[0],_tmp68_[1],_tmp68_[2],_tmp68_[3]) = orig_sbox_6_V32(_tmp67_[0],_tmp67_[1],_tmp67_[2],_tmp67_[3])
  (tmp_[31]) = orig_transform_V32(_tmp68_)
  _tmp69_[0] = tmp_[31][0] ^ keys_[31][0]
  _tmp69_[1] = tmp_[31][1] ^ keys_[31][1]
  _tmp69_[2] = tmp_[31][2] ^ keys_[31][2]
  _tmp69_[3] = tmp_[31][3] ^ keys_[31][3]
  (_tmp70_[0],_tmp70_[1],_tmp70_[2],_tmp70_[3]) = orig_sbox_7_V32(_tmp69_[0],_tmp69_[1],_tmp69_[2],_tmp69_[3])
  ciphertext_[0] = _tmp70_[0] ^ keys_[32][0]
  ciphertext_[1] = _tmp70_[1] ^ keys_[32][1]
  ciphertext_[2] = _tmp70_[2] ^ keys_[32][2]
  ciphertext_[3] = _tmp70_[3] ^ keys_[32][3]

  return (ciphertext_)


(orig_ciphertext_) = orig_Serpent_(plaintext_,keys_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_sbox_0_V32(a,b,c,d):


  t01 = b ^ c
  t02 = a | d
  t03 = a ^ b
  z = t02 ^ t01
  t05 = c | z
  t06 = a ^ d
  t07 = b | c
  t08 = d & t05
  t09 = t03 & t07
  y = t09 ^ t08
  t11 = t09 & y
  t12 = c ^ d
  t13 = t07 ^ t11
  t14 = b & t06
  t15 = t06 ^ t13
  w = ~ t15
  t17 = w ^ t14
  x = t12 ^ t17

  return (w,x,y,z)


def dest_sbox_1_V32(a,b,c,d):


  t01 = a | d
  t02 = c ^ d
  t03 = ~ b
  t04 = a ^ c
  t05 = a | t03
  t06 = d & t04
  t07 = t01 & t02
  t08 = b | t06
  y = t02 ^ t05
  t10 = t07 ^ t08
  t11 = t01 ^ t10
  t12 = y ^ t11
  t13 = b & d
  z = ~ t10
  x = t13 ^ t12
  t16 = t10 | x
  t17 = t05 & t16
  w = c ^ t17

  return (w,x,y,z)


def dest_sbox_2_V32(a,b,c,d):


  t01 = a | c
  t02 = a ^ b
  t03 = d ^ t01
  w = t02 ^ t03
  t05 = c ^ w
  t06 = b ^ t05
  t07 = b | t05
  t08 = t01 & t06
  t09 = t03 ^ t07
  t10 = t02 | t09
  x = t10 ^ t08
  t12 = a | d
  t13 = t09 ^ x
  t14 = b ^ t13
  z = ~ t09
  y = t12 ^ t14

  return (w,x,y,z)


def dest_sbox_3_V32(a,b,c,d):


  t01 = a ^ c
  t02 = a | d
  t03 = a & d
  t04 = t01 & t02
  t05 = b | t03
  t06 = a & b
  t07 = d ^ t04
  t08 = c | t06
  t09 = b ^ t07
  t10 = d & t05
  t11 = t02 ^ t10
  z = t08 ^ t09
  t13 = d | z
  t14 = a | t07
  t15 = b & t13
  y = t08 ^ t11
  w = t14 ^ t15
  x = t05 ^ t04

  return (w,x,y,z)


def dest_sbox_4_V32(a,b,c,d):


  t01 = a | b
  t02 = b | c
  t03 = a ^ t02
  t04 = b ^ d
  t05 = d | t03
  t06 = d & t01
  z = t03 ^ t06
  t08 = z & t04
  t09 = t04 & t05
  t10 = c ^ t06
  t11 = b & c
  t12 = t04 ^ t08
  t13 = t11 | t03
  t14 = t10 ^ t09
  t15 = a & t05
  t16 = t11 | t12
  y = t13 ^ t08
  x = t15 ^ t16
  w = ~ t14

  return (w,x,y,z)


def dest_sbox_5_V32(a,b,c,d):


  t01 = b ^ d
  t02 = b | d
  t03 = a & t01
  t04 = c ^ t02
  t05 = t03 ^ t04
  w = ~ t05
  t07 = a ^ t01
  t08 = d | w
  t09 = b | t05
  t10 = d ^ t08
  t11 = b | t07
  t12 = t03 | w
  t13 = t07 | t10
  t14 = t01 ^ t11
  y = t09 ^ t13
  x = t07 ^ t08
  z = t12 ^ t14

  return (w,x,y,z)


def dest_sbox_6_V32(a,b,c,d):


  t01 = a & d
  t02 = b ^ c
  t03 = a ^ d
  t04 = t01 ^ t02
  t05 = b | c
  x = ~ t04
  t07 = t03 & t05
  t08 = b & x
  t09 = a | c
  t10 = t07 ^ t08
  t11 = b | d
  t12 = c ^ t11
  t13 = t09 ^ t10
  y = ~ t13
  t15 = x & t03
  z = t12 ^ t07
  t17 = a ^ b
  t18 = y ^ t15
  w = t17 ^ t18

  return (w,x,y,z)


def dest_sbox_7_V32(a,b,c,d):


  t01 = a & c
  t02 = ~ d
  t03 = a & t02
  t04 = b | t01
  t05 = a & b
  t06 = c ^ t04
  z = t03 ^ t06
  t08 = c | z
  t09 = d | t05
  t10 = a ^ t08
  t11 = t04 & z
  x = t09 ^ t10
  t13 = b ^ x
  t14 = t01 ^ x
  t15 = c ^ t05
  t16 = t11 | t13
  t17 = t02 | t14
  w = t15 ^ t17
  y = a ^ t16

  return (w,x,y,z)


def dest_transform_V32(x_):
  out_ = [ None for _ in range(4)]


  _shadow_x_1_ = btor.Rol(x_[0],13)
  _shadow_x_2_ = btor.Rol(x_[2],3)
  _tmp1_ = x_[1] ^ _shadow_x_1_
  _shadow_x_3_ = _tmp1_ ^ _shadow_x_2_
  _tmp2_ = x_[3] ^ _shadow_x_2_
  _tmp3_ = _shadow_x_1_ << 3
  _shadow_x_4_ = _tmp2_ ^ _tmp3_
  _shadow_x_5_ = btor.Rol(_shadow_x_3_,1)
  _shadow_x_6_ = btor.Rol(_shadow_x_4_,7)
  _tmp4_ = _shadow_x_1_ ^ _shadow_x_5_
  _shadow_x_7_ = _tmp4_ ^ _shadow_x_6_
  _tmp5_ = _shadow_x_2_ ^ _shadow_x_6_
  _tmp6_ = _shadow_x_5_ << 7
  _shadow_x_8_ = _tmp5_ ^ _tmp6_
  _shadow_x_9_ = btor.Rol(_shadow_x_7_,5)
  _shadow_x_10_ = btor.Rol(_shadow_x_8_,22)
  out_[0] = _shadow_x_9_
  out_[1] = _shadow_x_5_
  out_[2] = _shadow_x_10_
  out_[3] = _shadow_x_6_

  return (out_)


def dest_Serpent_(plaintext_,keys_):
  ciphertext_ = [ None for _ in range(4)]

  tmp_ = [[ None for _ in range(4)] for _ in range(32)]
  _tmp70_ = [ None for _ in range(4)]
  _tmp69_ = [ None for _ in range(4)]
  _tmp68_ = [ None for _ in range(4)]
  _tmp67_ = [ None for _ in range(4)]
  _tmp66_ = [ None for _ in range(4)]
  _tmp65_ = [ None for _ in range(4)]
  _tmp64_ = [ None for _ in range(4)]
  _tmp63_ = [ None for _ in range(4)]
  _tmp62_ = [ None for _ in range(4)]
  _tmp61_ = [ None for _ in range(4)]
  _tmp60_ = [ None for _ in range(4)]
  _tmp59_ = [ None for _ in range(4)]
  _tmp58_ = [ None for _ in range(4)]
  _tmp57_ = [ None for _ in range(4)]
  _tmp56_ = [ None for _ in range(4)]
  _tmp55_ = [ None for _ in range(4)]
  _tmp54_ = [ None for _ in range(4)]
  _tmp53_ = [ None for _ in range(4)]
  _tmp52_ = [ None for _ in range(4)]
  _tmp51_ = [ None for _ in range(4)]
  _tmp50_ = [ None for _ in range(4)]
  _tmp49_ = [ None for _ in range(4)]
  _tmp48_ = [ None for _ in range(4)]
  _tmp47_ = [ None for _ in range(4)]
  _tmp46_ = [ None for _ in range(4)]
  _tmp45_ = [ None for _ in range(4)]
  _tmp44_ = [ None for _ in range(4)]
  _tmp43_ = [ None for _ in range(4)]
  _tmp42_ = [ None for _ in range(4)]
  _tmp41_ = [ None for _ in range(4)]
  _tmp40_ = [ None for _ in range(4)]
  _tmp39_ = [ None for _ in range(4)]
  _tmp38_ = [ None for _ in range(4)]
  _tmp37_ = [ None for _ in range(4)]
  _tmp36_ = [ None for _ in range(4)]
  _tmp35_ = [ None for _ in range(4)]
  _tmp34_ = [ None for _ in range(4)]
  _tmp33_ = [ None for _ in range(4)]
  _tmp32_ = [ None for _ in range(4)]
  _tmp31_ = [ None for _ in range(4)]
  _tmp30_ = [ None for _ in range(4)]
  _tmp29_ = [ None for _ in range(4)]
  _tmp28_ = [ None for _ in range(4)]
  _tmp27_ = [ None for _ in range(4)]
  _tmp26_ = [ None for _ in range(4)]
  _tmp25_ = [ None for _ in range(4)]
  _tmp24_ = [ None for _ in range(4)]
  _tmp23_ = [ None for _ in range(4)]
  _tmp22_ = [ None for _ in range(4)]
  _tmp21_ = [ None for _ in range(4)]
  _tmp20_ = [ None for _ in range(4)]
  _tmp19_ = [ None for _ in range(4)]
  _tmp18_ = [ None for _ in range(4)]
  _tmp17_ = [ None for _ in range(4)]
  _tmp16_ = [ None for _ in range(4)]
  _tmp15_ = [ None for _ in range(4)]
  _tmp14_ = [ None for _ in range(4)]
  _tmp13_ = [ None for _ in range(4)]
  _tmp12_ = [ None for _ in range(4)]
  _tmp11_ = [ None for _ in range(4)]
  _tmp10_ = [ None for _ in range(4)]
  _tmp9_ = [ None for _ in range(4)]
  _tmp8_ = [ None for _ in range(4)]
  _tmp7_ = [ None for _ in range(4)]

  _tmp7_[0] = plaintext_[0] ^ keys_[0][0]
  _tmp7_[1] = plaintext_[1] ^ keys_[0][1]
  _tmp7_[2] = plaintext_[2] ^ keys_[0][2]
  _tmp7_[3] = plaintext_[3] ^ keys_[0][3]
  (_tmp8_[0],_tmp8_[1],_tmp8_[2],_tmp8_[3]) = dest_sbox_0_V32(_tmp7_[0],_tmp7_[1],_tmp7_[2],_tmp7_[3])
  (tmp_[1]) = dest_transform_V32(_tmp8_)
  _tmp9_[0] = tmp_[1][0] ^ keys_[1][0]
  _tmp9_[1] = tmp_[1][1] ^ keys_[1][1]
  _tmp9_[2] = tmp_[1][2] ^ keys_[1][2]
  _tmp9_[3] = tmp_[1][3] ^ keys_[1][3]
  (_tmp10_[0],_tmp10_[1],_tmp10_[2],_tmp10_[3]) = dest_sbox_1_V32(_tmp9_[0],_tmp9_[1],_tmp9_[2],_tmp9_[3])
  (tmp_[2]) = dest_transform_V32(_tmp10_)
  _tmp11_[0] = tmp_[2][0] ^ keys_[2][0]
  _tmp11_[1] = tmp_[2][1] ^ keys_[2][1]
  _tmp11_[2] = tmp_[2][2] ^ keys_[2][2]
  _tmp11_[3] = tmp_[2][3] ^ keys_[2][3]
  (_tmp12_[0],_tmp12_[1],_tmp12_[2],_tmp12_[3]) = dest_sbox_2_V32(_tmp11_[0],_tmp11_[1],_tmp11_[2],_tmp11_[3])
  (tmp_[3]) = dest_transform_V32(_tmp12_)
  _tmp13_[0] = tmp_[3][0] ^ keys_[3][0]
  _tmp13_[1] = tmp_[3][1] ^ keys_[3][1]
  _tmp13_[2] = tmp_[3][2] ^ keys_[3][2]
  _tmp13_[3] = tmp_[3][3] ^ keys_[3][3]
  (_tmp14_[0],_tmp14_[1],_tmp14_[2],_tmp14_[3]) = dest_sbox_3_V32(_tmp13_[0],_tmp13_[1],_tmp13_[2],_tmp13_[3])
  (tmp_[4]) = dest_transform_V32(_tmp14_)
  _tmp15_[0] = tmp_[4][0] ^ keys_[4][0]
  _tmp15_[1] = tmp_[4][1] ^ keys_[4][1]
  _tmp15_[2] = tmp_[4][2] ^ keys_[4][2]
  _tmp15_[3] = tmp_[4][3] ^ keys_[4][3]
  (_tmp16_[0],_tmp16_[1],_tmp16_[2],_tmp16_[3]) = dest_sbox_4_V32(_tmp15_[0],_tmp15_[1],_tmp15_[2],_tmp15_[3])
  (tmp_[5]) = dest_transform_V32(_tmp16_)
  _tmp17_[0] = tmp_[5][0] ^ keys_[5][0]
  _tmp17_[1] = tmp_[5][1] ^ keys_[5][1]
  _tmp17_[2] = tmp_[5][2] ^ keys_[5][2]
  _tmp17_[3] = tmp_[5][3] ^ keys_[5][3]
  (_tmp18_[0],_tmp18_[1],_tmp18_[2],_tmp18_[3]) = dest_sbox_5_V32(_tmp17_[0],_tmp17_[1],_tmp17_[2],_tmp17_[3])
  (tmp_[6]) = dest_transform_V32(_tmp18_)
  _tmp19_[0] = tmp_[6][0] ^ keys_[6][0]
  _tmp19_[1] = tmp_[6][1] ^ keys_[6][1]
  _tmp19_[2] = tmp_[6][2] ^ keys_[6][2]
  _tmp19_[3] = tmp_[6][3] ^ keys_[6][3]
  (_tmp20_[0],_tmp20_[1],_tmp20_[2],_tmp20_[3]) = dest_sbox_6_V32(_tmp19_[0],_tmp19_[1],_tmp19_[2],_tmp19_[3])
  (tmp_[7]) = dest_transform_V32(_tmp20_)
  _tmp21_[0] = tmp_[7][0] ^ keys_[7][0]
  _tmp21_[1] = tmp_[7][1] ^ keys_[7][1]
  _tmp21_[2] = tmp_[7][2] ^ keys_[7][2]
  _tmp21_[3] = tmp_[7][3] ^ keys_[7][3]
  (_tmp22_[0],_tmp22_[1],_tmp22_[2],_tmp22_[3]) = dest_sbox_7_V32(_tmp21_[0],_tmp21_[1],_tmp21_[2],_tmp21_[3])
  (tmp_[8]) = dest_transform_V32(_tmp22_)
  _tmp23_[0] = tmp_[8][0] ^ keys_[8][0]
  _tmp23_[1] = tmp_[8][1] ^ keys_[8][1]
  _tmp23_[2] = tmp_[8][2] ^ keys_[8][2]
  _tmp23_[3] = tmp_[8][3] ^ keys_[8][3]
  (_tmp24_[0],_tmp24_[1],_tmp24_[2],_tmp24_[3]) = dest_sbox_0_V32(_tmp23_[0],_tmp23_[1],_tmp23_[2],_tmp23_[3])
  (tmp_[9]) = dest_transform_V32(_tmp24_)
  _tmp25_[0] = tmp_[9][0] ^ keys_[9][0]
  _tmp25_[1] = tmp_[9][1] ^ keys_[9][1]
  _tmp25_[2] = tmp_[9][2] ^ keys_[9][2]
  _tmp25_[3] = tmp_[9][3] ^ keys_[9][3]
  (_tmp26_[0],_tmp26_[1],_tmp26_[2],_tmp26_[3]) = dest_sbox_1_V32(_tmp25_[0],_tmp25_[1],_tmp25_[2],_tmp25_[3])
  (tmp_[10]) = dest_transform_V32(_tmp26_)
  _tmp27_[0] = tmp_[10][0] ^ keys_[10][0]
  _tmp27_[1] = tmp_[10][1] ^ keys_[10][1]
  _tmp27_[2] = tmp_[10][2] ^ keys_[10][2]
  _tmp27_[3] = tmp_[10][3] ^ keys_[10][3]
  (_tmp28_[0],_tmp28_[1],_tmp28_[2],_tmp28_[3]) = dest_sbox_2_V32(_tmp27_[0],_tmp27_[1],_tmp27_[2],_tmp27_[3])
  (tmp_[11]) = dest_transform_V32(_tmp28_)
  _tmp29_[0] = tmp_[11][0] ^ keys_[11][0]
  _tmp29_[1] = tmp_[11][1] ^ keys_[11][1]
  _tmp29_[2] = tmp_[11][2] ^ keys_[11][2]
  _tmp29_[3] = tmp_[11][3] ^ keys_[11][3]
  (_tmp30_[0],_tmp30_[1],_tmp30_[2],_tmp30_[3]) = dest_sbox_3_V32(_tmp29_[0],_tmp29_[1],_tmp29_[2],_tmp29_[3])
  (tmp_[12]) = dest_transform_V32(_tmp30_)
  _tmp31_[0] = tmp_[12][0] ^ keys_[12][0]
  _tmp31_[1] = tmp_[12][1] ^ keys_[12][1]
  _tmp31_[2] = tmp_[12][2] ^ keys_[12][2]
  _tmp31_[3] = tmp_[12][3] ^ keys_[12][3]
  (_tmp32_[0],_tmp32_[1],_tmp32_[2],_tmp32_[3]) = dest_sbox_4_V32(_tmp31_[0],_tmp31_[1],_tmp31_[2],_tmp31_[3])
  (tmp_[13]) = dest_transform_V32(_tmp32_)
  _tmp33_[0] = tmp_[13][0] ^ keys_[13][0]
  _tmp33_[1] = tmp_[13][1] ^ keys_[13][1]
  _tmp33_[2] = tmp_[13][2] ^ keys_[13][2]
  _tmp33_[3] = tmp_[13][3] ^ keys_[13][3]
  (_tmp34_[0],_tmp34_[1],_tmp34_[2],_tmp34_[3]) = dest_sbox_5_V32(_tmp33_[0],_tmp33_[1],_tmp33_[2],_tmp33_[3])
  (tmp_[14]) = dest_transform_V32(_tmp34_)
  _tmp35_[0] = tmp_[14][0] ^ keys_[14][0]
  _tmp35_[1] = tmp_[14][1] ^ keys_[14][1]
  _tmp35_[2] = tmp_[14][2] ^ keys_[14][2]
  _tmp35_[3] = tmp_[14][3] ^ keys_[14][3]
  (_tmp36_[0],_tmp36_[1],_tmp36_[2],_tmp36_[3]) = dest_sbox_6_V32(_tmp35_[0],_tmp35_[1],_tmp35_[2],_tmp35_[3])
  (tmp_[15]) = dest_transform_V32(_tmp36_)
  _tmp37_[0] = tmp_[15][0] ^ keys_[15][0]
  _tmp37_[1] = tmp_[15][1] ^ keys_[15][1]
  _tmp37_[2] = tmp_[15][2] ^ keys_[15][2]
  _tmp37_[3] = tmp_[15][3] ^ keys_[15][3]
  (_tmp38_[0],_tmp38_[1],_tmp38_[2],_tmp38_[3]) = dest_sbox_7_V32(_tmp37_[0],_tmp37_[1],_tmp37_[2],_tmp37_[3])
  (tmp_[16]) = dest_transform_V32(_tmp38_)
  _tmp39_[0] = tmp_[16][0] ^ keys_[16][0]
  _tmp39_[1] = tmp_[16][1] ^ keys_[16][1]
  _tmp39_[2] = tmp_[16][2] ^ keys_[16][2]
  _tmp39_[3] = tmp_[16][3] ^ keys_[16][3]
  (_tmp40_[0],_tmp40_[1],_tmp40_[2],_tmp40_[3]) = dest_sbox_0_V32(_tmp39_[0],_tmp39_[1],_tmp39_[2],_tmp39_[3])
  (tmp_[17]) = dest_transform_V32(_tmp40_)
  _tmp41_[0] = tmp_[17][0] ^ keys_[17][0]
  _tmp41_[1] = tmp_[17][1] ^ keys_[17][1]
  _tmp41_[2] = tmp_[17][2] ^ keys_[17][2]
  _tmp41_[3] = tmp_[17][3] ^ keys_[17][3]
  (_tmp42_[0],_tmp42_[1],_tmp42_[2],_tmp42_[3]) = dest_sbox_1_V32(_tmp41_[0],_tmp41_[1],_tmp41_[2],_tmp41_[3])
  (tmp_[18]) = dest_transform_V32(_tmp42_)
  _tmp43_[0] = tmp_[18][0] ^ keys_[18][0]
  _tmp43_[1] = tmp_[18][1] ^ keys_[18][1]
  _tmp43_[2] = tmp_[18][2] ^ keys_[18][2]
  _tmp43_[3] = tmp_[18][3] ^ keys_[18][3]
  (_tmp44_[0],_tmp44_[1],_tmp44_[2],_tmp44_[3]) = dest_sbox_2_V32(_tmp43_[0],_tmp43_[1],_tmp43_[2],_tmp43_[3])
  (tmp_[19]) = dest_transform_V32(_tmp44_)
  _tmp45_[0] = tmp_[19][0] ^ keys_[19][0]
  _tmp45_[1] = tmp_[19][1] ^ keys_[19][1]
  _tmp45_[2] = tmp_[19][2] ^ keys_[19][2]
  _tmp45_[3] = tmp_[19][3] ^ keys_[19][3]
  (_tmp46_[0],_tmp46_[1],_tmp46_[2],_tmp46_[3]) = dest_sbox_3_V32(_tmp45_[0],_tmp45_[1],_tmp45_[2],_tmp45_[3])
  (tmp_[20]) = dest_transform_V32(_tmp46_)
  _tmp47_[0] = tmp_[20][0] ^ keys_[20][0]
  _tmp47_[1] = tmp_[20][1] ^ keys_[20][1]
  _tmp47_[2] = tmp_[20][2] ^ keys_[20][2]
  _tmp47_[3] = tmp_[20][3] ^ keys_[20][3]
  (_tmp48_[0],_tmp48_[1],_tmp48_[2],_tmp48_[3]) = dest_sbox_4_V32(_tmp47_[0],_tmp47_[1],_tmp47_[2],_tmp47_[3])
  (tmp_[21]) = dest_transform_V32(_tmp48_)
  _tmp49_[0] = tmp_[21][0] ^ keys_[21][0]
  _tmp49_[1] = tmp_[21][1] ^ keys_[21][1]
  _tmp49_[2] = tmp_[21][2] ^ keys_[21][2]
  _tmp49_[3] = tmp_[21][3] ^ keys_[21][3]
  (_tmp50_[0],_tmp50_[1],_tmp50_[2],_tmp50_[3]) = dest_sbox_5_V32(_tmp49_[0],_tmp49_[1],_tmp49_[2],_tmp49_[3])
  (tmp_[22]) = dest_transform_V32(_tmp50_)
  _tmp51_[0] = tmp_[22][0] ^ keys_[22][0]
  _tmp51_[1] = tmp_[22][1] ^ keys_[22][1]
  _tmp51_[2] = tmp_[22][2] ^ keys_[22][2]
  _tmp51_[3] = tmp_[22][3] ^ keys_[22][3]
  (_tmp52_[0],_tmp52_[1],_tmp52_[2],_tmp52_[3]) = dest_sbox_6_V32(_tmp51_[0],_tmp51_[1],_tmp51_[2],_tmp51_[3])
  (tmp_[23]) = dest_transform_V32(_tmp52_)
  _tmp53_[0] = tmp_[23][0] ^ keys_[23][0]
  _tmp53_[1] = tmp_[23][1] ^ keys_[23][1]
  _tmp53_[2] = tmp_[23][2] ^ keys_[23][2]
  _tmp53_[3] = tmp_[23][3] ^ keys_[23][3]
  (_tmp54_[0],_tmp54_[1],_tmp54_[2],_tmp54_[3]) = dest_sbox_7_V32(_tmp53_[0],_tmp53_[1],_tmp53_[2],_tmp53_[3])
  (tmp_[24]) = dest_transform_V32(_tmp54_)
  _tmp55_[0] = tmp_[24][0] ^ keys_[24][0]
  _tmp55_[1] = tmp_[24][1] ^ keys_[24][1]
  _tmp55_[2] = tmp_[24][2] ^ keys_[24][2]
  _tmp55_[3] = tmp_[24][3] ^ keys_[24][3]
  (_tmp56_[0],_tmp56_[1],_tmp56_[2],_tmp56_[3]) = dest_sbox_0_V32(_tmp55_[0],_tmp55_[1],_tmp55_[2],_tmp55_[3])
  (tmp_[25]) = dest_transform_V32(_tmp56_)
  _tmp57_[0] = tmp_[25][0] ^ keys_[25][0]
  _tmp57_[1] = tmp_[25][1] ^ keys_[25][1]
  _tmp57_[2] = tmp_[25][2] ^ keys_[25][2]
  _tmp57_[3] = tmp_[25][3] ^ keys_[25][3]
  (_tmp58_[0],_tmp58_[1],_tmp58_[2],_tmp58_[3]) = dest_sbox_1_V32(_tmp57_[0],_tmp57_[1],_tmp57_[2],_tmp57_[3])
  (tmp_[26]) = dest_transform_V32(_tmp58_)
  _tmp59_[0] = tmp_[26][0] ^ keys_[26][0]
  _tmp59_[1] = tmp_[26][1] ^ keys_[26][1]
  _tmp59_[2] = tmp_[26][2] ^ keys_[26][2]
  _tmp59_[3] = tmp_[26][3] ^ keys_[26][3]
  (_tmp60_[0],_tmp60_[1],_tmp60_[2],_tmp60_[3]) = dest_sbox_2_V32(_tmp59_[0],_tmp59_[1],_tmp59_[2],_tmp59_[3])
  (tmp_[27]) = dest_transform_V32(_tmp60_)
  _tmp61_[0] = tmp_[27][0] ^ keys_[27][0]
  _tmp61_[1] = tmp_[27][1] ^ keys_[27][1]
  _tmp61_[2] = tmp_[27][2] ^ keys_[27][2]
  _tmp61_[3] = tmp_[27][3] ^ keys_[27][3]
  (_tmp62_[0],_tmp62_[1],_tmp62_[2],_tmp62_[3]) = dest_sbox_3_V32(_tmp61_[0],_tmp61_[1],_tmp61_[2],_tmp61_[3])
  (tmp_[28]) = dest_transform_V32(_tmp62_)
  _tmp63_[0] = tmp_[28][0] ^ keys_[28][0]
  _tmp63_[1] = tmp_[28][1] ^ keys_[28][1]
  _tmp63_[2] = tmp_[28][2] ^ keys_[28][2]
  _tmp63_[3] = tmp_[28][3] ^ keys_[28][3]
  (_tmp64_[0],_tmp64_[1],_tmp64_[2],_tmp64_[3]) = dest_sbox_4_V32(_tmp63_[0],_tmp63_[1],_tmp63_[2],_tmp63_[3])
  (tmp_[29]) = dest_transform_V32(_tmp64_)
  _tmp65_[0] = tmp_[29][0] ^ keys_[29][0]
  _tmp65_[1] = tmp_[29][1] ^ keys_[29][1]
  _tmp65_[2] = tmp_[29][2] ^ keys_[29][2]
  _tmp65_[3] = tmp_[29][3] ^ keys_[29][3]
  (_tmp66_[0],_tmp66_[1],_tmp66_[2],_tmp66_[3]) = dest_sbox_5_V32(_tmp65_[0],_tmp65_[1],_tmp65_[2],_tmp65_[3])
  (tmp_[30]) = dest_transform_V32(_tmp66_)
  _tmp67_[0] = tmp_[30][0] ^ keys_[30][0]
  _tmp67_[1] = tmp_[30][1] ^ keys_[30][1]
  _tmp67_[2] = tmp_[30][2] ^ keys_[30][2]
  _tmp67_[3] = tmp_[30][3] ^ keys_[30][3]
  (_tmp68_[0],_tmp68_[1],_tmp68_[2],_tmp68_[3]) = dest_sbox_6_V32(_tmp67_[0],_tmp67_[1],_tmp67_[2],_tmp67_[3])
  (tmp_[31]) = dest_transform_V32(_tmp68_)
  _tmp69_[0] = tmp_[31][0] ^ keys_[31][0]
  _tmp69_[1] = tmp_[31][1] ^ keys_[31][1]
  _tmp69_[2] = tmp_[31][2] ^ keys_[31][2]
  _tmp69_[3] = tmp_[31][3] ^ keys_[31][3]
  (_tmp70_[0],_tmp70_[1],_tmp70_[2],_tmp70_[3]) = dest_sbox_7_V32(_tmp69_[0],_tmp69_[1],_tmp69_[2],_tmp69_[3])
  ciphertext_[0] = _tmp70_[0] ^ keys_[32][0]
  ciphertext_[1] = _tmp70_[1] ^ keys_[32][1]
  ciphertext_[2] = _tmp70_[2] ^ keys_[32][2]
  ciphertext_[3] = _tmp70_[3] ^ keys_[32][3]

  return (ciphertext_)


(dest_ciphertext_) = dest_Serpent_(plaintext_,keys_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################

ortmp0 = orig_ciphertext_[0] != dest_ciphertext_[0]
ortmp1 = btor.Or(orig_ciphertext_[1] != dest_ciphertext_[1], ortmp0)
ortmp2 = btor.Or(orig_ciphertext_[2] != dest_ciphertext_[2], ortmp1)
ortmp3 = btor.Or(orig_ciphertext_[3] != dest_ciphertext_[3], ortmp2)
btor.Assert(ortmp3)


start = timer()
res = btor.Sat()
end = timer()
print("Running time: " + str(end - start))
if res == btor.SAT:
  print('SAT')
  #btor.Print_model()
else:
  print('UNSAT')
