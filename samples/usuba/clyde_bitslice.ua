# Specification: https://csrc.nist.gov/CSRC/media/Projects/Lightweight-Cryptography/documents/round-1/spec-doc/Spook-spec.pdf

node sbox (x0:v1, x1:v1, x2:v1, x3:v1) returns (y0:v1, y1:v1, y2:v1, y3:v1)
let
    y1 = (x0 & x1) ^ x2;
    y0 = (x3 & x0) ^ x1;
    y3 = (y1 & x3) ^ x0;
    y2 = (y0 & y1) ^ x3
tel

node lbox(x,y:u32) returns (xr,yr:u32)
vars
    a, b, c, d: u32
let
    a  = x ^ (x >>> 12);
    b  = y ^ (y >>> 12);
    a := a ^ (a >>> 3);
    b := b ^ (b >>> 3);
    a := a ^ (x >>> 17);
    b := b ^ (y >>> 17);
    c  = a ^ (a >>> 31);
    d  = b ^ (b >>> 31);
    a := a ^ (d >>> 26);
    b := b ^ (c >>> 25);
    a := a ^ (c >>> 15);
    b := b ^ (d >>> 15);
    (xr, yr) = (a,b)
tel

node lbox_layer(state:u32x4) returns (stateR:u32x4)
let
    stateR[0,1] = lbox(state[0], state[1]);
    stateR[2,3] = lbox(state[2], state[3])
tel

node add_rc(state:u32x4, rc:u32x4) returns (stateR:u32x4)
let
    forall i in [0, 3] {
        stateR[i] = state[i] ^ rc[i]
    }
tel

node tweakey (key,tweak:u32x4) returns (tk:u32x4[3])
vars
    tx : u32[2]
let
    tx = tweak[0,1] ^ tweak[2,3];
    tk[0] = key ^ tweak;
    tk[1] = (key[0,1] ^ tx, key[2,3] ^ tweak[0,1]);
    tk[2] = (key[0,1] ^ tweak[2,3], key[2,3] ^ tx)
tel


node clyde128 (state,key,tweak:u32x4) returns (cipher:u32x4)
vars
    rc:u32x4[12],
    round:u32x4[19],
    tk:u32x4[3]
let
    rc = ((1, 0, 0, 0),
          (0, 1, 0, 0),
          (0, 0, 1, 0),
          (0, 0, 0, 1),
          (1, 1, 0, 0),
          (0, 1, 1, 0),
          (0, 0, 1, 1),
          (1, 1, 0, 1),
          (1, 0, 1, 0),
          (0, 1, 0, 1),
          (1, 1, 1, 0),
          (0, 1, 1, 1));

    tk = tweakey(key,tweak);

    round[0] = state ^ tk[0];

    forall s in [0, 5] {
      round[s*3+1] = add_rc(lbox_layer(sbox(round[s*3])), rc[s*2]);
      round[s*3+2] = add_rc(lbox_layer(sbox(round[s*3+1])), rc[s*2+1]);
      round[s*3+3] = round[s*3+2] ^ tk[(s+1)%3];
    }

    cipher = round[18]

tel