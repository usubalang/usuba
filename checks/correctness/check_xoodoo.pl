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

# Compiling the compiler.
unless ($ARGV[0]) {
    say "Compiling...";
    error if system 'make';
}

for my $slicing ('vslice', 'bitslice') {
    my $temp_dir = "tmp_xoodoo_$slicing";

    say "############################# Xoodoo $slicing ############################";

    # switching to usuba dir
    chdir "$FindBin::Bin/../..";

    # Switching to temporary directory.
    say "Preparing the files for the test...";
    remove_tree $temp_dir if -d $temp_dir;
    mkdir $temp_dir;

    # Compiling Usuba Clyde.
    say "Compiling Xoodoo from Usuba to C...";
    my $slicing_flag = $slicing eq 'vslice' ? '-V' : '-B -bits-per-reg 32';
    error if system "./usubac $slicing_flag -o $temp_dir/xoodoo_ua_$slicing.c -arch std -no-sched $samples/usuba/xoodoo.ua";

    chdir $temp_dir;
    copy $_, "." for glob "$FindBin::Bin/xoodoo/*";

    # Compiling the C files
    say "Compiling the test executable...";
    my $implem_flag = $slicing eq 'vslice' ? 'UA_V' : 'UA_B';
    error if system "clang -D $implem_flag -march=native -I../arch -I . -o main main.c";

    say "Running the test...";
    error if system './main';

    chdir '..';
    remove_tree $temp_dir;

    say "$slicing Xoodoo OK.\n\n";
}
