object MainForm: TMainForm
  Left = 643
  Top = 124
  Width = 730
  Height = 350
  Caption = #23545#23545'aaa''bbb'#30896#22806#25346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnZb: TButton
    Left = 18
    Top = 14
    Width = 100
    Height = 29
    Caption = #20934#22791
    TabOrder = 0
    OnClick = btnZbClick
  end
  object edtAx: TEdit
    Left = 163
    Top = 18
    Width = 26
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtAy: TEdit
    Left = 188
    Top = 17
    Width = 30
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object btnJh: TButton
    Left = 291
    Top = 12
    Width = 76
    Height = 29
    Caption = #20132#25442
    TabOrder = 3
    OnClick = btnJhClick
  end
  object edtBx: TEdit
    Left = 231
    Top = 17
    Width = 26
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object edtBy: TEdit
    Left = 257
    Top = 16
    Width = 30
    Height = 21
    TabOrder = 5
    Text = '1'
  end
  object btnA: TButton
    Left = 164
    Top = 44
    Width = 54
    Height = 19
    Caption = 'A'
    TabOrder = 6
    OnClick = btnAClick
  end
  object chkZdzb: TCheckBox
    Left = 19
    Top = 46
    Width = 97
    Height = 20
    Caption = #33258#21160#20934#22791
    TabOrder = 7
  end
  object btnClearOnce: TButton
    Left = 22
    Top = 90
    Width = 88
    Height = 29
    Caption = #28040#38500#19968#27425
    TabOrder = 8
    OnClick = btnClearOnceClick
  end
  object edtSeatNo: TEdit
    Left = 382
    Top = 16
    Width = 45
    Height = 21
    TabOrder = 9
  end
  object btnPorc: TButton
    Left = 143
    Top = 86
    Width = 99
    Height = 29
    Caption = 'btnPorc'
    TabOrder = 10
    OnClick = btnPorcClick
  end
  object tmrZDzb: TTimer
    Interval = 5000
    OnTimer = tmrZDzbTimer
    Left = 116
    Top = 40
  end
end
