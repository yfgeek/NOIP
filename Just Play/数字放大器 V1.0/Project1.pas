program KUZIconvert;
var
k:integer;
procedure sj(m:integer) ;
const
sise=5;
var
a: array[0..9] of char =('-',' ','-','-',' ','-','-','-','-','-');
b1:array[0..9] of char =('|',' ',' ',' ','|','|','|',' ','|','|');
b2:array[0..9] of char =('|','|','|','|','|',' ',' ','|','|','|');
c: array[0..9] of char =(' ',' ','-','-','-','-','-',' ','-','-');
d1:array[0..9] of char =('|',' ','|',' ',' ',' ','|',' ','|',' ');
d2:array[0..9] of char =('|','|',' ','|','|','|','|','|','|','|');
e: array[0..9] of char =('-',' ','-','-',' ','-','-',' ','-','-');
ans:array[1..255] of integer;
j,g,f,i,k:longint;
l:integer;
n:string[255];
begin
l:=1;
str(m,n);
k:=length(n);
for i:=k downto 1 do    {拆数}
ans[i]:=ord(n[i])-48;
writeln;
g:=1;
while (ans[g]=0) and (g<k) do inc(g);
for i:=g to k do
begin
   write(' ');
    for j:=1 to sise do write(a[ans[i]]);
   write(' ');
end;
writeln;
for f:=1 to sise do
begin
   for i:=g to k do
    begin
     write(' ',b1[ans[i]]);
     for j:=1 to sise do write(' ');
     write(b2[ans[i]]);
    end;
   writeln;
end;
for i:=g to k do
begin
   write(' ');
   for j:=1 to sise do write(c[ans[i]]);
   write(' ');
end;
writeln;
for f:=1 to sise do
begin
   for i:=g to k do
    begin
     write(' ',d1[ans[i]]);
     for j:=1 to sise do write(' ');
     write(d2[ans[i]]);
    end;
   writeln;
end;
for i:=g to k do
begin
   write(' ');
    for j:=1 to sise do write(e[ans[i]]);
   write(' ');
end;
end;
begin
writeln('请输入一个数吧：');
read(k);
sj(k);
readln;
readln;
readln;
end.
