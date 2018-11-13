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

my @grains = (1 .. 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 45, 50, 75, 100, 125, 150, 200, 300, 500, 750, 1000, 1500, 2000);


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    my $ua_args = "-arch sse -no-share -no-arr -no-sched -inline-all";

    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        if ($cipher eq 'rectangle') {
            $source = "-lf samples/usuba/rectangle_vector.ua";
        }
        system "./usubac $ua_args                        -o $pwd/$cipher/${cipher}_ua.c              $source";
        for my $grain (@grains) {
            system "./usubac $ua_args -interleave $grain -o $pwd/$cipher-inter/${cipher}_ua_$grain.c $source";
        }
    }

    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";

    system "$CC -w $CFLAGS $HEADERS main_speed.c serpent/stream.c " .
        "serpent/serpent.c serpent/serpent_ua.c -o bin/serpent";
    system "$CC -D SSE $CFLAGS $HEADERS main_speed.c rectangle/stream.c " .
        "rectangle/key.c rectangle/rectangle_ua.c -o bin/rectangle";
    
    for my $grain (@grains) {
        system "$CC -w $CFLAGS $HEADERS main_speed.c serpent-inter/stream.c " .
            "serpent-inter/serpent.c serpent-inter/serpent_ua_$grain.c -o bin/serpent-inter-$grain";
        system "$CC -D SSE $CFLAGS $HEADERS main_speed.c rectangle-inter/stream.c " .
            "rectangle-inter/key.c rectangle-inter/rectangle_ua_$grain.c -o bin/rectangle-inter-$grain";
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

        {
            my $bin = "bin/$cipher";
            my $cycles = sprintf "%03.02f", `./$bin`; 
            push @{ $res{$bin}->{details} }, $cycles;
            $res{$bin}->{total} += $cycles;
        }
        for my $grain (@grains) {
            my $bin = "bin/$cipher-inter-$grain";
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
}

