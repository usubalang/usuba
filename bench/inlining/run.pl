#!/usr/bin/perl

=head

To add a new ciphers, modify the %ciphers hash.

=cut

use strict;
use warnings;
use v5.14;
use autodie qw( open close );
$| = 1;

use Cwd;
use File::Path qw( remove_tree make_path );
use File::Copy;
use File::Copy::Recursive qw( dircopy );
use FindBin;
use List::Util qw( sum max );
use JSON;
use POSIX qw( strftime );
use Term::ANSIColor;
use Statistics::Test::WilcoxonRankSum;

my @archs         = qw( std avx );
my @inlinings     = ('-inline-all', '-no-inline', '');
my $ref_inline    = ""; # Inlining option to use as reference
my $cc            = 'clang';
my $header_file   = "$FindBin::Bin/../../arch";
my $cflags        = "-march=native -O3 -fno-tree-vectorize -fno-slp-vectorize " .
                    "-Wall -Wextra -Wno-missing-braces -D WARMING=1000 -I $header_file";
my $bench_nb_run  = 300000;
my $ua_source_dir = "$FindBin::Bin/../../samples/usuba";
my $c_source_dir  = "$FindBin::Bin/C";
my $bin_dir       = "$FindBin::Bin/bin";
my $ua_flags      = '-gen-bench';
my $bench_main    = "$FindBin::Bin/bench.c";
my $res_dir       = "$FindBin::Bin/results";
my $ua_dir        = "$FindBin::Bin/../..";
my %ciphers = (
    'AES-bs'       => [ 'aes.ua',                '-B' ],
    'AES-hs'       => [ 'aes_mslice.ua',         '-H' ],
    'ACE-vs'       => [ 'ace.ua',                '-V' ],
    'ACE-bs'       => [ 'ace_bitslice.ua',       '-B' ],
    'Ascon-vs'     => [ 'ascon.ua',              '-V', '-interleave 2' ],
    'Ascon-bs'     => [ 'ascon.ua',              '-B' ],
    'Clyde-vs'     => [ 'clyde.ua',              '-V' ],
    'Clyde-bs'     => [ 'clyde_bitslice.ua',     '-B' ],
    'DES'          => [ 'des.ua',                '-B' ],
    'Chacha20'     => [ 'chacha20.ua',           '-V' ],
    'Gift-vs'      => [ 'gift.ua',               '-V' ],
    'Gift-bs'      => [ 'gift_bitslice.ua',      '-B' ],
    'Gimli-vs'     => [ 'gimli.ua',              '-V' ],
    'Gimli-bs'     => [ 'gimli_bitslice.ua',     '-B -unroll -inline-all' ],
    'Photon-bs'    => [ 'photon_bitslice.ua',    '-B', '-no-sched' ],
    'Present'      => [ 'present.ua',            '-B' ],
    'Pyjamask-vs'  => [ 'pyjamask_vslice.ua',    '-V' ],
    'Pyjamask-bs'  => [ 'pyjamask_bitslice.ua',  '-B' ],
    'Rectangle-vs' => [ 'rectangle.ua',          '-V', '-interleave 2' ],
    'Rectangle-hs' => [ 'rectangle.ua',          '-H', '-interleave 2' ],
    'Rectangle-bs' => [ 'rectangle_bitslice.ua', '-B' ],
    'Serpent'      => [ 'serpent.ua',            '-V', '-interleave 2' ],
    'Skinny-bs'    => [ 'skinny_bitslice.ua',    '-B' ],
    'Spongent'     => [ 'spongent.ua',           '-B' ],
    'Subterranean' => [ 'subterranean.ua',       '-B' ],
    );
my $nb_run = 20;

my $make     = !@ARGV || "@ARGV" =~ /-m/;
my $gen      = !@ARGV || "@ARGV" =~ /-g/;
my $compile  = !@ARGV || "@ARGV" =~ /-c/;
my $run      = !@ARGV || "@ARGV" =~ /-r/;

sub avg_stdev {
    my $u = sum(@_) / @_; # mean
    my $s = (sum(map {($_-$u)**2} @_) / @_) ** 0.5; # stdev
    return ($u, $s);
}


if ($make) {
    chdir $ua_dir;

    say "-----------------------------------------------------------------------";
    say "------------------------- Recompiling Usuba   -------------------------";
    say "-----------------------------------------------------------------------";
    die if system 'make';
    say "\n";
}

