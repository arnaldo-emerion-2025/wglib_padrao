unit ManGDB;

interface

uses
  Windows, Dialogs, SysUtils, Classes, Controls, Forms, Db,
  Bbacesso, FileCtrl, Wwquery, inifiles, RDprint, bbfuncao, Printers, WinSpool, ClipBrd,
  Wwdatsrc, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  ScktComp, ExtCtrls, buttons, ShellApi, DBTables, DBClient, Provider,
  Menus;



type
  TfmManGDB = class(TDataModule)
    dbMain: TDatabase;
    quMan: TwwQuery;
    quBusca: TwwQuery;
    DBEmerion1: TDatabase;
    dbEmerion2: TDatabase;
    REPLIC_CATEGORIAS: TStoredProc;
    ATUALIZA_REGRAS: TStoredProc;
    REPLICA_PRODUTOS: TStoredProc;
    REPLIC_IPI: TStoredProc;
    REPLIC_ICM: TStoredProc;
    REPLIC_ESTSTR: TStoredProc;
    REPLIC_ESTTME: TStoredProc;
    REPLIC_TEXTOFISCAL: TStoredProc;
    REPLIC_FINTCL: TStoredProc;
    REPLIC_GERUFE: TStoredProc;
    Replica_tipoEmbalagem: TStoredProc;
    REPLIC_NCM: TStoredProc;
    REPLIC_ST1: TStoredProc;
    REPLIC_ST2: TStoredProc;
    REPLIC_UNIDADE: TStoredProc;
    REPLIC_MARCA: TStoredProc;
    REPLIC_GRUPO: TStoredProc;
    REPLIC_SUBGRUPO: TStoredProc;
    REPLIC_TIPOITENS: TStoredProc;
    REPLIC_ESTUFE: TStoredProc;
    dsCOF: TwwDataSource;
    SQLCOF: TwwQuery;
    SQLCOFSIGNFE: TStringField;
    SQLCOFNOMCOF: TStringField;
    SQLCOFCODNOM: TStringField;
    dsPIS: TwwDataSource;
    SQLPIS: TwwQuery;
    SQLPISSIGNFE: TStringField;
    SQLPISNOMPIS: TStringField;
    SQLPISCODNOM: TStringField;
    dsIPI: TwwDataSource;
    SQLIPI: TwwQuery;
    SQLIPISIGNFE: TStringField;
    SQLIPINOMSIP: TStringField;
    SQLIPICODNOM: TStringField;
    DSst2: TwwDataSource;
    SQLST2: TwwQuery;
    SQLST2CODST2: TStringField;
    SQLST2NOMST2: TStringField;
    SQLST2CODNOM: TStringField;
    quSQL: TwwQuery;
    REPLIC_ESTITE: TStoredProc;
    CliSocket: TClientSocket;
    TimeSocket: TTimer;
    REPLIC_ESTBAR: TStoredProc;
    REPLIC_ESTEMB: TStoredProc;
    MainMenu1: TMainMenu;

    procedure OnModuleCreate(Sender: TObject);
    procedure dbMainBeforeConnect(Sender: TObject);
    procedure DadosEmpresa(id: integer);
    function BuscaSimples(Tabela, Retorna, _and: string; Sel: string = ''): string;
    function BuscaSimplesInt(Tabela, Retorna, _and: string; Sel: string = ''): Integer;

    function MasterGuIdHal: string;
    function AtuIPI_ICMS_ST(OriDB, DestDB: TDatabase): Boolean;
    function ImpressoraPadraoMatricial: Boolean;
    
    procedure AtualizaRegras(CodClp, Codgru, CodSub, CodPro: string);

    procedure CarregaCboICMS(SN: Boolean; Libera: string = 'B');
    procedure CarregaCboPIS;
    procedure CarregaCboCOF;
    procedure CarregaCboIPI(EntSad: string = 'Saida');
    function retornaCaminho(alias: string): string;
    procedure dbMainAfterConnect(Sender: TObject);
    procedure TimeSocketTimer(Sender: TObject);
    procedure CliSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure CarregaCboUnd(strCbo: TStrings);

    function applyUpdates(tQuery: TwwQuery): Boolean;
    function applyUpdatesQuery(tQuery: TQuery): Boolean;

  private
    {Private declarations}
    strIPServNFe, strPortaServNFe: string; //vari�veis para ServNFe
    CaminhoXml, CaminhoDanfe, CaminhoRetorno: string;

    procedure CarregaSOCKET;
    procedure CarregaIni;

  public
    sCabe: string;
    VCODUSU: integer; {Public declarations}
    VGrupoUsu: Integer;
    function NotaExiste(nronfs: string): Boolean;
    procedure carregaLoginTxt();
  end;

