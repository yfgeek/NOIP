{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
program Number2;
const InputFileName='Number2.in';
      OutputFileName='Number2.out';
      num:array[1..14]of integer=(1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192);
var N,S:integer;
    Total:longint;
    data:array[0..10000]of integer;
procedure InputData;
begin
      Assign(Input,InputFileName);
      Reset(Input);
      Readln(N);
      Close(Input);
      S:=N;
end;
Procedure OutputData;
Begin
      Assign(Output,OutputFileName);
      Rewrite(Output);
      Writeln(Total);
      Close(Output)
end;
procedure DFS_TRY(i:integer);
var r:byte;
begin
      for r:=1 to 14 do
         if (num[r]>=data[i-1]) and (num[r]<=s) then
         begin
           s:=s-num[r];data[i]:=num[r];
           if s=0 then inc(total)
           else if s>=num[r] then DFS_TRY(i+1);
           s:=s+num[r];
         end;
end;
Begin
      InputData;
      fillchar(data,sizeof(data),0);
      data[0]:=1;
      DFS_TRY(1);
      OutputData;
end.

