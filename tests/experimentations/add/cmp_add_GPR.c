#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>


void add_pack (int x1, int x2, int x3, int x4,
              int x5, int x6, int x7, int x8,
              int y1, int y2, int y3, int y4,
              int y5, int y6, int y7, int y8,
              int* out)  {
  out[0] = x1 + y1;
  out[1] = x2 + y2;
  out[2] = x3 + y3;
  out[3] = x4 + y4;
  out[4] = x5 + y5;
  out[5] = x6 + y6;
  out[6] = x7 + y7;
  out[7] = x8 + y8;
}

int add(int a, int b, int* c) {
  int tmp = a ^ b;
  int res = tmp ^ *c;
  *c = (a & b) | (*c & tmp);
  return res;
}

void add_bitslice (int x1, int x2, int x3, int x4,
                   int x5, int x6, int x7, int x8,
                   int y1, int y2, int y3, int y4,
                   int y5, int y6, int y7, int y8,
                   int* out) {
  int c = 0;
  out[0] = add(x1,y1,&c);
  out[1] = add(x2,y2,&c);
  out[2] = add(x3,y3,&c);
  out[3] = add(x4,y4,&c);
  out[4] = add(x5,y5,&c);
  out[5] = add(x6,y6,&c);
  out[6] = add(x7,y7,&c);
  out[7] = add(x8,y8,&c);  
}

void add_lookahead (int a0, int a1, int a2, int a3,
                    int a4, int a5, int a6, int a7,
                    int b0, int b1, int b2, int b3,
                    int b4, int b5, int b6, int b7,
                    int* out) {
  int p0 = a0 ^ b0;
  int p1 = a1 ^ b1;
  int p2 = a2 ^ b2;
  int p3 = a3 ^ b3;
  int p4 = a4 ^ b4;
  int p5 = a5 ^ b5;
  int p6 = a6 ^ b6;
  int p7 = a7 ^ b7;

  int g0 = a0 & b0;
  int g1 = a1 & b1;
  int g2 = a2 & b2;
  int g3 = a3 & b3;
  int g4 = a4 & b4;
  int g5 = a5 & b5;
  int g6 = a6 & b6;

  int c0 = g0;
  int c1 = g1 | p1&g0;
  int c2 = g2 | p2&g1 | p2&p1&g0;
  int c3 = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0;
  int c4 = g4 | p4&g3 | p4&p3&g2 | p4&p3&p2&g1 | p4&p3&p2&p1&g0 ;
  int c5 = g5 | p5&g4 | p5&p4&g3 | p5&p4&p3&g2 | p5&p4&p3&p2&g1 | p5&p4&p3&p2&p1&g0;
  int c6 = g6 | p6&g5 | p6&p5&g4 | p6&p5&p4&g3 | p6&p5&p4&p3&g2 | p6&p5&p4&p3&p2&g1 | p6&p5&p4&p3&p2&p1&g0;
  
  out[0] = p0;
  out[1] = p1 ^ c0;
  out[2] = p2 ^ c1;
  out[3] = p3 ^ c2;
  out[4] = p4 ^ c3;
  out[5] = p5 ^ c4;
  out[6] = p6 ^ c5;
  out[7] = p7 ^ c6;
}

void lookahead_sound() {
  
  int x1, x2, x3, x4, x5, x6, x7, x8;
  int y1, y2, y3, y4, y5, y6, y7, y8;
  
  x1 = rand(); y1 = rand();
  x2 = rand(); y2 = rand();
  x3 = rand(); y3 = rand();
  x4 = rand(); y4 = rand();
  x5 = rand(); y5 = rand();
  x6 = rand(); y6 = rand();
  x7 = rand(); y7 = rand();
  x8 = rand(); y8 = rand();

  int buf1[8], buf2[8];
  add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buf1);
  add_lookahead(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buf2);
  for (int i = 0; i < 8; i++)
    if (buf1[i] != buf2[i]) {
      printf("Error: %d vs %d\n",buf1[i], buf2[i]);
      exit(EXIT_FAILURE);
    }
}

int main () {
  clock_t begin, end;
  FILE* f = fopen("/dev/null","w");

  int x1, x2, x3, x4, x5, x6, x7, x8;
  int y1, y2, y3, y4, y5, y6, y7, y8;

  int size = 1e8;
  srand(time(NULL));
  int* buffer = malloc(size * 8 * sizeof *buffer);
  
  x1 = rand(); y1 = rand();
  x2 = rand(); y2 = rand();
  x3 = rand(); y3 = rand();
  x4 = rand(); y4 = rand();
  x5 = rand(); y5 = rand();
  x6 = rand(); y6 = rand();
  x7 = rand(); y7 = rand();
  x8 = rand(); y8 = rand();

  
  for(long long i = 0; i < size; i++)
    add_pack(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buffer+i*8);

  printf("Packed...... ");fflush(stdout);
  begin = clock();
  for(long long i = 0; i < size; i++)
    add_pack(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buffer+i*8);
  end = clock();
  printf("%.2fs\n",(double)(end-begin)/CLOCKS_PER_SEC);
  fwrite(buffer,sizeof *buffer,size,f);

  x1 = rand(); y1 = rand();
  x2 = rand(); y2 = rand();
  x3 = rand(); y3 = rand();
  x4 = rand(); y4 = rand();
  x5 = rand(); y5 = rand();
  x6 = rand(); y6 = rand();
  x7 = rand(); y7 = rand();
  x8 = rand(); y8 = rand();

  printf("Bitsliced... ");fflush(stdout);
  begin = clock();
  for (long long i = 0; i < size; i++)
    add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buffer+i*8);
  end = clock();
  printf("%.2fs\n",(double)(end-begin)/CLOCKS_PER_SEC);
  fwrite(buffer,sizeof *buffer,size,f);

  printf("Lookahead... ");fflush(stdout);
  begin = clock();
  for (long long i = 0; i < size; i++)
    add_lookahead(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buffer+i*8);
  end = clock();
  printf("%.2fs\n",(double)(end-begin)/CLOCKS_PER_SEC);
  fwrite(buffer,sizeof *buffer,size,f);
  
  fclose(f);
  return 0;
}
