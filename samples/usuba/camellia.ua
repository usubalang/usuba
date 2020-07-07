# Specification: https://info.isl.ntt.co.jp/crypt/eng/camellia/dl/01espec.pdf
# Misc.:
#   https://info.isl.ntt.co.jp/crypt/eng/camellia/

_no_inline table SBOX1 (a:u8) returns (b:u8) {
 112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12, 174,  65,
  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,  29, 101, 146, 189,
 134, 184, 175, 143, 124, 235,  31, 206,  62,  48, 220,  95,  94, 197,  11,  26,
 166, 225,  57, 202, 213,  71,  93,  61, 217,   1,  90, 214,  81,  86, 108,  77,
 139,  13, 154, 102, 251, 204, 176,  45, 116,  18,  43,  32, 240, 177, 132, 153,
 223,  76, 203, 194,  52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215,
  20,  88,  58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34,
 254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252, 105,  80,
 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149, 224, 255, 100, 210,
  16, 196,   0,  72, 163, 247, 117, 219, 138,   3, 230, 218,   9,  63, 221, 148,
 135,  92, 131,   2, 205,  74, 144,  51, 115, 103, 246, 243, 157, 127, 191, 226,
  82, 155, 216,  38, 200,  55, 198,  59, 129, 150, 111,  75,  19, 190,  99,  46,
 233, 121, 167, 140, 159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89,
 120, 152,   6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250,
 114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56, 241, 164,
  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244, 119, 199, 128, 158
}


node[] SBOX (a:u8) returns (b:u8) [
let b = SBOX1(a) tel;
let b = SBOX1(a) <<< 1 tel;
let b = SBOX1(a) <<< 7 tel;
let b = SBOX1(a <<< 1) tel
]


node FLINV (f_in:u64,key:u64) returns (f_out:u64)
vars
    y1:u32, y2:u32,
    k1:u32, k2:u32
let
    (y1,y2) = f_in;
    (k1,k2) = key;

    f_out = (y1 ^ (y2 | k2), y2 ^ ((y1 & k1) <<< 1))
tel


node FL (f_in:u64,key:u64) returns (f_out:u64)
vars
    x1:u32, x2:u32,
    k1:u32, k2:u32
let
    (x1,x2) = f_in;
    (k1,k2) = key;

    f_out = (x2 ^ ((x1 & k1) <<< 1), x1 ^ (x2 | k2))
tel

node F (f_in:u64,key:u64) returns (f_out:u64)
vars
    t_in:u8[8],
    t_out:u8[8],
    y:u8[8]
let
    t_in = f_in ^ key;

    forall i in [0,3] { t_out[i] = SBOX<i>(t_in[i]) }
    t_out[4] = SBOX<1>(t_in[4]);
    t_out[5] = SBOX<2>(t_in[5]);
    t_out[6] = SBOX<3>(t_in[6]);
    t_out[7] = SBOX<0>(t_in[7]);

    y[0] = t_out[0] ^ t_out[2] ^ t_out[3] ^ t_out[5] ^ t_out[6] ^ t_out[7];
    y[1] = t_out[0] ^ t_out[1] ^ t_out[3] ^ t_out[4] ^ t_out[6] ^ t_out[7];
    y[2] = t_out[0] ^ t_out[1] ^ t_out[2] ^ t_out[4] ^ t_out[5] ^ t_out[7];
    y[3] = t_out[1] ^ t_out[2] ^ t_out[3] ^ t_out[4] ^ t_out[5] ^ t_out[6];
    y[4] = t_out[0] ^ t_out[1] ^ t_out[5] ^ t_out[6] ^ t_out[7];
    y[5] = t_out[1] ^ t_out[2] ^ t_out[4] ^ t_out[6] ^ t_out[7];
    y[6] = t_out[2] ^ t_out[3] ^ t_out[4] ^ t_out[5] ^ t_out[7];
    y[7] = t_out[0] ^ t_out[3] ^ t_out[4] ^ t_out[5] ^ t_out[6];

    f_out = y
tel

node camellia (plaintext:u128, kw:u64[4], k:u64[18], ke:u64[4])
     returns (ciphertext:u128)
vars
    D1 : u64[12],
    D2 : u64[12]
let
   (D1[0],D2[0]) = plaintext ^ kw[0,1];

   forall i in [0,2] {
     D2[i+1] = D2[i] ^ F(D1[i],k[i*2]);
     D1[i+1] = D1[i] ^ F(D2[i+1],k[i*2+1])
   }

   D1[4] = FL(D1[3],ke[0]);
   D2[4] = FLINV(D2[3],ke[1]);

   forall i in [4,6] {
     D2[i+1] = D2[i] ^ F(D1[i],k[(i-1)*2]);
     D1[i+1] = D1[i] ^ F(D2[i+1],k[(i-1)*2+1])
   }

   D1[8] = FL(D1[7],ke[2]);
   D2[8] = FLINV(D2[7],ke[3]);

   forall i in [8,10] {
     D2[i+1] = D2[i] ^ F(D1[i],k[(i-2)*2]);
     D1[i+1] = D1[i] ^ F(D2[i+1],k[(i-2)*2+1])
   }

   ciphertext = (D2[11], D1[11]) ^ kw[2,3]
tel