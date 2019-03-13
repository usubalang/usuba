
from z3 import *

######################################################################
#                          Original program                          #
######################################################################

def orig_SubColumn_V16(a0,a1,a2,a3):


  t1 = ~ a1
  t2 = a0 & t1
  t3 = a2 ^ a3
  b0 = t2 ^ t3
  t5 = a3 | t1
  t6 = a0 ^ t5
  b1 = a2 ^ t6
  t8 = a1 ^ a2
  t9 = t3 & t6
  b3 = t8 ^ t9
  t11 = b0 | t8
  b2 = t6 ^ t11

  return (b0,b1,b2,b3)


def orig_ShiftRows_V16(input_0_,input_1_,input_2_,input_3_):


  out_0_ = input_0_
  out_1_ = RotateLeft(input_1_,1)
  out_2_ = RotateLeft(input_2_,12)
  out_3_ = RotateLeft(input_3_,13)

  return (out_0_,out_1_,out_2_,out_3_)


def orig_Rectangle_(plain_,key_):
  cipher_ = [ None for _ in range(4)]

  tmp_ = [[ None for _ in range(4)] for _ in range(26)]
  _tmp2_ = [ None for _ in range(4)]
  _tmp1_ = [ None for _ in range(4)]

  tmp_[0][0] = plain_[0]
  tmp_[0][1] = plain_[1]
  tmp_[0][2] = plain_[2]
  tmp_[0][3] = plain_[3]
  for i_ in range(0,24+1):
    _tmp1_[0] = tmp_[i_][0] ^ key_[i_][0]
    _tmp1_[1] = tmp_[i_][1] ^ key_[i_][1]
    _tmp1_[2] = tmp_[i_][2] ^ key_[i_][2]
    _tmp1_[3] = tmp_[i_][3] ^ key_[i_][3]
    (_tmp2_[0],_tmp2_[1],_tmp2_[2],_tmp2_[3]) = orig_SubColumn_V16(_tmp1_[0],_tmp1_[1],_tmp1_[2],_tmp1_[3])
    (tmp_[(i_ + 1)][0],tmp_[(i_ + 1)][1],tmp_[(i_ + 1)][2],tmp_[(i_ + 1)][3]) = orig_ShiftRows_V16(_tmp2_[0],_tmp2_[1],_tmp2_[2],_tmp2_[3])
  cipher_[0] = tmp_[25][0] ^ key_[25][0]
  cipher_[1] = tmp_[25][1] ^ key_[25][1]
  cipher_[2] = tmp_[25][2] ^ key_[25][2]
  cipher_[3] = tmp_[25][3] ^ key_[25][3]

  return (cipher_)


orig_plain_ = [ BitVec('plain_[%d]' % (c0), 16) for c0 in range(4)]
orig_key_ = [[ BitVec('key_[%d][%d]' % (c0,c1), 16) for c1 in range(4)] for c0 in range(26)]


(orig_cipher_) = orig_Rectangle_(orig_plain_,orig_key_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_SubColumn_V16(a0,a1,a2,a3):


  t1 = ~ a1
  t2 = a0 & t1
  t3 = a2 ^ a3
  b0 = t2 ^ t3
  t5 = a3 | t1
  t6 = a0 ^ t5
  b1 = a2 ^ t6
  t8 = a1 ^ a2
  t9 = t3 & t6
  b3 = t8 ^ t9
  t11 = b0 | t8
  b2 = t6 ^ t11

  return (b0,b1,b2,b3)


def dest_ShiftRows_V16(input_0_,input_1_,input_2_,input_3_):


  out_0_ = input_0_
  out_1_ = RotateLeft(input_1_,1)
  out_2_ = RotateLeft(input_2_,12)
  out_3_ = RotateLeft(input_3_,13)

  return (out_0_,out_1_,out_2_,out_3_)


def dest_Rectangle_(plain_,key_):
  cipher_ = [ None for _ in range(4)]

  tmp_ = [[ None for _ in range(4)] for _ in range(26)]
  _tmp2_ = [ None for _ in range(4)]
  _tmp1_ = [ None for _ in range(4)]

  tmp_[0][0] = plain_[0]
  tmp_[0][1] = plain_[1]
  tmp_[0][2] = plain_[2]
  tmp_[0][3] = plain_[3]
  for i_ in range(0,24+1):
    _tmp1_[0] = tmp_[i_][0] ^ key_[i_][0]
    _tmp1_[1] = tmp_[i_][1] ^ key_[i_][1]
    _tmp1_[2] = tmp_[i_][2] ^ key_[i_][2]
    _tmp1_[3] = tmp_[i_][3] ^ key_[i_][3]
    (_tmp2_[0],_tmp2_[1],_tmp2_[2],_tmp2_[3]) = dest_SubColumn_V16(_tmp1_[0],_tmp1_[1],_tmp1_[2],_tmp1_[3])
    (tmp_[(i_ + 1)][0],tmp_[(i_ + 1)][1],tmp_[(i_ + 1)][2],tmp_[(i_ + 1)][3]) = dest_ShiftRows_V16(_tmp2_[0],_tmp2_[1],_tmp2_[2],_tmp2_[3])
  cipher_[0] = tmp_[25][0] ^ key_[25][0]
  cipher_[1] = tmp_[25][1] ^ key_[25][1]
  cipher_[2] = tmp_[25][2] ^ key_[25][2]
  cipher_[3] = tmp_[25][3] ^ key_[25][3]

  return (cipher_)


dest_plain_ = [ BitVec('plain_[%d]' % (c0), 16) for c0 in range(4)]
dest_key_ = [[ BitVec('key_[%d][%d]' % (c0,c1), 16) for c1 in range(4)] for c0 in range(26)]


(dest_cipher_) = dest_Rectangle_(dest_plain_,dest_key_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################
s = Solver()
s.add(Or(orig_cipher_[0] != dest_cipher_[0], orig_cipher_[1] != dest_cipher_[1], orig_cipher_[2] != dest_cipher_[2], orig_cipher_[3] != dest_cipher_[3]))
print(s.check())
