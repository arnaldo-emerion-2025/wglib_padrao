inherited fmManCom: TfmManCom
  Left = 528
  Top = 211
  Caption = 'Comissões'
  ClientHeight = 268
  ClientWidth = 192
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 0
    Top = 0
    Width = 192
    Height = 268
    Align = alClient
    OnPaint = PaintBoxPaint
  end
  object grPro: TdxDBGraphicEdit
    Left = 1
    Top = 41
    Width = 191
    Color = 16577773
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Haettenschweiler'
    Font.Style = [fsBold]
    ParentFont = False
    Style.BorderColor = 14859373
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 0
    TabStop = False
    DblClickActivate = False
    Stretch = True
    ToolbarLayout.Buttons = []
    ToolbarLayout.IsPopupMenu = False
    ToolbarPosStored = False
    Height = 202
  end
  object grCom: ThGrid
    Left = 3
    Top = 43
    Width = 185
    Height = 196
    Selected.Strings = (
      'CODCOM'#9'8'#9' Código'
      'PERCOM'#9'15'#9'       % Percentual')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    BorderStyle = bsNone
    Color = 16577773
    DataSource = DsCom
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyOptions = []
    Options = [dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = False
    OnKeyDown = grComKeyDown
    IndicatorColor = icYellow
    CorDeFoco = clInfoBk
  end
  object EdCodCom: TdxDBColorEdit
    Left = 1
    Top = 243
    Width = 68
    Hint = 'Código'
    Color = 16577773
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Style.BorderColor = 14789952
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 2
    OnExit = EdCodComExit
    Alignment = taCenter
    CharCase = ecUpperCase
    DataField = 'CODCOM'
    DataSource = DsCom
    CorDeFoco = clInfoBk
    StoredValues = 1
  end
  object EdPerCom: TdxDBColorCurrencyEdit
    Left = 68
    Top = 243
    Width = 125
    Hint = 'Percentual de Comissão'
    Color = 16577773
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Style.BorderColor = 14065456
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 3
    OnExit = EdPerComExit
    Alignment = taRightJustify
    AutoSize = False
    DataField = 'PERCOM'
    DataSource = DsCom
    Nullable = False
    UseThousandSeparator = True
    CorDeFoco = clInfoBk
    Height = 24
    StoredValues = 1
  end
  object dxDBGraphicEdit1: TdxDBGraphicEdit
    Left = 1
    Top = 1
    Width = 191
    Color = 16577773
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Haettenschweiler'
    Font.Style = [fsBold]
    ParentFont = False
    Style.BorderColor = 14859373
    Style.BorderStyle = xbsSingle
    Style.ButtonStyle = btsSimple
    Style.ButtonTransparence = ebtInactive
    Style.HotTrack = True
    Style.Shadow = True
    TabOrder = 4
    TabStop = False
    Caption = '(Imagem do Item)'
    DblClickActivate = False
    Stretch = True
    ToolbarLayout.Buttons = []
    ToolbarLayout.IsPopupMenu = False
    ToolbarPosStored = False
    Height = 41
  end
  object Panel3: TPanel
    Left = 3
    Top = 3
    Width = 185
    Height = 35
    BevelOuter = bvNone
    TabOrder = 5
    object Label1: TLabel
      Left = 3
      Top = 8
      Width = 79
      Height = 18
      Caption = 'Comissões'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object FinCom: TwwQuery
    Active = True
    CachedUpdates = True
    OnNewRecord = FinComNewRecord
    DatabaseName = 'ISade'
    SQL.Strings = (
      'Select * From FinCom'
      'Order by SeqCom')
    UpdateObject = UpCom
    ValidateWithMask = True
    Top = 306
    object FinComCODCOM: TStringField
      Alignment = taCenter
      DisplayLabel = ' Código'
      DisplayWidth = 8
      FieldName = 'CODCOM'
      Origin = 'ISADE.FINCOM.CODCOM'
      FixedChar = True
      Size = 3
    end
    object FinComPERCOM: TFloatField
      DisplayLabel = '       % Percentual'
      DisplayWidth = 15
      FieldName = 'PERCOM'
      Origin = 'ISADE.FINCOM.PERCOM'
      DisplayFormat = '###,###,##0.00'
      Precision = 2
    end
    object FinComSEQCOM: TIntegerField
      DisplayWidth = 10
      FieldName = 'SEQCOM'
      Origin = 'ISADE.FINCOM.SEQCOM'
      Visible = False
    end
    object FinComFLGTRG: TStringField
      DisplayWidth = 1
      FieldName = 'FLGTRG'
      Origin = 'ISADE.FINCOM.FLGTRG'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DsCom: TwwDataSource
    DataSet = FinCom
    Left = 28
    Top = 306
  end
  object UpCom: TUpdateSQL
    ModifySQL.Strings = (
      'update FinCom'
      'set'
      '  PERCOM = :PERCOM,'
      '  SEQCOM = :SEQCOM,'
      '  FLGTRG = :FLGTRG'
      'where'
      '  CODCOM = :OLD_CODCOM')
    InsertSQL.Strings = (
      'insert into FinCom'
      '  (CODCOM, PERCOM, SEQCOM, FLGTRG)'
      'values'
      '  (:CODCOM, :PERCOM, :SEQCOM, :FLGTRG)')
    DeleteSQL.Strings = (
      'delete from FinCom'
      'where'
      '  CODCOM = :OLD_CODCOM')
    Top = 334
  end
  object quSQL: TwwQuery
    DatabaseName = 'ISade'
    ValidateWithMask = True
    Left = 28
    Top = 334
  end
end
