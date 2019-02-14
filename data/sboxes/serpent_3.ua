node s3(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
    t01 = a   ^ c  ;
	t02 = a   | d  ;
	t03 = a   & d  ;
	t04 = t01 & t02;
	t05 = b   | t03;
	t06 = a   & b  ;
	t07 = d   ^ t04;
	t08 = c   | t06;
	t09 = b   ^ t07;
	t10 = d   & t05;
	t11 = t02 ^ t10;
	z   = t08 ^ t09;
	t13 = d   | z  ;
	t14 = a   | t07;
	t15 = b   & t13;
	y   = t08 ^ t11;
	w   = t14 ^ t15;
	x   = t05 ^ t04
tel