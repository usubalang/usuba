node s7(a:bool,b:bool,c:bool,d:bool) returns (w:bool,x:bool,y:bool,z:bool)
vars
    t01 : bool, t02 : bool, t03 : bool, t04 : bool, t05 : bool, t06 : bool,
    t07 : bool, t08 : bool, t09 : bool, t10 : bool, t11 : bool, t12 : bool,
    t13 : bool, t14 : bool, t15 : bool, t16 : bool, t17 : bool, t18 : bool
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