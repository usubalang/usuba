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

my $NB_LOOP = 20;
my $CC      = 'clang';
my $CFLAGS  = '-O3 -std=gnu11';
my $HEADERS = '-I ../../arch -I .';
$| = 1;


my $gen     = "@ARGV" =~  /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my $cipher   = 'rectangle';
my @archs = qw( std sse avx avx2 avx512 );
my @slicings = qw( vslice-inter bitslice hslice-inter  );

my @binaries;

my $pwd = "$FindBin::Bin";

my %comp_opt = (
    icc   => { std    => '-D std',
               sse    => '-xSSE4.2 -D sse',
               avx    => '-xAVX -D sse',
               avx2   => '-xAVX2 -D avx',
               avx512 => '-march=native -D avx512' },
    clang   => { std    => '-D std',
                 sse    => '-msse4.2 -D sse',
                 avx    => '-mavx -D sse',
                 avx2   => '-mavx2 -D avx',
                 avx512 => '-march=native -D avx512' },
    );

if ($gen) {
    print "Compiling Usuba sources...";
    chdir "$FindBin::Bin/../..";

    # Bitslice
    for my $arch (qw(std sse avx avx512)) {
        my $source = "samples/usuba/rectangle_bitslice.ua";
        system "./usubac -B -arch $arch -o $pwd/bitslice/$arch.c $source";
    }
    # Hslice + interleaving
    for my $arch (qw(sse avx avx512)) {
        my $source = "samples/usuba/rectangle.ua";
        system "./usubac -H -arch $arch -interleave 2 -o $pwd/hslice-inter/$arch.c $source";
    }
    # Vslice + interleaving
    for my $arch (qw(std sse avx avx512)) {
        my $source = "samples/usuba/rectangle.ua";
        my $lf = $arch =~ /avx/ ? '-lf' : '';
        system "./usubac -V $lf -arch $arch -interleave 5 -o $pwd/vslice-inter/$arch.c $source";
    }

    say " done.";
}

chdir $pwd;

print "Compiling the C sources..." if $compile;
make_path "bin" unless -d "bin";
for my $arch (@archs) {
    for my $slicing (@slicings) {
        my $bin = "bin/$arch-$slicing";

        my $arch_flag = $comp_opt{$CC}->{$arch};

        my $source_dir = "$slicing/$arch.c";
        if    ($arch eq 'avx')  { $source_dir = "$slicing/sse.c" }
        elsif ($arch eq 'avx2') { $source_dir = "$slicing/avx.c" }

        next if $arch eq 'std' && $slicing eq 'hslice-inter';
        my $cmd = "$CC $arch_flag $CFLAGS $HEADERS -I . -D $arch main.c key.c $slicing/stream.c $source_dir -o $bin";
        system $cmd if $compile;
        push @binaries, $bin;
    }
}

say " done." if $compile;

exit unless $run;
print "Running benchs... ";
my %res;
for ( 1 .. $NB_LOOP ) {
    print "\rRunning Benchs... $_/$NB_LOOP";
    for my $bin (@binaries) {
        my ($encrypt,$ortho) = `./$bin` =~  /Usuba: (\d+\.\d+)\s*Ortho: (\d+\.\d+)/;
        $encrypt ||= 0; $ortho ||= 0;
        push @{ $res{$bin}->{details} }, (sprintf "%.2f", $encrypt);
        $res{$bin}->{total} += $encrypt;
        $res{$bin}->{ortho} += $ortho;
    }
}
say "\rRunning benchs... done.     ";

open my $FP_OUT, '>', 'plot/results.txt';
say "Results:";
for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } @binaries) {
    my $name = $bin =~ s{bin/}{}r;
    printf "%8s : %03.02f/%03.02f  [ %s ]\n", $name, $res{$bin}->{total} / $NB_LOOP,
        $res{$bin}->{ortho} / $NB_LOOP, (join ", ", @{$res{$bin}->{details}});
    printf $FP_OUT "%8s %03.02f %03.02f\n", $name, $res{$bin}->{total} / $NB_LOOP,
        $res{$bin}->{ortho} / $NB_LOOP;
}
close $FP_OUT;

# Removing "ortho" from "total" (so that "new_total + ortho = old_total")
for my $bin (keys %res) {
    $res{$bin}->{total} -= $res{$bin}->{ortho};
}

# Printing formatted results for plotting
{ # STD
    open my $FP_OUT, '>', 'plot/std.dat';
    printf $FP_OUT
q{"Rectangle cipher" %.2f %.2f -
Transposition %.2f %.2f -},
    map { my $measure = $_; map { $res{"bin/std-$_"}->{$measure} / $NB_LOOP }
          qw(vslice-inter bitslice) } qw(total ortho);
}
{ # SSE
    open my $FP_OUT, '>', 'plot/sse.dat';
    printf $FP_OUT
q{"Rectangle cipher" %.2f %.2f %.2f
Transposition %.2f %.2f %.2f},
    map { my $measure = $_; map { $res{"bin/sse-$_"}->{$measure} / $NB_LOOP }
          qw(vslice-inter bitslice hslice-inter) } qw(total ortho);
}
{ # AVX
    open my $FP_OUT, '>', 'plot/avx.dat';
    printf $FP_OUT
q{"Rectangle cipher" %.2f %.2f %.2f
Transposition %.2f %.2f %.2f},
    map { my $measure = $_; map { $res{"bin/avx-$_"}->{$measure} / $NB_LOOP }
          qw(vslice-inter bitslice hslice-inter) } qw(total ortho);
}
{ # AVX2
    open my $FP_OUT, '>', 'plot/avx2.dat';
    printf $FP_OUT
q{"Rectangle cipher" %.2f %.2f %.2f
Transposition %.2f %.2f %.2f},
    map { my $measure = $_; map { $res{"bin/avx2-$_"}->{$measure} / $NB_LOOP }
          qw(vslice-inter bitslice hslice-inter) } qw(total ortho);
}
{ # AVX512
    open my $FP_OUT, '>', 'plot/avx512.dat';
    printf $FP_OUT
q{"Rectangle cipher" %.2f %.2f %.2f
Transposition %.2f %.2f %.2f},
    map { my $measure = $_; map { $res{"bin/avx512-$_"}->{$measure} / $NB_LOOP }
          qw(vslice-inter bitslice hslice-inter) } qw(total ortho);
}
