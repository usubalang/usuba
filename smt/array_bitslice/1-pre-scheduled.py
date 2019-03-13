
from z3 import *

######################################################################
#                          Original program                          #
######################################################################

def orig_f_B1(a_0_,a_1_,a_2_,a_3_,b_0_,b_1_,b_2_,b_3_):


  c_0_ = Xor(a_0_,b_0_)
  c_1_ = Xor(a_1_,b_1_)
  c_2_ = Xor(a_2_,b_2_)
  c_3_ = Xor(a_3_,b_3_)

  return (c_0_,c_1_,c_2_,c_3_)


def orig_main_(a_,b_):
  c_ = [ None for _ in range(4)]


  (c_[0],c_[1],c_[2],c_[3]) = orig_f_B1(a_[0],a_[1],a_[2],a_[3],b_[0],b_[1],b_[2],b_[3])

  return (c_)


orig_a_ = [ Bool('a_[%d]' % (c0)) for c0 in range(4)]
orig_b_ = [ Bool('b_[%d]' % (c0)) for c0 in range(4)]


(orig_c_) = orig_main_(orig_a_,orig_b_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_f_B1(a_0_,a_1_,a_2_,a_3_,b_0_,b_1_,b_2_,b_3_):


  c_0_ = Xor(a_0_,b_0_)
  c_1_ = Xor(a_1_,b_1_)
  c_2_ = Xor(a_2_,b_2_)
  c_3_ = Xor(a_3_,b_3_)

  return (c_0_,c_1_,c_2_,c_3_)


def dest_main_(a_,b_):
  c_ = [ None for _ in range(4)]


  (c_[0],c_[1],c_[2],c_[3]) = dest_f_B1(a_[0],a_[1],a_[2],a_[3],b_[0],b_[1],b_[2],b_[3])

  return (c_)


dest_a_ = [ Bool('a_[%d]' % (c0)) for c0 in range(4)]
dest_b_ = [ Bool('b_[%d]' % (c0)) for c0 in range(4)]


(dest_c_) = dest_main_(dest_a_,dest_b_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################
s = Solver()
s.add(Or(orig_c_[0] != dest_c_[0], orig_c_[1] != dest_c_[1], orig_c_[2] != dest_c_[2], orig_c_[3] != dest_c_[3]))
print(s.check())
