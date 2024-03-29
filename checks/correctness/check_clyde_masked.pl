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

use require::relative "../../subroutines.pl";

my $samples = samples_location();

sub error {
    say "************ ERROR **************\n\n";
    exit 1;
}

for my $slicing (qw(bitslice vslice)) {
    my $temp_dir = "tmp_clyde_masked_$slicing";

    say "############################ Clyde-masked $slicing ###########################";

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

    # Compiling Usuba Clyde.
    say "Compiling Clyde-masked from Usuba to C...";
    my $slicing_flag = $slicing eq 'vslice' ? '-V' : '-B';
    error if system "./usubac -ua-masked $slicing_flag -o $temp_dir/clyde_ua_$slicing.c -arch std -no-share $samples/usuba/clyde.ua" ;

    chdir $temp_dir;
    copy $_, "." for glob "$FindBin::Bin/clyde_masked/*";

    for my $ARCH (qw(STD)) {
        # Compiling the C files
        say "Compiling the test executable with $ARCH...";
        my $implem_flag = $slicing eq 'vslice' ? 'UA_V' : 'UA_B';
        error if system "clang -D $implem_flag -D MASKING_ORDER=4 -march=native -I../arch -I . -o main main.c";

        say "Running the test with $ARCH...";
        error if system './main';
    }

    chdir '..';
    remove_tree $temp_dir;

    say "$slicing Clyde-masked OK.\n\n";
}
