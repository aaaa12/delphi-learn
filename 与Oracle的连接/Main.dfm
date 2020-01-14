object Form1: TForm1
  Left = 529
  Top = 223
  Width = 931
  Height = 554
  Caption = 'LinkOracle'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdShowList: TDBGrid
    Left = 29
    Top = 175
    Width = 856
    Height = 311
    DataSource = dsShowList
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'L_ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VC_CLASS1'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VC_CLASS2'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VC_TITLE'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VC_VALUE'
        Width = 230
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VC_COMMENT'
        Width = 182
        Visible = True
      end>
  end
  object dbnvgrShowList: TDBNavigator
    Left = 24
    Top = 137
    Width = 200
    Height = 29
    DataSource = dsShowList
    TabOrder = 1
  end
  object btnTdnode: TButton
    Left = 13
    Top = 7
    Width = 84
    Height = 28
    Hint = 'tdnode'
    Caption = 'delphi'#30693#35782
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnTNodeClick
  end
  object btnTenode: TButton
    Left = 12
    Top = 44
    Width = 86
    Height = 27
    Hint = 'tenode'
    Caption = #33521#35821#30693#35782
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnTNodeClick
  end
  object btnTnode: TButton
    Left = 13
    Top = 80
    Width = 86
    Height = 27
    Hint = 'tnode'
    Caption = #36890#29992#30693#35782
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnTNodeClick
  end
  object conDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=OraOLEDB.Oracle.1;Password=123456;Persist Security Info' +
      '=True;User ID=BrainNet;Data Source=127.0.0.1/orcl'
    Provider = 'OraOLEDB.Oracle.1'
    Left = 480
    Top = 88
  end
  object qryShowList: TADOQuery
    Connection = conDB
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM tnode')
    Left = 482
    Top = 121
  end
  object dsShowList: TDataSource
    DataSet = qryShowList
    Left = 482
    Top = 150
  end
  object qrySQL: TADOQuery
    Connection = conDB
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM tnode')
    Left = 527
    Top = 34
  end
  object dsSQL: TDataSource
    DataSet = qrySQL
    Left = 526
    Top = 70
  end
  object dstSQL: TADODataSet
    Connection = conDB
    DataSource = dsSQL
    Parameters = <>
    Left = 486
    Top = 58
  end
end
