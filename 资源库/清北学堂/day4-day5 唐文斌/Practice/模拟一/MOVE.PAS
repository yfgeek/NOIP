{$R+,Q+,S-,I+}
{$M 65521,0,655360}
program move;
const inputfilename='move.in';
      outputfilename='move.out';
      maxn=5005;
var n:integer;
    ans:longint;
    b:array[1..maxn]of integer;
    F1:array[1..maxn]of integer;
    F3,F4:array[1..maxn]of longint;
procedure read_data;
var i:integer;
begin
      assign(input,inputfilename);
      reset(input);
      readln(n);
      for i:=1 to n do
         readln(b[i]);
      close(input);
end;
procedure process;
var time,i,j,cl,op:integer;
    F2:array[1..maxn]of byte;
    dist:array[1..maxn]of longint;
    prev:array[1..maxn]of integer;
    queue:array[1..maxn+maxn]of integer;
    mark:array[1..maxn]of boolean;
begin
      time:=0;
      for i:=1 to n do
         time:=time+b[i];
      fillchar(F1,sizeof(F1),0);
      fillchar(F2,sizeof(F2),0);
      fillchar(F3,sizeof(F3),0);
      fillchar(F4,sizeof(F4),0);
      ans:=0;
      while time>0 do
      begin
        time:=time-1;
        cl:=0;op:=0;
        fillchar(mark,sizeof(mark),0);
        for i:=1 to n do
           if F1[i]<b[i] then
           begin
             op:=op+1;
             queue[op]:=i;
             mark[i]:=true;
             dist[i]:=0;
             prev[i]:=0;
           end
           else dist[i]:=100000000;
        dist[n+1]:=100000000;
        while cl<op do
        begin
          cl:=cl+1;
          i:=queue[cl];
          j:=i+1;if j=n+1 then j:=1;
          if (F3[j]>0) and (dist[j]>dist[i]-1) then
          begin
            if not mark[j] then
            begin
              mark[j]:=true;
              op:=op+1;
              queue[op]:=j;
            end;
            dist[j]:=dist[i]-1;
            prev[j]:=-i;
          end;
          if dist[j]>dist[i]+1 then
          begin
            if not mark[j] then
            begin
              mark[j]:=true;
              op:=op+1;
              queue[op]:=j;
            end;
            dist[j]:=dist[i]+1;
            prev[j]:=i;
          end;
          j:=i-1;if j=0 then j:=n;
          if (F4[j]>0) and (dist[j]>dist[i]-1) then
          begin
            if not mark[j] then
            begin
              mark[j]:=true;
              op:=op+1;
              queue[op]:=j;
            end;
            dist[j]:=dist[i]-1;
            prev[j]:=-i;
          end;
          if dist[j]>dist[i]+1 then
          begin
            if not mark[j] then
            begin
              mark[j]:=true;
              op:=op+1;
              queue[op]:=j;
            end;
            dist[j]:=dist[i]+1;
            prev[j]:=i;
          end;
          if (F2[i]=0) and (dist[n+1]>dist[i]) then
          begin
            dist[n+1]:=dist[i];
            prev[n+1]:=i;
          end;
        end;
        ans:=ans+dist[n+1];
        i:=n+1;
        repeat
          j:=prev[i];
          if i=n+1 then F2[j]:=F2[j]+1 else
          if j=0 then F1[i]:=F1[i]+1 else
          if j>0 then
          begin
            if ((j>1) and (i=j-1)) or ((j=1) and (i=0)) then
              F3[j]:=F3[j]+1
            else
              F4[j]:=F4[j]+1;
          end
          else
          begin
            j:=abs(j);
            if ((j>1) and (i=j-1)) or ((j=1) and (i=0)) then
              F4[i]:=F4[i]-1
            else
              F3[i]:=F3[i]-1;
          end;
          i:=j;
        until i=0;
      end;
end;
procedure answer;
begin
      assign(output,outputfilename);
      rewrite(output);
      writeln(ans);
      close(output);
end;
begin
      read_data;
      process;
      answer;
end.
