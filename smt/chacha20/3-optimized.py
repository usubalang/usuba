
from pyboolector import *
from timeit import default_timer as timer

btor = Boolector()

# Inputs
plain_ = [ btor.Var(btor.BitVecSort(32), 'plain_[%d]' % (c0)) for c0 in range(16)]


######################################################################
#                          Original program                          #
######################################################################

def orig_DR_V32(state_):
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
  DR_start_V32_1_QR_V32_1__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_1__tmp5_[2] = state_[8] + DR_start_V32_1_QR_V32_1__tmp5_[3]
  DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp2_ = state_[4] ^ DR_start_V32_1_QR_V32_1__tmp5_[2]
  DR_start_V32_1_QR_V32_1__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp2_,12)
  _tmp6_[0] = DR_start_V32_1_QR_V32_1__tmp5_[0] + DR_start_V32_1_QR_V32_1__tmp5_[1]
  DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_1__tmp5_[3] ^ _tmp6_[0]
  _tmp6_[12] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp3_,8)
  _tmp6_[8] = DR_start_V32_1_QR_V32_1__tmp5_[2] + _tmp6_[12]
  DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_1__tmp5_[1] ^ _tmp6_[8]
  _tmp6_[4] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp4_,7)
  DR_start_V32_1_QR_V32_2__tmp5_[0] = state_[1] + state_[5]
  DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp1_ = state_[13] ^ DR_start_V32_1_QR_V32_2__tmp5_[0]
  DR_start_V32_1_QR_V32_2__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_2__tmp5_[2] = state_[9] + DR_start_V32_1_QR_V32_2__tmp5_[3]
  DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp2_ = state_[5] ^ DR_start_V32_1_QR_V32_2__tmp5_[2]
  DR_start_V32_1_QR_V32_2__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp2_,12)
  _tmp6_[1] = DR_start_V32_1_QR_V32_2__tmp5_[0] + DR_start_V32_1_QR_V32_2__tmp5_[1]
  DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_2__tmp5_[3] ^ _tmp6_[1]
  _tmp6_[13] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp3_,8)
  _tmp6_[9] = DR_start_V32_1_QR_V32_2__tmp5_[2] + _tmp6_[13]
  DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_2__tmp5_[1] ^ _tmp6_[9]
  _tmp6_[5] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp4_,7)
  DR_start_V32_1_QR_V32_3__tmp5_[0] = state_[2] + state_[6]
  DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp1_ = state_[14] ^ DR_start_V32_1_QR_V32_3__tmp5_[0]
  DR_start_V32_1_QR_V32_3__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_3__tmp5_[2] = state_[10] + DR_start_V32_1_QR_V32_3__tmp5_[3]
  DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp2_ = state_[6] ^ DR_start_V32_1_QR_V32_3__tmp5_[2]
  DR_start_V32_1_QR_V32_3__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp2_,12)
  _tmp6_[2] = DR_start_V32_1_QR_V32_3__tmp5_[0] + DR_start_V32_1_QR_V32_3__tmp5_[1]
  DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_3__tmp5_[3] ^ _tmp6_[2]
  _tmp6_[14] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp3_,8)
  _tmp6_[10] = DR_start_V32_1_QR_V32_3__tmp5_[2] + _tmp6_[14]
  DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_3__tmp5_[1] ^ _tmp6_[10]
  _tmp6_[6] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp4_,7)
  DR_start_V32_1_QR_V32_4__tmp5_[0] = state_[3] + state_[7]
  DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp1_ = state_[15] ^ DR_start_V32_1_QR_V32_4__tmp5_[0]
  DR_start_V32_1_QR_V32_4__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_4__tmp5_[2] = state_[11] + DR_start_V32_1_QR_V32_4__tmp5_[3]
  DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp2_ = state_[7] ^ DR_start_V32_1_QR_V32_4__tmp5_[2]
  DR_start_V32_1_QR_V32_4__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp2_,12)
  _tmp6_[3] = DR_start_V32_1_QR_V32_4__tmp5_[0] + DR_start_V32_1_QR_V32_4__tmp5_[1]
  DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_4__tmp5_[3] ^ _tmp6_[3]
  _tmp6_[15] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp3_,8)
  _tmp6_[11] = DR_start_V32_1_QR_V32_4__tmp5_[2] + _tmp6_[15]
  DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_4__tmp5_[1] ^ _tmp6_[11]
  _tmp6_[7] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_1__tmp5_[0] = _tmp6_[0] + _tmp6_[5]
  DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp1_ = _tmp6_[15] ^ DR_end_V32_1_QR_V32_1__tmp5_[0]
  DR_end_V32_1_QR_V32_1__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_1__tmp5_[2] = _tmp6_[10] + DR_end_V32_1_QR_V32_1__tmp5_[3]
  DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp2_ = _tmp6_[5] ^ DR_end_V32_1_QR_V32_1__tmp5_[2]
  DR_end_V32_1_QR_V32_1__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp2_,12)
  stateR_[0] = DR_end_V32_1_QR_V32_1__tmp5_[0] + DR_end_V32_1_QR_V32_1__tmp5_[1]
  DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_1__tmp5_[3] ^ stateR_[0]
  stateR_[15] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp3_,8)
  stateR_[10] = DR_end_V32_1_QR_V32_1__tmp5_[2] + stateR_[15]
  DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_1__tmp5_[1] ^ stateR_[10]
  stateR_[5] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_2__tmp5_[0] = _tmp6_[1] + _tmp6_[6]
  DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp1_ = _tmp6_[12] ^ DR_end_V32_1_QR_V32_2__tmp5_[0]
  DR_end_V32_1_QR_V32_2__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_2__tmp5_[2] = _tmp6_[11] + DR_end_V32_1_QR_V32_2__tmp5_[3]
  DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp2_ = _tmp6_[6] ^ DR_end_V32_1_QR_V32_2__tmp5_[2]
  DR_end_V32_1_QR_V32_2__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp2_,12)
  stateR_[1] = DR_end_V32_1_QR_V32_2__tmp5_[0] + DR_end_V32_1_QR_V32_2__tmp5_[1]
  DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_2__tmp5_[3] ^ stateR_[1]
  stateR_[12] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp3_,8)
  stateR_[11] = DR_end_V32_1_QR_V32_2__tmp5_[2] + stateR_[12]
  DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_2__tmp5_[1] ^ stateR_[11]
  stateR_[6] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_3__tmp5_[0] = _tmp6_[2] + _tmp6_[7]
  DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp1_ = _tmp6_[13] ^ DR_end_V32_1_QR_V32_3__tmp5_[0]
  DR_end_V32_1_QR_V32_3__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_3__tmp5_[2] = _tmp6_[8] + DR_end_V32_1_QR_V32_3__tmp5_[3]
  DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp2_ = _tmp6_[7] ^ DR_end_V32_1_QR_V32_3__tmp5_[2]
  DR_end_V32_1_QR_V32_3__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp2_,12)
  stateR_[2] = DR_end_V32_1_QR_V32_3__tmp5_[0] + DR_end_V32_1_QR_V32_3__tmp5_[1]
  DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_3__tmp5_[3] ^ stateR_[2]
  stateR_[13] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp3_,8)
  stateR_[8] = DR_end_V32_1_QR_V32_3__tmp5_[2] + stateR_[13]
  DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_3__tmp5_[1] ^ stateR_[8]
  stateR_[7] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_4__tmp5_[0] = _tmp6_[3] + _tmp6_[4]
  DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp1_ = _tmp6_[14] ^ DR_end_V32_1_QR_V32_4__tmp5_[0]
  DR_end_V32_1_QR_V32_4__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_4__tmp5_[2] = _tmp6_[9] + DR_end_V32_1_QR_V32_4__tmp5_[3]
  DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp2_ = _tmp6_[4] ^ DR_end_V32_1_QR_V32_4__tmp5_[2]
  DR_end_V32_1_QR_V32_4__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp2_,12)
  stateR_[3] = DR_end_V32_1_QR_V32_4__tmp5_[0] + DR_end_V32_1_QR_V32_4__tmp5_[1]
  DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_4__tmp5_[3] ^ stateR_[3]
  stateR_[14] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp3_,8)
  stateR_[9] = DR_end_V32_1_QR_V32_4__tmp5_[2] + stateR_[14]
  DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_4__tmp5_[1] ^ stateR_[9]
  stateR_[4] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp4_,7)

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


