node QR (a:u<V>32, b:u<V>32, c:u<V>32, d:u<V>32)
     returns (aR:u<V>32, bR:u<V>32, cR:u<V>32, dR:u<V>32)
let
    a := a + b;
    d := (d ^ aR) <<< 16;
    c := c + dR;
    b := (b ^ cR) <<< 12;
    aR = a + b;
    dR = (d ^ aR) <<< 8;
    cR = c + dR;
    bR = (b ^ cR) <<< 7
tel

node DR (state:u<V>32x16) returns (stateR:u<V>32x16)
let
    state[0,4,8,12]  := QR(state[0,4,8,12]);
    state[1,5,9,13]  := QR(state[1,5,9,13]);
    state[2,6,10,14] := QR(state[2,6,10,14]);
    state[3,7,11,15] := QR(state[3,7,11,15]);
    stateR[0,5,10,15] = QR(state[0,5,10,15]);
    stateR[1,6,11,12] = QR(state[1,6,11,12]);
    stateR[2,7,8,13]  = QR(state[2,7,8,13]);
    stateR[3,4,9,14]  = QR(state[3,4,9,14])
tel

node Chacha20 (plain:u<V>32x16) returns (cipher:u<V>32x16)
let
    _no_unroll forall i in [1,10] {
      plain := DR(plain)
    }
    cipher = plain
tel