
let sboxes = [

  ("des_1", [ 14; 0; 4; 15; 13; 7; 1; 4; 2; 14; 15; 2; 11; 13; 8; 1;
              3; 10; 10; 6; 6; 12; 12; 11; 5; 9; 9; 5; 0; 3; 7; 8;
              4; 15; 1; 12; 14; 8; 8; 2; 13; 4; 6; 9; 2; 1; 11; 7;
              15; 5; 12; 11; 9; 3; 7; 14; 3; 10; 10; 0; 5; 6; 0; 13 ] );

  ("des_2", [ 15; 3; 1; 13; 8; 4; 14; 7; 6; 15; 11; 2; 3; 8; 4; 14;
              9; 12; 7; 0; 2; 1; 13; 10; 12; 6; 0; 9; 5; 11; 10; 5;
              0; 13; 14; 8; 7; 10; 11; 1; 10; 3; 4; 15; 13; 4; 1; 2;
              5; 11; 8; 6; 12; 7; 6; 12; 9; 0; 3; 5; 2; 14; 15; 9 ] );

  ("des_3", [ 10; 13; 0; 7; 9; 0; 14; 9; 6; 3; 3; 4; 15; 6; 5; 10;
              1; 2; 13; 8; 12; 5; 7; 14; 11; 12; 4; 11; 2; 15; 8; 1;
              13; 1; 6; 10; 4; 13; 9; 0; 8; 6; 15; 9; 3; 8; 0; 7;
              11; 4; 1; 15; 2; 14; 12; 3; 5; 11; 10; 5; 14; 2; 7; 12 ] );

  ("des_4", [ 7; 13; 13; 8; 14; 11; 3; 5; 0; 6; 6; 15; 9; 0; 10; 3;
              1; 4; 2; 7; 8; 2; 5; 12; 11; 1; 12; 10; 4; 14; 15; 9;
              10; 3; 6; 15; 9; 0; 0; 6; 12; 10; 11; 1; 7; 13; 13; 8;
              15; 9; 1; 4; 3; 5; 14; 11; 5; 12; 2; 7; 8; 2; 4; 14 ] );

  ("des_5", [ 2; 14; 12; 11; 4; 2; 1; 12; 7; 4; 10; 7; 11; 13; 6; 1;
              8; 5; 5; 0; 3; 15; 15; 10; 13; 3; 0; 9; 14; 8; 9; 6;
              4; 11; 2; 8; 1; 12; 11; 7; 10; 1; 13; 14; 7; 2; 8; 13;
              15; 6; 9; 15; 12; 0; 5; 9; 6; 10; 3; 4; 0; 5; 14; 3 ] );

  ("des_6", [ 12; 10; 1; 15; 10; 4; 15; 2; 9; 7; 2; 12; 6; 9; 8; 5;
              0; 6; 13; 1; 3; 13; 4; 14; 14; 0; 7; 11; 5; 3; 11; 8;
              9; 4; 14; 3; 15; 2; 5; 12; 2; 9; 8; 5; 12; 15; 3; 10;
              7; 11; 0; 14; 4; 1; 10; 7; 1; 6; 13; 0; 11; 8; 6; 13 ] );

  ("des_7", [ 4; 13; 11; 0; 2; 11; 14; 7; 15; 4; 0; 9; 8; 1; 13; 10;
              3; 14; 12; 3; 9; 5; 7; 12; 5; 2; 10; 15; 6; 8; 1; 6;
              1; 6; 4; 11; 11; 13; 13; 8; 12; 1; 3; 4; 7; 10; 14; 7;
              10; 9; 15; 5; 6; 0; 8; 15; 0; 14; 5; 2; 9; 3; 2; 12 ] );

  ("des_8", [ 13; 1; 2; 15; 8; 13; 4; 8; 6; 10; 15; 3; 11; 7; 1; 4;
              10; 12; 9; 5; 3; 6; 14; 11; 5; 0; 0; 14; 12; 9; 7; 2;
              7; 2; 11; 1; 4; 14; 1; 7; 9; 4; 12; 10; 14; 8; 2; 13;
              0; 15; 6; 12; 10; 9; 13; 0; 15; 3; 3; 5; 5; 6; 8; 11 ] );

  ("aes", [ 99; 124; 119; 123; 242; 107; 111; 197; 48; 1; 103; 43; 254; 215; 171; 118;
            202; 130; 201; 125; 250; 89; 71; 240; 173; 212; 162; 175; 156; 164; 114; 192;
            183; 253; 147; 38; 54; 63; 247; 204; 52; 165; 229; 241; 113; 216; 49; 21;
            4; 199; 35; 195; 24; 150; 5; 154; 7; 18; 128; 226; 235; 39; 178; 117;
            9; 131; 44; 26; 27; 110; 90; 160; 82; 59; 214; 179; 41; 227; 47; 132;
            83; 209; 0; 237; 32; 252; 177; 91; 106; 203; 190; 57; 74; 76; 88; 207;
            208; 239; 170; 251; 67; 77; 51; 133; 69; 249; 2; 127; 80; 60; 159; 168;
            81; 163; 64; 143; 146; 157; 56; 245; 188; 182; 218; 33; 16; 255; 243; 210;
            205; 12; 19; 236; 95; 151; 68; 23; 196; 167; 126; 61; 100; 93; 25; 115;
            96; 129; 79; 220; 34; 42; 144; 136; 70; 238; 184; 20; 222; 94; 11; 219;
            224; 50; 58; 10; 73; 6; 36; 92; 194; 211; 172; 98; 145; 149; 228; 121;
            231; 200; 55; 109; 141; 213; 78; 169; 108; 86; 244; 234; 101; 122; 174; 8;
            186; 120; 37; 46; 28; 166; 180; 198; 232; 221; 116; 31; 75; 189; 139; 138;
            112; 62; 181; 102; 72; 3; 246; 14; 97; 53; 87; 185; 134; 193; 29; 158;
            225; 248; 152; 17; 105; 217; 142; 148; 155; 30; 135; 233; 206; 85; 40; 223;
            140; 161; 137; 13; 191; 230; 66; 104; 65; 153; 45; 15; 176; 84; 187; 22]);

  ("serpent_osvik_0", [ 3; 8;15; 1;10; 6; 5;11;14;13; 4; 2; 7; 0; 9;12 ]);
  ("serpent_osvik_1", [15;12; 2; 7; 9; 0; 5;10; 1;11;14; 8; 6;13; 3; 4 ]);
  ("serpent_osvik_2", [ 8; 6; 7; 9; 3;12;10;15;13; 1;14; 4; 0;11; 5; 2 ]);
  ("serpent_osvik_3", [ 0;15;11; 8;12; 9; 6; 3;13; 1; 2; 4;10; 7; 5;14 ]);
  ("serpent_osvik_4", [ 1;15; 8; 3;12; 0;11; 6; 2; 5; 4;10; 9;14; 7;13 ]);
  ("serpent_osvik_5", [15; 5; 2;11; 4;10; 9;12; 0; 3;14; 8;13; 6; 7; 1 ]);
  ("serpent_osvik_6", [ 7; 2;12; 5; 8; 4; 6;11;14; 9; 1;15;13; 3;10; 0 ]);
  ("serpent_osvik_7", [ 1;13;15; 0;14; 8; 2;11; 7; 4;12;10; 9; 3; 5; 6 ]);
  
  ("serpent_0", [ 3; 8;15; 1;10; 6; 5;11;14;13; 4; 2; 7; 0; 9;12 ]);
  ("serpent_1", [15;12; 2; 7; 9; 0; 5;10; 1;11;14; 8; 6;13; 3; 4 ]);
  ("serpent_2", [ 8; 6; 7; 9; 3;12;10;15;13; 1;14; 4; 0;11; 5; 2 ]);
  ("serpent_3", [ 0;15;11; 8;12; 9; 6; 3;13; 1; 2; 4;10; 7; 5;14 ]);
  ("serpent_4", [ 1;15; 8; 3;12; 0;11; 6; 2; 5; 4;10; 9;14; 7;13 ]);
  ("serpent_5", [15; 5; 2;11; 4;10; 9;12; 0; 3;14; 8;13; 6; 7; 1 ]);
  ("serpent_6", [ 7; 2;12; 5; 8; 4; 6;11;14; 9; 1;15;13; 3;10; 0 ]);
  ("serpent_7", [ 1;13;15; 0;14; 8; 2;11; 7; 4;12;10; 9; 3; 5; 6 ]);
  
  ("rectangle", [ 6; 5; 12; 10; 1; 14; 7; 9; 11; 0; 3; 13; 8; 15; 4; 2]);

  ("present",   [ 12; 5; 6; 11; 9; 0; 10; 13; 3; 14; 15; 8; 4; 7; 1; 2]);

  
  ("pyjamask", [0x2;0xd;0x3;0x9;0x7;0xb;0xa;0x6;0xe;0x0;0xf;0x4;0x8;0x5;0x1;0xc]);

]
