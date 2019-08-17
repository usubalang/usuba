node sbox_calc(a:b8) returns (b:b8)
let
    b = (a[0], a[1], a[2], a[3] ^ ~(a[0] | a[1]),
         a[4], a[5], a[6], a[7] ^ ~(a[4] | a[5]))
tel

perm sbox_perm(a:b8) returns (b:b8) {
     6, 7, 1, 2, 4, 8, 5, 3
}

perm sbox_last_perm(a:b8) returns (b:b8) {
     1, 2, 3, 4, 5, 7, 6, 8
}

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
