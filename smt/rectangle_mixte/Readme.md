Those files were manually generated to check that `rectangle.ua` and `rectangle_bitslice.ua` both produce equivalent circuits.  

Basically, to generate those files, you'll want to:  
 - `./usubac -smt -B -o t.c samples/usuba/rectangle_bitslice.ua`
 - `./usubac -smt -B -o t.c samples/usuba/rectangle.ua`
 - Then, `start.ua` is the begining of `smt/rectangle_bitslice/1-pre-scheduled.py` and `smt/rectangle/1-pre-scheduled.py`. 
 - and `final.ua` is the end of `smt/rectangle_bitslice/3-optimized.py` and `smt/rectangle/3-optimized.py`.  
 
 (in both cases, you'll need to manually rename half the `orig_` to `dest_`)
