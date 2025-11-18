unit ManLog;

interface

uses
  Windows, Messages, Dialogs, ComCtrls, SysUtils, Db, DBTables,
  StdCtrls, Mask, Controls, ExtCtrls, Classes, Buttons, Forms, hEdits,
  Wwquery, Graphics, AdvImage, dxCntner, dxEditor, dxEdLib, dxColorEdit;

type
  TfmManLog = class(TForm)
    quSql: TwwQuery;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    bConectar: TSpeedButton;
    bCancelar: TSpeedButton;
    Image1: TImage;
    EdUsuario: TdxColorEdit;
    EdSenha: TdxColorEdit;
    procedure FormCreate(Sender: TObject);
    procedure bConectarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdSenhaExit(Sender: TObject);
    procedure AcertaPadraoData;
  private
    {Private declarations}
  public
    {Public declarations}
    Cancelar: string;
  end;

var
  fmManLog: TfmManLog;

implementation

uses Encrypt, Bbgeral, Bbmensag, Bbacesso, Bbfuncao, ManGDB, ManPri;

{$R *.DFM}

{*************************************************************************
* Rotina: executa login
*************************************************************************}

procedure TfmManLog.bConectarClick(Sender: TObject);
var
  Senha: string;
  HreLog: string;
  DteLog: string;
  DataHora: TSystemTime;
  Data, Hora: TDateTime;
  Ano, Mes, Dia,
    H, M, S, Mil: Word;

  roleName: String;
