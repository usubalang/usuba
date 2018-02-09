node s1(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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