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

for my $slicing ('vslice', 'bitslice') {
    my $temp_dir = "tmp_gimli_masked_$slicing";

    say "############################ Gimli-masked $slicing ###########################";

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

    # Compiling Usuba Gimli.
    say "Compiling Gimli from Usuba to C...";
    my $slicing_flag = $slicing eq 'vslice' ? '-V' : '-B -inline-all';
    my $file_end = $slicing eq 'vslice' ? '' : '_bitslice';
    error if system "./usubac -masked $slicing_flag -o $temp_dir/gimli_ua_$slicing.c -arch std -no-share samples/usuba/gimli$file_end.ua" ;

    chdir $temp_dir;
    copy $_, "." for glob "$FindBin::Bin/gimli_masked/*";

    # Compiling the C files
    say "Compiling the test executable...";
    my $implem_flag = $slicing eq 'vslice' ? 'UA_V' : 'UA_B';
    error if system "clang -D $implem_flag -D MASKING_ORDER=4 -Wno-incompatible-pointer-types -march=native -I../arch -I . -o main main.c";

    say "Running the test...";
    error if system './main';

    chdir '..';
    remove_tree $temp_dir;

    say "$slicing Gimli-masked OK.\n\n";
}
