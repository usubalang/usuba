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
use List::MoreUtils qw( zip_unflatten );

my @archs         = qw( std avx );
my $cc            = 'clang';
my $header_file   = "$FindBin::Bin/arch";
my $cflags        = "-march=native -O3 -fno-slp-vectorize -fno-tree-vectorize " .
                    "-Wall -Wextra -Wno-missing-braces -D WARMING=1000 -I $header_file";
my $bench_nb_run  = 300000;
my $ua_source_dir = "$FindBin::Bin/samples/usuba";
my $c_source_dir  = "/tmp/ua-bench/C";
my $bin_dir       = "/tmp/ua-bench/bin";
my $ua_flags      = '-gen-bench -unroll';
my $bench_main    = "$FindBin::Bin/experimentations/bench_generic/bench.c";
my $res_file      = "/tmp/ua-bench/results.txt";
my $ua_dir        = "$FindBin::Bin";
my %ciphers = (
    'AES-bs'       => [ 'aes.ua',                '-B', '-no-sched' ],
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
    'Gift-fix'     => [ 'gift_fixslice.ua',      '-V' ],
    'Gift-bs'      => [ 'gift.ua',               '-B' ],
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
    'Skinny-bs'    => [ 'skinny_bitslice.ua',    '-B', '-no-pre-sched' ],
    'Spongent'     => [ 'spongent.ua',           '-B' ],
    'Subterranean' => [ 'subterranean.ua',       '-B' ],
    'Xoodoo-vs'    => [ 'xoodoo.ua',             '-V' ],
    'Xoodoo-bs'    => [ 'xoodoo.ua',             '-B' ],
    );
my $nb_run = 30;

my @opts = (
    '-no-inline',
    '-inline-all',
    '',
    '-bench-inline');
my $ref_opt = $opts[0];
# If first argument is a number, then this is the number of the opts
# to use as reference.
if ($opts[0] =~ /^(\d+)$/) {
    @opts    = @opts[1 .. $#opts];
    $ref_opt = $opts[$1];
}

my $make     = 1;
my $gen      = 1;
my $compile  = 1;
my $run      = 1;

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
            next if $arch eq 'std' && $cipher =~ /-hs$/;
            for my $opt (@opts) {
                my $opt_name = $opt =~ y/ /_/r;
                my ($ua_file, @specific_opts) = @{$ciphers{$cipher}};
                system "./usubac $ua_flags $opt @specific_opts -arch $arch -o " .
                    "$c_source_dir/$cipher-$opt_name-$arch.c " .
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
            next if $arch eq 'std' && $cipher =~ /-hs/;
            for my $opt (@opts) {
                my $opt_name = $opt =~ y/ /_/r;
                my $this_nb_run = (grep { $_ eq '-B' } @{$ciphers{$cipher}}) ?
                    $bench_nb_run / 20 : $bench_nb_run;
                system "$cc $cflags -D NB_RUN=$this_nb_run $bench_main $c_source_dir/$cipher-$opt_name-$arch.c -o $bin_dir/$cipher$opt_name-$arch";
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
                for my $opt (@opts) {
                    my $opt_name = $opt =~ y/ /_/r;
                    push @{$times{$arch}->{$opt}->{$cipher}},
                        0+(`$bin_dir/$cipher$opt_name-$arch` =~ s/^\d+(\.\d+)?\K.*\n?//r);
                }
            }
        }
    }
    say "\r\033[2KBenchmarking done.";


    say "Computing statistics...\n";
    open my $FH, '>', $res_file;

    my $longest_str_cipher = max map { length } keys %ciphers;
    my %lengths = map { $_ => max(6, length($_)) } @opts;


    for my $arch (@archs) {

        say "Arch: $arch";

        printf "%*s ", $longest_str_cipher, 'cipher';
        printf $FH "%*s ", $longest_str_cipher, 'cipher';
        for my $opt (@opts) {
            printf "| %*s ", $lengths{$opt}, $opt;
            printf $FH "| %*s ", $lengths{$opt}, $opt;
        }
        printf "\n";
        printf $FH "\n";
        printf "-" x ($longest_str_cipher);
        printf $FH "-" x ($longest_str_cipher);
        for my $opt (@opts) {
            print "-|", "-" x ($lengths{$opt}+1);
            print $FH "-|", "-" x ($lengths{$opt}+1);
        }
        printf "\n";
        printf $FH "\n";

        for my $cipher (sort keys %ciphers) {
            next if $arch eq 'std' && $cipher =~ /-hs$/;
            my %mean;
            for my $opt (@opts) {
                next unless grep { $_ > 0 } @{$times{$arch}->{$opt}->{$cipher}};
                @{$times{$arch}->{$opt}->{$cipher}} =
                    (sort { $a <=> $b } @{$times{$arch}->{$opt}->{$cipher}})
                    [1 .. $nb_run - 2];
                ($mean{$arch}->{$opt}->{$cipher}) =
                    avg_stdev(@{$times{$arch}->{$opt}->{$cipher}});
            }

            my $ref_mean = $mean{$arch}->{$ref_opt}->{$cipher};

            my @perfs =
                map {
                    $mean{$arch}->{$_}->{$cipher} ?
                        sprintf "%.2f", $mean{$arch}->{$_}->{$cipher} / $ref_mean :
                        "-"
                }
                @opts;

            my @probs =
                map {
                    $mean{$arch}->{$_}->{$cipher} ?
                        do {
                            my $wilcox = Statistics::Test::WilcoxonRankSum->new();
                            $wilcox->load_data($times{$arch}->{$_}->{$cipher},
                                               $times{$arch}->{$ref_opt}->{$cipher});
                            $wilcox->probability()} :
                        "-"
                }
                @opts;

            my @colors =
                map {
                    $_->[0] =~ /\d/ ?
                        $_->[0] > 0.05 ? 'yellow' : $_->[1] > 1 ? 'red' : 'green' :
                        'white'
                }
                zip_unflatten(@probs, @perfs);


            printf "%*s ", $longest_str_cipher, $cipher;
            printf $FH "%*s ", $longest_str_cipher, $cipher;
            for my $i (0 .. $#opts) {
                printf "| %s%*s%s ", color($colors[$i]), $lengths{$opts[$i]},"x$perfs[$i]", color('reset');
                printf $FH "| %s%*s%s ", color($colors[$i]), $lengths{$opts[$i]},"x$perfs[$i]", color('reset');
            }
            printf "\n" ;
            printf $FH "\n" ;
        }
        say "\n";
        say $FH "\n";
    }
    close $FH;
}
