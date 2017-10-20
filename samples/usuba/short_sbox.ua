table f (a:u2) returns (b:u2) {
      1,3,2,0
}

node main (a:u2) returns (b:u2)
vars
let
   b = f(a)
tel