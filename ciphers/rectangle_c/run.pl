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

use FindBin;
use File::Path qw(make_path);

my $NB_LOOP = 1;
my $CC      = 'icc';
my $CFLAGS  = '-O3 -std=gnu11';
my $HEADERS = '-I arch -I .';
$| = 1;

my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my $cipher   = 'rectangle';
my @archs = qw( std sse avx avx2 avx512 );
my @slicings = qw( vslice-inter bitslice hslice-inter  );

my @binaries;

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
        push @{ $res{$bin}->{details} }, (sprintf "%.2f", $encrypt);
        $res{$bin}->{total} += $encrypt;
        $res{$bin}->{ortho} += $ortho;
    }
}
say "\rRunning benchs... done.     ";

open my $FP_OUT, '>', 'data/results.txt';
say "Results:";
for my $bin (sort { $res{$a}->{total} <=> $res{$b}->{total} } @binaries) {
    my $name = $bin =~ s{bin/}{}r;
    printf "%8s : %03.02f/%03.02f  [ %s ]\n", $name, $res{$bin}->{total} / $NB_LOOP,
        $res{$bin}->{ortho} / $NB_LOOP, (join ", ", @{$res{$bin}->{details}});
    printf $FP_OUT "%8s %03.02f %03.02f\n", $name, $res{$bin}->{total} / $NB_LOOP,
        $res{$bin}->{ortho} / $NB_LOOP;
}
close $FP_OUT;

my %formatted;
for my $bin (@binaries) {
    my ($arch, $slicing) = split '-', ($bin =~ s{bin/}{}r), 2;
    $slicing =~ s/-inter//; # Cleaning vslice-inter
    $formatted{$arch}->{$slicing} = $res{$bin}->{total} / $NB_LOOP;
}

open $FP_OUT, '>', 'data/data.dat';
printf $FP_OUT qq{
Title                  "vsliced"   "bitsliced"   "hsliced"
"GP\\n(64-bits)"          %.2f        %.2f          %s
"SSE\\n(128-bits)"        %.2f        %.2f         %.2f
"AVX\\n(128-bits)"        %.2f        %.2f         %.2f
"AVX2\\n(256-bits)"       %.2f        %.2f         %.2f
"AVX512\\n(512-bits)"     %.2f        %.2f         %.2f
},
    map { my $arch = $_; 
          map { my $slicing = $_;
                $slicing =~ s/-inter//;
                $formatted{$arch}->{$slicing} // "-" } 
          @slicings }
    @archs; 
