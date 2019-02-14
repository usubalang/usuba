node s2(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
	t01 = a   | c  ;
	t02 = a   ^ b  ;
	t03 = d   ^ t01;
	w   = t02 ^ t03;
	t05 = c   ^ w  ;
	t06 = b   ^ t05;
	t07 = b   | t05;
	t08 = t01 & t06;
	t09 = t03 ^ t07;
	t10 = t02 | t09;
	x   = t10 ^ t08;
	t12 = a   | d  ;
	t13 = t09 ^ x  ;
	t14 = b   ^ t13;
	z   =     ~ t09;
	y   = t12 ^ t14
tel