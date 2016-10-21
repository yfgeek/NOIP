program shift;

const finp      ='input9.txt';
      fout      ='output9.txt';
      maxn      =10000;

var   n         :longint;
      a,a1,b,b1 :array[1..maxn]of longint;

procedure Yes;
  begin
    assign(output,fout);rewrite(output);
    writeln('YES');
    close(output)
  end;

procedure No;
  begin
    assign(output,fout);rewrite(output);
    writeln('NO');
    close(output);
    halt
  end;

procedure init;
  var i :longint;
  begin
    randomize;
    assign(input,finp);reset(input);
    readln(n);
    for i:=1 to n do read(a[i]);readln;
    for i:=1 to n do read(b[i]);readln;
    close(input);
    a1[1]:=a[1];
    for i:=2 to n do a1[i]:=a1[i-1]+a[i];
    b1[1]:=b[1];
    for i:=2 to n do b1[i]:=b1[i-1]+b[i];
    if b1[n]<>0 then No;
  end;

procedure sort(s,t:longint);
  var i,j,x,y   :longint;
  begin
    i:=s;j:=t;x:=a1[random(t-s+1)+s];
    repeat
      while (i<=j)and(a1[i]<x) do inc(i);
      while (i<=j)and(a1[j]>x) do dec(j);
      if i<=j then begin
        y:=a1[i];a1[i]:=a1[j];a1[j]:=y;
        inc(i);dec(j)
      end
    until i>j;
    if j>s then sort(s,j);
    if i<t then sort(i,t)
  end;

procedure main;
  var ok        :boolean;
      i         :longint;
  begin
    sort(1,n);
    a:=a1;
    a1:=b1;
    sort(1,n);
    b:=a1;
    ok:=true;
    for i:=1 to n do
      if a[i]<>b[i] then begin ok:=false;break end;
    if ok then Yes else No
  end;

begin
  init;
  main
end.
