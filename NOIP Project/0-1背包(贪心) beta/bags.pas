program bagss;
type
 bag=record
  number:integer;
  weight:integer;
  value:integer;
  ratio:real;
end;
var
f1,f2:text;
bags:array[0..255] of bag;
n,i,maxweight:integer;
nowweight:integer;
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
 i:=l;j:=r;mid:=bags[(l+r) div 2].value;
 repeat
  while bags[i].value<mid do inc(i);
  while bags[j].value>mid do dec(j);
  if i <=j then begin
   swap(bags[i].value,bags[j].value);
   inc(i);
   dec(j);
  end;
 until i>j;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;
procedure init;
begin
assign(f1,'input.txt');
reset(f1);
readln(f1,n);
readln(f1,maxweight);
for i:=1 to n do begin
 readln(f1,bags[i].weight,bags[i].value);
 bags[i].ratio:=(bags[i].weight)/(bags[i].value);
 bags[i].number:=i;
end;
close(f1);

end;

procedure work;
begin
qsort(1,n);
  assign(f2,'output.txt');
  rewrite(f2);
for i:=1 to n do begin
 if maxweight>=nowweight then begin
  writeln(f2,bags[i].weight,' ----');
  writeln(f2,bags[i].number);
  nowweight:=nowweight+bags[i].weight;
 end;
end;
close(f2);
end;
begin
init;
work;
end.

