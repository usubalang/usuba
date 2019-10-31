#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

for my $fd (1, 2, 4) {
    for my $ti (1, 2, 4) {
        system "rm main_${fd}_${ti}";
    }
}
