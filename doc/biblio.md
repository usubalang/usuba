# A short bibliography about bitslicing papers

## Bitslicing

Separeted in two parts: papers about the a bitslice implementation of a specific algorithm, and specific bitslicing techniques are in __bitslicing implementations__, and optimization of S-box are in __S-BOX optimization__.

#### Bitslicing implementations

- __Eli Biham, [A fast New DES Implementation in Software](http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/1997/CS/CS0891.pdf), 1997.__  
  The first paper about using bitslicing to optimize DES. 
  Biham explains how bitslicing works, how to convert sbox to circuits, how to orthogonalize the data, and how it behaves with the different modes of operation of DES.
  
- __Ross Anderson, Eli Biham, Lars Knudsen, [Serpent: A proposal for the Advanced Encryption Standard](http://www.cl.cam.ac.uk/~rja14/Papers/serpent.pdf), 1998.__  
  (I didn't read the *Security* nor the *Performance* part).  
  This paper present __Serpent__ cipher. It is designed to be use in bitslice mode. However, the bitslice of Serpent is very different from the bitslice of DES: whereas bitsliced DES computes 64 DES in parallel, Serpent computes only one block at a time in a bitsliced way. Any implementation of Serpent is bitsliced, due to how the algorithm is designed. (and thus, I don't think usuba can (or rather should) be used to implement Serpent).
  
- __Thomas Pornin, [Implantation et optimization's des primitives cryptographiques](http://www.bolet.org/~pornin/2001-phd-pornin.pdf), Chapitre 3, 2001 (Phd Thesis).__  
  A presentation of bitslicing techniques: when it's useful, when it's not, and how to do it (in particular, the orthogonalization of the data, and the conversion of the lookup tables).  
  Pornin developed a compiler named `bsc` for a language that allows to write bitsliced algorithms quite conveniently.

- __Atri Rudra et al., [Efficient Rijndael Encryption Implementation with Composite Field Arithmetic](http://link.springer.com/chapter/10.1007/3-540-44709-1_16), 2001.__  
  The first bitslice implementation of Rijndael (now known as AES). This paper is based on a lot of mathematics (Galois Fields and composite fields), to achieve a very efficient bitsliced implementation of Rijndael.  
  *I haven't read much of this paper, as I'm not familiar with composite fields at all.*  
    
- __Gunnar Gaubatz, Berk Sunar, [Leveraging the Multiprocessing Capabilities of Modern Network Processors for Cryptographic Acceleration](http://www.cs.nthu.edu.tw/~ychung/conference/NCA_2005.pdf), 2005.__  
  This paper presents a bitsliced implementation of Kasumi block cipher, targetting Intel IXP 2xxx microengine.  
  The structure of Kasumi is quite interesting: it consists of 3 nested Feistel networks. *Bitslicing it doesn't look too hard (but, once again, CBC won't be applicable easily).*  
  The paper doesn't dive too deep into details, except for the orthogonalization algorithm for which they gave the pseudo-code.

- __Chester Rebeiro, David Selvakumar, A.S.L. Devi, [Bitslice Implementation of AES](http://link.springer.com/chapter/10.1007%2F11935070_14), 2006.__  
  A bitslice implementation of AES. The paper is oriented on how to implement AES in bitslice, rather than the theory behind it (part of which comes from Atri Rudra et al., *Efficient Rijndael Encryption Implementation with Composite Field Arithmetic*). They use the sboxes of D. Canright's *A Very Compact Rijndael S-box* (132 gates).  
  I'm not exactly sure what improvement they make over *Efficient Rijndael Encryption Implementation with Composite Field Arithmetic*...

- __Adnan Baysal, Sühap Sahin, [RoadRunneR: A Small and Fast Bitslice Block Cipher for Low Cost 8-Bit Processors](http://link.springer.com/chapter/10.1007/978-3-319-29078-2_4), 2015.__  
  __TODO__

- __WenTao Zhang et al., [RECTANGLE: a bit-slice lightweight block cipher suitable for multiple platforms](https://eprint.iacr.org/2014/084.pdf), 2015.__  
  __TODO__

- __Seiichi Matsuda, Shiho Moriai, [Lightweight Cryptography for the Cloud:
Exploit the Power of Bitslice Implementation](http://www.iacr.org/archive/ches2012/74280406/74280406.pdf).__  
  __TODO__

- __Zhenzhen Bao et al., [Bitsliced Implementations of the PRINCE, LED and RECTANGLE Block
Ciphers on AVR 8-bit Microcontrollers](http://eprint.iacr.org/2015/1118.pdf).__  
  __TODO__

- __Ryad Benadjila et al., [Implementing Lightweight Block Ciphers on x86 Architectures](https://eprint.iacr.org/2013/445.pdf).__  
  __TODO__

- __Josep Balasch et al., [DPA, Bitslicing and Masking at 1 GHz](https://eprint.iacr.org/2015/727.pdf).__    
  __TODO__

- __Ko Stoffelen, [Optimizing S-box Implementations for Several Criteria using SAT Solvers](http://eprint.iacr.org/2016/198.pdf).__  
  __TODO__

- __Lauren May et al., [An Implementation of Bitsliced DES on the Pentium MMX Processor](http://taz.newffr.com/TAZ/Cryptologie/hash-lib-algo/des/acisp2000-lyta.pdf).__  
  __TODO__
  
- __Emilia Käsper, Peter Schwabe, [Faster and Timing-Attack Resistant AES-GCM](https://lirias.kuleuven.be/bitstream/123456789/244793/2/article-1261.pdf).__  
  __TODO__
  
- __Vincent Grosso et al., [LS-Designs: Bitslice Encryption for Efficient Masked Software Implementations](http://link.springer.com/chapter/10.1007/978-3-662-46706-0_2).__  
  __TODO__

#### S-BOX optimization
      
- __Matthew Kwan, [Reducing the Gate Count of Bitslice DES](http://fgrieu.free.fr/Mattew%20Kwan%20-%20Reducing%20the%20Gate%20Count%20of%20Bitslice%20DES.pdf), 2000.__  
  Kwan's algorithm to reduce the gate count of bitslice DES. It's not applicable as is in our compiler since this techniques takes several days/weeks to find the circuits. However, he also presents his old approach (which is probably roughly the same as Biham) to compute the sboxes efficiently.  
  His best approach uses Karnaugh maps to represent the sboxes, and then a recursive algorithm searches for the best circuits to represent the sboxes.  
    
- __D. Canright, [A Very Compact S-box for AES](https://www.iacr.org/archive/ches2005/032.pdf), 2005.__  
  Through some Galois Field arithmetic, Canright managed to come up with a quite compact (20% improvement over previous best known) implementation of AES S-box (FYI, about 400 citations of this article...).  
  *Once again, I don't really understand how it works. I'd need to spend a lot of time on it to figure it out.*  
  
- __Joan Boyar, René Peralta, [A new combinational logic minimization technique with applications to cryptology](https://eprint.iacr.org/2009/191.pdf), 2010.__
  This paper presents a technique to minimize the size of a circuit implementation of a sbox.  
  *(I haven't read it yet)*
  
- __N. T. Courtois et al., [Solving Circuit Optimisation Problems in Cryptography and Cryptanalysis](https://eprint.iacr.org/2011/475), 2011.__  
  This paper is based on *A new combinational logic minimization technique with applications to cryptology* of J. Boyar and R. Peralta. They use the same technique, but go further to optimize even more the sboxes, and prove them optimal.  
  This works well on small sboxes (4x4 typically), but not that well on larger ones.
  
- __Markus Ullrich et al., [Finding Optimal Bitsliced Implementations of 4 x 4-bit S-boxes](http://skew2011.mat.dtu.dk/proceedings/Finding%20Optimal%20Bitsliced%20Implementations%20of%204%20to%204-bit%20S-boxes.pdf).__
  __TODO__
  
## SIMD / SWAR

The bitslicing used in the following papers about SWAR is not exactly the same the one we use in usuba, and in cryptography more generally. However, it's still interesting to know about thosen so here are a few references.
  
- __Randall Fisher, [General Purpose SIMD Within A Register on Consumer Microprocessors](http://aggregate.org/SWAR/Dis/dissertation.pdf), 2003 (Phd Thesis).__  
  It's not exactly the same kind of bitslicing we are interested into. In particular, there is no orthogonalization of the data. The idea is to use the same register for multiple data that fit into it.
  In this thesis, Fisher presents a language he designed to easily write SWAR code, and the generated C code.
  
- __Randall Fisher, Henry Dietz, [Compiling For SIMD Within A Register](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.27.9067&rep=rep1&type=pdf), 2000.__  
  Describes various software (code) "tricks" to do efficient SWAR. (probably not usable for our compiler though).
 

## Assembly / C

- __GCC instrinsics: [Official documentation](https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/X86-Built-in-Functions.html)__  
  Explains how to use instructions related to MMX, AVX, SSE, etc.  
  Should be useful when generating C.
  
- __AVX instruction: [Wikipedia](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions)__  
  Should follow the links from here when we start getting really interested in generating C code. 


## Random stuffs about bitslicing

Nothing really new nor surprising here... Just think of it as a small list of arguments you might need in a conversation about bitslicing!

- resistant to timing attacks.
- doesn't suffer from branch misprediction.
- may need to use a lot of memory (hopefully the caches are enough, but sometimes it might need some RAM).


## Miscellaneous

- __Joan Daemen et al., [Bitslice Ciphers and Power Analysis Attacks](http://gva.noekeon.org/papers/2000-FSE-DPV.pdf).__
  __TODO__
  
- __Mitsuru Matsui, Junko Nakajima, [On the Power of Bitslice Implementation on Intel Core2 Processor](http://download.springer.com/static/pdf/326/chp%253A10.1007%252F978-3-540-74735-2_9.pdf?originUrl=http%3A%2F%2Flink.springer.com%2Fchapter%2F10.1007%2F978-3-540-74735-2_9&token2=exp=1489076654~acl=%2Fstatic%2Fpdf%2F326%2Fchp%25253A10.1007%25252F978-3-540-74735-2_9.pdf%3ForiginUrl%3Dhttp%253A%252F%252Flink.springer.com%252Fchapter%252F10.1007%252F978-3-540-74735-2_9*~hmac=ab39f56ffc1f9d1fbfe73fcf59f27d8a8d2633b562a2a083c366a9d69ef1060e).__  
  I'm not sure whether this article is relevant. I'll know more soon.
  __TODO__

- Algorithms to look at: s LBlock [45], LED [26], PRESENT [10], PRINCE [12], PRINTcipher [32], SEA [41], TEA [44], SIMON and SPECK [5], ITUbee [28], PRIDE [3], and RECTANGLE [47]. NOEKEON[16]


The twho following links are about how to implement hardware instructions in software. This might be helpful in the future, when we'll want to add more functionnalities to usuba.
- Implement addition in software: [Wikipedia](https://en.wikipedia.org/wiki/Adder_%28electronics%29).
- Implement shift in software: [Wikipedia](https://en.wikipedia.org/wiki/Barrel_shifter). 
