# Specification: https://www.ecrypt.eu.org/stream/p3ciphers/trivium/trivium_p3.pdf

#pragma vectorization

_no_inline node S1 (s11 : u64, s12 : u64, i : nat)
     returns (r:u64)
let
    r = (s11 << (i-64)) | (s12 >> (128-i))
tel

_no_inline node S2 (s21 :u64, s22 : u64, i : nat)
     returns (r:u64)
let
    r = (s21 << (i-157)) | (s22 >> (221-i))
tel

_no_inline node S3 (s31 : u64, s32 : u64, i : nat)
     returns (r:u64)
let
    r = (s31 << (i-241)) | (s32 >> (305-i))
tel

node Trivium (state:u64x6) 
     returns (state':u64x6, z : u64)
vars
    s11 : u64, s12 : u64, s21 : u64, s22 : u64, s31 : u64, s32 : u64,
    s11' : u64, s21' : u64, s31' : u64, 
    t1 : u64,t2 : u64,t3 : u64
let

    (s11,s12,s21,s22,s31,s32) = state;

    t1 = S1(s11,s12,66) ^ S1(s11,s12,93);
    t2 = S2(s21,s22,162) ^ S2(s21,s22,177);
    t3 = S3(s31,s32,243) ^ S3(s31,s32,288);

    z = t1 ^ t2 ^ t3;

    s21' = t1 ^ S1(s11,s12,91) & S1(s11,s12,92) ^ S2(s21,s22,171);
    s31' = t2 ^ S2(s21,s22,175) ^ S2(s21,s22,176) ^ S3(s31,s32,264);
    s11' = t3 ^ S3(s31,s32,286) ^ S3(s31,s32,287) ^ S1(s11,s12,69);

    
    state'[1] = state[0];
    state'[0] = s11';
    state'[3] = state[2];
    state'[2] = s21';
    state'[5] = state[4];
    state'[4] = s31'

tel