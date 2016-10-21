{$r-,s-,q-}

const    infns                  = '3.in';
         outfns                 = '3.out';
         maxn                   =  40000;
         maxcase                =  10000;
type     node                   =  record
                                     x, y, t : longint;
                                   end;
         tnode                  =  record
                                     x, y, root : longint;
                                   end;
var      question               :  array[1 .. maxcase] of node;
         info                   :  array[1 .. maxn] of tnode;
         n, m, t                :  longint;

procedure main;
var  i, point, x, y, distant      : longint;
     x1, y1, x2, y2, rx, ry       : longint;
     direction                    : char;

  function  findroot(root : longint; var x, y : longint) : longint;
    begin
      x := 0;
      y := 0;
      while info[root].root <> 0 do
        begin
          inc(x, info[root].x);
          inc(y, info[root].y);
          root := info[root].root;
        end;
      findroot := root;
    end;  { end of findroot }

  begin
    assign(input, infns);
    reset(input);
    assign(output, outfns);
    rewrite(output);
    readln(n, m);
    point := 1;
    fillchar(info, sizeof(info), 0);
    for i := 1 to m do
      begin
        read(x, y, distant);
        readln(direction, direction);
        rx := findroot(x, x1, y1);
        ry := findroot(y, x2, y2);
        info[ry].root := rx;
        case direction of
          'W' : begin
                  info[ry].x := x1 + distant - x2;
                  info[ry].y := y1 - y2;
                end;
          'E' : begin
                  info[ry].x := x1 - distant - x2;
                  info[ry].y := y1 - y2;
                end;
          'N' : begin
                  info[ry].x := x1 - x2;
                  info[ry].y := y1 - distant - y2;
                end;
          'S' : begin
                  info[ry].x := x1 - x2;
                  info[ry].y := y1 + distant - y2;
                end;
        end;
        while (point <= t) and (i = question[point].t) do
          begin
            rx := findroot(question[point].x, x1, y1);
            ry := findroot(question[point].y, x2, y2);
            if rx <> ry then writeln(-1)
                        else writeln(abs(x1 - x2) + abs(y1 - y2));
            inc(point);
          end;
      end;
    close(output);
    close(input);
  end;  { end of main }

procedure init;
var  i                      : longint;
  begin
    assign(input, infns);
    reset(input);
    readln(n, m);
    for i := 1 to m do readln;
    readln(t);
    for i := 1 to t do
      with question[i] do
        readln(x, y, t);
    close(input);
  end;  { end of init }

begin
  init;
  main;
end.
