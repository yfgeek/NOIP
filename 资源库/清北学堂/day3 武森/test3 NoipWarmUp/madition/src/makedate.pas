var sin,sou:string;
   e,i,j,k:integer;
function tochr(r:integer):char;
var p:char;
begin
    if r<=9 then p:=chr(r+ord('0'))
     else p:=chr(r+ord('a')-10);
     tochr:=p;
end;
begin
  sin:='madition.in';
    for e:=0 to 2 do begin
       sin:=sin+chr(ord('0')+e);
       assign(output,sin);
        rewrite(output);
         i:=random(5)+2;
         writeln(i);
         write(random(i)+1);
         for j:=2 to random(10)+1 do begin
          write(random(i));
         end;
         writeln;
         write(random(i)+1);
	for j:=2 to random(10)+1 do begin
          write(random(i));
         end;
         writeln;
       close(output);
       delete(sin,length(sin),1);
    end;
     for e:=3 to 6 do begin
       sin:=sin+chr(ord('0')+e);
       assign(output,sin);
        rewrite(output);
         i:=random(20)+2;
         writeln(i);
         write(tochr(random(i)+1));
         for j:=2 to random(100)+1 do begin
          write(tochr(random(i)));
         end;
         writeln;
         write(tochr(random(i)+1));
	for j:=2 to random(100)+1 do begin
          write(tochr(random(i)));
         end;
         writeln;
       close(output);
         delete(sin,length(sin),1);
    end;
     for e:=7 to 9 do begin
       sin:=sin+chr(ord('0')+e);
       assign(output,sin);
        rewrite(output);
         i:=random(16)+20;
         writeln(i);
         write(tochr(random(i)+1));
         for j:=2 to random(100)+100 do begin
          write(tochr(random(i)));
         end;
         writeln;
         write(tochr(random(i)+1));
	for j:=2 to random(100)+100 do begin
          write(tochr(random(i)));
         end;
         writeln;
       close(output);
      delete(sin,length(sin),1);
    end;
end.
