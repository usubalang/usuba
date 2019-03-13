# Usuba & SMT 


## SMT-LIB

 - **Functions.** Can't define functions, only macros (not really a SMT-LIB issue, but rather something a bit tedious to handle with SMT-LIB). And macros can't return multiple values -> a function with _n_ return values become _n_ macros.  
 For instance, 
 
 ```
 node f(a,b) returns (c,d)
 let
     c = a ^ b;
     d = a & b
 tel
 ```
 
 Becomes
 
 ```
 (define-fun f-c ((a Bool) (b Bool)) Bool
     (let ((c (xor a b)))
     (let ((d (and a b)))
        c)))
 (define-fun f-d ((a Bool) (b Bool)) Bool
     (let ((c (xor a b)))
     (let ((d (and a b)))
        d)))
 ```
 
 Now imagine this with 64 outputs and a function with hundreds of temporary variables -> a bit heavy.
 
 - **Arrays** are hard to handle. Usuba code often contain code like
 
 ```
 node g(x:bool[2], y:bool[2]) returns (z:bool[2])
 let
     z[0] = x[0] ^ y[0];
     z[1] = x[1] ^ y[1]
 tel
 ```
 
 In such a case, I guess using a BitVector could work. But in the more general case were you can have arrays of arrays, and where values can have non-boolean types (Integers / BitVectors), you need to use SMT-LIB arrays (or do you?). Once again, this feels very unpleasant. Also, I'm _guessing_ Z3 won't be very happy (read "efficient") to have to deal with arrays (but I haven't tested it).
 
 - **Loops.** Usuba contains loops that look like `foreach i in [start, end]` and correspond to `for (i = start; i <= end; i++)` in C, or `foreach i in range(start,end+1)` in Python. In SMT-LIB, this is a bit tedious: the following code
 
 ```
 forall i in [1, 5] {
       out[i] = in[i]
 }
 ```
 
 Would be translated to something like
 
 ```
 (forall ((i Int))
       (xor (or (< i 1) (> i 5))  ;; out of the loop's bounds
            (= (select in i) (select out i))))
 ```
 
 -> doesn't look very pleasant, and I don't know whether Z3 would be efficient with such loops.
 
 
## Python's interface to Z3

The idea is actually to generate a python program which will generate a Z3 SMT tree. The only Z3 variables that I define are the inputs of the program. Every intermediary variable is a python variable that isn't directly added to the tree, but rather used to create another variable, and ultimately to set the outputs (which will be seen by Z3). For instance,

```
node f(a,b) returns (c)
let
    tmp1 = a ^ b
    tmp2 = a & b
    tmp3 = tmp1 | tmp2
    c = tmp3
tel
```

becomes

```python
def f(a,b):
    tmp1 = a ^ b
    tmp2 = a & b
    tmp3 = tmp1 | tmp2
    c = tmp3
    return c
    
a = Bool('a')
b = Bool('b')
c = f(a,b)

```
And, to be complete, if we wanted to show that `f` is equivalent to some function `g`, the generated code would be something like:

```
a2 = Bool('a2')
b2 = Bool('b2')
c2 = g(a2,b2)

s = Solver()
s.add(c != c2)
print(s.check())
```

And if `f` and `g` are indeed equivalent, Z3 should output `unsat`.

Using Python have several advantages over SMT-LIB:

 - **Functions.** Usuba functions are converted into Python functions. The translation is very straight forward (cf. example above). Python's functions can return mutliple values (tuples), like Usuba's, which make them quite convenient. For instance,
 
 ```
 node f(a,b) returns (c,d)
 let
     c = a ^ b;
     d = a & b
 tel
 ```
 
 will become
 
 ```python
 def f(a,b)
     c = a ^ b
     d = a & b
     return (c,d)
 ```
 
 This choice was motivated by two things:
  - Z3's python interface doesn't have an equivalent to SMT-LIB `define-fun`
  - This is the approach the seem to be usually taken in the litterature.
 
 It's worth noting that such functions behave exactly like `define-fun`: the latter is a macro that is expanded in the tree; and the former will be called within python to produce part of the tree, and as far as Z3 is concerned, both approaches produce the same tree.
 
 - **Arrays.** We use Python's arrays to represent Usuba's arrays. For instance,
 
 ```
 node g(x:bool[2], y:bool[2]) returns (z:bool[2])
 let
     z[0] = x[0] ^ y[0];
     z[1] = x[1] ^ y[1]
 tel
 ```
 
 becomes
 
 ```python
 def g(x,y):
     z = [ None for _ in range(2) ]    # Need to declare the arrays
     z[0] = x[0] ^ y[0]
     z[1] = x[1] ^ y[1]
     return z
 ```
 
 They work the same as Usuba's arrays. In particular, we can easily use sub-arrays (ie, if we have `x:bool[2][3]`, then `x[1]` has type `bool[3]` in both Usuba and Python. And the syntax to manipulate them is quite lightweight (compared to Z3's arrays). Z3 never actually knows (I think) that any arrays were used.
 
 - **Loops.** Usuba's loops become Python's loops, using `foreach` and `range`. For instance,
 
 ```
 forall i in [1, 5] {
       out[i] = in[i]
 }
 ```
 
 becomes
 
 ```
 forall i in range(1,6):
       out[i] = in[i]
 ```
 
 Once again, Z3 won't know that there ever was a loop somewhere: the loop will be executed in Python are therefore be unrolled in the SMT tree generated. (this is possible only since loops bounds are statically known)


