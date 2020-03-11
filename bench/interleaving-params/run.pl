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


my $NB_LOOP = 10;
my $CC      = 'clang';
my $CFLAGS  = '-Wall -Wextra -O3 -march=native -fno-slp-vectorize -fno-vectorize';
my $INC     = '-I ../../arch';
my @factors = (2, 3, 4, 5);
my @grains  = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20, 30, 50, 100, 200);
$| = 1;



my %ciphers = (
    des        => 0,
    serpent    => 1,
    rectangle  => 1,
    aes        => 0,
    aes_kasper => 0,
    chacha20   => 1,
    ascon      => 1,
    ace        => 1,
    clyde      => 1,
    gift       => 1,
    pyjamask   => 1,
    xoodoo     => 1,
    gimli      => 1
    );
my @ciphers = grep { $ciphers{$_} } keys %ciphers;

my $gen     = !@ARGV || "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";

if ($gen) {

    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    my $out_dir = "$pwd/generated/ciphers";
    make_path $out_dir unless -d $out_dir;

    my $ua_args = "-V -arch avx -gen-bench -no-sched -inline-all -unroll -no-pre-sched";

    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        system "./usubac $ua_args -o $out_dir/$cipher.c $source";
        system "./usubac -V -arch avx -gen-bench -interleave 5 -sched-n 4 -inline-all -unroll -no-pre-sched -o $out_dir/$cipher-2-sched.c $source";
        system "./usubac -V -arch avx -gen-bench -sched-n 4 -inline-all -unroll -no-pre-sched -o $out_dir/$cipher-sched.c $source";

        for my $grain (@grains) {
            for my $factor (@factors) {

                system "./usubac $ua_args -inter-factor $factor -interleave $grain " .
                    "-o $out_dir/${cipher}-$factor-$grain.c $source";
            }
        }
    }
    say " done.";
}


if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";

    my $out_dir = "$pwd/generated/bin";
    make_path $out_dir unless -d $out_dir;

    my $cipher_dir = "$pwd/generated/ciphers";

    for my $cipher (@ciphers) {
        system "$CC $CFLAGS $INC bench.c $cipher_dir/$cipher.c -o $out_dir/$cipher";
        system "$CC $CFLAGS $INC bench.c $cipher_dir/$cipher-2-sched.c -o $out_dir/$cipher-2-sched";
        system "$CC $CFLAGS $INC bench.c $cipher_dir/$cipher-sched.c -o $out_dir/$cipher-sched";
        for my $grain (@grains) {
            for my $factor (@factors) {
                system "$CC $CFLAGS $INC bench.c $cipher_dir/$cipher-$factor-$grain.c " .
                    "-o $out_dir/$cipher-$factor-$grain";
            }
        }
    }
    say " done.";
}

exit unless $run;

chdir $pwd;
make_path "results" unless -d "results";

my %formatted;
for my $cipher (@ciphers) {

    my $bin_dir = "$pwd/generated/bin";
    next unless -e "$bin_dir/$cipher";

    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cipher... $_/$NB_LOOP";

        for my $bin ("$bin_dir/$cipher", "$bin_dir/$cipher-2-sched", "$bin_dir/$cipher-sched") {
            if (-e $bin) {
                my $cycles = sprintf "%03.02f", `$bin`;
                push @{ $res{$bin}->{details} }, $cycles;
                $res{$bin}->{total} += $cycles;
            }
        }

        for my $grain (@grains) {
            for my $factor (@factors) {
                my $bin = "$bin_dir/$cipher-$factor-$grain";
                if (-e $bin) {
                    my $cycles = sprintf "%03.02f", `$bin`;
                    push @{ $res{$bin}->{details} }, $cycles;
                    $res{$bin}->{total} += $cycles;
                }
            }
        }
    }
    say "\rRunning benchs $cipher... done.     ";

    open my $FP_OUT, '>', "results/$cipher.txt";
    say "Results $cipher:";
    for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } keys %res) {
        my $size = -s $bin;
        my $name = $bin =~ s{$bin_dir/}{}r;
        printf "%13s : %03.02f  [ %s ]  {$size bytes}\n", $name, $res{$bin}->{total} / $NB_LOOP,
            (join ", ", @{$res{$bin}->{details}});
        printf $FP_OUT "%s %.02f $size\n", $name, $res{$bin}->{total} / $NB_LOOP;
    }
    say "";
}
