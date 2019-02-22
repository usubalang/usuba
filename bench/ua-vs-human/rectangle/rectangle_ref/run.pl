#!/usr/bin/perl

=usage
    
    ./compile.pl [-c] [-r]

No '-g' option, since this script doesn't benchmark Usuba codes.
To compile and run, `./compile.pl` (or `./compile.pl -c -r`).
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`

=cut
    
use v5.14;
use strict;
use warnings;
use autodie qw( open close );

use File::Path qw( make_path );
use FindBin;

my $NB_LOOP = 20;

my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;

my @arch = qw( gp sse avx );


chdir $FindBin::Bin;

# Compiling
if ($compile) {
    print "Compiling the C sources...";
    make_path 'bin' unless -d 'bin';
    for my $arch (@arch) {
        my $bin = $arch eq 'avx' ? 'avx2' : 
                  $arch eq 'sse' ? 'avx'  : 
                  $arch eq 'gp'  ? 'std'  :
                  $arch;     
        my $arch_flag = "USE_" . (uc $arch);
        my $cmd = "clang++ -I ../../../../arch -D$arch_flag -march=native -w -O3 -c crypt.cpp test.cpp timing.cpp key.cpp main.cpp && clang++ -O3 -march=native -o bin/$bin timing.o crypt.o key.o test.o main.o";
        system $cmd;
        if ($arch eq 'sse') {
            my $cmd = "clang++ -I ../../../../arch -D$arch_flag -msse4.2 -w -O3 -c crypt.cpp test.cpp timing.cpp key.cpp main.cpp && clang++ -O3 -msse4.2 -o bin/sse timing.o crypt.o key.o test.o main.o";
            system $cmd;
        }
    }
    say " done.";
}

exit unless $run;

# Running the benchs
my @binaries = qw( std sse avx avx2 );
my %res;
print "Running benchs... ";
for ( 1 .. $NB_LOOP ) {
    print "\rRunning Benchs... $_/$NB_LOOP";
    for my $arch (@binaries) {
        my $encrypt = `./bin/$arch`;
        push @{ $res{$arch}->{details} }, (sprintf "%.2f", $encrypt);
        $res{$arch}->{total} += $encrypt;
    }
}
say "\rRunning benchs... done.     ";

open my $FP_OUT, '>', 'results.txt';
say "Results:";
for my $arch (@binaries) {
    printf "%8s : %03.02f  [ %s ]\n", $arch, $res{$arch}->{total} / $NB_LOOP,
      (join ", ", @{$res{$arch}->{details}});
    printf $FP_OUT "%8s %03.02f\n", $arch, $res{$arch}->{total} / $NB_LOOP;
}
close $FP_OUT;


unlink $_ for glob("*.o");
