node s5(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
	t01 = b   ^ d  ;
	t02 = b   | d  ;
	t03 = a   & t01;
	t04 = c   ^ t02;
	t05 = t03 ^ t04;
	w   =     ~ t05;
	t07 = a   ^ t01;
	t08 = d   | w  ;
	t09 = b   | t05;
	t10 = d   ^ t08;
	t11 = b   | t07;
	t12 = t03 | w  ;
	t13 = t07 | t10;
	t14 = t01 ^ t11;
	y   = t09 ^ t13;
	x   = t07 ^ t08;
	z   = t12 ^ t14
tel