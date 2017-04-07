exception Error

open Array
open Int64

 
let int_to_bin n =
  let rec aux n acc =
    if n == 0 then acc
    else aux (n/2) ((string_of_int (n mod 2)) ^ acc)
  in aux n ""

let permut64 x p =
  let res = ref zero in
  (*  let len = Array.length p - 1 in *)
  for i = 0 to Array.length p - 1 do
    res := logor !res (shift_left (logand (shift_right x p.(i)) one) i)
  done;
  !res
   

(* initial_permutation *)
let init_p_left =
  [|56; 48; 40; 32; 24; 16; 8; 0; 58; 50; 42; 34; 26; 18; 10; 2;
    60; 52; 44; 36; 28; 20; 12; 4; 62; 54; 46; 38; 30; 22; 14; 6 |]

let init_p_right =
  [|57; 49; 41; 33; 25; 17; 9; 1; 59; 51; 43; 35; 27; 19; 11; 3;
    61; 53; 45; 37; 29; 21; 13; 5; 63; 55; 47; 39; 31; 23; 15; 7 |]

(* final permutation *)
let final_p =
  [|39; 7; 47; 15; 55; 23; 63; 31; 38; 6; 46; 14; 54; 22; 62; 30;
    37; 5; 45; 13; 53; 21; 61; 29; 36; 4; 44; 12; 52; 20; 60; 28;
    35; 3; 43; 11; 51; 19; 59; 27; 34; 2; 42; 10; 50; 18; 58; 26;
    33; 1; 41; 9; 49; 17; 57; 25; 32; 0; 40; 8; 48; 16; 56; 24|]


let permut x table =
  let res = ref 0 in
  for i = 0 to Array.length table - 1 do
    res := !res lor (((x lsr table.(i)) land 1) lsl i)
  done;
  !res  
                
(* permutation P *)
let permut_p x =
  let table =
    [|7; 28; 21; 10; 26; 2; 19; 13; 23; 29; 5; 0; 18; 8; 24; 30;
      22; 1; 14; 27; 6; 9; 17; 31; 15; 4; 20; 3; 11; 12; 25; 16|] in
  permut x table

   
(* expansion function *)
let expand x =
  let table = [|
	31; 0; 1; 2; 3; 4; 3; 4; 5; 6; 7; 8; 7; 8; 9; 10; 11; 12;
	11; 12; 13; 14; 15; 16; 15; 16; 17; 18; 19; 20; 19; 20;
	21; 22; 23; 24; 23; 24; 25; 26; 27; 28; 27; 28; 29; 30; 31; 0
    |] in
  permut x table

let sbox x s =
  let row = (x lsr 4 land 2) lor (x land 1) in
  let col = (x lsr 1 land 15) in
  s.(row*16+col)

(* The s-boxes*)
let s1 = [|
    14; 4; 13; 1; 2; 15; 11; 8; 3; 10; 6; 12; 5; 9; 0; 7; 
    0; 15; 7; 4; 14; 2; 13; 1; 10; 6; 12; 11; 9; 5; 3; 8; 
    4; 1; 14; 8; 13; 6; 2; 11; 15; 12; 9; 7; 3; 10; 5; 0; 
    15; 12; 8; 2; 4; 9; 1; 7; 5; 11; 3; 14; 10; 0; 6; 13; 
   |]

let s2 = [|
    15; 1; 8; 14; 6; 11; 3; 4; 9; 7; 2; 13; 12; 0; 5; 10; 
    3; 13; 4; 7; 15; 2; 8; 14; 12; 0; 1; 10; 6; 9; 11; 5; 
    0; 14; 7; 11; 10; 4; 13; 1; 5; 8; 12; 6; 9; 3; 2; 15; 
    13; 8; 10; 1; 3; 15; 4; 2; 11; 6; 7; 12; 0; 5; 14; 9; 
   |]

let s3 = [|
    10; 0; 9; 14; 6; 3; 15; 5; 1; 13; 12; 7; 11; 4; 2; 8; 
    13; 7; 0; 9; 3; 4; 6; 10; 2; 8; 5; 14; 12; 11; 15; 1; 
    13; 6; 4; 9; 8; 15; 3; 0; 11; 1; 2; 12; 5; 10; 14; 7; 
    1; 10; 13; 0; 6; 9; 8; 7; 4; 15; 14; 3; 11; 5; 2; 12
   |]

