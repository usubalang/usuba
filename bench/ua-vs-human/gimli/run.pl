#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use utf8;
use open qw( :encoding(UTF-8) :std );
use autodie qw( open close );

use List::Util qw( sum );

use FindBin;
chdir "$FindBin::Bin";

my $gen     = "@ARGV" =~ /-[ag]/;
my $compile = "@ARGV" =~ /-[ac]/;
my $run     = !@ARGV || "@ARGV" =~ /-[ar]/;


my $cc          = "clang";
my $c_opts      = "-O3 -march=native -fno-tree-vectorize -fno-slp-vectorize";
my $source_file = "gimli.ua";
my $usubac      = "../../../usubac";
my $ua_opts     = "-gen-bench -inline-all -unroll";
my $bench_main  = "../../../experimentations/bench_generic/bench.c";
my $bench_opts  = "-D WARMUP=10000 -D NB_RUN=4000000";
my $c_headers   = "-I ../../../arch";
my $bin_dir     = "bin";
my @archs       = qw(sse avx);
my $nb_run      = 30;


sub avg_stdev {
    my $u = sum(@_) / @_; # mean
    my $s = (sum(map {($_-$u)**2} @_) / @_) ** 0.5; # stdev
    return ($u, $s);
}

if ($gen) {
    say "Generating C files...";
    for my $arch (@archs) {
        # Generating default Usuba
        system "$usubac $ua_opts -arch $arch -o gimli-ua-$arch.c $source_file";
    }
}


if ($compile) {
    say "Compiling C files...";
    mkdir "bin" unless -d "bin";
    for my $arch (@archs) {
        system "$cc $c_opts $bench_main $bench_opts $c_headers " .
            "gimli-ua-$arch.c -o $bin_dir/gimli-ua-$arch";
        system "$cc $c_opts $bench_main $bench_opts $c_headers " .
            "gimli-ref-$arch.c -o $bin_dir/gimli-ref-$arch";
        system "$cc $c_opts $bench_main $bench_opts $c_headers " .
            "gimli-ref-$arch-2.c -o $bin_dir/gimli-ref-2-$arch";
    }
}

if ($run) {
    say "Running benchmarks...";
    for my $arch (@archs) {
        my %times;

        for (1 .. $nb_run) {
            for my $bench (qw(gimli-ua gimli-ref gimli-ref-2)) {
                push @{$times{$bench}}, (`./$bin_dir/$bench-$arch` =~ s/ .*$//r)+0;
            }
        }

        say "Arch: $arch";

        my ($ua, $ua_stdev) = avg_stdev(@{$times{"gimli-ua"}});
        printf "Usuba: %.2f   +-%.2f\n", $ua, $ua_stdev;

        my ($ref, $ref_stdev) = avg_stdev(@{$times{"gimli-ref"}});
        printf "Ref  : %.2f   +-%.2f  (x%.2f)\n", $ref, $ref_stdev, $ref/$ua;

        my ($ref2, $ref2_stdev) = avg_stdev(@{$times{"gimli-ref-2"}});
        printf "Ref 2: %.2f   +-%.2f  (x%.2f)\n", $ref2, $ref2_stdev, $ref2/$ua;

        say "\n\n", "*" x 80, "\n";
    }
}
