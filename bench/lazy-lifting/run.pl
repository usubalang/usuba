#!/usr/bin/perl

=usage
    
    ./compile.pl [-g] [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

=cut
    
use strict;
use warnings;
no warnings qw( numeric );
use v5.14;

use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use FindBin;


my $NB_LOOP = 20;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../arch';
$| = 1;


my %ciphers = (
    des        => 0,
    serpent    => 1,
    'serpent-inter'   => 0,
    rectangle   => 1,
    'rectangle-inter' => 0,
    aes        => 0,
    aes_kasper => 0,
    chacha20   => 0
    );
my @ciphers = grep { $ciphers{$_} } keys %ciphers;


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    my $ua_args = "-arch sse -no-share -no-arr -no-sched";

    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        if ($cipher eq 'rectangle') {
            $source = "samples/usuba/rectangle_vector.ua";
        }
        for my $lazy (qw(lazy nolazy)) {
            my $lazy_opt = $lazy eq 'lazy' ? '-lf' : '';
            for my $inter (qw(inter nointer)) {
                my $inter_opt = $inter eq 'inter' ? '-interleave 10' : '';
                system "./usubac $ua_args $lazy_opt $inter_opt -o $pwd/$cipher/${lazy}_${inter}.c $source";
            }
        }
    }

    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";

    for my $cipher (@ciphers) {
        my $add_source = $cipher eq 'rectangle' ? 'rectangle/key.c' : 'serpent/serpent.c';
        for my $lazy (qw(lazy nolazy)) {
           for my $inter (qw(inter nointer)) {
               system "$CC -w $CFLAGS $HEADERS -D _$cipher -D $lazy -D $inter main_speed.c $cipher/stream.c $add_source $cipher/${lazy}_${inter}.c -o bin/$cipher-$lazy-$inter";
           }
        }
    }

    say " done.";
}

exit unless $run;

make_path "results" unless -d "results";

my %formatted;
for my $cipher (@ciphers) {
    
    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cipher... $_/$NB_LOOP";

        for my $inter (qw(inter nointer)) {
            for my $lazy (qw(lazy nolazy)) {
                my $bin = "bin/$cipher-$lazy-$inter";
                my $cycles = sprintf "%03.02f", `./$bin`; 
                push @{ $res{$bin}->{details} }, $cycles;
                $res{$bin}->{total} += $cycles;
            }
        }
    }
    say "\rRunning benchs $cipher... done.     ";

    open my $FP_OUT, '>', "results/$cipher.txt";
    say "Results $cipher:";
    for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } keys %res) {
        my $size = -s $bin;
        my $name = $bin =~ s{bin/}{}r;
        printf "%13s : %03.02f  [ %s ]  {$size bytes}\n", $name, $res{$bin}->{total} / $NB_LOOP,
            (join ", ", @{$res{$bin}->{details}});
        printf $FP_OUT "%s %.02f $size\n", $name, $res{$bin}->{total} / $NB_LOOP;
    }
    say "";

    for my $inter (qw(inter nointer)) {
        my $bin_nolazy = "bin/$cipher-nolazy-$inter";
        my $bin_lazy   = "bin/$cipher-lazy-$inter";
        my $speedup    = ($res{$bin_nolazy}->{total} - $res{$bin_lazy}->{total})
            / $res{$bin_nolazy}->{total} * 100;
        my $size  = ((-s $bin_lazy) - (-s $bin_nolazy)) / (-s $bin_lazy) * 100;
        $formatted{"$cipher$inter"}->{speedup} = $speedup;
        $formatted{"$cipher$inter"}->{size}    = $size;
        $formatted{"$cipher$inter"}->{sign}    = $size >= 0 ? "+" : "";
    }
}


open my $FP_OUT, '>', 'results/lazy-lifting.tex';
printf $FP_OUT
"
\\newcommand{\\LazyLiftingSerpentInterSpeedup}{%.02f}
\\newcommand{\\LazyLiftingSerpentInterCode}{%.02f}

\\newcommand{\\LazyLiftingRectangleInterSpeedup}{%.02f}
\\newcommand{\\LazyLiftingRectangleInterCode}{%.02f}

\\newcommand{\\LazyLiftingSerpentSpeedup}{%.02f}
\\newcommand{\\LazyLiftingSerpentCode}{%.02f}

\\newcommand{\\LazyLiftingRectangleSpeedup}{%.02f}
\\newcommand{\\LazyLiftingRectangleCode}{%.02f}
",
    $formatted{serpentinter}->{speedup},     $formatted{serpentinter}->{size},
    $formatted{rectangleinter}->{speedup},   $formatted{rectangleinter}->{size},
    $formatted{serpentnointer}->{speedup},   $formatted{serpentnointer}->{size},
    $formatted{rectanglenointer}->{speedup}, $formatted{rectanglenointer}->{size};
    
