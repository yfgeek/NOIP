{$r-,s-,q-}
const infns                     = '3.in';
      outfns                    = '3.out';
type tdist                      = array[1 .. 2] of longint;
var n, m, k                     : word;
    fa                          : array[1 .. 40000] of word;
    far                         : array[1 .. 40000] of tdist;
    listk                       : array[1 .. 40000, 1 .. 3] of longint;

procedure init;
var i           : longint;
begin
  assign(input, infns);
  reset(input);
    readln(n, m);
    for i :=1 to m do readln;
    readln(k);
    for i :=1 to k do readln(listk[i, 1], listk[i, 2], listk[i, 3]);
  close(input);
end;

procedure findx(a:longint; var ra : longint);
var ffa, x              : longint;
    dist, tt            : tdist;
begin
  ra :=a;
  fillchar(dist, sizeof(dist), 0);
  while fa[ra] <> 0 do begin
    inc(dist[1], far[ra, 1]);
    inc(dist[2], far[ra, 2]);
    ra :=fa[ra];
  end;
  ffa :=a;
  if fa[ffa] = 0 then exit;
  while fa[ffa] <> ra do begin
    x :=fa[ffa]; tt :=far[ffa];
    far[ffa, 1] :=dist[1]; far[ffa, 2] :=dist[2]; fa[ffa] :=ra;
    dec(dist[1], tt[1]); dec(dist[2], tt[2]);
    ffa :=x;
  end;
end;

procedure readline;
var a, b, ra, rb, l, x                  : longint;
    d                                   : char;
begin
  read(a, b, l);
  repeat
    read(d); d :=upcase(d);
  until d in ['E', 'W', 'S', 'N'];
  readln; findx(a, ra); findx(b, rb);
  if ra <> rb then begin
    if ra <> a then begin
      fa[ra] :=a;
      far[ra, 1] :=-far[a, 1];
      far[ra, 2] :=-far[a, 2];
    end;
    fillchar(far[a], sizeof(far[a]), 0);
    fa[a] :=b;
    case d of
      'E' : far[a, 1] :=-l;
      'W' : far[a, 1] :=l;
      'S' : far[a, 2] :=l;
      'N' : far[a, 2] :=-l;
    end;
  end;
end;

function getdist(a, b : longint) : longint;
var ra, rb        : longint;
    l1, l2        : tdist;
begin
  findx(a, ra); findx(b, rb);
  if ra <> rb then getdist :=-1
  else begin
    l1 :=far[a]; l2 :=far[b];
    dec(l1[1], l2[1]);
    dec(l1[2], l2[2]);
    getdist :=abs(l1[1]) + abs(l1[2]);
  end;
end;

procedure main;
var i, j, a, b, t             : longint;
begin
  fillchar(fa, sizeof(fa), 0);
  fillchar(far, sizeof(far), 0);
  readln(n, m);
  i :=0;
  for j :=1 to k do begin
    a :=listk[j, 1]; b :=listk[j, 2]; t :=listk[j, 3];
    if t > i then
      for i := i + 1 to t do readline;
    writeln(getdist(a, b));
  end;
end;

begin
  init;
  assign(input, infns);
  reset(input);
    assign(output, outfns);
    rewrite(output);
      main;
    close(input);
  close(output);
end.
