#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use autodie qw( open close );

my $source_file = 'add.s';

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

    printf "%3d - %3d: $cycles\n", $start_alignment, $jump_alignment;
    #if (($mite_uops=~s/ //gr) > ($dsb_uops =~ s/ //gr)) {
        say "   $mite_uops - $dsb_uops - $dsb_miss - $penalty_cycles - $cycles";
    #}
}
