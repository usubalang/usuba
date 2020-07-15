# Specification: https://tools.ietf.org/html/rfc7539
# Supported mode: bitslicing, v-slicing

# XXX: one implementation of Chacha stands between V and H, with
# something akin to 32x4x4. This may not be strictly required
# here. Another example is GIMLI, where it is necessary to get perf.

# Quarter round
node QR (*a:u<V>32, *b:u<V>32, *c:u<V>32, *d:u<V>32)
let
    a := a + b;
    d := (d ^ a) <<< 16;
    c := c + d;
    b := (b ^ c) <<< 12;
    a +:= b;
    d := (d ^ a) <<< 8;
    c +:= d;
    b := (b ^ cR) <<< 7;
tel

# Double round
node DR (*state:u<V>32x16)
let
    state[0,4,8,12]  := QR(state[0,4,8,12]);
    state[1,5,9,13]  := QR(state[1,5,9,13]);
    state[2,6,10,14] := QR(state[2,6,10,14]);
    state[3,7,11,15] := QR(state[3,7,11,15]);

    state[0,5,10,15] := QR(state[0,5,10,15]);
    state[1,6,11,12] := QR(state[1,6,11,12]);
    state[2,7,8,13]  := QR(state[2,7,8,13]);
    state[3,4,9,14]  := QR(state[3,4,9,14]);
tel

# Main
node Chacha20 (plain:u<V>32x16) returns (cipher:u<V>32x16)
vars
    state : u<V>32x16
let
    forall i in [0,10] {
      i = 0: state = plain;
      _    : state := DR(state)
    }
    cipher = state
tel
