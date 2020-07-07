# node sbox (xmm7:v1, xmm6:v1, xmm5:v1, xmm4:v1,
#            xmm3:v1, xmm2:v1, xmm1:v1, xmm0:v1)
#      returns  (S7:v1, S6:v1, S5:v1, S4:v1, S3:v1, S2:v1, S1:v1, S0:v1)
# vars
#     xmm8:v1,xmm9:v1,xmm10:v1,xmm11:v1,xmm12:v1,xmm13:v1,xmm14:v1,xmm15:v1,
#     xmm16:v1,xmm17:v1,xmm18:v1,xmm19:v1,xmm20:v1,xmm21:v1,xmm22:v1,xmm23:v1,
#     xmm24:v1,xmm25:v1,xmm26:v1,xmm27:v1,xmm28:v1,xmm29:v1,xmm30:v1,xmm31:v1,
#     xmm32:v1,xmm33:v1,xmm34:v1,xmm35:v1,xmm36:v1,xmm37:v1,xmm38:v1,xmm39:v1,
#     xmm40:v1,xmm41:v1,xmm42:v1,xmm43:v1,xmm44:v1,xmm45:v1,xmm46:v1,xmm47:v1,
#     xmm48:v1,xmm49:v1,xmm50:v1,xmm51:v1,xmm52:v1,xmm53:v1,xmm54:v1,xmm55:v1,
#     xmm56:v1,xmm57:v1,xmm58:v1,xmm59:v1,xmm60:v1,xmm61:v1,xmm62:v1,xmm63:v1,
#     xmm64:v1,xmm65:v1,xmm66:v1,xmm67:v1,xmm68:v1,xmm69:v1,xmm70:v1,xmm71:v1,
#     xmm72:v1,xmm73:v1,xmm74:v1,xmm75:v1,xmm76:v1,xmm77:v1,xmm78:v1,xmm79:v1,
#     xmm80:v1,xmm81:v1,xmm82:v1,xmm83:v1,xmm84:v1,xmm85:v1,xmm86:v1,xmm87:v1,
#     xmm88:v1,xmm89:v1,xmm90:v1,xmm91:v1,xmm92:v1,xmm93:v1,xmm94:v1,xmm95:v1,
#     xmm96:v1,xmm97:v1,xmm98:v1,xmm99:v1,xmm100:v1,xmm101:v1,xmm102:v1,
#     xmm103:v1,xmm104:v1,xmm105:v1,xmm106:v1,xmm107:v1,xmm108:v1,xmm109:v1,
#     xmm110:v1,xmm111:v1,xmm112:v1,xmm113:v1,xmm114:v1,xmm115:v1,xmm116:v1,
#     xmm117:v1,xmm118:v1,xmm119:v1,xmm120:v1,xmm121:v1,xmm122:v1,xmm123:v1,
#     xmm124:v1,xmm125:v1,xmm126:v1,xmm127:v1,xmm128:v1,xmm129:v1,xmm130:v1,
#     xmm131:v1,xmm132:v1,xmm133:v1,xmm134:v1,xmm135:v1,xmm136:v1,xmm137:v1,
#     xmm138:v1,xmm139:v1
# let
#     xmm8 = xmm6 ^ xmm5;
#     xmm9 = xmm1 ^ xmm2;
#     xmm10 = xmm0 ^ xmm8;
#     xmm11 = xmm9 ^ xmm6;
#     xmm12 = xmm0 ^ xmm3;
#     xmm13 = xmm12 ^ xmm11;
#     xmm14 = xmm7 ^ xmm12;
#     xmm15 = xmm10 ^ xmm7;
#     xmm16 = xmm4 ^ xmm14;
#     xmm17 = xmm10 ^ xmm4;
#     xmm18 = xmm1 ^ xmm16;
#     xmm19 = xmm15 ^ xmm9;
#     xmm20 = xmm10 ^ xmm1;
#     xmm21 = xmm15 ^ xmm17;
#     xmm22 = xmm20 ^ xmm19;
#     xmm23 = xmm10 ^ xmm18;
#     xmm24 = xmm19 ^ xmm17;
#     xmm25 = xmm13 ^ xmm0;
#     xmm26 = xmm21 ^ xmm22;
#     xmm27 = xmm22 & xmm23;
#     xmm28 = xmm23 | xmm22;
#     xmm29 = xmm21 & xmm25;
#     xmm30 = xmm25 | xmm21;
#     xmm31 = xmm23 ^ xmm25;
#     xmm32 = xmm31 & xmm26;
#     xmm33 = xmm18 ^ xmm0;
#     xmm34 = xmm33 & xmm24;
#     xmm35 = xmm34 ^ xmm30;
#     xmm36 = xmm34 ^ xmm28;
#     xmm37 = xmm15 ^ xmm20;
#     xmm38 = xmm10 ^ xmm13;
#     xmm39 = xmm37 | xmm38;
#     xmm40 = xmm38 & xmm37;
#     xmm41 = xmm40 ^ xmm27;
#     xmm42 = xmm32 ^ xmm35;
#     xmm43 = xmm29 ^ xmm36;
#     xmm44 = xmm32 ^ xmm39;
#     xmm45 = xmm29 ^ xmm41;
#     xmm46 = xmm29 ^ xmm44;
#     xmm47 = xmm19 & xmm18;
#     xmm48 = xmm17 & xmm0;
#     xmm49 = xmm20 & xmm10;
#     xmm50 = xmm15 | xmm13;
#     xmm51 = xmm47 ^ xmm42;
#     xmm52 = xmm48 ^ xmm43;
#     xmm53 = xmm49 ^ xmm46;
#     xmm54 = xmm50 ^ xmm45;
#     xmm55 = xmm51 ^ xmm52;
#     xmm56 = xmm53 & xmm51;
#     xmm57 = xmm54 ^ xmm56;
#     xmm58 = xmm55 & xmm57;
#     xmm59 = xmm52 ^ xmm58;
#     xmm60 = xmm53 ^ xmm54;
#     xmm61 = xmm52 ^ xmm56;
#     xmm62 = xmm61 & xmm60;
#     xmm63 = xmm54 ^ xmm62;
#     xmm64 = xmm63 ^ xmm53;
#     xmm65 = xmm57 ^ xmm63;
#     xmm66 = xmm54 & xmm65;
#     xmm67 = xmm66 ^ xmm64;
#     xmm68 = xmm66 ^ xmm57;
#     xmm69 = xmm59 & xmm68;
#     xmm70 = xmm55 ^ xmm69;
#     xmm71 = xmm59 ^ xmm70;
#     xmm72 = xmm13 & xmm71;
#     xmm73 = xmm13 ^ xmm10;
#     xmm74 = xmm70 & xmm73;
#     xmm75 = xmm10 & xmm59;
#     xmm76 = xmm75 ^ xmm74;
#     xmm77 = xmm72 ^ xmm75;
#     xmm78 = xmm0 ^ xmm13;
#     xmm79 = xmm18 ^ xmm10;
#     xmm80 = xmm63 ^ xmm59;
#     xmm81 = xmm67 ^ xmm70;
#     xmm82 = xmm80 ^ xmm81;
#     xmm83 = xmm78 & xmm82;
#     xmm84 = xmm79 ^ xmm78;
#     xmm85 = xmm81 & xmm84;
#     xmm86 = xmm80 & xmm79;
#     xmm87 = xmm85 ^ xmm86;
#     xmm88 = xmm83 ^ xmm85;
#     xmm89 = xmm63 ^ xmm67;
#     xmm90 = xmm0 & xmm89;
#     xmm91 = xmm0 ^ xmm18;
#     xmm92 = xmm67 & xmm91;
#     xmm93 = xmm18 & xmm63;
#     xmm94 = xmm93 ^ xmm92;
#     xmm95 = xmm90 ^ xmm93;
#     xmm96 = xmm88 ^ xmm94;
#     xmm97 = xmm76 ^ xmm88;
#     xmm98 = xmm87 ^ xmm95;
#     xmm99 = xmm77 ^ xmm87;
#     xmm100 = xmm15 ^ xmm17;
#     xmm101 = xmm20 ^ xmm19;
#     xmm102 = xmm80 ^ xmm81;
#     xmm103 = xmm100 & xmm102;
#     xmm104 = xmm101 ^ xmm100;
#     xmm105 = xmm81 & xmm104;
#     xmm106 = xmm80 & xmm101;
#     xmm107 = xmm105 ^ xmm106;
#     xmm108 = xmm103 ^ xmm105;
#     xmm109 = xmm63 ^ xmm67;
#     xmm110 = xmm17 & xmm109;
#     xmm111 = xmm17 ^ xmm19;
#     xmm112 = xmm67 & xmm111;
#     xmm113 = xmm19 & xmm63;
#     xmm114 = xmm113 ^ xmm112;
#     xmm115 = xmm110 ^ xmm113;
#     xmm116 = xmm63 ^ xmm80;
#     xmm117 = xmm67 ^ xmm81;
#     xmm118 = xmm116 ^ xmm117;
#     xmm119 = xmm15 & xmm118;
#     xmm120 = xmm15 ^ xmm20;
#     xmm121 = xmm117 & xmm120;
#     xmm122 = xmm20 & xmm116;
#     xmm123 = xmm122 ^ xmm121;
#     xmm124 = xmm119 ^ xmm122;
#     xmm125 = xmm108 ^ xmm123;
#     xmm126 = xmm108 ^ xmm114;
#     xmm127 = xmm107 ^ xmm124;
#     xmm128 = xmm107 ^ xmm115;
#     xmm129 = xmm125 ^ xmm96;
#     xmm130 = xmm127 ^ xmm97;
#     xmm131 = xmm126 ^ xmm129;
#     xmm132 = xmm97 ^ xmm96;
#     xmm133 = xmm96 ^ xmm130;
#     xmm134 = xmm99 ^ xmm130;
#     xmm135 = xmm99 ^ xmm128;
#     xmm136 = xmm128 ^ xmm98;
#     xmm137 = xmm131 ^ xmm135;
#     xmm138 = xmm98 ^ xmm135;
#     xmm139 = xmm132 ^ xmm138;
#     S0 = xmm133;
#     S1 = xmm134;
#     S2 = xmm137;
#     S3 = xmm139;
#     S4 = xmm138;
#     S5 = xmm129;
#     S6 = xmm136;
#     S7 = xmm135
# tel


