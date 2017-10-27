#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;

chdir $FindBin::Bin;

chdir '..';
system 'make clean && make';
chdir $FindBin::Bin;

unlink 'input.txt';
system 'clang -O3 -march=native -o make_input make_input.c';
system './make_input';
unlink 'make_input';

system "./opti/array/run.pl";
system "./opti/CSE-CP/run.pl";
system "./opti/inlining/run.pl";
system "./opti/scheduling/run.pl";

system "./eval/bdd/run.pl";
system "./eval/des-no-ortho/run.pl";
system "./eval/des-std/run.pl";
system "./eval/des-std/run2.pl";