begin
  GVerUsuario := 0;

  Application.ProcessMessages;

  roleName := fmManGDB.BuscaSimples('GERPAR','ROLENAME',' 1 = 1');

  if Trim(EdUsuario.Text) <> '' then
  begin

    Screen.Cursor := crHourglass;

    with fmManGDB.dbMain do

    try

      Connected := False;
      Params.Clear;

      Params.Add('BLOBS TO CACHE=-1');

      if Trim(GDirAce) <> '' then
        Params.Add('SERVER NAME=' + GDirAce);

      if Trim(UpperCase(EdUsuario.Text)) <> 'SUPORTE' then
      begin
        Params.Add('USER NAME=' + UpperCase(EdUsuario.Text));
      end
      else
        Params.Add('USER NAME=SYSDBA');

      Params.Add('PASSWORD=' + GuIdHal);

      if Trim(roleName) <> '' then
         Params.Add('ROLE NAME=' + Trim(roleName));

      Connected := True;

    except
      on E: Exception do
      begin
        fMsg(E.Message, 'E');
        EdUsuario.SetFocus;
      end;
    end;

    Screen.Cursor := crDefault;

    quSQL.DatabaseName := GDatabaseName;

    with quSql, SQL do
    begin

      Close;
      Text := ' Select * From GerUsu Where GerUsu.LogUsu = ' + QuotedStr(UpperCase(edUsuario.Text));
      Open;

    end;

    if quSql.FieldbyName('CodUsu').AsInteger > 0 then
    begin

      //fmManGDB.VGrupoUsu := StrToInt(FmMangdb.BuscaSimples('GerUsU', 'CodGus', ' CodUsu = ' + intToStr(QuSql.FieldByName('CodUsu').Value)));
      FmManGdb.VCODUSU := StrToInt(QuSql.FieldByName('CodUsu').AsString);
      Senha := IBPassword(PChar(EdSenha.Text));

      if Senha <> quSQL.FieldByName('SenUsu').AsString then
        fMsgErro('Senha Inválida', edSenha);

      GUsu_Sn := quSQL.FieldByName('SenUsu').AsString;
      GUsu_Nm := quSQL.FieldByName('LogUsu').AsString;
      GFlgGer := quSQL.FieldByName('FlgGer').AsString;
      GExiNot := quSQL.FieldByName('ExiNot').AsString;
      GUsu_Ema := quSQL.FieldByName('EmaUsu').AsString;
      GEmp_Id := quSQL.FieldByName('CodEmp').AsInteger;
      GUsu_Id := quSQL.FieldByName('CodUsu').AsInteger;
      GSup_Id := quSQL.FieldByName('CodSup').AsInteger;
      GGus_Id := quSQL.FieldByName('CodGUs').AsInteger;

      if Trim(quSQL.FieldByName('PrtUsu').AsString) <> '' then
        GFonUsu := '( ' + Trim(quSQL.FieldByName('PrtUsu').AsString) + ' ) ' + quSQL.FieldByName('FonUsu').AsString
      else
        GFonUsu := quSQL.FieldByName('FonUsu').AsString;

      if Trim(quSQL.FieldByName('PrfUsu').AsString) <> '' then
        GFaxUsu := '( ' + Trim(quSQL.FieldByName('PrfUsu').AsString) + ' ) ' + quSQL.FieldByName('FaxUsu').AsString
      else
        GFaxUsu := quSQL.FieldByName('FaxUsu').AsString;

      GCodVen_Id := quSQL.FieldByName('CodVen').AsInteger;
      GCodRep_Id := quSQL.FieldByName('CodRep').AsInteger;
      GCodAtd_Id := quSQL.FieldByName('CodAtd').AsInteger;

      with quSQL, SQL do
      begin

        Close;
        Text := ' Select Cast(' + QuotedStr('Today') + ' as Date) as DteSer From rdb$database';
        Open;

        DteLog := FieldbyName('DteSer').AsString;

        Close;
        Text := ' Select ExtrClock(Cast(Cast(' + QuotedStr('NOW') + ' as Date) as char(25))) as HreSer From rdb$database';
        Open;

        HreLog := Trim(FieldbyName('HreSer').AsString);

      end;

      Data := StrToDate(DteLog);
      Hora := StrToTime(HreLog);

      DecodeDate(Data, Ano, Mes, Dia);
      DecodeTime(Hora, H, M, S, Mil);

      with DataHora do
      begin

        wYear := Ano;
        wMonth := Mes;
        wDay := Dia;
        wHour := H;
        wMinute := M;
        wSecond := S;

        wMilliSeconds := Mil;

      end;

      //      SetLocalTime(DataHora);

      fmManPri.sbMain.Panels[2].Text := DateToStr(Date);

      AcertaPadraoData;

      if GFlgAce = 'Sim' then
      begin

        with quSQL, SQL do
        begin

          Close;
          Text := ' Select SEQIMP from GerPar';
          Open;

          GEmpLog := FieldbyName('SEQIMP').AsInteger;

        end;

      end
      else
        GEmpLog := 0;

      if GCodVen_Id > 0 then
      begin

        with quSql, SQl do
        begin

          Close;
          Text := ' Select FinVen.ApeVen,FinVen.CodClp From FinVen Where FinVen.CodVen = ' + QuotedStr(IntToStr(GCodVen_Id));
          Open;

          GNomVen_Id := FieldbyName('ApeVen').AsString;
          GCodClp_Id := FieldbyName('CodClp').AsString;

        end;
      end;

      if GCodRep_Id > 0 then
      begin

        with quSql, SQl do
        begin

          Close;
          Text := ' Select FinRep.ApeRep From FinRep Where FinRep.CodVen = ' + QuotedStr(IntToStr(GCodVen_Id)) + ' and FinRep.CodRep = ' +
            QuotedStr(IntToStr(GCodRep_Id));
          Open;

          GNomRep_Id := FieldbyName('ApeRep').AsString;

        end;
      end;

      if GCodAtd_Id > 0 then
      begin

        with quSql, SQl do
        begin

          Close;
          Text := ' Select FinAtd.ApeAtd From FinAtd Where FinAtd.CodAtd = ' + QuotedStr(IntToStr(GCodAtd_Id));
          Open;

          GNomAtd_Id := FieldbyName('ApeAtd').AsString;

        end;
      end;

      if GEmp_Id > 0 then
      begin

        with quSql, SQL do
        begin

          Close;
          Text := ' Select * From GerEmp Where GerEmp.CodEmp = ' + QuotedStr(IntToStr(GEmp_Id));
          Open;

        end;

        if quSQL.FieldbyName('CodEmp').AsInteger > 0 then
        begin

          GInsEmp := quSQL.FieldbyName('InsEmp').AsString;
          GApeEmp := quSQL.FieldbyName('ApeEmp').AsString;
          GRazEmp := quSQL.FieldbyName('NomEmp').AsString;
          GWebEmp := quSQL.FieldbyName('WebEmp').AsString;
          GEmaEmp := quSQL.FieldbyName('EmaEmp').AsString;

          GCgcEmp := fFormatCgcCPF(quSQL.FieldbyName('CgcEmp').AsString);

          if quSQL.FieldbyName('Id_FinPai').AsInteger > 0 then
            GId_FinPai := quSQL.FieldbyName('Id_FinPai').AsInteger;

          if Trim(quSQL.FieldbyName('CepEmp').AsString) <> '' then
            GCepEmp := copy(quSQL.FieldbyName('CepEmp').AsString, 1, 5) + '-' + copy(quSQL.FieldbyName('CepEmp').AsString, 6, 3)
          else
            GCepEmp := ' ';

          if Trim(quSQL.FieldbyName('TenEmp').AsString) <> '' then
            GEndEmp := Trim(quSQL.FieldbyName('TenEmp').AsString) + ' ' + Trim(quSQL.FieldbyName('EndEmp').AsString)
          else
            GEndEmp := Trim(quSQL.FieldbyName('EndEmp').AsString);

          if Trim(quSQL.FieldbyName('NumEmp').AsString) <> '' then
            GEndEmp := GEndEmp + ',' + Trim(quSQL.FieldbyName('NumEmp').AsString) + ' - ' + Trim(quSQL.FieldbyName('BaiEmp').AsString)
          else
            GEndEmp := GEndEmp + ' - ' + Trim(quSQL.FieldbyName('BaiEmp').AsString);

          GCidEmp := quSQL.FieldbyName('CidEmp').AsString;
          GUfeEmp := quSQL.FieldbyName('SigUfe').AsString;
          GRefEmp := quSQL.FieldbyName('CidEmp').AsString + ' - ' +
            quSQL.FieldbyName('SigUfe').AsString + ' CEP ';

          if quSQL.FieldByName('CepEmp').AsString <> '' then
            GRefEmp := GRefEmp + copy(quSQL.FieldByName('CepEmp').AsString, 1, 5) + '-' +
              copy(quSQL.FieldByName('CepEmp').AsString, 6, 3);

          if Trim(quSQL.FieldbyName('PrtEmp').AsString) <> '' then
            GFonEmp := '(' + Trim(quSQL.FieldbyName('PrtEmp').AsString) + ') ' + quSQL.FieldbyName('FonEmp').AsString
          else
            GFonEmp := quSQL.FieldbyName('FonEmp').AsString;

          if Trim(quSQL.FieldbyName('PrfEmp').AsString) <> '' then
            GFaxEmp := '(' + Trim(quSQL.FieldbyName('PrfEmp').AsString) + ') ' + quSQL.FieldbyName('FaxEmp').AsString
          else
            GFaxEmp := quSQL.FieldbyName('FaxEmp').AsString;

        end;

      end
      else
      begin

        GApeEmp := '';
        GRazEmp := '';
        GEndEmp := '';
        GCidEmp := '';
        GUfeEmp := '';
        GRefEmp := '';
        GFonEmp := '';
        GFaxEmp := '';

      end;

      close;
    end

    else
      fMsgErro('Usuário Não Cadastrado', EdUsuario);

  end
  else
    fMsgErro('Usuário Não Informado', edUsuario);
