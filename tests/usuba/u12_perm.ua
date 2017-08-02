perm init_p (a:u12) returns ( out:u12 ) {
     10, 2, 12, 4, 6, 8, 9, 1, 11, 3, 5, 7
}

node main (a:u12) returns (b:u12)
vars
let
    b = init_p(a)
tel