node sbox (x0:v1, x1:v1, x2:v1, x3:v1)
     returns (y0:v1, y1:v1, y2:v1, y3:v1)
let
    y1 = (x0 & x1) ^ x2;
    y0 = (x3 & x0) ^ x1;
    y3 = (y1 & x3) ^ x0;
    y2 = (y0 & y1) ^ x3
tel
