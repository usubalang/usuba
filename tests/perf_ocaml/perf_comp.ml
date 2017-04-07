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

let rand_list = make_list_f (fun () -> Random.int64 Int64.max_int) 10_000
let key = Random.int64 Int64.max_int
                            
let stream1 = Stream.of_list rand_list
let stream2 = Stream.of_list rand_list
let stream3 = Stream.of_list rand_list
let key_stream = Stream.from (fun _ -> Some key)

let unfold_stream stream =
  let rec aux () = Stream.next stream; aux () in
  let _ = (try
              aux ()
            with _ -> ()) in
  ()
                             
let _ =
  let t = Sys.time () in
  let out_std = Des.des_ecb_encrypt stream1 key in
  unfold_stream out_std;
  Printf.printf "Standart implem: %.3f seconds\n"
                (Sys.time () -. t);
  let t = Sys.time () in
  let out_naive = Des_v1_naive.main stream2 key_stream in
  unfold_stream out_naive;
  Printf.printf "Naive bitsliced: %.3f seconds\n"
                (Sys.time () -. t);
  let t = Sys.time () in
  let out_ortho = Des_v1_ortho.main stream3 key_stream in
  unfold_stream out_ortho;
  Printf.printf "Ortho bitsliced: %.3f seconds\n"
                (Sys.time () -. t);
  

