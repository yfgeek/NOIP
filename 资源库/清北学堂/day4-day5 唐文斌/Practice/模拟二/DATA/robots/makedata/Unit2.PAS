unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ComCtrls;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabelM: TLabel;
    LabelN: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  st1, st2: string;
  code: integer;
begin
  st1 := maskedit1.Text;
  st2 := maskedit2.text;
  val(st1, n, code);
  if code <> 0 then exit;
  val(st2, m, code);
  if code <> 0 then exit;
  if (n >= 3) and (n <= 50) and (m >= 3) and (m <= 50) then
    begin
     form2.visible := false;
     form1.Enabled := true;
     if n = 0 then exit;
     fillchar(map, sizeof(map), 1);
     opend := true;
     form1.showmap;
    end;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  n := 0; m := 0;
  form2.visible := false;
  form1.Enabled := true;
end;

end.
