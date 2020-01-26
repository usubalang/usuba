#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use autodie qw( open close );

my $source_file = 'add.s';

say "| Padding |       Cycles      |   MITE uops   |   DSB uops    |" . 
    "    DSB miss   | DSB miss penalty |";
say "| ------- | ----------------- | ------------- | ------------- |" . 
    " ------------- | ---------------- |";

for my $n (0 .. 128) {
    open my $FH_IN, '<', $source_file;
    open my $FH_OUT, '>', 'tmp.s';
    while (<$FH_IN>) {
        print $FH_OUT $_;
        if (/.p2align\s*7/) {
            print $FH_OUT "\tnop\n" for 1 .. $n;
        }
    }
    close $FH_OUT;

    system "clang -o tmp tmp.s";
    my $perf_output = `perf stat -e idq.dsb_uops,idq.mite_uops,frontend_retired.dsb_miss,dsb2mite_switches.penalty_cycles,cycles ./tmp 2>&1`;
    my ($dsb_uops)       = $perf_output =~ /(\d+(?: \d+)*)\s*idq.dsb_uops/;
    my ($mite_uops)      = $perf_output =~ /(\d+(?: \d+)*)\s*idq.mite_uops/;
    my ($dsb_miss)       = $perf_output =~ /(\d+(?: \d+)*)\s*frontend_retired.dsb_miss/;
    my ($penalty_cycles) = $perf_output =~ /(\d+(?: \d+)*)\s*dsb2mite_switches.penalty_cycles/;
    my ($cycles)         = $perf_output =~ /(\d+(?: \d+)*)\s*cycles/;

    my $start_alignment = $n;
    my $jump_alignment = $n+16;

    if (($cycles =~ s/ //gr) < 2_400_000_000 || 
        ($cycles =~ s/ //gr) > 2_600_000_000) {
        $cycles = "**" . $cycles . "**";
    } else {
        $cycles = "  " . $cycles . "  ";
    }
    
    printf "| %7d | %13s | %13s | %13s | %13s | %16s |\n",
      $n, $cycles, $mite_uops, $dsb_uops, $dsb_miss, $penalty_cycles
}
