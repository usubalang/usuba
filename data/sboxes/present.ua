node sbox (X0, X1, X2, X3 : v1)
     returns (Y0, Y1, Y2, Y3 : v1)
vars
    T1, T2, T3, T4, T5, T6, T7, T8, T9 : v1
let    
  T1 = X1 ^ X2;
  T2 = X2 & T1;
  T3 = X3 ^ T2;
  Y0 = X0 ^ T3;
  T4 = T1 & T3;
  T5 = T1 ^ Y0;
  T6 = T4 ^ X2;
  T7 = X0 | T6;
  Y1 = T5 ^ T7;
  T8 = T6 ^ ~X0;
  Y3 = Y1 ^ T8;
  T9 = T8 | T5;
  Y2 = T3 ^ T8
tel