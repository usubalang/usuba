perm init_p (a:u10) returns ( out:u10 ) {
     10, 2, 4, 6, 8, 9, 1, 3, 5, 7
}

node main (a:u10) returns (b:u10)
vars
let
    b = init_p(a)
tel