if ($gen) {
    chdir $ua_dir;
    remove_tree $c_source_dir if -d $c_source_dir;
    make_path $c_source_dir;

    say "-----------------------------------------------------------------------";
    say "-------------------- Compiling from Usuba to C ------------------------";
    say "-----------------------------------------------------------------------";
    for my $cipher (sort keys %ciphers) {
        say "\t- $cipher....";
        for my $arch (@archs) {
            for my $inline (@inlinings) {
                next if $arch eq 'std' && $cipher =~ /-hs$/;
                my ($ua_file, @opts) = @{$ciphers{$cipher}};
                system "./usubac $ua_flags $inline -arch $arch -o " .
                    "$c_source_dir/$cipher$inline-$arch.c @opts " .
                    "$ua_source_dir/$ua_file";
            }
        }
    }
    say "\n";
}

if ($compile) {
    say "-----------------------------------------------------------------------";
    say "-------------------------- Compiling C files --------------------------";
    say "-----------------------------------------------------------------------";

    remove_tree $bin_dir if -d $bin_dir;
    make_path $bin_dir;

    for my $cipher (sort keys %ciphers) {
        say "\t- $cipher....";
        for my $arch (@archs) {
            for my $inline (@inlinings) {
                next if $arch eq 'std' && $cipher eq 'AES-hs';
                my $this_nb_run = (grep { $_ eq '-B' } @{$ciphers{$cipher}}) ?
                    $bench_nb_run / 20 : $bench_nb_run;
                system "$cc $cflags -D NB_RUN=$this_nb_run $bench_main $c_source_dir/$cipher$inline-$arch.c -o $bin_dir/$cipher$inline-$arch";
            }
        }
    }
    say "\n";
}


if ($run) {
    say "-----------------------------------------------------------------------";
    say "---------------------------- Benchmarking -----------------------------";
    say "-----------------------------------------------------------------------";

    my %times;
    for (1 .. $nb_run) {
        for my $cipher (sort keys %ciphers) {
            print "\r\033[2K\t- $cipher ($_ / $nb_run)";
            for my $arch (@archs) {
                next if $arch eq 'std' && $cipher =~ /-hs$/;
                for my $inline (@inlinings) {
                    push @{$times{$arch}->{$inline}->{$cipher}},
                        0+(`$bin_dir/$cipher$inline-$arch` =~ s/^\d+(\.\d+)?\K.*\n?//r);
                }
            }
        }
    }
    say "\r\033[2KBenchmarking done.";


    say "Computing statistics...\n";
    make_path $res_dir unless -d $res_dir;
    my $res_file = "$res_dir/result.txt";
    open my $FH, '>', $res_file;

    my $longest_str_cipher = max map { length } keys %ciphers;


    for my $arch (@archs) {

        say "Arch: $arch";

        say join "-+-", ("-" x ($longest_str_cipher)), map { "-" x 8 } 1 .. 3;
        printf "%*s | %16s | %16s | %16s\n", $longest_str_cipher, 'cipher',
            'no-inline', '-inline-all', 'auto-inline';
        say join "-+-", ("-" x ($longest_str_cipher)), map { "-" x 8 } 1 .. 3;

        for my $cipher (sort keys %ciphers) {
            next if $arch eq 'std' && $cipher =~ /-hs$/;
            my %mean;
            for my $inline (@inlinings) {
                @{$times{$arch}->{$inline}->{$cipher}} =
                    (sort { $a <=> $b } @{$times{$arch}->{$inline}->{$cipher}})
                    [1 .. $nb_run - 2];
                ($mean{$arch}->{$inline}->{$cipher}) =
                    avg_stdev(@{$times{$arch}->{$inline}->{$cipher}});
            }

            my $ref_mean = $mean{$arch}->{"-no-inline"}->{$cipher};

            my ($perf_all, $perf_auto) =
                map { sprintf "%.2f", $mean{$arch}->{$_}->{$cipher} / $ref_mean }
                "-inline-all", "";

            my ($prob_all, $prob_auto) =
                map { my $wilcox = Statistics::Test::WilcoxonRankSum->new();
                      $wilcox->load_data($times{$arch}->{$_}->{$cipher},
                                         $times{$arch}->{"-no-inline"}->{$cipher});
                      $wilcox->probability() }
                "-inline-all", "";

            my ($color_all, $color_auto) =
                map { $_->[0] > 0.05 ? 'yellow' : $_->[1] > 1 ? 'red' : 'green' }
                [$prob_all, $perf_all], [$prob_auto, $perf_auto];


            printf "%*s | %16s | %s%16s%s | %s%16s%s\n",
                $longest_str_cipher, $cipher, 1,
                color($color_all), "x$perf_all", color('reset'),
                color($color_auto),  "x$perf_auto",  color('reset');
            printf $FH "%*s | %16s | %16s | %16s\n",
                $longest_str_cipher, $cipher, 1,
                "x$perf_all", "x$perf_auto";
        }
        say "\n";
    }
    close $FH;
}
