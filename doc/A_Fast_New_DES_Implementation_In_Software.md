A Fast New DES Implementation in Software, Eli Biham, 1997
===

This paper presents two things:  
 - the first __bitslice__ implementation of DES.  
 - a fast implementation of DES (without bitslicing).  
The former is almost 5 times faster than the standart implementation, and the latter about 2 times faster.

The bitslice DES allows for 64 parallel executions of DES.  
Cost of the operations:  
 - XOR costs the same.  
 - expension and permutations are free (they are equivalent to a simple renaiming).  
 - S-BOX are more tricky. They are implemented through logical gates circuit instead of lookup tables. (~ 100 gates / S-BOX => 1.5 gate / block (since there are 64 parallel executions)).  

Part of the cost also comes from converting the data from their standart representation to their bitsliced representation. This can be achieved in ~40 cycles per block. However, this isn't always needed.  

Also, standart CBC (or CFB, or OFB) mode can't be used, since 64 blocks are computed simultaneously. A solution is to use CBC on 4096 bits (= 64*64) blocks. Or, for other cases, Bigam presents a new CBC-like mode that is more secure.

Most of the cost of the bitsliced DES comes from the number of gates used for the S-BOX. That number can be improved, and was reduced to 56 by Kwan (Reducing the Gate Count of Bitslice DES, Matthew Kwan, 2000).

