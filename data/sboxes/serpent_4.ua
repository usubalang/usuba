node s4(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
    t01 = a   | b  ;
	t02 = b   | c  ;
	t03 = a   ^ t02;
	t04 = b   ^ d  ;
	t05 = d   | t03;
	t06 = d   & t01;
	z   = t03 ^ t06;
	t08 = z   & t04;
	t09 = t04 & t05;
	t10 = c   ^ t06;
	t11 = b   & c  ;
	t12 = t04 ^ t08;
	t13 = t11 | t03;
	t14 = t10 ^ t09;
	t15 = a   & t05;
	t16 = t11 | t12;
	y   = t13 ^ t08;
	x   = t15 ^ t16;
	w   =     ~ t14
tel