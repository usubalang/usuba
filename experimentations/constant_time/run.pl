#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use List::Util qw( sum max min );

my $nb_mesure = 1000;

my $CC     = "clang";
my $CFLAGS = "-O3 -march=native -I ../../arch";

system "$CC $CFLAGS -c des.c";


my @times;

# Full 0 & full 1
#system "$CC -DFULL_ZERO=1 $CFLAGS -o main main.c des.o";
#push @times, [ split ' ', `./main` ];
#system "$CC -DFULL_ONE=1 $CFLAGS -o main main.c des.o";
#push @times, [ split ' ', `./main` ];

# Random values
system "$CC $CFLAGS -o main main.c des.o";
for my $i (1 .. $nb_mesure) {
    my $seed = int(rand(1<<63));
    push @times, [ split ' ', `./main $seed` ];
}

open my $FH, '>', 'data.txt' or die $!;
for (@times) {
    say $FH "@$_"
}
close $FH;

__END__
# Find the global min & max
# and remove values > 1.3 * min
my ($min_glob,$max_glob) = (1<<63,-1);
my @sorted_times;
for (@times) {
    my @sorted = sort { $a <=> $b } @$_;
    my $min = $sorted[0];
    @sorted = grep { $_ < 1.3 * $min } @sorted;
    my $max = $sorted[-1];
    push @sorted_times, \@sorted;
    ($min_glob,$max_glob) = (min($min_glob,$min),max($max_glob,$max));
}

# print the elements per buckets
open my $FH, '>', 'data.txt' or die $!;
my ($min,$max) = ($min_glob,$max_glob);
my $bck_size = ($max-$min) / 100;
for (@sorted_times) {
    my @data = (0)x100;
    my $limit = $min + $bck_size;
    my $i = 0;
    for (@$_) {
        if ($_ > $limit) {
            $limit += $bck_size;
            $i++;
            redo;
        }
        $data[$i]++;
    }
    say $FH "@data";
}
close $FH;
