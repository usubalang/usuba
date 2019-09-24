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


for my $slicing ('bitslice', 'vslice') {

    my $temp_dir = "tmp_pyjamask_$slicing";

    say "############################ Pyjamask $slicing ###########################";

    # switching to usuba dir
    chdir "$FindBin::Bin/../..";

    # Compiling the compiler.
    unless ($ARGV[0]) {
        say "Compiling...";
        error if system 'make';
    }


    # Switching to temporary directory.
    say "Preparing the files for the test...";
    remove_tree $temp_dir if -d $temp_dir;
    mkdir $temp_dir;

    # Compiling Usuba DES.
    say "Compiling Pyjamask from Usuba to C...";
    my $slicing_flag = $slicing eq 'bitslice' ? '-B' : '-V';
    error if system "./usubac $slicing_flag -o $temp_dir/pyjamask_ua_$slicing.c -arch std -no-share -no-sched samples/usuba/pyjamask_$slicing.ua" ;

    chdir $temp_dir;
    copy $_, "." for glob "$FindBin::Bin/pyjamask/*";

    for my $ARCH (qw(STD)) {
        # Compiling the C files
        say "Compiling the test executable with $ARCH...";
        my $slicing_flag = $slicing eq 'bitslice' ? 'UA_B' : 'UA_V';
        error if system "clang -Wno-incompatible-pointer-types -march=native -I../arch -I . -o main -D $slicing_flag main.c";

        say "Running the test with $ARCH...";
        error if system './main';
    }

    chdir '..';
    remove_tree $temp_dir;

    say ucfirst "$slicing Pyjamask OK.\n\n";
}
