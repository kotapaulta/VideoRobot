object MainForm: TMainForm
  Left = 229
  Top = 130
  Width = 323
  Height = 271
  Caption = 'RoboMove1.1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PortStateLabel: TLabel
    Left = 16
    Top = 40
    Width = 79
    Height = 13
    Caption = #1055#1086#1088#1090' '#1085#1077' '#1086#1090#1082#1088#1099#1090
  end
  object OpenPort: TButton
    Left = 8
    Top = 8
    Width = 97
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    TabOrder = 0
    OnClick = OpenPortClick
  end
  object ClosePort: TButton
    Left = 120
    Top = 8
    Width = 89
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    TabOrder = 1
    OnClick = ClosePortClick
  end
  object SendData: TButton
    Left = 24
    Top = 88
    Width = 105
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
    TabOrder = 2
    OnClick = SendDataClick
  end
  object Edit1: TEdit
    Left = 152
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object btnUp: TButton
    Left = 128
    Top = 136
    Width = 33
    Height = 33
    Caption = 'Up'
    TabOrder = 4
    OnMouseDown = btnUpMouseDown
    OnMouseUp = btnUpMouseUp
  end
  object btnDown: TButton
    Left = 128
    Top = 184
    Width = 33
    Height = 33
    Caption = 'Down'
    TabOrder = 5
    OnMouseDown = btnDownMouseDown
    OnMouseUp = btnDownMouseUp
  end
  object btnLeft: TButton
    Left = 64
    Top = 184
    Width = 41
    Height = 33
    Caption = '<---'
    TabOrder = 6
    OnMouseDown = btnLeftMouseDown
    OnMouseUp = btnLeftMouseUp
  end
  object btnRight: TButton
    Left = 176
    Top = 184
    Width = 41
    Height = 33
    Caption = '--->'
    TabOrder = 7
    OnMouseDown = btnRightMouseDown
    OnMouseUp = btnRightMouseUp
  end
end
