program litteY;
const
 histroy='histroy.txt';
 data='data.txt';
var
 f1,f2,f3:text;
 t,oua,oub:string;
procedure learn(a,b:string);
begin
assign(f2,data);
append(f2);
writeln(f2,a,b);
close(f2);
end;
procedure search(s:string);
var
 a,b:string;
begin
assign(f1,data);
reset(f1);
while not eof(f1) do begin
readln(f1,a,b);
if s=a then begin
    writeln(b);
    close(f1);
    exit;
end
else begin
close(f1);
    writeln('�ҵļ������û�����ʵ����⣬������ش����ݣ�');
    oua:=a;
    readln(oub);
    learn(oua,oub);
    exit;
    end;
end;
end;
//procedure history(x:integer);
//begin
//assign(f2,history);
//reset(f2);
//close(f2);
//end;
begin
//histroy(3);
writeln('�ðɣ����Ǽ�������ɣ�');
repeat
readln(t);
search(t);
until t= 'exit';
end.

