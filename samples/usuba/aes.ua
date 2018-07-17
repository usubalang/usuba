#pragma bitslicing

_no_inline table SubBytes_single (input:u8) returns (output:u8) {
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

node SubBytes (inputSB:u8[16]) returns (out:u8[16])
vars
let
    forall i in [0,15] {
      out[i] = SubBytes_single(inputSB[i])
    }
tel

node ShiftRows (inputSR:u8[16]) returns (output:bool[128])
vars
let
    output = inputSR[0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]
tel

node times2 (i:bool[8]) returns (o:bool[8])
vars
let
    o = (i << 1) ^ (0,0,0,i[0],i[0],0,i[0],i[0])
tel

node times3 (i:bool[8]) returns (o:bool[8])
vars
let
    o = times2(i) ^ i
tel

node MixColumn_single (inp:u8[4]) returns (out:u8[4])
vars
let
    out[0] = times2(inp[0]) ^ times3(inp[1]) ^ inp[2] ^ inp[3];
    out[1] = inp[0] ^ times2(inp[1]) ^ times3(inp[2]) ^ inp[3];
    out[2] = inp[0] ^ inp[1] ^ times2(inp[2]) ^ times3(inp[3]);
    out[3] = times3(inp[0]) ^ inp[1] ^ inp[2] ^ times2(inp[3])
tel

node MixColumn (inp:u32[4]) returns (out:u32[4])
vars
let
    forall i in [0,3] {
       out[i] = MixColumn_single(inp[i])
    }
tel


node AES (plain:u128,key:u128[11]) returns (cipher:bool[128])
vars
    tmp : u128[10]
let
    # Initial AddRoundKey
    tmp[0] = plain ^ key[0];

    # 9 rounds (the last is special)
    forall i in [1,9] {
      tmp[i] = MixColumn( ShiftRows( SubBytes( tmp[i-1] ) ) ) ^ key[i]
    }

    # Last (10th) round (no MixColumn)
    cipher = ShiftRows(SubBytes(tmp[9])) ^ key[10]

tel