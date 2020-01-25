I observed some surprising performance behavior when unrolling a loop
which does 3 additions.

Here are my (preliminary) findings on the loop twice unrolled:

 - Most of the time, performances are of 2.45 cycles/iteration.

 - Ideal performances (2 cycles/iteration) are achieved when the jump
   is aligned on 64 bytes.
 
 - When the jump is aligned on 64 bytes, it doesn't fuse with the
   `add` before it (8 billion uops).
   
 - In all other cases, it seems to fuse with the add (7 billion uops).
 
 - With some alignments, the DSB is not used and all instructions come
   from the MITE.
 
 - In such cases, performances are worst (3 to 4 cycles/iteration).

