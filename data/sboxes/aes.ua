# node sbox (xmm7:bool, xmm6:bool, xmm5:bool, xmm4:bool,
#            xmm3:bool, xmm2:bool, xmm1:bool, xmm0:bool)
#      returns  (S7:bool, S6:bool, S5:bool, S4:bool, S3:bool, S2:bool, S1:bool, S0:bool)
# vars
#     xmm8:bool,xmm9:bool,xmm10:bool,xmm11:bool,xmm12:bool,xmm13:bool,xmm14:bool,xmm15:bool,
#     xmm16:bool,xmm17:bool,xmm18:bool,xmm19:bool,xmm20:bool,xmm21:bool,xmm22:bool,xmm23:bool,
#     xmm24:bool,xmm25:bool,xmm26:bool,xmm27:bool,xmm28:bool,xmm29:bool,xmm30:bool,xmm31:bool,
#     xmm32:bool,xmm33:bool,xmm34:bool,xmm35:bool,xmm36:bool,xmm37:bool,xmm38:bool,xmm39:bool,
#     xmm40:bool,xmm41:bool,xmm42:bool,xmm43:bool,xmm44:bool,xmm45:bool,xmm46:bool,xmm47:bool,
#     xmm48:bool,xmm49:bool,xmm50:bool,xmm51:bool,xmm52:bool,xmm53:bool,xmm54:bool,xmm55:bool,
#     xmm56:bool,xmm57:bool,xmm58:bool,xmm59:bool,xmm60:bool,xmm61:bool,xmm62:bool,xmm63:bool,
#     xmm64:bool,xmm65:bool,xmm66:bool,xmm67:bool,xmm68:bool,xmm69:bool,xmm70:bool,xmm71:bool,
#     xmm72:bool,xmm73:bool,xmm74:bool,xmm75:bool,xmm76:bool,xmm77:bool,xmm78:bool,xmm79:bool,
#     xmm80:bool,xmm81:bool,xmm82:bool,xmm83:bool,xmm84:bool,xmm85:bool,xmm86:bool,xmm87:bool,
#     xmm88:bool,xmm89:bool,xmm90:bool,xmm91:bool,xmm92:bool,xmm93:bool,xmm94:bool,xmm95:bool,
#     xmm96:bool,xmm97:bool,xmm98:bool,xmm99:bool,xmm100:bool,xmm101:bool,xmm102:bool,
#     xmm103:bool,xmm104:bool,xmm105:bool,xmm106:bool,xmm107:bool,xmm108:bool,xmm109:bool,
#     xmm110:bool,xmm111:bool,xmm112:bool,xmm113:bool,xmm114:bool,xmm115:bool,xmm116:bool,
#     xmm117:bool,xmm118:bool,xmm119:bool,xmm120:bool,xmm121:bool,xmm122:bool,xmm123:bool,
#     xmm124:bool,xmm125:bool,xmm126:bool,xmm127:bool,xmm128:bool,xmm129:bool,xmm130:bool,
#     xmm131:bool,xmm132:bool,xmm133:bool,xmm134:bool,xmm135:bool,xmm136:bool,xmm137:bool,
#     xmm138:bool,xmm139:bool
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


node sbox (U0:bool, U1:bool, U2:bool, U3:bool, U4:bool, U5:bool, U6:bool, U7:bool)
     returns  (S0:bool, S1:bool, S2:bool, S3:bool, S4:bool, S5:bool, S6:bool, S7:bool)
vars
    y0:bool,  y1:bool,  y2:bool,  y3:bool,  y4:bool,  y5:bool,  y6:bool,  y7:bool,
    y8:bool,  y9:bool,  y10:bool, y11:bool, y12:bool, y13:bool, y14:bool, y15:bool,
    y16:bool, y17:bool, y18:bool, y19:bool, y20:bool, y21:bool, 
    t0:bool,  t1:bool,  t2:bool,  t3:bool,  t4:bool,  t5:bool,  t6:bool,  t7:bool,
    t8:bool,  t9:bool,  t10:bool, t11:bool, t12:bool, t13:bool, t14:bool, t15:bool,
    t16:bool, t17:bool, t18:bool, t19:bool, t20:bool, t21:bool, t22:bool, t23:bool,
    t24:bool, t25:bool, t26:bool, t27:bool, t28:bool, t29:bool, t30:bool, t31:bool,
    t32:bool, t33:bool, t34:bool, t35:bool, t36:bool, t37:bool, t38:bool, t39:bool,
    t40:bool, t41:bool, t42:bool, t43:bool, t44:bool, t45:bool, 
    z0:bool,  z1:bool,  z2:bool,  z3:bool,  z4:bool,  z5:bool,  z6:bool,  z7:bool,
    z8:bool,  z9:bool,  z10:bool, z11:bool, z12:bool, z13:bool, z14:bool, z15:bool,
    z16:bool, z17:bool,
    tc0:bool,  tc1:bool,  tc2:bool,  tc3:bool,  tc4:bool,  tc5:bool,  tc6:bool,
    tc7:bool,  tc8:bool,  tc9:bool,  tc10:bool, tc11:bool, tc12:bool, tc13:bool,
    tc14:bool, tc15:bool, tc16:bool, tc17:bool, tc18:bool, tc19:bool, tc20:bool,
    tc21:bool, tc22:bool, tc23:bool, tc24:bool, tc25:bool, tc26:bool
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
