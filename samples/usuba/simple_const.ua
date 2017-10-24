# Note: due to the current state of usuba, only the last function actually
# gets generated in the generated code. To test the other functions, you'll
# have to put them last in the file or comment the rest.

node tes_op (a:u8) returns (b:u8)
vars
let
    b = a & 12
tel

node test_size (a:u6) returns (b:u8,d:u5)
vars
let
    b = 11;
    d = 11
tel

node test_tuple (a:u3) returns (b:u8)
vars
let
    b = (a,6)
tel