program fenshujisuanqi;
var
a,b:array[1..2] of integer;
c,d,n:integer;                {c是分母,d是分子}

procedure swap(a,b:integer);   {交换}
var
 c:integer;
begin
c:=a;
a:=b;
b:=c;
end;
function gcd(a,b:integer):integer;  {求最大公约数}
begin
    if b=0
       then
         gcd:=a
       else
          gcd:=gcd(b,a mod b);
end;
procedure yf;                      {约分}
var
 l:integer;
begin
 l:=gcd(c,d);
 c:=c div l;
 d:=d div l;
end;
function lcm(a,b:integer):integer;    {求最小公倍数}
var t:integer;
begin
     if a<b then swap(a,b);
     lcm:=a;
     while lcm mod b<>0 do
       inc(lcm,a);
end;
procedure jia;                      {加法运算}
begin
c:=lcm(a[2],b[2]);
d:=(c div a[2])*a[1]+(c div b[2])*b[1];
end;
procedure cheng;                    {乘法运算}
begin
c:=a[2]*b[2];
d:=a[1]*b[1];
end;
procedure jian;                  {减法运算}
begin
c:=lcm(a[2],b[2]);
d:=(c div a[2])*a[1]-(c div b[2])*b[1];
end;

procedure chu;                  {除法运算}
begin
c:=a[2]*b[1];
d:=a[1]*b[2];
end;
begin
writeln;
write(' 请输入第一个数的分子 分母：');
read(a[1],a[2]);
write(' 请输入第二个数的分子 分母：');
read(b[1],b[2]);
repeat
 begin
writeln(' 请选择：');
writeln(' 1.相加');
writeln(' 2.相减');
writeln(' 3.相乘');
writeln(' 4.相除');
writeln(' 5.退出');
write('   请输入序号：');
read(n);
case n of
 1:jia;
 2:jian;
 3:cheng;
 4:chu;
 5:exit;
 end;
yf;
writeln('                  计算结果为：',d,'/',c);
end;
until n=5 ;
readln;
readln;
readln;
end.

