# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/subterranean-spec-round2.pdf
# Supported mode: ???

# XXX: this is an example of cipher where pretty every equation should
# turn into an in-place update
# XXX: similarly, loops ought to turn into updates with temps

node chi(state:b257) returns (stateR:b257)
let
    forall i in [0, 254] {
        stateR[i] = state[i] ^ ((1 ^ state[i+1]) & state[i+2]);
    }
    stateR[255] = state[255] ^ ((1 ^ state[256]) & state[0]);
    stateR[256] = state[256] ^ ((1 ^ state[0]) & state[1]);
tel

node iota(state:b257) returns (stateR:b257)
let
    # XXX: want to only write `state[0] <- state[0] ^ 1` here
    stateR[0] = state[0] ^ 1;
    forall i in [1, 256] { stateR[i] = state[i] }
tel

node theta(state:b257) returns (stateR:b257)
let
    forall i in [0, 256] {
        # XXX: in-place update will certainly require a few temp vars here
        stateR[i] = state[i] ^ state[(i+3)%257] ^ state[(i+8)%257]
    }
tel

perm phi(state:b257) returns (stateR:b257) {
      1,  13,  25,  37,  49,  61,  73,  85,  97, 109, 121, 133, 145, 157, 169, 181,
    193, 205, 217, 229, 241, 253,   8,  20,  32,  44,  56,  68,  80,  92, 104, 116,
    128, 140, 152, 164, 176, 188, 200, 212, 224, 236, 248, 3, 15, 27, 39,  51,  63,
     75,  87,  99, 111, 123, 135, 147, 159, 171, 183, 195, 207, 219, 231, 243, 255,
      10,  22,  34,  46,  58,  70,  82,  94, 106, 118, 130, 142, 154, 166, 178, 190,
    202, 214, 226, 238, 250,   5,  17,  29,  41,  53,  65,  77,  89, 101, 113, 125,
    137, 149, 161, 173, 185, 197, 209, 221, 233, 245, 257,  12,  24,  36,  48,  60,
     72,  84,  96, 108, 120, 132, 144, 156, 168, 180, 192, 204, 216, 228, 240, 252,
      7,  19,  31,  43,  55,  67,  79,  91, 103, 115, 127, 139, 151, 163, 175, 187,
    199, 211, 223, 235, 247,   2,  14,  26,  38,  50,  62,  74,  86,  98, 110, 122,
    134, 146, 158, 170, 182, 194, 206, 218, 230, 242, 254,   9,  21,  33,  45,  57,
     69,  81,  93, 105, 117, 129, 141, 153, 165, 177, 189, 201, 213, 225, 237, 249,
      4,  16,  28,  40,  52,  64,  76,  88,  100, 112, 124, 136, 148, 160, 172, 184,
    196, 208, 220, 232, 244, 256,  11,  23,  35,  47,  59,  71,  83,  95, 107, 119,
    131, 143, 155, 167, 179, 191, 203, 215, 227, 239, 251,   6,  18,  30,  42,  54,
     66,  78,  90, 102, 114, 126, 138, 150, 162, 174, 186, 198, 210, 222, 234, 246
}


node round(state:b257) returns (stateR:b257)
let
    # phi is not in-place
    stateR = phi(theta(iota(chi(state))))
tel

node xor1(state:b257) returns (stateR:b257)
let
    # XXX: want to only write `state[1] <- state[1] ^ 1` here
    stateR[0] = state[0];
    stateR[1] = state[1] ^ 1;
    forall i in [2, 256] { stateR[i] = state[i] }
tel

node blank(state:b257) returns (stateR:b257)
vars tmp:b257[9]
let
    tmp[0] = state;
    forall i in [0, 7] { tmp[i+1] = xor1(round(tmp[i])); }
    stateR = tmp[8];
tel