## Evaluation

We check 3 passes of the compiler using Z3: 
 - a pass of scheduling
 - a pass of inlining combined with some scheduling
 - a pass of (a different) scheduling combined with some redundancy elimination (CSE/CF/CP)
 
For each pass, we generate two SMT trees: one for the program before, one for the program after, and we ask Z3 to check that both are equivalent. The time need to check each pass were the following:

- Rectangle V-sliced (using 16-bits BitVectors): 40/40/40 seconds
- Rectangle Bitsliced (using Bool): 17/17/17 seconds
- DES (using Bool): 1/1/1 second
- AES (using Bool): 2.7//2.7 seconds
- Chacha20 V-sliced (using 32-bits BitVectors): <1/<1/<1 second
- Serpent V-sliced (using 32-bits BitVectors): <1/<1/<1 second (/!\ Using arithmetic shifts - see [Issues](#Issues))

We tried to manually insert errors in the SMT tree to check that Z3 would say `sat` (instead of `unsat`) as expected. It takes much longer to Z3 to come to such a conclusion: from a few seconds on DES, up to more than 25 minutes on Rectangle V-sliced (I actually stopped after 25 minutes; the memory consumption was about 16GB). Z3 never said `unsat` when we manually faulted the tree.

## Issues

- **Rotations / Logical shifts**. Some ciphers (eg Serpent) use rotations. Experimentally, Z3 doesn't come near proving equivalence between two full Serpents. Serpent contains 32 rounds. When reducing it to 5 rounds, it takes Z3 about 3 seconds to check the correctness of our transformations. With 10 rounds, it takes about 50 minutes. With 32 rounds, it's likely undoable. We can replace the rotations with shifts: if `x:u32`, then `x <<< n == (x << n) | (x >> (32-n))`. Using this to represent rotations allows Z3 to verify the whole Serpent in under 2 seconds. However, this result isn't the most precise, since `>>` is an arithmetic shift (ie signed) and not a logical one. Replacing `>>` with `LShR` (Z3's logical right shift) yield the same issue as rotations.
  - A solution could be to try and remove rotations at Usuba level. However, I expect that this isn't easily doable.
  - Is using arithmetic shifts really wrong? If both programs are equivalent with arithmetic shifts, it might imply that they are equivalent when using logical shifts -> think of a proof/justification/counter-example.
  
- **AES inlining**. Transformations that don't change too much the structure of the program (eg. scheduling) seem easy to verify. However, inlining changes quite a lot structure of the program, and AES's code is quite long (fully unrolled (which it is once the SMT problem has been generated), it is probably around 8-10k instructions). 


## TODO

- **Permutations.** We left out H-slicing for now. Concretely, we just need something to do bit permutations in Z3. For instance, consider the following Usuba code:

 ```
x,y:u4
y = Shuffle(x,[1,0,3,2])
 ```

 It is somewhat equivalent to

 ```
x,y:u4
y = (x >> 1 & 1) |
    ((x >> 0 & 1) << 1) |
    ((x >> 3 & 1) << 2) |
    ((x >> 2 & 1) << 3)
 ```

 We could encode it using such shift/masks peharps.


- **Performances.** It would be good to understand why some programs are very fast for Z3 to verify (DES, Chacha20), while others are slow (AES, Serpent). It doesn't seem to be correlated with the size of the code (DES's code is quite long, yet fast; AES 1st pass is fast, but the second is not..). Ultimately, understanding this could help us understand how to write "good" SMT problems, that Z3 knows how to solve efficiently.


## References

Dennis Yurichev, [SAT/SMT by Example](https://github.com/DennisYurichev/SAT_SMT_by_example/blob/master/libs/SAT_lib.py).  

Leonardo de Moura, Nikolaj Bjørner, [Z3 - a Tutorial](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.225.8231&rep=rep1&type=pdf).  

Nikolaj Bjørner, Leonardo de Moura, Lev Nachmanson, [Programming Z3](https://theory.stanford.edu/~nikolaj/programmingz3.html).  

Leonardo de Moura, &lt;other authors?&gt;, [Z3 API in Python](https://www.cs.tau.ac.il/~msagiv/courses/asv/z3py/guide-examples.htm).
