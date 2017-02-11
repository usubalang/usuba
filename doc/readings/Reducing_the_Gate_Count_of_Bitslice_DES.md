Reducing the Gate Count of Bitslice DES, Matthew Kwan
===

*Notes: the paper is a bit too complex for me right now. I hardly understand the details, but hopefully I got the main ideas right.*

From the observation that the only way to improve the bitsliced implementation of DES is to reduce the number of gates per S-box, this paper presents several way to do so. Kwan eventually uses this techniques to obtain S-box of 56 gates in average, which is shorter than the previous best known 61.  

The goal of Kwan's approach is to reuse as many gates as possible. To do so, he uses Karnaugh maps to represent the S-box as a function of 6 variables. Then, a reccursive algorithm searches for the best way to combine the existing gates in order not to add new ones.

This approach is quite time consumming: it tooks 6 weeks to find the best gates with non-standart instructions (ie. NAND, NOR, etc.).  
Another downside of how Kwan uses this techniques is that it leaves the register allocation problem up to the compiler.

As Kwan point out himself, the circuits he find are probably not optimals, and shorter ones might be found. (by either improving the approach, or by using a new one).
