node sbox_calc(a:b8) returns (b:b8)
let
    b[0..7] = (a[0], a[1], a[2], a[3] ^ ~(a[0] | a[1]),
               a[4], a[5], a[6], a[7] ^ ~(a[4] | a[5]))
tel

node sbox_perm(a:b8) returns (b:b8)
let
    b[0..7] = a[5, 6, 0, 1, 3, 7, 4, 2]
tel

node sbox_last_perm(a:b8) returns (b:b8)
let
    b[0..7] = a[0, 2, 1, 3, 4, 6, 5, 7]
tel

node sbox_quarter(a:b8) returns (b:b8)
let
    b = sbox_perm(sbox_calc(a))
tel

node sbox_last_quarter(a:b8) returns (b:b8)
let
    b = sbox_last_perm(sbox_calc(a))
tel

node sbox(a:b8) returns (b:b8)
let
    b = sbox_last_quarter(sbox_quarter(sbox_quarter(sbox_quarter(a))))
tel