var
  fmManGDB: TfmManGDB;
  gPsqNumPed: string;
  GFlgImp: string;
  GEmail: string;
  GAssunto: string;
  GDirAce: string; {Caminho para Acesso ao Banco de Dados}
  GDirUsu: string; {Caminho para Acesso ao Banco de Dados}
  GApeAce: string; {Apelido do Acesso Realizado}
  GFlgCod: string;
  GArquivo: string;
  GLibAce: string;
  GDataLimite: TDateTime; {Data Limite para Utiliza��o do Software}
  GParLib: string;
  GFprm: string; {Permiss�o do usu�rio ativo na transa��o selecionada}
  GExiFor: string;
  GExiCli: string;
  GExiCom: string;
  GDlog: TDateTime; {Data / hora de login}
  GModu: TModulos; {M�dulos habilitados para uso}
  GUsu_Id: integer; {Usu�rio ativo}
  GsCodCli: integer;
  GUsu_Sn: string; {Senha do Usuario ativo}
  GGus_Id: integer; {Grupo de Usuario ativo}
  GCodCli: integer;
  GSup_Id: integer;
  GCodUsu: string; {Usu�rio ativo}
  GFonUsu: string;
  GFaxUsu: string;
  GFlgGer: string;
  GParamStr: string;
  GuIdHal: string;
  GEmp_Id: integer; {Empresa ativa}
  GUsu_Nm: string; {login do Usu�rio Ativo}
  GUsu_Ema: string; {Email do Usuario}
  GTemp: string[40]; {Diret�rio para grava��o de arquivos tempor�rios}
  GCtr_bai, Tecla: string; {Controle da baixa}
  GCgcEmp, GInsEmp, GApeEmp, GRazEmp, GEndEmp, GCidEmp, GUfeEmp, GRefEmp, GFonEmp, GFaxEmp, GCepEmp, GWebEmp, GEmaEmp: string;
  GId_FinUfe: integer;
  GId_FinCie: string;
  GnNavig: Integer; {Quantidade navigator}
  GTmpLog: Integer; {Tempo limite para inatividade do Sistema}
  GTmpVer: Integer; {Tempo limite para inatividade do Sistema}
  GExiNot: string; {Se o Usuario esta ou nao habilitado a Receber Mensagens de Notifica��es em Projeto}
  GDSNavig: string; {Primeiro navigator - Data source correspondente}
  GVerUsuario: integer; {Verificar se o formulario de Autentica��o de Usuario ja esta aberto}
  GCodVen_Id: integer; {Se Usu�rio Logado Possui C�digo de Vendedor Ativo}
  GCodRep_Id: integer; {Se Usu�rio Logado Possui C�digo de Preposto Ativo}
  GCodAtd_Id: integer; {Se Usu�rio Logado Possui C�digo de Atendente Ativo}
  GNomVen_Id: string; {Nome do Vendedor Ativo}
  GNomRep_Id: string; {Nome do Preposto Ativo}
  GCodClp_Id: string; {Tipo de Linha de Produto que poder trabalhar o Vendedor}
  GNomAtd_Id: string; {Nome do Atendente Ativo}
  GQtdReg: integer; {Quantidade de Registros que o Software pode Inserir por Tabela}
  GModAce: string; {Modulo que esta Sendo Acessado}
  GFlgAce: string; {Flag se o Usuario tem Acesso Restrito as Empresas Filiais}
  GEmpLog: integer;
  GBaseName: string;
  RetornoImpressora, TrataRetornoImp: string;
  TentaImp: Boolean;

  Nome_ArqReq1, Nome_ArqReq2, Nome_ArqRes1, Nome_ArqRes2: string;

  Gcx_Emp, Gcx_Cai, Gcx_Ope, Gcx_Sup: integer; {Informa��es de Usu�rios Operadores de Caixas}

  GError: string;
  sConectar: string;

  GId_FinPai: integer;

  Gcx_Id_LojCai: integer;
  Gcx_Id_LojOpe: integer;
  Gcx_Id_LojAbe: integer;

  Gcx_SeqAbe: integer; {Sequencia de Abertura do Caixa}
  Gcx_DteAbe: TDateTime; {Data de Abertura do Caixa}

  GNFeEnvia: string;

  GCodEmpCodUsuServ: string;

  roleName, fireBird: string; {nome da role Atribuida e vers�o correntdo Firebird}

const

  GEntrar = 'c:\Emerion\splash.bmp';
  GAnimar = 'c:\Emerion\animar.gif';
  GLogar = 'c:\Emerion\login.bmp';
  GImprimir = 'c:\Emerion\print.bmp';
  GDatabaseName = 'ISade'; {Database de conex�o}
  GMensagem = 'Aten��o. Ocorreu um problema em rela��o ao licenciamento do sistema. Por favor entre em contato com o suporte tecnico.';
  GMensagem_0001 = 'Aten��o. Ocorreu um problema em rela��o ao licenciamento do sistema. Por favor entre em contato com o suporte tecnico.';
  GMensagem_0002 = 'Usuario n�o possui acesso a opc�o.';
  _BR = #13#10;

implementation

uses Bbmensag, Bbgeral, ManPri, VerUsu;

{$R *.DFM}

function TfmManGDB.NotaExiste(nronfs: string): Boolean;
var
  temp: TQuery;
  mensagem: string;
begin
  temp := TQuery.Create(Self);
  temp.SQl.Text := ' select nronfs, ' + QuotedStr('1') + ' tab from fatped where flgnfe = ' + QuotedStr('Sim') + ' and nronfs = ' + nronfs + //
  ' union ' + //
  ' select nronfs, ' + QuotedStr('2') + ' tab from fatger where flgnfe = ' + QuotedStr('Sim') + ' and nronfs = ' + nronfs + //
  ' union ' + //
  ' select cast(coalesce(nronfs, 0) as integer) nronfs, ' + QuotedStr('3') + ' tab from lojped where nronfs = ' + nronfs;
  temp.ExecSQL;
  temp.Last;
  temp.First;
  if temp.RecordCount > 0 then
  begin
    mensagem := 'Nota j� utilizada em ';
    case temp.FieldByName('TAB').AsInteger of
      1:
        begin
          mensagem := mensagem + 'nota de venda.';
        end;

      2:
        begin
          mensagem := mensagem + 'outros tipos de nota.';
        end;

      3:
        begin
          mensagem := mensagem + 'notas do loja.';
        end;
    end;
    showMessage(mensagem);
    Result := True;
  end
  else
    Result := False;
