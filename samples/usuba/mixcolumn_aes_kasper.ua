perm RL32 (input:u16x1) returns (out:u16x1) {
     1,2,3,0
}

perm RL64 (input:u16x1) returns (out:u16x1) {
      2,3,0,1
}

# Note: the 7-x are due to the fact that Kasper & Schwabe don't index their array
# the same way we do.
node MixColumn (a:u16x8) returns (b:u16x8)
vars
let
    b[7-0] = (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-0])) ^ RL64(a[7-0] ^ (RL32(a[7-0])));
    b[7-1] = (a[7-0] ^ (RL32(a[7-0]))) ^ (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-1])) ^ RL64(a[7-1] ^ (RL32(a[7-1])));
    b[7-2] = (a[7-1] ^ (RL32(a[7-1]))) ^ (RL32(a[7-2])) ^ RL64(a[7-2] ^ (RL32(a[7-2])));
    b[7-3] = (a[7-2] ^ (RL32(a[7-2]))) ^ (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-3])) ^ RL64(a[7-3] ^ (RL32(a[7-3])));
    b[7-4] = (a[7-3] ^ (RL32(a[7-3]))) ^ (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-4])) ^ RL64(a[7-4] ^ (RL32(a[7-4])));
    b[7-5] = (a[7-4] ^ (RL32(a[7-4]))) ^ (RL32(a[7-5])) ^ RL64(a[7-5] ^ (RL32(a[7-5])));
    b[7-6] = (a[7-5] ^ (RL32(a[7-5]))) ^ (RL32(a[7-6])) ^ RL64(a[7-6] ^ (RL32(a[7-6])));
    b[7-7] = (a[7-6] ^ (RL32(a[7-6]))) ^ (RL32(a[7-7])) ^ RL64(a[7-7] ^ (RL32(a[7-7])))
tel