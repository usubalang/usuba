
table Sbox(x:v5) returns (y:v5) {
  0x4,  0xb,  0x1f, 0x14, 0x1a, 0x15, 0x9,  0x2,
  0x1b, 0x5,  0x8,  0x12, 0x1d, 0x3,  0x6,  0x1c,
  0x1e, 0x13, 0x7,  0xe,  0x0,  0xd,  0x11, 0x18,
  0x10, 0xc,  0x1,  0x19, 0x16, 0xa,  0xf,  0x17
}

node AddConstant(state:u64x5,c:u64) returns (stateR:u64x5)
let
    stateR = (state[0,1], state[2] ^ c, state[3,4]);
tel

node LinearLayer(state:u64x5) returns (stateR:u64x5)
let
  stateR[0] = state[0] ^ (state[0] >>> 19) ^ (state[0] >>> 28);
  stateR[1] = state[1] ^ (state[1] >>> 61) ^ (state[1] >>> 39);
  stateR[2] = state[2] ^ (state[2] >>> 1)  ^ (state[2] >>> 6);
  stateR[3] = state[3] ^ (state[3] >>> 10) ^ (state[3] >>> 17);
  stateR[4] = state[4] ^ (state[4] >>> 7)  ^ (state[4] >>> 41);
tel

node ascon12(input:u64x5) returns (output:u64x5)
vars
    consts:u64[12],
    state:u64x5[13]
let
    consts = (0xf0, 0xe1, 0xd2, 0xc3, 0xb4, 0xa5,
              0x96, 0x87, 0x78, 0x69, 0x5a, 0x4b);

    state[0] = input;
    forall i in [0, 11] {
        state[i+1] = LinearLayer(Sbox(AddConstant(state[i],consts[i])))
    }
    output = state[12]
tel