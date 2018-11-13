#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use autodie qw( open close );

use Crypt::DES;

my $key = pack "H16", "133457799BBCDFF1";

my $cipher = Crypt::DES->new($key);

open my $FP_IN, '<', 'input.txt';
open my $FP_OUT, '>', 'out_pl.txt';
binmode($FP_IN);
binmode($FP_OUT);

while (read($FP_IN, my $plaintext, 8)) {
    my $ciphertext = $cipher->encrypt($plaintext);
    print $FP_OUT $ciphertext;
}
