
from z3 import *

######################################################################
#                          Original program                          #
######################################################################

def orig_f_B1(a_,b_):


  c_ = Xor(a_,b_)

  return (c_)


def orig_main_(a_,b_):


  (c_) = orig_f_B1(a_,b_)

  return (c_)


orig_a_ = Bool('a_')
orig_b_ = Bool('b_')


(orig_c_) = orig_main_(orig_a_,orig_b_)
 



######################################################################
#                        Transformed program                         #
######################################################################

def dest_f_B1(a_,b_):


  c_ = Xor(a_,b_)

  return (c_)


def dest_main_(a_,b_):


  (c_) = dest_f_B1(a_,b_)

  return (c_)


dest_a_ = Bool('a_')
dest_b_ = Bool('b_')


(dest_c_) = dest_main_(dest_a_,dest_b_)
 


######################################################################
#                        Equivalence checking                        #
######################################################################
s = Solver()
s.add(Or(orig_c_ != dest_c_))
print(s.check())
