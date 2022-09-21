module Hash_consed = struct
  type 'a t = { node : 'a; tag : int; hkey : int }

  let pp ppn ppf { node; tag; hkey } =
    Format.fprintf ppf "@[<v 2>{node: %a;@ tag: %d;@ hkey: %d}]" ppn node tag
      hkey
end

let newtag =
  let r = ref 0 in
  fun () ->
    incr r;
    !r

module type HashedType = sig
  type t

  val equal : t -> t -> bool
  val hash : t -> int
end

module type Printable = sig
  type t

  val pp : Format.formatter -> t -> unit
end

module Printers = struct
  let pp_int ppf i = Format.fprintf ppf "%d" i

  let pp_list ?(pp_sep = fun ppf () -> Format.fprintf ppf "; ") ?(left = "[")
      ?(right = "]") pp ppf l =
    Format.fprintf ppf "%s%a%s" left Format.(pp_print_list ~pp_sep pp) l right

  let pp_array ?(pp_sep = fun ppf () -> Format.fprintf ppf "; ") ?(left = "[|")
      ?(right = "|]") pp ppf a =
    pp_list ~pp_sep ~left ~right pp ppf (Array.to_list a)
end

module HashTable (H : sig
  include HashedType
  include Printable with type t := t
end) : sig
  type t = {
    mutable table : H.t Hash_consed.t Weak.t array;
    mutable blocks_size : int;
    mutable limit : int;
  }

  val create : int -> t
  val hashcons : t -> H.t -> H.t Hash_consed.t
  val clear : t -> unit
  val pp : Format.formatter -> t -> unit
end = struct
  type t = {
    mutable table : H.t Hash_consed.t Weak.t array;
    mutable blocks_size : int;
    mutable limit : int;
  }

  open Hash_consed

  let pp_weak ppf w =
    for i = 0 to Weak.length w - 1 do
      match Weak.get w i with
      | None -> Format.fprintf ppf " "
      | Some v -> Format.fprintf ppf "%a" Hash_consed.(pp H.pp) v
    done

  let pp ppf { table; blocks_size; limit } =
    Format.fprintf ppf "@[<v 1>{table: %a;@ blocks_size: %d;@ limit: %d}]"
      Printers.(pp_array pp_weak)
      table blocks_size limit

  let next_size n = min ((3 * n / 2) + 3) (Sys.max_array_length - 1)

  let create size =
    let size = if size < 7 then 7 else min Sys.max_array_length size in
    let empty_block = Weak.create 0 in
    { table = Array.make size empty_block; blocks_size = 0; limit = 3 }

  let fold f t init =
    let rec fold_block i b accu =
      if i < Weak.length b then
        fold_block (i + 1) b
          (match Weak.get b i with Some v -> f v accu | None -> accu)
      else accu
    in
    Array.fold_right (fold_block 0) t.table init

  let rec resize t =
    let len = Array.length t.table in
    let new_len = next_size len in

    if new_len > len then (
      let new_table = create new_len in
      new_table.limit <- t.limit + 100;
      fold (fun d () -> add new_table d) t ();
      t.table <- new_table.table;
      t.limit <- t.limit + 2)

  and add t d =
    let index = d.hkey mod Array.length t.table in
    let block = t.table.(index) in
    let size = Weak.length block in

    let rec search i =
      if i < size then
        if Weak.check block i then search (i + 1) else Weak.set block i (Some d)
      else
        let new_size = min (size + 3) (Sys.max_array_length - 1) in

        if new_size <= size then failwith "Not enough space"
        else
          (* Crée un nouveau block vide *)
          let new_block = Weak.create new_size in

          (* Recopie le block *)
          Weak.blit block 0 new_block 0 size;
          (* Ajoute le nouvel élément *)
          Weak.set new_block i (Some d);

          t.table.(index) <- new_block;
          t.blocks_size <- t.blocks_size + (new_size - size);

          if t.blocks_size > t.limit * Array.length t.table then resize t
    in
    search 0

  and hashcons t d =
    let hkey = H.hash d land max_int in
    let index = hkey mod Array.length t.table in
    let block = t.table.(index) in
    let size = Weak.length block in

    let rec search i =
      if i < size then
        match Weak.get_copy block i with
        | Some v when H.equal v.node d -> (
            match Weak.get block i with Some v -> v | None -> search (i + 1))
        | _ -> search (i + 1)
      else
        let n = { hkey; tag = newtag (); node = d } in
        add t n;
        n
    in
    search 0

  let clear t =
    let empty_block = Weak.create 0 in
    for i = 0 to Array.length t.table - 1 do
      t.table.(i) <- empty_block
    done;
    t.blocks_size <- 0;
    t.limit <- 3