end;

function TfmManGDB.MasterGuIdHal: string;
var
  aux : Integer;
begin
  Result := '';
  Result := 'ibsade20';
  for aux := 0 to 1 do
     begin
      if (ParamStr(aux) = 'senhaNova') then
       Result := 'FgB@8165';
     end;
end;

function TfmManGDB.BuscaSimples(Tabela, Retorna, _and: string; Sel: string = ''): string;
begin
  Result := '';

  if sel = '' then
  begin
    if (trim(Tabela) <> '') and (trim(_and) <> '') and (trim(Retorna) <> '') then
    begin

      quBusca.Active := False;
      quBusca.SQL.Text := ' select ' + Retorna + ' From ' + Tabela + ' Where 1 = 1 and ' + _and;
      quBusca.Active := True;

      if not quBusca.IsEmpty then
      begin

        if      quBusca.Fields[0] is TDateTimeField then Result := FormatDateTime('dd/mm/yyyy', quBusca.Fields[0].AsDateTime)
        else if quBusca.Fields[0] is TFloatField    then Result := FormatFloat('0.00', quBusca.Fields[0].AsFloat)
        else if quBusca.Fields[0] is TIntegerField  then Result := FormatFloat('0', quBusca.Fields[0].AsInteger)
        else                                             Result := quBusca.Fields[0].AsString;

        quBusca.Active := False;
      end;
    end;
  end
  else
  begin
    quBusca.Active := False;
    quBusca.SQL.Text := Sel;
    quBusca.Active := True;

    if not quBusca.IsEmpty then
    begin

      if      quBusca.Fields[0] is TDateTimeField then Result := FormatDateTime('dd/mm/yyyy', quBusca.Fields[0].AsDateTime)
      else if quBusca.Fields[0] is TFloatField    then Result := FormatFloat('0.00', quBusca.Fields[0].AsFloat)
      else if quBusca.Fields[0] is TIntegerField  then Result := FormatFloat('0', quBusca.Fields[0].AsInteger)
      else                                             Result := quBusca.Fields[0].AsString;

      quBusca.Active := False;
    end;
  end;

end;

function TfmManGDB.BuscaSimplesInt(Tabela, Retorna, _and: string; Sel: string = ''): Integer;
begin
  Result := 0;

  if sel = '' then
  begin
    if (trim(Tabela) <> '') and (trim(_and) <> '') and (trim(Retorna) <> '') then
    begin
      quBusca.Active := False;
      quBusca.SQL.Text := ' select ' + Retorna + ' From ' + Tabela + ' Where 1 = 1 and ' + _and;
      quBusca.Active := True;

      if not quBusca.IsEmpty then
      begin
        Result := quBusca.Fields[0].AsInteger;
      end
      else
        Result := 0;

      quBusca.Active := False;

    end;
  end
  else
  begin
    quBusca.Active := False;
    quBusca.SQL.Text := Sel;
    quBusca.Active := True;

    if not quBusca.IsEmpty then
    begin
      Result := quBusca.Fields[0].AsInteger;
    end
    else
      Result := 0;

    quBusca.Active := False;

  end;

end;

procedure TfmManGDB.DadosEmpresa(id: integer);
begin

  quMan.Active := False;
  quMan.SQL.Text := ' Select * From GerEmp Where GerEmp.CodEmp = ' + (IntToStr(id));
  quMan.Active := True;

  if quMan.FieldbyName('CodEmp').AsInteger > 0 then
  begin

    GInsEmp := quMan.FieldbyName('InsEmp').AsString;
    GApeEmp := quMan.FieldbyName('ApeEmp').AsString;
    GRazEmp := quMan.FieldbyName('NomEmp').AsString;
    GWebEmp := quMan.FieldbyName('WebEmp').AsString;
    GEmaEmp := quMan.FieldbyName('EmaEmp').AsString;

    GCgcEmp := fFormatCgcCPF(quMan.FieldbyName('CgcEmp').AsString);

    if quMan.FieldbyName('Id_FinPai').AsInteger > 0 then
      GId_FinPai := quMan.FieldbyName('Id_FinPai').AsInteger;

    if Trim(quMan.FieldbyName('CepEmp').AsString) <> '' then
      GCepEmp := copy(quMan.FieldbyName('CepEmp').AsString, 1, 5) + '-' + copy(quMan.FieldbyName('CepEmp').AsString, 6, 3)
    else
      GCepEmp := ' ';

    if Trim(quMan.FieldbyName('TenEmp').AsString) <> '' then
      GEndEmp := Trim(quMan.FieldbyName('TenEmp').AsString) + ' ' + Trim(quMan.FieldbyName('EndEmp').AsString)
    else
      GEndEmp := Trim(quMan.FieldbyName('EndEmp').AsString);

    if Trim(quMan.FieldbyName('NumEmp').AsString) <> '' then
      GEndEmp := GEndEmp + ',' + Trim(quMan.FieldbyName('NumEmp').AsString) + ' - ' + Trim(quMan.FieldbyName('BaiEmp').AsString)
    else
      GEndEmp := GEndEmp + ' - ' + Trim(quMan.FieldbyName('BaiEmp').AsString);

    GCidEmp := quMan.FieldbyName('CidEmp').AsString;
    GUfeEmp := quMan.FieldbyName('SigUfe').AsString;
    GRefEmp := quMan.FieldbyName('CidEmp').AsString + ' - ' +
      quMan.FieldbyName('SigUfe').AsString + ' CEP ';

    if quMan.FieldByName('CepEmp').AsString <> '' then
      GRefEmp := GRefEmp + copy(quMan.FieldByName('CepEmp').AsString, 1, 5) + '-' +
        copy(quMan.FieldByName('CepEmp').AsString, 6, 3);

    if Trim(quMan.FieldbyName('PrtEmp').AsString) <> '' then
      GFonEmp := '(' + Trim(quMan.FieldbyName('PrtEmp').AsString) + ') ' + quMan.FieldbyName('FonEmp').AsString
    else
      GFonEmp := quMan.FieldbyName('FonEmp').AsString;

    if Trim(quMan.FieldbyName('PrfEmp').AsString) <> '' then
      GFaxEmp := '(' + Trim(quMan.FieldbyName('PrfEmp').AsString) + ') ' + quMan.FieldbyName('FaxEmp').AsString
    else
      GFaxEmp := quMan.FieldbyName('FaxEmp').AsString;
  end;
