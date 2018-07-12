
node andTI (a:u3,b:u3,r:u3) returns (x:u3)
vars
    c1:u3,c2:u3,c3:u3,d1:u3,d2:u3,d3:u3,d4:u3
let
    c1 = a & b;
    c2 = a & (b <<< 1);
    c3 = (a <<< 1) & b;
    d1 = c1 ^ r;
    d2 = d1 ^ c2;
    d3 = d2 ^ c3;
    d4 = d3 ^ (r <<< 1);
    x = d4
tel

node andTI' (a:u3,b:u3,r:u3) returns (x:u3)
vars
    c1:u3,c2:u3,c3:u3,d1:u3,d2:u3,d3:u3,d4:u3
let
    c1 = a | b;
    c2 = a | (b <<< 1);
    c3 = (a <<< 1) | b;
    d1 = c1 ^ r;
    d2 = d1 ^ c2;
    d3 = d2 ^ c3;
    d4 = d3 ^ (r <<< 1);
    x = d4
tel

node notTI (a:u3) returns (a':u3)
let
    a' = (~a[0], a[1,2])
tel

node orTI (a:u3,b:u3,r:u3) returns (x:u3)
let
    x = notTI(andTI(notTI(a),notTI(b),r))
tel
