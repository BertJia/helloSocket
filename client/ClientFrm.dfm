object FormClient: TFormClient
  Left = 0
  Top = 0
  Caption = #23458#25143#31471
  ClientHeight = 307
  ClientWidth = 622
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
  object Label1: TLabel
    Left = 415
    Top = 168
    Width = 27
    Height = 18
    Caption = 'IP'
  end
  object LabelPort: TLabel
    Left = 415
    Top = 203
    Width = 41
    Height = 13
    Caption = 'PORT'
  end
  object GroupBox1: TGroupBox
    Left = 327
    Top = 152
    Width = 287
    Height = 81
    TabOrder = 4
  end
  object ButtonConnection: TButton
    Left = 347
    Top = 253
    Width = 75
    Height = 25
    Caption = #36830#25509#26381#21153#22120
    TabOrder = 0
    OnClick = ButtonConnectionClick
  end
  object MemoContent: TMemo
    Left = 8
    Top = 239
    Width = 313
    Height = 60
    TabOrder = 1
  end
  object EditAddr: TEdit
    Left = 478
    Top = 165
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object EditPort: TEdit
    Left = 478
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '8080'
  end
  object MemoRecord: TMemo
    Left = 8
    Top = 8
    Width = 313
    Height = 225
    TabOrder = 5
  end
  object MemoLog: TMemo
    Left = 327
    Top = 8
    Width = 287
    Height = 121
    TabOrder = 6
  end
  object ButtonSend: TButton
    Left = 428
    Top = 253
    Width = 75
    Height = 25
    Caption = #21457#36865
    TabOrder = 7
  end
end
