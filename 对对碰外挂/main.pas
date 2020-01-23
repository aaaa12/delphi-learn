unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,GamePrc, ExtCtrls;

type
  TMainForm = class(TForm)
    btnZb: TButton;
    edtAx: TEdit;
    edtAy: TEdit;
    btnJh: TButton;
    edtBx: TEdit;
    edtBy: TEdit;
    btnA: TButton;
    tmrZDzb: TTimer;
    chkZdzb: TCheckBox;
    btnClearOnce: TButton;
    edtSeatNo: TEdit;
    btnPorc: TButton;
    lbl1: TLabel;
    procedure btnZbClick(Sender: TObject);
    procedure btnJhClick(Sender: TObject);
    procedure btnAClick(Sender: TObject);
    procedure tmrZDzbTimer(Sender: TObject);
    procedure btnClearOnceClick(Sender: TObject);
    procedure btnPorcClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnZbClick(Sender: TObject);
begin
  Start;
end;



procedure TMainForm.btnJhClick(Sender: TObject);
var
  a,b:TPoint;
begin
  a.x:=StrToInt(edtAx.Text);a.y:=StrToInt(edtAy.Text);
  b.x:=StrToInt(edtBx.Text);b.y:=StrToInt(edtBy.Text);

  Switch(a,b);
end;

procedure TMainForm.btnAClick(Sender: TObject);
var
  a:TPoint;
begin
  a.x:=StrToInt(edtAx.Text);a.y:=StrToInt(edtAy.Text);
  MyClick(a);
end;

procedure TMainForm.tmrZDzbTimer(Sender: TObject);
begin
  if chkZdzb.Checked then
    btnZbClick(nil);
end;

procedure TMainForm.btnClearOnceClick(Sender: TObject);
begin
  clearOnce;
end;

procedure TMainForm.btnPorcClick(Sender: TObject);
begin
  PorcHandle;
end;

end.

