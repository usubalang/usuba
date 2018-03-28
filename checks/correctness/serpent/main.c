
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>


/* Do NOT change the order of those define/include */

/* defining "BENCH" or "STD" */
/* (will impact the .h functions loaded by the .h) */
#define NO_RUNTIME
/* including the architecture specific .h */

#ifdef AVX
#include "AVX.h"
#define PARALLEL_BLOCK 8
#elif defined SSE
#define PARALLEL_BLOCK 4
#include "SSE.h"
#else
#define PARALLEL_BLOCK 1
#define BITS_PER_REG 32
#define DATATYPE unsigned int
#include "STD.h"
#endif

#include "sbox_for_key.c"

#include "serpent.c"


#define ROL(x,n) ((((unsigned int)(x))<<(n))| \
                  (((unsigned int)(x))>>(32-(n))))
#define PHI 0x9e3779b9
#define min(x,y) (((x)<(y))?(x):(y))
int serpent_convert_from_string(int len, const char *str, unsigned int *val);

/*  CORRECT */
int makeKey(const char* keyMaterial, unsigned int key[33][4]) {
  unsigned int i,j;
  unsigned int w[132],k[132];
  int rc;
  unsigned int key_int[8];

  int keyLen = 256;

  rc=serpent_convert_from_string(keyLen, keyMaterial, key_int);

  for(i=0; i<keyLen/32; i++)
    w[i]=key_int[i];
  if(keyLen<256)
    w[i]=(key_int[i]&((1L<<((keyLen&31)))-1))|(1L<<((keyLen&31)));
  for(i++; i<8; i++)
    w[i]=0;
  for(i=8; i<16; i++)
    w[i]=ROL(w[i-8]^w[i-5]^w[i-3]^w[i-1]^PHI^(i-8),11);
  for(i=0; i<8; i++)
    w[i]=w[i+8];
  for(i=8; i<132; i++)
    w[i]=ROL(w[i-8]^w[i-5]^w[i-3]^w[i-1]^PHI^i,11);

    
  sbox__3(w[  0], w[  1], w[  2], w[  3], &k[  0], &k[  1], &k[  2], &k[  3]);
  sbox__2(w[  4], w[  5], w[  6], w[  7], &k[  4], &k[  5], &k[  6], &k[  7]);
  sbox__1(w[  8], w[  9], w[ 10], w[ 11], &k[  8], &k[  9], &k[ 10], &k[ 11]);
  sbox__0(w[ 12], w[ 13], w[ 14], w[ 15], &k[ 12], &k[ 13], &k[ 14], &k[ 15]);
  sbox__7(w[ 16], w[ 17], w[ 18], w[ 19], &k[ 16], &k[ 17], &k[ 18], &k[ 19]);
  sbox__6(w[ 20], w[ 21], w[ 22], w[ 23], &k[ 20], &k[ 21], &k[ 22], &k[ 23]);
  sbox__5(w[ 24], w[ 25], w[ 26], w[ 27], &k[ 24], &k[ 25], &k[ 26], &k[ 27]);
  sbox__4(w[ 28], w[ 29], w[ 30], w[ 31], &k[ 28], &k[ 29], &k[ 30], &k[ 31]);
  sbox__3(w[ 32], w[ 33], w[ 34], w[ 35], &k[ 32], &k[ 33], &k[ 34], &k[ 35]);
  sbox__2(w[ 36], w[ 37], w[ 38], w[ 39], &k[ 36], &k[ 37], &k[ 38], &k[ 39]);
  sbox__1(w[ 40], w[ 41], w[ 42], w[ 43], &k[ 40], &k[ 41], &k[ 42], &k[ 43]);
  sbox__0(w[ 44], w[ 45], w[ 46], w[ 47], &k[ 44], &k[ 45], &k[ 46], &k[ 47]);
  sbox__7(w[ 48], w[ 49], w[ 50], w[ 51], &k[ 48], &k[ 49], &k[ 50], &k[ 51]);
  sbox__6(w[ 52], w[ 53], w[ 54], w[ 55], &k[ 52], &k[ 53], &k[ 54], &k[ 55]);
  sbox__5(w[ 56], w[ 57], w[ 58], w[ 59], &k[ 56], &k[ 57], &k[ 58], &k[ 59]);
  sbox__4(w[ 60], w[ 61], w[ 62], w[ 63], &k[ 60], &k[ 61], &k[ 62], &k[ 63]);
  sbox__3(w[ 64], w[ 65], w[ 66], w[ 67], &k[ 64], &k[ 65], &k[ 66], &k[ 67]);
  sbox__2(w[ 68], w[ 69], w[ 70], w[ 71], &k[ 68], &k[ 69], &k[ 70], &k[ 71]);
  sbox__1(w[ 72], w[ 73], w[ 74], w[ 75], &k[ 72], &k[ 73], &k[ 74], &k[ 75]);
  sbox__0(w[ 76], w[ 77], w[ 78], w[ 79], &k[ 76], &k[ 77], &k[ 78], &k[ 79]);
  sbox__7(w[ 80], w[ 81], w[ 82], w[ 83], &k[ 80], &k[ 81], &k[ 82], &k[ 83]);
  sbox__6(w[ 84], w[ 85], w[ 86], w[ 87], &k[ 84], &k[ 85], &k[ 86], &k[ 87]);
  sbox__5(w[ 88], w[ 89], w[ 90], w[ 91], &k[ 88], &k[ 89], &k[ 90], &k[ 91]);
  sbox__4(w[ 92], w[ 93], w[ 94], w[ 95], &k[ 92], &k[ 93], &k[ 94], &k[ 95]);
  sbox__3(w[ 96], w[ 97], w[ 98], w[ 99], &k[ 96], &k[ 97], &k[ 98], &k[ 99]);
  sbox__2(w[100], w[101], w[102], w[103], &k[100], &k[101], &k[102], &k[103]);
  sbox__1(w[104], w[105], w[106], w[107], &k[104], &k[105], &k[106], &k[107]);
  sbox__0(w[108], w[109], w[110], w[111], &k[108], &k[109], &k[110], &k[111]);
  sbox__7(w[112], w[113], w[114], w[115], &k[112], &k[113], &k[114], &k[115]);
  sbox__6(w[116], w[117], w[118], w[119], &k[116], &k[117], &k[118], &k[119]);
  sbox__5(w[120], w[121], w[122], w[123], &k[120], &k[121], &k[122], &k[123]);
  sbox__4(w[124], w[125], w[126], w[127], &k[124], &k[125], &k[126], &k[127]);
  sbox__3(w[128], w[129], w[130], w[131], &k[128], &k[129], &k[130], &k[131]);

  //for (int i = 0; i < 8; i++) printf("%016lX\n", k[i]);
  
  
  for(i=0; i<=32; i++)
    for(j=0; j<4; j++)
      key[i][j] = k[4*i+j];

  return 1;
}

