table f (a:b4) returns (b:b2) {
      1,0,2,1,3,0,2,3,1,2,3,1,0,1,3,0
}

node main (a:b4) returns (b:b2)
vars
let
   b = f(a)
tel