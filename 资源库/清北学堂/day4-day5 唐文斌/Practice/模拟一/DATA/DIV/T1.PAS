{$r+,s+,q+}
const
  inputFileName = 'div.in';
  outputFileName = 'div.out';
  maxN = 100;

type
  tNode = record
    l, minus: integer;
    a: array[1 .. maxN] of longint;
  end;

var
  n, m, p1, p2: integer;
  a: array[1 .. maxN] of integer;
  ans: tNode;

procedure init;
var
  i: integer;
begin
  assign(input, inputFileName);
  reset(input);
  read(n, m);
  for i := 1 to n do read(a[i]);
  close(input);
end;

procedure main;
var
  i, j, k: longint;
begin
  for i := 1 to n do
    for j := i + 1 to n do
      if a[i] > a[j] then
      begin
        k := a[i]; a[i] := a[j]; a[j] := k;
      end;

  if n = m then
  begin

  end;

end;

procedure show;
begin
  assign(output, outputFileName);
  rewrite(output);
  close(output);
end;

begin
  init;
  main;
  show;
end.