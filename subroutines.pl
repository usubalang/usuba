use strict;
use warnings;
use v5.14;
use Getopt::Long;
use FindBin;

sub samples_location() {
    my $ua_dir = $FindBin::Bin;
    my $samples = "$ua_dir/../examples/samples";
    GetOptions(
        "samples|s=s"   => \$samples,    # string with default
        ) or die "Error in command line arguments";
    if ($samples =~ /.*\/$/) { $samples = substr $samples, 0, length($samples) - 1 };
    say $samples;
    return $samples
}

1;
