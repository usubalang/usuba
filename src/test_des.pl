#!/usr/bin/perl -w

=head Description

    This script is meant to check that the bitsliced versions of DES produce the
    same results as the standart implmentation.
    It will:
     - compile the project (using the Makefile of "src" directory)
     - generate the bitsliced DES (from src/tests/des_v1.prog)
     - run three DES : one using the standart implementation, one using the
       naive generated code, and one using the orthogonal generated code,
       and check that the three results are the same.

    If any of the step fails, it will print an error message, and exit with a
    non-zero code.
    
=cut

use v5.14;
use Cwd;
use File::Path qw( remove_tree );
use File::Copy;

sub error {
    say "************ ERROR **************";
    exit $?;
}

# switching to src dir
my $path = getcwd() =~ s{bitslicing-compiler\K.*}{}r 
    or die "Can't run this script from outside bitslicing-compiler.";
chdir "$path/src";

# running DES
say "Compiling...";
error if system 'make';
say "Regenerating the des OCaml code...";
error if system './main.native tests/des_v1.prog' ;

# switching to temporary directory
say "Preparing the files for the test...";
remove_tree 'tmp' if -d 'tmp';
mkdir 'tmp';
chdir 'tmp';

copy '../tests/ocaml_run/des_v1_naive.ml', '.';
copy '../tests/ocaml_run/des_v1_ortho.ml', '.';
copy '../des/des.ml', '.';

open my $FH, '>', 'check_des.ml' or die $!;
print $FH <<'END_PRINT';
let make_list_f (f : unit -> 'a) (len: int) : 'a list =
  let rec aux i acc =
    if i <= 0 then acc
    else aux (i-1) (f () :: acc)
  in aux len []

let make_const_list (e: 'a) (len: int) : 'a list =
  let rec aux i acc =
    if i <= 0 then acc
    else aux (i-1) (e :: acc)
  in aux len []
         
         
let () = Random.self_init ()

let rand_list = make_list_f (fun () -> Random.int64 Int64.max_int) 128
let key = Random.int64 Int64.max_int
                            
let stream1 = Stream.of_list rand_list
let stream2 = Stream.of_list rand_list
let stream3 = Stream.of_list rand_list
let key_stream = Stream.from (fun _ -> Some key)

let out_std = Des.des_ecb_encrypt stream1 key
let out_naive = Des_v1_naive.main stream2 key_stream
let out_ortho = Des_v1_ortho.main stream3 key_stream


let l1 = Stream.npeek 64 out_std
let l2 = Stream.npeek 64 out_naive
let l3 = Stream.npeek 64 out_ortho

let status = ref true
let _ =
  if l1 <> l2 then (status := false; print_endline "Error in naive backend");
  if l1 <> l3 then (status := false; print_endline "Error in orthogonal backend");
  if not !status then raise Exit
                 
END_PRINT

close $FH;

say "Compiling the test executable...";
error if system 'ocamlc -o check_des des*.ml check_des.ml';
say "Running the test...";
error if system './check_des';

chdir '..';
remove_tree 'tmp';

say "All done.";
