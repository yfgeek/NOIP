program route;
type
  sz=array[1..4]of byte;
var
  a:array[1..100,0..100]of integer;
  b:array[1..100,1..5]of sz;
  b0:array[1..100]of integer;
  d:array[1..100,1..2]of integer;
  ans:array[1..100]of integer;
  n,m,st,et:integer;
  f:boolean;

procedure zhuan(s:string;var x:sz);
  var
    i,j,k:integer;
  begin
    fillchar(x,sizeof(x),0);
    for i:=1 to 3 do
      begin
        j:=pos('.',s);
        val(copy(s,1,j-1),x[i],k);
        delete(s,1,j);
      end;
    val(s,x[4],k);
  end;

procedure shuru;
  var
    i,j,k:integer;
    g,h:sz;
    s:string;
  begin
    assign(input,'route.in');
    reset(input);
    readln(n);
    fillchar(a,sizeof(a),0);
    fillchar(b,sizeof(b),0);
    fillchar(b0,sizeof(b0),0);
    for i:=1 to n do
      begin
        readln(b0[i]);
        for j:=1 to b0[i] do
          begin
            readln(s);
            k:=pos(' ',s);
            zhuan(copy(s,1,k-1),g);
            zhuan(copy(s,k+1,length(s)-k),h);
            for k:=1 to 4 do
              b[i,j,k]:=g[k] and h[k];
          end;
      end;
    readln(st,et);
    close(input);
  end;

procedure shuchu;
  var
    i,j:integer;
  begin
    assign(output,'route.out');
    rewrite(output);
    if f then
      begin
        writeln('Yes');
        for i:=m downto 2 do
          write(ans[i],' ');
        writeln(ans[1]);
      end
    else
      writeln('No');
    close(output);
  end;

function ok(x,y:integer):boolean;
  var
   i,j,k:integer;
   f:boolean;
  begin
    ok:=true;
    for i:=1 to b0[x] do
      for j:=1 to b0[y] do
        begin
          f:=true;
          for k:=1 to 4 do
            if b[x,i,k]<>b[y,j,k] then
              begin
                f:=false;
                break;
              end;
          if f then
            exit;
        end;
    ok:=false;
  end;

procedure init;
  var
    i,j:integer;
  begin
    for i:=1 to n-1 do
      for j:=i+1 to n do
        if ok(i,j) then
          begin
            inc(a[i,0]);
            a[i,a[i,0]]:=j;
            inc(a[j,0]);
            a[j,a[j,0]]:=i;
          end;
  end;

procedure out(x:integer);
  begin
    inc(m);
    ans[m]:=d[x,1];
    if d[x,2]<>0 then
      out(d[x,2]);
  end;

procedure search;
  var
    t,w,i,j:integer;
    bb:array[1..90]of boolean;
  begin
    fillchar(d,sizeof(d),0);
    fillchar(bb,sizeof(bb),true);
    t:=0;
    w:=1;
    d[1,1]:=st;
    d[1,2]:=0;
    bb[st]:=false;
    while t<w do
      begin
        inc(t);
        if d[t,1]=et then
          begin
            f:=true;
            m:=0;
            out(t);
            exit;
          end;
        j:=d[t,1];
        for i:=1 to a[j,0] do
          if bb[a[j,i]] then
            begin
              inc(w);
              d[w,1]:=a[j,i];
              d[w,2]:=t;
              bb[a[j,i]]:=false;
            end;
      end;
    f:=false;
  end;

begin
  shuru;
  init;
  search;
  shuchu;
end.
