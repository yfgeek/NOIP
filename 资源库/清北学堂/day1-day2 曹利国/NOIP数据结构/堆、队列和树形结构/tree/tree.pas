type
   lpnode=^node;
   node=record
      id:longint;
      next:lpnode;
      end;
var
   f:array[1..100000,0..1]of longint;
   beento:array[1..100000]of boolean;
   n,u,v,i:longint;
   t:lpnode;
   root:array[1..100000]of lpnode;
procedure dp(id:longint);
var
   p:lpnode;
begin
   beento[id]:=true;
   f[id][1]:=0;
   f[id][0]:=0;
   p:=root[id];
   while p<>nil do
   begin
      if not beento[p^.id] then
      begin
         dp(p^.id);
         if f[p^.id][1]+f[id][1]>=f[id][0] then f[id][0]:=f[p^.id][1]+1+f[id][1];
         if f[p^.id][0]>f[id][0] then f[id][0]:=f[p^.id][0];
         if f[p^.id][1]>=f[id][1] then f[id][1]:=f[p^.id][1]+1;
      end;
      p:=p^.next;
   end;
   if f[id][1]>f[id][0] then f[id][0]:=f[id][1];
end;
begin
   assign(input,'tree.in');reset(input);
   readln(n);
   for i:=1 to n do
      root[i]:=nil;
   for i:=2 to n do
   begin
      readln(u,v);
      new(t);
      t^.id:=u;
      t^.next:=root[v];
      root[v]:=t;
      new(t);
      t^.id:=v;
      t^.next:=root[u];
      root[u]:=t;
   end;
   close(input);
   fillchar(beento,n,false);
   dp(1);
   assign(output,'tree.out');rewrite(output);
   writeln(f[1][0]);
   close(output);
end.