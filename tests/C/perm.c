#include <stdlib.h>
#include <stdio.h>
#include "mmintrin.h"
#include "immintrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"





void main__ (unsigned long a[4],unsigned long b[6]) {

  b[0] = a[0];
  b[1] = a[2];
  b[2] = a[1];
  b[3] = a[3];
  b[4] = a[3];
  b[5] = a[0];
}


int main() { return 0; }