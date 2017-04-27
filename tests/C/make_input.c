/* Compile with:
   gcc -o make_input make_input.c -O3

   Run with
   ./make_input

*/

#include <stdio.h>
#include <stdlib.h>

// 1024 * 8 => 8 Mb
#define SIZE 1024 * 8

int main() {
  unsigned char text[8]={0x01,0x23,0x45,0x67,0x89,0xAB,0xCD,0xEF},
    key[8]={0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1} ;
  
  
  FILE* f = fopen("input.txt","wb");
  for (int i = 0; i < 128*SIZE; i++) {
    if (i%2) {
      fprintf(f, "%c%c%c%c%c%c%c%c",key[0],key[1],key[2],key[3],
              key[4],key[5],key[6],key[7]);
    } else {
      fprintf(f, "%c%c%c%c%c%c%c%c",text[0],text[1],text[2],text[3],
              text[4],text[5],text[6],text[7]);
    }
  }
  fclose(f);

}