let s4 = [|
    7; 13; 14; 3; 0; 6; 9; 10; 1; 2; 8; 5; 11; 12; 4; 15; 
    13; 8; 11; 5; 6; 15; 0; 3; 4; 7; 2; 12; 1; 10; 14; 9; 
    10; 6; 9; 0; 12; 11; 7; 13; 15; 1; 3; 14; 5; 2; 8; 4; 
    3; 15; 0; 6; 10; 1; 13; 8; 9; 4; 5; 11; 12; 7; 2; 14
   |]

let s5 = [|
    2; 12; 4; 1; 7; 10; 11; 6; 8; 5; 3; 15; 13; 0; 14; 9; 
    14; 11; 2; 12; 4; 7; 13; 1; 5; 0; 15; 10; 3; 9; 8; 6; 
    4; 2; 1; 11; 10; 13; 7; 8; 15; 9; 12; 5; 6; 3; 0; 14; 
    11; 8; 12; 7; 1; 14; 2; 13; 6; 15; 0; 9; 10; 4; 5; 3
   |]

let s6 = [|
    12; 1; 10; 15; 9; 2; 6; 8; 0; 13; 3; 4; 14; 7; 5; 11; 
    10; 15; 4; 2; 7; 12; 9; 5; 6; 1; 13; 14; 0; 11; 3; 8; 
    9; 14; 15; 5; 2; 8; 12; 3; 7; 0; 4; 10; 1; 13; 11; 6; 
    4; 3; 2; 12; 9; 5; 15; 10; 11; 14; 1; 7; 6; 0; 8; 13
   |]
let s7 = [|
    4; 11; 2; 14; 15; 0; 8; 13; 3; 12; 9; 7; 5; 10; 6; 1; 
    13; 0; 11; 7; 4; 9; 1; 10; 14; 3; 5; 12; 2; 15; 8; 6; 
    1; 4; 11; 13; 12; 3; 7; 14; 10; 15; 6; 8; 0; 5; 9; 2; 
    6; 11; 13; 8; 1; 4; 10; 7; 9; 5; 0; 15; 14; 2; 3; 12
   |]

let s8 = [|
    13; 2; 8; 4; 6; 15; 11; 1; 10; 9; 3; 14; 5; 0; 12; 7; 
    1; 15; 13; 8; 10; 3; 7; 4; 12; 5; 6; 11; 0; 14; 9; 2; 
    7; 11; 4; 1; 9; 12; 14; 2; 0; 6; 10; 13; 15; 3; 5; 8; 
    2; 1; 14; 7; 4; 10; 8; 13; 15; 12; 9; 0; 3; 5; 6; 11
   |]

