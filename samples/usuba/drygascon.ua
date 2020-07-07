# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/drygascon-spec-round2.pdf

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

# Rotate the lowest 32 bits of |x|; discard the high half of |x|.
node Rotr32(x:u64,n:nat) returns (y:u64)
let
    y = ((x >> n) ^ (x << (32-n))) & 0xffffffff;
tel

_inline node BitRotR_odd(x:u64, shift:nat) returns (y:u64)
vars i0,i1,t:u64
let
    i0  = x & 0xffffffff;
    i1  = x >> 32;
    t   = Rotr32(i1, (shift / 2));
    i1 := Rotr32(i0, (((shift / 2) + 1) % 32));
    i0 := t;
    y = (i1 << 32) ^ (i0 & 0xffffffff);
tel

_inline node BitRotR_eve(x:u64, shift:nat) returns (y:u64)
vars i0,i1:u64
let
    i0  = x & 0xffffffff;
    i1  = x >> 32;
    i0 := Rotr32(i0, (shift / 2));
    i1 := Rotr32(i1, (shift / 2));
    y = (i1 << 32) ^ (i0 & 0xffffffff);
tel


node LinearLayer(state:u64x5) returns (stateR:u64x5)
let
  stateR[0] = state[0] ^ (BitRotR_odd(state[0], 19) ^ BitRotR_eve(state[0], 28));
  stateR[1] = state[1] ^ (BitRotR_odd(state[1], 61) ^ BitRotR_eve(state[1], 38));
  stateR[2] = state[2] ^ (BitRotR_odd(state[2], 1)  ^ BitRotR_eve(state[2], 6));
  stateR[3] = state[3] ^ (BitRotR_eve(state[3], 10) ^ BitRotR_odd(state[3], 17));
  stateR[4] = state[4] ^ (BitRotR_odd(state[4], 7)  ^ BitRotR_eve(state[4], 40));
tel

node CoreRound(c:u64x5,cst:u64) returns (cR:u64x5)
vars
let
    cR = LinearLayer(Sbox(AddConstant(c, cst)))
tel

node Accumulate(r:u64x2, c:u64x5) returns (rR:u64x2)
let
    rR[0] = r[0] ^ c[0] ^ (c[2] >> 32) ^ (c[3] << 32);
    rR[1] = r[1] ^ c[1] ^ (c[3] >> 32) ^ (c[2] << 32);
tel

node drysponge_g(c:u64x5) returns (cR:u64x5,r:u64x2)
vars csts:u64[12], round_c:u64x5[12], round_r:u64x2[12]
let
    csts = (0xf0, 0xe1, 0xd2, 0xc3, 0xb4, 0xa5, 0x96, 0x87, 0x78, 0x69, 0x5a, 0x4b);

    round_c[0] = c;
    round_r[0] = (0, 0);

    forall i in [0, 10] {
        round_c[i+1] = CoreRound(round_c[i], csts[i]);
        round_r[i+1] = Accumulate(round_r[i], round_c[i+1]);
    }

    cR = round_c[11];
    r  = round_r[11];
tel