#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $size = $ARGV[0] || die "No size!";
my $size_m1 = $size-1;

say qq{#define ADD_SIZE "$size"\n};

# Generating the adder
say "#define add(" . join(",", map { "a$_" } 0 .. $size_m1)
    . ",\\\n              " . join(",", map { "b$_" } 0 .. $size_m1)
    . ") {  \\\n    _VOLATILE DATATYPE c = ZERO;\\";

for (0 .. $size_m1) {
    say "    full_adder(a$_,b$_,c,a$_); \\";
}
say "  }\n\n";


# Generating the function calling it
say "__attribute__ ((noinline)) void speed_bitslice() {\n";

say "  // Initializing data";
for (0 .. $size_m1) {
    say "  _VOLATILE DATATYPE a$_ = INIT();";
    say "  _VOLATILE DATATYPE b$_ = INIT();";
}
say "\n";

say "  // Warming up caches";
say "  for (unsigned long i = 0; i < WARMUP; i++) {";
say "    add(" . join(",", map { "a$_" } 0 .. $size_m1)
    . ",\n        " . join(",", map { "b$_" } 0 .. $size_m1)
    . ");\n  }\n";

say "  // The actual measurement";
say "  unsigned int unused;";
say "  uint64_t timer = __rdtscp(&unused);";
say "  for (unsigned long i = 0; i < NB_RUN_BITSLICE; i++) {";
say "    add(" . join(",", map { "a$_" } 0 .. $size_m1)
    . ",\n        " . join(",", map { "b$_" } 0 .. $size_m1)
    . ");\n  }\n";
say "  timer = __rdtscp(&unused) - timer;";
say q{  printf(ADD_SIZE "-bit bitslice add:        %5.2f cycles/loop  (%.2f cycles/add)\n",
    ((double)timer)/NB_RUN_BITSLICE, ((double)timer) / NB_RUN_BITSLICE / REG_SIZE);};
say "";

say "  // Prevent data from being optimized out";
for (0 .. $size_m1) {
    say qq{  asm volatile("" : "+"ASM_MOD (a$_));}
}
say "\n}\n";
