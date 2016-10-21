program number;
var  g:array[0..6,0..6] of integer;
     f:array[1..49] of longint;
     a,b,n :longint;
procedure doit;
var i:longint;
    x,y:integer;
begin
    fillchar(g,sizeof(g),0);
    g[1,1]:=1;
    f[1]:=1;f[2]:=1;
    for i:=3 to n do begin
        f[i]:=(f[i-1]*a+f[i-2]*b) mod 7;
        if g[f[i-1],f[i]]>0 then break;
        g[f[i-1],f[i]]:=i-1;
    end;
    x:=f[i-1];y:=f[i];
    if i-1-g[x,y]=0 then begin
       writeln(f[n]);
       exit;
    end;
    n:=(n-g[x,y]+1) mod (i-1-g[x,y]);
    if n=0 then n:=i-1-g[x,y];
    n:=n+g[x,y]-1;
    writeln(f[n]);
end;
begin
     assign(input,'number.in');
     assign(output,'number.out');
     reset(input);
     rewrite(output);
     readln(a,b,n);
     while n>0 do
     begin
         if n<3 then writeln(1) else doit;
         readln(a,b,n);
     end;
     close(input);
     close(output);
end.