node sbox (U0:v1, U1:v1, U2:v1, U3:v1, U4:v1, U5:v1, U6:v1, U7:v1)
     returns  (S0:v1, S1:v1, S2:v1, S3:v1, S4:v1, S5:v1, S6:v1, S7:v1)
vars
    y0:v1,  y1:v1,  y2:v1,  y3:v1,  y4:v1,  y5:v1,  y6:v1,  y7:v1,
    y8:v1,  y9:v1,  y10:v1, y11:v1, y12:v1, y13:v1, y14:v1, y15:v1,
    y16:v1, y17:v1, y18:v1, y19:v1, y20:v1, y21:v1,
    t0:v1,  t1:v1,  t2:v1,  t3:v1,  t4:v1,  t5:v1,  t6:v1,  t7:v1,
    t8:v1,  t9:v1,  t10:v1, t11:v1, t12:v1, t13:v1, t14:v1, t15:v1,
    t16:v1, t17:v1, t18:v1, t19:v1, t20:v1, t21:v1, t22:v1, t23:v1,
    t24:v1, t25:v1, t26:v1, t27:v1, t28:v1, t29:v1, t30:v1, t31:v1,
    t32:v1, t33:v1, t34:v1, t35:v1, t36:v1, t37:v1, t38:v1, t39:v1,
    t40:v1, t41:v1, t42:v1, t43:v1, t44:v1, t45:v1,
    z0:v1,  z1:v1,  z2:v1,  z3:v1,  z4:v1,  z5:v1,  z6:v1,  z7:v1,
    z8:v1,  z9:v1,  z10:v1, z11:v1, z12:v1, z13:v1, z14:v1, z15:v1,
    z16:v1, z17:v1,
    tc0:v1,  tc1:v1,  tc2:v1,  tc3:v1,  tc4:v1,  tc5:v1,  tc6:v1,
    tc7:v1,  tc8:v1,  tc9:v1,  tc10:v1, tc11:v1, tc12:v1, tc13:v1,
    tc14:v1, tc15:v1, tc16:v1, tc17:v1, tc18:v1, tc19:v1, tc20:v1,
    tc21:v1, tc22:v1, tc23:v1, tc24:v1, tc25:v1, tc26:v1
