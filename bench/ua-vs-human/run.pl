#!/usr/bin/perl

=usage
    
    ./compile.pl [-c] [-r] [-l]

To collect only, `./compile.pl` (or `./compile.pl -l`).
To generate the C files from Usuba, `./compile.pl -g`. (not by default)
To compile only, `./compile.pl -c`.
To run only, `./compile.pl -r`
To collect the results only, `./compile.pl -l`

=cut

use strict;
use warnings;
no warnings qw( numeric );
use v5.14;
use autodie qw( open close );


use FindBin; chdir "$FindBin::Bin";

use List::Util qw(sum);


my $gen     = "@ARGV" =~ /-g/;
my $compile = "@ARGV" =~ /-c/;
my $run     = "@ARGV" =~ /-r/;
my $collect = !@ARGV || "@ARGV" =~ /-l/;
@ARGV = grep { ! /-l/ } @ARGV;


if ($run) {
    say "Running supercop (gonna take a while)...";
    chdir "$FindBin::Bin/../../supercop";
    system "./data_do";
    say "Running supercop: Done.";
}


open my $FP_OUT, '>', 'human.tex';


# ##############################  DES  ###############################

{
    chdir "$FindBin::Bin/../../ciphers/des";
    
    system "./compile.pl @ARGV"
        if $gen || $compile || $run;

    open my $FP_IN, '<', 'results.txt';
    my ($ref_speed,$ua_speed);
    while (<$FP_IN>) {
        if (/kwan-std (\S+)/) {
            $ref_speed = $1;
        } elsif (/ua-std (\S+)/) {
            $ua_speed = $1;
        }
    }

    my $speedup = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = get_c_sloc('kwan/des.c');
    my $ua_sloc  = get_ua_sloc('../../samples/usuba/des.ua') + 500; # 500 for the Sboxes

    say $FP_OUT
"\\newcommand{\\ReferenceDESThroughput}{$ref_speed}
\\newcommand{\\ReferenceDESSLOC}{$ref_sloc}
\\newcommand{\\UsubaDESThroughput}{$ua_speed}
\\newcommand{\\UsubaDESSLOC}{$ua_sloc}
\\newcommand{\\DESAbsoluteSpeedup}{$speedup}\n";
}


# ###########################  AES SSSE3 (Hslice) #############################
{
    chdir "$FindBin::Bin/../../";

    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-xSSSE3_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/aes128ctr/kasper_sse/data';
    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/icc_-xSSSE3_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/aes128ctr/usuba-sse/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc  = do {
        my $mix_col    = 47;
        my $shift_rows = 15;
        my $sbox       = 200;
        $mix_col + $shift_rows + $sbox + 10; # 10 for the 10 rounds
    };
    my $ua_sloc = get_ua_sloc('samples/usuba/aes_mslice.ua');

    say $FP_OUT
"\\newcommand{\\ReferenceAESKSThroughput}{$ref_speed}
\\newcommand{\\ReferenceAESKSSLOC}{$ref_sloc}
\\newcommand{\\UsubaAESKSThroughput}{$ua_speed}
\\newcommand{\\UsubaAESKSSLOC}{$ua_sloc}
\\newcommand{\\AESKSAbsoluteSpeedup}{$speedup}\n";
}


# ###########################  AES AVX (Hslice) #############################
{
    chdir "$FindBin::Bin/../../";

    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/clang_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/aes128ctr/kivilinna-avx/data';
    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/clang_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/aes128ctr/usuba-sse/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = get_asm_sloc('supercop/crypto_stream/aes128ctr/kivilinna-avx/aes_asm_bitslice_avx.S') - 500;
    my $ua_sloc  = get_ua_sloc('samples/usuba/aes_kasper_constr.ua');

    say $FP_OUT
"\\newcommand{\\ReferenceAESKiviThroughput}{$ref_speed}
\\newcommand{\\ReferenceAESKiviSLOC}{$ref_sloc}
\\newcommand{\\UsubaAESKiviThroughput}{$ua_speed}
\\newcommand{\\UsubaAESKiviSLOC}{$ua_sloc}
\\newcommand{\\AESKiviAbsoluteSpeedup}{$speedup}\n";
}



# ###########################  Chacha20 #############################
{ # AVX2
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/icc_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/usuba-avx-fast/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/dolbeau/amd64-avx2/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 20;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua');
 
    say $FP_OUT   
"\\newcommand{\\ReferenceChachaAVXtwoThroughput}{$ref_speed}
\\newcommand{\\ReferenceChachaAVXtwoSLOC}{$ref_sloc}
\\newcommand{\\UsubaChachaAVXtwoThroughput}{$ua_speed}
\\newcommand{\\UsubaChachaAVXtwoSLOC}{$ua_sloc}
\\newcommand{\\ChachaAVXtwoAbsoluteSpeedup}{$speedup}\n";
}

