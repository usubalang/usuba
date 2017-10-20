node lshift2 (input:u6) returns (out:u6)
vars
let
    out = input << 2
tel

node lrotate3 (input:u6) returns (out:u6)
vars
let
    out = input <<< 3
tel

node rshift4 (input:u6) returns (out:u6)
vars
let
    out = input >> 4
tel

node rrotate1 (input:u6) returns (out:u6)
vars
let
    out = input >>> 1
tel