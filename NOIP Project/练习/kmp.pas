program kmp;
var
  prefix: array [1..100] of integer;
  p,t:string;

procedure pre(p:string);
  var
    k,q,m :integer;
  begin
    m:=length(p);
    prefix[1]:=0;
    k:=0;
    for q := 2 to m do
      begin
        while (k>0) and (p[q]<>p[q+1]) do
          k:= prefix[k];
        if (p[q+1]= p[k]) then
          k:=k+1;
        prefix[q]:=k;
      end;
  end;

procedure kmp(t,p:string);
  var
    q,flog,m,n,i:integer;
  begin
    pre(p);
    q:=0;
    flog:=0;
    m:=length(p);
    n:=length(t);
    for i:= 1 to n do
      begin
        while (q>0) and (p[q+1]<>t[i]) do
          q:=prefix[q];
        if (p[q+1]=t[i]) then
          q:=q+1;
        if (q=m) then
          begin
            writeln(i-m+1:4);
            flog:=1 ;
            q:=prefix[q];
          end;
      end;
    if flog=0 then writeln('no');
  end;


begin
  readln(t);
  readln(p);
  kmp(t,p);
  readln;
  readln;
end.
