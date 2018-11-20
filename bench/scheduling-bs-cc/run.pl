#!/usr/bin/perl

=usage
    
    ./compile.pl [-c] [-r]

To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
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
my @CCs     = qw(clang icc gcc);
my $CFLAGS  = '-O3 -march=native';
my $HEADERS = '-I ../../arch';
$| = 1;


my %ciphers = (
    des        => 1,
    serpent    => 0,
    aes        => 0,
    aes_kasper => 0,
    chacha20   => 0
    );
my @ciphers = grep { $ciphers{$_} } keys %ciphers;


my $compile = "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my $pwd = "$FindBin::Bin";


if ($compile) {
    print "Compiling C sources...";
    chdir "$FindBin::Bin";
    make_path "bin" unless -d "bin";
    for my $cc (@CCs) {
        for my $post (qw(nopost post)) {
            system "$cc -Os -march=native -I../../arch -o bin/$cc-noinline-$post ".
                "main_speed.c des/stream.c des/sched_$post.c";
            system "$cc -O3 -march=native -I../../arch -o bin/$cc-inline-$post ".
                "main_speed.c des/stream.c des/sched_$post.c";
        }
    }
    say " done.";
}

exit unless $run;

make_path "results" unless -d "results";

my %formatted;
for my $cc (@CCs) {
    
    my %res;
    for ( 1 .. $NB_LOOP ) {
        print "\rRunning benchs $cc... $_/$NB_LOOP";

        for my $post (qw(nopost post)) {
            for my $inline (qw(inline noinline)) {
                my $bin = "bin/$cc-$inline-$post";
                my $cycles = sprintf "%03.02f", `./$bin`; 
                push @{ $res{$bin}->{details} }, $cycles;
                $res{$bin}->{total} += $cycles;
            }
        }
            
    }
    say "\rRunning benchs $cc... done.     ";


    open my $FP_OUT, '>', "results/$cc.txt";
    say "Results $cc:";
    for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } keys %res) {
        my $size = -s $bin;
        my $name = $bin =~ s{bin/}{}r;
        printf "%13s : %03.02f  [ %s ]  {$size bytes}\n", $name, $res{$bin}->{total} / $NB_LOOP,
            (join ", ", @{$res{$bin}->{details}});
        printf $FP_OUT "%s %.02f $size\n", $name, $res{$bin}->{total} / $NB_LOOP;
    }
    say "";

}
