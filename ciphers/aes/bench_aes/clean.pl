#!/usr/bin/perl

use strict;
use warnings;
use v5.14;


unlink 'full_kivi';

for my $implem (qw( KIVI MACRO )) {
    for my $direct (qw( DIRECT INDIRECT )) {
        for my $expanded (qw( EXPANDED NOEXP )) {
            unlink "ua_${implem}_${direct}_${expanded}";
        }
    }
}
