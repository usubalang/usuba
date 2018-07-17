#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Cwd;
use File::Path qw( remove_tree );
use File::Copy;
use File::Copy::Recursive qw(dircopy fcopy rcopy);
use FindBin;

sub error {
    say "************ ERROR **************";
    exit $?;
}

my $temp_dir = "tmp_fd";

say "############################## Fault detection ###########################";

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
dircopy "$FindBin::Bin/fd", $temp_dir;

say "Compiling AES/DES sbox from Usuba to C...";
error if system "./usubac -o $temp_dir/aes_sbox/sbox.c -no-arr -no-arr-entry -no-share samples/usuba/sbox_aes_kasper.ua";
error if system "./usubac -o $temp_dir/aes_sbox/sbox_fd.c -fd -no-arr -no-arr-entry -no-share samples/usuba/sbox_aes_kasper.ua";
error if system "./usubac -o $temp_dir/des_sbox_1/sbox.c -no-arr -no-arr-entry -no-share samples/usuba/sbox1_des.ua";
error if system "./usubac -o $temp_dir/des_sbox_1/sbox_fd.c -fd -no-arr -no-arr-entry -no-share samples/usuba/sbox1_des.ua";

# Renaming the fd versions
{
    local $^I = "";
    local @ARGV = ("$temp_dir/aes_sbox/sbox_fd.c","$temp_dir/des_sbox_1/sbox_fd.c");
    while(<>) {
        s/f__/_fd_f__/;
    } continue { print }
}

chdir $temp_dir;

error if system 'make test';

chdir '..';
remove_tree $temp_dir;

say "Fault detection OK.\n\n";