{ # AVX
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/icc_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/usuba-sse-fast/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/moon/avx/64/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 232-98;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua');
 
    say $FP_OUT   
"\\newcommand{\\ReferenceChachaAVXThroughput}{$ref_speed}
\\newcommand{\\ReferenceChachaAVXSLOC}{$ref_sloc}
\\newcommand{\\UsubaChachaAVXThroughput}{$ua_speed}
\\newcommand{\\UsubaChachaAVXSLOC}{$ua_sloc}
\\newcommand{\\ChachaAVXAbsoluteSpeedup}{$speedup}\n";
}

{ # SSE (SSSE3)
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/clang_-mssse3_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/usuba-sse/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/clang_-mssse3_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/moon/ssse3/64/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 232-98;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua');
 
    say $FP_OUT   
"\\newcommand{\\ReferenceChachaSSEThroughput}{$ref_speed}
\\newcommand{\\ReferenceChachaSSESLOC}{$ref_sloc}
\\newcommand{\\UsubaChachaSSEThroughput}{$ua_speed}
\\newcommand{\\UsubaChachaSSESLOC}{$ua_sloc}
\\newcommand{\\ChachaSSEAbsoluteSpeedup}{$speedup}\n";
}

{ # STD
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/icc_-msse4.2_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/usuba-std/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/chacha20/e/ref/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 26;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua');
 
    say $FP_OUT   
"\\newcommand{\\ReferenceChachaGPThroughput}{$ref_speed}
\\newcommand{\\ReferenceChachaGPSLOC}{$ref_sloc}
\\newcommand{\\UsubaChachaGPThroughput}{$ua_speed}
\\newcommand{\\UsubaChachaGPSLOC}{$ua_sloc}
\\newcommand{\\ChachaGPAbsoluteSpeedup}{$speedup}\n";
}




# ###########################  Serpent #############################
{ # AVX2
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/clang_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/usuba-avx-fast-inter/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/clang_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/avx2-16way-1/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 300;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua') + 190;
 
    say $FP_OUT   
"\\newcommand{\\ReferenceSerpentAVXtwoThroughput}{$ref_speed}
\\newcommand{\\ReferenceSerpentAVXtwoSLOC}{$ref_sloc}
\\newcommand{\\UsubaSerpentAVXtwoThroughput}{$ua_speed}
\\newcommand{\\UsubaSerpentAVXtwoSLOC}{$ua_sloc}
\\newcommand{\\SerpentAVXtwoAbsoluteSpeedup}{$speedup}\n";
}

{ # AVX
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/clang_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/inter-sse/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/avx-8way-1/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 300;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua') + 190;
 
    say $FP_OUT   
"\\newcommand{\\ReferenceSerpentAVXThroughput}{$ref_speed}
\\newcommand{\\ReferenceSerpentAVXSLOC}{$ref_sloc}
\\newcommand{\\UsubaSerpentAVXThroughput}{$ua_speed}
\\newcommand{\\UsubaSerpentAVXSLOC}{$ua_sloc}
\\newcommand{\\SerpentAVXAbsoluteSpeedup}{$speedup}\n";
}

{ # SSE (SSE2)
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/icc_-xSSE2_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/inter-sse/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-xSSE2_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/sse2-8way/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 300;
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua') + 190;
 
    say $FP_OUT   
"\\newcommand{\\ReferenceSerpentSSEThroughput}{$ref_speed}
\\newcommand{\\ReferenceSerpentSSESLOC}{$ref_sloc}
\\newcommand{\\UsubaSerpentSSEThroughput}{$ua_speed}
\\newcommand{\\UsubaSerpentSSESLOC}{$ua_sloc}
\\newcommand{\\SerpentSSEAbsoluteSpeedup}{$speedup}\n";
}

