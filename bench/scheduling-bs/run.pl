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
    des        => 1,
    serpent    => 0,
    aes        => 1,
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

    my $ua_args = "-arch sse";
    for my $cipher (@ciphers) {
        my $source  = "samples/usuba/$cipher.ua";
        system "./usubac -B $ua_args -no-sched -o $pwd/$cipher/nosched.c $source";
        system "./usubac -B $ua_args           -o $pwd/$cipher/sched.c   $source";
    }
    say " done.";
}

if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";
    for my $cipher (@ciphers) {
        system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/sched.c -o bin/$cipher-sched";
        system "$CC $CFLAGS $HEADERS main_speed.c $cipher/stream.c $cipher/nosched.c -o bin/$cipher-nosched";
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

        for my $sched (qw(nosched sched)) {
            my $bin = "bin/$cipher-$sched";
            my $cycles = sprintf "%03.02f", `./$bin`; 
            push @{ $res{$bin}->{details} }, $cycles;
            $res{$bin}->{total} += $cycles;
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

    my $bin_sched   = "bin/$cipher-sched";
    my $bin_nosched = "bin/$cipher-nosched";
    my $speedup      = ($res{$bin_nosched}->{total} - $res{$bin_sched}->{total})
        / $res{$bin_nosched}->{total} * 100;
    my $size  = ((-s $bin_sched) - (-s $bin_nosched)) / (-s $bin_sched) * 100;
    $formatted{$cipher}->{speedup} = $speedup;
    $formatted{$cipher}->{size}    = $size;
    $formatted{$cipher}->{sign}    = $size >= 0 ? "+" : "";
}


open my $FP_OUT, '>', 'results/scheduling-bs.tex';
printf $FP_OUT
"\\newcommand{\\SchedulingBitsliceDESSpeedup}{%.2f}
\\newcommand{\\SchedulingBitsliceDESCode}{%.2f}
\\newcommand{\\SchedulingBitsliceAESSpeedup}{%.2f}
\\newcommand{\\SchedulingBitsliceAESCode}{%.2f}
",
    $formatted{des}->{speedup}, $formatted{des}->{size},
    $formatted{aes}->{speedup}, $formatted{aes}->{size};
    
