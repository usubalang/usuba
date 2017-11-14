#include <stdint.h>
#include <stdlib.h>

#define AND(a,b)  ((a) & (b))
#define OR(a,b)   ((a) | (b))
#define XOR(a,b)  ((a) ^ (b))
#define ANDN(a,b) (~(a) & (b))
#define NOT(a)    (~(a))

#define DATATYPE uint64_t


void des__ (/*inputs*/ DATATYPE plaintext[64],DATATYPE key[64], /*outputs*/ DATATYPE ciphered[64]);
