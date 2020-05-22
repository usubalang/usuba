#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use autodie qw( open close );

use FindBin;
use File::Temp qw( tempdir );

my $ua_dir = "$FindBin::Bin/../..";
my @ciphers = qw(des ascon gift present rectangle serpent);
my $work_dir = tempdir();


# Generating the .c
chdir $ua_dir;
for my $cipher (@ciphers) {
    system "./usubac -gen-bench -no-pre-sched -no-sched -B -o $work_dir/$cipher.c samples/usuba/$cipher.ua";
}

# Compiling C files to ASM
chdir $work_dir;
for my $cipher (@ciphers) {
    system "perl -pi -E 's/void/static void/' $cipher.c";
    system "clang -Wall -Wextra -Wno-missing-braces -O3 -I $ua_dir/arch -S $cipher.c";
}

# Counting spilling
chdir $work_dir;
for my $cipher (@ciphers) {
    open my $FH, '<', "$cipher.s";
    my ($spills, $tot);
    while (<$FH>) {
        $spills += /spill|reload/i;
        $tot++;
    }
    printf "%10s: %.2f ($spills / $tot)\n", $cipher, $spills / $tot;
}
