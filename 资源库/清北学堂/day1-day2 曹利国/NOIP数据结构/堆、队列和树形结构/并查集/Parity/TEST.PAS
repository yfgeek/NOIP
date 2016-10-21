program Test;
var
  i,j:integer;
  f1,f2:text;

  begin
    assign(f1,'parity.out');
    reset(f1);
    readln(f1,i);
    close(f1);

    assign(f2,'parity.std');
    reset(f2);
    readln(f2,j);
    close(f2);

    if i=j then
      begin
        writeln('OK');
      end else
      begin
        writeln('You : ',i);
        writeln('Com : ',j);
      end;
  end.