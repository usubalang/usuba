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
static volatile int state = 0;
static int remaining = 32;
static int get_rand() {
  if (remaining == 0) {
    timer_count_cycles();
    remaining = 32;
  }
  int bits_per_rand = 32 / FD;
#ifdef PIPELINED
  bits_per_rand /= 2;
#endif
  remaining -= bits_per_rand;
  return state;
}
#define RAND() get_rand()

#define seed(x) (void)x
#define get_seed() 0
#define seed_prev(x) (void)x


#else // #ifdef COPROC_RAND

// INTERLEAVE (and UNINTERLEAVE) convert data to (and back from)
// pipelined (ie Rt = 2) format. See explanations in aes.c somewhere.
#ifdef PIPELINED
#if FD == 1
#define SHIFT 16
#define MASK_RIGHT 0x0000ffff
#define MASK_LEFT  0xffff0000
#elif FD == 2
#define SHIFT 8
#define MASK_RIGHT 0x00ff00ff
#define MASK_LEFT  0xff00ff00
#elif FD == 4
#define SHIFT 4
#define MASK_RIGHT 0x0f0f0f0f
#define MASK_LEFT  0xf0f0f0f0
#endif // #if FD == 1

#define INTERLEAVE(a,b) ((a & MASK_RIGHT) | ((b << SHIFT) & MASK_LEFT))
#define UNINTERLEAVE(a) (a & MASK_RIGHT)

#endif // #ifdef PIPELINED

#if FD == 1
#define FORMAT(x) x
#elif FD == 2
#define FORMAT(x) ((x & 0x0000ffff) | (~x << 16))
#elif FD == 4
#define FORMAT(x) ((x & 0x000000ff) | ((x & 0x000000ff) << 16) | \
                   ((~x & 0x000000ff) << 8) | ((~x & 0x000000ff) << 24))
#endif // #if FD == 1

// There is no coprocessor to generate random bits -> using a xorshift
// RNG (namely, one that Wikipedia
// (https://en.wikipedia.org/wiki/Xorshift) attributes to p.4 of
// Marsaglia, "Xorshift RNGs").

static int state = 0x8e20a6e5;

// In pipelined mode, we need to compute twice each round with the
// same randomness. To do so, we need that |state_prev| as well as
// |seed|, |seed_prev| and |get_seed| to reset the seed between rounds
// as needed. See their usage in aes.c.
#ifdef PIPELINED
static int state_prev = 0x8e20a6e5;
static void seed(int seed) { state = seed; }
static int get_seed() { return state; }
static void seed_prev(int seed) { state_prev = seed; }
#endif

static int __attribute__((noinline)) xorshift_rand() {
  state ^= state << 13;
  state ^= state >> 17;
  state ^= state << 5;
  int state_R = FORMAT(state);
#ifdef PIPELINED
  state_prev ^= state_prev << 13;
  state_prev ^= state_prev >> 17;
  state_prev ^= state_prev << 5;
  int state_prev_R = FORMAT(state_prev);
#endif

#ifdef PIPELINED
  return INTERLEAVE(state_R, state_prev_R);
#else
  return state_R;
#endif
}

#define RAND() xorshift_rand()

#endif // #ifdef COPROC_RAND


#ifdef CST_RAND
#undef RAND
static volatile int x = 0;
#define seed(x) (void)x
#define get_seed() 0
#define seed_prev(x) (void)x
#define RAND() x
#endif // #ifdef CST_RAND
