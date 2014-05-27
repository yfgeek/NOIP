program project1;
var
f1,f2:text;
money:array[1..255] of longint;
now,answer,j,k,i:longint;
procedure init;
begin
 assign(f1,'save.in');
 reset(f1);
 for i:=1 to 12 do readln(f1,money[i]);
 close(f1);
end;
procedure work;
begin
j:=0;
for i:=1 to 12 do begin
if now>=0 then begin
  now:=now-money[i]+300;
   while now >100 do begin
    now:=now-100;
	j:=j+1;
   end;
end
else
 begin
  k:=i-1;
  exit;
 end;
end;
end;
begin
  now:=0;
  init;
  k:=0;
  work;
  assign(f2,'save.out');
  rewrite(f2);
  if k<>0 then writeln(f2,-k) else begin
	answer:=now+j*120;
	writeln(f2,answer);
  end;
  close(f2);
end.