let
  y14 = U3 ^ U5;
  y13 = U0 ^ U6;
  y9 = U0 ^ U3;
  y8 = U0 ^ U5;
  t0 = U1 ^ U2;
  y1 = t0 ^ U7;
  y4 = y1 ^ U3;
  y12 = y13 ^ y14;
  y2 = y1 ^ U0;
  y5 = y1 ^ U6;
  y3 = y5 ^ y8;
  t1 = U4 ^ y12;
  y15 = t1 ^ U5;
  y20 = t1 ^ U1;
  y6 = y15 ^ U7;
  y10 = y15 ^ t0;
  y11 = y20 ^ y9;
  y7 = U7 ^ y11;
  y17 = y10 ^ y11;
  y19 = y10 ^ y8;
  y16 = t0 ^ y11;
  y21 = y13 ^ y16;
  y18 = U0 ^ y16;
  t2 = y12 & y15;
  t3 = y3 & y6;
  t4 = t3 ^ t2;
  t5 = y4 & U7;
  t6 = t5 ^ t2;
  t7 = y13 & y16;
  t8 = y5 & y1;
  t9 = t8 ^ t7;
  t10 = y2 & y7;
  t11 = t10 ^ t7;
  t12 = y9 & y11;
  t13 = y14 & y17;
  t14 = t13 ^ t12;
  t15 = y8 & y10;
  t16 = t15 ^ t12;
  t17 = t4 ^ y20;
  t18 = t6 ^ t16;
  t19 = t9 ^ t14;
  t20 = t11 ^ t16;
  t21 = t17 ^ t14;
  t22 = t18 ^ y19;
  t23 = t19 ^ y21;
  t24 = t20 ^ y18;
  t25 = t21 ^ t22;
  t26 = t21 & t23;
  t27 = t24 ^ t26;
  t28 = t25 & t27;
  t29 = t28 ^ t22;
  t30 = t23 ^ t24;
  t31 = t22 ^ t26;
  t32 = t31 & t30;
  t33 = t32 ^ t24;
  t34 = t23 ^ t33;
  t35 = t27 ^ t33;
  t36 = t24 & t35;
  t37 = t36 ^ t34;
  t38 = t27 ^ t36;
  t39 = t29 & t38;
  t40 = t25 ^ t39;
  t41 = t40 ^ t37;
  t42 = t29 ^ t33;
  t43 = t29 ^ t40;
  t44 = t33 ^ t37;
  t45 = t42 ^ t41;
  z0 = t44 & y15;
  z1 = t37 & y6;
  z2 = t33 & U7;
  z3 = t43 & y16;
  z4 = t40 & y1;
  z5 = t29 & y7;
  z6 = t42 & y11;
  z7 = t45 & y17;
  z8 = t41 & y10;
  z9 = t44 & y12;
  z10 = t37 & y3;
  z11 = t33 & y4;
  z12 = t43 & y13;
  z13 = t40 & y5;
  z14 = t29 & y2;
  z15 = t42 & y9;
  z16 = t45 & y14;
  z17 = t41 & y8;
  tc1 = z15 ^ z16;
  tc2 = z10 ^ tc1;
  tc3 = z9 ^ tc2;
  tc4 = z0 ^ z2;
  tc5 = z1 ^ z0;
  tc6 = z3 ^ z4;
  tc7 = z12 ^ tc4;
  tc8 = z7 ^ tc6;
  tc9 = z8 ^ tc7;
  tc10 = tc8 ^ tc9;
  tc11 = tc6 ^ tc5;
  tc12 = z3 ^ z5;
  tc13 = z13 ^ tc1;
  tc14 = tc4 ^ tc12;
  S3 = tc3 ^ tc11;
  tc16 = z6 ^ tc8;
  tc17 = z14 ^ tc10;
  tc18 = tc13 ^ tc14;
  S7 = ~(z12 ^ tc18);
  tc20 = z15 ^ tc16;
  tc21 = tc2 ^ z11;
  S0 = tc3 ^ tc16;
  S6 = ~(tc10 ^ tc18);
  S4 = tc14 ^ S3;
  S1 = ~(S3 ^ tc16);
  tc26 = tc17 ^ tc20;
  S2 = ~(tc26 ^ z17);
  S5 = tc21 ^ tc17
tel
