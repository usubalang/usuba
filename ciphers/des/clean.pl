#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

for my $arch (qw( std sse avx )) {
    for my $implem (qw( ua kwan )) {
        my $bin = "$implem-$arch";
        unlink $bin;
    }
}