(orig_cipher_) = orig_Chacha20_(plain_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_DR_V32(state_):
  stateR_ = [ None for _ in range(16)]

  DR_end_V32_1_QR_V32_1__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_2__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_3__tmp5_ = [ None for _ in range(4)]
  DR_end_V32_1_QR_V32_4__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_1__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_2__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_3__tmp5_ = [ None for _ in range(4)]
  DR_start_V32_1_QR_V32_4__tmp5_ = [ None for _ in range(4)]
  _tmp6_ = [ None for _ in range(16)]

  DR_start_V32_1_QR_V32_1__tmp5_[0] = state_[0] + state_[4]
  DR_start_V32_1_QR_V32_2__tmp5_[0] = state_[1] + state_[5]
  DR_start_V32_1_QR_V32_3__tmp5_[0] = state_[2] + state_[6]
  DR_start_V32_1_QR_V32_4__tmp5_[0] = state_[3] + state_[7]
  DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp1_ = state_[12] ^ DR_start_V32_1_QR_V32_1__tmp5_[0]
  DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp1_ = state_[13] ^ DR_start_V32_1_QR_V32_2__tmp5_[0]
  DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp1_ = state_[14] ^ DR_start_V32_1_QR_V32_3__tmp5_[0]
  DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp1_ = state_[15] ^ DR_start_V32_1_QR_V32_4__tmp5_[0]
  DR_start_V32_1_QR_V32_1__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_2__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_3__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_4__tmp5_[3] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp1_,16)
  DR_start_V32_1_QR_V32_1__tmp5_[2] = state_[8] + DR_start_V32_1_QR_V32_1__tmp5_[3]
  DR_start_V32_1_QR_V32_2__tmp5_[2] = state_[9] + DR_start_V32_1_QR_V32_2__tmp5_[3]
  DR_start_V32_1_QR_V32_3__tmp5_[2] = state_[10] + DR_start_V32_1_QR_V32_3__tmp5_[3]
  DR_start_V32_1_QR_V32_4__tmp5_[2] = state_[11] + DR_start_V32_1_QR_V32_4__tmp5_[3]
  DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp2_ = state_[4] ^ DR_start_V32_1_QR_V32_1__tmp5_[2]
  DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp2_ = state_[5] ^ DR_start_V32_1_QR_V32_2__tmp5_[2]
  DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp2_ = state_[6] ^ DR_start_V32_1_QR_V32_3__tmp5_[2]
  DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp2_ = state_[7] ^ DR_start_V32_1_QR_V32_4__tmp5_[2]
  DR_start_V32_1_QR_V32_1__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_start_V32_1__tmp2_,12)
  DR_start_V32_1_QR_V32_2__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_start_V32_1__tmp2_,12)
  DR_start_V32_1_QR_V32_3__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_start_V32_1__tmp2_,12)
  DR_start_V32_1_QR_V32_4__tmp5_[1] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_start_V32_1__tmp2_,12)
  _tmp6_[0] = DR_start_V32_1_QR_V32_1__tmp5_[0] + DR_start_V32_1_QR_V32_1__tmp5_[1]
  _tmp6_[1] = DR_start_V32_1_QR_V32_2__tmp5_[0] + DR_start_V32_1_QR_V32_2__tmp5_[1]
  _tmp6_[2] = DR_start_V32_1_QR_V32_3__tmp5_[0] + DR_start_V32_1_QR_V32_3__tmp5_[1]
  _tmp6_[3] = DR_start_V32_1_QR_V32_4__tmp5_[0] + DR_start_V32_1_QR_V32_4__tmp5_[1]
  DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_1__tmp5_[3] ^ _tmp6_[0]
  DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_2__tmp5_[3] ^ _tmp6_[1]
  DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_3__tmp5_[3] ^ _tmp6_[2]
  DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp3_ = DR_start_V32_1_QR_V32_4__tmp5_[3] ^ _tmp6_[3]
  _tmp6_[12] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp3_,8)
  _tmp6_[13] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp3_,8)
  _tmp6_[14] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp3_,8)
  _tmp6_[15] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp3_,8)
  _tmp6_[8] = DR_start_V32_1_QR_V32_1__tmp5_[2] + _tmp6_[12]
  _tmp6_[9] = DR_start_V32_1_QR_V32_2__tmp5_[2] + _tmp6_[13]
  _tmp6_[10] = DR_start_V32_1_QR_V32_3__tmp5_[2] + _tmp6_[14]
  _tmp6_[11] = DR_start_V32_1_QR_V32_4__tmp5_[2] + _tmp6_[15]
  DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_1__tmp5_[1] ^ _tmp6_[8]
  DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_2__tmp5_[1] ^ _tmp6_[9]
  DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_3__tmp5_[1] ^ _tmp6_[10]
  DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp4_ = DR_start_V32_1_QR_V32_4__tmp5_[1] ^ _tmp6_[11]
  _tmp6_[4] = btor.Rol(DR_start_V32_1_QR_V32_1_QR_end_V32_1__tmp4_,7)
  _tmp6_[5] = btor.Rol(DR_start_V32_1_QR_V32_2_QR_end_V32_1__tmp4_,7)
  _tmp6_[6] = btor.Rol(DR_start_V32_1_QR_V32_3_QR_end_V32_1__tmp4_,7)
  _tmp6_[7] = btor.Rol(DR_start_V32_1_QR_V32_4_QR_end_V32_1__tmp4_,7)
  DR_end_V32_1_QR_V32_4__tmp5_[0] = _tmp6_[3] + _tmp6_[4]
  DR_end_V32_1_QR_V32_1__tmp5_[0] = _tmp6_[0] + _tmp6_[5]
  DR_end_V32_1_QR_V32_2__tmp5_[0] = _tmp6_[1] + _tmp6_[6]
  DR_end_V32_1_QR_V32_3__tmp5_[0] = _tmp6_[2] + _tmp6_[7]
  DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp1_ = _tmp6_[14] ^ DR_end_V32_1_QR_V32_4__tmp5_[0]
  DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp1_ = _tmp6_[15] ^ DR_end_V32_1_QR_V32_1__tmp5_[0]
  DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp1_ = _tmp6_[12] ^ DR_end_V32_1_QR_V32_2__tmp5_[0]
  DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp1_ = _tmp6_[13] ^ DR_end_V32_1_QR_V32_3__tmp5_[0]
  DR_end_V32_1_QR_V32_4__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_1__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_2__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_3__tmp5_[3] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp1_,16)
  DR_end_V32_1_QR_V32_4__tmp5_[2] = _tmp6_[9] + DR_end_V32_1_QR_V32_4__tmp5_[3]
  DR_end_V32_1_QR_V32_1__tmp5_[2] = _tmp6_[10] + DR_end_V32_1_QR_V32_1__tmp5_[3]
  DR_end_V32_1_QR_V32_2__tmp5_[2] = _tmp6_[11] + DR_end_V32_1_QR_V32_2__tmp5_[3]
  DR_end_V32_1_QR_V32_3__tmp5_[2] = _tmp6_[8] + DR_end_V32_1_QR_V32_3__tmp5_[3]
  DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp2_ = _tmp6_[4] ^ DR_end_V32_1_QR_V32_4__tmp5_[2]
  DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp2_ = _tmp6_[5] ^ DR_end_V32_1_QR_V32_1__tmp5_[2]
  DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp2_ = _tmp6_[6] ^ DR_end_V32_1_QR_V32_2__tmp5_[2]
  DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp2_ = _tmp6_[7] ^ DR_end_V32_1_QR_V32_3__tmp5_[2]
  DR_end_V32_1_QR_V32_4__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_start_V32_1__tmp2_,12)
  DR_end_V32_1_QR_V32_1__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_start_V32_1__tmp2_,12)
  DR_end_V32_1_QR_V32_2__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_start_V32_1__tmp2_,12)
  DR_end_V32_1_QR_V32_3__tmp5_[1] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_start_V32_1__tmp2_,12)
  stateR_[3] = DR_end_V32_1_QR_V32_4__tmp5_[0] + DR_end_V32_1_QR_V32_4__tmp5_[1]
  stateR_[0] = DR_end_V32_1_QR_V32_1__tmp5_[0] + DR_end_V32_1_QR_V32_1__tmp5_[1]
  stateR_[1] = DR_end_V32_1_QR_V32_2__tmp5_[0] + DR_end_V32_1_QR_V32_2__tmp5_[1]
  stateR_[2] = DR_end_V32_1_QR_V32_3__tmp5_[0] + DR_end_V32_1_QR_V32_3__tmp5_[1]
  DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_4__tmp5_[3] ^ stateR_[3]
  DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_1__tmp5_[3] ^ stateR_[0]
  DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_2__tmp5_[3] ^ stateR_[1]
  DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp3_ = DR_end_V32_1_QR_V32_3__tmp5_[3] ^ stateR_[2]
  stateR_[14] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp3_,8)
  stateR_[15] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp3_,8)
  stateR_[12] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp3_,8)
  stateR_[13] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp3_,8)
  stateR_[9] = DR_end_V32_1_QR_V32_4__tmp5_[2] + stateR_[14]
  stateR_[10] = DR_end_V32_1_QR_V32_1__tmp5_[2] + stateR_[15]
  stateR_[11] = DR_end_V32_1_QR_V32_2__tmp5_[2] + stateR_[12]
  stateR_[8] = DR_end_V32_1_QR_V32_3__tmp5_[2] + stateR_[13]
  DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_4__tmp5_[1] ^ stateR_[9]
  DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_1__tmp5_[1] ^ stateR_[10]
  DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_2__tmp5_[1] ^ stateR_[11]
  DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp4_ = DR_end_V32_1_QR_V32_3__tmp5_[1] ^ stateR_[8]
  stateR_[4] = btor.Rol(DR_end_V32_1_QR_V32_4_QR_end_V32_1__tmp4_,7)
  stateR_[5] = btor.Rol(DR_end_V32_1_QR_V32_1_QR_end_V32_1__tmp4_,7)
  stateR_[6] = btor.Rol(DR_end_V32_1_QR_V32_2_QR_end_V32_1__tmp4_,7)
  stateR_[7] = btor.Rol(DR_end_V32_1_QR_V32_3_QR_end_V32_1__tmp4_,7)

  return (stateR_)


