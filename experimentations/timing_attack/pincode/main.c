#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <x86intrin.h>

// How many measurements to collect for each guess
#define MEASURES_PER_ITEM 10000


extern void init_password();
extern int check_password(unsigned int provided, int length);
extern void print_password();

// Quicksort implementation to sort the measurements in able to find
// their mean.
int partition(unsigned long* arr, int start, int end) {
  unsigned long p = arr[end];
  int i = start;
  for (int j = start; j < end; j++) {
    if (arr[j] < p) {
      unsigned long tmp = arr[j];
      arr[j] = arr[i];
      arr[i] = tmp;
      i++;
    }
  }
  unsigned long tmp = arr[end];
  arr[end] = arr[i];
  arr[i] = tmp;
  return i;
}
void quicksort(unsigned long* arr, int start, int end) {
  if (start < end) {
    int p = partition(arr, start, end);
    quicksort(arr, start, p-1);
    quicksort(arr, p+1, end);
  }
}
void sort_array(unsigned long* arr, int length) {
  quicksort(arr, 0, length-1);
}



int guess_password(int length) {

  unsigned int start = 0;
  unsigned int digit_num = 1;

  unsigned long** timings = malloc(10 * sizeof(*timings));
  for (int i = 0; i < 10; i++)
    timings[i] = calloc(MEASURES_PER_ITEM, sizeof(**timings));


  for (int i = 0; i < length; i++) {
    /* printf("Guessing character %d (start:%u)\n", i, start); */

    // Collecting measurements
    for (int j = 0; j < MEASURES_PER_ITEM; j++) {
      for (int n = 0; n < 10; n++) {
        unsigned int pwd = start + n * digit_num;
        unsigned int garbage;
        uint64_t timer = __rdtscp(&garbage);
        check_password(pwd, length);
        timer = __rdtscp(&garbage) - timer;
        timings[n][j] = timer;
      }
    }

    // Finding out which mean is the highest
    unsigned long means[10];
    int max = 0;
    for (int j = 0; j < 10; j++) {
      sort_array(timings[j], MEASURES_PER_ITEM);
      means[j] = timings[j][MEASURES_PER_ITEM/2];
      max = means[j] > means[max] ? j : max;
      /* printf("  %d: %lu\n", j, means[j]); */
      /* printf("     ["); */
      /* for (int k = 0; k < MEASURES_PER_ITEM; k++) */
      /*   printf("%lu ", timings[j][k]); */
      /* printf("]\n"); */
    }

    /* printf(" ---> %d\n", max); */

    /* printf("\n\n"); */

    // Updating known start
    start     += max * digit_num;
    digit_num *= 10;
  }

  return start;
}


int main(int argc, char** argv) {
  unsigned length = argc > 1 ? atoi(argv[1]) : 6;
  init_password(length);
  unsigned int pwd = guess_password(length);
  printf("Guess: %u\n", pwd);
  return 0;
}
