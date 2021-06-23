# Playing with array types and parameters in Usuba (reminder: bn is
# equal to b1[n], which means that we are indeed dealing with arrays).
#
# Test: this file should compile. The resulting function should be the
# identity.

node f(a:b2, b:b2) returns (c:b4)
vars x:b3, y:b1, z:b4
let
    z = (a, b);
    (x, y) = z;
    c = (x, y);
tel

node g(a:b4) returns (c:b4)
let
    c = f(a)
tel