program project1;
var
 f1,f2:text;
 a,b,n:integer;
function  fx(x:real):longint;
begin
 if (x=1 )or( x=2 ) then exit(1)
 else exit((a*fx(x-1)+b*fx(x-2)) mod 7 );
end;

procedure init;
begin
 assign(f1,'input.txt');
 reset(f1);
 read(f1,a,b,n);
 close(f1);
end;
procedure printf;
begin
 assign(f2,'output.txt');
 rewrite(f2);
 write(f2,fx(n));
 close(f2);
end;

begin
 init;
 printf;
end.

