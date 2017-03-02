
open Abstract_syntax_tree

module type SPECIFIC_REWRITER =
  sig
    
    val keep_print : bool

    val gen_print : 'a list -> ident

    val gen_entry_point : def -> string list * string
                                   
  end
