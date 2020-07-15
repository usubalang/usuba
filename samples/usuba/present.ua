# Specification: http://www.lightweightcrypto.org/present/ches2007.pdf
# Supported mode: ???

table sbox : v4 -> v4 {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

// Warning: 1-indexed
perm pLayer : b64 -> b64 {
      1,  5,  9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61,
      2,  6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62,
      3,  7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63,
      4,  8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64
}

_no_inline node round (*inp:b64, key:b64)
vars
    tmp  : b4[16],
let
    tmp = inp ^ key;
    # XXX: lifting b4 -> b4[16] of sbox
    forall i in [0, 15] { tmp[i] := sbox(tmp[i]) }
    inp := pLayer(tmp)
tel

node present (plain:b64, key:b64[32]) returns (cipher:b64)
vars
    state : b64
let
    forall i in [0, 31] {
    i = 0: state = plain;
    _    : state := round(state, key[i-1])
    }
    cipher = state ^ key[31]
tel