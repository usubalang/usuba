#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
use File::Copy::Recursive qw(rcopy dircopy);
$File::Copy::Recursive::CPRFComp = 1;
use FindBin;


sub error {
    say "************ ERROR **************\n\n";
    exit 1;
}

# Compiling the compiler.
unless ($ARGV[0]) {
    say "Compiling...";
    error if system 'make';
}

for my $slicing ('vslice', 'bitslice') {
    my $temp_dir = "tmp_ascon_$slicing";

    say "############################# Ascon $slicing ############################";

    # switching to usuba dir
    chdir "$FindBin::Bin/../..";

    # Switching to temporary directory.
    say "Preparing the files for the test...";
    remove_tree $temp_dir if -d $temp_dir;
    mkdir $temp_dir;

    # Compiling Usuba Clyde.
    say "Compiling Ascon from Usuba to C...";
    my $slicing_flag = $slicing eq 'vslice' ? '-V' : '-B';
    error if system "./usubac $slicing_flag -o $temp_dir/ascon_ua_$slicing.c -arch std -no-sched samples/usuba/ascon.ua";

    chdir $temp_dir;
    copy $_, "." for glob "$FindBin::Bin/ascon/*";

    # Compiling the C files
    say "Compiling the test executable...";
    my $implem_flag = $slicing eq 'vslice' ? 'UA_V' : 'UA_B';
    error if system "clang -D $implem_flag -O3 -march=native -I../arch -I . -o main main.c";

    say "Running the test...";

    chdir '..';
    remove_tree $temp_dir;

    say "$slicing Ascon OK.\n\n";
}