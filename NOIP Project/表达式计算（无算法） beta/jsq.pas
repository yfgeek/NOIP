program jsq;
USES MATH;
var
 f1,f2:text;
 numm,readin:array[0..200] of string;
 i:integer;
 q,w,p,x,o:integer;
 numr:array[0..200] of integer;
 opp:array[0..200] of integer;
procedure readd;       {��������}
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

function shuzi(x:char):boolean; {�ж��Ƿ�Ϊ����}
begin
shuzi:=false;
 if (ord(x)>=49)and(ord(x)<=57) then
   shuzi:=true;
 end;
procedure fenxi(n:string);       {��������}
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
for q:=1 to x do begin                    {���}
writeln('��',q,'������Ϊ->      ',numr[q]);
 case opp[q] of
    1   :writeln('�������Ϊ->         ','+');
    2   :writeln('�������Ϊ->         ','-');
    3   :writeln('�������Ϊ->         ','*');
    4   :writeln('�������Ϊ->         ','/');
 end;
writeln;
writeln;
end;
writeln;


end;
begin
readd;
i:=0;
writeln('�������ʽΪ �� ',readin[0]);
shanchukongge(readin[0]);
writeln('ɾ���ո���Ϊ��',readin[0]);
fenxi(readin[0]);
writeln;
readln;;
end.

