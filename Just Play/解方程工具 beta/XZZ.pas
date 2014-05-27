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
 writeln('请输入方程的最高次幂 即X^n:');
   read(n);
   for i:=1 to n-1 do  begin
   writeln('请输入',i,'次幂的a项');
   read(k[i]);
  end;
 writeln('请输入b项 即X');
 read(q);
 writeln('请输入c项 即常数项');
 read(o);
  writeln('你输入的方程是');
 for i:=n-1 downto 1 do begin

  write('X^',i+1,'+');
 end;
 write(q,'*X+',o,'=0');
 writeln;
 writeln('请输入方程的上限，下限：');
 read(a,b);
 m:=(a+b) / 2;
 writeln('请输入精度数:');
 read(d);
 repeat
  if fxx(a)*fxx(m)<0 then b:=m
  else a:=m;
 until (m<=d) or (m=0);
writeln('方程在上限下限之内的近似解为： ',m);
assign(output,'SOLUTION.txt');
rewrite(output) ;
 writeln('你输入的方程是');
 for i:=n-1 downto 1 do begin

  write('X^',i+1,'+');
 end;
 write(q,'*X+',o,'=0');
 writeln;
  writeln('测数方程的函数值',fxx(10)) ;
  writeln('方程在上限下限之内的近似解为： ',m);
close(output);

end.

