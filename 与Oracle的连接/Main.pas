unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls, DBCtrls;

type
  TForm1 = class(TForm)
    conDB: TADOConnection;
    qryShowList: TADOQuery;
    dsShowList: TDataSource;
    dbgrdShowList: TDBGrid;
    dbnvgrShowList: TDBNavigator;
    qrySQL: TADOQuery;
    dsSQL: TDataSource;
    btnTdnode: TButton;
    dstSQL: TADODataSet;
    btnTenode: TButton;
    btnTnode: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTNodeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
const
  C_TB_SQL='SELECT b.comments,'+
             'a.column_name,'+
             'a.data_type || ''('' || a.data_length || '')'' data_type,'+
             'a.nullable '+
              'FROM user_tab_columns a, user_col_comments b '+
             'WHERE a.TABLE_NAME =UPPER(''{$table}'') '+
               'and b.table_name = UPPER(''{$table}'') '+
               'and a.column_name = b.column_name';
  C_ALLDATE_SQL='select * from {$table}';
implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  qryShowList.open;
end;

procedure TForm1.btnTNodeClick(Sender: TObject);
var
  sTBSQL,sAllDataSQL,sTable:string;
begin
  sTable:=TButton(Sender).Hint;
  sTBSQL:=StringReplace(C_TB_SQL,'{$table}',sTable,[rfReplaceAll]);
  sAllDataSQL:=StringReplace(C_ALLDATE_SQL,'{$table}',sTable,[rfReplaceAll]);

  qrySQL.SQL.Clear;
  qrySQL.SQL.Add(sTBSQL);
  //exec 与 open的区别在于 exec 是执行不且不返回结果集

  dstSQL.Close;
  dstSQL.CommandText:=sTBSQL;
  dstSQL.Open;


  qryShowList.Close;
  dbgrdShowList.Columns.Clear;
  dstSQL.First; //findFirst和findNext来2循环就爆错
  while not dstSQL.Eof do
  begin
    with dbgrdShowList.Columns.Add do
    begin
       title.Caption := VarToStr(dstSQL.FieldValues['column_name']);
       fieldname := VarToStr(dstSQL.FieldValues['column_name']);
       width:=70;
       if VarToStr(dstSQL.FieldValues['column_name'])='VC_VALUE' then
       begin
         width:=240;
       end;
    end;
    dstSQL.Next;
  end;
  qryShowList.SQL.Clear;
  qryShowList.SQL.Add(sAllDataSQL);
  qryShowList.Open;

end;


end.

