#!/usr/bin/perl

=usage
    
    ./compile.pl [-g] [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

=cut
    
use strict;
use warnings;
no warnings qw( numeric );
use v5.14;

use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;


my $NB_LOOP = 20;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../arch';
$| = 1;


my %ciphers = (
    des        => 1,
    serpent    => 0, # Not good with inlining (scheduling actually)
    aes        => 1,
    aes_kasper => 1,
    chacha20   => 1
    );
my @ciphers = grep { $ciphers{$_} } keys %ciphers;
my @scheds  = qw(nosched sched);

my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    for my $sched (@scheds) {
        my $sched_opt   = $sched eq 'nosched' ? '-no-sched' : '-sched-n 5';
        my $ua_args = "-arch sse -no-arr -no-share $sched_opt";
        for my $cipher (@ciphers) {
            my $source  = "samples/usuba/$cipher.ua";
            my $sched_flag = $cipher eq 'des' || $cipher eq 'aes' ? '' : '-inline-all';
            if ($cipher eq 'aes_kasper') {
                $source = "samples/usuba/aes_kasper_shufb.ua";
            }
            system "./usubac $ua_args -no-inline  -o $pwd/$cipher/noinline-$sched.c $source";
            system "./usubac $ua_args $sched_flag -o $pwd/$cipher/inline-$sched.c   $source";
        }
    }
    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    for my $sched (@scheds) {
        for my $cipher (@ciphers) {
            system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/inline-$sched.c -o bin/$cipher-inline-$sched";
            system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/noinline-$sched.c -o bin/$cipher-noinline-$sched";
        }
    }
    say " done.";
}

exit unless $run;

my %formatted;
for my $sched (@scheds) {
    for my $cipher (@ciphers) {
        
        my %res;
        for ( 1 .. $NB_LOOP ) {
            print "\rRunning benchs $cipher... $_/$NB_LOOP";

            for my $inline (qw(noinline inline)) {
                my $bin = "bin/$cipher-$inline-$sched";
                my $cycles = sprintf "%03.02f", `./$bin`; 
                push @{ $res{$bin}->{details} }, $cycles;
                $res{$bin}->{total} += $cycles;
            }
        }
        say "\rRunning benchs $cipher... done.     ";


        open my $FP_OUT, '>', "results/$cipher-$sched.txt";
        say "Results $cipher:";
        for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } keys %res) {
            my $size = -s $bin;
            my $name = $bin =~ s{bin/}{}r;
            printf "%13s : %03.02f  [ %s ]  {$size bytes}\n", $name, $res{$bin}->{total} / $NB_LOOP,
            (join ", ", @{$res{$bin}->{details}});
            printf $FP_OUT "%s %.02f $size\n", $name, $res{$bin}->{total} / $NB_LOOP;
        }
        say "";

        my $bin_inline   = "bin/$cipher-inline-$sched";
        my $bin_noinline = "bin/$cipher-noinline-$sched";
        my $speedup      = ($res{$bin_noinline}->{total} - $res{$bin_inline}->{total})
            / $res{$bin_noinline}->{total} * 100;
        my $size  = ((-s $bin_inline) - (-s $bin_noinline)) / (-s $bin_inline) * 100;
        $formatted{$sched}->{$cipher}->{speedup} = $speedup;
        $formatted{$sched}->{$cipher}->{size}    = $size;
        $formatted{$sched}->{$cipher}->{sign}    = $size >= 0 ? "+" : "";
    }
}


open my $FP_OUT, '>', 'results/inlining-sched.tex';
printf $FP_OUT
"\\centering
  \\begin{tabular}{|l K{3cm}|K{3cm}|K{3cm}|}
    \\hline
    \\textbf{cipher} & \\textbf{speedup} & \\textbf{code size (B)}\\\\
    \\hline
    DES & +%02.01f\\%% & %s%.01f\\%% \\\\
    \\hline
    Chacha20 & +%02.02f\\%% & %s%.01f\\%% \\\\
    \\hline
    AES (bitslice) & +%02.02f\\%% & %s%.01f\\%% \\\\
    \\hline
    AES (H-slice) & +%02.02f\\%% & %s%.01f\\%% \\\\
    \\hline
\\end{tabular}",
    $formatted{sched}->{des}->{speedup}, $formatted{sched}->{des}->{sign}, $formatted{sched}->{des}->{size},
    $formatted{sched}->{chacha20}->{speedup}, $formatted{sched}->{chacha20}->{sign}, $formatted{sched}->{chacha20}->{size},
    $formatted{sched}->{aes}->{speedup}, $formatted{sched}->{aes}->{sign}, $formatted{sched}->{aes}->{size},
    $formatted{sched}->{aes_kasper}->{speedup}, $formatted{sched}->{aes_kasper}->{sign}, $formatted{sched}->{aes_kasper}->{size};
close $FP_OUT;

open $FP_OUT, '>', 'results/inlining-nosched.tex';
printf $FP_OUT
"
\\newcommand{\\InliningNoschedDESSpeedup}{%.2f}
\\newcommand{\\InliningNoschedDESCode}{%.2f}
\\newcommand{\\InliningNoschedAESSpeedup}{%.2f}
\\newcommand{\\InliningNoschedAESCode}{%.2f}",
    $formatted{nosched}->{des}->{speedup}, $formatted{nosched}->{des}->{sign}, $formatted{nosched}->{des}->{size},
    $formatted{nosched}->{aes}->{speedup}, $formatted{nosched}->{aes}->{sign}, $formatted{nosched}->{aes}->{size};
    
