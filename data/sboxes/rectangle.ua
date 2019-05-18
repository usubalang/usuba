node sbox (a0:v1, a1:v1, a2:v1, a3:v1)
     returns  (b0:v1, b1:v1, b2:v1, b3:v1)
vars
    t1:v1, t2:v1, t3:v1, t4:v1, t5:v1, t6:v1,
    t7:v1, t8:v1, t9:v1, t10:v1, t11:v1, t12:v1
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