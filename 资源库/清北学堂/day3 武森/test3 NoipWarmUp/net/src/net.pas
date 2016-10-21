program net;
const
  maxn=10000;
var
  aa,a:array[1..maxn,1..2]of integer;
  ans:array[1..maxn]of integer;
  d,c:array[1..maxn]of integer;
  b:array[1..2*maxn]of integer;
  n,m:integer;

procedure shuru;
  var
    i,j:integer;
  begin
    assign(input,'net.in');
    reset(input);
    readln(n);
    fillchar(a,sizeof(a),0);
    fillchar(ans,sizeof(ans),0);
    fillchar(b,sizeof(b),0);
    fillchar(c,sizeof(c),0);
    fillchar(d,sizeof(d),0);
    for i:=2 to n do
      begin
        read(d[i]);
        inc(b[i]);
        inc(b[d[i]]);
      end;
    j:=1;
    for i:=1 to n do
      begin
        a[i,1]:=j;
        a[i,2]:=j+b[i]-1;
        j:=j+b[i];
      end;
    fillchar(b,sizeof(b),0);
    for i:=2 to n do
      begin
        j:=d[i];
        inc(c[i]);
        b[a[i,1]+c[i]-1]:=j;
        inc(c[j]);
        b[a[j,1]+c[j]-1]:=i;
      end;
    fillchar(c,sizeof(c),0);
    m:=0;
    close(input);
  end;

procedure shuchu;
  var
    i,j:integer;
  begin
    j:=n+1;
    for i:=1 to n do
      if c[i]<j then
        j:=c[i];
    for i:=1 to n do
      if c[i]=j then
        begin
          inc(m);
          ans[m]:=i;
        end;
    assign(output,'net.out');
    rewrite(output);
    for i:=1 to m-1 do
      write(ans[i],' ');
    writeln(ans[m]);
    close(output);
  end;

procedure dph(x,dad:integer);
  var
    i,j,k:integer;
  begin
    for i:=a[x,1] to a[x,2] do
      if b[i]<>dad then
        begin
          dph(b[i],x);
          k:=aa[b[i],1]+1;
          if k>aa[x,1] then
            begin
              aa[x,2]:=aa[x,1];
              aa[x,1]:=k;
            end
          else
            if k>aa[x,2] then
              aa[x,2]:=k
        end;
  end;

procedure dpq(x,dad:integer);
  var
    i,j:integer;
  begin
    for i:=a[x,1] to a[x,2] do
      if b[i]<>dad then
        begin
          c[b[i]]:=c[x]+1;
          if aa[b[i],1]=aa[x,1]-1 then
            j:=aa[x,2]
          else
            j:=aa[x,1];
          if j+1>c[b[i]] then
            c[b[i]]:=j+1;
          dpq(b[i],x);
          if aa[b[i],1]>c[b[i]] then
            c[b[i]]:=aa[b[i],1];
        end;
  end;

begin
  shuru;
  dph(1,0);
  dpq(1,0);
  c[1]:=aa[1,1];
  shuchu;
end.