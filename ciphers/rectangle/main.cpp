/** @file main.cpp
 * @brief 本文件是主函数的定义，调用测试正确性的函数和测试速度的函数进行测试。
 */

#include "rectangle.h"
#include "test.h"
#include "timing.h"
#include "rect_ua.h"
#include "stream.h"
#include <x86intrin.h>
#include <time.h>

void a() {
  unsigned char input[8] = { 0 }; //{ 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77 };
  unsigned char output[8];
  unsigned char key[10] = { 0 };
  int outlen;
  rectangle_ecb_enc(input,8,output,&outlen,key,80);
  for (int i = 0; i < 8; i++) printf("%02x ",input[i]);
  puts("");
  for (int i = 0; i < 8; i++) printf("%02x ",output[i]);
  puts("");
}


#define IN_SIZE (8*8192)
void verif() {
  srand(7);
  
  // unsigned char input[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  //                             0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
  unsigned char input[IN_SIZE] __attribute ((aligned(32)));
  for (int i = 0; i < IN_SIZE; i++) input[i] = rand();

  // unsigned char key[10] = { 0 };
  unsigned char key[10];
  for (int i = 0; i < 10; i++) key[i] = rand();
  unsigned char key_sched[208];
  Key_Schedule(key,80,ENC,key_sched);
  
  int outlen;
  unsigned char output_ref[IN_SIZE] __attribute ((aligned(32)));
  Crypt_Enc_Block(input,IN_SIZE,output_ref,&outlen,key_sched,80);

  unsigned char output_ua[IN_SIZE] __attribute ((aligned(32)));
  crypto_stream_ecb(output_ua,input,IN_SIZE,key);

  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 8; j++) {
      printf("%02x",output_ua[i*8+j]);
    }
    printf(" ");
  }
  printf("\n");
  
  // unsigned char xored = 0, summed = 0;
  // for (int i = 0; i < IN_SIZE; i++) {
  //   xored  ^= output_ua[i];
  //   summed += output_ua[i];
  // }
  // printf("%d %d\n",xored, summed);

  if (memcmp(output_ref,output_ua,IN_SIZE) != 0) {
    fprintf(stderr, "Encryption Error.\n");
  } else {
    printf("All OK.\n");
  }
  
}

#define NB_LOOP 10000
void speed() {
  unsigned char input[IN_SIZE] __attribute ((aligned(32)));
  unsigned char output[IN_SIZE] __attribute ((aligned(32)));
  
  unsigned char key[10] = { 0 };

  {
    int outlen;
    for (int i = 0; i < 10000; i++)
      rectangle_ecb_enc(input,IN_SIZE,output,&outlen,key,80);

    uint64_t timer = _rdtsc();
    for (int i = 0; i < NB_LOOP; i++)
      rectangle_ecb_enc(input,IN_SIZE,output,&outlen,key,80);
    timer = _rdtsc() - timer;
    printf("Ref  : %.2f\n",(double)timer/IN_SIZE/NB_LOOP);
  }

  {
    for (int i = 0; i < 10000; i++)
      crypto_stream_ecb(output,input,IN_SIZE,key);

    uint64_t timer = _rdtsc();
    for (int i = 0; i < NB_LOOP; i++)
      crypto_stream_ecb(output,input,IN_SIZE,key);
    timer = _rdtsc() - timer;
    printf("Usuba: %.2f\n",(double)timer/IN_SIZE/NB_LOOP);
  }

  {
    for (int i = 0; i < 10000; i++)
      ortho_speed(output,input,IN_SIZE,key);
    
    uint64_t timer = _rdtsc();
    for (int i = 0; i < NB_LOOP; i++)
      ortho_speed(output,input,IN_SIZE,key);
    timer = _rdtsc() - timer;
    printf("Ortho: %.2f\n",(double)timer/IN_SIZE/NB_LOOP);
  }
  
  FILE* fh = fopen("/dev/null","w");
  for (int i = 0; i < 8; i++) fprintf(fh,"%02x ",input[i]);
  for (int i = 0; i < 8; i++) fprintf(fh,"%02x ",output[i]);
  
}

int main()
{
  verif();
  speed();
  
  //test();
	//timing();

	return 0;
}
