program Number1;
const InputFileName='Number1.in';
      OutputFileName='Number1.out';
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
var r:integer;
begin
      for r:=data[i-1] to S do
      begin
         s:=s-R;data[i]:=r;
         if S=0 then inc(total)
         else if s>=r then DFS_TRY(i+1);
         s:=s+r;
      end;
end;
Begin
      InputData;
      fillchar(data,sizeof(data),0);
      data[0]:=1;
      DFS_TRY(1);
      OutputData;
end.

