#!/usr/bin/perl

use File::Copy qw(cp);

system "./mono/run.pl";
system "./multi1/run.pl";
system "./multi2/run.pl";

mkdir "results";
cp "mono/altivec.tex", "results/altivec.tex";
cp "mono/data.txt", "results/mono.txt";
cp "multi1/data.txt", "results/multi1.txt";
cp "multi2/data.txt", "results/multi2.txt";
