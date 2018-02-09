node s3(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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