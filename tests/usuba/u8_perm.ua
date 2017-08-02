perm init_p (a:u8) returns ( out:u8 ) {
     2, 4, 6, 8, 1, 3, 5, 7
}

node main (a:u8) returns (b:u8)
vars
let
    b = init_p(a)
tel