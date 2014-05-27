program energy;
var 
 f1,f2:text;
 n,i,hb:longint;
 en:array[1..100] of longint;
procedure init;
 begin
  assign(f1,'energy.in');
  reset(f1);
  readln(f1,n);
  for i:=1 to n do read(f1,en[i]);
  close(f1);
end;

procedure sort(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=en[(l+r) div 2];
         repeat
           while en[i]<x do
            inc(i);
           while x<en[j] do
            dec(j);
           if not(i>j) then
             begin
                y:=en[i];
                en[i]:=en[j];
                en[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
         sort(i,r);
end;

procedure work(up,center,down:longint);
begin
  hb:= hb+en[up]*en[center]*en[down];
end;

begin
 init;
 sort(1,n);
 i:=1;
if n>=3 then begin
 if i=1 then  work(2,1,n);
 i:=i+1;
 while i<n-2 do begin
   work(i,i+1,i+2);
   i:=i+1;
 end;
end;

assign(f2,'energy.out');
rewrite(f2);
write(f2,hb);
close(f2);
end.
 
 