# Bitsliced version
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/pyjamask-spec-round2.pdf

# We use a different source for pyjamask bitslice and vslice because
# col_mult in Vslicing uses an arithmetic shift to convert a bit into
# a register full of this bit. This is not doable, nor needed in
# bitslicing.

table SubBytes : b4 -> b4 {
  0x2, 0xd, 0x3, 0x9, 0x7, 0xb, 0xa, 0x6, 0xe, 0x0, 0xf, 0x4, 0x8, 0x5, 0x1, 0xc
}

node AddRoundKey (*i,k:b128)
let
    i ^:= k
tel

node SubBytesAll (*input:b32[4])
let
    # XXX: lift of SybBytes from b4 to b32[4] (NON-TRIVIAL!)
    forall i in [0, 31] {
       input[0..3][i] := SubBytes(input[0..3][i])
    }
tel

node col_mult (a:b32,b:b32) returns (r:b1)
vars
    acc:b1
let
    forall i in [0,31] {
     i = 0: acc = a[0] & b[0];
     _    : acc := acc ^ (a[i] & b[i])
    }
    r = acc
tel

node MixRows (*input:b32[4])
vars
    M: b32[4]
let
    # Manually unrolling the loop over M so that M can be partially linearized away...
    # XXX: ie. all that to get in-place update

    M = (0xa3861085, 0x63417021, 0x692cf280, 0x48a54813);

    forall i in [0, 3]{
      forall idx in [0,31] {
        input[i][idx] := col_mult(input[i], M[i]);
        M[i] >>>:= 1
      }
    }
tel

node pyjamask (plaintext:b32[4], key:b32[15][4]) returns (ciphertext:b32[4])
vars
    state: b32[4]
let
    forall i in [0, 16] {
      i = 0:  state = plaintext;
      _    :  state := AddStateKey(state, key[i])
              _     : state := MixRows(SubBytesAll(state))
              i = 16: ciphertext = state
    }
tel
