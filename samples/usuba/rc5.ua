# Specification: https://tools.ietf.org/html/rfc2040

# Can't work because of the dynamic rotate.

# A full adder
node add (a:bool,b:bool,cin:bool)
     returns (r:bool,cout:bool)
vars
let
    r = a ^ b ^ cin;
    cout = (a & b) | (cin & (a ^ b))
tel


node add32 (a:u32,b:u32) returns (r:bool[32])
vars
    c:bool[33]
let
    c[0] = 0;

    forall i in [0,31] {
      (r[i],c[i+1]) = add(a[i],b[i],c[i])
    }
tel


node rc5 (plaintext:u64, key:u32[26])
     returns (ciphertext:u64)
vars
    Ainit : u32,
    Binit : u32,
    A : u32[13],
    B : u32[13]
let

    (Ainit, Binit) = plaintext;
    A[0] = add32(Ainit,key[0]);
    B[0] = add32(Binit,key[1]);

    forall i in [1, 12] {
        # This dynamic rotate won't work for now.
        A[i] = add32((A[i-1] ^ B[i-1]) <<< B[i-1], key[i*2]);
        B[i] = add32((B[i-1] ^ A[i]) <<< A[i], key[i*2+1]);
    }

    ciphertext = (A[12], B[12]);
tel