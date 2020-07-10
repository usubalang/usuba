# Bitsliced version, with key-schedule
# Specification: https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197.pdf

# XXX: this should just `include aes.ua`

# XXX: BEGIN REDUNDANT

table SubBytes_single (input:v8) returns (output:v8) {
    99, 124, 119, 123, 242, 107, 111, 197, 48, 1, 103, 43, 254, 215, 171, 118,
    202, 130, 201, 125, 250, 89, 71, 240, 173, 212, 162, 175, 156, 164, 114, 192,
    183, 253, 147, 38, 54, 63, 247, 204, 52, 165, 229, 241, 113, 216, 49, 21,
    4, 199, 35, 195, 24, 150, 5, 154, 7, 18, 128, 226, 235, 39, 178, 117,
    9, 131, 44, 26, 27, 110, 90, 160, 82, 59, 214, 179, 41, 227, 47, 132,
    83, 209, 0, 237, 32, 252, 177, 91, 106, 203, 190, 57, 74, 76, 88, 207,
    208, 239, 170, 251, 67, 77, 51, 133, 69, 249, 2, 127, 80, 60, 159, 168,
    81, 163, 64, 143, 146, 157, 56, 245, 188, 182, 218, 33, 16, 255, 243, 210,
    205, 12, 19, 236, 95, 151, 68, 23, 196, 167, 126, 61, 100, 93, 25, 115,
    96, 129, 79, 220, 34, 42, 144, 136, 70, 238, 184, 20, 222, 94, 11, 219,
    224, 50, 58, 10, 73, 6, 36, 92, 194, 211, 172, 98, 145, 149, 228, 121,
    231, 200, 55, 109, 141, 213, 78, 169, 108, 86, 244, 234, 101, 122, 174, 8,
    186, 120, 37, 46, 28, 166, 180, 198, 232, 221, 116, 31, 75, 189, 139, 138,
    112, 62, 181, 102, 72, 3, 246, 14, 97, 53, 87, 185, 134, 193, 29, 158,
    225, 248, 152, 17, 105, 217, 142, 148, 155, 30, 135, 233, 206, 85, 40, 223,
    140, 161, 137, 13, 191, 230, 66, 104, 65, 153, 45, 15, 176, 84, 187, 22
}

node SubBytes (inputSB:b8[16]) returns (out:b8[16])
let
    forall i in [0,15] {
      out[i] = SubBytes_single(inputSB[i])
    }
tel

node ShiftRows (inputSR:b8[16]) returns (output:b1[128])
let
    output = inputSR[0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]
tel

node times2 (i:b1[8]) returns (o:b1[8])
let
    o = (i << 1) ^ (0,0,0,i[0],i[0],0,i[0],i[0])
tel

node times3 (i:b1[8]) returns (o:b1[8])
let
    o = times2(i) ^ i
tel

node MixColumn_single (inp:b8[4]) returns (out:b8[4])
let
    out[0] = times2(inp[0]) ^ times3(inp[1]) ^ inp[2] ^ inp[3];
    out[1] = inp[0] ^ times2(inp[1]) ^ times3(inp[2]) ^ inp[3];
    out[2] = inp[0] ^ inp[1] ^ times2(inp[2]) ^ times3(inp[3]);
    out[3] = times3(inp[0]) ^ inp[1] ^ inp[2] ^ times2(inp[3])
tel

node MixColumn (inp:b32[4]) returns (out:b32[4])
let
    forall i in [0,3] {
       out[i] = MixColumn_single(inp[i])
    }
tel

# XXX: END REDUNDANT

node sched_core (key:b8[4], rcon:b8) returns (subkey:b8[4])
vars
    tmp:b8[4]
let
    forall i in [0,3] {
      tmp[i] = SubBytes_single(key[(i+1)%4])
    }
    subkey[0] = tmp[0] ^ rcon;
    subkey[1 .. 3] = tmp[1 .. 3];
tel


_no_inline node key_sched (key:b128) returns (subkeys:b32[11][4])
vars
    rcon : b8[10],
    tmp : b32[11]
let
    rcon = ((0,0,0,0,0,0,0,1),
            (0,0,0,0,0,0,1,0),
            (0,0,0,0,0,1,0,0),
            (0,0,0,0,1,0,0,0),
            (0,0,0,1,0,0,0,0),
            (0,0,1,0,0,0,0,0),
            (0,1,0,0,0,0,0,0),
            (1,0,0,0,0,0,0,0),
            (0,0,0,1,1,0,1,1),
            (0,0,1,1,0,1,1,0));

    # Initial AddRoundKey
    subkeys[0] = key;

    forall i in [1, 10] {
        tmp[i-1] = sched_core(subkeys[i-1][3], rcon[i-1]);
        subkeys[i][0] = tmp[i-1] ^ subkeys[i-1][0];
        forall j in [1, 3] {
            subkeys[i][j] = subkeys[i-1][j] ^ subkeys[i][j-1];
        }
    }
tel

node AddRoundKey(i:b128,key:b128) returns (r:b128)
let
    r = i ^ key
tel

# XXX: replace with a node that calls `AES` from `aes.ua` with the output of `key_sched`
node AES (plain:b128,key:b128) returns (cipher:b1[128])
vars
    tmp : b128[10],
    subkeys : b32[11][4]
let
    subkeys = key_sched(key);

    # Initial AddRoundKey
    tmp[0] = AddRoundKey(plain, subkeys[0]);

    # 9 rounds (the last is special)
    forall i in [1,9] {
      tmp[i] = AddRoundKey(MixColumn( ShiftRows( SubBytes( tmp[i-1] ) ) ), subkeys[i])
    }

    # Last (10th) round (no MixColumn)
    cipher = AddRoundKey(ShiftRows(SubBytes(tmp[9])), subkeys[10])
tel

