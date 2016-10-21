const
  inputFileName = 'input.txt';
  outputFileName = 'output.txt';
  maxN = 100;
  maxl = 15;

type
  tNode = record
    l: integer;
    a: array[1 .. maxl] of integer;
  end;
  tlist = array[1 .. maxN, 1 .. maxN] of tNode;

var
  f1: tlist;

begin

end.