#pragma vectorization

node QR_start (a:u<V>32, b:u<V>32, c:u<V>32, d:u<V>32)
     returns (aR:u<V>32, bR:u<V>32, cR:u<V>32, dR:u<V>32)
let
    aR = a + b;
    dR = (d ^ aR) <<< 16;
    cR = c + dR;
    bR = (b ^ cR) <<< 12
tel


node QR_end (a:u<V>32, b:u<V>32, c:u<V>32, d:u<V>32)
     returns (aR:u<V>32, bR:u<V>32, cR:u<V>32, dR:u<V>32)
let
    aR = a + b;
    dR = (d ^ aR) <<< 8;
    cR = c + dR;
    bR = (b ^ cR) <<< 7
tel

// Quarter round
node QR (input:u<V>32x4) returns (output:u<V>32x4)
let
    output = QR_end(QR_start(input))    
tel

// first half of the double round
node DR_start (state:u<V>32x16) returns (stateR:u<V>32x16)
let
    stateR[0,4,8,12]  = QR(state[0,4,8,12]);
    stateR[1,5,9,13]  = QR(state[1,5,9,13]);
    stateR[2,6,10,14] = QR(state[2,6,10,14]);
    stateR[3,7,11,15] = QR(state[3,7,11,15])
tel

// second half of the double round
node DR_end (state:u<V>32x16) returns (stateR:u<V>32x16)
let
    stateR[0,5,10,15] = QR(state[0,5,10,15]);
    stateR[1,6,11,12] = QR(state[1,6,11,12]);
    stateR[2,7,8,13]  = QR(state[2,7,8,13]);
    stateR[3,4,9,14]  = QR(state[3,4,9,14])
tel

// full double round
_no_inline node DR (state:u<V>32x16) returns (stateR:u<V>32x16)
let
    stateR = DR_end(DR_start(state))
tel


node Chacha20 (plain:u<V>32x16) returns (cipher:u<V>32x16)
vars
    state : u<V>32x16[11]
let
    state[0] = plain;
    _no_unroll forall i in [1,10] {
      state[i] = DR(state[i-1])
    }
    cipher = state[10]
tel