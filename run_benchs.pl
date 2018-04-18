#!/usr/bin/perl

use strict;
use warnings;
use v5.14;

use Data::Dumper;
use Data::Printer;

use FindBin;
chdir $FindBin::Bin;

use File::Copy;
use File::Path qw(remove_tree);
use Sys::Hostname;
use List::Util qw( sum );

use Getopt::Long;

use constant {
    TRUE  => 1,
    FALSE => 0,
    V_LOW_PRIO => 5,
    V_MED_PRIO => 3,
    V_HIGH_PRIO => 1
};

my $make_usubac = FALSE; # If true, then recompile Usubac (implies --generate)
my $generate    = FALSE; # If true, then regenerate the C sources from Usuba
my $verbose     = V_LOW_PRIO;
my $run_benchs  = FALSE; # If true, run the benchmarks
my $collect     = TRUE ; # If true, collects the data from the benchmakrs

GetOptions('make-usubac' => sub { $make_usubac = $generate = 1 },
           'generate'    => \$generate,
           'verbose=i'   => \$verbose,
           'run-benchs'  => \$run_benchs,
           'collect'     => \$collect);


sub status {
    my $priority = shift;
    if ($verbose >= $priority) {
        say @_;
    }
}
our $job_str = ''; # Don't pay attention, I'm gonna play with dynamic scoping :p
sub status_start { status(V_HIGH_PRIO, "$job_str: in progress...") }
sub status_end   { status(V_HIGH_PRIO, "$job_str: done.") }




# Generation of the C ciphers
make_usubac() if $make_usubac;
generate() if $generate;

# Running supercop benchmarks
run_benchs() if $run_benchs;

# Collecting the results
collect() if $collect;




sub make_usubac {
    local $job_str = "Recompiling Usubac";
    status_start;
    
    die "Couldn't make." if system 'make';
    
    status_end;
}


sub generate {
    local $job_str = "Regenerating C ciphers from Usuba";
    status_start;

    my $options_all = '-no-share -no-runtime';

    my %conf = (
        aes       => { src => 'aes_kasper.ua', archs => [qw(sse avx)], 
                       dir => 'aes128ctr', opts => ' '  },
        rectangle => { src => 'rectangle.ua', archs => [qw(sse)], 
                       dir => 'rectangle64ctr', opts => ' ' },
        serpent   => { src => 'serpent.ua', archs => [qw(std sse avx)], 
                       dir => 'serpent128ctr', opts => '-bits-per-reg 32' },
        chacha20  => { src => 'chacha20.ua',archs => [qw(std sse avx)],  
                       dir => 'chacha20', opts => '-bits-per-reg 32' });

    while (my ($cipher,$cconf) = each %conf) {
        status(V_MED_PRIO, "Generating $cipher...");
        for my $arch (@{$cconf->{archs}}) {
            status(V_LOW_PRIO, "Generating ${cipher}::${arch}...");

            my $dst_dir = "supercop/crypto_stream/$cconf->{dir}/usuba-$arch/";
            
            # Compiling the Usuba cipher to C
            die "Couldn't compile '$cipher -- $arch'" if 
                system "./usubac "
                . "-o $dst_dir/$cipher.c "
                . "$options_all "
                . "$cconf->{opts} "
                . "-arch $arch "
                . "samples/usuba/$cconf->{src}";

            # Making sure the arch specific header is up-to-date
            copy "arch/" . uc($arch) . ".h", $dst_dir;
            
            status(V_LOW_PRIO, "Generating ${cipher}::${arch}: done.");
        }
        status(V_MED_PRIO, "Generating $cipher: done.");
    }
    
    status_end;
}

sub run_benchs {
    local $job_str = "Running Supercop (this could take a while)";
    status_start;

    remove_tree "supercop-data";
    chdir "supercop";
    unlink "supercop-data";
    
    die "Error in supercop benchmark." if system "./data-do";

    chdir "..";
    
    local $job_str = "Running Supercop";
    status_end;
}


