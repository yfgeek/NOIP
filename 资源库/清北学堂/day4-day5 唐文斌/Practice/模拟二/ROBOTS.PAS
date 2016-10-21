program Robots;
const InputFileName='Robots.in';
      OutputFileName='Robots.out';
      maxn=50;maxm=50;maxp=20;
      dx:array[1..4]of shortint=(-1,1,0,0);
      dy:array[1..4]of shortint=(0,0,-1,1);
type pos=record
       X,Y:byte;
        end;
     node=record
       x,y,call:byte;
       last:integer;
       end;
var data:array[1..5000]of ^node;
    Field:array[0..maxn+1,0..maxm+1]of byte;
    Robot:array[1..maxp]of pos;
    N,M,P:byte;
    r,f:word;
    Path:array[1..32767]of byte;
    Buf:array[0..4095]of byte;
procedure InputData;
var I,J:Integer;
begin
      FillChar(Field,SizeOf(Field),1);
      Assign(Input,InputFileName);
      Reset(Input);
      Readln(N,M,P);
      For I:=1 to P do
         Read(Robot[I].X,Robot[I].Y);
      For I:=1 to N do
      Begin
         Readln;
         For J:=1 to M do
            Read(Field[I,J]);
      End;
      Close(Input);
end;
procedure Move(Rule:byte);
var I:byte;
begin
      for I:=1 to P do
         if Field[ Robot[I].X+dx[rule],Robot[I].Y+dy[rule] ]=0 then
         begin
           Robot[I].X:=Robot[I].X+dx[rule];
           Robot[I].Y:=Robot[I].Y+dy[rule];
         end;
end;
procedure Shortest;
var
    closed,open:integer;
    rule:byte;
    hash:array[1..maxn,1..maxm]of byte;
    procedure Memory;
    var i,top:integer;
        tmp:array[1..2500]of byte;
    begin
          i:=open;top:=0;
          while data[i]^.last>0 do
          begin
            top:=top+1;
            tmp[top]:=data[i]^.call;
            i:=data[i]^.last;
          end;
          r:=f;
          for i:=1 to top do
          begin
             f:=f+1;
             Path[f]:=tmp[top+1-i];
          end;
    end;
    function check(rule:byte):boolean;
    var wx,wy:byte;
    begin
          wx:=data[closed]^.x+dx[rule];
          wy:=data[closed]^.y+dy[rule];
          Check:=(Hash[wx,wy]=0) and (Field[wx,wy]=0);
    end;
begin
      if (Robot[P].X=Robot[P-1].X)
      and (Robot[P].Y=Robot[P-1].Y) then Exit;
      closed:=0;open:=1;
      FillChar(Hash,SizeOf(Hash),0);
      Hash[Robot[P].X,Robot[P].Y]:=1;
      with data[1]^ do
      begin
        call:=0;
        x:=Robot[P].X;
        y:=Robot[P].Y;
        last:=0;
      end;
      repeat
        closed:=closed+1;
        for rule:=1 to 4 do
           if check(rule) then
           begin
             open:=open+1;
             with data[open]^ do
             begin
               x:=data[closed]^.x+dx[rule];
               y:=data[closed]^.y+dy[rule];
               Hash[x,y]:=1;
               last:=closed;
               call:=rule;
             end;
             if (data[open]^.x=Robot[P-1].X)
             and (data[open]^.y=Robot[P-1].Y) then
             begin
               Memory;
               Exit;
             end;
           end;
     until closed>=open;
end;
procedure Merge;
var tmp:array[1..maxp]of pos;
    i,j,m:byte;
    same:boolean;
begin
      m:=0;
      for i:=1 to P do
      begin
         j:=1;same:=false;
         while j<=m do
         begin
           if (Robot[i].X=tmp[j].X)
           and (Robot[i].Y=tmp[j].Y) then
           begin
             same:=true;
             break;
           end;
           j:=j+1;
         end;
         if not(same) then
         begin
           m:=m+1;
           tmp[m]:=Robot[i];
         end;
      end;
      P:=m;
      for i:=1 to m do
         Robot[i]:=tmp[i];
end;
procedure Work;
var i:integer;
begin
      for i:=1 to 5000 do
         New(data[i]);
      f:=0;
      Repeat
        Shortest;
        for I:=r+1 to f do
           Move(Path[I]);
        Merge;
      Until P=1;
      Close(Output)
end;
procedure OutputData;
var I:integer;
begin
      Assign(Output,OutputFileName);
      Rewrite(Output);
      SetTextBuf(Output,Buf);
      Writeln(f);
      for I:=1 to f do
         case Path[I] of
           1:write('N');
           2:write('S');
           3:write('W');
           4:write('E');
         end;
      Close(Output)
end;
begin
      InputData;
      Work;
      OutputData;
end.