node s0(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t17 : bool
let
	t01 = b   ^ c  ;
	t02 = a   | d  ;
	t03 = a   ^ b  ;
	z   = t02 ^ t01;
	t05 = c   | z  ;
	t06 = a   ^ d  ;
	t07 = b   | c  ;
	t08 = d   & t05;
	t09 = t03 & t07;
	y   = t09 ^ t08;
	t11 = t09 & y  ;
	t12 = c   ^ d  ;
	t13 = t07 ^ t11;
	t14 = b   & t06;
	t15 = t06 ^ t13;
	w   =     ~ t15;
	t17 = w   ^ t14;
	x   = t12 ^ t17
tel