end;

procedure TfmManLog.bCancelarClick(Sender: TObject);
begin
  Cancelar := 'S';
  Application.Terminate;
end;

procedure TfmManLog.FormCreate(Sender: TObject);
var
  pCor: TColor;
  r, Lqtd: integer;
  LCor, Linha: string;
  ArqTexto: TStringList;
begin

  try
    Image1.Picture.LoadFromFile(GLogar);
  except
    Image1.Picture.LoadFromFile('');
  end;

  if FileExists('C:\Emerion\Config.ini') then
  begin

    ArqTexto := TStringList.Create;
    ArqTexto.LoadFromFile('C:\Emerion\Config.ini');

    Lqtd := ArqTexto.Count - 1;

    r := 0;

    while r <= Lqtd do
    begin

      Linha := ArqTexto[r];

      if pos('color', Linha) > 0 then
      begin

        LCor := copy(Linha, pos('=', Linha) + 1, 20);

        r := Lqtd;

      end;

      Inc(r);

    end;

    FreeAndNil(ArqTexto);

    pCor := clAqua;

    if UpperCase(LCor) = 'CLAQUA' then
      pCor := clAqua;
    if UpperCase(LCor) = 'CLBLACK' then
      pCor := clBlack;
    if UpperCase(LCor) = 'CLBLUE' then
      pCor := clBlue;
    if UpperCase(LCor) = 'CLDKGRAY' then
      pCor := clDkGray;
    if UpperCase(LCor) = 'CLFUCHSIA' then
      pCor := clFuchsia;
    if UpperCase(LCor) = 'CLGRAY' then
      pCor := clGray;
    if UpperCase(LCor) = 'CLGREEN' then
      pCor := clGreen;
    if UpperCase(LCor) = 'CLLIME' then
      pCor := clLime;
    if UpperCase(LCor) = 'cLLTGRAY' then
      pCor := clLtGray;
    if UpperCase(LCor) = 'CLMAROON' then
      pCor := clMaroon;
    if UpperCase(LCor) = 'CLNAVY' then
      pCor := clNavy;
    if UpperCase(LCor) = 'CLOLIVE' then
      pCor := clOlive;
    if UpperCase(LCor) = 'CLPURPLE' then
      pCor := clPurple;
    if UpperCase(LCor) = 'CLRED' then
      pCor := clRed;
    if UpperCase(LCor) = 'CLSILVER' then
      pCor := clSilver;
    if UpperCase(LCor) = 'CLTEAL' then
      pCor := clTeal;
    if UpperCase(LCor) = 'CLWHITE' then
      pCor := clWhite;
    if UpperCase(LCor) = 'CLYELLOW' then
      pCor := clYellow;

    Label1.Font.Color := pCor;
    Label2.Font.Color := pCor;
    Label3.Font.Color := pCor;

    bConectar.Font.Color := pCor;
    bCancelar.Font.Color := pCor;

  end;

  Cancelar := 'N';