end

module PArray = struct
  type 'a t = 'a data ref
  and 'a data = Array of 'a array | Diff of int * 'a * 'a t

  let rec pp ppv ppf t = Format.fprintf ppf "%a" (pp_data ppv) !t

  and pp_data ppv ppf = function
    | Array a -> Format.fprintf ppf "Array %a" (Printers.pp_array ppv) a
    | Diff (i, v, t) ->
        Format.fprintf ppf "Diff (%d, %a, %a)" i ppv v (pp ppv) t

  let create n v = ref (Array (Array.make n v))
  let init n f = ref (Array (Array.init n f))

  let rec rerootk t k =
    match !t with
    | Diff (i, v, t') ->
        (reroot t';
         let n = !t' in
         match n with
         | Array a ->
             let v' = a.(i) in
             a.(i) <- v;
             t := n;
             t' := Diff (i, v', t)
         | _ -> assert false);
        k ()
    | _ -> ()

  and reroot t = rerootk t (fun () -> ())

  let ( = ) a1 a2 =
    let a1, a2 =
      match (!a1, !a2) with
      | Array a1, Array a2 -> (a1, a2)
      | _ ->
          reroot a1;
          let a1 =
            match !a1 with Array a1 -> Array.copy a1 | _ -> assert false
          in
          reroot a2;
          let a2 =
            match !a2 with Array a2 -> Array.copy a2 | _ -> assert false
          in
          (a1, a2)
    in
    Stdlib.Array.for_all2 (fun a b -> a == b) a1 a2

  let ( != ) a1 a2 =
    let a1, a2 =
      match (!a1, !a2) with
      | Array a1, Array a2 -> (a1, a2)
      | _ ->
          reroot a1;
          let a1 =
            match !a1 with Array a1 -> Array.copy a1 | _ -> assert false
          in
          reroot a2;
          let a2 =
            match !a2 with Array a2 -> Array.copy a2 | _ -> assert false
          in
          (a1, a2)
    in
    Stdlib.Array.exists2 (fun a b -> a <> b) a1 a2

  let get t i =
    match !t with
    | Array a -> a.(i)
    | _ -> (
        reroot t;
        match !t with Array a -> a.(i) | _ -> assert false)

  let set t i v =
    reroot t;
    match !t with
    | Array a as n ->
        let old = a.(i) in
        if old == v then t
        else (
          a.(i) <- v;
          let res = ref n in
          t := Diff (i, old, res);
          res)
    | _ -> assert false
end

module PUnion = struct
  type t = { mutable father : int PArray.t; rank : int PArray.t }

  let pp ppf t =
    Format.fprintf ppf "{father: %a; rank: %a}"
      PArray.(pp Printers.pp_int)
      t.father
      PArray.(pp Printers.pp_int)
      t.rank

  let create n =
    { rank = PArray.create n 0; father = PArray.init n (fun i -> i) }

  let rec find_aux f i =
    let fi = PArray.get f i in
    if fi == i then (f, i)
    else
      let f, r = find_aux f fi in
      let f = PArray.set f i r in
      (f, r)

  let find t x =
    let f, rx = find_aux t.father x in
    t.father <- f;
    rx

  let union h x y =
    let rep_x = find h x in
    let rep_y = find h y in
    if rep_x == rep_y then h
    else
      let rank_x = PArray.get h.rank rep_x in
      let rank_y = PArray.get h.rank rep_y in
      if rank_x > rank_y then
        { h with father = PArray.set h.father rep_y rep_x }
      else if rank_x < rank_y then
        { h with father = PArray.set h.father rep_x rep_y }
      else
        {
          rank = PArray.set h.rank rep_x (rank_x + 1);
          father = PArray.set h.father rep_y rep_x;
        }

  let ( = ) t1 t2 = PArray.(t1.father = t2.father) && PArray.(t1.rank = t2.rank)

  let ( != ) t1 t2 =
    PArray.(t1.father != t2.father) || PArray.(t1.rank != t2.rank)
