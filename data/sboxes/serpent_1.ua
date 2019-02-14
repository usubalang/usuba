node s1(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
	t01 = a   | d  ;
	t02 = c   ^ d  ;
	t03 =     ~ b  ;
	t04 = a   ^ c  ;
	t05 = a   | t03;
	t06 = d   & t04;
	t07 = t01 & t02;
	t08 = b   | t06;
	y   = t02 ^ t05;
	t10 = t07 ^ t08;
	t11 = t01 ^ t10;
	t12 = y   ^ t11;
	t13 = b   & d  ;
	z   =     ~ t10;
	x   = t13 ^ t12;
	t16 = t10 | x  ;
	t17 = t05 & t16;
	w   = c   ^ t17
tel