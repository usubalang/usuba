#!/usr/bin/perl

=usage
    
    ./compile.pl [-g] [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

Note that for Serpent and AES, you might have to manually modify the Sbox files
the Usuba uses. (Via index_sbox.ml or by modifying the files directly)

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
    serpent    => 0,
    aes_kasper => 1,
    chacha20   => 1,
    aes        => 0,
    des        => 0
    );
my @ciphers = grep { $ciphers{$_} } keys %ciphers;
my $max_sched = 20;


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    my $ua_args = "-arch sse -inline-all -no-arr";
    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        system "./usubac $ua_args -no-sched -o $pwd/$cipher/sched_0.c $source";
        for my $n (1 .. $max_sched) {
            system "./usubac $ua_args -sched-n $n -o $pwd/$cipher/sched_$n.c $source";
        }
    }
    say " done.";
}


if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    for my $cipher (@ciphers) {
        for my $n (0 .. $max_sched) {
            system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/sched_$n.c -o bin/$cipher-$n";
        }
    }


    say " done.";
}


exit unless $run;

for my $cipher (@ciphers) {
    
    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cipher... $_/$NB_LOOP";
        
        for my $n (0 .. $max_sched) {
            my $bin = "bin/$cipher-$n";
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
