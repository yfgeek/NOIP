{$R+}
program parity;
type
  ip=^node;
  node=record k:longint;value:shortint;next:ip end;
  headtype=record k:longint;next:ip end;

var
  f:text;
  All,Err:boolean;
  i,j:integer;
  n:longint;
  cur,m:word;
  s:string;
  Nbs:array[1..10000] of ^headtype;

  procedure Add(u,v:longint;p:shortint);
  var i,j:integer;
      y,z,x:^ip;
  begin
    if err then exit;
    if u=v then exit;
    i:=1;
    while (Nbs[i]<>nil) and (Nbs[i]^.k<>u) do inc(i);
    if Nbs[i]=nil then
      begin
        new(nbs[i]);
        nbs[i]^.k:=u;
        nbs[i]^.next:=nil;
        x:=@(nbs[i]^.next);
      end else x:=@(nbs[i]^.next);
    while (x^<>nil) and (x^^.k<>v) do x:=@(x^^.next);
    if x^<>nil then
      begin
        if x^^.value<>p then Err:=true;
      end else
      begin
        new(x^);
        x^^.next:=nil;
        x^^.k:=v;
        x^^.value:=p;
        j:=1;
        while (Nbs[j]<>nil) and (Nbs[j]^.k<>v) do inc(j);
        if Nbs[j]=nil then
          begin
            new(Nbs[j]);
            Nbs[j]^.k:=v;
            Nbs[j]^.next:=nil;
          end;
        z:=@(Nbs[j]^.next);
        while(z^<>nil) and (z^^.k<>v) do
          z:=@(z^^.next);
        if z^=nil then
          begin
            new(z^);
            z^^.k:=u;
            z^^.value:=p;
            z^^.next:=nil;
          end else
          begin
            if z^^.value<>p then
              begin
                err:=true;
                exit;
              end;
          end;

        j:=1;
        while (Nbs[j]<>nil) and (Nbs[j]^.k<>v+1) do inc(j);
        if Nbs[j]<>nil then
          begin
            x:=@(Nbs[j]^.next);
            while (x^<>nil) do
              begin
                Add(u,x^^.k,(p+x^^.value) mod 2);
                x:=@(x^^.next);
              end;
          end;
        j:=1;
        while(Nbs[j]<>nil) and (Nbs[j]^.k<>u-1) do inc(j);
        if Nbs[j]<>nil then
          begin
            x:=@(Nbs[j]^.next);
            while(x^<>nil) do
              begin
                Add(x^^.k,v,(p+x^^.value)mod 2);
                x:=@(x^^.next);
              end;
          end;
      end;
  end;

  procedure Solve;
  var u,v:longint;
  begin
    assign(input,'parity.in');
    reset(input);
    readln(n);
    readln(m);
    all:=true;
    for cur:=1 to m do
      begin
        read(u,v);
        readln(s);
        Err:=false;
        if s=' odd'  then Add(u,v,1) else
        if s=' even' then Add(u,v,0);
        if Err then
          begin
            writeln(f,cur-1);
            all:=false;
            break;
          end;
        if paramcount>0 then writeln('Cur = ',cur,' MemAvail=',(memavail/1024):0:2,'k');
      end;
    if all=true then writeln(f,m);
    close(input);
  end;

  procedure Init;
  var i,j:integer;
  begin

  end;

  begin
    assign(f,'parity.out');
    rewrite(f);
    Solve;
    close(f);
  end.
