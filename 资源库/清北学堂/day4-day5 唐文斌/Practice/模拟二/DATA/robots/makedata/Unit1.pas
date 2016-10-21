unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Grids, unit2, unit3, unit4;

type
  TForm1 = class(TForm)
    Panel3: TPanel;
    Button5: TButton;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    background: TImage;
    MainDraw: TImage;
    Button9: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    memo_m: TMemo;
    Memo1: TMemo;
    procedure showmap;
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure MainDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; XX, YY: Integer);
    procedure MainDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; xx, yy: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  maxp = 20;
  maxn = 50;

var
  Form1: TForm1;
  filename: string;
  downx, downy, nowoperation, len, n, m, p: integer;
  map: array[1 .. maxn, 1 .. maxn] of shortint;
  x, y: array[1 .. maxp] of integer;
  wanttosave, opend, beenchanged: boolean;
  positions: array[1 .. maxn, 1 .. maxn] of record
    x, y: integer;
  end;

implementation

uses Unit5;

{$R *.dfm}

procedure checkforsave;
begin
  if beenchanged then
    begin
      form1.Enabled := false;
      form5.Label1.Caption := 'Do you want to close the map with out saving?';
      form5.visible := true;
    end;
  wanttosave := false;
end;

function min(a, b: integer): integer;
begin
  if a < b then min := a else min := b;
end;

function max(a, b: integer): integer;
begin
  if a > b then max := a else max := b;
end;

procedure tform1.showmap;
var
  i, j, k, xx, yy: integer;
  firstx, firsty: integer;
begin
  maindraw.canvas.Brush.Color := clwhite;
  maindraw.canvas.FillRect(rect(0, 0, maindraw.Width - 1, maindraw.Height - 1));
  len := min(maindraw.Width div m, maindraw.Height div n) - 1;
  firstx := (maindraw.width - len * m) shr 1 - len;
  firsty := (maindraw.height - len * n) shr 1 - len;
  for i := 1 to n do
    for j := 1 to m do
      begin
        xx := j * len + firstx;
        yy := i * len + firsty;
        positions[i, j].x := xx; positions[i, j].y := yy;
        if map[i, j] = 0 then maindraw.canvas.Brush.Color := clyellow
        else maindraw.canvas.brush.color := clblue;
        maindraw.Canvas.fillrect(rect(xx + 1, yy + 1, xx + len, yy + len));
      end;
  for k := 1 to p do
    begin
      i := x[k]; j := y[k];
      xx := j * len + firstx;
      yy := i * len + firsty;
      maindraw.canvas.brush.color := clred;
      maindraw.Canvas.Ellipse(xx + 1, yy + 1, xx + len, yy + len);
    end;
  maindraw.repaint;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  input: textfile;
  i, j: integer;
begin
  checkforsave;
  if not wanttosave then
    begin
      if opendialog.Execute then
        begin
          filename := opendialog.filename;
          assignfile(input, filename); reset(input);
          readln(input, n, m, p);
          for i := 1 to p do read(input, x[i], y[i]);
          for i := 1 to n do
            for j := 1 to m do read(input, map[i, j]);
          closefile(input);
          showmap;
          beenchanged := false; opend := true;
       end;
    end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Halt;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  nowoperation := 1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  nowoperation := 2;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if opend then
    begin
      form1.enabled := false;
      form3.Label1.Caption :=
        'Are you sure you want to remove all the terrain and the position of all the robots?';
      form3.visible := true;
    end;
end;

procedure putanrobot(xx, yy: integer);
var
  i, j: integer;
begin
  if map[xx, yy] = 1 then
    begin
      form1.Enabled := false;
      form4.Label1.caption := 'You can put a robot only on the flat';
      form4.Visible := true;
      exit;
    end;
  for i := 1 to p do
    if (x[i] = xx) and (y[i] = yy) then
      begin
        dec(p);
        for j := i to p do
          begin
            x[j] := x[j + 1]; y[j] := y[j + 1];
          end;
        exit;
      end;
  if p = 20 then
    begin
      form1.enabled := false;
      form4.Label1.Caption := 'P is already equal to the maximal value, you could not add a new robot now! But  you may remove a exist robot for create a new one.';
      form4.Visible := true;
    end
  else
    begin
      inc(p); x[p] := xx; y[p] := yy;
    end;
end;

function find(xx, yy: integer; var x, y: integer): boolean;
var
  a, b, i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to m do
      begin
        a := xx - positions[i, j].x;
        b := yy - positions[i, j].y;
        if (a >= 1) and (a <= len) and (b >= 1) and (b <= len) then
          begin
            x := i; y := j; find := true; exit;
          end;
      end;
  find := false;
end;

procedure TForm1.MainDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; XX, YY: Integer);
var
  i, j, x, y: integer;
begin
  if not opend then exit;
  if not find(xx, yy, x, y) then exit;
  if (downx = 0) or (downy = 0) then exit;
  if nowoperation = 1 then
    begin
      putanrobot(x, y); showmap; exit;
    end;
  if (x > 1) and (x < n) and (y > 1) and (y < m) and
    (downx > 1) and (downx < n) and (downy > 1) and (downy < m) then
    begin
      for i := min(x, downx) to max(x, downx) do
        for j := min(y, downy) to max(y, downy) do
          map[i, j] := 1 - map[i, j];
      showmap;
    end
  else
    begin
      form1.enabled := false;
      form4.label1.Caption := 'You can''t make the bouder of the map falt.';
      form4.visible := true;
      exit;
    end
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  nowoperation := 2;
end;

procedure TForm1.MainDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; xx, yy: Integer);
begin
  if not find(xx, yy, downx, downy) then
    begin
      downx := 0; downy := 0; exit;
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i, j: integer;
  output: textfile;
  fname : tfilename;
begin
  if filename = '' then
    begin
      if not savedialog.Execute then exit;
      i := savedialog.filterindex;
      filename := savedialog.filename + '.in';
    end;
  assignfile(output, filename); rewrite(output);
  writeln(output, n, ' ', m, ' ', p);
  for i := 1 to p do write(output, x[i], ' ', y[i], ' ');
  writeln(output);
  for i := 1 to n do
    begin
      for j := 1 to m do write(output, map[i, j], ' ');
      writeln(output);
    end;
  closefile(output);
  beenchanged := false;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  form1.Enabled := false;
  form2.visible := true;
end;

end.

