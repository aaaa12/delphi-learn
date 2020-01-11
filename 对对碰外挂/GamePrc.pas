unit GamePrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

const
  x0 = 530;  //���Ͻ�,�м�
  y0 = 160;
  len = 63;  //���ӳ���
type
 twoPxy=array[0..1] of Tpoint;
 QP_Array= Array[0..7,0..24] of byte;
var
  nPrcoHandle: HWnd;
  ChessData:QP_Array;
  sitBase: array[0..3] of ^Dword = (   //
                                    Pointer($0049E310),         //
                                    Pointer($0049EEF4),          //
                                    Pointer($0049FAD8),          //
                                    Pointer($004A06BC)         //
                                    );
procedure link;
procedure Start;
procedure MyClick(a: TPoint);
procedure Switch(a, b: TPoint);
function upDataChess: Integer;
function TestChess(qp:QP_Array):bool;
function GetTwoPoint():twoPxy;
procedure clearOnce;
implementation
{
1 ��
2 ��
3 ��
4 ����
5 è
6 ţ
7 ��è

"left_base"3 ="004A06BC"
"up_base"0 ="0049E310"
"right_base"1 ="0049EEF4"
"down_base"2 ="0049FAD8"

"seatNo" ="004A18D0"

}

procedure link;
begin
  //if nPrcoHandle=0 then
  nPrcoHandle := FindWindow(nil, '�Զ�����ɫ��');
end;

procedure Start;
begin
  link;

  SendMessage(nPrcoHandle, Messages.WM_LBUTTONDOWN, 0, $02170214); //����
  SendMessage(nPrcoHandle, Messages.WM_LBUTTONUP, 0, $02170214); //̧��
end;

procedure Switch(a, b: TPoint);
var
  ax, ay, bx, by: Integer;
  aYx, bYx: DWORD;
begin
  link;

  ax := (a.X) * len + x0;
  ay := (a.Y) * len + y0;
  ayx := ax + ay shl 16;

  bx := (b.X) * len + x0;
  by := (b.Y) * len + y0;
  byx := bx + by shl 16;

  SendMessage(nPrcoHandle, Messages.WM_LBUTTONDOWN, 0, ayx);
  SendMessage(nPrcoHandle, Messages.WM_LBUTTONUP, 0, ayx);

  SendMessage(nPrcoHandle, Messages.WM_LBUTTONDOWN, 0, byx);
  SendMessage(nPrcoHandle, Messages.WM_LBUTTONUP, 0, byx);
end;

procedure MyClick(a: TPoint);
var
  xa, ya, xb, yb: LongInt;
  aYx, bYx: DWORD;
begin
  link;

  xa := (a.X) * len + x0;
  ya := (a.Y) * len + y0;
  ayx := xa + ya shl 16;

  SendMessage(nPrcoHandle, Messages.WM_LBUTTONDOWN, 0, ayx);
  SendMessage(nPrcoHandle, Messages.WM_LBUTTONUP, 0, ayx);

end;

function upDataChess: Integer;
var
  GamePid: DWORD;
  Gamehprocess: THandle;
  SitNum: DWORD;
  readByte: DWORD;  //ʵ�ʶ�ȡ����

{
^ ��������;��
1.�������������ͱ�ʶ��֮ǰ���� ^typeName ��ʾһ�����ͣ������ͱ�ʾָ��typeName���ͱ�����ָ�롣
2.����������ָ�����֮����pointer^�÷��Ŷ�ָ�������գ�Ҳ����˵�����ش洢���ڴ��ַ���õ�ַ������ָ���У���ֵָ��,ָ�������.
}
begin
  link;

  //��ȡ����ID
  GetWindowThreadprocessID(nPrcoHandle, GamePid);
  //��ȡ���̾��
  gamehProcess := OpenProcess(PROCESS_ALL_ACCESS, false, GamePid);
  //������λ��  @: ȡַ
  Readprocessmemory(gamehProcess, Pointer($004A18D0), @SitNum, 4, readByte);
   //������λ���� ������Ӧ��������
  Readprocessmemory(gamehProcess, sitBase[sitNum], @ChessData, 200, readByte);

end;

function TestChess(qp:QP_Array):bool;
var
  i,j:Integer;
  stmp:string;
  function getStr():string;
  var
    i,j:Integer;
  begin
    result:='';
    for j:=0 to 8 do
    begin
      for i:=0 to 8 do
      begin
        result:= result+','+IntToStr(qp[i][j]);
      end;
      result:=result+#13#10;
    end;
  end;
begin
  result:=false;
  for i:=0 to 7 do
    for j:=0 to 7 do
    begin

      if (((i-1>0) and (qp[i][j]=qp[i-1][j])) and ((i+1<8) and(qp[i][j]=qp[i+1][j])))
        or (((j-1>0) and (qp[i][j]=qp[i][j-1])) and ((j+1<8) and (qp[i][j]=qp[i][j+1])))
      then
      begin
        //showMessage(IntToStr(i)+','+IntToStr(j));
       // showMessage(getStr);
        result:=true;
        Exit;
      end;
    end;



end;

function GetTwoPoint():twoPxy;
var
  x,y:Integer;
  tmp:byte;
begin
  for x:=0 to 7 do   //x����
    for y:=0 to 6 do
    begin
      upDataChess;

      tmp:=ChessData[x][y];
      ChessData[x][y]:=ChessData[x][y+1];
      ChessData[x][y+1]:=tmp;    //������������

      if TestChess(ChessData) then
      begin
        result[0].X:=x;
        result[0].Y:=y;
        result[1].X:=x;
        result[1].Y:=y+1;
        Exit;
      end;
    end;

  for y:=0 to 7 do   //x����
    for x:=0 to 6 do
    begin
      upDataChess;

      tmp:=ChessData[x][y];
      ChessData[x][y]:=ChessData[x+1][y];
      ChessData[x+1][y]:=tmp;    //������������

      if TestChess(ChessData) then
      begin
        result[0].X:=x+1;
        result[0].Y:=y;
        result[1].X:=x;
        result[1].Y:=y;
        Exit;
      end;
    end;
end;

procedure clearOnce;
var
  tp:twoPxy;
begin
  tp:=GetTwoPoint;
  Switch(tp[0],tp[1]);
end;

end.

