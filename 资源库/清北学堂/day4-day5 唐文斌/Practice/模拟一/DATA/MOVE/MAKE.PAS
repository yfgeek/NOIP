const
  outputfilename = 'mov9.in';
  n = 5000;

var
  now, i, j: longint;

begin
  randomize;
  assign(output, outputfilename);
  rewrite(output);
  writeln(n);
  for i := 1 to n do
  begin
    if random(100) < 50 then writeln(0) else
    begin
      repeat
        j := random(n div 10);
      until now + j <= n;
      writeln(j);
      now := now + j;
    end;
  end;
  close(output);
end.