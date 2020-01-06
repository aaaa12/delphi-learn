unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,GameProc;

type
  TForm1 = class(TForm)
    btnBegin: TButton;
    btnTest: TButton;
    lbl1: TLabel;
    chk1: TCheckBox;
    btn1: TButton;
    btn2: TButton;
    procedure btnBeginClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnBeginClick(Sender: TObject);

begin
   Start;
end;

procedure TForm1.btnTestClick(Sender: TObject);
begin
  showMessage(TButton(GetInstanceFromhWnd(btnBegin.Handle)).Caption);
  //Label是画上去的，和shape,line一样，没有句柄
  //showMessage(TButton(GetInstanceFromhWnd(lbl1.Handle)).Caption);

  showMessage(TButton(GetInstanceFromhWnd(chk1.Handle)).Caption);
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  pc:Pchar;
begin
  pc:='btn1';
  EnumWindowsForFindChildWindowProc(btnBegin.Handle,LongInt(PChar(pc)));
end;



procedure TForm1.btn2Click(Sender: TObject);
var
 nParentHandle:HWnd;
begin
  nParentHandle := FindWindow(nil, 'Form1');

  showMessage(EIGetWinText(nParentHandle));

  showMessage(TForm(GetInstanceFromhWnd(nParentHandle)).Caption);
  showMessage(EIGetWinText(nParentHandle));
 // if nParentHandle <> 0 then
 //   nChildHandle := FindChildWindow(nParentHandle, '按钮1');
     //模拟鼠标单击 ，使用spy++获取点击事件
  //<00001> 00361E32 P WM_LBUTTONDOWN fwKeys:MK_LBUTTON xPos:330 yPos:129     00810140
  //<00002> 00361E32 P WM_LBUTTONUP fwKeys:0000 xPos:306 yPos:144             00900132
  //SendMessage(nChildHandle, Messages.WM_LBUTTONDOWN, 0, $000D0038); //按下
  //SendMessage(nChildHandle, Messages.WM_LBUTTONUP, 0, $000D0038); //抬起
end;

end.
