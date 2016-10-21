var
  i:integer;
  k,n:integer;

begin
   assign(output,'div10.in');rewrite(output);
   n:=100;
   k:=50;
   writeln(n,' ',k);
   randomize;
   for i:=1 to n do
     if random(2)=1 then writeln(random(100))
        else writeln('-',random(100));

end.