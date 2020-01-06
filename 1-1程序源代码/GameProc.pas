unit GameProc;

interface

uses
  windows, Messages, StrUtils, SysUtils, Dialogs, StdCtrls, Forms, Controls;
function GetInstanceFromhWnd(const hWnd: Cardinal): TWinControl;

function FindChildWindow(hwndParent: HWnd; ClassName: PChar): HWnd;

function EIGetWindowClass(const nHandle: HWnd): string;    //���ش��������

function EnumWindowsForFindChildWindowProc(WHandle: HWND; lParam: LPARAM): BOOL; export; stdcall;

function GetFocusedWindowFromParent(ParentWnd: HWnd): HWnd; //���ص�ǰ��ý���Ĵ���

function GetFocusedChildWindow: HWnd;     //��õ�ǰ��ý�����Ӵ��壬��ʹ��������Ӧ�ó���Ĵ���

function EIGetWinText(nHandle: Integer): string;       //��ô�����ı�

procedure EISetWinText(nHandle: Integer; const sNewText: string);    //�趨������ı�

procedure Start;

implementation

var
  hwndFindChildWindow,nParentHandle, nChildHandle:HWND;

function GetInstanceFromhWnd(const hWnd: Cardinal): TWinControl;   //��Ľ��̵�ʵ�岻�ܻ�ȡ��
type
  PObjectInstance = ^TObjectInstance;

  TObjectInstance = packed record
    Code: Byte;            { ����ת $E8 }
    Offset: Integer;       { CalcJmpOffset(Instance, @Block^.Code); }
    Next: PObjectInstance; { MainWndProc ��ַ }
    Self: Pointer;         { �ؼ������ַ }
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

function EnumWindowsForFindChildWindowProc(WHandle: HWND; lParam: LPARAM): BOOL; export; stdcall;   //export; stdcall��������ã���Ȼ�����޷�ִ��
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
   //�޷���ȡ�������̵�ʵ��
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

  //���ص�ǰ��ý���Ĵ���
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

  //��õ�ǰ��ý�����Ӵ��壬��ʹ��������Ӧ�ó���Ĵ���
function GetFocusedChildWindow: HWnd;
begin
  Result := GetFocusedWindowFromParent(GetForegroundWindow);
end;

  //��ô�����ı�
function EIGetWinText(nHandle: Integer): string;
var
  pcText: array[0..32768] of char;
begin
  SendMessage(nHandle, WM_GETTEXT, 32768, LongInt(@pcText));
  Result := pcText;
end;

  //�趨������ı�
procedure EISetWinText(nHandle: Integer; const sNewText: string);
begin
  SendMessage(nHandle, WM_SETTEXT, Length(sNewText), LongInt(PChar(Trim(sNewText))));
end;

procedure Start;
var

  pc:pchar;
begin
  // ���ݱ����ȡ���
  nParentHandle := FindWindow(nil, 'Form1');

 // showMessage(EIGetWinText(nParentHandle));
  pc:='��ť1';
  if nParentHandle <> 0 then
    nChildHandle := FindChildWindow(nParentHandle, pc);

  if nChildHandle <> 0 then
  begin
    //ģ����굥�� ��ʹ��spy++��ȡ����¼�
    //<00001> 00361E32 P WM_LBUTTONDOWN fwKeys:MK_LBUTTON xPos:330 yPos:129     00810140
    //<00002> 00361E32 P WM_LBUTTONUP fwKeys:0000 xPos:306 yPos:144             00900132
    SendMessage(nChildHandle, Messages.WM_LBUTTONDOWN, 0, $000D0038); //����
    SendMessage(nChildHandle, Messages.WM_LBUTTONUP, 0, $000D0038); //̧��
  end
  else
   showMessage('û����');
end;

end.

