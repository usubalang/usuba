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
    }
}

my $move = $instr{move};
my $arit = sum @instr{qw(andn xor and or)};

say "$move - $arit";
