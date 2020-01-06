unit GameProc;

interface

uses
  windows, Messages, StrUtils, SysUtils, Dialogs, StdCtrls, Forms, Controls;
function GetInstanceFromhWnd(const hWnd: Cardinal): TWinControl;

function FindChildWindow(hwndParent: HWnd; ClassName: PChar): HWnd;

function EIGetWindowClass(const nHandle: HWnd): string;    //返回窗体的类名

function EnumWindowsForFindChildWindowProc(WHandle: HWND; lParam: LPARAM): BOOL; export; stdcall;

function GetFocusedWindowFromParent(ParentWnd: HWnd): HWnd; //返回当前获得焦点的窗体

function GetFocusedChildWindow: HWnd;     //获得当前获得焦点的子窗体，即使它是其他应用程序的窗体

function EIGetWinText(nHandle: Integer): string;       //获得窗体的文本

procedure EISetWinText(nHandle: Integer; const sNewText: string);    //设定窗体的文本

procedure Start;

implementation

var
  hwndFindChildWindow,nParentHandle, nChildHandle:HWND;

function GetInstanceFromhWnd(const hWnd: Cardinal): TWinControl;   //别的进程的实体不能获取到
type
  PObjectInstance = ^TObjectInstance;

  TObjectInstance = packed record
    Code: Byte;            { 短跳转 $E8 }
    Offset: Integer;       { CalcJmpOffset(Instance, @Block^.Code); }
    Next: PObjectInstance; { MainWndProc 地址 }
    Self: Pointer;         { 控件对象地址 }
  end;
var
  wc: PObjectInstance;
begin
  Result := nil;
  wc := Pointer(GetWindowLong(hWnd, GWL_WNDPROC));
  if wc <> nil then
  begin
    Result := wc.Self;
  end;
end;

function FindChildWindow(hwndParent: HWnd; ClassName: PChar): HWnd;
begin
  try
    EnumChildWindows(hwndParent, @EnumWindowsForFindChildWindowProc, LongInt(PChar(ClassName)));
    Result := hwndFindChildWindow;
  except
    Result := 0;
  end;
end;

function EIGetWindowClass(const nHandle: HWnd): string;
var
  szClassName: array[0..255] of char;
begin
  GetClassName(nHandle, szClassName, 255);
  Result := szClassName;
end;

function EnumWindowsForFindChildWindowProc(WHandle: HWND; lParam: LPARAM): BOOL; export; stdcall;   //export; stdcall输出，有用，不然程序无法执行
const
  MAX_WINDOW_NAME_LEN = 80;
var
  sTargetClassName: string;
  nHandle: HWnd;
  sCurrClassName: string;
  bResult: Boolean;
begin
  if (hwndFindChildWindow <> 0) then
    exit;

  sTargetClassName := PChar(lParam);
  sCurrClassName := EIGetWindowClass(WHandle);
  if sCurrClassName = 'TButton' then
  begin
   //无法获取其它进程的实体
   // sCurrClassName := TButton(GetInstanceFromhWnd(WHandle)).Caption;
   // showMessage(sCurrClassName);

    sCurrClassName:=EIGetWinText(WHandle);

    bResult := sCurrClassName = sTargetClassName;
    if (bResult) then
      hwndFindChildWindow := WHandle
    else
      FindChildWindow(WHandle, PChar(lParam));
  end;
end;

  //返回当前获得焦点的窗体
function GetFocusedWindowFromParent(ParentWnd: HWnd): HWnd;
var
  OtherThread, Buffer: DWord;
  idCurrThread: DWord;
begin
  OtherThread := GetWindowThreadProcessID(ParentWnd, @Buffer);
  idCurrThread := GetCurrentThreadID;
  if AttachThreadInput(idCurrThread, OtherThread, true) then
  begin
    Result := GetFocus;
    AttachThreadInput(idCurrThread, OtherThread, false);
  end
  else
    Result := GetFocus;
end;

  //获得当前获得焦点的子窗体，即使它是其他应用程序的窗体
function GetFocusedChildWindow: HWnd;
begin
  Result := GetFocusedWindowFromParent(GetForegroundWindow);
end;

  //获得窗体的文本
function EIGetWinText(nHandle: Integer): string;
var
  pcText: array[0..32768] of char;
begin
  SendMessage(nHandle, WM_GETTEXT, 32768, LongInt(@pcText));
  Result := pcText;
end;

  //设定窗体的文本
procedure EISetWinText(nHandle: Integer; const sNewText: string);
begin
  SendMessage(nHandle, WM_SETTEXT, Length(sNewText), LongInt(PChar(Trim(sNewText))));
end;

procedure Start;
var

  pc:pchar;
begin
  // 根据标题获取句柄
  nParentHandle := FindWindow(nil, 'Form1');

 // showMessage(EIGetWinText(nParentHandle));
  pc:='按钮1';
  if nParentHandle <> 0 then
    nChildHandle := FindChildWindow(nParentHandle, pc);

  if nChildHandle <> 0 then
  begin
    //模拟鼠标单击 ，使用spy++获取点击事件
    //<00001> 00361E32 P WM_LBUTTONDOWN fwKeys:MK_LBUTTON xPos:330 yPos:129     00810140
    //<00002> 00361E32 P WM_LBUTTONUP fwKeys:0000 xPos:306 yPos:144             00900132
    SendMessage(nChildHandle, Messages.WM_LBUTTONDOWN, 0, $000D0038); //按下
    SendMessage(nChildHandle, Messages.WM_LBUTTONUP, 0, $000D0038); //抬起
  end
  else
   showMessage('没找着');
end;

end.

