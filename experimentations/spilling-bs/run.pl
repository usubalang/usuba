#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use autodie qw( open close );

use FindBin;
use File::Temp qw( tempdir );

my $ua_dir = "$FindBin::Bin/../..";
my @ciphers = qw(ace_bitslice aes ascon clyde_bitslice des gift gimli photon_bitslice present pyjamask_bitslice rectangle serpent skinny_bitslice spongent subterranean xoodoo);
my $work_dir = tempdir();


# Compiling the Usuba files to C
say "Compiling Usuba files";
chdir $ua_dir;
for my $cipher (@ciphers) {
    system "./usubac -no-arr -unroll -inline-all -no-sched -no-pre-sched -gen-bench -B -o $work_dir/$cipher.c samples/usuba/$cipher.ua";
}

# Compiling C files to ASM
say "Compiling C files";
chdir $work_dir;
for my $cipher (@ciphers) {
    system "perl -pi -E 's/void/static void/' $cipher.c";
    system "clang -Wall -Wextra -Wno-missing-braces -O3 -I $ua_dir/arch -S $cipher.c";
}

# Counting spilling
say "Computing spilling\n";
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

# Removing work directory
rmdir $work_dir;