end;

procedure TfmManLog.EdSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //  if (key = 13) or (key = 40) then bConectar.OnClick(Sender);
end;

procedure TfmManLog.FormShow(Sender: TObject);
var
  cForm: TComponent;
begin
  cForm := FindComponent('fmManLog');

  if (cForm <> nil) then
  begin

    TForm(cForm).WindowState := wsNormal;
    TForm(cForm).BringToFront;

  end;
end;

procedure TfmManLog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 40) or (key = 38) then
  begin

    if key = 40 then
      Perform(Wm_NextDlgCtl, 0, 0)
    else
      Perform(Wm_NextDlgCtl, 1, 0);

  end
  else
  begin

    if key = 13 then
      Perform(Wm_NextDlgCtl, 0, 0)

  end;
end;

procedure TfmManLog.EdSenhaExit(Sender: TObject);
begin
  if Trim(EdSenha.Text) <> '' then
    bConectar.Click;
end;

procedure TfmManLog.AcertaPadraoData;
const
  arrShortDayNames: array[1..7] of string[03] = ('Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab');
  arrLongDayNames: array[1..7] of string[15] = ('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');
  arrShortMonthNames: array[1..12] of string[03] = ('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez');
  arrLongMonthNames: array[1..12] of string[15] = ('Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro',
    'Novembro', 'Dezembro');
var
  ii: integer;
begin

  ShortDateFormat := 'dd/MM/yyyy';

  DecimalSeparator := ',';

  ThousandSeparator := '.';

  for ii := 1 to 7 do
  begin

    ShortDayNames[ii] := arrShortDayNames[ii];
    LongDayNames[ii] := arrLongDayNames[ii];

  end;

  for ii := 1 to 12 do
  begin

    ShortMonthNames[ii] := arrShortMonthNames[ii];
    LongMonthNames[ii] := arrLongMonthNames[ii];

  end;
end;

end.
