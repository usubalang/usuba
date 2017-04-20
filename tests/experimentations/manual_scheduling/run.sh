make
./make_input
perl -MTime::HiRes=time -E 'for$f(kwan,usuba,old_usuba){$t=time;system "./$f" for 1 .. 5;printf"$f: %.2fs\n",(time)-$t,"s"}'
