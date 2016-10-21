program compare;{for robots}
const ifn='robots.in';
      ans='robots.out';
      ofn='result.txt';
      dx:array[1..4]of shortint=(-1,1,0,0);
      dy:array[1..4]of shortint=(0,0,-1,1);
type pos=record
       X,Y:byte;
        end;
var Field:array[0..50+1,0..50+1]of byte;
    Robot:array[1..20]of pos;
    N,M,P:byte;
procedure InputData;
var I,J:Integer;
begin
      FillChar(Field,SizeOf(Field),1);
      Assign(Input,ifn);
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
procedure print(r:byte);
var tmp:array[1..50,1..50]of byte;
    i,j:byte;
begin
      for i:=1 to n do
         for j:=1 to m do
            tmp[i,j]:=field[i,j];
      for i:=1 to p do
         tmp[Robot[i].x,Robot[i].y]:=9;
      write('==========call:');
      case r of
        1:write('N');
        2:write('S');
        3:write('W');
        4:write('E');
      end;
      writeln('==========');
      for i:=1 to n do
      begin
         for j:=1 to m do
            if tmp[i,j]=9 then write('*')
            else if tmp[i,j]=0 then write(' ')
                 else write(tmp[i,j]);
         writeln;
      end;
end;
procedure Move(R:byte);
var I:byte;
begin
      for i:=1 to P do
         if Field[ Robot[I].X+dx[r],Robot[I].Y+dy[r] ]=0 then
         begin
           Robot[I].X:=Robot[I].X+dx[r];
           Robot[I].Y:=Robot[I].Y+dy[r];
         end;
      print(r);
end;
function check:boolean;
var x,y,i:byte;
begin
      x:=Robot[1].x;y:=Robot[1].y;
      for i:=2 to p do
         if (Robot[i].x<>x) or (Robot[i].y<>y) then
         begin
           check:=false;
           exit;
         end;
      check:=true;
end;
procedure Work;
var ch:char;
    call:byte;
    i,n:word;
begin
      Assign(Input,ans);
      Reset(Input);
      assign(output,ofn);
      rewrite(output);
      Readln(n);
      for i:=1 to n do
      begin
         read(ch);
         case ch of
           'N':call:=1;
           'S':call:=2;
           'W':call:=3;
           'E':call:=4;
         end;
         Move(call);
      end;
      close(Input);
      if check then writeln('Right!!! You are really a smart boy!!!')
      else writeln('You nut!!!');
      close(output)
end;
begin
      InputData;
      Work;
end.