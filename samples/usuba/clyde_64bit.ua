# Specification: https://csrc.nist.gov/CSRC/media/Projects/Lightweight-Cryptography/documents/round-1/spec-doc/Spook-spec.pdf
# Supported mode: bitslicing, v-slicing, (h-slicing?)

node sbox (a:u64, b:u64) returns (aR:u64, bR:u64)
vars
    s0, s1, s2, s3, y0, y1, y2, y3: u64
let
    s0 = (a >> 1) & 0x5555555555555555;
    s1 = (a) & 0x5555555555555555;
    s2 = (b >> 1) & 0x5555555555555555;
    s3 = (b) & 0x5555555555555555;
    y1 = (s0 & s1) ^ s2;
    y0 = (s3 & s0) ^ s1;
    y3 = (y1 & s3) ^ s0;
    y2 = (y0 & y1) ^ s3;
    aR = (y0 << 1) | y1;
    bR = (y2 << 1) | y3;
tel

node lbox(c:u64) returns (cr:u64)
vars
    a, b: u64
let
    a   = c ^ (c >>> 24);
    a ^:=      a >>> 6;
    a ^:=      c >>> 34;
    b   = a ^ (a >>> 62);
    a ^:=     (b >>> 51);
    cr  = a ^ (b >>> 30);
tel

node lbox_layer(state:u64x2) returns (stateR:u64x2)
let
    stateR = (lbox(state[0]), lbox(state[1]))
tel

node add_rc(state:u64x2, rc:u64x2) returns (stateR:u64x2)
let
    stateR = state ^ rc
tel

node tweakey (key,tweak:u64x2) returns (tk:u64x2[3])
vars
    tx : u64
let
    tx = tweak[0] ^ tweak[1];
    tk[0] = key ^ tweak;
    tk[1] = (key[0] ^ tx, key[1] ^ tweak[0]);
    tk[2] = (key[0] ^ tweak[1], key[1] ^ tx)
tel


node clyde128 (state,key,tweak:u64x2) returns (cipher:u64x2)
vars
    rc:u64x2[12],
    round:u64x2[19],
    tk:u64x2[3]
let
    rc  = (2, 0,
           1, 0,
           0, 2,
           0, 1,
           3, 0,
           1, 2,
           0, 3,
           3, 1,
           2, 2,
           1, 1,
           3, 2,
           1, 3);

    tk = tweakey(key,tweak);

    round[0] = state ^ tk[0];

    # XXX: need imperative loop: UGLY!
    forall s in [0, 5] {
      round[s*3+1] = add_rc(lbox_layer(sbox(round[s*3])), rc[s*2]);
      round[s*3+2] = add_rc(lbox_layer(sbox(round[s*3+1])), rc[s*2+1]);
      round[s*3+3] = round[s*3+2] ^ tk[(s+1)%3];
    }

    cipher = round[18]

tel