(* the key permutations *)
let round_key k r =
  let table = [|        
  [|33; 9; 2; 51; 50; 19; 44; 49; 1; 26; 43; 3; 35; 41; 11; 59; 34; 17; 60;
    27; 10; 25; 36; 42; 23; 46; 37; 28; 63; 5; 6; 20; 39; 38; 29; 61; 22; 45;
    55; 62; 7; 31; 47; 15; 4; 30; 13; 54|];
  [|41; 17; 10; 59; 58; 27; 52; 57; 9; 34; 51; 11; 43; 49; 19; 36; 42; 25; 1;
    35; 18; 33; 44; 50; 31; 54; 45; 7; 6; 13; 14; 28; 47; 46; 37; 4; 30; 53;
    63; 5; 15; 39; 55; 23; 12; 38; 21; 62|];
  [|57; 33; 26; 44; 11; 43; 1; 10; 25; 50; 36; 27; 59; 2; 35; 52; 58; 41; 17;
    51; 34; 49; 60; 3; 47; 5; 61; 23; 22; 29; 30; 15; 63; 62; 53; 20; 46; 4;
    14; 21; 31; 55; 6; 39; 28; 54; 37; 13|];
  [|10; 49; 42; 60; 27; 59; 17; 26; 41; 3; 52; 43; 44; 18; 51; 1; 11; 57; 33;
    36; 50; 2; 9; 19; 63; 21; 12; 39; 38; 45; 46; 31; 14; 13; 4; 7; 62; 20;
    30; 37; 47; 6; 22; 55; 15; 5; 53; 29|];
  [|26; 2; 58; 9; 43; 44; 33; 42; 57; 19; 1; 59; 60; 34; 36; 17; 27; 10; 49;
    52; 3; 18; 25; 35; 14; 37; 28; 55; 54; 61; 62; 47; 30; 29; 20; 23; 13; 7;
    46; 53; 63; 22; 38; 6; 31; 21; 4; 45|];
  [|42; 18; 11; 25; 59; 60; 49; 58; 10; 35; 17; 44; 9; 50; 52; 33; 43; 26; 2;
    1; 19; 34; 41; 51; 30; 53; 15; 6; 5; 12; 13; 63; 46; 45; 7; 39; 29; 23;
    62; 4; 14; 38; 54; 22; 47; 37; 20; 61|];
  [|58; 34; 27; 41; 44; 9; 2; 11; 26; 51; 33; 60; 25; 3; 1; 49; 59; 42; 18;
    17; 35; 50; 57; 36; 46; 4; 31; 22; 21; 28; 29; 14; 62; 61; 23; 55; 45;
    39; 13; 20; 30; 54; 5; 38; 63; 53; 7; 12|];
  [|11; 50; 43; 57; 60; 25; 18; 27; 42; 36; 49; 9; 41; 19; 17; 2; 44; 58; 34;
    33; 51; 3; 10; 52; 62; 20; 47; 38; 37; 15; 45; 30; 13; 12; 39; 6; 61; 55;
    29; 7; 46; 5; 21; 54; 14; 4; 23; 28|];
  [|19; 58; 51; 2; 1; 33; 26; 35; 50; 44; 57; 17; 49; 27; 25; 10; 52; 3; 42;
    41; 59; 11; 18; 60; 5; 28; 55; 46; 45; 23; 53; 38; 21; 20; 47; 14; 4; 63;
    37; 15; 54; 13; 29; 62; 22; 12; 31; 7|];
  [|35; 11; 36; 18; 17; 49; 42; 51; 3; 60; 10; 33; 2; 43; 41; 26; 1; 19; 58;
    57; 44; 27; 34; 9; 21; 15; 6; 62; 61; 39; 4; 54; 37; 7; 63; 30; 20; 14;
    53; 31; 5; 29; 45; 13; 38; 28; 47; 23|];
  [|51; 27; 52; 34; 33; 2; 58; 36; 19; 9; 26; 49; 18; 59; 57; 42; 17; 35; 11;
    10; 60; 43; 50; 25; 37; 31; 22; 13; 12; 55; 20; 5; 53; 23; 14; 46; 7; 30;
    4; 47; 21; 45; 61; 29; 54; 15; 63; 39|];
  [|36; 43; 1; 50; 49; 18; 11; 52; 35; 25; 42; 2; 34; 44; 10; 58; 33; 51; 27;
    26; 9; 59; 3; 41; 53; 47; 38; 29; 28; 6; 7; 21; 4; 39; 30; 62; 23; 46;
    20; 63; 37; 61; 12; 45; 5; 31; 14; 55|];
  [|52; 59; 17; 3; 2; 34; 27; 1; 51; 41; 58; 18; 50; 60; 26; 11; 49; 36; 43;
    42; 25; 44; 19; 57; 4; 63; 54; 45; 15; 22; 23; 37; 20; 55; 46; 13; 39;
    62; 7; 14; 53; 12; 28; 61; 21; 47; 30; 6|];
  [|1; 44; 33; 19; 18; 50; 43; 17; 36; 57; 11; 34; 3; 9; 42; 27; 2; 52; 59;
    58; 41; 60; 35; 10; 20; 14; 5; 61; 31; 38; 39; 53; 7; 6; 62; 29; 55; 13;
    23; 30; 4; 28; 15; 12; 37; 63; 46; 22|];
  [|17; 60; 49; 35; 34; 3; 59; 33; 52; 10; 27; 50; 19; 25; 58; 43; 18; 1; 44;
    11; 57; 9; 51; 26; 7; 30; 21; 12; 47; 54; 55; 4; 23; 22; 13; 45; 6; 29;
    39; 46; 20; 15; 31; 28; 53; 14; 62; 38|];
  [|25; 1; 57; 43; 42; 11; 36; 41; 60; 18; 35; 58; 27; 33; 3; 51; 26; 9; 52;
    19; 2; 17; 59; 34; 15; 38; 29; 20; 55; 62; 63; 12; 31; 30; 21; 53; 14;
    37; 47; 54; 28; 23; 39; 7; 61; 22; 5; 46|] |] in
  permut64 k table.(r)
                      
