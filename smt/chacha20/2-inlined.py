
from z3 import *

######################################################################
#                          Original program                          #
######################################################################

def orig_QR_start_V32(a_,b_,c_,d_):


  aR_ = a_ + b_
  _tmp1_ = d_ ^ aR_
  dR_ = RotateLeft(_tmp1_,16)
  cR_ = c_ + dR_
  _tmp2_ = b_ ^ cR_
  bR_ = RotateLeft(_tmp2_,12)

  return (aR_,bR_,cR_,dR_)


def orig_QR_end_V32(a_,b_,c_,d_):


  aR_ = a_ + b_
  _tmp3_ = d_ ^ aR_
  dR_ = RotateLeft(_tmp3_,8)
  cR_ = c_ + dR_
  _tmp4_ = b_ ^ cR_
  bR_ = RotateLeft(_tmp4_,7)

  return (aR_,bR_,cR_,dR_)


def orig_QR_V32(input_0_,input_1_,input_2_,input_3_):

  _tmp5_ = [ None for _ in range(4)]

  (_tmp5_[0],_tmp5_[1],_tmp5_[2],_tmp5_[3]) = orig_QR_start_V32(input_0_,input_1_,input_2_,input_3_)
  (output_0_,output_1_,output_2_,output_3_) = orig_QR_end_V32(_tmp5_[0],_tmp5_[1],_tmp5_[2],_tmp5_[3])

  return (output_0_,output_1_,output_2_,output_3_)


def orig_DR_start_V32(state_):
  stateR_ = [ None for _ in range(16)]


  (stateR_[0],stateR_[4],stateR_[8],stateR_[12]) = orig_QR_V32(state_[0],state_[4],state_[8],state_[12])
  (stateR_[1],stateR_[5],stateR_[9],stateR_[13]) = orig_QR_V32(state_[1],state_[5],state_[9],state_[13])
  (stateR_[2],stateR_[6],stateR_[10],stateR_[14]) = orig_QR_V32(state_[2],state_[6],state_[10],state_[14])
  (stateR_[3],stateR_[7],stateR_[11],stateR_[15]) = orig_QR_V32(state_[3],state_[7],state_[11],state_[15])

  return (stateR_)


def orig_DR_end_V32(state_):
  stateR_ = [ None for _ in range(16)]


  (stateR_[0],stateR_[5],stateR_[10],stateR_[15]) = orig_QR_V32(state_[0],state_[5],state_[10],state_[15])
  (stateR_[1],stateR_[6],stateR_[11],stateR_[12]) = orig_QR_V32(state_[1],state_[6],state_[11],state_[12])
  (stateR_[2],stateR_[7],stateR_[8],stateR_[13]) = orig_QR_V32(state_[2],state_[7],state_[8],state_[13])
  (stateR_[3],stateR_[4],stateR_[9],stateR_[14]) = orig_QR_V32(state_[3],state_[4],state_[9],state_[14])

  return (stateR_)


def orig_DR_V32(state_):
  stateR_ = [ None for _ in range(16)]

  _tmp6_ = [ None for _ in range(16)]

  (_tmp6_) = orig_DR_start_V32(state_)
  (stateR_) = orig_DR_end_V32(_tmp6_)

  return (stateR_)


def orig_Chacha20_(plain_):
  cipher_ = [ None for _ in range(16)]

  state_ = [[ None for _ in range(16)] for _ in range(11)]

  state_[0][0] = plain_[0]
  state_[0][1] = plain_[1]
  state_[0][2] = plain_[2]
  state_[0][3] = plain_[3]
  state_[0][4] = plain_[4]
  state_[0][5] = plain_[5]
  state_[0][6] = plain_[6]
  state_[0][7] = plain_[7]
  state_[0][8] = plain_[8]
  state_[0][9] = plain_[9]
  state_[0][10] = plain_[10]
  state_[0][11] = plain_[11]
  state_[0][12] = plain_[12]
  state_[0][13] = plain_[13]
  state_[0][14] = plain_[14]
  state_[0][15] = plain_[15]
  for i_ in range(1,10+1):
    (state_[i_]) = orig_DR_V32(state_[(i_ - 1)])
  cipher_[0] = state_[10][0]
  cipher_[1] = state_[10][1]
  cipher_[2] = state_[10][2]
  cipher_[3] = state_[10][3]
  cipher_[4] = state_[10][4]
  cipher_[5] = state_[10][5]
  cipher_[6] = state_[10][6]
  cipher_[7] = state_[10][7]
  cipher_[8] = state_[10][8]
  cipher_[9] = state_[10][9]
  cipher_[10] = state_[10][10]
  cipher_[11] = state_[10][11]
  cipher_[12] = state_[10][12]
  cipher_[13] = state_[10][13]
  cipher_[14] = state_[10][14]
  cipher_[15] = state_[10][15]

  return (cipher_)


