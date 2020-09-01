# Note: due to the current state of usuba, only the last function actually
# gets generated in the generated code. To test the other functions, you'll
# have to put them last in the file or comment the rest.

node tes_op (a:b8) returns (b:b8)
vars
let
    b = a & 12:b8
tel

node test_size (a:b6) returns (b:b8,d:b5)
vars
let
    b = 11:b8;
    d = 11:b5
tel

node test_tuple (a:b3) returns (b:b8)
vars
let
    b = (a,6:b5)
tel