#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $x86 = "@ARGV" =~ /X86/;
my $run = "@ARGV" =~ /run/;

for my $fd (1, 2, 4) {
    for my $ti (1, 2, 4) {
        say "Compiling FD=$fd TI=$ti";
        if ($ARGV[0] && $ARGV[0] eq "X86") {
            system "gcc -I ../../arch -Wall -Wextra -Wno-unused-function -o main_${fd}_${ti} main.c sbox.c -D TI=$ti -D FD=$fd -D X86";
            if ($run) {
                say "Running it";
                system "./main_${fd}_${ti}";
            }
        } else {
            system "sparc-gaisler-elf-gcc -Wall -Wextra -Wno-unused-function -mcpu=leon3 -mno-fpu -Wall -Wextra -D TI=$ti -D FD=$fd -I ../../arch -O3 -o main_${fd}_${ti} main.c sbox.c";
        }
    }
}
