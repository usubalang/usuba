# Specification: https://eprint.iacr.org/2014/084.pdf
# Supported mode: ???

table SubColumn : v4 -> v4 {
    6, 5, 12, 10, 1, 14, 7, 9, 11, 0, 3, 13, 8, 15, 4, 2
}

# XXX: in-place update of input
node ShiftRows (*input:u16x4)
vars
let
    input[1] <<<:= 1;
    input[2] <<<:= 12;
    input[3] <<<:= 13
tel

node Rectangle (plain:u16x4,key:const u16x4[26]) returns (cipher:u16x4)
vars
    state : u16x4
let
    forall i in [0,24] {
      i = 0: state = plain;
      _    : state := ShiftRows(SubColumn(state ^ key[i]))
    }

    cipher = state ^ key[25]
tel