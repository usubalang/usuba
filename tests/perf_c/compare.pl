#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use Data::Dumper;

use Benchmark qw(:all);

die "Make failed" if system 'make';
system "./make_input" unless -f 'input.txt';

{
    my %speed;
    $speed{std} = 75;
    for my $instance (['uak-64*','test_uak_64std'], ['uak-man-64*','test_uak_manual_64std'],
                      ['kwan-64*','test_kwan'], ['uak-64','test_uak_64'], 
                      ['uak-128','test_uak_128'], ['uak-256','test_uak_256'],
                      ['ua-256','test_ua_256']
        ) {
        my $time = timethis(10,sub{system "./@$instance[1]"});
        $speed{@$instance[0]} = sprintf "%d", (130023424 * 10) / $time->cpu_a
            / 1_000_000;
    }


    open local *STDOUT, '>', 'speed_std.tikz' or die $!;

    my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

    say 
        '  \begin{tikzpicture}[font=\small]
    \begin{axis}[
      ybar,
      bar width=25pt,
      width = .95\linewidth,
      ylabel={Speed (Mib/s)},
      ymin=0,
      ytick=\empty,
      xtick=data,
      axis x line=bottom,
      axis y line=left,
      enlarge x limits=0.1,
      symbolic x coords={',$x_coord, '},
      xticklabel style={anchor=base,yshift=-\baselineskip},
      nodes near coords={\pgfmathprintnumber\pgfplotspointmeta}
    ]

      \addplot[fill=white] coordinates {';

    for (sort {$speed{$b} <=> $speed{$a}} keys %speed) {
        say "       ($_,$speed{$_})";
    }

    say '      };
    \end{axis}
  \end{tikzpicture}';
}

################################################################################
# No orthogonalization

{
    my %speed;
    for my $instance (['uak-64*','test_uak_64std_no'], ['uak-64','test_uak_64_no'],
                      ['uak-128','test_uak_128_no'], ['uak-256','test_uak_256_no'],
                      ['ua-256','test_ua_256_no'], ['kwan-64*','test_kwan_no'],
                      ['uak-man-64*','test_uak_manual_64std_no']) {
        my $time = timethis(20,sub{system "./@$instance[1]"});
        $speed{@$instance[0]} = sprintf "%d", (130023424 * 20) / $time->cpu_a
            / 1_000_000;
    }
    my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

    open local *STDOUT, '>', 'speed_no_ortho.tikz' or die $!;
    say 
        '  \begin{tikzpicture}[font=\small]
    \begin{axis}[
      ybar,
      bar width=25pt,
      width = .95\linewidth,
      ylabel={Speed (Mib/s)},
      ymin=0,
      ytick=\empty,
      xtick=data,
      axis x line=bottom,
      axis y line=left,
      enlarge x limits=0.1,
      symbolic x coords={',$x_coord, '},
      xticklabel style={anchor=base,yshift=-\baselineskip},
      nodes near coords={\pgfmathprintnumber\pgfplotspointmeta}
    ]

      \addplot[fill=white] coordinates {';

    for (sort {$speed{$b} <=> $speed{$a}} keys %speed) {
        say "       ($_,$speed{$_})";
    }

    say '      };
    \end{axis}
  \end{tikzpicture}';
}


################################################################################
# Code size

{
    system 'clang -o tmp -O3 -fno-inline test_kwan.c';
    my %speed;
    for my $instance (['uak-64*','test_uak_64std'], ['uak-64','test_uak_64'],
                      ['uak-128','test_uak_128'], ['uak-256','test_uak_256'],
                      ['ua-256','test_ua_256'], ['kwan-64*','test_kwan'],
                      ['uak-man-64*','test_uak_manual_64std'],
                      ['kwan-64*-ni', 'tmp']) {
        $speed{@$instance[0]} = sprintf"%d",(-s @$instance[1])/1000;
    }
    my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

    open local *STDOUT, '>', 'size_code.tikz' or die $!;
    say 
        '  \begin{tikzpicture}[font=\small]
    \begin{axis}[
      ybar,
      bar width=20pt,
      width = .95\linewidth,
      ylabel={Size (KB)},
      ymin=0,
      ytick=\empty,
      xtick=data,
      axis x line=bottom,
      axis y line=left,
      enlarge x limits=0.1,
      symbolic x coords={',$x_coord, '},
      xticklabel style={anchor=base,yshift=-\baselineskip},
      nodes near coords={\pgfmathprintnumber\pgfplotspointmeta}
    ]

      \addplot[fill=white] coordinates {';

    for (sort {$speed{$b} <=> $speed{$a}} keys %speed) {
        say "       ($_,$speed{$_})";
    }

    say '      };
    \end{axis}
  \end{tikzpicture}';

    unlink 'tmp';
}
