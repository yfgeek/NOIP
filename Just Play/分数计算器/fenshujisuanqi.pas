program fenshujisuanqi;
var
a,b:array[1..2] of integer;
c,d,n:integer;                {c�Ƿ�ĸ,d�Ƿ���}

procedure swap(a,b:integer);   {����}
var
 c:integer;
begin
c:=a;
a:=b;
b:=c;
end;
function gcd(a,b:integer):integer;  {�����Լ��}
begin
    if b=0
       then
         gcd:=a
       else
          gcd:=gcd(b,a mod b);
end;
procedure yf;                      {Լ��}
var
 l:integer;
begin
 l:=gcd(c,d);
 c:=c div l;
 d:=d div l;
end;
function lcm(a,b:integer):integer;    {����С������}
var t:integer;
begin
     if a<b then swap(a,b);
     lcm:=a;
     while lcm mod b<>0 do
       inc(lcm,a);
end;
procedure jia;                      {�ӷ�����}
begin
c:=lcm(a[2],b[2]);
d:=(c div a[2])*a[1]+(c div b[2])*b[1];
end;
procedure cheng;                    {�˷�����}
begin
c:=a[2]*b[2];
d:=a[1]*b[1];
end;
procedure jian;                  {��������}
begin
c:=lcm(a[2],b[2]);
d:=(c div a[2])*a[1]-(c div b[2])*b[1];
end;

procedure chu;                  {��������}
begin
c:=a[2]*b[1];
d:=a[1]*b[2];
end;
begin
writeln;
write(' �������һ�����ķ��� ��ĸ��');
read(a[1],a[2]);
write(' ������ڶ������ķ��� ��ĸ��');
read(b[1],b[2]);
repeat
 begin
writeln(' ��ѡ��');
writeln(' 1.���');
writeln(' 2.���');
writeln(' 3.���');
writeln(' 4.���');
writeln(' 5.�˳�');
write('   ��������ţ�');
read(n);
case n of
 1:jia;
 2:jian;
 3:cheng;
 4:chu;
 5:exit;
 end;
yf;
writeln('                  ������Ϊ��',d,'/',c);
end;
until n=5 ;
readln;
readln;
readln;
end.

