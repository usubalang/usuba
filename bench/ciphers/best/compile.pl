#!/usr/bin/perl

=usage
    
    ./compile.pl [-c] [-r] [-l]

To collect only, `./compile.pl` (or `./compile.pl -l`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`
To collect the results only, `./compile.pl -l`

=cut

use strict;
use warnings;
no warnings qw( numeric );
use v5.14;

use FindBin;
use File::Path qw(make_path);


my $gen     = "@ARGV" =~ /-g/;
my $compile = "@ARGV" =~ /-c/;
my $run     = "@ARGV" =~ /-r/;
my $collect = !@ARGV || "@ARGV" =~ /-l/;
@ARGV = grep { ! /-l/ } @ARGV;

my %ciphers = (
    'aes-bs'    => 'BitsliceAES',
    'aes-hs'    => 'HAES',
    'des'       => 'DES',
    'chacha20'  => 'Chacha',
    'rectangle' => 'Rectangle',
    'serpent'   => 'Serpent'
    );    
my @ciphers = keys %ciphers;

if ($gen || $compile || $run) {
    for my $cipher (@ciphers) {
        say "$cipher:";
        chdir $cipher;
        system "./compile.pl @ARGV";
        chdir "..";
    }
}

my %res;
if ($collect) {
    for my $cipher (@ciphers) {
        next unless -f "$cipher/results.txt";
        open my $FP_IN, '<', "$cipher/results.txt";
        while (<$FP_IN>) {
            my ($cc,$num) = split;
            my $name = $ciphers{$cipher};
            if ($cipher eq 'rectangle') {
                my ($slicing,$cc2) = split '-', $cc;
                $cc = $cc2;
                $name = $slicing eq 'hslice' ? 'HRectangle' :
                        $slicing eq 'vslice' ? 'VRectangle' :
                        'BitsliceRectangle';
            }
            $cc = ucfirst $cc;
            $res{$name}->{$cc} = $num;
        }
    }
}

open my $FP_OUT, '>', 'AVX2throughput.tex';
for my $cipher (sort keys %res) {
    my ($best) = sort { $res{$cipher}->{$a} <=> $res{$cipher}->{$b} } keys %{$res{$cipher}};
    printf $FP_OUT "\\newcommand{\\AVXtwo%sThroughput}{%s}\n",
                   $cipher, $res{$cipher}->{$best};
    print $FP_OUT "\\newcommand{\\AVXtwo${cipher}BestCC}{$best}\n";
    for my $cc (sort { $res{$cipher}{$a} <=> $res{$cipher}{$b} } keys %{$res{$cipher}}) {
        printf $FP_OUT "\\newcommand{\\AVXtwo%sThroughput%s}{%s}\n",
           $cipher, $cc, $res{$cipher}->{$cc};
    }
}
