


void print64bin (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8bin(c) printf("%d%d%d%d%d%d%d%d",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8bin(bytearray[i]);
}
void print128bin (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}
void print64binSPC8 (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8binSPC8(c) printf("%d%d%d%d%d%d%d%d ",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8binSPC8(bytearray[i]);
}
void print128binSPC8 (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64binSPC8(out[i]);
  }
  puts("");
}

void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
}
