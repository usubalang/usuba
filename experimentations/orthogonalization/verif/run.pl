#!/usr/bin/perl

use File::Copy;
use File::Compare;


system "make";

system "./des-orig";
move "output.txt", "orig.txt";

system "./des-new";
move "output.txt", "new.txt";

if (compare("orig.txt","new.txt") != 0) {
    print "The two files are different; something is wrong.\n";
    exit(1);
} else {
    print "All went well.\n";
}

unlink "orig.txt";
unlink "new.txt";

system "make clean";
