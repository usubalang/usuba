# Note: this isn't exactly the s-box of Kwan, as his implementation is more optimized.
# in particular, the output are modified in place.
# for instance, he does "out2 = xor(out2,x24)" where I do "out2 = x24"

node sbox_4 (a : uint_6 :: _ )
     returns out : uint_4 :: _
vars
    x : uint_42 :: _   # 42 bool would be semantically more accurate, but it's not a big deal.
let
    x.1 = not(a.1);
	x.2 = not(a.3);
	x.3 = or(a.1,a.3);
	x.4 = and(a.5,x.3);
	x.5 = xor(x.1,x.4);
	x.6 = or(a.2,a.3);
	x.7 = xor(x.5,x.6);
	x.8 = and(a.1,a.5);
	x.9 = xor(x.8,x.3);
	x.10 = and(a.2,x.9);
	x.11 = xor(a.5,x.10);
	x.12 = and(a.4,x.11);
	x.13 = xor(x.7,x.12);
	x.14 = xor(x.2,x.4);
	x.15 = and(a.2,x.14);
	x.16 = xor(x.9,x.15);
	x.17 = and(x.5,x.14);
	x.18 = xor(a.5,x.2);
	x.19 = or(a.2,x.18);
	x.20 = xor(x.17,x.19);
	x.21 = or(a.4,x.20);
	x.22 = xor(x.16,x.21);
	x.23 = and(a.6,x.22);
	x.24 = xor(x.13,x.23);
	out.2 = x.24;
	x.25 = not(x.13);
	x.26 = or(a.6,x.22);
	x.27 = xor(x.25,x.26);
	out.1 = x.27;
	x.28 = and(a.2,x.11);
	x.29 = xor(x.28,x.17);
	x.30 = xor(a.3,x.10);
	x.31 = xor(x.30,x.19);
	x.32 = and(a.4,x.31);
	x.33 = xor(x.29,x.32);
	x.34 = xor(x.25,x.33);
	x.35 = and(a.2,x.34);
	x.36 = xor(x.24,x.35);
	x.37 = or(a.4,x.34);
	x.38 = xor(x.36,x.37);
	x.39 = and(a.6,x.38);
	x.40 = xor(x.33,x.39);
	out.4 = x.40;
	x.41 = xor(x.26,x.38);
	x.42 = xor(x.41,x.40);
	out.3 = x.42
tel