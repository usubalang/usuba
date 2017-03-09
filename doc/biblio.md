# A short bibliography about bitslicing papers

## Bitslicing

- __Eli Biham, [A fast New DES Implementation in Software](http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/1997/CS/CS0891.pdf), 1997.__  
  The first paper about using bitslicing to optimize DES. 
  Biham explains how bitslicing works, how to convert sbox to circuits, how to orthogonalize the data, and how it behaves with the different modes of operation of DES.
  
- __Thomas Pornin, [Implantation et optimisation des primitives cryptographiques](http://www.bolet.org/~pornin/2001-phd-pornin.pdf), Chapitre 3, 2001 (Phd Thesis).__  
  A presentation of bitslicing techniques: when it's useful, when it's not, and how to do it (in particular, the orthogonalization of the data, and the convertion of the lookup tables).  
  Pornin developped a compiler named `bcs` for a language that allows to write bitsliced algorithls quite conveniently.
  
- __Matthew Kwan, [Reducing the Gate Count of Bitslice DES](http://fgrieu.free.fr/Mattew%20Kwan%20-%20Reducing%20the%20Gate%20Count%20of%20Bitslice%20DES.pdf), 2000.__  
  Kwan's algorithm to reduce the gate count of bitslice DES. It's not applicable as is in our compiler since this techniques takes several days/weeks to find the circuits. However, he also presents his old approach (which is probably roughly the same as Biham) to compute the sboxes efficiently.  
  His best approach uses Karnaugh maps to represent the sboxes, and then a reccursive algorithm searches for the best circuits to represent the sboxes.  
  
- __Ross Anderson, Eli Biham, Lars Knudsen, [Serpent: A proposal for the Advanced Encryption Standard](http://www.cl.cam.ac.uk/~rja14/Papers/serpent.pdf), 1998.__  
  (I didn't read the *Security* nor the *Performance* part).  
  This paper present __Serpent__ cipher. It is designed to be use in bitslice mode. However, the bitslice of Serpent is very different from the bitslice of DES: whereas bitsliced DES computes 64 DES in parallel, Serpent computes only one block at a time in a bitsliced way. Any implementation of Serpent is bitsliced, due to how the algorithm is designed. (and thus, I don't think usuba can (or rather should) be used to implement Serpent).
  
- __WenTao Zhang et al., [RECTANGLE: a bit-slice lightweight block cipher suitable for multiple platforms](https://eprint.iacr.org/2014/084.pdf), 2015.__

- __Seiichi Matsuda, Shiho Moriai, [Lightweight Cryptography for the Cloud:
Exploit the Power of Bitslice Implementation](http://www.iacr.org/archive/ches2012/74280406/74280406.pdf).__

- __Zhenzhen Bao et al., [Bitsliced Implementations of the PRINCE, LED and RECTANGLE Block
Ciphers on AVR 8-bit Microcontrollers](http://eprint.iacr.org/2015/1118.pdf).__

- __Ryad Benadjila et al., [Implementing Lightweight Block Ciphers on x86 Architectures](https://eprint.iacr.org/2013/445.pdf).__

- __Josep Balasch et al., [DPA, Bitslicing and Masking at 1 GHz](https://eprint.iacr.org/2015/727.pdf).__

- __Ko Stoffelen, [Optimizing S-box Implementations for Several Criteria using SAT Solvers](http://eprint.iacr.org/2016/198.pdf).__

- __Markus Ullrich et al., [Finding Optimal Bitsliced Implementations of 4 x 4-bit S-boxes](http://skew2011.mat.dtu.dk/proceedings/Finding%20Optimal%20Bitsliced%20Implementations%20of%204%20to%204-bit%20S-boxes.pdf).__

- __Lauren May et al., [An Implementation of Bitsliced DES on the Pentium MMX Processor](http://taz.newffr.com/TAZ/Cryptologie/hash-lib-algo/des/acisp2000-lyta.pdf).__

- __Emilia Käsper, Peter Schwabe, [Faster and Timing-Attack Resistant AES-GCM](https://lirias.kuleuven.be/bitstream/123456789/244793/2/article-1261.pdf).__

- __Vincent Grosso et al., [LS-Designs: Bitslice Encryption for Efficient Masked Software Implementations](http://link.springer.com/chapter/10.1007/978-3-662-46706-0_2).__
  
## SIMD / SWAR
  
- __Randall Fisher, [General Purpose SIMD Within A Register on Consumer Microprocessors](http://aggregate.org/SWAR/Dis/dissertation.pdf), 2003 (Phd Thesis).__  
  It's not exactly the same kind of bitslicing we are intersted into. In particular, there is no orthogonalization of the data. The idea is tu use the same register for multiple data that fit into it.
  In this thesis, Fisher presents a language he designed to easily write SWAR code, and the generated C code.
  
- __Randall Fisher, Henry Dietz, [Compiling For SIMD Within A Register](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.27.9067&rep=rep1&type=pdf), 2000.__  
  Describes various software (code) "tricks" to do efficient SWAR. (probably not usable for our compiler though).
 

## Assembly / C

- __GCC instrinsics: [Official documentation](https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/X86-Built-in-Functions.html)__  
  Explains how to use instructions related to MMX, AVX, SSE, etc.  
  Should be useful when generating C.
  
- __AVX instruction: [Wikipedia](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions)__  
  Should follow the links from here when we start getting really interested in generating C code. 


## Random things about bitslicing

- resistant to timing attacks.
- doesn't suffer from branch misprediction.
- may need to use a lot of memory (hopefully the caches are enought, but sometimes it might need some RAM).


## Miscellaneous

- Implement addition in software: [Wikipedia](https://en.wikipedia.org/wiki/Adder_%28electronics%29).

- Implement shift in software: [Wikipedia](https://en.wikipedia.org/wiki/Barrel_shifter). 

- __Joan Daemen et al., [Bitslice Ciphers and Power Analysis Attacks](http://gva.noekeon.org/papers/2000-FSE-DPV.pdf).__

- __Mitsuru Matsui, Junko Nakajima, [On the Power of Bitslice Implementation on Intel Core2 Processor](http://download.springer.com/static/pdf/326/chp%253A10.1007%252F978-3-540-74735-2_9.pdf?originUrl=http%3A%2F%2Flink.springer.com%2Fchapter%2F10.1007%2F978-3-540-74735-2_9&token2=exp=1489076654~acl=%2Fstatic%2Fpdf%2F326%2Fchp%25253A10.1007%25252F978-3-540-74735-2_9.pdf%3ForiginUrl%3Dhttp%253A%252F%252Flink.springer.com%252Fchapter%252F10.1007%252F978-3-540-74735-2_9*~hmac=ab39f56ffc1f9d1fbfe73fcf59f27d8a8d2633b562a2a083c366a9d69ef1060e).__  
  I'm not sure whether this article is relevant. I'll know more soon.
