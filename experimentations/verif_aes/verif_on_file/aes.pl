#!/usr/bin/perl

use strict; use warnings;
use v5.14;

use Crypt::Mode::ECB;

open my $FH, '<', 'input.txt';

chomp(my $plaintext = <$FH>);

my $key = "0123456789ABCDEF";
my $ecb = Crypt::Mode::ECB->new('AES');
my $ciphertext = $ecb->encrypt($plaintext, $key);

open $FH, '>', 'out.txt' or die $!;
print $FH $ciphertext;
close $FH;
