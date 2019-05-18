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

use FindBin;
use File::Path qw(make_path);
use File::Copy;

my $NB_LOOP = 20;
my $CC      = 'icc';
my $CFLAGS  = '-O3 -std=gnu11';
my $HEADERS = '-I ../../../arch';
$| = 1;

my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my $cipher  = 'aes';
my @archs = qw( sse avx avx2 avx512 );

my $pwd = $FindBin::Bin;

my @binaries;


if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../../..";
    my $source = "samples/usuba/aes_mslice.ua";

    # Saving a bit of time: the same code -except for the headers- is generated for
    # SSE, AVX and AVX512 (on this specific AES) -> let's only compile SSE, and
    # just change the headers for the others.
    for my $arch (qw(sse)) {
        system "./usubac -H -arch $arch -unroll -inline-all -sched-n 16 -o $pwd/$arch/aes.c $source";
    } 

    chdir $pwd;
    for my $arch (qw(avx avx512)) {
        copy "sse/aes.c", "$arch/aes.c";
        {
            local $^I = "";
            local @ARGV = "$arch/aes.c";
            while (<>) {
                s/SSE(?=\.h)/uc $arch/e;
                print;
            }
        }
    }

    say " done.";
}

chdir $pwd;

print "Compiling the C sources..." if $compile;
make_path "bin" unless -d "bin";
for my $arch (@archs) {
    my $bin = "bin/$arch";

    my $arch_flag = '';
    if    ($arch eq 'sse')    { $arch_flag = '-xSSE4.2'      }
    elsif ($arch eq 'avx')    { $arch_flag = '-xAVX'         }
    elsif ($arch eq 'avx2')   { $arch_flag = '-xAVX2'        }
    elsif ($arch eq 'avx512') { $arch_flag = '-march=native' }

    my $source_dir = "$arch/stream.c";
    if    ($arch eq 'avx')  { $source_dir = "sse/stream.c" }
    elsif ($arch eq 'avx2') { $source_dir = "avx/stream.c" }
    
    my $cmd = "$CC $CFLAGS $arch_flag $HEADERS -I . main_speed.c $source_dir -o $bin";
    system $cmd if $compile;
    push @binaries, $bin;
}

say " done." if $compile;

exit unless $run;
print "Running benchs... ";

my %res;
for ( 1 .. $NB_LOOP ) {
    print "\rRunning Benchs... $_/$NB_LOOP";
    for my $bin (@binaries) {
        my $cycles = sprintf "%03.02f", (`./$bin` || 0); 
        push @{ $res{$bin}->{details} }, $cycles;
        $res{$bin}->{total} += $cycles;
    }
}
say "\rRunning benchs... done.     ";

open my $FP_OUT, '>', 'results.txt';
say "Results:";
for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } @binaries) {
    printf "%8s : %03.02f  [ %s ]\n", $bin, $res{$bin}->{total} / $NB_LOOP,
        (join ", ", @{$res{$bin}->{details}});
    printf $FP_OUT "%8s %03.02f\n", $bin, $res{$bin}->{total} / $NB_LOOP;
}
