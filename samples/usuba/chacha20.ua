# Specification: https://tools.ietf.org/html/rfc7539
# Supported mode: bitslicing, v-slicing

# XXX: one implementation of Chacha stands between V and H, with
# something akin to 32x4x4. This may not be strictly required
# here. Another example is GIMLI, where it is necessary to get perf.

# Quarter round
# XXX: in-place update
node QR (a:u<V>32, b:u<V>32, c:u<V>32, d:u<V>32)
     returns (aR:u<V>32, bR:u<V>32, cR:u<V>32, dR:u<V>32)
let
    a := a + b;
    d := (d ^ a) <<< 16;
    c := c + d;
    b := (b ^ c) <<< 12;
    aR = a + b;
    dR = (d ^ aR) <<< 8;
    cR = c + dR;
    bR = (b ^ cR) <<< 7;
tel

# Double round
# XXX: in-place update
node DR (state:u<V>32x16) returns (stateR:u<V>32x16)
let
    state[0,4,8,12]  := QR(state[0,4,8,12]);
    state[1,5,9,13]  := QR(state[1,5,9,13]);
    state[2,6,10,14] := QR(state[2,6,10,14]);
    state[3,7,11,15] := QR(state[3,7,11,15]);

    stateR[0,5,10,15] = QR(state[0,5,10,15]);
    stateR[1,6,11,12] = QR(state[1,6,11,12]);
    stateR[2,7,8,13]  = QR(state[2,7,8,13]);
    stateR[3,4,9,14]  = QR(state[3,4,9,14]);
tel

# Main
node Chacha20 (plain:u<V>32x16) returns (cipher:u<V>32x16)
vars
    state : u<V>32x16[11]
let
    state[0] = plain;
    # XXX: imperative loop
    forall i in [1,10] {
      state[i] = DR(state[i-1])
    }
    cipher = state[10]
tel
