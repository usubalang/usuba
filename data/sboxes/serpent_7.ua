node s7(a:v1,b:v1,c:v1,d:v1) returns (w:v1,x:v1,y:v1,z:v1)
vars
    t01 : v1, t02 : v1, t03 : v1, t04 : v1, t05 : v1, t06 : v1,
    t07 : v1, t08 : v1, t09 : v1, t10 : v1, t11 : v1, t12 : v1,
    t13 : v1, t14 : v1, t15 : v1, t16 : v1, t17 : v1, t18 : v1
let
    t01 = a   & c  ;
	t02 =     ~ d  ;
	t03 = a   & t02;
	t04 = b   | t01;
	t05 = a   & b  ;
	t06 = c   ^ t04;
	z   = t03 ^ t06;
	t08 = c   | z  ;
	t09 = d   | t05;
	t10 = a   ^ t08;
	t11 = t04 & z  ;
	x   = t09 ^ t10;
	t13 = b   ^ x  ;
	t14 = t01 ^ x  ;
	t15 = c   ^ t05;
	t16 = t11 | t13;
	t17 = t02 | t14;
	w   = t15 ^ t17;
	y   = a   ^ t16
tel