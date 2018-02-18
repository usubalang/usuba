node sbox (a0:bool, a1:bool, a2:bool, a3:bool)
     returns  (b0:bool, b1:bool, b2:bool, b3:bool)
vars
    t1:bool, t2:bool, t3:bool, t4:bool, t5:bool, t6:bool,
    t7:bool, t8:bool, t9:bool, t10:bool, t11:bool, t12:bool
let
    t1 = ~a1;
    t2 = a0 & t1;
    t3 = a2 ^ a3;
    b0 = t2 ^ t3;
    t5 = a3 | t1;
    t6 = a0 ^ t5;
    b1 = a2 ^ t6;
    t8 = a1 ^ a2;
    t9 = t3 & t6;
    b3 = t8 ^ t9;
    t11 = b0 | t8;
    b2 = t6 ^ t11
tel