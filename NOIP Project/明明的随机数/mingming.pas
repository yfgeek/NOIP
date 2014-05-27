program mingming;
var
i,j:integer;
f1,f2:text;
n:integer;
a,b:array[1..255] of longint;
agn:array[1..255] of boolean;
procedure init;
begin
 assign(f1,'random.in');
 reset(f1);
 readln(f1,n);
 fillchar(agn,sizeof(agn),false); 
 for i:=1 to n do begin
 read(f1,a[i]);
 agn[i]:=agn+1;
 end;
 close(f1);
end;
 procedure sort(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=b[(l+r) div 2];
         repeat
           while b[i]<x do
            inc(i);
           while x<b[j] do
            dec(j);
           if not(i>j) then
             begin
                y:=b[i];
                b[i]:=b[j];
                b[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;
procedure work;
begin
j:=1;
 for i:=1 to n do begin
	if  agn[i] then begin
	b[j]:=a[i];
	j:=j+1;
    end;
end;
sort(1,j);
end;
procedure printf;
begin
 assign(f2,'rodam.out');
 rewrite(f2);
 writeln(f2,j);
 for i:=1 to j do write(f2,b[i]);
 close(f2);
end;
begin
 init;
 work;
 printf;
end.
	 