{ # GP
    chdir "$FindBin::Bin/../../";

    my $ua_file  = 'supercop-data/dadaubuntu/amd64/try/c/clang_-march=native_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/inter-std/data';
    my $ref_file = 'supercop-data/dadaubuntu/amd64/try/c/icc_-msse4.2_-O3_-fomit-frame-pointer_-fwrapv_-std=gnu11/crypto_stream/serpent128ctr/linux_c/data';

    my $ref_speed = get_speed_supercop($ref_file);
    my $ua_speed  = get_speed_supercop($ua_file);
    my $speedup   = get_speedup($ref_speed,$ua_speed);

    my $ref_sloc = 300; 
    my $ua_sloc  = get_ua_sloc('samples/usuba/chacha20_shadow.ua') + 190;
 
    say $FP_OUT   
"\\newcommand{\\ReferenceSerpentGPThroughput}{$ref_speed}
\\newcommand{\\ReferenceSerpentGPSLOC}{$ref_sloc}
\\newcommand{\\UsubaSerpentGPThroughput}{$ua_speed}
\\newcommand{\\UsubaSerpentGPSLOC}{$ua_sloc}
\\newcommand{\\SerpentGPAbsoluteSpeedup}{$speedup}\n";
}





# ###########################  Rectangle #############################
{ 
    chdir "$FindBin::Bin/../../ciphers/rectangle";

    system "./bench.pl @ARGV"
        if $gen || $compile || $run;

    my $file = 'results.txt';

    my $ref_sloc = 115;
    my $ua_sloc  = get_ua_sloc('../../samples/usuba/rectangle.ua') + 10; # +10 for sbox
    
    open my $FP_IN, '<', $file;
    while (<$FP_IN>) {
        chomp;
        my ($expe) = split;
        my ($arch,$slicing) = split '-', $expe;
        chomp(my $ref = <$FP_IN>);
        $ref = <$FP_IN> if $ref =~ /All OK/i;
        chomp(my $ua = <$FP_IN>);
        <$FP_IN>; <$FP_IN>;
        next unless $expe =~ /vector.*inter_inline/;
        ($arch) = $expe =~ /vector-(.+?)_/;
        my ($ref_speed) = $ref =~ /(\d+\.\d+)/;
        my ($ua_speed)  = $ua  =~ /(\d+\.\d+)/;
        my $real_arch;
        if    ($arch =~ /gp/)     { $real_arch = 'GP'   }
        elsif ($arch =~ /avx/)    { $real_arch = 'AVXtwo' }
        elsif ($arch =~ /sseSSE/) { $real_arch = 'SSE'  }
        elsif ($arch =~ /sse/)    { $real_arch = 'AVX'  }
        else { say "Unknown arch: $arch\n"; exit }

        if ($real_arch eq 'GP') {
            $ua_speed = sprintf "%.2f", $ua_speed / 1.1075; 
            # Should compute that automatically
            # Note: I didn't invent this number: got it from the C benchmarks
        }

        my $speedup = get_speedup($ref_speed,$ua_speed);
        
        say $FP_OUT   
"\\newcommand{\\ReferenceRectangle${real_arch}Throughput}{$ref_speed}
\\newcommand{\\ReferenceRectangle${real_arch}SLOC}{$ref_sloc}
\\newcommand{\\UsubaRectangle${real_arch}Throughput}{$ua_speed}
\\newcommand{\\UsubaRectangle${real_arch}SLOC}{$ua_sloc}
\\newcommand{\\Rectangle${real_arch}AbsoluteSpeedup}{$speedup}\n";
    }

}






sub get_speed_supercop {
    my $file = shift;
    open my $FP_IN, '<', $file or return 0;
    my @numbers;
    while (<$FP_IN>) {
        next unless /xor_cycles 4096 (.*) $/;
        push @numbers, split ' ', $1;
    }
    @numbers = sort { $a <=> $b } @numbers;
    @numbers = @numbers[0 .. @numbers/2]; # Making sure there are no context switch
    if (@numbers) {
        return sprintf "%.2f", sum(@numbers) / @numbers / 4096;
    } else {
        return 0;
    }
}

sub get_speedup {
    my ($ref_speed, $ua_speed) = @_;
    return 0 if !$ref_speed;
    my $speedup = ($ref_speed - $ua_speed) / $ref_speed * 100;
    my $sign = $speedup > 0 ? "+" : "";
    return sprintf "%s%.2f", $sign, $speedup;
}

sub get_cpp_sloc {
    my ($sloc) = `cloc $_[0]` =~ /^C\+\+\s.*?(\d+)$/m;
    return $sloc;
}

sub get_c_sloc {
    my ($sloc) = `cloc $_[0]` =~ /^C\s.*?(\d+)$/m;
    return $sloc;
}

sub get_asm_sloc {
    my ($sloc) = `cloc $_[0]` =~ /^Assembly\s.*?(\d+)$/m;
    return $sloc;
}

sub get_ua_sloc {
    my $sloc = `perl -pe '\$\\+=!/^\\s*\$/}{' $_[0]`;
    return $sloc;
}