end;

procedure TfmManGDB.OnModuleCreate(Sender: TObject);
var
  aux, i : Integer;
  NomDir, NomArq: String;
begin
  CarregaSOCKET;

  if (UpperCase(ExtractFileName(application.exename)) = 'EFATURA.EXE..')
    or (UpperCase(ExtractFileName(application.exename)) = 'EFRENTELOJA.EXE') then
  begin
    CarregaIni;
  end;

  GNFeEnvia := '';

  GuIdHal := MasterGuIdHal;

  if 1 = 2 then
  begin

    for i := 0 to 15 do
    begin

      if i = 0 then
        NomDir := 'PRIV\'
      else                                                                           
        NomDir := 'PRIV' + IntToStr(i) + '\';

      if DirectoryExists(ExtractFilePath(ParamStr(0)) + NomDir) then
      begin

        NomArq := 'Command.com /c Del ' + ExtractFilePath(Application.ExeName) + NomDir + '*.tmp';

        WinExec(PAnsiChar(NomArq), 0);

        NomArq := 'Command.com /c Del ' + ExtractFilePath(Application.ExeName) + NomDir + '*.DB';

        WinExec(PAnsiChar(NomArq), 0);

        NomArq := 'Command.com /c Del ' + ExtractFilePath(Application.ExeName) + NomDir + '*.MB';

        WinExec(PAnsiChar(NomArq), 0);

      end;
    end;

    if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'PRIV') or CreateDir(ExtractFilePath(ParamStr(0)) + 'PRIV') then
    begin

      for i := 0 to 15 do
      begin

        try

          if i = 0 then
          begin

            Session.PrivateDir := ExtractFilePath(ParamStr(0)) + 'PRIV';

            Exit;

          end
          else
          begin

            if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'PRIV' + IntToStr(i)) or CreateDir(ExtractFilePath(ParamStr(0)) + 'PRIV' + IntToStr(i)) then
              Session.PrivateDir := ExtractFilePath(ParamStr(0)) + 'PRIV' + IntToStr(i);

            Exit;

          end;

        except

        end;
      end;

    end
    else
      ShowMessage('Diretorio Privado n�o Pode ser Criado ' + ExtractFilePath(ParamStr(0)) + 'PRIV');

  end;

  if Session.isAlias('Emerion_01') then
  begin
    DBEmerion1.AliasName := 'Emerion_01';
    REPLIC_ESTITE.DatabaseName := 'Emerion_01';
    REPLICA_PRODUTOS.DatabaseName := 'Emerion_01';
    ATUALIZA_REGRAS.DatabaseName := 'Emerion_01';
    REPLIC_CATEGORIAS.DatabaseName := 'Emerion_01';
    REPLIC_ESTSTR.DatabaseName := 'Emerion_01';
    REPLIC_ESTTME.DatabaseName := 'Emerion_01';
    REPLIC_FINTCL.DatabaseName := 'Emerion_01';
    REPLIC_GERUFE.DatabaseName := 'Emerion_01';
    REPLIC_ICM.DatabaseName := 'Emerion_01';
    replic_ipi.DatabaseName := 'Emerion_01';
    REPLIC_TEXTOFISCAL.DatabaseName := 'Emerion_01';
    Replica_tipoEmbalagem.DatabaseName := 'Emerion_01';
    REPLIC_NCM.DatabaseName := 'Emerion_01';
    REPLIC_ST1.DatabaseName := 'Emerion_01';
    REPLIC_ST2.DatabaseName := 'Emerion_01';
    REPLIC_UNIDADE.DatabaseName := 'Emerion_01';
    REPLIC_MARCA.DatabaseName := 'Emerion_01';
    REPLIC_GRUPO.DatabaseName := 'Emerion_01';
    REPLIC_SUBGRUPO.DatabaseName := 'Emerion_01';
    REPLIC_TIPOITENS.DatabaseName := 'Emerion_01';
    REPLIC_ESTUFE.DatabaseName := 'Emerion_01';
    REPLIC_ESTBAR.DatabaseName := 'Emerion_01';
    REPLIC_ESTEMB.DatabaseName := 'Emerion_01';
  end;

