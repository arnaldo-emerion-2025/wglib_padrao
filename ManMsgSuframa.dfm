object fmMsgSuframa: TfmMsgSuframa
  Left = 407
  Top = 204
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Alerta sobre Suframa'
  ClientHeight = 293
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 6
    Width = 577
    Height = 121
    AutoSize = False
    Caption = 
      'Atenção consulte sempre o código no site do SUFRAMA e os incenti' +
      'vos fiscais que o cliente tem direito.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object lbValido: TLabel
    Left = 328
    Top = 136
    Width = 260
    Height = 33
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Val.:01/01/2013'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbNroSuframa: TLabel
    Left = 0
    Top = 140
    Width = 329
    Height = 25
    AutoSize = False
    Caption = 'Nro Suframa: 99999999999'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 181
    Width = 585
    Height = 64
    Caption = 'Considerar incentivos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object ckCOFINS: TCheckBox
      Left = 488
      Top = 24
      Width = 90
      Height = 17
      Caption = 'COFINS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ckCOFINSClick
    end
    object ckPIS: TCheckBox
      Left = 331
      Top = 24
      Width = 70
      Height = 17
      Caption = 'PIS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = ckPISClick
    end
    object ckICMS: TCheckBox
      Left = 16
      Top = 24
      Width = 78
      Height = 17
      Caption = 'ICMS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = ckICMSClick
    end
    object ckIPI: TCheckBox
      Left = 173
      Top = 24
      Width = 62
      Height = 17
      Caption = 'IPI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = ckIPIClick
    end
  end
  object Button1: TButton
    Left = 434
    Top = 249
    Width = 153
    Height = 41
    Caption = '&Confirma'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
end
