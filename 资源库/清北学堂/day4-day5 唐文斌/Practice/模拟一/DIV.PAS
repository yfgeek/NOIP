program Ks3;{Div}
const ifn='Div.in';
      ofn='Div.out';
      bits=100000;bit=5;
      maxn=100;
type TNum=record
       op:boolean;
       len:integer;
       d:array[1..30]of longint;
          end;
var a:array[1..maxn]of integer;
    f:array[1..2,1..maxn]of TNum;
    n,k:integer;
procedure init;
var i:integer;
begin
      assign(input,ifn);
      reset(input);
      readln(n,k);
      for i:=1 to n do
         read(a[i]);
      close(input);
end;
function bigger(a,b:Tnum):boolean;
var i:integer;
begin
      if a.op and not b.op then bigger:=true else
      if b.op and not a.op then bigger:=true else
        if a.len>b.len then
          if a.op then bigger:=true else bigger:=false else
        if a.len<b.len then
          if a.op then bigger:=false else bigger:=true else
          begin
            for i:=a.len downto 1 do
            begin
               if ( (a.d[i]>b.d[i]) and a.op )
               or ( (a.d[i]<b.d[i]) and not(a.op) ) then
               begin
                 bigger:=true;
                 exit;
               end;
               if ( (a.d[i]<b.d[i]) and a.op )
               or ( (a.d[i]>b.d[i]) and not(a.op) ) then
               begin
                 bigger:=false;
                 exit;
               end;
            end;
            bigger:=false;
          end;
end;
procedure Mul(x:integer;var a:TNum);
var i:integer;
    t:longint;
begin
      with a do
      begin
        if x<0 then op:=not op;
        x:=abs(x);
        t:=0;
        for i:=1 to len do
        begin
           d[i]:=d[i]*x+t;
           t:=d[i] div bits;
           d[i]:=d[i]-t*bits;
        end;
        if t>0 then
        begin
          len:=len+1;
          d[len]:=t;
        end;
      end;
end;
procedure Add(a,b:TNum;var c:TNum);
var i:integer;
    t:longint;
begin
      fillchar(c,sizeof(c),0);
      if a.op and b.op then c.op:=true else
      if not a.op and not b.op then c.op:=false else
      if a.op then
      begin
        b.op:=true;
        if bigger(b,a) then exit;
      end else
      if b.op then
      begin
        a.op:=true;
        if bigger(a,b) then exit;
      end;
      if a.len>b.len then c.len:=a.len else c.len:=b.len;
      t:=0;
      for i:=1 to c.len do
      begin
         c.d[i]:=a.d[i]+b.d[i]+t;
         t:=c.d[i] div bits;
         c.d[i]:=c.d[i]-t*bits;
      end;
end;
procedure main;
var i,j,m:integer;
    t,h:TNum;
begin
      fillchar(t,sizeof(t),0);
      with t do
      begin
        op:=true;
        len:=1;
        d[1]:=1;
      end;
      fillchar(f[2],sizeof(f[2]),0);
      for i:=1 to n do
      begin
         Mul(a[i],t);
         f[2][i]:=t;
      end;
      for i:=2 to k do
      begin
         f[1]:=f[2];
         fillchar(f[2],sizeof(f[2]),0);
         for j:=i to n do
         begin
            fillchar(t,sizeof(t),0);
            with t do
            begin
              op:=true;
              len:=1;
              d[1]:=1;
            end;
            for m:=j-1 downto i-1 do
            begin
               Mul(a[m+1],t);
               Add(f[1][m],t,h);
               if bigger(h,f[2][j]) then
                 f[2][j]:=h;
            end;
         end;
      end;
end;
procedure putout;
var i:integer;
    st:string;
begin
      assign(output,ofn);
      rewrite(output);
      with f[2][n] do
      begin
        write(d[len]);
        for i:=len-1 downto 1 do
        begin
           str(d[i],st);
           while length(st)<bit do
             st:='0'+st;
           write(st);
        end;
      end;
      close(output);
end;
begin
      init;
      main;
      putout;
end.