(* crypt: true for encryption, false for decryption *)
let des_single (plaintext: int64) (key: int64) (crypt: bool) : int64 =
  let left  = ref (Int64.to_int (permut64 plaintext init_p_left)) in
  let right = ref (Int64.to_int (permut64 plaintext init_p_right)) in

  for i = 0 to 15 do
    
    let tmp = expand !right in
    let k   = Int64.to_int (round_key key (if crypt then i else (15-i))) in
    let xored = tmp lxor k in
    let c1 = sbox ((xored lsr 0 ) land 63) s8 in
    let c2 = sbox ((xored lsr 6 ) land 63) s7 in
    let c3 = sbox ((xored lsr 12) land 63) s6 in
    let c4 = sbox ((xored lsr 18) land 63) s5 in
    let c5 = sbox ((xored lsr 24) land 63) s4 in
    let c6 = sbox ((xored lsr 30) land 63) s3 in
    let c7 = sbox ((xored lsr 36) land 63) s2 in
    let c8 = sbox ((xored lsr 42) land 63) s1 in
    
    let c  = c1 lor (c2 lsl 4) lor (c3 lsl 8) lor (c4 lsl 12) lor
               (c5 lsl 16) lor (c6 lsl 20) lor (c7 lsl 24) lor (c8 lsl 28) in
    let tmp2 = !left lxor (permut_p c) in
    left  := !right;
    right := tmp2;
    
  done;
  let pre_ciphered = Int64.logor (Int64.shift_left (Int64.of_int !right) 32)
                                 (Int64.of_int !left) in
  permut64 pre_ciphered final_p



           
(* Multiple blocks encrypting/decrypting *)
           
           
let test_int64  = Int64.of_string "0x0123456789ABCDEF"
let test_key    = Int64.of_string "0x133457799BBCDFF1"
let test_res    = Int64.of_string "0x85E813540F0AB405"
let test_stream_ecb = Stream.of_list [ test_int64; test_int64; test_int64; test_int64; test_res ]
let test_stream_cbc = Stream.of_list [ test_int64; test_int64; test_int64; test_int64; test_res ]
let test_stream_cfb = Stream.of_list [ test_int64; test_int64; test_int64; test_int64; test_res ]
let test_stream_ofb = Stream.of_list [ test_int64; test_int64; test_int64; test_int64; test_res ]
let test_iv     = Int64.of_string "0xABCDEF123456789"

let hex_print x = 
  let _ = Sys.command ("perl -e 'printf\"%X\n\"," ^ x ^ "'") in ()
                                                                  

(* *********************** ECB *********************** *)
let des_ecb_encrypt (plaintext: int64 Stream.t) (key: int64) : int64 Stream.t =
  Stream.from (fun _ ->
               try
                 let x = Stream.next plaintext in        
                 Some (des_single x key true)
               with
                 Stream.Failure -> None )

let des_ecb_decrypt (ciphered: int64 Stream.t) (key: int64) : int64 Stream.t =
  Stream.from (fun _ ->
               try
                 let x = Stream.next ciphered in        
                 Some (des_single x key false)
               with
                 Stream.Failure -> None )

let test_ecb () =
  let ciphered = des_ecb_encrypt test_stream_ecb test_key in
  let decrypted = des_ecb_decrypt ciphered test_key in
  Stream.iter (fun x -> hex_print (Int64.to_string x)) decrypted

