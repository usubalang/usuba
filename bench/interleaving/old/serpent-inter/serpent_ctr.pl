#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Crypt::Mode::CTR;

my $key       = pack 'H*', '2b7e151628aed2a6abf7158809cf4f3c';
my $iv        = pack 'H*', 'f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff';


open my $FH, '<', 'input.txt';

local $/;
my $plaintext = <$FH>;

my $m = Crypt::Mode::CTR->new('Serpent',1);
my $ciphertext = $m->encrypt($plaintext, $key, $iv);


open $FH, '>', 'out_pl.txt' or die $!;
print $FH $ciphertext;
close $FH;
