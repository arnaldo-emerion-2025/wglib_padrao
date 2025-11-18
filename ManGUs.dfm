inherited fmManGus: TfmManGus
  Left = 84
  Top = 38
  Caption = 'Grupo de Usuarios'
  ClientHeight = 384
  ClientWidth = 583
  Color = 15788249
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcGUs: TPageControl
    Left = -3
    Top = 0
    Width = 589
    Height = 389
    ActivePage = pcPag1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Style = tsButtons
    TabOrder = 0
    TabWidth = 90
    object pcPag1: TTabSheet
      Caption = ' &Visualizar '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnShow = pcPag1Show
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 581
        Height = 358
        Align = alClient
        BevelOuter = bvNone
        Color = 15788249
        TabOrder = 0
        object Shape6: TShape
          Left = 1
          Top = 3
          Width = 172
          Height = 18
          Brush.Color = 14789952
          Pen.Color = 11764252
          Shape = stRoundRect
        end
        object Label2: TLabel
          Left = 5
          Top = 5
          Width = 154
          Height = 13
          Caption = 'Informações para Pesquisa'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Shape2: TShape
          Left = 174
          Top = 11
          Width = 407
          Height = 3
          Brush.Color = 11106843
          Pen.Color = 14789952
        end
        object Label10: TLabel
          Left = 3
          Top = 28
          Width = 40
          Height = 13
          Caption = 'Código :'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Shape4: TShape
          Left = 1
          Top = 112
          Width = 221
          Height = 18
          Brush.Color = 14789952
          Pen.Color = 11764252
          Shape = stRoundRect
        end
        object Label3: TLabel
          Left = 6
          Top = 114
          Width = 167
          Height = 13
          Caption = 'Tipos de Parada Selecionados'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Shape5: TShape
          Left = 223
          Top = 120
          Width = 358
          Height = 3
          Brush.Color = 11106843
          Pen.Color = 14789952
        end
        object Shape11: TShape
          Left = 2
          Top = 335
          Width = 579
          Height = 20
          Brush.Color = 14789952
          Pen.Color = 11764252
          Shape = stRoundRect
        end
        object Label4: TLabel
          Left = 3
          Top = 52
          Width = 53
          Height = 13
          Caption = 'Descrição :'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label12: TLabel
          Left = 6
          Top = 338
          Width = 253
          Height = 13
          Caption = 'Crtl+'#39'I'#39'-Incluir Ctrl+'#39'E'#39'-Excluir Ctrl+'#39'S'#39'-Salvar'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object EdPsqCodGUs: TdxColorEdit
          Left = 78
          Top = 24
          Width = 96
          Color = 16577773
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Style.BorderColor = 14789952
          Style.BorderStyle = xbsSingle
          Style.ButtonStyle = btsSimple
          Style.ButtonTransparence = ebtInactive
          Style.HotTrack = True
          Style.Shadow = True
          TabOrder = 0
          CharCase = ecUpperCase
          CorDeFoco = clInfoBk
        end
        object rgOrdem: TRadioGroup
          Left = 365
          Top = 14
          Width = 107
          Height = 104
          Caption = ' Exibido Por '
          ItemIndex = 0
          Items.Strings = (
            'Código'
            'Descrição')
          TabOrder = 2
        end
        object rgBusca: TRadioGroup
          Left = 476
          Top = 14
          Width = 105
          Height = 104
          Caption = ' Tipo de Busca'
          ItemIndex = 0
          Items.Strings = (
            'Iniciais'
            'Inteligente')
          TabOrder = 3
        end
        object Bbselecionar: TBitBtn
          Left = 227
          Top = 73
          Width = 135
          Height = 45
          Caption = '&Selecionar'
          Default = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = BbselecionarClick
          Glyph.Data = {
            36080000424D3608000000000000360400002800000020000000200000000100
            0800000000000004000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A600CCFFFF0099FFFF0066FFFF0033FFFF00FFCCFF00CCCCFF0099CCFF0066CC
            FF0033CCFF0000CCFF00FF99FF00CC99FF009999FF006699FF003399FF000099
            FF00FF66FF00CC66FF009966FF006666FF003366FF000066FF00FF33FF00CC33
            FF009933FF006633FF003333FF000033FF00CC00FF009900FF006600FF003300
            FF00FFFFCC00CCFFCC0099FFCC0066FFCC0066FFCC0033FFCC0000FFCC00FFCC
            CC00CCCCCC0099CCCC0066CCCC0033CCCC0000CCCC00FF99CC00CC99CC009999
            CC006699CC003399CC000099CC00FF66CC00CC66CC009966CC006666CC003366
            CC000066CC00FF33CC00CC33CC009933CC006633CC003333CC000033CC00FF00
            CC00CC00CC009900CC006600CC003300CC000000CC00FFFF9900CCFF990099FF
            990066FF990033FF990000FF9900FFCC9900CCCC990099CC990066CC990033CC
            990000CC9900FF999900CC99990099999900669999003399990000999900FF66
            9900CC66990099669900666699003366990000669900FF339900CC3399009933
            9900663399003333990000339900FF009900CC00990099009900660099003300
            990000009900FFFF6600CCFF660099FF660066FF660033FF660000FF6600FFCC
            6600CCCC660099CC660066CC660033CC660000CC6600FF996600CC9966009999
            6600669966003399660000996600FF666600CC66660099666600666666003366
            660000666600FF336600CC33660099336600663366003333660000336600FF00
            6600CC00660099006600660066003300660000006600FFFF3300CCFF330099FF
            330066FF330033FF330000FF3300FFCC3300CCCC330099CC330066CC330033CC
            330000CC3300FF993300CC99330099993300669933003399330000993300FF66
            3300CC66330099663300666633003366330000663300FF333300CC3333009933
            3300663333003333330000333300FF003300CC00330099003300660033003300
            330000003300CCFF000099FF000066FF000033FF0000FFCC0000CCCC000099CC
            000066CC000033CC000000CC0000FF990000CC99000099990000669900003399
            000000990000FF660000CC66000099660000666600000066000033660000FF33
            0000CC33000099330000663300003333000000330000CC000000990000006600
            0000330000000000DD000000BB000000AA000000880000007700000055000000
            44000000220000DD000000BB000000AA00000088000000770000005500000044
            000000220000DDDDDD0055555500777777007777770044444400222222001111
            110077000000550000004400000022000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00323232323232
            323232000000000000000000EDEDED3232323232323232323232323232323232
            00000031313131FF5CFF5C5C000000EDEDED3232323232323232323232320000
            31313131313131FF5CFF5C5C5C5C5C0000EDEDED323232323232323232005C5C
            31313131313131FF5CFF5C5C5C5C5C5C5C00EDEDED32323232323232005C5C5C
            31313131313131FF5CFF5C5C5C5C5C5C5C5C00EDEDED3232323232005C5C5C5C
            3131310000000000000000005C5C5C5C5C5C5C00EDEDED323232005C5C5C5C5C
            000000FFFFFFFFFFFFFFFFFF0000005C5C5C5C5C00EDED323232005C5C5C0000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00005C5C5C00EDEDED3232005C5C00FFFF
            FFFF00000000000000000000FFFFFFFFFF005C5C00EDEDED3232005C00FFFFFF
            00005B5B5B5B5B5B5B5B5B5B000000FFFFFF005C00EDEDEDED320000FFFFFF00
            5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B00FFFFFF0000EDEDEDED3200FFFFFF0087
            5B5B5B5B5B5B5B5B5BFFFFFF5B5B5B5B00FFFFFF00EDEDEDED3200FFFF005C5B
            875B5B5B5B5B5B5B5B5B5B5BFF5B5B875B00FFFF00EDEDED323200FFFF005C5C
            5B8787315B5B5B5B5B5B5B5BFF87875B5C00FFFF00EDEDED323200FFFF005C5C
            5C5B31FF3187878787878787875B5C5C5C00FFFF00EDED32323200FFFFFF005C
            5C5C5C315B5B5B5B5B5B5B5B5B5CF75B00FFFFFF00ED323232323200FFFFFF00
            5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C00FFFFFF00323232323232323200FFFFFF
            0000005C5C5C5C5C5C5C5C5C5C0000FFFFFF003232323232323232323200FFFF
            FFFFFF00000000000000000000FFFFFFFF00EDED323232323232323232320000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00005D00EDED3232323232323232323232
            000000FFFFFFFFFFFFFFFFFFFF00000707075D00EDED32323232323232323232
            3232320000000000000000000007FFFF0707070000EDED323232323232323232
            323232323232323232323232320007FFFF0700000000EDED3232323232323232
            323232323232323232323232323200000000F100000000EDED32323232323232
            32323232323232323232323232323200F0EDF0F100000000EDED323232323232
            3232323232323232323232323232323200F0EDF0F100000000ED323232323232
            323232323232323232323232323232323200F0EDF0F100000000323232323232
            32323232323232323232323232323232323200F0EDF0F1000000323232323232
            3232323232323232323232323232323232323200F0EDF0F10000323232323232
            323232323232323232323232323232323232323200F0EDF0F100323232323232
            3232323232323232323232323232323232323232320000000032323232323232
            3232323232323232323232323232323232323232323232323232}
        end
        object Panel3: TPanel
          Left = 2
          Top = 133
          Width = 579
          Height = 199
          BevelOuter = bvNone
          Color = 14789952
          TabOrder = 4
          object grGUs: ThGrid
            Tag = 1
            Left = 1
            Top = 1
            Width = 577
            Height = 197
            Selected.Strings = (
              'CODGUS'#9'13'#9'Código'
              'NOMGUS'#9'79'#9'Descrição'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            BorderStyle = bsNone
            Color = 16577773
            DataSource = dsGus
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = False
            IndicatorColor = icYellow
            CorDeFoco = clInfoBk
          end
        end
        object EdPsqNomGUs: TdxColorEdit
          Left = 78
          Top = 48
          Width = 286
          Color = 16577773
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
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
          CharCase = ecUpperCase
          CorDeFoco = clInfoBk
        end
      end
    end
    object pcPag2: TTabSheet
      Caption = '&Identificação'
      ImageIndex = 1
      OnShow = pcPag2Show
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 581
        Height = 358
        Align = alClient
        BevelOuter = bvNone
        Color = 15788249
        TabOrder = 0
        object Shape9: TShape
          Left = 1
          Top = 3
          Width = 172
          Height = 18
          Brush.Color = 14789952
          Pen.Color = 11764252
          Shape = stRoundRect
        end
        object Label5: TLabel
          Left = 5
          Top = 5
          Width = 129
          Height = 13
          Caption = 'Informações Principais'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Shape10: TShape
          Left = 174
          Top = 11
          Width = 407
          Height = 3
          Brush.Color = 11106843
          Pen.Color = 14789952
        end
        object Label7: TLabel
          Left = 3
          Top = 52
          Width = 53
          Height = 13
          Caption = 'Descrição :'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 3
          Top = 28
          Width = 40
          Height = 13
          Caption = 'Código :'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object EdNomGUs: TdxDBColorEdit
          Left = 78
          Top = 48
          Width = 505
          Color = 16577773
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
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
          CharCase = ecUpperCase
          DataField = 'NOMGUS'
          DataSource = dsGus
          CorDeFoco = clInfoBk
        end
        object EdCodGUs: TdxDBColorEdit
          Left = 78
          Top = 24
          Width = 96
          Color = 16577773
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Style.BorderColor = 14789952
          Style.BorderStyle = xbsSingle
          Style.ButtonStyle = btsSimple
          Style.ButtonTransparence = ebtInactive
          Style.HotTrack = True
          Style.Shadow = True
          TabOrder = 0
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          DataField = 'CODGUS'
          DataSource = dsGus
          CorDeFoco = clInfoBk
          StoredValues = 1
        end
      end
    end
  end
  object nvGUs: ThDBNavigator
    Left = 189
    Top = -6
    Width = 394
    Height = 31
    BevelOuter = bvNone
    Caption = ' '
    Color = 15788249
    TabOrder = 1
    DataSource = dsGus
    BaseAtualizar = 'CepTitFinPlcFinSubFinBanGerUfeCmpPed'
    Registros = 0
    UsaAppend = False
    Salvar = False
  end
  object GerGus: TwwQuery
    Active = True
    CachedUpdates = True
    BeforeDelete = GerGusBeforeDelete
    OnNewRecord = GerGusNewRecord
    DatabaseName = 'ISade'
    SessionName = 'Default'
    SQL.Strings = (
      'Select * from GerGus order by CodGus')
    UpdateObject = upGus
    ValidateWithMask = True
    Top = 387
    object GerGusCODGUS: TIntegerField
      DisplayLabel = 'Código'
      DisplayWidth = 13
      FieldName = 'CODGUS'
      Origin = 'ISADE.GERGUS.CODGUS'
    end
    object GerGusNOMGUS: TStringField
      DisplayLabel = 'Descrição'
      DisplayWidth = 79
      FieldName = 'NOMGUS'
      Origin = 'ISADE.GERGUS.NOMGUS'
      FixedChar = True
      Size = 40
    end
  end
  object dsGus: TwwDataSource
    AutoEdit = False
    DataSet = GerGus
    Left = 28
    Top = 387
  end
  object upGus: TUpdateSQL
    ModifySQL.Strings = (
      'update GerGus'
      'set'
      '  NOMGUS = :NOMGUS'
      'where'
      '  CODGUS = :OLD_CODGUS')
    InsertSQL.Strings = (
      'insert into GerGus'
      '  (CODGUS, NOMGUS)'
      'values'
      '  (:CODGUS, :NOMGUS)')
    DeleteSQL.Strings = (
      'delete from GerGus'
      'where'
      '  CODGUS = :OLD_CODGUS')
    Left = 28
    Top = 415
  end
  object quSql: TwwQuery
    Tag = 1
    CachedUpdates = True
    DatabaseName = 'ISade'
    ValidateWithMask = True
    Top = 415
  end
  object plOcoCr1: TppDBPipeline
    DataSource = dsGus
    UserName = 'plOcoCr1'
    Top = 443
    object plOcoCr1ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'CODGUS'
      FieldName = 'CODGUS'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 13
      Position = 0
    end
    object plOcoCr1ppField2: TppField
      FieldAlias = 'NOMGUS'
      FieldName = 'NOMGUS'
      FieldLength = 40
      DisplayWidth = 73
      Position = 1
    end
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = plOcoCr1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    Template.FileName = 'C:\_WGSYS\Sade\Modulo_Financeiro\Relatorios\RManGus.rtm'
    Units = utMillimeters
    UserName = 'Report'
    CachePages = True
    DeviceType = 'Screen'
    Left = 28
    Top = 443
    Version = '5.0'
    mmColumnWidth = 0
    object hbReport: TppHeaderBand
      BeforePrint = hbReportBeforePrint
      mmBottomOffset = 0
      mmHeight = 33073
      mmPrintPosition = 0
      object ppShape5: TppShape
        UserName = 'Shape5'
        Pen.Width = 2
        mmHeight = 20638
        mmLeft = 265
        mmTop = 265
        mmWidth = 197380
        BandType = 0
      end
      object ppImage1: TppImage
        UserName = 'Image1'
        MaintainAspectRatio = False
        mmHeight = 17992
        mmLeft = 1323
        mmTop = 1323
        mmWidth = 24342
        BandType = 0
      end
      object ppDesEmp4: TppLabel
        UserName = 'DesEmp4'
        Caption = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 26458
        mmTop = 14023
        mmWidth = 93134
        BandType = 0
      end
      object ppDesEmp3: TppLabel
        UserName = 'DesEmp3'
        Caption = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 26458
        mmTop = 9790
        mmWidth = 82550
        BandType = 0
      end
      object ppDesEmp2: TppLabel
        UserName = 'DesEmp2'
        Caption = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 26458
        mmTop = 5556
        mmWidth = 65617
        BandType = 0
      end
      object ppDesEmp1: TppLabel
        UserName = 'DesEmp1'
        Caption = 'XXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 26458
        mmTop = 1323
        mmWidth = 21167
        BandType = 0
      end
      object QrTitulo: TppLabel
        UserName = 'QrTitulo'
        Caption = 'Grupo de Usuarios'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 83344
        mmTop = 21696
        mmWidth = 35983
        BandType = 0
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Pen.Width = 2
        Weight = 1.5
        mmHeight = 529
        mmLeft = 265
        mmTop = 26194
        mmWidth = 197115
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        AutoSize = False
        VarType = vtDateTime
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 156369
        mmTop = 14023
        mmWidth = 40217
        BandType = 0
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Pen.Width = 2
        Weight = 1.5
        mmHeight = 529
        mmLeft = 265
        mmTop = 32015
        mmWidth = 197115
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Código'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 265
        mmTop = 27517
        mmWidth = 12700
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Descrição'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 15875
        mmTop = 27517
        mmWidth = 19050
        BandType = 0
      end
    end
    object dbReport: TppDetailBand
      BeforePrint = dbReportBeforePrint
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object ppCodGus: TppLabel
        UserName = 'CodGus'
        Caption = 'XXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 265
        mmTop = 794
        mmWidth = 14817
        BandType = 4
      end
      object ppNomGus: TppLabel
        UserName = 'NomGus'
        Caption = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 15875
        mmTop = 794
        mmWidth = 84667
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 6879
      mmPrintPosition = 0
      object ppShape2: TppShape
        UserName = 'Shape2'
        Pen.Width = 2
        mmHeight = 5821
        mmLeft = 0
        mmTop = 265
        mmWidth = 197644
        BandType = 8
      end
      object ppLabel29: TppLabel
        UserName = 'Label6'
        Caption = 'SADE CONSULTORIA E SISTEMAS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 1058
        mmTop = 1323
        mmWidth = 57150
        BandType = 8
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageNo
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 186002
        mmTop = 1323
        mmWidth = 10583
        BandType = 8
      end
      object ppLabel30: TppLabel
        UserName = 'Label30'
        Caption = 'Pag.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 176477
        mmTop = 1323
        mmWidth = 8467
        BandType = 8
      end
    end
  end
end
