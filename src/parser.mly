
%{
    open Abstract_syntax_tree
%}

/*******************\
|*      tokens     *|
\*******************/
%token TOK_NODE
%token TOK_RETURN
%token TOK_LET
%token TOK_TEL
%token TOK_WHEN
(* %token TOK_MERGE *)

%token TOK_UNDEF

%token TOK_LPAREN
%token TOK_RPAREN
%token TOK_EQUAL
%token TOK_COMMA
%token TOK_TWO_COLON
%token TOK_COLON
%token TOK_SEMICOLON

%token TOK_AND
%token TOK_OR
%token TOK_XOR
%token TOK_NOT

%token <string> TOK_id
%token <string> TOK_int
/* do we need int ? */

%token TOK_EOF

/*******************\
|*   entry point   *|
\*******************/
%start<Abstract_syntax_tree.prog> prog


%%

prog:
  | d=defs TOK_EOF { d }

op:
  | TOK_AND { AST_and }
  | TOK_OR  { AST_or  }
  | TOK_XOR { AST_xor }
  | TOK_NOT { AST_not }

exp:
  | x=TOK_int { AST_const (int_of_string x) }
  | id=TOK_id  { AST_var(AST_ident id) }
  | TOK_LPAREN; t=explist; TOK_RPAREN  { AST_tuple t }
  | o=op; TOK_LPAREN; args=explist; TOK_RPAREN { AST_op(o, args) }
  | f=TOK_id; TOK_LPAREN; args=explist; TOK_RPAREN { AST_fun(AST_ident f, args) }
  | e=exp; TOK_WHEN; cstr=TOK_id; TOK_LPAREN; x=TOK_id; TOK_LPAREN
    { AST_mux(e,AST_ident cstr,AST_ident x) }
  (* TODO: add merge *)

explist:
  | x=exp                           { [ x ]     }
  | tail=explist; TOK_COMMA; x=exp  { x :: tail }

pat:
  | i=TOK_id                          { AST_pat [ AST_ident i ] }
  | TOK_LPAREN; l=patlist; TOK_RPAREN { AST_pat   l   }

patlist:
  | i=TOK_id                            { [ AST_ident i ]     }
  | tail=patlist; TOK_COMMA; i=TOK_id   { (AST_ident i) :: tail }

deq: (* returns a tuple list, is converted to AST by def *)
  | p=pat; TOK_EQUAL; e=exp                           { [ ( p, e ) ]  }
  | tail=deq; TOK_SEMICOLON; p=pat; TOK_EQUAL; e=exp  { (p,e) :: tail }

p:
  | ps=psingle      { AST_p([ps]) } 
  | l=plist         { AST_p(List.rev l)    }

psingle:
  | x=TOK_id TOK_COLON typ=TOK_UNDEF TOK_TWO_COLON ck=TOK_UNDEF
    { (AST_ident x, AST_undef, AST_undef) }

plist:
  | e=psingle                        { [ e ] }
  | tail=plist; TOK_COMMA; e=psingle { e :: tail }

def:
  | TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p TOK_LET body=deq TOK_TEL
  { AST_def(AST_ident f,p_in,p_out,AST_deq (List.rev body)) }
  
defs:
  | d=def              { [ d ] }
  | d=def; dl=defs     { d::dl }

%%