unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
  form3.Visible := false;
  form1.enabled := true;
  fillchar(map, sizeof(map), 1);
  p := 0;
  form1.showmap;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
  form3.Visible := false;
  form1.enabled := true;
end;

end.
