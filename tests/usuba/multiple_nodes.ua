node nxor ( x : u6, y : u6 ) returns (z : u6)
vars
let
  z = ~ (x ^ y)
tel

node main ( x : u6[2] ) returns (z : u6[2])
vars
let
  z = (nxor(x[0],x[1]),nxor(x[0],x[1]))
tel