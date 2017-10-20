perm expand (a: u4) returns ( out:u6 )  {
     1,3,2,4,4,1
}

node main (a:u4) returns (b:u6)
vars
let
    b = expand(a)
tel
  