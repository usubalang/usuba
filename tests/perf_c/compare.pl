#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use Data::Dumper;

use Benchmark qw(:all);

die "Make failed" if system 'make';
system "./make_input" unless -f 'input.txt';

my $tot_size = -s 'input.txt';

{
    my %speed;
    $speed{std} = 75;
    for my $instance (['uak-64*','test_uak_64std'], ['uak-man-64*','test_uak_manual_64std'],
                      ['kwan-64*','test_kwan'], ['uak-64','test_uak_64'], 
                      ['uak-128','test_uak_128'], ['uak-256','test_uak_256'],
                      ['ua-256','test_ua_256']
        ) {
        my $time = 0;
        $time += `./@$instance[1]` for 1 .. 10;
        $speed{@$instance[0]} = sprintf "%d", ($tot_size*16)*10 / $time / 1_000_000;
    }


    open local *STDOUT, '>', 'data_std.dat' or die $!;

    my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

    for (sort {$speed{$b} <=> $speed{$a}} keys %speed) {
        my $conv = $_ =~ /man/ ? 'uak-64*\nman' : $_ ;
        say qq{"$conv" $speed{$_}};
    }
    system "gnuplot plot_std.txt"
}

################################################################################
# No orthogonalization

{
    my %speed;
    for my $instance (['uak-64*','test_uak_64std_no'], ['uak-64','test_uak_64_no'],
                      ['uak-128','test_uak_128_no'], ['uak-256','test_uak_256_no'],
                      ['ua-256','test_ua_256_no'], ['kwan-64*','test_kwan_no'],
                      ['uak-man-64*','test_uak_manual_64std_no']) {
        my $time = 0;
        $time += `./@$instance[1]` for 1 .. 20;
        $speed{@$instance[0]} = sprintf "%d", ($tot_size*16)*20 / $time / 1_000_000;
    }
    my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

    open local *STDOUT, '>', 'data_no.dat' or die $!;
    for (sort {$speed{$b} <=> $speed{$a}} keys %speed) {
        my $conv = $_ =~ /man/ ? 'uak-64*\nman' : $_;
        say qq{"$conv" $speed{$_}};
    }
    system "gnuplot plot_no.txt"
}


################################################################################
# Code size

{
    system 'clang -o tmp -O3 -fno-inline test_kwan.c';
    my %speed;
    $speed{std} = 10;
    for my $instance (['uak-64*','test_uak_64std'], ['uak-64','test_uak_64'],
                      ['uak-128','test_uak_128'], ['uak-256','test_uak_256'],
                      ['ua-256','test_ua_256'], ['kwan-64*','test_kwan'],
                      ['kwan-64*-ni', 'tmp']) {
        $speed{@$instance[0]} = sprintf"%d",(-s @$instance[1])/1000;
    }
    my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

    open local *STDOUT, '>', 'data_size.dat' or die $!;

    for (sort {$speed{$b} <=> $speed{$a}} keys %speed) {
        my $conv = $_ =~ /ni/ ? 'uak-64*\nni' : $_;
        say qq{"$conv" $speed{$_}};
    }
    system "gnuplot plot_size.txt";
    unlink 'tmp';
}
