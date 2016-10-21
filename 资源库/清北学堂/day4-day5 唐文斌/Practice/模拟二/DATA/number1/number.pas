{$mode delphi}
program number;
{integer 7bit, carry at same time}

uses
  SysUtils;

const
  fn1 = 'number.in';
  fn2 = 'number.out';
  maxn = 10000;
  maxl = 100;
  bit = 7;
  more = 10000000;

type
  list = object
    l: integer;
    num: array[1 .. maxl] of integer;
    procedure add(var a: list);
    procedure sub(var a: list);
    procedure print;
    procedure carry;
  end;

var
  n, tot: integer;
  time: tdatetime;
  t: array[0 .. maxn] of list;
  multi: array[0 .. maxint div more] of integer;
  order: array[1 .. maxn] of integer;

procedure init;
begin
  assign(input, fn1); reset(input);
  readln(n);
  close(input);
end;

procedure list.add;
var
  i: integer;
begin
  for i := 1 to a.l do inc(num[i], a.num[i]);
end;

procedure list.sub;
var
  i: integer;
begin
  for i := 1 to a.l do dec(num[i], a.num[i]);
end;

procedure list.carry;
var
  i, j: integer;
begin
  for i := 1 to l do
    if num[i] < 0 then
      begin
        j := (more - 1 - num[i]) div more;
        dec(num[i + 1], j); inc(num[i], multi[j]);
      end
    else if num[i] >= more then
      begin
        j := num[i] div more;
        inc(num[i + 1], j); dec(num[i], multi[j]);
      end;
  i := l + 1;
  while num[i] > 0 do
    begin
      j := num[i] div more;
      num[i + 1] := j; dec(num[i], multi[j]);
      l := i; inc(i);
    end;
end;

procedure list.print;
var
  i: integer;
  st: string;
begin
  write(num[l]);
  for i := l - 1 downto 1 do
    begin
      str(num[i], st); while length(st) < bit do st := '0' + st;
      write(st);
    end;
  writeln;
end;

procedure prepare;
var
  i, j: integer;
begin
  for i := 0 to maxint div more do multi[i] := i * more;
  for i := 1 to maxn div 2 do
    if i * (3 * i - 1) div 2 > n then break
    else
      begin
        j := i * ((i and 1) * 2 - 1);
        order[i * 2 - 1] := j * (3 * i - 1) div 2;
        order[i * 2] := j * (3 * i + 1 ) div 2;
      end;
  tot := 2 * i - 2;
end;

procedure calc;
var
  i, j: integer;
begin
  t[0].num[1] := 1; t[0].l := 1;
  for i := 1 to n do
    begin
      t[i] := t[i - 1];
      for j := 2 to tot do
        begin
          if abs(order[j]) > i then break;
          if order[j] > 0 then t[i].add(t[i - order[j]])
                          else t[i].sub(t[i + order[j]]);
        end;
      t[i].carry;
    end;
end;

procedure print;
begin
  assign(output, fn2); rewrite(output);
  t[n].print;
{  writeln((now - time)*60*60*24:0:5);}
  close(output);
end;

begin
  time := now;
  init;
  prepare;
  calc;
  print;
end.