{$IFDEF ClienteA}
  //TimeSocket.Enabled := True;
{$ENDIF}
  if Session.isAlias('Emerion_02') then
  begin
    DBEmerion2.AliasName := 'Emerion_02';

  end;

end;

procedure TfmManGDB.dbMainBeforeConnect(Sender: TObject);
var
  ApeLin: string;
  ApeAce: string;
  DirAce: string;
  DirUsu: string;
  LinAce: string;
  SeqLin, aux: integer;
  ArqTxt: TStringList;
begin
  if dbMain.Connected then
    dbMain.Close;

  dbMain.Params.Values['PASSWORD'] := MasterGuIdHal;
  dbMain.Params.Add('SQLDIALECT=3');

  if Trim(sConectar) = '' then
  begin

    sConectar := 'S';

    ApeLin := UpperCase(ParamStr(1));

    if (trim(ApeLin) <> '') then
    begin

      if fileExists(ExtractFilePath(Application.ExeName) + 'login.txt') then
      begin

        ArqTxt := TStringList.Create;

        ArqTxt.LoadFromFile(ExtractFilePath(Application.ExeName) + 'login.txt');

        SeqLin := 0;

        while SeqLin <= (ArqTxt.Count - 1) do
        begin

          LinAce := UpperCase(ArqTxt[SeqLin]);

          if pos(ApeLin, LinAce) > 0 then
          begin

            DirAce := copy(LinAce, pos('##', LinAce) + 2, 100);

            DirAce := copy(DirAce, 1, pos('@@', DirAce) - 1);

            ApeAce := copy(LinAce, pos('@@', LinAce) + 2, 100);

            if pos('@@', ApeAce) > 0 then
              ApeAce := copy(ApeAce, 1, pos('@@', ApeAce) - 1);

          end;

          Inc(SeqLin);

        end;

        GDirAce := LowerCase(Trim(DirAce));

        SeqLin := 0;

        while SeqLin <= (ArqTxt.Count - 1) do
        begin

          LinAce := UpperCase(ArqTxt[SeqLin]);

          if pos(ApeLin, LinAce) > 0 then
          begin
            DirUsu := copy(LinAce, pos('***', LinAce) + 3, 100);
            DirUsu := copy(DirUsu, 1, pos('***', DirUsu) - 1);
          end;

          Inc(SeqLin);

        end;

        if Trim(ApeAce) <> '' then
          GApeAce := ' [ ' + ApeAce + ' ] '
        else
          GApeAce := '';

        if dbMain.Connected then
          dbMain.Close;

        dbMain.Params.Clear;

        dbMain.Params.Add('SQLDIALECT=3');
        dbMain.Params.Add('BLOBS TO CACHE=-1');

        if Trim(GDirAce) <> '' then
          dbMain.Params.Add('SERVER NAME=' + GDirAce);

        dbMain.Params.Add('USER NAME=SYSDBA');

        if (Trim(roleName) <> '') then
          dbMain.Params.Add('ROLE NAME=' + roleName);

        FreeAndNil(ArqTxt);

        if (BuscaSimples('GERPAR', 'VER_FIREBIRD', ' 1=1') = '2.5') then
          GDirUsu := GDirAce;

        GDirUsu := LowerCase(DirUsu);

      end;
    end
    else
    begin
      if dbMain.Connected then
        dbMain.Close;
        dbMain.Params.Values['PASSWORD'] := MasterGuIdHal;
    end;
  end
end;

function TfmManGDB.AtuIPI_ICMS_ST(OriDB, DestDB: TDatabase): Boolean;
var
  SQLTemp: TwwQuery;
  strUFOri, strAtuOri, strUFDes, strAtuDes: string;
begin
  Result := True;
  SQLTemp := TwwQuery.Create(Self);

  try
    //Informa��es da empresa Origem
    SQLTemp.Active := False;
    SQLTemp.DatabaseName := OriDB.DatabaseName;
    SQLTemp.sql.Text := 'select geremp.sigufe from geremp where codemp = 1';
    SQLTemp.Active := True;
    strUFOri := SQLTemp.FieldByName('sigufe').AsString;

    SQLTemp.Active := False;
    SQLTemp.DatabaseName := OriDB.DatabaseName;
    SQLTemp.sql.Text := 'select ATU_REGRAS_DBS from estpar';
    SQLTemp.Active := True;
    strAtuOri := SQLTemp.FieldByName('ATU_REGRAS_DBS').AsString;

    //Informa��es da empresa Destino
    SQLTemp.Active := False;
    SQLTemp.DatabaseName := DestDB.DatabaseName;
    SQLTemp.sql.Text := 'select geremp.sigufe from geremp where codemp = 1';
    SQLTemp.Active := True;
    strUFDes := SQLTemp.FieldByName('sigufe').AsString;

    SQLTemp.Active := False;
    SQLTemp.DatabaseName := DestDB.DatabaseName;
    SQLTemp.sql.Text := 'select ATU_REGRAS_DBS from estpar';
    SQLTemp.Active := True;
    strAtuDes := SQLTemp.FieldByName('ATU_REGRAS_DBS').AsString;

    //Quando UFs diferentes verifica se destinat�rio aceita atualiza��o
    if strUFOri <> strUFDes then
      if strAtuDes <> 'Sim' then
        Result := False;

  finally
    FreeAndNil(SqlTemp);
  end;
  //
end;

