{$P-,Q-,R-,S-}

program Kod;

const
  Fn1 = 'Kod.In';
  Fn2 = 'Kod.Out';

type
  Point = ^Node;
  Node = record
    i: Integer;
    L, R: Point
  end;

var
  N: Longint;
  K: Integer;
  F: array[0 .. 20] of Longint;
  Root: Point;

procedure Init;
begin
  Assign(Input, Fn1); Reset(Input);
  Readln(N, K); Close(Input)
end;

procedure Work;
var
  i, j: Integer;
begin
  F[0] := 1;
  for i := 1 to K do
    for j := 1 to i do F[i] := F[i] + F[j - 1] * F[i - j]
end;

procedure Calc(i, j: Integer; o: Point; X: Longint);
var
  h: Integer;
  p: Point;
begin
  for h := i to j do
    begin
      Dec(N, F[h - i] * F[j - h] * X);
      if N <= 0 then Break
    end;
  N := N + F[h - i] * F[j - h] * X;
  o^.i := h; o^.L := nil; o^.R := nil;
  if h > i then
    begin
      New(p); p^.L := nil; p^.R := nil; o^.L := p;
      Calc(i, h - 1, p, F[j - h] * x)
    end;
  if h < j then
    begin
      new(p); p^.R := nil; p^.R := nil; o^.R := p;
      Calc(h + 1, j, p, x)
    end
end;

procedure Print(o: Point);
begin
  Write(Chr(o^.i+96));
  if o^.L <> nil then Print(o^.L);
  if o^.R <> nil then Print(o^.R)
end;

begin
  Init;
  Work;
  New(Root);
  Calc(1, K, Root, 1);
  Assign(Output, Fn2); Rewrite(Output);
  Print(Root);
  Close(Output)
end.