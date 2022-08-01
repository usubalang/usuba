let ( = ) a b = Int.equal a b
let ( <> ) a b = not (Int.equal a b)
let ( < ) (a : int) (b : int) = a < b
let ( > ) (a : int) (b : int) = a > b
let ( <= ) (a : int) (b : int) = a <= b
let ( >= ) (a : int) (b : int) = a >= b
let compare = Int.compare

module List = struct
  include Stdlib.List

  let mem _ _ =
    failwith "Use of List.mem is forbidden as it uses the polymorphic `=`"
end