function TfmManGDB.ImpressoraPadraoMatricial: Boolean;
begin
  Result := True;
end;

procedure TfmManGDB.AtualizaRegras(CodClp, Codgru, CodSub, CodPro: string);
var
  SQLProduto: TwwQuery;
begin

  try
    try
      DBEmerion1.StartTransaction;
      SQLProduto := TwwQuery.Create(Self);
      SQLProduto.DatabaseName := 'isade';
      SQLProduto.sql.Text := 'select * from estpro where codclp = ' + QuotedStr(codclp) + ' and codgru = ' + QuotedStr(codgru)
        + ' and codsub = ' + QuotedStr(codsub) + ' and codpro = ' + QuotedStr(codpro);
      SQLProduto.active := true;

      ATUALIZA_REGRAS.Params[0].value := SQLProduto.FieldByName('CODPRO').AsString;
      ATUALIZA_REGRAS.Params[1].value := SQLProduto.FieldByName('ICMSAI').AsString;
      ATUALIZA_REGRAS.Params[2].value := SQLProduto.FieldByName('ICMENT').AsString;
      ATUALIZA_REGRAS.Params[3].value := SQLProduto.FieldByName('IPISAI').AsString;
      ATUALIZA_REGRAS.Params[4].value := SQLProduto.FieldByName('IPIENT').AsString;
      ATUALIZA_REGRAS.Params[5].value := SQLProduto.FieldByName('CODSTS').AsString;
      ATUALIZA_REGRAS.Params[6].value := SQLProduto.FieldByName('CODSTE').AsString;
      ATUALIZA_REGRAS.Params[7].value := SQLProduto.FieldByName('SAIICM').Value;
      ATUALIZA_REGRAS.Params[8].value := SQLProduto.FieldByName('ENTICM').Value;
      ATUALIZA_REGRAS.Params[9].value := SQLProduto.FieldByName('SAIIPI').Value;
      ATUALIZA_REGRAS.Params[10].value := SQLProduto.FieldByName('ENTIPI').Value;
      ATUALIZA_REGRAS.Params[11].value := SQLProduto.FieldByName('CODST1').AsString;
      ATUALIZA_REGRAS.Params[12].value := SQLProduto.FieldByName('CODST2').AsString;
      ATUALIZA_REGRAS.Params[13].value := SQLProduto.FieldByName('CLFSAI').AsString;
      ATUALIZA_REGRAS.Params[14].value := SQLProduto.FieldByName('CLFENT').AsString;
      ATUALIZA_REGRAS.Params[15].value := SQLProduto.FieldByName('CODCLP').AsString;
      ATUALIZA_REGRAS.Params[16].value := SQLProduto.FieldByName('CODGRU').AsString;
      ATUALIZA_REGRAS.Params[17].value := SQLProduto.FieldByName('CODSUB').AsString;
      ATUALIZA_REGRAS.ExecProc;
      DBEmerion1.Commit;
    except
      DBEmerion1.Rollback;
      Fmsg('Regras n�o replicadas', 'I');
    end;
  finally
    FreeAndNil(SQLProduto);
  end;

end;

procedure TfmManGDB.CarregaCboCOF;
begin
  //st COF
  SQLCOF.Active := false;
  SQLCOF.sql.text := 'select signfe, nomcof, signfe ||'' - ''|| nomcof CodNom from estcof /*where cast(signfe as integer) < 100*/ order by signfe';
  SQLCOF.Active := True;
end;

procedure TfmManGDB.CarregaCboICMS(SN: Boolean; Libera: string = 'B');
begin
  //Libera : 'L' Permite todas as Situa��es cadastradas 'B' diferencia entre Regime normal e Simples Nacional

  //ST ICMS
  SQLST2.Active := false;
  if Libera = 'B' then
  begin
    //Diferencia Simples Nacional
    if SN then
    begin
      SQLST2.sql.text := 'select codst2, nomst2, codst2 ||'' - ''|| nomst2 CodNom from estst2 where cast(codst2 as integer) >= 100 order by codst2';
    end
    else
    begin
      SQLST2.sql.text := 'select codst2, nomst2, codst2 ||'' - ''|| nomst2 CodNom from estst2 where cast(codst2 as integer) < 100 order by codst2';
    end;
  end
  else
  begin
    SQLST2.sql.text := 'select codst2, nomst2, codst2 ||'' - ''|| nomst2 CodNom from estst2 order by cast(codst2 as integer) ';
  end;
  SQLST2.Active := True;
end;

procedure TfmManGDB.CarregaCboIPI(EntSad: string = 'Saida');
begin
  //st IPI
  SQLIPI.Active := false;
  //SQLIPI.sql.text := 'select signfe, nomsip, signfe ||'' - ''|| nomsip CodNom from estsip where tipsip = ' + QuotedStr(EntSad) + ' order by signfe';
  SQLIPI.sql.text := 'select signfe, nomsip, signfe ||'' - ''|| nomsip CodNom from estsip order by signfe';
  SQLIPI.Active := True;
end;

procedure TfmManGDB.CarregaCboPIS;
begin
  //st PIS
  SQLPIS.Active := false;
  SQLPIS.sql.text := 'select signfe, nompis, signfe ||'' - ''|| nompis CodNom from estpis';
  SQLPIS.Active := True;
end;

function TfmManGDB.retornaCaminho(alias: string): string;
var
  WAlias: TStringList;
  WServidor: string;
