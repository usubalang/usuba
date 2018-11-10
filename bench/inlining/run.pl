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


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    my $ua_args = "-arch sse -no-arr -sched-n 15";
    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        if ($cipher eq 'aes_kasper') {
            $source = "samples/usuba/aes_kasper_shufb.ua";
        }
        system "./usubac $ua_args -no-inline  -o $pwd/$cipher/noinline.c $source";
        system "./usubac $ua_args -inline-all -o $pwd/$cipher/inline.c   $source";
    }
    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    for my $cipher (@ciphers) {
        system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/inline.c -o bin/$cipher-inline";
        system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/noinline.c -o bin/$cipher-noinline";
    }
    say " done.";
}

exit unless $run;

my %formatted;
for my $cipher (@ciphers) {
    
    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cipher... $_/$NB_LOOP";

        for my $inline (qw(noinline inline)) {
            my $bin = "bin/$cipher-$inline";
            my $cycles = sprintf "%03.02f", `./$bin`; 
            push @{ $res{$bin}->{details} }, $cycles;
            $res{$bin}->{total} += $cycles;
        }
    }
    say "\rRunning benchs $cipher... done.     ";


    open my $FP_OUT, '>', "results/$cipher.txt";
    say "Results $cipher:";
    for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } keys %res) {
        my $size = -s $bin;
        my $name = $bin =~ s{bin/}{}r;
        printf "%13s : %03.02f  [ %s ]  {$size bytes}\n", $name, $res{$bin}->{total} / $NB_LOOP,
            (join ", ", @{$res{$bin}->{details}});
        printf $FP_OUT "%s %.02f $size\n", $name, $res{$bin}->{total} / $NB_LOOP;
    }
    say "";

    my $bin_inline   = "bin/$cipher-inline";
    my $bin_noinline = "bin/$cipher-noinline";
    my $speedup      = ($res{$bin_noinline}->{total} - $res{$bin_inline}->{total})
        / $res{$bin_noinline}->{total} * 100;
    my $size  = ((-s $bin_inline) - (-s $bin_noinline)) / (-s $bin_inline) * 100;
    $formatted{$cipher}->{speedup} = $speedup;
    $formatted{$cipher}->{size}    = $size;
    $formatted{$cipher}->{sign}    = $size >= 0 ? "+" : "";
}


open my $FP_OUT, '>', 'results/inlining.tex';
printf $FP_OUT
"\\centering
  \\begin{tabular}{|l K{2cm}|K{1.5cm}|K{2cm}|K{2cm}|}
    \\hline
    & \\textbf{cipher} & \\textbf{speedup} & \\textbf{code size (B)}\\\\
    \\hline
    des & +%02.01f%% & %s%.01f%% \\\\
    \\hline
    chacha20 & +%02.02f%% & %s%.01f%% \\\\
    \\hline
    aes (bitslice) & +%02.02f%% & %s%.01f%% \\\\
    \\hline
    aes (H-slice) & +%02.02f%% & %s%.01f%% \\\\
    \\hline
    \\end{tabular}
  \\caption{Inlining}
  \\label{tbl:perf-inlining}",
    $formatted{des}->{speedup}, $formatted{des}->{sign}, $formatted{des}->{size},
    $formatted{chacha20}->{speedup}, $formatted{chacha20}->{sign}, $formatted{chacha20}->{size},
    $formatted{aes}->{speedup}, $formatted{aes}->{sign}, $formatted{aes}->{size},
    $formatted{aes_kasper}->{speedup}, $formatted{aes_kasper}->{sign}, $formatted{aes_kasper}->{size};
    
