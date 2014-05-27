program standrad(input,output);
const
 n=10;
var
    i:integer;
    f1,f2:text;
    a:array[1..n] of integer;
procedure init;       {读入程序}
begin
 assign(f1,'input.txt');
 reset(f1);
 for i:=1 to 10 do
  read(f1,a[i]);
 close(f1);
end;

procedure print;       {输出程序}
var n:integer;
begin
 assign(f2,'output.txt');
 rewrite(f2);
 for i:=1 to 10 do
  write(f2,a[i],' ');
 close(f2);
end;

procedure swap(var a,b:integer);   {两数交换}
var c:integer;
begin
 c:=a;
 a:=b;
 b:=c;
end;
procedure qsort(l,r:integer);        {快速排序}
var
 mid,i,j:integer;
begin
i:=l;j:=r;
mid:=a[(l+r)div 2];
repeat
 while a[i]<mid do inc(i);
 while a[j]>mid do dec(j);
 if i<=j then
  begin
   swap(a[i],a[j]);
   inc(i);
   dec(j);
  end;
 until i>j;
if i<r then qsort(i,r);
if l<j then qsort(l,j);
end;
procedure msort(l,r:integer);   {冒泡排序}
var
 i,j:integer;
begin
 for i:=l to r-1 do
  for j:=r downto i+1 do
   if a[j-1]>a[j] then
    swap(a[j-1],a[j]);
end;

function gcd(a,b:integer):integer;          {最大公约数}
begin
 if b=0 then
  gcd:=a
 else
  gcd:=gcd(b,a mod b);
end;

function lcm(a,b:integer):integer;        {最大公约数}
begin
  if a<b then swap(a,b);
  lcm:=a;
  while lcm mod b<>0 do
   inc(lcm,a);
end;

begin
 init;
 msort(1,10);
 print;
end.

