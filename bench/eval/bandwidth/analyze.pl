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
my %instr_asm;
open my $FH, '<', 'des.s' or die $!;
while (<$FH>) {
    given ($_) {
        when (/andn/) { $instr_asm{andn}++ }
        when (/xor/)  { $instr_asm{xor}++  }
        when (/and/)  { $instr_asm{and}++  }
        when (/or/)   { $instr_asm{or}++   }
        when (/mov/)  { $instr_asm{move}++ }
        when (/not/)  { $instr_asm{not}++  }
    }
}

my $move_asm  = $instr_asm{move};
my $arith_asm = sum @instr_asm{qw(andn xor and or not)};
my $instr_asm_tot = $move_asm + $arith_asm;

# Couting the instructions in the C code
my %instr_c;
open $FH, '<', 'des.c' or die $!;
while (<$FH>) {
    given ($_) {
        when (/ANDN/) { $instr_c{andn}++ }
        when (/XOR/)  { $instr_c{xor}++  }
        when (/AND/)  { $instr_c{and}++  }
        when (/OR/)   { $instr_c{or}++   }
        when (/NOT/)  { $instr_c{not}++  }
    }
    $instr_c{move}++ for /\[\d+\]/g;
}

my $move_c  = $instr_c{move};
my $arith_c = sum map { $_ || 0 } @instr_c{qw(andn xor and or not)};
my $instr_c_tot = $move_c + $arith_c;


# Mesuring the execution time
my $nb_run = 100;
my $cycles;
$cycles += `./main` for 1 .. $nb_run;
$cycles = int($cycles / $nb_run);


printf "Execution time: %d (cycles)\n\n" .
    "Nb instr (C)      : %d\n" .
    "       (move)     : %d\n" .
    "      (arith)     : %d\n" .
    " arith/move       : %.2f\n" .
    "Instr/cycle (C)   : %.2f\n\n" .
    "Nb instr (asm)    : %d\n" .
    "       (move)     : %d\n" .
    "      (arith)     : %d\n" .
    " arith/move       : %.2f\n" .
    "Instr/cycle (asm) : %.2f\n",
    $cycles,
    $instr_c_tot, $move_c, $arith_c,
    $arith_c / $move_c,
    $instr_c_tot/$cycles,
    $instr_asm_tot, $move_asm, $arith_asm,
    $arith_asm / $move_asm,
    $instr_asm_tot/$cycles;
