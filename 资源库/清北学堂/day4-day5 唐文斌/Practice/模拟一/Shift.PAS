{$R-,Q-,S-,I-}
program Ks1;{Shift}
const ifn='Shift.in';
      ofn='Shift.out';
      maxn=10000;
type TArray=array[1..maxn]of longint;
var n:integer;
    can:boolean;
    a,b,s:^Tarray;
procedure init;
var i:integer;
begin
      new(a);new(b);
      assign(input,ifn);
      reset(input);
      readln(n);
      for i:=1 to n do
         read(a^[i]);
      readln;
      for i:=1 to n do
         read(b^[i]);
      close(input);
end;
procedure Sort(l,r:Integer);
var i,j:integer;
    x,y:longint;
begin
      i:=l;j:=r;x:=s^[(l+r) div 2];
      repeat
        while s^[i]<x do i:=i+1;
        while x< s^[j] do j:=j-1;
        if i<=j then
        begin
          y:=s^[i];s^[i]:=s^[j];s^[j]:= y;
          i:=i+1;j:=j-1;
        end;
      until i>j;
      if l<j then Sort(l,j);
      if i<r then Sort(i,r);
end;
procedure main;
var i:integer;
begin
      for i:=2 to n do
      begin
         a^[i]:=a^[i]+a^[i-1];
         b^[i]:=b^[i]+b^[i-1];
      end;
      s:=a;Sort(1,n);
      s:=b;Sort(1,n);
      can:=false;
      for i:=1 to n do
         if a^[i]<>b^[i] then exit;
      can:=true;
end;
procedure putout;
begin
      assign(output,ofn);
      rewrite(output);
      if can then writeln('YES')
      else writeln('NO');
      close(output);
end;
begin
      init;
      main;
      putout;
end.