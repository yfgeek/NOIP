var heap:array[1..10000] of longint;
    top:longint;

procedure push(s:longint);
var i,k:longint;
begin
  inc(top);
  i:=top;
  k:=i shr 1;
  while (k>0) and (heap[k]<s) do begin
    heap[i]:=heap[k];
    i:=k;
    k:=i shr 1;
  end;
  heap[i]:=s;
end;

function pop:longint;
var i,k:longint;
begin
  pop:=heap[1];
  heap[1]:=heap[top];
  dec(top);
  i:=1;
  k:=i shl 1;
  while (k<=top) do begin
    if (k<top) and (heap[k]<heap[k+1]) then inc(k);
    if heap[k]>heap[i] then begin
      heap[i]:=heap[k];
      i:=k;
      k:=i shl 1;
    end
    else break;
  end;
  heap[i]:=heap[top+1];
end;

procedure test;
var n,i,p:longint;
begin
  top:=0;
  readln(n);
  for i:=1 to n do begin
    readln(p);
    push(p);
  end;
  for i:=1 to n do
    writeln(pop);
end;

begin
  test;
end.
