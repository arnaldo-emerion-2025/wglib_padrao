inherited fmManAut: TfmManAut
  Caption = 'Licenciamento'
  ClientHeight = 284
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 0
    Top = 0
    Width = 428
    Height = 284
    Align = alClient
    OnPaint = PaintBoxPaint
  end
  object Label1: TLabel
    Left = 53
    Top = 130
    Width = 101
    Height = 14
    Caption = 'Autorização No. '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 16
    Top = 22
    Width = 363
    Height = 14
    Caption = 'Aguarde verificando o número de autorização informado....'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object ProgressBar: TdxfProgressBar
    Left = 16
    Top = 41
    Width = 397
    Height = 57
    BarBevelOuter = bvNone
    BevelOuter = bvLowered
    Orientation = orHorizontal
    Max = 100
    Min = 0
    Position = 0
    ShowText = True
    ShowTextStyle = stsPercent
    BeginColor = clNavy
    EndColor = clWhite
    Style = sExSolid
    Step = 1
    TransparentGlyph = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object EdSeqInf1: TdxColorEdit
    Left = 51
    Top = 146
    Width = 39
    Color = 16577773
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 1
    OnKeyPress = EdSeqInf1KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object EdSeqInf2: TdxColorEdit
    Left = 92
    Top = 146
    Width = 39
    Color = 16577773
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 2
    OnKeyPress = EdSeqInf1KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object EdSeqInf3: TdxColorEdit
    Left = 133
    Top = 146
    Width = 39
    Color = 16577773
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 3
    OnKeyPress = EdSeqInf3KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object EdSeqInf4: TdxColorEdit
    Left = 174
    Top = 146
    Width = 39
    Color = 16577773
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 4
    OnKeyPress = EdSeqInf3KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object EdSeqInf5: TdxColorEdit
    Left = 215
    Top = 146
    Width = 39
    Color = 16577773
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 5
    OnKeyPress = EdSeqInf3KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object EdSeqInf6: TdxColorEdit
    Left = 256
    Top = 146
    Width = 39
    Color = 16577773
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 6
    OnKeyPress = EdSeqInf3KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object btnVerificar: TBitBtn
    Left = 33
    Top = 208
    Width = 361
    Height = 65
    Caption = 'Verificar no. informado ...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btnVerificarClick
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      0800000000004002000000000000000000000001000000010000FF00FF003837
      37003C3D3E00403F3E0041424200484646004B4B4B004D4D4D00515050005755
      5500585655006E686600797573007E7776007E7A7900877E7B0005669500046B
      9C00046C9E000A6E9A000271A5000C75A4000274A9000578AC000F7BAA00017A
      B400037FB7001680A7001183B1001F89B2001C95BB002781A9002695BD00289C
      BC004D9CBB000387C1001D95C0002093C200249DCE0016A9D70026ABCF003AAF
      C70034A9CE003FB4CB0023A5D4003FB1D3000CB7ED001BB6E00027BFE20054B1
      CA005DB0CC0046B6DD0062AFC9000DC7FE0018C6F7001ACCFE0025D7FE0030D3
      FE003AD6FE003ED7FE0049CEE20051C7E9005BD5E2005CD5E20048DEFE0050DA
      F0005AD9F8005CDEFF0070CFE50063D5E20069D5E2006FD3ED007BD5E20045E6
      FE0056EEFE006AEFF70060E1FF007DE5FC007DE9FE007AEEFE0066F2FB0069F6
      FE0076F3FA007FF7FE007BFCFE00898483008A8887008A88880097898700908B
      8A00918E8E00968F8E00988F8C009C8F8C009E918F0096929200999593009896
      95009E969600A0969300A79F9E00A99D9900AC9D9A00A7A09E00ACA3A000B4A5
      A300B0AAA900B7B1B000B7B6B600BDB4B100BBB7B600C4B7B500C7BCBA00C1BD
      BD00C4BFBF008ED5E30082D9F000B2D5E30087E7FF0095EAFC0081FFFE0087FF
      FE008EFFFE0092F7FE009FF7FF0095FFFE0098FAFE009FFFFE00A0E9EF00AAEE
      F600A3EDFF00A6FFFE00BDF3FF00BAFFFE00C9C1C000CCC2C000CBC4C200CCC9
      C700D0C9C700D1CBCA00D5CCCA00DAD4D300E0DAD900E1DDDC00E5DDDC00C4F4
      FF00C1FFFF00D0F6FE00D5FFFF00DDFFFF00E2E0E000E6E2E200EDE5E300EAE9
      E700EDEAE900EFEDED00F3EEEB00F6F2EF00EBF4F800F6F2F000FAF6F600F2FF
      FF00F8FFFF00FFFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000606060600000000000000000000000000000000000000060C986D06000000
      00000000000000000000000000000010066A0E9C6A0810100000000000000000
      000000000010102A2A066A0EA3062015101000000000000000000000101B3C49
      4039066A56960606061110000000000000000000163E514938393B066A5A9971
      5A0606060606000000000000163E514938353B43066A5AA08E8C87716F5E0600
      00000000163E5149383537434E066A579A8A87670C69580600000000163E5149
      3835373B4E77066C8E8D6D0A0A66660600000000163E51493835373B4C77069A
      967105035A5D5D0600000000163E534E53768284919306A08905016255030F06
      00000000168081442D241C181D3206A36D08625600050B060000000014312128
      2F2E363B437406629F8C71050303620600000000112B50493835373B43774706
      5F8E87675F68670600000000163E51493835373B4C4E47330606060606060600
      00000000163E51493835373B4C4E3D3326251F000000000000000000163E5149
      3835373B4C4E3D2C231910000000000000000000163E51493835373B4C4E3D2C
      231910000000000000000000163E51493835373B4C4E3D2C2319100000000000
      0000000016457E7C7B7D7878787852412719100000000000000000001675A395
      92837A78787878784A301000000000000000000016229EA194857E7A78787878
      4B1E1000000000000000000000161734347348453E3E29291310000000000000
      0000000000000016161616161616161600000000000000000000}
  end
  object EdSeqInf7: TdxColorEdit
    Left = 298
    Top = 146
    Width = 39
    Color = 16577773
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 7
    OnKeyPress = EdSeqInf3KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object EdSeqInf8: TdxColorEdit
    Left = 339
    Top = 146
    Width = 39
    Color = 16577773
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 8
    OnKeyPress = EdSeqInf3KeyPress
    Alignment = taCenter
    CharCase = ecUpperCase
    MaxLength = 1
    CorDeFoco = clInfoBk
    StoredValues = 3
  end
  object quSQL: TwwQuery
    AutoCalcFields = False
    DatabaseName = 'ISade'
    UniDirectional = True
    ValidateWithMask = True
    Left = 371
    Top = 58
  end
end
