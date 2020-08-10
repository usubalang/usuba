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
my $source_file = "ace.ua";
my $usubac      = "../../../usubac";
my $ua_opts     = "-gen-bench -inline-all -unroll -sched-n 4";
my $bench_main  = "../../../experimentations/bench_generic/bench.c";
my $bench_opts  = "-D WARMUP=10000 -D NB_RUN=1000000";
my $c_headers   = "-I ../../../arch";
my $bin_dir     = "bin";
my @archs       = qw(sse avx);
my $nb_run      = 30;

my %c_opts = (
    sse2 => "-O3 -msse2 -fno-tree-vectorize -fno-slp-vectorize",
    sse  => "-O3 -msse4.2 -fno-tree-vectorize -fno-slp-vectorize",
    avx  => "-O3 -march=native -fno-tree-vectorize -fno-slp-vectorize"
);


sub avg_stdev {
    my $u = sum(@_) / @_; # mean
    my $s = (sum(map {($_-$u)**2} @_) / @_) ** 0.5; # stdev
    return ($u, $s);
}

if ($gen) {
    say "Generating C files...";
    for my $arch (@archs) {
        # Generating default Usuba
        system "$usubac $ua_opts -arch $arch -o ace-ua-$arch.c $source_file";
        # Generating Usuba without unrolling
        system "$usubac -gen-bench -inline-all -sched-n 4 -arch $arch -o ace-ua-no_unr-$arch.c $source_file";
    }
}


if ($compile) {
    say "Compiling C files...";
    mkdir "bin" unless -d "bin";
    # Compiling ua files
    for my $file (qw(ace-ua ace-ua-no_unr)) {
        for my $arch (@archs) {
            system "$cc $c_opts{$arch} $bench_main $bench_opts $c_headers " .
                "$file-$arch.c -o $bin_dir/$file-$arch";
        }
        # Compiling for sse2
        system "$cc $c_opts{sse2} $bench_main $bench_opts $c_headers " .
            "$file-sse.c -o $bin_dir/$file-sse2";
    }
    # Compiling ref files
    for my $arch (@archs) {
        system "$cc $c_opts{$arch} $bench_main $bench_opts $c_headers " .
            "ref-$arch/ace.c -o $bin_dir/ace-ref-$arch";
    }
    # Compiling for sse2
    system "$cc $c_opts{sse2} $bench_main $bench_opts $c_headers " .
        "ref-sse/ace.c -o $bin_dir/ace-ref-sse2";
}


push @archs, 'sse2';

if ($run) {
    say "Running benchmarks...";
    for my $arch (@archs) {
        my %times;

        for (1 .. $nb_run) {
            for my $bench (qw(ace-ua ace-ua-no_unr ace-ref)) {
                push @{$times{$bench}}, (`./$bin_dir/$bench-$arch` =~ s/ .*$//r)+0;
            }
        }

        say "Arch: $arch";

        my ($ua, $ua_stdev) = avg_stdev(@{$times{"ace-ua"}});
        printf "Usuba: %.2f   +-%.2f\n", $ua, $ua_stdev;

        my ($ref, $ref_stdev) = avg_stdev(@{$times{"ace-ref"}});
        printf "Ref  : %.2f   +-%.2f  (x%.2f)\n", $ref, $ref_stdev, $ref/$ua;

        my ($noint, $noint_stdev) = avg_stdev(@{$times{"ace-ua-no_unr"}});
        printf "\nUsuba no unrolling: %.2f   +-%.2f  (x%.2f)\n",
            $noint, $noint_stdev, $noint/$ua;

        say "\n\n", "*" x 80, "\n";
    }
}
