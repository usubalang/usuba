#pragma vectorization

node _andTI (a:u4,b:u4,r:u4) returns (x:u4)
vars
    c1:u4,c2:u4,c3:u4,c4:u4,d1:u4,d2:u4,d3:u4,d4:u4
let
    c1 = a & b;
    c2 = a & (b <<< 1);
    c3 = (a <<< 1) & b;
    c4 = a & (b <<< 2);
    d1 = c1 ^ r;
    d2 = d1 ^ c2;
    d3 = d2 ^ c3;
    d4 = d3 ^ (r <<< 1);
    x = d4 ^ c4
tel


node _notTI (a:u4) returns (a':u4)
let
    a' = ~a
tel


node _orTI (a:u4,b:u4,r:u4) returns (x:u4)
let
    x = _notTI(_andTI(_notTI(a),_notTI(b),r))
tel