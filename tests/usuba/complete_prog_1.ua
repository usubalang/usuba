node nxor ( x : bool :: _, y : bool :: _ ) returns z : bool :: _
vars
let
  tmp = xor(x,y);
  z = not(tmp)
tel

node nand ( x : bool :: _, y : bool :: _ ) returns z : bool :: _
vars
let
    tmp = and(x,y);
    z = not(tmp)
tel

node triple_nxor (x:bool::_,y:bool::_,z:bool::_) returns b:bool::_
vars
let
    tmp1 = nxor(x,y);
    b = nxor(tmp1,z)
tel

node random_box (x1:bool::_,x2:bool::_,x3:bool::_,x4:bool::_)
     returns r1:bool::_,r2:bool::_,r3:bool::_
vars
let
    a = xor(x1,x2);
    r1 = or(x1,x2);
    b = not(nxor(a,x3));
    c = nand(b,triple_nxor(x2,x3,x4));
    d = or(c,xor(x1,x4));
    r2 = xor(d,x3);
    r3 = nand(and(b,d),or(x2,x4))    
tel