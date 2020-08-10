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
my $source_file = "ascon.ua";
my $usubac      = "../../../usubac";
my $ua_opts     = "-gen-bench -inline-all -unroll";
my $bench_main  = "../../../experimentations/bench_generic/bench.c";
my $bench_opts  = "-D WARMUP=10000 -D NB_RUN=1000000";
my $c_headers   = "-I ../../../arch";
my $bin_dir     = "bin";
my $nb_run      = 30;


sub avg_stdev {
    my $u = sum(@_) / @_; # mean
    my $s = (sum(map {($_-$u)**2} @_) / @_) ** 0.5; # stdev
    return ($u, $s);
}

if ($gen) {
    say "Generating C files...";
    # Generating default Usuba
    system "$usubac $ua_opts -interleave 2 -inter-factor 2 -o ascon-ua.c $source_file";
    # Generating Usuba without interleaving
    system "$usubac $ua_opts -o ascon-ua-no_inter.c $source_file";
    # Generating Usuba without interleaving and scheduling
    system "$usubac $ua_opts -no-sched -o ascon-ua-no_inter-no_sched.c $source_file";
}


if ($compile) {
    say "Compiling C files...";
    mkdir "bin" unless -d "bin";
    for my $file (qw(ascon-ua ascon-ua-no_inter ascon-ua-no_inter-no_sched ascon-ref)) {
        system "$cc $c_opts $bench_main $bench_opts $c_headers $file.c -o $bin_dir/$file";
    }
}



if ($run) {
    say "Running benchmarks...";
    my %times;

    for (1 .. $nb_run) {
        for my $bench (qw(ascon-ua ascon-ua-no_inter ascon-ua-no_inter-no_sched ascon-ref)) {
            push @{$times{$bench}}, (`./$bin_dir/$bench` =~ s/ .*$//r)+0;
        }
    }

    my ($ua, $ua_stdev) = avg_stdev(@{$times{"ascon-ua"}});
    printf "Usuba: %.2f   +-%.2f\n", $ua, $ua_stdev;

    my ($ref, $ref_stdev) = avg_stdev(@{$times{"ascon-ref"}});
    printf "Ref  : %.2f   +-%.2f  (x%.2f)\n", $ref, $ref_stdev, $ref/$ua;

    my ($noint, $noint_stdev) = avg_stdev(@{$times{"ascon-ua-no_inter"}});
    printf "\nUsuba no inter: %.2f   +-%.2f  (x%.2f)\n",
        $noint, $noint_stdev, $noint/$ua;

    my ($nosched, $nosched_stdev) = avg_stdev(@{$times{"ascon-ua-no_inter-no_sched"}});
    printf "Usuba no sched: %.2f   +-%.2f  (x%.2f)\n",
        $nosched, $nosched_stdev, $nosched/$ua;
}
