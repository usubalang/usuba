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


my $NB_LOOP = 1;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../arch';
$| = 1;


my %ciphers = (
    des        => 1,
    serpent    => 1,
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

    my $ua_args = "-arch sse -no-arr -sched-n 5";
    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        if ($cipher eq 'aes_kasper') {
            $source = "samples/usuba/aes_kasper_shufb.ua";
        }
        system "./usubac $ua_args -no-inline  -o $pwd/$cipher/inline.c $source";
        system "./usubac $ua_args -inline-all -o $pwd/$cipher/noinline.c $source";
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
        my $name = $bin =~ s{bin/}{}r;
        printf "%13s : %03.02f  [ %s ]\n", $name, $res{$bin}->{total} / $NB_LOOP,
            (join ", ", @{$res{$bin}->{details}});
        printf $FP_OUT "%s %.02f\n", $name, $res{$bin}->{total} / $NB_LOOP;
    }
    say "";
}
