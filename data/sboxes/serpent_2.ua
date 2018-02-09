node s2(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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