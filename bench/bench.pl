#!/usr/bin/perl

use strict; use warnings;
use v5.18;
use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;

chdir $FindBin::Bin;

unlink 'input.txt';
system 'clang -O3 -march=native -o make_input make_input.c';
system './make_input';
unlink 'make_input';

