unit ManTUs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Wwquery, dxCntner, dxEditor, dxEdLib, dxColorEdit, Buttons,
  StdCtrls, ExtCtrls;

{,
Db, Grids, Wwdbigrd, Wwdbgrid, hGrid, DBTables, ExtCtrls,
hNavigator, Wwdatsrc, Wwquery, StdCtrls, Buttons, wwdblook, Mask,
DBCtrls, hEdits, ppBands, ppClass, ppCtrls, ppVar, ppPrnabl, ppDB,
ppProd, ppReport, ppComm, ppRelatv, ppCache, ppDBPipe, AdvImage, Fpadrao,
dxCntner, dxEditor, dxEdLib, dxColorEdit}

type
  TfmManTUs = class(TForm)
    quSql: TwwQuery;
    Image1: TImage;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EdSenha: TdxColorEdit;
    EdUsuario: TdxColorEdit;
    bConectar: TSpeedButton;
    bCancelar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure bConectarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var
  fmManTUs: TfmManTUs;

implementation

uses Encrypt, Bbgeral, Bbmensag, Bbacesso, Bbfuncao, ManGDB;

{$R *.DFM}

{*************************************************************************
* Rotina: executa login
*************************************************************************}

procedure TfmManTUs.bConectarClick(Sender: TObject);
var
  Senha: string;
begin
  fmManGDB.dbMain.Connected := False;
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
        Params.Add('USER NAME=' + UpperCase(EdUsuario.Text))
      else
        Params.Add('USER NAME=SYSDBA');

      Params.Add('PASSWORD=ibsade2002');
      Params.Add('PASSWORD=' + GuIdHal);
      ;

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
      Senha := IBPassword(PChar(EdSenha.Text));
      //fmManGDB.VGrupoUsu := StrToInt(FmMangdb.BuscaSimples('GerUsU', 'CodGus', ' CodUsu = ' + intToStr(QuSql.FieldByName('CodUsu').Value)));

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

          GCgcEmp := copy(quSQL.FieldbyName('CgcEmp').AsString, 01, 2) + '.' +
            copy(quSQL.FieldbyName('CgcEmp').AsString, 03, 3) + '.' +
            copy(quSQL.FieldbyName('CgcEmp').AsString, 06, 3) + '/' +
            copy(quSQL.FieldbyName('CgcEmp').AsString, 09, 4) + '-' +
            copy(quSQL.FieldbyName('CgcEmp').AsString, 13, 2);

          GInsEmp := quSQL.FieldbyName('InsEmp').AsString;
          GApeEmp := quSQL.FieldbyName('ApeEmp').AsString;
          GRazEmp := quSQL.FieldbyName('NomEmp').AsString;
          GWebEmp := quSQL.FieldbyName('WebEmp').AsString;
          GEmaEmp := quSQL.FieldbyName('EmaEmp').AsString;

          //              if quSQL.FieldbyName('Id_FinPai').AsInteger > 0 then GId_FinPai := quSQL.FieldbyName('Id_FinPai').AsInteger;

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
            GFonEmp := Trim(quSQL.FieldbyName('PrtEmp').AsString) + ' ' + quSQL.FieldbyName('FonEmp').AsString
          else
            GFonEmp := quSQL.FieldbyName('FonEmp').AsString;

          if Trim(quSQL.FieldbyName('PrfEmp').AsString) <> '' then
            GFaxEmp := Trim(quSQL.FieldbyName('PrfEmp').AsString) + ' ' + quSQL.FieldbyName('FaxEmp').AsString
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

procedure TfmManTUs.bCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfmManTUs.FormCreate(Sender: TObject);
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
end;

procedure TfmManTUs.edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 13) or (key = 40) then
    bConectar.OnClick(Sender);
end;

procedure TfmManTUs.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

end.
