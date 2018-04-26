node QR_start (a:u128<4>x1, b:u128<4>x1, c:u128<4>x1, d:u128<4>x1)
     returns (aR:u128<4>x1, bR:u128<4>x1, cR:u128<4>x1, dR:u128<4>x1)
let
    aR = a + b;
    dR = (d ^ aR) <<< 16;
    cR = c + dR;
    bR = (b ^ cR) <<< 12
tel


node QR_end (a:u128<4>x1, b:u128<4>x1, c:u128<4>x1, d:u128<4>x1)
     returns (aR:u128<4>x1, bR:u128<4>x1, cR:u128<4>x1, dR:u128<4>x1)
let
    aR = a + b;
    dR = (d ^ aR) <<< 8;
    cR = c + dR;
    bR = (b ^ cR) <<< 7
tel


// Quarter round
node QR (input:u128<4>x4) returns (output:u128<4>x4)
let
    output = QR_end(QR_start(input))    
tel


node DR_mid_rot (state:u128<4>x4) returns (stateR:u128<4>x4)
let
    stateR[0] = state[0];
    stateR[1] = Shuffle(state[1],[3,0,1,2]);
    stateR[2] = Shuffle(state[2],[2,3,0,1]);
    stateR[3] = Shuffle(state[3],[1,2,3,0])
tel

node DR_end_rot (state:u128<4>x4) returns (stateR:u128<4>x4)
let
    stateR[0] = state[0];
    stateR[1] = Shuffle(state[1],[1,2,3,0]);
    stateR[2] = Shuffle(state[2],[2,3,0,1]);
    stateR[3] = Shuffle(state[3],[3,0,1,2])
tel

node DR (state:u128<4>x4) returns (stateR:u128<4>x4)
let
    stateR = DR_end_rot(QR(DR_mid_rot(QR(state))))
tel

node Chacha20 (plain:u128<4>x4) returns (cipher:u128<4>x4)
vars
    state : u128<4>x4[11]
let
    state[0] = plain;
    _no_unroll forall i in [1,10] {
      state[i] = DR(state[i-1])
    }
    cipher = state[10]
tel