def dest_Chacha20_(plain_):
  cipher_ = [ None for _ in range(16)]

  state_ = [ None for _ in range(16)]

  state_[0] = plain_[0]
  state_[1] = plain_[1]
  state_[2] = plain_[2]
  state_[3] = plain_[3]
  state_[4] = plain_[4]
  state_[5] = plain_[5]
  state_[6] = plain_[6]
  state_[7] = plain_[7]
  state_[8] = plain_[8]
  state_[9] = plain_[9]
  state_[10] = plain_[10]
  state_[11] = plain_[11]
  state_[12] = plain_[12]
  state_[13] = plain_[13]
  state_[14] = plain_[14]
  state_[15] = plain_[15]
  for i_ in range(1,10+1):
    (state_) = dest_DR_V32(state_)
  cipher_[0] = state_[0]
  cipher_[1] = state_[1]
  cipher_[2] = state_[2]
  cipher_[3] = state_[3]
  cipher_[4] = state_[4]
  cipher_[5] = state_[5]
  cipher_[6] = state_[6]
  cipher_[7] = state_[7]
  cipher_[8] = state_[8]
  cipher_[9] = state_[9]
  cipher_[10] = state_[10]
  cipher_[11] = state_[11]
  cipher_[12] = state_[12]
  cipher_[13] = state_[13]
  cipher_[14] = state_[14]
  cipher_[15] = state_[15]

  return (cipher_)


