table sbox (x:v4) returns (y:v4) {
      0, 8, 1, 15, 2, 10, 7, 9, 4, 13, 5, 6, 14, 3, 11, 12
}

_no_inline node sbox_layer (x:v4) returns (y:v4)
let
    y = sbox(x)
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

_no_inline node lbox_layer(state:u32x4) returns (stateR:u32x4)
let
    stateR[0,1] = lbox(state[0], state[1]);
    stateR[2,3] = lbox(state[2], state[3])
tel

_no_inline node add_rc(state:u32x4, rc:u32x4) returns (stateR:u32x4)
let
    forall i in [0, 3] {
        stateR[i] = state[i] ^ rc[i]
    }
tel

_no_inline node tweakey (key,tweak:u32x4) returns (tk:u32x4[3])
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
    rc[0]  = (1, 0, 0, 0);
    rc[1]  = (0, 1, 0, 0);
    rc[2]  = (0, 0, 1, 0);
    rc[3]  = (0, 0, 0, 1);
    rc[4]  = (1, 1, 0, 0);
    rc[5]  = (0, 1, 1, 0);
    rc[6]  = (0, 0, 1, 1);
    rc[7]  = (1, 1, 0, 1);
    rc[8]  = (1, 0, 1, 0);
    rc[9]  = (0, 1, 0, 1);
    rc[10] = (1, 1, 1, 0);
    rc[11] = (0, 1, 1, 1);

    tk = tweakey(key,tweak);

    round[0] = state ^ tk[0];

    forall s in [0, 5] {
      forall rho in [0, 1] {
        round[s*3+rho+1] = add_rc(lbox_layer(sbox_layer(round[s*3+rho])), rc[s*2+rho])
      }
      round[(s+1)*3] = round[s*3+2] ^ tk[(s+1)%3]
    }

    cipher = round[18]

tel