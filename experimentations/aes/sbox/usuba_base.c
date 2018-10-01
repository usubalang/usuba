
#define usuba(v0,v1,v2,v3,v4,v5,v6,v7) {        \
    ShiftRows(v0,v1,v2,v3,v4,v5,v6,v7);         \
    SubBytes(v0,v1,v2,v3,v4,v5,v6,v7);          \
    MixColumn(v0,v1,v2,v3,v4,v5,v6,v7);         \
  }

#define ShiftRows(v0,v1,v2,v3,v4,v5,v6,v7) {                    \
    v0 = PERMUT_16(v0,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v1 = PERMUT_16(v1,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v2 = PERMUT_16(v2,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v3 = PERMUT_16(v3,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v4 = PERMUT_16(v4,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v5 = PERMUT_16(v5,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v6 = PERMUT_16(v6,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v7 = PERMUT_16(v7,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
  }

#define SubBytes(v0,v1,v2,v3,v4,v5,v6,v7) {     \
                                                \
    DATATYPE _tmp1_;                            \
    DATATYPE _tmp2_;                            \
    DATATYPE _tmp3_;                            \
    DATATYPE _tmp4_;                            \
    DATATYPE t0;                                \
    DATATYPE t1;                                \
    DATATYPE t10;                               \
    DATATYPE t11;                               \
    DATATYPE t12;                               \
    DATATYPE t13;                               \
    DATATYPE t14;                               \
    DATATYPE t15;                               \
    DATATYPE t16;                               \
    DATATYPE t17;                               \
    DATATYPE t18;                               \
    DATATYPE t19;                               \
    DATATYPE t2;                                \
    DATATYPE t20;                               \
    DATATYPE t21;                               \
    DATATYPE t22;                               \
    DATATYPE t23;                               \
    DATATYPE t24;                               \
    DATATYPE t25;                               \
    DATATYPE t26;                               \
    DATATYPE t27;                               \
    DATATYPE t28;                               \
    DATATYPE t29;                               \
    DATATYPE t3;                                \
    DATATYPE t30;                               \
    DATATYPE t31;                               \
    DATATYPE t32;                               \
    DATATYPE t33;                               \
    DATATYPE t34;                               \
    DATATYPE t35;                               \
    DATATYPE t36;                               \
    DATATYPE t37;                               \
    DATATYPE t38;                               \
    DATATYPE t39;                               \
    DATATYPE t4;                                \
    DATATYPE t40;                               \
    DATATYPE t41;                               \
    DATATYPE t42;                               \
    DATATYPE t43;                               \
    DATATYPE t44;                               \
    DATATYPE t45;                               \
    DATATYPE t5;                                \
    DATATYPE t6;                                \
    DATATYPE t7;                                \
    DATATYPE t8;                                \
    DATATYPE t9;                                \
    DATATYPE tc1;                               \
    DATATYPE tc10;                              \
    DATATYPE tc11;                              \
    DATATYPE tc12;                              \
    DATATYPE tc13;                              \
    DATATYPE tc14;                              \
    DATATYPE tc16;                              \
    DATATYPE tc17;                              \
    DATATYPE tc18;                              \
    DATATYPE tc2;                               \
    DATATYPE tc20;                              \
    DATATYPE tc21;                              \
    DATATYPE tc26;                              \
    DATATYPE tc3;                               \
    DATATYPE tc4;                               \
    DATATYPE tc5;                               \
    DATATYPE tc6;                               \
    DATATYPE tc7;                               \
    DATATYPE tc8;                               \
    DATATYPE tc9;                               \
    DATATYPE y1;                                \
    DATATYPE y10;                               \
    DATATYPE y11;                               \
    DATATYPE y12;                               \
    DATATYPE y13;                               \
    DATATYPE y14;                               \
    DATATYPE y15;                               \
    DATATYPE y16;                               \
    DATATYPE y17;                               \
    DATATYPE y18;                               \
    DATATYPE y19;                               \
    DATATYPE y2;                                \
    DATATYPE y20;                               \
    DATATYPE y21;                               \
    DATATYPE y3;                                \
    DATATYPE y4;                                \
    DATATYPE y5;                                \
    DATATYPE y6;                                \
    DATATYPE y7;                                \
    DATATYPE y8;                                \
    DATATYPE y9;                                \
    DATATYPE z0;                                \
    DATATYPE z1;                                \
    DATATYPE z10;                               \
    DATATYPE z11;                               \
    DATATYPE z12;                               \
    DATATYPE z13;                               \
    DATATYPE z14;                               \
    DATATYPE z15;                               \
    DATATYPE z16;                               \
    DATATYPE z17;                               \
    DATATYPE z2;                                \
    DATATYPE z3;                                \
    DATATYPE z4;                                \
    DATATYPE z5;                                \
    DATATYPE z6;                                \
    DATATYPE z7;                                \
    DATATYPE z8;                                \
    DATATYPE z9;                                \
                                                \
                                                \
    y14 = XOR(v3,v5);                           \
    y13 = XOR(v0,v6);                           \
    y9 = XOR(v0,v3);                            \
    y8 = XOR(v0,v5);                            \
    t0 = XOR(v1,v2);                            \
    y1 = XOR(t0,v7);                            \
    y4 = XOR(y1,v3);                            \
    y12 = XOR(y13,y14);                         \
    y2 = XOR(y1,v0);                            \
    y5 = XOR(y1,v6);                            \
    y3 = XOR(y5,y8);                            \
    t1 = XOR(v4,y12);                           \
    y15 = XOR(t1,v5);                           \
    y20 = XOR(t1,v1);                           \
    y6 = XOR(y15,v7);                           \
    y10 = XOR(y15,t0);                          \
    y11 = XOR(y20,y9);                          \
    y7 = XOR(v7,y11);                           \
    y17 = XOR(y10,y11);                         \
    y19 = XOR(y10,y8);                          \
    y16 = XOR(t0,y11);                          \
    y21 = XOR(y13,y16);                         \
    y18 = XOR(v0,y16);                          \
    t2 = AND(y12,y15);                          \
    t3 = AND(y3,y6);                            \
    t4 = XOR(t3,t2);                            \
    t5 = AND(y4,v7);                            \
    t6 = XOR(t5,t2);                            \
    t7 = AND(y13,y16);                          \
    t8 = AND(y5,y1);                            \
    t9 = XOR(t8,t7);                            \
    t10 = AND(y2,y7);                           \
    t11 = XOR(t10,t7);                          \
    t12 = AND(y9,y11);                          \
    t13 = AND(y14,y17);                         \
    t14 = XOR(t13,t12);                         \
    t15 = AND(y8,y10);                          \
    t16 = XOR(t15,t12);                         \
    t17 = XOR(t4,y20);                          \
    t18 = XOR(t6,t16);                          \
    t19 = XOR(t9,t14);                          \
    t20 = XOR(t11,t16);                         \
    t21 = XOR(t17,t14);                         \
    t22 = XOR(t18,y19);                         \
    t23 = XOR(t19,y21);                         \
    t24 = XOR(t20,y18);                         \
    t25 = XOR(t21,t22);                         \
    t26 = AND(t21,t23);                         \
    t27 = XOR(t24,t26);                         \
    t28 = AND(t25,t27);                         \
    t29 = XOR(t28,t22);                         \
    t30 = XOR(t23,t24);                         \
    t31 = XOR(t22,t26);                         \
    t32 = AND(t31,t30);                         \
    t33 = XOR(t32,t24);                         \
    t34 = XOR(t23,t33);                         \
    t35 = XOR(t27,t33);                         \
    t36 = AND(t24,t35);                         \
    t37 = XOR(t36,t34);                         \
    t38 = XOR(t27,t36);                         \
    t39 = AND(t29,t38);                         \
    t40 = XOR(t25,t39);                         \
    t41 = XOR(t40,t37);                         \
    t42 = XOR(t29,t33);                         \
    t43 = XOR(t29,t40);                         \
    t44 = XOR(t33,t37);                         \
    t45 = XOR(t42,t41);                         \
    z0 = AND(t44,y15);                          \
    z1 = AND(t37,y6);                           \
    z2 = AND(t33,v7);                           \
    z3 = AND(t43,y16);                          \
    z4 = AND(t40,y1);                           \
    z5 = AND(t29,y7);                           \
    z6 = AND(t42,y11);                          \
    z7 = AND(t45,y17);                          \
    z8 = AND(t41,y10);                          \
    z9 = AND(t44,y12);                          \
    z10 = AND(t37,y3);                          \
    z11 = AND(t33,y4);                          \
    z12 = AND(t43,y13);                         \
    z13 = AND(t40,y5);                          \
    z14 = AND(t29,y2);                          \
    z15 = AND(t42,y9);                          \
    z16 = AND(t45,y14);                         \
    z17 = AND(t41,y8);                          \
    tc1 = XOR(z15,z16);                         \
    tc2 = XOR(z10,tc1);                         \
    tc3 = XOR(z9,tc2);                          \
    tc4 = XOR(z0,z2);                           \
    tc5 = XOR(z1,z0);                           \
    tc6 = XOR(z3,z4);                           \
    tc7 = XOR(z12,tc4);                         \
    tc8 = XOR(z7,tc6);                          \
    tc9 = XOR(z8,tc7);                          \
    tc10 = XOR(tc8,tc9);                        \
    tc11 = XOR(tc6,tc5);                        \
    tc12 = XOR(z3,z5);                          \
    tc13 = XOR(z13,tc1);                        \
    tc14 = XOR(tc4,tc12);                       \
    v3 = XOR(tc3,tc11);                         \
    tc16 = XOR(z6,tc8);                         \
    tc17 = XOR(z14,tc10);                       \
    tc18 = XOR(tc13,tc14);                      \
    _tmp1_ = XOR(z12,tc18);                     \
    v7 = _tmp1_;                                \
    tc20 = XOR(z15,tc16);                       \
    tc21 = XOR(tc2,z11);                        \
    v0 = XOR(tc3,tc16);                         \
    _tmp2_ = XOR(tc10,tc18);                    \
    v6 = _tmp2_;                                \
    v4 = XOR(tc14,v3);                          \
    _tmp3_ = XOR(v3,tc16);                      \
    v1 = _tmp3_;                                \
    tc26 = XOR(tc17,tc20);                      \
    _tmp4_ = XOR(tc26,z17);                     \
    v2 = _tmp4_;                                \
    v5 = XOR(tc21,tc17);                        \
  }



#define MixColumn(v0,v1,v2,v3,v4,v5,v6,v7) {                            \
                                                                        \
    DATATYPE _tmp14_;                                                   \
    DATATYPE _tmp15_;                                                   \
    DATATYPE _tmp16_;                                                   \
    DATATYPE _tmp18_;                                                   \
    DATATYPE _tmp19_;                                                   \
    DATATYPE _tmp22_;                                                   \
    DATATYPE _tmp23_;                                                   \
    DATATYPE _tmp25_;                                                   \
    DATATYPE _tmp26_;                                                   \
    DATATYPE _tmp31_;                                                   \
    DATATYPE _tmp32_;                                                   \
    DATATYPE _tmp33_;                                                   \
    DATATYPE _tmp35_;                                                   \
    DATATYPE _tmp36_;                                                   \
    DATATYPE _tmp3_;                                                    \
    DATATYPE _tmp41_;                                                   \
    DATATYPE _tmp42_;                                                   \
    DATATYPE _tmp43_;                                                   \
    DATATYPE _tmp45_;                                                   \
    DATATYPE _tmp46_;                                                   \
    DATATYPE _tmp49_;                                                   \
    DATATYPE _tmp4_;                                                    \
    DATATYPE _tmp50_;                                                   \
    DATATYPE _tmp52_;                                                   \
    DATATYPE _tmp53_;                                                   \
    DATATYPE _tmp56_;                                                   \
    DATATYPE _tmp57_;                                                   \
    DATATYPE _tmp59_;                                                   \
    DATATYPE _tmp5_;                                                    \
    DATATYPE _tmp60_;                                                   \
    DATATYPE _tmp64_;                                                   \
    DATATYPE _tmp67_;                                                   \
    DATATYPE _tmp6_;                                                    \
    DATATYPE _tmp8_;                                                    \
    DATATYPE _tmp9_;                                                    \
                                                                        \
                                                                        \
    _tmp3_ = PERMUT_16( v0,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp5_ = PERMUT_16( v7,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp15_ = PERMUT_16(v6,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp22_ = PERMUT_16(v5,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp32_ = PERMUT_16(v4,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp42_ = PERMUT_16(v3,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp49_ = PERMUT_16(v2,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp56_ = PERMUT_16(v1,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp4_ = XOR(v0,_tmp3_);                                            \
    _tmp8_ = XOR(v7,_tmp5_);                                            \
    _tmp18_ = XOR(v6,_tmp15_);                                          \
    _tmp25_ = XOR(v5,_tmp22_);                                          \
    _tmp35_ = XOR(v4,_tmp32_);                                          \
    _tmp45_ = XOR(v3,_tmp42_);                                          \
    _tmp52_ = XOR(v2,_tmp49_);                                          \
    _tmp59_ = XOR(v1,_tmp56_);                                          \
    _tmp67_ = PERMUT_16(_tmp4_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);  \
    _tmp6_ = XOR(_tmp4_,_tmp5_);                                        \
    _tmp9_ = PERMUT_16(_tmp8_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);   \
    _tmp14_ = XOR(_tmp8_,_tmp4_);                                       \
    _tmp19_ = PERMUT_16(_tmp18_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    _tmp23_ = XOR(_tmp18_,_tmp22_);                                     \
    _tmp26_ = PERMUT_16(_tmp25_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    _tmp31_ = XOR(_tmp25_,_tmp4_);                                      \
    _tmp36_ = PERMUT_16(_tmp35_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    _tmp41_ = XOR(_tmp35_,_tmp4_);                                      \
    _tmp46_ = PERMUT_16(_tmp45_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    _tmp50_ = XOR(_tmp45_,_tmp49_);                                     \
    _tmp53_ = PERMUT_16(_tmp52_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    _tmp57_ = XOR(_tmp52_,_tmp56_);                                     \
    _tmp60_ = PERMUT_16(_tmp59_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    _tmp64_ = XOR(_tmp59_,_tmp3_);                                      \
    v7 = XOR(_tmp6_,_tmp9_);                                            \
    _tmp16_ = XOR(_tmp14_,_tmp15_);                                     \
    v5 = XOR(_tmp23_,_tmp26_);                                          \
    _tmp33_ = XOR(_tmp31_,_tmp32_);                                     \
    _tmp43_ = XOR(_tmp41_,_tmp42_);                                     \
    v2 = XOR(_tmp50_,_tmp53_);                                          \
    v1 = XOR(_tmp57_,_tmp60_);                                          \
    v0 = XOR(_tmp64_,_tmp67_);                                          \
    v6 = XOR(_tmp16_,_tmp19_);                                          \
    v4 = XOR(_tmp33_,_tmp36_);                                          \
    v3 = XOR(_tmp43_,_tmp46_);                                          \
                                                                        \
  }
