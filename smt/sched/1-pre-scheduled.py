
from z3 import *

######################################################################
#                          Original program                          #
######################################################################

def orig_sbox_(a0_,a1_,a2_,a3_):


  t1_ = ~ a1_
  t2_ = a0_ & t1_
  t3_ = a2_ ^ a3_
  b0_ = t2_ ^ t3_
  t5_ = a3_ | t1_
  t6_ = a0_ ^ t5_
  b1_ = a2_ ^ t6_
  t8_ = a1_ ^ a2_
  t9_ = t3_ & t6_
  b3_ = t8_ ^ t9_
  t11_ = b0_ | t8_
  b2_ = t6_ ^ t11_

  return (b0_,b1_,b2_,b3_)


orig_a0_ = BitVec('a0_',16)
orig_a1_ = BitVec('a1_',16)
orig_a2_ = BitVec('a2_',16)
orig_a3_ = BitVec('a3_',16)


(orig_b0_,orig_b1_,orig_b2_,orig_b3_) = orig_sbox_(orig_a0_,orig_a1_,orig_a2_,orig_a3_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_sbox_(a0_,a1_,a2_,a3_):


  t1_ = ~ a1_
  t2_ = a0_ & t1_
  t3_ = a2_ ^ a3_
  b0_ = t2_ ^ t3_
  t5_ = a3_ | t1_
  t6_ = a0_ ^ t5_
  b1_ = a2_ ^ t6_
  t8_ = a1_ ^ a2_
  t9_ = t3_ & t6_
  b3_ = t8_ ^ t9_
  t11_ = b0_ | t8_
  b2_ = t6_ ^ t11_

  return (b0_,b1_,b2_,b3_)


dest_a0_ = BitVec('a0_',16)
dest_a1_ = BitVec('a1_',16)
dest_a2_ = BitVec('a2_',16)
dest_a3_ = BitVec('a3_',16)


(dest_b0_,dest_b1_,dest_b2_,dest_b3_) = dest_sbox_(dest_a0_,dest_a1_,dest_a2_,dest_a3_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################
s = Solver()
s.add(Or(orig_b0_ != dest_b0_, orig_b1_ != dest_b1_, orig_b2_ != dest_b2_, orig_b3_ != dest_b3_))
print(s.check())
