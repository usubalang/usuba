#!/usr/bin/perl

use strict;
use warnings;
use v5.14;
use Data::Dumper;

use Benchmark qw(:all);

die "Make failed" if system 'make';

my %speed;
$speed{std} = 75;
for my $instance (['uak-64*','test_uak_64std'], ['uak-64','test_uak_64'],
                  ['uak-128','test_uak_128'], ['uak-256','test_uak_256'],
                  ['ua-256','test_ua_256'], ['kwan-64*','test_kwan']) {
    my $time = timethis(10,sub{system "./@$instance[1]"});
    $speed{@$instance[0]} = sprintf "%d", (130023424 * 10) / $time->cpu_a
        / 1_000_000;
}

my $BCK = *STDOUT;
open *STDOUT, '>', 'speed_std.tikz' or die $!;

my $x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

say 
'  \begin{tikzpicture}[font=\small]
    \begin{axis}[
      ybar,
      bar width=30pt,
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

close *STDOUT;
*STDOUT = $BCK;

################################################################################
# No orthogonalization


%speed = ();
for my $instance (['uak-64*','test_uak_64std_no'], ['uak-64','test_uak_64_no'],
                  ['uak-128','test_uak_128_no'], ['uak-256','test_uak_256_no'],
                  ['ua-256','test_ua_256_no'], ['kwan-64*','test_kwan_no']) {
    my $time = timethis(20,sub{system "./@$instance[1]"});
    $speed{@$instance[0]} = sprintf "%d", (130023424 * 20) / $time->cpu_a
        / 1_000_000;
}
$x_coord = join ",", sort { $speed{$b} <=> $speed{$a} } keys %speed;

open *STDOUT, '>', 'speed_no_ortho.tikz' or die $!;
say 
'  \begin{tikzpicture}[font=\small]
    \begin{axis}[
      ybar,
      bar width=30pt,
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


__END__
cmpthese(5, {
    'uak-64*'  => sub { system './test_uak_64std' },
    'uak-64'   => sub { system './test_uak_64'    },
    'uak-128'  => sub { system './test_uak_128'   },
    'uak-256'  => sub { system './test_uak_256'   },
    'ua-256'   => sub { system './test_ua_256'    },
    'kwan-64*' => sub { system './test_kwan'      }
         });


say "\nDES on 130Mo input file, without orthogonalization:";
cmpthese(10, {
    'uak-64*'  => sub { system './test_uak_64std_no' },
    'uak-64'   => sub { system './test_uak_64_no'    },
    'uak-128'  => sub { system './test_uak_128_no'   },
    'uak-256'  => sub { system './test_uak_256_no'   },
    'ua-256'   => sub { system './test_ua_256_no'    },
    'kwan-64*' => sub { system './test_kwan_no'      }
         });
