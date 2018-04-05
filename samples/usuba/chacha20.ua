
#pragma vectorization

node QR_start (a:u32, b:u32, c:u32, d:u32)
     returns (aR:u32, bR:u32, cR:u32, dR:u32)
let
    aR = a + b;
    dR = (d ^ aR) <<< 16;
    cR = c + dR;
    bR = (b ^ cR) <<< 8
tel


node QR_end (a:u32, b:u32, c:u32, d:u32)
     returns (aR:u32, bR:u32, cR:u32, dR:u32)
let
    aR = a + b;
    dR = (d ^ aR) <<< 8;
    cR = c + dR;
    bR = (b ^ cR) <<< 7
tel


// Quarter round
node QR (input:u32x4) returns (output:u32x4)
let
    output = QR_end(QR_start(input))    
tel

// first half of the double round
node DR_start (state:u32x16) returns (stateR:u32x16)
let
    stateR[0,4,8,12]  = QR(state[0,4,8,12]);
    stateR[1,5,9,13]  = QR(state[1,5,9,13]);
    stateR[2,6,10,14] = QR(state[2,6,10,14]);
    stateR[3,7,11,15] = QR(state[3,7,11,15])
tel

// second half of the double round
node DR_end (state:u32x16) returns (stateR:u32x16)
let
    stateR[0,5,10,15] = QR(state[0,5,10,15]);
    stateR[1,6,11,12] = QR(state[1,6,11,12]);
    stateR[2,7,8,13]  = QR(state[2,7,8,13]);
    stateR[3,4,9,14]  = QR(state[3,4,9,14])
tel

// full double round
node DR (state:u32x16) returns (stateR:u32x16)
let
    stateR = DR_end(DR_start(state))
tel


node Chacha20 (plain:u32x16) returns (cipher:u32x16)
vars
    state : u32x16[11]
let
    state[0] = plain;
    forall i in [1,10] {
      state[i] = DR(state[i-1])
    }
    cipher = state[10]
tel