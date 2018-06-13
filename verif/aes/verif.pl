#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

no warnings 'once';

use FindBin;
chdir $FindBin::Bin;

use File::Copy::Recursive qw(dircopy);
use File::Path qw(remove_tree);


system 'head -c 8M </dev/urandom > input.txt';
system './aes_ctr.pl';

for my $arch (qw(sse avx)) {
    remove_tree $arch;
    dircopy "../../supercop/crypto_stream/aes128ctr/usuba-$arch", $arch;
    chdir $arch;
    open TMP, '>', 'crypto_stream.h' or die $!;
    system 'clang -O3 -march=native -c stream.c';
    chdir '..';
    system "clang -O3 -march=native $arch/stream.o -o main main.c";
    system './main';
    die "Invalid $arch." if system 'diff out_c.txt out_pl.txt';
    unlink 'out_c.txt', "$arch/stream.o";
}

unlink 'out_pl.txt', 'out_c.txt', 'input.txt', 'main';
system 'rm -rf avx sse';


say "AES OK.";
