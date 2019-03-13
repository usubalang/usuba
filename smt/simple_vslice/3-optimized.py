
from z3 import *

######################################################################
#                          Original program                          #
######################################################################

def orig_main_(a_,b_):


  c_ = a_ ^ b_

  return (c_)


orig_a_ = BitVec('a_',8)
orig_b_ = BitVec('b_',8)


(orig_c_) = orig_main_(orig_a_,orig_b_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_main_(a_,b_):


  c_ = a_ ^ b_

  return (c_)


dest_a_ = BitVec('a_',8)
dest_b_ = BitVec('b_',8)


(dest_c_) = dest_main_(dest_a_,dest_b_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################
s = Solver()
s.add(Or(orig_c_ != dest_c_))
print(s.check())
