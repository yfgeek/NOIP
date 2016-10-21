program circle;
const inputfilename='circle.in';
      outputfilename='circle.out';
var x,m,t,tmp:longint;
    ans:array[1..30]of longint;
begin
      assign(input,inputfilename);
      reset(input);
      readln(x,m);
      close(input);
      if odd(m) then
      begin
        m:=m shr 1;
        tmp:=2;
        while tmp<m do
          tmp:=tmp shl 1;
        while tmp+m<=x do
        begin
          t:=t+1;
          ans[t]:=tmp+m;
          tmp:=tmp shl 1;
        end;
      end;
      assign(output,outputfilename);
      rewrite(output);
      writeln(t);
      for m:=1 to t do
         writeln(ans[m]);
      close(output);
end.