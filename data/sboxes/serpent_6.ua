node s6(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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