#pragma once

#ifdef COPROC_RAND
// Assumes there is a coprocessor generating random bits. 32 random
// bits are generated every RANDOM_DELAY bytes

#define ADDR 0x80000600
typedef struct {
  volatile unsigned int counter;
  volatile unsigned int reload;
  volatile unsigned int control;
  volatile unsigned int latch;
} timerreg;
typedef struct {
  volatile unsigned int scalercnt;
  volatile unsigned int scalerload;
  volatile unsigned int configreg;
  volatile unsigned int latch;
  timerreg timer[7];
} gptimer;

extern int waiting_cycles;

static unsigned long timer_count_cycles() {
  gptimer* lr = (gptimer*) ADDR;
  static unsigned long count = 0;
  unsigned long lap = (unsigned long) (count - lr->timer[0].counter);
  if (lap < RANDOM_DELAY) waiting_cycles += RANDOM_DELAY - lap;
  count = lr->timer[0].counter;
  return lap;
}
static int state = 0x8e20a6e5;
static int remaining = 32;
static int get_rand() {
  if (remaining == 0) {
    state     = timer_count_cycles();
    remaining = 32;
  }
  int bits_per_rand = 32 / FD;
#ifdef PIPELINED
  bits_per_rand /= 2;
#endif
  remaining -= bits_per_rand;
  return state; // Not quite correct, should depend on TI, FD and PIPELINED
}
#define RAND() get_rand()



#else // #ifdef COPROC_RAND

// There is no coprocessor to generate random bits -> using a xorshift
// RNG (namely, one that Wikipedia
// (https://en.wikipedia.org/wiki/Xorshift) attributes to p.4 of
// Marsaglia, "Xorshift RNGs").
static int state = 0x8e20a6e5;
#ifdef PIPELINED
static int state_prev = 0x8e20a6e5;
#endif
static void seed(int seed) { state = seed; }
#ifdef PIPELINED
static int get_seed() { return state; }
static void seed_prev(int seed) { state_prev = seed; }
#endif
static int __attribute__((noinline)) xorshift_rand() {
  state ^= state << 13;
  state ^= state >> 17;
  state ^= state << 5;
#ifdef PIPELINED
  state_prev ^= state_prev << 13;
  state_prev ^= state_prev >> 17;
  state_prev ^= state_prev << 5;
#endif
#if FD == 1
#ifdef PIPELINED
  return (state_prev << 16) | (state & 0xFFFF);
#else
  return state;
#endif
#elif FD == 2
  // Can't have both PIPELINED and FD == 2
  return (~state << 16) | (state & 0xFFFF);
#elif FD == 4
#ifdef PIPELINED
  return (~state_prev << 24) | ((state_prev & 0xFF) << 16) |
    ((~state & 0xFF) << 8) | (state & 0xFF);
#else
  return (~state << 24) | ((state & 0xFF) << 16) |
    ((~state & 0xFF) << 8) | (state & 0xFF);
#endif
#endif
}

#if defined(FD) && FD >= 2
#if FD == 2
#define RAND() ({ DATATYPE _tmp = xorshift_rand(); (~_tmp & 0xFFFF) | (_tmp << 16); })
#elif FD == 4
#define RAND() ({ DATATYPE _tmp = xorshift_rand();                      \
      (~_tmp & 0xFF) | ((_tmp & 0xFF) << 8) | ((~_tmp & 0xFF) << 16) | (_tmp<< 24); })
#else // #if FD == 2 ... #elif FD == 4
#error Invalid FD
#endif // #if FD == 2
#else // #if defined(FD) && FD >= 2
#define RAND() xorshift_rand()
#endif // #if defined(FD) && FD >= 2
#endif // #ifdef COPROC_RAND


#ifdef CST_RAND
#undef RAND
#define RAND() (unsigned int) *((volatile unsigned int*)0x80000600)
#endif