int serpent_convert_from_string(int len, const char *str, unsigned int *val)
/* the size of val must be at least the next multiple of 32 */
/* bits after len bits */
{
  int is, iv;
  int slen=min(strlen(str), (len+3)/4);

  if(len<0)
    return -1;		/* Error!!! */

  if(len>slen*4 || len<slen*4-3)
    return -1;		/* Error!!! */

  for(is=0; is<slen; is++)
    if(((str[is]<'0')||(str[is]>'9')) &&
       ((str[is]<'A')||(str[is]>'F')) &&
       ((str[is]<'a')||(str[is]>'f')))
      return -1;	/* Error!!! */

  for(is=slen, iv=0; is>=8; is-=8, iv++)
    {
      unsigned int t;
      sscanf(&str[is-8], "%08X", &t);
      val[iv] = t;
    }
  if(is>0)
    {
      char tmp[10];
      unsigned int t;
      strncpy(tmp, str, is);
      tmp[is] = 0;
      sscanf(tmp, "%08X", &t);
      val[iv++] = t;
    }
  for(; iv<(len+31)/32; iv++)
    val[iv] = 0;
  return iv;
}


#define NB_LOOP 10000000


int main() {

  char* key_base = "01234567" "89ABCDEF" "FEDCBA98" "76543210"
                   "01234567" "89ABCDEF" "FEDCBA98" "76543210";
  unsigned int key_std[33][4];
  makeKey(key_base,key_std); /* it works! */

  DATATYPE key[33][4];
  DATATYPE key_cst[33][4];
  for (int i = 0; i < 33; i++)
    for (int j = 0; j < 4; j++)
#ifdef AVX
      key[i][j] = key_cst[i][j] = _mm256_set1_epi32(key_std[i][j]);
#elif defined SSE
      key[i][j] = key_cst[i][j] = _mm_set1_epi32(key_std[i][j]);
#else
      key[i][j] = key_cst[i][j] = key_std[i][j];
#endif
  
  // Reading the input file
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned int plain_std[PARALLEL_BLOCK*4];
  while (fread(plain_std,16,PARALLEL_BLOCK,fh_in) != 0) {
    DATATYPE plain[4];
#ifdef AVX
    for (int i = 0; i < 4; i++)
      plain[i] = _mm256_set_epi32(plain_std[i],plain_std[i+4],plain_std[i+8],plain_std[i+12],
                                  plain_std[i+16],plain_std[i+20],plain_std[i+24],plain_std[i+28]);
#elif defined SSE
    for (int i = 0; i < 4; i++)
      plain[i] = _mm_set_epi32(plain_std[i],plain_std[i+4],plain_std[i+8],plain_std[i+12]);
#else
    for (int i = 0; i < 4; i++)
      plain[i] = plain_std[i];
#endif 
    for (int i = 0; i < 33; i++)
      for (int j = 0; j < 4; j++)
        key[i][j] = key_cst[i][j];
    DATATYPE cipher[4];
    Serpent__(plain,key,cipher);
    unsigned int cipher_std[PARALLEL_BLOCK*4];
#ifdef AVX
    unsigned int pre_cipher[PARALLEL_BLOCK*4]  __attribute__ ((aligned (32)));
    for (int i = 0; i < 4; i++)
      _mm256_store_si256((__m256i*)&(pre_cipher[i*PARALLEL_BLOCK]),cipher[i]);
    for (int i = 0; i < PARALLEL_BLOCK; i++)
      for (int j = 0; j < 4; j++)
        cipher_std[31-(i*4+j)] = pre_cipher[(3-j)*PARALLEL_BLOCK+i];
#elif defined SSE
    unsigned int pre_cipher[PARALLEL_BLOCK*4];
    for (int i = 0; i < 4; i++)
      _mm_store_si128((__m128i*)&(pre_cipher[i*PARALLEL_BLOCK]),cipher[i]);
    for (int i = 0; i < PARALLEL_BLOCK; i++)
      for (int j = 0; j < 4; j++)
        cipher_std[15-(i*4+j)] = pre_cipher[(3-j)*PARALLEL_BLOCK+i];
#else
    for (int i = 0; i < 4; i++)
      cipher_std[i] = cipher[i];
#endif
    
    fwrite(cipher_std,16,PARALLEL_BLOCK,fh_out);
  }
  fclose(fh_in);
  fclose(fh_out);


  return 0;
}
