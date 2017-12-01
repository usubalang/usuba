#!/usr/bin/perl

use File::Copy qw(cp);

$cc     = 'clang';
$nb_run = 30;

for (glob ("*/run.pl")) {
    # Note that only "openmp/run.pl" ignores "$cc"
    system "./$_ $nb_run $cc";
}

mkdir "results";
cp "ortho/perf-ortho.tex", "results/";
cp "ortho2/data.dat", "results/data-ortho2.dat";
cp "des-std/data.dat", "results/data-std.dat";
cp "des-no-ortho/data.dat", "results/data-no-ortho.dat";
cp "openmp/data.dat"; "results/data-omp.dat";
cp "openmp2/data.dat"; "results/data-omp2.dat";
