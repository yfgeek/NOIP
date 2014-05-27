program project1;
var a:array[1..10] of integer;
    i,temp:integer;

procedure swap(var a,b:integer);
var
tmp:integer;
begin
tmp:=a;
a:=b;
b:=tmp;
end;
procedure qsort(l,r:integer);
var
 i,j,mid:integer;
begin
 i:=l;j:=r;mid:=a[(l+r) div 2];
 repeat
  while a[i]<mid do inc(i);
  while a[j]>mid do dec(j);
  if i <=j then begin
   swap(a[i],a[j]);
   inc(i);
   dec(j);
  end;
 until i>j;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;
begin
 for i:=1 to 10 do readln(a[i]);
 qsort(1,10);
 writeln;
 for i:=1 to 10 do
 write(i,'->',a[i],' ');
 readln;
end.

