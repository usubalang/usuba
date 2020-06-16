#!/usr/bin/perl

use strict;
use warnings;
use v5.18;
use autodie qw(open close);

use FindBin;
use List::Util qw(max);

my $c_dir   = "$FindBin::Bin/C";
my $ua_dir  = "$FindBin::Bin/../..";
# Inlining and unrolling to be able to compute easily the number of
# instructions.  -no-sched and -no-pre-sched to save time because
# those optimizations wont impact the number of C instructions.
my $ua_opts = '-inline-all -unroll -no-arr -no-sched -no-pre-sched';


my %ciphers = (
    'AES-bs'       => [ 'aes.ua',                '-B' ],
    'ACE-bs'       => [ 'ace_bitslice.ua',       '-B' ],
    'Ascon-bs'     => [ 'ascon.ua',              '-B' ],
    'Clyde-bs'     => [ 'clyde_bitslice.ua',     '-B' ],
    'DES'          => [ 'des.ua',                '-B' ],
    'Gift-bs'      => [ 'gift_bitslice.ua',      '-B' ],
    'Gimli-bs'     => [ 'gimli_bitslice.ua',     '-B' ],
    'Photon-bs'    => [ 'photon_bitslice.ua',    '-B' ],
    'Present'      => [ 'present.ua',            '-B' ],
    'Pyjamask-bs'  => [ 'pyjamask_bitslice.ua',  '-B' ],
    'Rectangle-bs' => [ 'rectangle_bitslice.ua', '-B' ],
    'Skinny-bs'    => [ 'skinny_bitslice.ua',    '-B' ],
    'Spongent'     => [ 'spongent.ua',           '-B' ],
    'Subterranean' => [ 'subterranean.ua',       '-B' ],
    );


# Recompiling Usuba
say "Recompiling Usuba...";
chdir $ua_dir;
system "make";

# Generating the C files
say "Generating the C files...";
mkdir $c_dir unless -d $c_dir;
chdir $ua_dir;
for my $cipher (sort keys %ciphers) {
    my ($source) = $ua_dir . "/samples/usuba/" . $ciphers{$cipher}[0];
    system "./usubac $ua_opts -B               -o $c_dir/$cipher.c           $source";
    system "./usubac $ua_opts -B -no-CSE-CP-CF -o $c_dir/$cipher-noCSECPCF.c $source";
}

# Computing the number of instructions in the C files
say "Computing the results...";
my %res;
for my $cipher (sort keys %ciphers) {
    my $with_opts    = compute_instrs("$c_dir/$cipher.c");
    my $without_opts = compute_instrs("$c_dir/$cipher-noCSECPCF.c");
    $res{$cipher} = { with    => $with_opts,
                      without => $without_opts };
}


# Displaying the results
say "\n";
my $longest_str_cipher = max map { length } 'cipher', keys %ciphers;
my $total = 0;
printf " %*s |   # with    |  # without  |  factor  \n", $longest_str_cipher, "cipher";
printf  "-%s-|-------------|-------------|----------\n", "-"x$longest_str_cipher;
for my $cipher (sort keys %ciphers) {
    printf " %*s | %11s | %11s |  %.2f\n", $longest_str_cipher, $cipher,
        format_num($res{$cipher}{with}),
        format_num($res{$cipher}{without}),
        $res{$cipher}{without} / $res{$cipher}{with};
    $total += $res{$cipher}{without} / $res{$cipher}{with};
}
$total /= keys %ciphers;
printf "\nFactor total: %.2f\n", $total;


sub compute_instrs {
    my ($file) = @_;
    open my $FH, '<', $file;
    my $instrs = 0;
    while (<$FH>) {
        last if /Additional functions/; # Skipping end of file so that
                                        # the Usuba source does not
                                        # count toward the total
                                        # number of instructions
        $instrs += /=/;
    }
    return $instrs;
}

sub format_num {
    my ($n) = @_;
    $n =~ s/.\K(?=(?:\d{3})+$)/,/g;
    return $n;
}