sub collect {
    local $job_str = "Collecting results";
    status_start;

    my $hostname = lc hostname =~ s/\W//gr;

    my %perfs;
    my $res_dir = "supercop-data/$hostname/amd64/try/c";
    # structure of the results directory:
    # res_dir/compiler/crypto_stream/cipher/implem/data"
    # (with krovetz, implem has a subdir)
    for my $file (glob("$res_dir/*/crypto_stream/*/*/{*/,}data")) {
        my $perf = perf_from_file($file) || next;
        my ($cc,$opts,$cipher) = $file =~ m{.*?(clang|gcc)_-(.*?)_.*?crypto_stream/(.*?)/data};
        $perfs{$cc}->{$opts}->{$cipher} = $perf;
    }

    my @refs;
    # Serpent, AES & Chacha Usuba
    for (['serpent','serpent128ctr'], ['aes', 'aes128ctr'], ['chacha20','chacha20']) {
        my ($file, $cipher) = @$_;
        for (['std', 'GP\n64-bit'], ['sse', 'SSE'], ['avx', 'AVX2']) {
            my ($implem,$name) = @$_;
            push @refs, { cipher => $cipher, implem => "usuba-$implem",
                          cc => 'clang', opts => 'march=native',
                          file => $file, name => $name },
        }
    }
    # Serpent Kivilinna 64-bits, SSE and Götzfried
    for (['linux_c','Kivilinna\n64-bit'],['sse2-8way','Kivilinna\nSSE'],
         ['avx2-16way-1','Götzfried\nAVX2']) {
        my ($implem,$name) = @$_;
        push @refs, { cipher => 'serpent128ctr', implem => $implem,
                      cc => 'gcc', opts => 'march=native',
                      file => 'serpent', name => $name };
    }
    # AES K&S and Kivilinna
    for (['kivilinna-avx','Kivilinna SSE'],['kasper_sse','K\\&S\nSSE']) {
        my ($implem,$name) = @$_;
        push @refs, { cipher => 'aes128ctr', implem => $implem,
                      cc => 'gcc', opts => 'march=native',
                      file => 'aes', name => $name };
    }
    # Chacha20 Krovetz SSE and AVX2
    for (['krovetz/vec128','Krovetz SSE'],['krovetz/avx2','Krovetz AVX2']) {
        my ($implem,$name) = @$_;
        push @refs, { cipher => 'chacha20', implem => $implem,
                      cc => 'gcc', opts => 'march=native',
                      file => 'chacha20', name => $name };
    }
    
    # Gathering the results
    my %data;
    for (@refs) {
        my $perf = $perfs{$_->{cc}}->{$_->{opts}}->{"$_->{cipher}/$_->{implem}"} || next;
        push @{$data{$_->{file}}},{ name => $_->{name}, perf => $perf, ttt => "$_->{cipher}/$_->{implem}" };
    }

    # Printing the data files
    for my $cipher (keys %data) {
        open my $FP, '>', "supercop/plots/data-$cipher.dat" or die $!;
        for (sort { $b->{perf} <=> $a->{perf} } @{$data{$cipher}}) {
            say $FP qq("$_->{name}" $_->{perf});
        }
        close $FP;
    }

    # Generating the graphs
    chdir 'supercop/plots';
    system("gnuplot $_") for glob "plot-*.txt";

    status_end;
}

sub perf_from_file {
    my $filename = shift;
    
    my $last_line;
    open my $FP, '<', $filename;

    my @cycles;
    while (<$FP>) {
        if (/xor_cycles 4096 (.*)/) {
            push @cycles, split ' ', $1;
        }
    }

    if (@cycles) {
        @cycles = (sort { $a <=> $b } @cycles)[0 .. 5];
        my $cycles_avg = (sum @cycles) / @cycles;
        return sprintf "%.02f", $cycles_avg / 4096;
    } else {
        return 0;
    }
    
}
