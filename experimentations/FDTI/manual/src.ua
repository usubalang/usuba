
node adder (a:bool,b:bool) returns (s:bool,c:bool)
let
    s = a ^ b;
    c = a & b
tel

############################################################

node normal2TI (a:bool,r:u2) returns (a':u3)
let
    a' = (r[0], r[1], a ^ r[0] ^ r[1])
tel

node TI2normal (a':u3) returns (a:bool)
let
    a = a'[0] ^ a'[1] ^ a'[2]
tel

node normal2FD (a:bool) returns (a':u2)
let
    a' = (a,~a)
tel

node FD2normal (a':u2) returns (a:bool,c:bool)
let
    a = a'[0];
    c = a'[0] & a'[1]
tel

############################################################


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

node notTI (a:u3) returns (a':u3)
let
    a' = ~a
tel

node orTI (a:u3,b:u3,r:u3) returns (x:u3)
let
    x = notTI(andTI(notTI(a),notTI(b),r))
tel

node andFDTI (a:u6,b:u6,r:u6) returns (x:u6,c:u3)
let
  x[0,2,4] = andTI(a[0,2,4],b[0,2,4],r[0,2,4]);
  x[1,3,5] = orTI(a[1,3,5],b[1,3,5],r[1,3,5]);
  c = x[0,2,4] ^ x[1,3,5]
tel

node xorFDTI (a:u6,b:u6) returns (x:u6,c:u3)
let
    x[0,2,4] = a[0,2,4] ^ b[0,2,4];
    x[1,3,5] = ~(a[1,3,5] ^b[1,3,5]);
    c = x[0,2,4] ^ x[1,3,5]
tel


node adderFDTI (a:u6,b:u6,r:u6) returns (s:u6,c:u6)
vars
    c1:u3,c2:u3
let
    (s,c1) = xorFDTI(a, b);
    (c,c2) = andFDTI(a, b, r)
tel

#################################################################


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

node andTIFD (a:u6,b:u6,r:u6) returns (x:u6,c:u3)
let
    x[0..2] = andTI(a[0..2],b[0..2],r[0..2]);
    x[3..5] = andTI'(a[3..5],b[3..5],r[3..5]);
    c = x[0,1,2] ^ x[3,4,5]  
tel

node xorTIFD (a:u6,b:u6) returns (x:u6,c:u3)
let
    x[0,1,2] = a[0,1,2] ^ b[0,1,2];
    x[3,4,5] = a[3,4,5] ^ b[3,4,5];
    c = x[0,1,2] ^ x[3,4,5]
tel



node adderTIFD (a:u6,b:u6,r:u6) returns (s:u6,c:u6)
vars
    c1:u3,c2:u3
let
    (s,c1) = xorTIFD(a, b);
    (c,c2) = andTIFD(a, b, r)    
tel