end

let%test_module "PArray" =
  (module struct
    let%test "no changes is equal" =
      let a0 = PArray.create 7 0 in
      let a1 = PArray.set a0 1 0 in
      PArray.(a0 = a1)

    let%test "change is different" =
      let a0 = PArray.create 7 0 in
      let a1 = PArray.set a0 1 1 in
      PArray.(a0 != a1)

    let%test "complex changes are equal" =
      let a0 = PArray.create 7 0 in
      let a1 = PArray.set a0 1 1 in
      let a2 = PArray.set a1 3 4 in
      let a3 = PArray.set a0 3 4 in
      let a4 = PArray.set a3 1 1 in
      PArray.(a2 = a4)
  end)

let%test_module "Hash_consing" =
  (module struct
    module Term = struct
      open Hash_consed

      type term = term_node Hash_consed.t
      and term_node = Var of int | Lam of term | App of term * term

      type t = term_node

      let equal x y =
        match (x, y) with
        | Var n, Var m -> n == m
        | Lam u, Lam v -> u == v
        | App (u1, u2), App (v1, v2) -> u1 == v1 && u2 == v2
        | _ -> false

      let hash = function
        | Var i -> i
        | Lam t -> abs ((19 * t.hkey) + 1)
        | App (u, v) -> abs ((19 * ((19 * u.hkey) + v.hkey)) + 2)

      let rec pp ppf = function
        | Var i -> Format.fprintf ppf "Var %d" i
        | Lam t -> Format.fprintf ppf "λ %a" pp t.node
        | App (t1, t2) -> Format.fprintf ppf "%a %a" pp t1.node pp t2.node
    end

    module H = HashTable (Term)

    let table = H.create 53
    let var n = H.hashcons table (Var n)
    let lam t = H.hashcons table (Lam t)
    let app t1 t2 = H.hashcons table (App (t1, t2))

    let%test "equal tag simple" = (var 1).tag == (var 1).tag

    let%test "equal tag nested" =
      (app (lam (var 1)) (var 2)).tag == (app (lam (var 1)) (var 2)).tag

    let%test "different tag same const" = (var 1).tag <> (var 2).tag

    let%test "different tag nested" =
      (app (lam (var 2)) (var 1)).tag == (app (lam (var 2)) (var 1)).tag

    let%test "different tag different const" = (var 1).tag <> (lam (var 1)).tag
  end)

let%test_module "Union Find" =
  (module struct
    let%test "creation is equal" =
      let uf = PUnion.create 10 in
      let uf2 = PUnion.create 10 in
      PUnion.(uf = uf2)

    let%test "change is equal" =
      let uf = PUnion.create 10 in
      let uf1 = PUnion.union uf 1 2 in
      let uf2 = PUnion.union uf 1 2 in
      PUnion.(uf1 = uf2)

    let%test "change is consistent" =
      let uf = PUnion.create 10 in
      let uf = PUnion.union uf 1 2 in
      PUnion.find uf 2 = 1

    let%test "complex change is consistent" =
      let uf = PUnion.create 10 in
      let uf = PUnion.union uf 1 2 in
      let uf = PUnion.union uf 3 4 in
      let uf = PUnion.union uf 2 5 in
      let uf = PUnion.union uf 1 3 in
      PUnion.find uf 4 = 1

    let%test "ordered change is different" =
      let uf = PUnion.create 10 in
      let uf1 = PUnion.union uf 1 2 in
      let uf2 = PUnion.union uf1 2 3 in
      let uf3 = PUnion.union uf 1 2 in
      let uf4 = PUnion.union uf3 2 3 in
      PUnion.(uf2 = uf4)

    let%test "unordered change is different" =
      let uf = PUnion.create 10 in
      let uf1 = PUnion.union uf 1 2 in
      let uf2 = PUnion.union uf1 2 3 in
      let uf3 = PUnion.union uf 2 3 in
      let uf4 = PUnion.union uf3 1 2 in
      PUnion.(uf2 != uf4)
  end)
