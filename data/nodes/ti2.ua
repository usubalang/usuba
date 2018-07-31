#pragma vectorization

node _andTI (a:u2,b:u2,r:u2) returns (x:u2)
vars
    c1:u2,c2:u2,d1:u2,d2:u2,d3:u2
let
    c1 = a & b;
    c2 = a & (b <<< 1);
    d1 = c1 ^ r;
    d2 = d1 ^ c2;
    d3 = d2 ^ (r <<< 1);
    x  = d3
tel

node _notTI (a:u2) returns (a':u2)
let
    a' = ~a
tel

node _orTI (a:u2,b:u2,r:u2) returns (x:u2)
let
    x = _notTI(_andTI(_notTI(a),_notTI(b),r))
tel