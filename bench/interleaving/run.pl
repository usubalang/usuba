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
    serpent    => 1,
    'serpent-inter'   => 0,
    rectangle   => 1,
    'rectangle-inter' => 0,
    aes        => 0,
    aes_kasper => 0,
    chacha20   => 0
    );
my @ciphers = grep { $ciphers{$_} } keys %ciphers;


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    my $ua_args = "-arch sse -no-share -no-arr -no-sched";

    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        if ($cipher eq 'rectangle') {
            $source = "-lf samples/usuba/rectangle_vector.ua";
        }
        system "./usubac $ua_args                -o $pwd/$cipher/${cipher}_ua.c       $source";
        system "./usubac $ua_args -interleave 30 -o $pwd/$cipher-inter/${cipher}_ua.c $source";
    }

    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";

    system "$CC -w $CFLAGS $HEADERS main_speed.c serpent/stream.c " .
        "serpent/serpent.c serpent/serpent_ua.c -o bin/serpent";
    system "$CC -w $CFLAGS $HEADERS main_speed.c serpent-inter/stream.c " .
        "serpent-inter/serpent.c serpent-inter/serpent_ua.c -o bin/serpent-inter";
    
    system "$CC -D SSE $CFLAGS $HEADERS main_speed.c rectangle/stream.c " .
        "rectangle/key.c rectangle/rectangle_ua.c -o bin/rectangle";
    system "$CC -D SSE $CFLAGS $HEADERS main_speed.c rectangle-inter/stream.c " .
        "rectangle-inter/key.c rectangle-inter/rectangle_ua.c -o bin/rectangle-inter";
    
    say " done.";
}

exit unless $run;

make_path "results" unless -d "results";

my %formatted;
for my $cipher (@ciphers) {
    
    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cipher... $_/$NB_LOOP";

        for my $bin ("bin/$cipher", "bin/$cipher-inter") {
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

    my $bin_nointer = "bin/$cipher";
    my $bin_inter   = "bin/$cipher-inter";
    my $speedup      = ($res{$bin_nointer}->{total} - $res{$bin_inter}->{total})
        / $res{$bin_nointer}->{total} * 100;
    my $size  = ((-s $bin_inter) - (-s $bin_nointer)) / (-s $bin_inter) * 100;
    $formatted{$cipher}->{speedup} = $speedup;
    $formatted{$cipher}->{size}    = $size;
    $formatted{$cipher}->{sign}    = $size >= 0 ? "+" : "";
}


open my $FP_OUT, '>', 'results/interleaving.tex';
printf $FP_OUT
"
\\newcommand{\\InterleavingSerpentSpeedup}{%.02f}
\\newcommand{\\InterleavingSerpentCode}{%.02f}

\\newcommand{\\InterleavingRectangleSpeedup}{%.02f}
\\newcommand{\\InterleavingRectangleCode}{%.02f}
",
    $formatted{serpent}->{speedup}, $formatted{serpent}->{size},
    $formatted{rectangle}->{speedup}, $formatted{rectangle}->{size};
    
