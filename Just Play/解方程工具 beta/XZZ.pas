program EFFJFC;
var
 a,q,o,b,m,d:real;
 i,n,j:integer;
 k:array[0..50] of real;

function fxx(x:real):real ;
 begin
 fxx:=0;
   for j:=1 to i do begin
    k[i]:=k[i]*k[i];
    end;
   for i:=1 to n do begin
   fxx:=fxx+k[i];
   end;
  fxx:=fxx+x*q+o ;
 end;
begin
 writeln('�����뷽�̵���ߴ��� ��X^n:');
   read(n);
   for i:=1 to n-1 do  begin
   writeln('������',i,'���ݵ�a��');
   read(k[i]);
  end;
 writeln('������b�� ��X');
 read(q);
 writeln('������c�� ��������');
 read(o);
  writeln('������ķ�����');
 for i:=n-1 downto 1 do begin

  write('X^',i+1,'+');
 end;
 write(q,'*X+',o,'=0');
 writeln;
 writeln('�����뷽�̵����ޣ����ޣ�');
 read(a,b);
 m:=(a+b) / 2;
 writeln('�����뾫����:');
 read(d);
 repeat
  if fxx(a)*fxx(m)<0 then b:=m
  else a:=m;
 until (m<=d) or (m=0);
writeln('��������������֮�ڵĽ��ƽ�Ϊ�� ',m);
assign(output,'SOLUTION.txt');
rewrite(output) ;
 writeln('������ķ�����');
 for i:=n-1 downto 1 do begin

  write('X^',i+1,'+');
 end;
 write(q,'*X+',o,'=0');
 writeln;
  writeln('�������̵ĺ���ֵ',fxx(10)) ;
  writeln('��������������֮�ڵĽ��ƽ�Ϊ�� ',m);
close(output);

end.

