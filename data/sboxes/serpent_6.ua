node s6(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
    t01 = a   & d  ;
	t02 = b   ^ c  ;
	t03 = a   ^ d  ;
	t04 = t01 ^ t02;
	t05 = b   | c  ;
	x   =     ~ t04;
	t07 = t03 & t05;
	t08 = b   & x  ;
	t09 = a   | c  ;
	t10 = t07 ^ t08;
	t11 = b   | d  ;
	t12 = c   ^ t11;
	t13 = t09 ^ t10;
	y   =     ~ t13;
	t15 = x   & t03;
	z   = t12 ^ t07;
	t17 = a   ^ b  ;
	t18 = y   ^ t15;
	w   = t17 ^ t18
tel