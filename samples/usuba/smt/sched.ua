# Rectangle's Sbox (gonna be scheduled)
node sbox (a0:u16, a1:u16, a2:u16, a3:u16)
     returns  (b0:u16, b1:u16, b2:u16, b3:u16)
vars
    t1:u16, t2:u16, t3:u16, t4:u16, t5:u16, t6:u16,
    t7:u16, t8:u16, t9:u16, t10:u16, t11:u16, t12:u16
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