
void SubBytes (_m128i inputSB[8], _m128i out[8]) {
  // le circuit de la sbox avec comme inputs inputSB[0..7] et outputs out[0..7]
}

void ShiftRows(_m128i inputSR[8], _m128i out[8]) {
  _mm_shuffle_epi8(inputSR[0],MASK);
  _mm_shuffle_epi8(inputSR[1],MASK);
  _mm_shuffle_epi8(inputSR[2],MASK);
  _mm_shuffle_epi8(inputSR[3],MASK);
  _mm_shuffle_epi8(inputSR[4],MASK);
  _mm_shuffle_epi8(inputSR[5],MASK);
  _mm_shuffle_epi8(inputSR[6],MASK);
  _mm_shuffle_epi8(inputSR[7],MASK);
}

void MixColumn(_m128i inputMC[8], _m128i out[8]) {
  // le code devrait être une traduction relativement directe du code Usuba
}



/* Note: les for pourraient être unrollés, et les appels de fonctions inlinés... 
   Cela dit, c'est peut-être plus efficace de les laisser tel quel. 
   (en tout cas, ca réduit la taille du code) */
/* Note 2: la clé peut etre généré avec le code bitslicé ou bien en mode non-bitslicé,
   mais dans tous les cas, c'est relativement raisonnable de ne pas s'en préoccuper. */
/* Note 3: il faudrait réfléchir à la fonction de transposition. */
void AES (_m128i plain[8], _m128i key[11][8], _m128i cipher[8]) {
  for (int i = 0; i < 8; i++) cipher[i] = plain[i] ^ key[0][i];

  for (int i = 1; i <= 9; i++) {
    _m128i subbytes[8];
    SubBytes(cipher, subbytes);
    _m128i shiftrows[8];
    ShiftRows(subbytes,shiftrows);
    _m128i mixcolumn[8];
    MixColumn(shiftrows,mixcolumn);
    for (int i = 0; i < 8; i++) cipher[i] = mixcolumn[i] ^ key[1][i];
  }
  
  _m128i subbytes[8];
  SubBytes(cipher, subbytes);
  _m128i shiftrows[8];
  ShiftRows(subbytes,shiftrows);

  for (int i = 0; i < 8; i++) cipher[i] = mixcolumn[i] ^ key[10][i];
  
}
