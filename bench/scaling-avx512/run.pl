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

my $NB_LOOP      = 20;
my $CC           = 'clang';
my $CFLAGS       = '-O3 -std=gnu11 -fno-tree-vectorize -fno-slp-vectorize -mtune=native';
my $HEADERS      = '-I ../../arch';
my $UA_OPTS      = '-gen-bench -sched-n 1 -unroll -no-arr';
my $NB_RUN       = 100000;
my $bench_main   = "$FindBin::Bin/../../experimentations/bench_generic/bench.c";
my $c_source_dir = "$FindBin::Bin/C";
my $bin_dir      = "$FindBin::Bin/bin";
my $ua_dir       = "$FindBin::Bin/../..";
$| = 1;


my $gen     = "@ARGV" =~ /-g/;
my $compile = !@ARGV || "@ARGV" =~ /-c/;
my $run     = !@ARGV || "@ARGV" =~ /-r/;


my @ua_archs = qw( std sse avx avx512 );
my %bin_archs = (
    std    => ['std',    ''              ],
    sse    => ['sse',    '-msse4.2'      ],
    avx    => ['sse',    '-mavx'         ],
    avx2   => ['avx',    '-mavx2'        ],
    avx512 => ['avx512', '-mavx512f -mavx512bw -march=native' ]);
my %ciphers = (
    'AES-bs'          => [ 'aes.ua',                '-B' ],
    'AES-hs'          => [ 'aes_mslice.ua',         '-H -inline-all' ],
    'ACE-vs'          => [ 'ace.ua',                '-V' ],
    'ACE-bs'          => [ 'ace_bitslice.ua',       '-B' ],
    'Ascon-vs'        => [ 'ascon.ua',              '-V', '-interleave 2 -inline-all' ],
    'Ascon-bs'        => [ 'ascon.ua',              '-B' ],
    'Clyde-vs'        => [ 'clyde.ua',              '-V -inline-all' ],
    'Clyde-bs'        => [ 'clyde_bitslice.ua',     '-B' ],
    'DES-bs'          => [ 'des.ua',                '-B' ],
    'Chacha20-vs'     => [ 'chacha20.ua',           '-V' ],
    'Gift-vs'         => [ 'gift.ua',               '-V -inline-all' ],
    'Gift-fix-vs'     => [ 'gift_fixslice.ua',      '-V' ],
    'Gift-bs'         => [ 'gift.ua',               '-B' ],
    'Gimli-vs'        => [ 'gimli.ua',              '-V -inline-all' ],
    'Gimli-bs'        => [ 'gimli_bitslice.ua',     '-B -no-arr -unroll -inline-all' ],
    'Photon-bs'       => [ 'photon_bitslice.ua',    '-B', '-no-sched' ],
    'Present-bs'      => [ 'present.ua',            '-B' ],
    'Pyjamask-vs'     => [ 'pyjamask_vslice.ua',    '-V -inline-all' ],
    'Pyjamask-bs'     => [ 'pyjamask_bitslice.ua',  '-B' ],
    'Rectangle-vs'    => [ 'rectangle.ua',          '-V', '-interleave 2 -inline-all' ],
    'Rectangle-hs'    => [ 'rectangle.ua',          '-H', '-interleave 2 -inline-all' ],
    'Rectangle-bs'    => [ 'rectangle_bitslice.ua', '-B' ],
    'Serpent-vs'      => [ 'serpent.ua',            '-V', '-interleave 2' ],
    'Serpent-bs'      => [ 'serpent.ua',            '-B' ],
    'Skinny-bs'       => [ 'skinny_bitslice.ua',    '-B', '-no-pre-sched' ],
    'Spongent-bs'     => [ 'spongent.ua',           '-B' ],
    'Subterranean-bs' => [ 'subterranean.ua',       '-B' ],
    'Xoodoo-vs'       => [ 'xoodoo.ua',             '-V' ],
    'Xoodoo-bs'       => [ 'xoodoo.ua',             '-B' ],
    );

if ($gen) {
    print "Compiling Usuba sources...";
    chdir $ua_dir;
    make_path $c_source_dir unless -d $c_source_dir;

    for my $cipher (keys %ciphers) {
        for my $arch (@ua_archs) {
            next if $cipher =~ /-hs$/ && $arch eq 'std';
            my $implem = "$cipher-$arch";
            my ($ua_file, @specific_opts) = @{$ciphers{$cipher}};
            system "./usubac $UA_OPTS -arch $arch @specific_opts -o $c_source_dir/$implem.c samples/usuba/$ua_file";
        }
    }

    say " done.";
}

if ($compile) {
    print "Compiling the C sources...";
    make_path $bin_dir unless -d $bin_dir;
    for my $cipher (keys %ciphers) {
        for my $arch (keys %bin_archs) {
            next if $cipher =~ /-hs$/ && $arch eq 'std';
            my ($ua_arch, $arch_flag) = @{$bin_archs{$arch}};

            my $bin_implem = "$cipher-$arch";
            my $c_implem   = "$cipher-$ua_arch";

            my $this_nb_run = $cipher =~ /-bs$/ ? $NB_RUN / 100 : $NB_RUN;

            system "$CC $CFLAGS $HEADERS $arch_flag -D WARMING=1000 -D NB_RUN=$this_nb_run $bench_main $c_source_dir/$c_implem.c -o $bin_dir/$bin_implem";
        }
    }

    say " done.";
}

exit unless $run;
print "Running benchs... ";

my %res;
for ( 1 .. $NB_LOOP ) {
    print "\rRunning Benchs... $_/$NB_LOOP";
    for my $cipher (keys %ciphers) {
        for my $arch (keys %bin_archs) {
            next if $cipher =~ /-hs$/ && $arch eq 'std';
            my $implem = "$cipher-$arch";
            my $cycles = sprintf "%03.02f", (`$bin_dir/$implem` || 0);
            push @{ $res{$cipher}->{$arch}->{details} }, $cycles;
            $res{$cipher}->{$arch}->{total} += $cycles;
        }
    }
}
say "\rRunning benchs... done.     ";

open my $FH, '>', 'results.dat';
say $FH q{cipher "GP (64-bit)"   "SSE (128-bit)"     "AVX (128-bit)"     "AVX2 (256-bit)"    "AVX512 (512-bit)"};
for my $implem (sort sort_ciphers keys %res) {
    my ($cipher, $s) = $implem =~ /^(\S+)-(\S+)$/;
    my $slicing = $s eq "hs" ? "hslice" : $s eq "vs" ? "vslice" : "bitslice";
    my $sse_perf = $res{$implem}{sse}{total};
    printf $FH qq{"$cipher \\n ($slicing)"   %.2f  1  %.2f   %.2f   %.2f\n},
        $res{$implem}{std}{total} ? $sse_perf / $res{$implem}{std}{total} : 0,
        $sse_perf / $res{$implem}{avx}{total},
        $sse_perf / $res{$implem}{avx2}{total},
        $sse_perf / $res{$implem}{avx512}{total};
}

sub sort_ciphers {
    my ($c_a, $s_a) = $a =~ /^(\S+)-(\S+)$/;
    my ($c_b, $s_b) = $b =~ /^(\S+)-(\S+)$/;
    return ($s_a cmp $s_b) || ($c_a cmp $c_b);
}