begin
  WAlias := TStringList.Create;
  Session.GetAliasParams(alias, WAlias);
  WServidor := WAlias[0];
  WServidor := Copy(WServidor, 13, 255);
  WServidor := Copy(WServidor, 1, (Length(WServidor)));
  result := WServidor;
end;

procedure TfmManGDB.dbMainAfterConnect(Sender: TObject);
begin
  roleName := BuscaSimples('GERPAR', 'ROLENAME', ' 1=1');
  firebird := BuscaSimples('GERPAR', 'VER_FIREBIRD', ' 1=1');
end;

procedure TfmManGDB.TimeSocketTimer(Sender: TObject);
begin
  CarregaSOCKET;
end;

procedure TfmManGDB.CliSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  lnConex: string;
  strComando, strPrograma, strParam1, strParam2: string;
  stDownLoad: TStream;
  intTam: integer;
  strBuf: string;
begin
  strComando := '';
  strParam1 := '';
  strParam2 := '';
  strPrograma := '';

  intTam := Socket.ReceiveLength;

  lnConex := Socket.ReceiveText;

  if lnConex <> '' then
  begin
    fmManPri.RetornoSocket(lnConex);
    if Trim(lnConex) <> '' then
    begin

      strPrograma := copy(lnConex, 1, pos('||', lnConex) - 1);
      delete(lnConex, 1, pos('||', lnConex) + 1);

      if Trim(lnConex) <> '' then
      begin
        strComando := (copy(lnConex, 1, pos('||', lnConex) - 1));
        delete(lnConex, 1, pos('||', lnConex) + 1);
      end;

      if Trim(lnConex) <> '' then
      begin
        strParam1 := (copy(lnConex, 1, pos('||', lnConex) - 1));
        delete(lnConex, 1, pos('||', lnConex) + 1);
      end;

      if Trim(lnConex) <> '' then
      begin
        strParam2 := (copy(lnConex, 1, pos('||', lnConex) - 1));
        delete(lnConex, 1, pos('||', lnConex) + 1);
      end;

      if (strPrograma = 'EFATURA') and (strComando = 'AQUI') then
      begin
        showmessage(strParam1);
      end;

      if (strPrograma = 'EFATURA') and (strComando = 'DANFE') then
      begin
        ShellExecute(0, nil, Pchar((strParam1)), '', '', SW_SHOWMAXIMIZED);
      end;

      if (strPrograma = 'EFATURA') and (strComando = 'DANFE_STREAM') then
      begin
        //strParam1
        if FileExists('ARQ.TMP.SERVER') then
        begin
          strParam1 := CaminhoDanfe + '\' + strParam1;
          CopyFile(pChar('ARQ.TMP.SERVER'), pChar(strParam1), true);
          DeleteFile('ARQ.TMP.SERVER');
          ShellExecute(0, nil, Pchar((strParam1)), '', '', SW_SHOWMAXIMIZED);
        end;
      end;

      if (strPrograma = 'EFATURA') and (strComando = 'XML_STREAM') then
      begin
        if FileExists('ARQ.TMP.SERVER') then
        begin
          strParam1 := CaminhoRetorno + '\' + strParam1;
          CopyFile(pChar('ARQ.TMP.SERVER'), pChar(strParam1), true);
          DeleteFile('ARQ.TMP.SERVER');
        end;
      end;

    end;
  end
  else if intTam > 0 then
  begin

    if FileExists('ARQ.TMP.SERVER') then
      DeleteFile('ARQ.TMP.SERVER');

    stDownLoad := TFileStream.Create('ARQ.TMP.SERVER', fmcreate);
    try

      while intTam > 0 do
      begin
        Socket.ReceiveBuf(strBuf, intTam);
        stDownLoad.Write(strBuf, intTam);
        Sleep(200);
        intTam := Socket.ReceiveLength;
      end;

    finally
      stDownLoad.Free;
    end;
  end;

end;

procedure TfmManGDB.CarregaSOCKET;
var
  ini: Tinifile;
  strPath: string;
begin

  if FileExists(strPath + 'config.ini') then
  begin
    CliSocket.Active := False;
    strPath := ExtractFilePath(application.ExeName);
    ini := TIniFile.Create(strPath + 'config.ini');

    try
      strIPServNFe := ini.ReadString('SERVNFE', 'IP', '127.0.01');
      strPortaServNFe := ini.ReadString('SERVNFE', 'PORTA', '62706');

    finally
      ini.Free;
    end;
    CliSocket.Address := strIPServNFe;

    if Length(trim(strPortaServNFe)) > 0 then
      CliSocket.Port := strtoint(strPortaServNFe);
  end
  else
  begin
    if DebugHook = 0 then
      messagebox(0, pchar('N�o foi encontrado arquivo CONFIG.INI. Favor verifique e tente novamente.'), 'Emerion', mb_ok + MB_ICONINFORMATION);

  end;

end;

procedure TfmManGDB.CarregaIni;
var
  inifile: string;
  ini: Tinifile;
begin

  if fileexists(ExtractFilePath(application.exename) + 'NFeEmerion2.ini') then
  begin
    inifile := ExtractFilePath(application.exename) + 'NFeEmerion2.ini';
    ini := Tinifile.create(Inifile);
    try
      CaminhoXml := ini.ReadString('Geral', 'PathXML', '');
      CaminhoDanfe := ini.ReadString('Geral', 'PathDanfe', '');
      CaminhoRetorno := ini.ReadString('Geral', 'PathRetorno', '');
    finally
      ini.free;
    end;
  end

