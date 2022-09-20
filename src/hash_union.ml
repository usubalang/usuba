
type +'a hash_consed = {
    node : 'a;
    tag : int;
    hkey : int;
}

type op = Mul | Add | Sub | Div | Mod

type htreeInst = treeInst hash_consed and treeInst =
    | Value of int 
    | Operation of treeInst * op * treeInst

let newtag =
    let r = ref 0 in
    fun () -> incr r;
    !r

module type HashedType = sig
    type t
    val equal : t -> t -> bool
    val hash : t -> int 
end

module HashTable(H : HashedType) : sig
    type t = {
        mutable table : H.t hash_consed Weak.t array;
        mutable blocks_size : int; 
        mutable limit : int;
    }   
    val create : int -> t
    val hashcons : t -> H.t -> H.t hash_consed
end = struct 
    type t = {
        mutable table : H.t hash_consed Weak.t array;
        mutable blocks_size : int; 
        mutable limit : int;
    }   

    let next_size n = 
        min (3*n/2 + 3) (Sys.max_array_length - 1) 

    let create size = 
        let size = if size < 7 then 7 else size in
        let size = if size > Sys.max_array_length then Sys.max_array_length else size in 
        let empty_block = Weak.create 0 in {
            table = Array.make size empty_block;
            blocks_size = 0;
            limit = 3;
        }

    let fold f t init = 
        let rec fold_block i b accu = 
            if i < Weak.length b then 
                fold_block (i + 1) b (
                    match Weak.get b i with 
                    | Some v ->  (f v accu)
                    | None -> accu
                )
            else accu
        in 
            Array.fold_right (fold_block 0) t.table init

    let rec resize t = 
        let len = Array.length t.table in
        let new_len = next_size len in

        if new_len > len then 
            let new_table = create new_len in 
            new_table.limit <- t.limit + 100;
            fold (fun d () -> add new_table d) t ();
            t.table <- new_table.table;
            t.limit <- t.limit + 2;

    and add t d = 
        let index = d.hkey mod (Array.length t.table) in  
        let block = t.table.(index) in 
        let size = Weak.length block in 

        let rec search i = 
            if i < size then 
                if Weak.check block i then 
                    search (i + 1)
                else 
                    Weak.set block i (Some d)
            else 
                let  new_size = min (size + 3) (Sys.max_array_length - 1) in

                if new_size <= size then 
                    failwith "Not enought space"
                else
                    (* Crée un nouveau block vide *)
                    let new_block =     
                        Weak.create new_size 
                    in

                    (* Recopie le block *)
                    Weak.blit block 0 new_block 0 size;
                    (* Ajoute le nouvel élément *)
                    Weak.set new_block i (Some d);

                    t.table.(index) <- new_block;
                    t.blocks_size <- t.blocks_size + (new_size - size);

                    if t.blocks_size > t.limit * Array.length t.table then
                        resize t;
         in 
            search 0 

    and hashcons t d = 
        let hkey = H.hash d land max_int in 
        let index = hkey mod (Array.length t.table) in 
        let block = t.table.(index) in
        let size = Weak.length block in 
        
        let rec search i = 
            if i < size then 
                match Weak.get_copy block i with
                | Some v when (H.equal v.node d) -> (
                    match Weak.get block i with 
                    | Some v -> v
                    | None -> search (i + 1)
                )
                | _ -> search (i + 1)
            else
                let n = { hkey = hkey; tag = newtag(); node = d } in 
                add t n; 
                n
        in 
            search 0

    and clear t =
        let empty_block = Weak.create 0 in
        for i = 0 to Array.length t.table - 1 do
            t.table.(i) <- empty_block
        done;
        t.blocks_size <- 0;
        t.limit <- 3
end

module PArray = struct 
    type 'a t = 'a data ref and 'a data = 
        | Array of 'a array 
        | Diff of int * 'a * 'a t

    let create n v = ref (Array(Array.make n v))
    let init n f = ref (Array(Array.init n f))
    
    let rec rerootk t k = 
        match !t with
        | Diff(i,v,t') -> 
            begin
            reroot t';
            let n = !t' in 
            match n with
                | Array a ->
                    let v' = a.(i) in 
                    a.(i) <- v;
                    t := n;
                    t' := Diff(i, v', t)
                | _ -> 
                    assert false 
            end;
            k()
        | _ -> ()

    and reroot t = rerootk t (fun () -> ())

    let get t i = match !t with 
        | Array a -> a.(i)
        | _ -> reroot t; 
            begin
                match !t with 
                | Array a -> a.(i)
                | _ -> assert false
            end

    let set t i v = 
        reroot t;
        match !t with 
        | Array a as n -> 
            let old = a.(i) in 
            if old == v then
                t 
            else begin
                a.(i) <- v;
                let res = ref n in
                t := Diff(i,old,res);
                res
            end
        | _ -> assert false
end 

module PUnion = struct 
    type t = {
        mutable father : treeInst PArray.t;
        rank : int PArray.t;
    }

    let create n = {
        rank = PArray.create n 0;
        father = PArray.init n (fun i -> Value i);
    }
    let rec find_aux f i = 
        let fi = PArray.get f i in
        if fi = i then
            f,i
        else
            let f,r = find_aux f fi in
            let f = PArray.set f i r in 
                f,r

    let find h x = 
        let f,rx = find_aux h.father x in 
            h.father <- f;
            rx

    let union h x y = 
        let rx = find h x in
        let ry = find h y in 
        if rx = ry then
            h
        else begin
            let rxc = PArray.get h.rank rx in 
            let ryc = PArray.get h.rank ry in 
            if rxc > ryc then {
                h with father = PArray.set h.father ry rx 
            } else if rxc < ryc then {
                h with father = PArray.set h.father rx ry 
            } else {
                rank = PArray.set h.rank rx (rxc + 1);
                father = PArray.set h.father ry rx
            }
        end
end