{$M 65520,0,655360}
{$N+}

type
  tlist = array[1 .. 2048] of integer;

var
  inp, out, std, log: string;
  n: integer;
  a: array[1 .. 2048] of ^tlist;
  s: array[1 .. 2048] of integer;

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
  assign(f, log);
  rewrite(f);
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

function ok: boolean;
var
  fx, fy: text;
  x, y: char;
  i, j, num: integer;
begin
  assign(fx, out); reset(fx);
  assign(fy, inp); reset(fy);
  read(fy, n);
  close(fy);
  if n >= 9 then begin ok := true; exit; end;
    for i := 1 to 1 shl n do
      begin
        new(a[i]);
        for j := 1 to 1 shl n do read(fx, a[i]^[j]);
      end;
    for i := 1 to 1 shl n do
    begin
      fillchar(s, sizeof(s), 0);
      for j := 1 to 1 shl n do
      begin
        if s[a[i]^[j]] = 1 then begin ok := false; exit; end;
        s[a[i]^[j]] := 1;
        if i <> j then if s[a[j]^[i]] = 1 then begin ok := false; exit; end;
        s[a[j]^[i]] := 1;
      end;
    end;
  close(fx);
  ok := true;
end;

function check: boolean; {简单的检测函数}
begin
  check := false;
  if not fileExists(out) then
    exit;
  if not fileExists(std) then
    exit;
  if not ok then exit;
  check := true;
end;

begin
  init;
  if check then
    accept
  else
    wrongAnswer;
end.
