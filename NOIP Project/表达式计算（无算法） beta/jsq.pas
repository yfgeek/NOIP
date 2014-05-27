program jsq;
USES MATH;
var
 f1,f2:text;
 numm,readin:array[0..200] of string;
 i:integer;
 q,w,p,x,o:integer;
 numr:array[0..200] of integer;
 opp:array[0..200] of integer;
procedure readd;       {读入数据}
begin
 i:=0;
 assign(f1,'input.txt');
 reset(f1);
 while not eof(f1) do  begin
 readln(f1,readin[i]);
 i:=i+1;
 end;
end;

procedure shanchukongge(var n:string);
var
 t:integer;
begin
 t:=length(n);
 for i:=1 to t do begin
  if (n[i]=' ')or(n[i]='	')or(n[i]='     ') then begin
   delete(n,i,1);
  t:=t-1;
  end;
end;
end;

function shuzi(x:char):boolean; {判断是否为数字}
begin
shuzi:=false;
 if (ord(x)>=49)and(ord(x)<=57) then
   shuzi:=true;
 end;
procedure fenxi(n:string);       {分析过程}
begin
x:=1;
i:=1;
w:=length(n);
if n[w]='=' then begin
for q:=1 to w-1 do
begin
if shuzi(n[q]) then
 begin
  numm[x]:=numm[x]+n[q];
 val(numm[x],numr[x],o) ;
 end
 else
 begin
 case n[q] of
   '+'   :opp[i]:=1;
   '-'   :opp[i]:=2;
   '*'   :opp[i]:=3;
   '/'   :opp[i]:=4;
 end;
 i:=i+1 ;
 x:=x+1;
 end;
end;
end;
for q:=1 to x do begin                    {检查}
writeln('第',q,'个数字为->      ',numr[q]);
 case opp[q] of
    1   :writeln('其运算符为->         ','+');
    2   :writeln('其运算符为->         ','-');
    3   :writeln('其运算符为->         ','*');
    4   :writeln('其运算符为->         ','/');
 end;
writeln;
writeln;
end;
writeln;


end;
begin
readd;
i:=0;
writeln('读入的算式为 ： ',readin[0]);
shanchukongge(readin[0]);
writeln('删除空格后的为：',readin[0]);
fenxi(readin[0]);
writeln;
readln;;
end.

