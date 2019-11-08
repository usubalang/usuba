#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
$| = 1;
use Data::Printer;

use Getopt::Long;

my ($pattern, $nb_run, $warmup, $gen_tex, $by_cipher, $by_slicing) = ("", 100000, 10000, 1);
GetOptions("by-cipher"  => \$by_cipher,
           "by-slicing" => \$by_slicing,
           "pattern=s"  => \$pattern,
           "nb-run=i"   => \$nb_run,
           "warmup=i"   => \$warmup,
           "gen-tex"    => \$gen_tex);

# Setting by_slicing by default
if (!$by_cipher && !$by_slicing) { $by_slicing = 1 }

my %times;
my $i = 0;
for my $code (glob("nist/*/usuba/bench/*{{bit,v}slice,ref}.c")) {
    next if $code =~ /masked/; # ignoring masked implementations
    next if $pattern && $code !~ /$pattern/;

    print "\r\033[2KCompiling $code.....";
    system "clang -O3 -march=native -I arch -o _run experimentations/bench_generic/bench.c $code -D NB_RUN=$nb_run -D WARMING=$warmup";;
    print " done.";

    print "\r\033[2KRunning $code.....";
    my ($cipher,$slicing) = $code =~ m{nist/([^/]+)/(?:.*_ua_((?:bit|v)slice))?};
    $slicing = 'ref' if $code =~ /ref\.c$/;
    my ($time) = `./_run` =~ /(\d+(?:\.\d+)?)/;
    $times{by_slicing}{$slicing}{$cipher} = $time;
    $times{by_cipher}{$cipher}{$slicing}  = $time;
    print " done.";

    unlink "_run";
}
print "\r\033[2K";

if ($by_slicing) {
    for my $slicing (sort keys %{$times{by_slicing}}) {
        say "*************** $slicing ***************";
        for my $cipher (sort { $times{by_slicing}{$slicing}{$a} <=>
                                   $times{by_slicing}{$slicing}{$b} }
                        keys %{$times{by_slicing}{$slicing}}) {
            printf "%15s    %.2f\n", $cipher, $times{by_slicing}{$slicing}{$cipher};
        }
        say "";
    }
}

if ($by_cipher) {
    for my $cipher (sort keys %{$times{by_cipher}}) {
        say "##### $cipher";
        for my $slicing (sort keys %{$times{by_cipher}{$cipher}}) {
            printf "%9s    %.2f\n", $slicing, $times{by_cipher}{$cipher}{$slicing};
        }
        say "";
    }
}

if ($gen_tex) {
    open my $FP, '>', 'perfs_x86_unmasked.tex';
    for my $cipher (sort keys %{$times{by_cipher}}) {
        for my $slicing (sort keys %{$times{by_cipher}{$cipher}}) {
            next if $cipher =~ /photon|skinny/i && $slicing =~ /vslice/;
            my $time = sprintf "%.2f", $times{by_cipher}{$cipher}{$slicing};
            if ($cipher =~ /photon|skinny/i && $slicing =~ /vslice/) {
                $time = "-";
            }
            printf $FP "\\newcommand{ \\BenchIntel%s%s }{ %s }\n",
                ucfirst($cipher), ucfirst($slicing), $time;
        }
    }
}
