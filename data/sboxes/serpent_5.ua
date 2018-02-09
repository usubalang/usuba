node s5(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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