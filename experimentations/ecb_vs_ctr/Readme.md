Why Electronic Codebook (ECB) is unsecured
---

This is an experiment to show why ECB is considered unsecured. It's
nothing new, and you can find a more convincing example on
[Wikipedia](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Electronic_Codebook_(ECB)).

However, I wanted to have my own version of this experiment, which
anyone can reproduce. Full discolsure: I'm cheating sligly: all images
formats I could find start with some headers specifying the dimensions
of the image (among other things). When encrypting such data, those
headers go away. What I did was encrypt an image, and then replace the
headers with the original headers. This is cheating, but in practice,
if one knows the file format, the image size should be somewhat enough
to try and guess the dimensions and reconstruct the headers.


I started from [usuba.pgm](usuba.pgm). I then encrypted it once with
ECB and once with CTR, and fixed the headers in both cases. This
produced the files [usuba-encrypted-ecb.pgm](usuba-encrypted-ecb.pgm)
and [usuba-encrypted-ctr.pgm](usuba-encrypted-ctr.pgm).

As you can see, we can clearly see "usuba" written in the image
encrypted with ECB, while the one encrypted with CTR looks like random
noise. Note that I purposely used a somewhat large text in order to
have such a clear result (if you try to encrypt a text file for
instance, it's unlikely that you'll get an interesting result).


## How to reproduce

Run `make` to compile the project. This will produce an executable
name `encrypt`. Then, run `./encrypt mode file_in file_out` to encrypt
`file_in` with mode `mode` (`mode` must be `ecb` or `ctr`). If you are
encrypting a pgm image, you might want to run `fix_headers.pl` in
order to reconstruct the old headers. Overall, to generate
`usuba-encrypted-ctr.pgm` and `usuba-encrypted-ecb.pgm`, run:

    make
    ./encrypt ctr usuba.pgm tmp.pgm
    ./fix_headers.pl < tmp.pgm > usuba-encrypted-ctr.pgm
    ./encrypt ecb usuba.pgm tmp.pgm
    ./fix_headers.pl < tmp.pgm > usuba-encrypted-ecb.pgm

