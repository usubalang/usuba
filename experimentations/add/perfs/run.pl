#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use autodie qw( open close );

my $jump_offset_base = 16; # Set to 34 for unrolling of 5

# Print output headers
say "| Padding | Jump offset |       Cycles      |   MITE uops   |   DSB uops    |" . 
    "    DSB miss   | DSB miss penalty |";
say "| ------- | ----------- | ----------------- | ------------- | ------------- |" . 
    " ------------- | ---------------- |";

for my $n (0 .. 128) {
    # Copy add.s to add some padding
    open my $FH_IN, '<', 'add.s';
    open my $FH_OUT, '>', 'tmp.s';
    while (<$FH_IN>) {
        print $FH_OUT $_;
        if (/.p2align\s*7/) {
            print $FH_OUT "\tnop\n" for 1 .. $n;
        }
    }
    close $FH_OUT;

    # Compile the new assembly file
    system "clang -o tmp tmp.s";

    # Run perf
    my $perf_output = `perf stat -e idq.dsb_uops,idq.mite_uops,frontend_retired.dsb_miss,dsb2mite_switches.penalty_cycles,cycles ./tmp 2>&1`;

    # Extract perf results from perf output
    my ($dsb_uops)       = $perf_output =~ /(\d+(?: \d+)*)\s*idq.dsb_uops/;
    my ($mite_uops)      = $perf_output =~ /(\d+(?: \d+)*)\s*idq.mite_uops/;
    my ($dsb_miss)       = $perf_output =~ /(\d+(?: \d+)*)\s*frontend_retired.dsb_miss/;
    my ($penalty_cycles) = $perf_output =~ /(\d+(?: \d+)*)\s*dsb2mite_switches.penalty_cycles/;
    my ($cycles)         = $perf_output =~ /(\d+(?: \d+)*)\s*cycles/;

    # Format number of cycles so that outliers are bolded
    if (($cycles =~ s/ //gr) < 2_400_000_000 || 
        ($cycles =~ s/ //gr) > 2_550_000_000) {
        $cycles = "**" . $cycles . "**";
    } else {
        $cycles = "  " . $cycles . "  ";
    }

    # Print the results for this padding
    printf "| %7d | %11d | %13s | %13s | %13s | %13s | %16s |\n",
        $n, $n+$jump_offset_base, $cycles, $mite_uops, $dsb_uops, 
        $dsb_miss, $penalty_cycles;
}