(dest_cipher_) = dest_Chacha20_(plain_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################

ortmp0 = orig_cipher_[0] != dest_cipher_[0]
ortmp1 = btor.Or(orig_cipher_[1] != dest_cipher_[1], ortmp0)
ortmp2 = btor.Or(orig_cipher_[2] != dest_cipher_[2], ortmp1)
ortmp3 = btor.Or(orig_cipher_[3] != dest_cipher_[3], ortmp2)
ortmp4 = btor.Or(orig_cipher_[4] != dest_cipher_[4], ortmp3)
ortmp5 = btor.Or(orig_cipher_[5] != dest_cipher_[5], ortmp4)
ortmp6 = btor.Or(orig_cipher_[6] != dest_cipher_[6], ortmp5)
ortmp7 = btor.Or(orig_cipher_[7] != dest_cipher_[7], ortmp6)
ortmp8 = btor.Or(orig_cipher_[8] != dest_cipher_[8], ortmp7)
ortmp9 = btor.Or(orig_cipher_[9] != dest_cipher_[9], ortmp8)
ortmp10 = btor.Or(orig_cipher_[10] != dest_cipher_[10], ortmp9)
ortmp11 = btor.Or(orig_cipher_[11] != dest_cipher_[11], ortmp10)
ortmp12 = btor.Or(orig_cipher_[12] != dest_cipher_[12], ortmp11)
ortmp13 = btor.Or(orig_cipher_[13] != dest_cipher_[13], ortmp12)
ortmp14 = btor.Or(orig_cipher_[14] != dest_cipher_[14], ortmp13)
ortmp15 = btor.Or(orig_cipher_[15] != dest_cipher_[15], ortmp14)
btor.Assert(ortmp15)


start = timer()
res = btor.Sat()
end = timer()
print("Running time: " + str(end - start))
if res == btor.SAT:
  print('SAT')
  #btor.Print_model()
else:
  print('UNSAT')
