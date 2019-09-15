table SubBytes (i:v4) returns (o:v4) {
  0x2, 0xd, 0x3, 0x9, 0x7, 0xb, 0xa, 0x6, 0xe, 0x0, 0xf, 0x4, 0x8, 0x5, 0x1, 0xc
}

node AddRoundKey (i,k:u32x4) returns (o:u32x4)
let
    o = i ^ k
tel

node mat_mult(col,vec:u32) returns (res:u32)
vars
    mat_col:u32[33],
    res_tmp:u32[33],
    mask:u32[32]
let
    mat_col[0] = col;
    res_tmp[0] = 0;

    forall i in [0, 31] {
        mask[i] = (vec << i) >>! 31;
        res_tmp[i+1] = res_tmp[i] ^ (mask[i] & mat_col[i]);
        mat_col[i+1] = mat_col[i] >>> 1;
    }

    res = res_tmp[32];
tel

node MixRows (input:u32x4) returns (output:u32x4)
vars
    M: u32[4]
let
    M = (0xa3861085, 0x63417021, 0x692cf280, 0x48a54813);
    forall i in [0, 3] {
        output[i] = mat_mult(M[i], input[i]);
    }
tel

node pyjamask (plaintext:u32x4, key:u32x4[15]) returns (ciphertext:u32x4)
vars
    round: u32x4[15]
let
    round[0] = plaintext;
    forall i in [0, 13] {
        round[i+1] = MixRows(SubBytes(AddRoundKey(round[i], key[i])))
    }
    ciphertext = AddRoundKey(round[14], key[14])
tel
