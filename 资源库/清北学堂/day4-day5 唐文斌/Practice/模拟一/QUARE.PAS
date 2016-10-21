program Ks2;{Quare}
const ifn='quare.in';
      ofn='quare.out';
      block=6;
var n,k:integer;
procedure read_data;
begin
      assign(input,ifn);
      reset(input);
      readln(k);
      close(input);
end;
function f(x:integer):integer;
begin
      if x mod (n-1)=0 then f:=n-1 else f:=x mod (n-1);
end;
procedure main;
var i,j:integer;
begin
      n:=1 shl k;
      assign(output,ofn);
      rewrite(output);
      for i:=1 to n do
      begin
         if i<n then
           for j:=1 to i-1 do
              write( f(i+j-2)+n-1 : block)
         else
           for j:=1 to i-1 do
              write( f( f(2*j-1)-1 )+n-1 : block);
         write( 2*n-1 : block);
         for j:=i+1 to n-1 do
            write( f(i+j-2) : block );
         if i<n then write( f( f(2*i-1)-1 ) : block);
         writeln;
      end;
      close(output);
end;
begin
      read_data;
      main;
end.
