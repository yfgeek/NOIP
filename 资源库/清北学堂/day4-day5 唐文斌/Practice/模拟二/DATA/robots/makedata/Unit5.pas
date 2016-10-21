unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm5 = class(TForm)
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
  Form5: TForm5;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
  wanttosave := false;
  form5.Visible := false;
  form1.enabled := true;
end;

procedure TForm5.BitBtn2Click(Sender: TObject);
begin
  wanttosave := true;
  form5.Visible := false;
  form1.enabled := true;
end;

end.
