object FormServer: TFormServer
  Left = 0
  Top = 0
  Caption = #26381#21153#31471
  ClientHeight = 331
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MemoContent: TMemo
    Left = 0
    Top = 274
    Width = 329
    Height = 57
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ButtonStart: TButton
    Left = 400
    Top = 298
    Width = 75
    Height = 25
    Caption = #21551#21160#26381#21153#22120
    TabOrder = 1
    OnClick = ButtonStartClick
  end
  object MemoRecord: TMemo
    Left = 0
    Top = 0
    Width = 329
    Height = 268
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object MemoLog: TMemo
    Left = 335
    Top = 8
    Width = 290
    Height = 129
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 335
    Top = 143
    Width = 290
    Height = 98
    TabOrder = 4
    object LabelAddr: TLabel
      Left = 24
      Top = 32
      Width = 60
      Height = 13
      Caption = #26381#21153#22120#22320#22336
    end
    object LabelPort: TLabel
      Left = 24
      Top = 56
      Width = 60
      Height = 13
      Caption = #26381#21153#22120#31471#21475
    end
    object EditAddr: TEdit
      Left = 120
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object EditPort: TEdit
      Left = 120
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '8080'
    end
  end
  object ButtonSend: TButton
    Left = 528
    Top = 298
    Width = 75
    Height = 25
    Caption = #21457#36865
    TabOrder = 5
  end
end
