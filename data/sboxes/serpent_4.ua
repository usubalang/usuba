node s4(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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