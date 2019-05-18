node s0(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t17 : v1
let
	t01 = b   ^ c  ;
	t02 = a   | d  ;
	t03 = a   ^ b  ;
	z   = t02 ^ t01;
	t05 = c   | z  ;
	t06 = a   ^ d  ;
	t07 = b   | c  ;
	t08 = d   & t05;
	t09 = t03 & t07;
	y   = t09 ^ t08;
	t11 = t09 & y  ;
	t12 = c   ^ d  ;
	t13 = t07 ^ t11;
	t14 = b   & t06;
	t15 = t06 ^ t13;
	w   =     ~ t15;
	t17 = w   ^ t14;
	x   = t12 ^ t17
tel