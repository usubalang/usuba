#pragma vectorization

node _andTI (a:u8,b:u8,r1:u8,r2:u8) returns (x:u8)
vars
    c1:u8,c2:u8,c3:u8,c4:u8,c5:u8,c6:u8,c7:u8,c8:u8,
    d1:u8,d2:u8,d3:u8,d4:u8,d5:u8,d6:u8,d7:u8,d8:u8,d9:u8,d10:u8
let
    c1 = a & b;
    c2 = a & (b <<< 1);
    c3 = (a <<< 1) & b;
    c4 = a & (b <<< 2);
    c5 = (a <<< 2) & b;
    c6 = a & (b <<< 3);
    c7 = (a <<< 3) & b;
    c8 = a & (b <<< 4);
    d1 = c1 ^ r1;
    d2 = d1 ^ c2;
    d3 = d2 ^ c3;
    d4 = d3 ^ (r1 <<< 1);
    d5 = d4 ^ c4;
    d6 = d5 ^ c5;
    d7 = d6 ^ (r2 <<< 0);
    d8 = d7 ^ c6;
    d9 = d8 ^ c7;
    d10 = d9 ^ (r2 <<< 1);
    x = d10 ^ c8
tel


node _notTI (a:u8) returns (a':u8)
let
    a' = ~a
tel


node _orTI (a:u8,b:u8,r:u8) returns (x:u8)
let
    x = _notTI(_andTI(_notTI(a),_notTI(b),r))
tel