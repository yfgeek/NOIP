program tfdian;
var i,j,k,a,b,c,d:integer ;

function n(i,x,y:integer):integer;
 begin
  if i=1 then n:=x+y
  else if i=2 then n:=x-y
  else if i=3 then n:=x*y
  else if i=4 then n:=x div y;
 end;
function l(i:integer):char;
 begin
   if i=1 then l:='+'
  else if i=2 then l:='-'
  else if i=3 then l:='*'
  else if i=4 then l:='/';
 end;
begin
read(a,b,c,d);
 for i:=1 to 4 do
  for j:=1 to 4 do
   for k:=1 to 4 do
    if (n(k,n(j,n(i,a,b),c),d)=24) then begin
     write(a,l(k),b,l(j),c,l(i),d,'=24');
     writeln;
    end;
 readln;
 readln;
end.

