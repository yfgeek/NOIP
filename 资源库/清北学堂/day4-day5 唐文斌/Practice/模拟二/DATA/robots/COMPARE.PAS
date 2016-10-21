{$N+}

const
  maxn = 50;
  maxp = 20;

var
  inp, out, std, log: string;
  map: array[1 .. maxn, 1 .. maxn] of integer;
  x, y: array[1 .. maxp] of integer;

procedure init; {初始化变量}
begin
  inp := paramStr(1); {标准输入文件，如input.txt}
  out := paramStr(2); {被测输出，如output.txt}
  std := paramStr(3); {标准输出，如output.001}
  log := paramStr(4); {把测试结果输出到log}
end;

procedure print(const d: double); {输出测试结果，测试结果是一个0到1之间的实数}
var
  f: text;
begin
  assign(f, log); rewrite(f);
  writeln(f, d : 0 : 2);
  close(f);
  halt;
end;

procedure accept; {1表示全对}
begin
  print(1);
end;

procedure wrongAnswer; {0表示全错}
begin
  print(0);
end;

function fileExists(const name: string): boolean; {判断文件是否存在}
var
  f: file;
begin
  {$I-}
  assign(f, name);
  fileMode := 0;
  reset(f);
  close(f);
  {$I+}
  fileExists := (ioResult = 0) and (name <> '');
end;

function ok(const inp, out: string): boolean; {评测函数}
var
  f: Text;
  tt, t, i, j, m, n, p: integer;
  ch: char;

procedure move(xx, yy: integer);
var
  i, x2, y2: integer;
begin
  for i := 1 to p do
    begin
      x2 := x[i] + xx; y2 := y[i] + yy;
      if map[x2, y2] = 0 then
        begin
          x[i] := x2; y[i] := y2;
        end;
    end;
end;

begin
  {$I-}
  ok := false;
  assign(f, inp); reset(f);
  readln(f, n, m, p);
  for i := 1 to p do read(f, x[i], y[i]);
  for i := 1 to n do
    for j := 1 to m do read(f, map[i, j]);
  close(f);

  assign(f, out); reset(f);
  readln(f, tt);
  t := 0;
  while not seekeoln(f) do
    begin
      inc(t); if t > 32767 then exit;
      read(f, ch);
      case ch of
        'N': move(-1, 0);
        'S': move(1, 0);
        'W': move(0, -1);
        'E': move(0, 1);
        else exit;
      end;
    end;
  if t <> tt then exit;
  for i := 2 to p do
    if (x[i] <> x[1]) or (y[i] <> y[1]) then exit;
  close(f);

  ok := true;
end;

function check: boolean; {简单的检测函数}
begin
  check := false;
  if not fileExists(out) then exit;
  if not fileExists(std) then exit;
  if not ok(inp, out) then exit;
  check := true;
end;

begin
  init;
  if check then accept else wrongAnswer;
end.
