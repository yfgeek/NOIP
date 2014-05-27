program spy;
var
 f1,f2:text;
 n,i,q1,q2:integer;
 s1,s2,tf:string;
 s:char;
 flag:boolean;
 sp:array['a'..'z'] of integer;
procedure init;
begin
assign(f1,'spy.in');
reset(f1);
readln(f1,s1,s2,tf);
q1:=length(s1);
q2:=length(s2);
close(f1);
end;
procedure work;
begin
flag:=true;
if q1<>q2 then exit;
for i:=1 to q1 do begin
sp[s1[i]]:=sp[s1[i]]+1;
sp[s2[i]]:=sp[s2[i]]+1;
end;
for s:='a' to 'z' do
 if sp[s]=0 then begin
 flag:=false;
 break;
 end;
 n:=ord(s1[1])-ord(s2[1]);
 if n=0 then begin
 flag:=false;
 exit;
 end;
 for i:=2 to q1 do
  if (ord(s1[i])-ord(s2[i]))<>n then begin
   flag:=false;
   exit;
  end;
end;
procedure printf;
begin
assign(f2,'spy.out');
rewrite(f2);
 if not flag then writeln(f2,'Failed.')
 else
  begin
   writeln(f2,n);
  end;
close(f2);
end;
begin
 init;
 work;
 printf;
end.

