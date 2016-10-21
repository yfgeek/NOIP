program madition;
var s1,s2,o:string;
    jin,e:integer;
    sin,sou:string;
function jia(x,y:char):integer;
var a,b:integer;
begin
   if x in['0'..'9'] then a:=ord(x)-ord('0')
    else if x in['a'..'z'] then a:=ord(x)-ord('a')+10;
   if y in['0'..'9'] then b:=ord(y)-ord('0')
    else if y in['a'..'z'] then b:=ord(y)-ord('a')+10;
    jia:=a+b;
end;
function tochr(r:integer):char;
var p:char;
begin
    if r<=9 then p:=chr(r+ord('0'))
     else p:=chr(r+ord('a')-10);
     tochr:=p;
end;
function plus(x,y:string):string;
var i,j,k,add,w:integer;
   c:string;
begin
    add:=0;
    if length(x)<length(y) then begin
     for i:=1 to length(y)-length(x) do x:='0'+x;
     w:=length(y);
    end else begin
     for i:=1 to length(x)-length(y) do y:='0'+y;
     w:=length(x);
    end;
    c:='';
     for i:=1 to w do c:=' '+c;
     add:=0;
    for i:=w downto 1 do begin
    k:=jia(x[i],y[i]);
     c[i]:=tochr((k+add)mod jin);
     add:=(k+add)div jin;
    end;
    if add<>0 then begin
      c:=tochr(add)+c;
    end;
    plus:=c;
end;
begin
    assign(input,'madition.in');
	assign(output,'madition.ou');
    reset(input);
    rewrite(output);
    readln(jin);
     readln(s1);
     readln(s2);
     o:=plus(s1,s2);
     writeln(o);
    close(input);
    close(output);
end.
