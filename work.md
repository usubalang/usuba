# Work status

This file contains my notes about my work: what I have done, what I'm planning to do, how I feel about some aspects of the project, etc. Unless specified otherwise, the questions are adressed to myself. As I'm writing this file, I'm not sure wether I'll keep updating it every day or not, nor if the format will remain the same. For now, I'm using as kind of an extensive TODO list and log file.

The sections I'm using are:
- *Done*: what I've done during the day.
- *Example*: concrete example of what I've done (so basically, commands to run).
- *Status*: comments about what I've done, and what I should do.
- *TODO*: what I plan to do next.
*Status* and *TODO* kinda overlap some times... maybe I'll merge them.


### 13/02/17

__DONE__:

- minimalist parser/lexer.  
- AST "pretty-printer" (not that pretty actually).
- implementation of Kwan's S-box number 4 (it's the shorter one).

__Example__:

Run the following code in your terminal to compile the project and execute the main on the file `s-box-4`. This file contains Kwan's 4th S-box converted to the syntax of my language. `test-native` will create an AST from the code of `s-box-4`, and will then print it.

```bash
cd src
make
./test.native s-box-4
```


__Status__:

- `merge` is missing. I wasn't sure about the syntax. need to think a little bit about it.  
- `C` (cf BNF) is fairly approximative now, need to think about it.  
- the syntax is very imperative for now (`;` and `,` everywhere): is it ok?  
- a lot of AST types looks like `type pat = AST_pat of ident list` -> maybe remove the "useless" indirection?
- debugging is very hard since the errors don't mention the line/col number -> improve this?  
- maybe restart from scratch, but cleaner?  
- What are my examples? just a run of S-box? clarify with Pierre-Evariste maybe.  

__TODO__:

- generation of OCaml code (with `Parsetree`). Maybe I shouldn't start that too soon though.  
- take the time to read a small tutorial/doc about menhir?
- find a name for the language, or a least a file extension.
