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
    des        => 0,
    serpent    => 0,
    aes        => 0,
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

    my $ua_args = "-arch sse -sched-n 15 -no-share";
    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        if ($cipher eq 'aes_kasper') {
            $source = "samples/usuba/aes_kasper_shufb.ua";
        }
        system "./usubac $ua_args         -o $pwd/$cipher/nounroll.c $source";
        system "./usubac $ua_args -no-arr -inline-all -o $pwd/$cipher/unroll.c   $source";
    }
    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";
    for my $cipher (@ciphers) {
        system "$CC $CFLAGS $HEADERS -D $cipher main_speed.c $cipher/stream.c $cipher/unroll.c -o bin/$cipher-unroll";
        system "$CC $CFLAGS $HEADERS -D $cipher main_speed.c $cipher/stream.c $cipher/nounroll.c -o bin/$cipher-nounroll";
    }
    say " done.";
}

exit unless $run;

make_path "results" unless -d "results";

my %formatted;
for my $cipher (@ciphers) {
    
    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cipher... $_/$NB_LOOP";

        for my $unroll (qw(nounroll unroll)) {
            my $bin = "bin/$cipher-$unroll";
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

    my $bin_unroll   = "bin/$cipher-unroll";
    my $bin_nounroll = "bin/$cipher-nounroll";
    my $speedup      = ($res{$bin_nounroll}->{total} - $res{$bin_unroll}->{total})
        / $res{$bin_nounroll}->{total} * 100;
    my $size  = ((-s $bin_unroll) - (-s $bin_nounroll)) / (-s $bin_unroll) * 100;
    $formatted{$cipher}->{speedup} = $speedup;
    $formatted{$cipher}->{size}    = $size;
    $formatted{$cipher}->{sign}    = $size >= 0 ? "+" : "";
}


open my $FP_OUT, '>', 'results/unrolling.tex';
printf $FP_OUT
"
\\newcommand{\\UnrollingChachaSpeedup}{%.2f}
\\newcommand{\\UnrollingChachaCode}{%.2f}
\\newcommand{\\UnrollingHAESSpeedup}{%.2f}
\\newcommand{\\UnrollingHAESCode}{%.2f}
",
    $formatted{chacha20}->{speedup}, $formatted{chacha20}->{size},
    $formatted{aes_kasper}->{speedup}, $formatted{aes_kasper}->{size};