end;

procedure TfmManGDB.CarregaCboUnd(strCbo: TStrings);
var
  SQLTEMP: TQuery;
begin
  SQLTEMP := TQuery.Create(nil);

  try
    SQLTEMP.DataBaseName := 'Isade';
    SQLTEMP.SQL.Text := ' select CODUND from estund order by CODUND ';
    SQLTEMP.Active := True;

    strCbo.Clear;

    SQLTEMP.First;

    while not SQLTEMP.Eof do
    begin
      strCbo.Add(trim(SQLTEMP.FieldByName('CODUND').AsString));

      SQLTEMP.Next;
    end;

  finally
    FreeAndnil(SQLTEMP);
  end;
end;

function TfmManGDB.applyUpdates(tQuery: TwwQuery): Boolean;
begin
  with TwwQuery(tQuery) do
  begin

    fmManGDB.dbMain.StartTransaction; {Inicia a Transa��o}

    try
      begin
        ApplyUpdates; {Tenta aplicar as altera��es}
        fmManGDB.dbMain.Commit; {confirma todas as altera��es fechando a transa��o}

        result := True;
      end;
    except
      begin
        fmManGDB.dbMain.Rollback; {desfaz as altera��es se acontecer um erro}

        if TwwQuery(tQuery).State <> dsBrowse then
          TwwQuery(tQuery).CancelUpdates;

        //grEn2.SetFocus;
        raise;

        result := False;
      end;
    end;

    CommitUpdates; {sucesso!, limpa o cache...}

  end;

end;

function TfmManGDB.applyUpdatesQuery(tQuery: TQuery): Boolean;
begin
  with TwwQuery(tQuery) do
  begin

    fmManGDB.dbMain.StartTransaction; {Inicia a Transa��o}

    try
      begin
        ApplyUpdates; {Tenta aplicar as altera��es}
        fmManGDB.dbMain.Commit; {confirma todas as altera��es fechando a transa��o}

        result := True;
      end;
    except
      begin
        fmManGDB.dbMain.Rollback; {desfaz as altera��es se acontecer um erro}

        if TwwQuery(tQuery).State <> dsBrowse then
          TwwQuery(tQuery).CancelUpdates;

        //grEn2.SetFocus;
        raise;

        result := False;
      end;
    end;

    CommitUpdates; {sucesso!, limpa o cache...}

  end;

end;

procedure TfmManGDB.carregaLoginTxt;
var
  ApeLin: string;
  ApeAce: string;
  DirAce: string;
  DirUsu: string;
  LinAce: string;
  SeqLin: integer;
  ArqTxt: TStringList;
begin
  if dbMain.Connected then
    dbMain.Close;

  dbMain.Params.Values['PASSWORD'] := MasterGuIdHal;

  if Trim(sConectar) = '' then
  begin

    sConectar := 'S';

    ApeLin := UpperCase(ParamStr(1));

    if (trim(ApeLin) <> '') then
    begin

      if fileExists(ExtractFilePath(Application.ExeName) + 'login.txt') then
      begin

        ArqTxt := TStringList.Create;

        ArqTxt.LoadFromFile(ExtractFilePath(Application.ExeName) + 'login.txt');

        SeqLin := 0;

        while SeqLin <= (ArqTxt.Count - 1) do
        begin

          LinAce := UpperCase(ArqTxt[SeqLin]);

          if pos(ApeLin, LinAce) > 0 then
          begin

            DirAce := copy(LinAce, pos('##', LinAce) + 2, 100);

            DirAce := copy(DirAce, 1, pos('@@', DirAce) - 1);

            ApeAce := copy(LinAce, pos('@@', LinAce) + 2, 100);

            if pos('@@', ApeAce) > 0 then
              ApeAce := copy(ApeAce, 1, pos('@@', ApeAce) - 1);

          end;

          Inc(SeqLin);

        end;

        GDirAce := LowerCase(Trim(DirAce));

        SeqLin := 0;

        while SeqLin <= (ArqTxt.Count - 1) do
        begin

          LinAce := UpperCase(ArqTxt[SeqLin]);

          if pos(ApeLin, LinAce) > 0 then
          begin

            DirUsu := copy(LinAce, pos('***', LinAce) + 3, 100);

            DirUsu := copy(DirUsu, 1, pos('***', DirUsu) - 1);

          end;

          Inc(SeqLin);

        end;

        if Trim(ApeAce) <> '' then
          GApeAce := ' [ ' + ApeAce + ' ] '
        else
          GApeAce := '';

        if dbMain.Connected then
          dbMain.Close;

        dbMain.Params.Clear;

        dbMain.Params.Add('SQLDIALECT=3');
        dbMain.Params.Add('BLOBS TO CACHE=-1');

        if Trim(GDirAce) <> '' then
          dbMain.Params.Add('SERVER NAME=' + GDirAce);

        dbMain.Params.Add('USER NAME=SYSDBA');
        dbMain.Params.Add('PASSWORD=' + GuIdHal);

        if (Trim(roleName) <> '') then
          dbMain.Params.Add('ROLE NAME=' + roleName);

        FreeAndNil(ArqTxt);

        if (BuscaSimples('GERPAR', 'VER_FIREBIRD', ' 1=1') = '2.5') then
          GDirUsu := GDirAce;

        GDirUsu := LowerCase(DirUsu);

      end;
    end;
  end
end;

end.