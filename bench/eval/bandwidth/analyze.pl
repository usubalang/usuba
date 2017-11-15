#!/usr/bin/perl


use strict;
use warnings;
use v5.18;
use FindBin;
use File::Path qw( remove_tree make_path );
use File::Copy;
use Cwd;
use Data::Printer;
use List::Util qw( sum );
no warnings 'experimental::smartmatch'; # Removing given/when warning

chdir "$FindBin::Bin/tmp";

# Counting the instructions in the assembly code
my %instr;
open my $FH, '<', 'des.s' or die $!;
while (<$FH>) {
    next unless /^des__/ .. 0;
    given ($_) {
        when (/andn/) { $instr{andn}++ }
        when (/xor/)  { $instr{xor}++  }
        when (/and/)  { $instr{and}++  }
        when (/or/)   { $instr{or}++   }
        when (/mov/)  { $instr{move}++ }
        when (/not/)  { $instr{not}++  }
    }
}

my $move  = $instr{move};
my $arith = sum @instr{qw(andn xor and or not)};
my $instr_tot = $move + $arith;

# Mesuring the execution time
my $nb_run = 100;
my $cycles;
$cycles += `./main` for 1 .. $nb_run;
$cycles = int($cycles / $nb_run);


printf "Execution time: %d (cycles)\n" .
    "Nb instr      : %d\n" .
    "       (move) : %d\n" .
    "      (arith) : %d\n" .
    "Instr/cycle   : %.2f\n",
    $cycles, $instr_tot, $move, $arith,
    $instr_tot/$cycles;