orig_plain_ = [ BitVec('plain_[%d]' % (c0), 32) for c0 in range(16)]


(orig_cipher_) = orig_Chacha20_(orig_plain_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_DR_V32(state_):
  stateR_ = [ None for _ in range(16)]

  _tmp6_ = [ None for _ in range(16)]
  DR_start_V32_1_QR_V32_1__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_2__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_3__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_4__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_1__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_2__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_3__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_4__tmp5_ = [ None for _ in range(4)]

  DR_start_V32_1_QR_V32_1__tmp5_[0] = state_[0] + state_[4]
  DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp1_ = state_[12] ^ DR_start_V32_1_QR_V32_1__tmp5_[0]
  DR_start_V32_1_QR_V32_1__tmp5_[3] = RotateLeft(DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_1__tmp5_[2] = state_[8] + DR_start_V32_1_QR_V32_1__tmp5_[3]
  DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp2_ = state_[4] ^ DR_start_V32_1_QR_V32_1__tmp5_[2]
  DR_start_V32_1_QR_V32_1__tmp5_[1] = RotateLeft(DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp2_,12)
  _tmp6_[0] = DR_start_V32_1_QR_V32_1__tmp5_[0] + DR_start_V32_1_QR_V32_1__tmp5_[1]
  DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_1__tmp5_[3] ^ _tmp6_[0]
  _tmp6_[12] = RotateLeft(DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp3_,8)
  _tmp6_[8] = DR_start_V32_1_QR_V32_1__tmp5_[2] + _tmp6_[12]
  DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_1__tmp5_[1] ^ _tmp6_[8]
  _tmp6_[4] = RotateLeft(DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp4_,7)
  DR_start_V32_1_QR_V32_2__tmp5_[0] = state_[1] + state_[5]
  DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp1_ = state_[13] ^ DR_start_V32_1_QR_V32_2__tmp5_[0]
  DR_start_V32_1_QR_V32_2__tmp5_[3] = RotateLeft(DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_2__tmp5_[2] = state_[9] + DR_start_V32_1_QR_V32_2__tmp5_[3]
  DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp2_ = state_[5] ^ DR_start_V32_1_QR_V32_2__tmp5_[2]
  DR_start_V32_1_QR_V32_2__tmp5_[1] = RotateLeft(DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp2_,12)
  _tmp6_[1] = DR_start_V32_1_QR_V32_2__tmp5_[0] + DR_start_V32_1_QR_V32_2__tmp5_[1]
  DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_2__tmp5_[3] ^ _tmp6_[1]
  _tmp6_[13] = RotateLeft(DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp3_,8)
  _tmp6_[9] = DR_start_V32_1_QR_V32_2__tmp5_[2] + _tmp6_[13]
  DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_2__tmp5_[1] ^ _tmp6_[9]
  _tmp6_[5] = RotateLeft(DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp4_,7)
  DR_start_V32_1_QR_V32_3__tmp5_[0] = state_[2] + state_[6]
  DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp1_ = state_[14] ^ DR_start_V32_1_QR_V32_3__tmp5_[0]
  DR_start_V32_1_QR_V32_3__tmp5_[3] = RotateLeft(DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_3__tmp5_[2] = state_[10] + DR_start_V32_1_QR_V32_3__tmp5_[3]
  DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp2_ = state_[6] ^ DR_start_V32_1_QR_V32_3__tmp5_[2]
  DR_start_V32_1_QR_V32_3__tmp5_[1] = RotateLeft(DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp2_,12)
  _tmp6_[2] = DR_start_V32_1_QR_V32_3__tmp5_[0] + DR_start_V32_1_QR_V32_3__tmp5_[1]
  DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_3__tmp5_[3] ^ _tmp6_[2]
  _tmp6_[14] = RotateLeft(DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp3_,8)
  _tmp6_[10] = DR_start_V32_1_QR_V32_3__tmp5_[2] + _tmp6_[14]
  DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_3__tmp5_[1] ^ _tmp6_[10]
  _tmp6_[6] = RotateLeft(DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp4_,7)
  DR_start_V32_1_QR_V32_4__tmp5_[0] = state_[3] + state_[7]
  DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp1_ = state_[15] ^ DR_start_V32_1_QR_V32_4__tmp5_[0]
  DR_start_V32_1_QR_V32_4__tmp5_[3] = RotateLeft(DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_4__tmp5_[2] = state_[11] + DR_start_V32_1_QR_V32_4__tmp5_[3]
  DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp2_ = state_[7] ^ DR_start_V32_1_QR_V32_4__tmp5_[2]
  DR_start_V32_1_QR_V32_4__tmp5_[1] = RotateLeft(DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp2_,12)
  _tmp6_[3] = DR_start_V32_1_QR_V32_4__tmp5_[0] + DR_start_V32_1_QR_V32_4__tmp5_[1]
  DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_4__tmp5_[3] ^ _tmp6_[3]
  _tmp6_[15] = RotateLeft(DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp3_,8)
  _tmp6_[11] = DR_start_V32_1_QR_V32_4__tmp5_[2] + _tmp6_[15]
  DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_4__tmp5_[1] ^ _tmp6_[11]
  _tmp6_[7] = RotateLeft(DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_1__tmp5_[0] = _tmp6_[0] + _tmp6_[5]
  DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp1_ = _tmp6_[15] ^ DR_end_V32_1_QR_V32_1__tmp5_[0]
  DR_end_V32_1_QR_V32_1__tmp5_[3] = RotateLeft(DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_1__tmp5_[2] = _tmp6_[10] + DR_end_V32_1_QR_V32_1__tmp5_[3]
  DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp2_ = _tmp6_[5] ^ DR_end_V32_1_QR_V32_1__tmp5_[2]
  DR_end_V32_1_QR_V32_1__tmp5_[1] = RotateLeft(DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp2_,12)
  stateR_[0] = DR_end_V32_1_QR_V32_1__tmp5_[0] + DR_end_V32_1_QR_V32_1__tmp5_[1]
  DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_1__tmp5_[3] ^ stateR_[0]
  stateR_[15] = RotateLeft(DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp3_,8)
  stateR_[10] = DR_end_V32_1_QR_V32_1__tmp5_[2] + stateR_[15]
  DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_1__tmp5_[1] ^ stateR_[10]
  stateR_[5] = RotateLeft(DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_2__tmp5_[0] = _tmp6_[1] + _tmp6_[6]
  DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp1_ = _tmp6_[12] ^ DR_end_V32_1_QR_V32_2__tmp5_[0]
  DR_end_V32_1_QR_V32_2__tmp5_[3] = RotateLeft(DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_2__tmp5_[2] = _tmp6_[11] + DR_end_V32_1_QR_V32_2__tmp5_[3]
  DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp2_ = _tmp6_[6] ^ DR_end_V32_1_QR_V32_2__tmp5_[2]
  DR_end_V32_1_QR_V32_2__tmp5_[1] = RotateLeft(DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp2_,12)
  stateR_[1] = DR_end_V32_1_QR_V32_2__tmp5_[0] + DR_end_V32_1_QR_V32_2__tmp5_[1]
  DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_2__tmp5_[3] ^ stateR_[1]
  stateR_[12] = RotateLeft(DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp3_,8)
  stateR_[11] = DR_end_V32_1_QR_V32_2__tmp5_[2] + stateR_[12]
  DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_2__tmp5_[1] ^ stateR_[11]
  stateR_[6] = RotateLeft(DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_3__tmp5_[0] = _tmp6_[2] + _tmp6_[7]
  DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp1_ = _tmp6_[13] ^ DR_end_V32_1_QR_V32_3__tmp5_[0]
  DR_end_V32_1_QR_V32_3__tmp5_[3] = RotateLeft(DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_3__tmp5_[2] = _tmp6_[8] + DR_end_V32_1_QR_V32_3__tmp5_[3]
  DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp2_ = _tmp6_[7] ^ DR_end_V32_1_QR_V32_3__tmp5_[2]
  DR_end_V32_1_QR_V32_3__tmp5_[1] = RotateLeft(DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp2_,12)
  stateR_[2] = DR_end_V32_1_QR_V32_3__tmp5_[0] + DR_end_V32_1_QR_V32_3__tmp5_[1]
  DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_3__tmp5_[3] ^ stateR_[2]
  stateR_[13] = RotateLeft(DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp3_,8)
  stateR_[8] = DR_end_V32_1_QR_V32_3__tmp5_[2] + stateR_[13]
  DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_3__tmp5_[1] ^ stateR_[8]
  stateR_[7] = RotateLeft(DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_4__tmp5_[0] = _tmp6_[3] + _tmp6_[4]
  DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp1_ = _tmp6_[14] ^ DR_end_V32_1_QR_V32_4__tmp5_[0]
  DR_end_V32_1_QR_V32_4__tmp5_[3] = RotateLeft(DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_4__tmp5_[2] = _tmp6_[9] + DR_end_V32_1_QR_V32_4__tmp5_[3]
  DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp2_ = _tmp6_[4] ^ DR_end_V32_1_QR_V32_4__tmp5_[2]
  DR_end_V32_1_QR_V32_4__tmp5_[1] = RotateLeft(DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp2_,12)
  stateR_[3] = DR_end_V32_1_QR_V32_4__tmp5_[0] + DR_end_V32_1_QR_V32_4__tmp5_[1]
  DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_4__tmp5_[3] ^ stateR_[3]
  stateR_[14] = RotateLeft(DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp3_,8)
  stateR_[9] = DR_end_V32_1_QR_V32_4__tmp5_[2] + stateR_[14]
  DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_4__tmp5_[1] ^ stateR_[9]
  stateR_[4] = RotateLeft(DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp4_,7)

  return (stateR_)


def dest_Chacha20_(plain_):
  cipher_ = [ None for _ in range(16)]

  state_ = [[ None for _ in range(16)] for _ in range(11)]

  state_[0][0] = plain_[0]
  state_[0][1] = plain_[1]
  state_[0][2] = plain_[2]
  state_[0][3] = plain_[3]
  state_[0][4] = plain_[4]
  state_[0][5] = plain_[5]
  state_[0][6] = plain_[6]
  state_[0][7] = plain_[7]
  state_[0][8] = plain_[8]
  state_[0][9] = plain_[9]
  state_[0][10] = plain_[10]
  state_[0][11] = plain_[11]
  state_[0][12] = plain_[12]
  state_[0][13] = plain_[13]
  state_[0][14] = plain_[14]
  state_[0][15] = plain_[15]
  for i_ in range(1,10+1):
    (state_[i_]) = dest_DR_V32(state_[(i_ - 1)])
  cipher_[0] = state_[10][0]
  cipher_[1] = state_[10][1]
  cipher_[2] = state_[10][2]
  cipher_[3] = state_[10][3]
  cipher_[4] = state_[10][4]
  cipher_[5] = state_[10][5]
  cipher_[6] = state_[10][6]
  cipher_[7] = state_[10][7]
  cipher_[8] = state_[10][8]
  cipher_[9] = state_[10][9]
  cipher_[10] = state_[10][10]
  cipher_[11] = state_[10][11]
  cipher_[12] = state_[10][12]
  cipher_[13] = state_[10][13]
  cipher_[14] = state_[10][14]
  cipher_[15] = state_[10][15]

  return (cipher_)


dest_plain_ = [ BitVec('plain_[%d]' % (c0), 32) for c0 in range(16)]


(dest_cipher_) = dest_Chacha20_(dest_plain_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################
s = Solver()
s.add(Or(orig_cipher_[0] != dest_cipher_[0], orig_cipher_[1] != dest_cipher_[1], orig_cipher_[2] != dest_cipher_[2], orig_cipher_[3] != dest_cipher_[3], orig_cipher_[4] != dest_cipher_[4], orig_cipher_[5] != dest_cipher_[5], orig_cipher_[6] != dest_cipher_[6], orig_cipher_[7] != dest_cipher_[7], orig_cipher_[8] != dest_cipher_[8], orig_cipher_[9] != dest_cipher_[9], orig_cipher_[10] != dest_cipher_[10], orig_cipher_[11] != dest_cipher_[11], orig_cipher_[12] != dest_cipher_[12], orig_cipher_[13] != dest_cipher_[13], orig_cipher_[14] != dest_cipher_[14], orig_cipher_[15] != dest_cipher_[15]))
print(s.check())
