Usubot are you there?

- Add dir/m inference to type-checker
- Make sure that functions that can't have the same input/output don't
- Rewrite Unfold_unnest (in particular, temporaries in loops should have better types)
- Rewrite Bitslice_shift
- Rewrite Expand_array
- Rewrite Utils:
   - split into multiple modules ?
   - clean code
- Fix share_var
- Fix Pre-schedule
- Rewrite predicate to check is_usuba0
- Make type-checker check if var is written twice
- Add Present to checks

- Major work:
  * automatically generate non-trivial vectorized code (Gimli, Chacha)
  * lower stack usage
  * efficient generation of Sboxes

Expand_parameters / Monomorphize interaction issues


node f' (a:um[4],a2:um'[3]) returns (b:um[4]) let b = a in
node f' (a:u1[4],a2:u8[3]) returns (b:um[4],b2:um'[4]) let (b,b2) = (a,a2) in



node f (a:um[4]) returns (b:um[4]) let b = a in

- node f (a:u1[4]) returns (b:u1[4]) let b = a in
- node f (a:u8[4]) returns (b:u8[4]) let b = a in

node g (x:u4) returns (y:u4) let y = f(x[0],x[1],x[2],x[3]) tel
node h (x:u8[4]) returns (y:u8[4]) let y = f(x) tel


node f' (a:um[4],a2:um'[3]) returns (b:um[4]) let b = a in
node k (x1:u4, x2:u8[3]) returns (y1:u4,y2:u8[3]) let (y1,y2) = f'(x1[0,1],x1[2,3],x2) tel

a:um[4],a2:um'[3]
x1[0,1]:u4[2],x1[2,3]:u4[2],x2:u8[3]


----

node f (a:um,a2:um') returns (b:u1[4]) let b = (a,a2) tel

node g (x:u1[4]) returns (y:u1[4]) let y = f(x[0],x[1],x[2],x[3]) tel


a_0,a_1,a2_0,a2_1   m=2,m'=2
a_0,a_1,a_2,a2      m=3,m'=1
a,a2_0,a2_1,a2_2    m=1,m'=3
x[0],x[1],x[2],x[3]


a, x, a'    --> 1+2m
x[0],x[1],x[2],x[3],x[4] --> 5
1+2m = 5  => m=2

a, a'    --> m+m'
x[0],x[1],x[2],x[3],x[4] --> 5

a:m, a':m'   -> m+m'
x:2,x2:1,x3:1


----

f(a:b1[4],b:b1[4]) ...


x:b1[3]
y:b1[3]
z:b1[2]
... = f(x,y,z)


----
f(a:b1[4],b:b1[4]) ...

g(...) returns (x:b1[3],y:b1[3],z:b1[2])

f( g(..) )

----
node f (a:um,a2:um') returns (b:u1[4]) let b = (a,a2) tel
node g (x:u1[4]) returns (y:u1[4]) let y = f(x[0],x[1],x[2],x[3]) tel

m=2,m'=2
void f(bool a[2],bool a2[2], bool b[4]) {
  b[0] = a[0];
  b[1] = a[1];
  b[2] = a2[0];
  b[3] = a2[1];
}
void h(int x[4],int y[4]) {
  int x1[2];
  int x2[2];
  x1[0] = x[0];
  x1[1] = x[1];
  x2[0] = x[2];
  x2[1] = x[3];
  f(x1,x2,y);
}

m=3,m'=1
void f(bool a[3],bool a2[1], bool b[4]) {
  b[0] = a[0];
  b[1] = a[1];
  b[2] = a[2];
  b[3] = a2[0];
}
void h(int x[4],int y[4]) {
  int x1[3];
  int x2[1];
  x1[0] = x[0];
  x1[1] = x[1];
  x1[2] = x[2];
  x2[0] = x[3];
  f(x1,x2,y);
}


----

node f(x:um[4],y:um[4],x':um'[4],y':um'[4]) returns (z:um[4],z:um'[4]) let
  forall i in [0,3] {
    z[i] = x[i] ^ y[i];
    z'[i] = x'[i] ^ y'[i];
  }
tel


f(a:u1[4],b:u1[4],a':u8[4],b':u8[4])

f(a:u1[4],b:u1[4],a':u8[2],a'':u8[2],b':u8[2],b'':u8[2])


f(x:u2[4],y:u2[4],


x:um => x[0], x[1]



-----

node f(a:v8)

f(x:u4,y:u4)
