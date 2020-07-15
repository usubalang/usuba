# Specification: https://csrc.nist.gov/CSRC/media/Projects/Lightweight-Cryptography/documents/round-1/spec-doc/Spook-spec.pdf
# Supported mode: bitslicing, v-slicing, (h-slicing?)

# XXX: annoying redundancy between sbox and sbox_R, both used
node sbox (x0:v1, x1:v1, x2:v1, x3:v1) returns (y0:v1, y1:v1, y2:v1, y3:v1)
let
    y1 = (x0 & x1) ^ x2;
    y0 = (x3 & x0) ^ x1;
    y3 = (y1 & x3) ^ x0;
    y2 = (y0 & y1) ^ x3
tel

node sbox_R (x0:v1, x1:v1, x2:v1, x3:v1) returns (y0:v1, y1:v1, y2:v1, y3:v1)
vars
    y1_R:v1
let
    y1 = (x0 & x1) ^ x2;
    y1_R = refresh(y1);
    y0 = (x3 & x0) ^ x1;
    y3 = (y1_R & x3) ^ x0;
    y2 = (y0 & y1_R) ^ x3
tel

node lbox(*x,*y:u32)
vars
    a, b, c, d: u32
let
    # XXX: subtle alternation between `=` and `:=`: too subtle?
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
    (x, y) := (a,b)
tel

node lbox_layer(*state:u32x4)
let
    state := (lbox(state[0], state[1]),
              lbox(state[2], state[3]))
tel

node add_rc(*state:u32x4, rc:u32x4)
let
    state := state ^ rc
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


node clyde128 (plain,key,tweak:u32x4) returns (cipher:u32x4)
vars
    rc:u32x4[12],
    state:u32x4[19],
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

    forall s in [0, 5] {
      s = 0: state = plain ^ tk[0];
      _    : forall rho in [0, 1] {
              rho = 0: state := add_rc(lbox_layer(sbox_R(state)), rc[2*s + rho]);
              rho = 1: state := add_rc(lbox_layer(sbox(state)), rc[2*s + rho]);
             }
             state := state ^ tk[(s + 1) % 3];
    }

    cipher = state
tel