(* *********************** CBC *********************** *)
let des_cbc_encrypt (plaintext: int64 Stream.t) (key: int64) (iv: int64)
    : int64 Stream.t =
  let prev = ref iv in
  Stream.from (fun _ ->
               try
                 let x = Stream.next plaintext in
                 (let v = des_single (Int64.logxor !prev x) key true in
                  prev := v;
                  Some v )
               with
                 Stream.Failure -> None )

let des_cbc_decrypt (ciphered: int64 Stream.t) (key: int64) (iv: int64)
    : int64 Stream.t =
  let prev = ref iv in
  Stream.from (fun _ ->
               try
                 let x = Stream.next ciphered in
                 let v = (Int64.logxor (des_single x key false) !prev) in
                 (prev := x;
                  Some v )
               with
                 Stream.Failure -> None )
              
let test_cbc () =
  let ciphered = des_cbc_encrypt test_stream_cbc test_key test_iv in
  let decrypted = des_cbc_decrypt ciphered test_key test_iv in
  Stream.iter (fun x -> hex_print (Int64.to_string x)) decrypted


(* *********************** CFB *********************** *)                            
let des_cfb_encrypt (plaintext: int64 Stream.t) (key: int64) (iv: int64)
    : int64 Stream.t =
  let prev = ref iv in
  Stream.from (fun _ ->
               try
                 let x = Stream.next plaintext in
                 (let v = Int64.logxor (des_single !prev key true) x in
                  prev := v;
                  Some v)
               with
                 Stream.Failure -> None )
              

let des_cfb_decrypt (ciphered: int64 Stream.t) (key: int64) (iv: int64)
    : int64 Stream.t =
  let prev = ref (des_single iv key true) in
  Stream.from (fun _ ->
               try
                 let x = Stream.next ciphered in
                 (let v = (Int64.logxor x !prev) in
                  prev := des_single x key true;
                  Some v)
               with
                 Stream.Failure -> None )

let test_cfb () =
  let ciphered = des_cfb_encrypt test_stream_cfb test_key test_iv in
  let decrypted = des_cfb_decrypt ciphered test_key test_iv in
  Stream.iter (fun x -> hex_print (Int64.to_string x)) decrypted
              
(* *********************** OFB *********************** *)
let des_ofb_encrypt (plaintext: int64 Stream.t) (key: int64) (iv: int64)
    : int64 Stream.t =
  let prev = ref (des_single iv key true) in
  Stream.from (fun _ ->
               try
                 let x = Stream.next plaintext in
                 (let v = Int64.logxor !prev x in
                  prev := des_single !prev key true;
                  Some v)
               with
                 Stream.Failure -> None )

let des_ofb_decrypt (ciphered: int64 Stream.t) (key: int64) (iv: int64)
    : int64 Stream.t =
  let prev = ref (des_single iv key true) in
  Stream.from (fun _ ->
               try
                 let x = Stream.next ciphered in
                 let v = Int64.logxor !prev x in
                 (prev := des_single !prev key true;
                  Some v)
               with
                 Stream.Failure -> None )

let test_ofb () =
  let ciphered = des_ofb_encrypt test_stream_ofb test_key test_iv in
  let decrypted = des_ofb_decrypt ciphered test_key test_iv in
  Stream.iter (fun x -> hex_print (Int64.to_string x)) decrypted              

let test_all () = 
         print_endline "Test ECB:";
         test_ecb ();
         print_endline "Test CBC:";
         test_cbc ();
         print_endline "Test CFB:";
         test_cfb ();
         print_endline "Test OFB:";
         test_ofb ()

(* let _ = test_all () *)
                  
                  
                  (*
The code to call the code generated from the usuba DES.
let hex_print x = 
  let _ = Sys.command ("perl -e 'printf\"%X\n\"," ^ x ^ "'") in ()
let test_int64  = Int64.of_string "0x0123456789ABCDEF"
let test_key    = Int64.of_string "0x133457799BBCDFF1"
let test_res    = Int64.of_string "0x85E813540F0AB405"
                                  
let input_stream = Stream.of_list [ test_int64; test_res ]
let key_stream = Stream.of_list [ test_key; test_key ]

let _ =
  Stream.iter (fun x -> hex_print (Int64.to_string x)) (main input_stream key_stream)
                   *)
