program wird;
type
 h=record
  max:integer;
  min:integer;
end;

var
 f1,f2:text;
 i,n:integer;
 word:string;
 c:char;
 m:h;
 abc:array['a'..'z'] of integer;
function prime(x:integer):boolean;
var i:integer;
begin
if x=1 or 0 then exit(false);
    for i:=2 to trunc(sqrt(x)) do
      if x mod i=0
        then
          begin
            prime:=false;
            exit;
          end;
    prime:=true;
end;
procedure work;
begin
 for i:=1 to n do
  abc[word[i]]:=abc[word[i]]+1;
 for c:='a' to 'z' do if abc[c]>m.max then m.max:=abc[c];
 m.min:=m.max;
 for c:='a' to 'z' do if abc[c]<>0 then if abc[c]<m.min then m.min:=abc[c];
end;

begin
assign(f1,'word.in');
reset(f1);
read(f1,word);
n:=length(word);
close(f1);
work;
assign(f2,'word.out');
rewrite(f2);

//for c:='a' to 'z' do begin
// writeln(f2,c,' ->',abc[c]);
//end;
//writeln(f2);


if prime(m.max-m.min) then  begin
 writeln(f2,'Lucky Word');
 write(f2,m.max-m.min);
end
else begin
 writeln(f2,'No Answer');
 write(f2,0);
end;
close(f2);
end.

