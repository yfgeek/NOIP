
program beg;
const
 maxn=1000000;
type
 yf=record
  number:integer;
  weight:longint;
  value:longint;
 end;
var
 f1,f2:text;
 bag:array[1..maxn] of yf;
 i,v,n:longint;
 weight,maxweight:longint;
 
procedure init;
var
 j:integer;
begin
assign(f1,'bag.txt');
reset(f1);
readln(f1,n,maxweight);
for j:=1 to n do
readln(f1,bag[i].number,bag[i].value ,bag[i].weight);
end;

function max(a,b:longint):longint;    
begin
max:=b;
if a>max then max:=a;
end;

function work(i,w:longint):longint;
begin
if maxweight>0 then begin
  work:=max((work(i-1,bag[i].value)+bag[i].value),bag[i].value);
  maxweight:=maxweight-bag[i].weight;
end;
end;

procedure prints;
begin
assign(f2,'output.txt');
rewrite(f2);
writeln(f2,work(n,bag[n].value));
close(f2);
end;
begin
init;
prints;
end.

