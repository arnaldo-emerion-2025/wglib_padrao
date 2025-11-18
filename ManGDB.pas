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
    procedure ReplicaProduto(CodClp, CodGru, CodSub, CodPro: string);
    procedure ReplicaEstBar(CodClp, CodGru, CodSub, CodPro: string);
    procedure ReplicaEstEmb(CodEmb: string);
    procedure ReplicaCategoria(codCat: integer);
    procedure ReplicSTR(CodStr, TipStr: string);
    procedure ReplicaUFE(SigUfe, CodStr, TipStr: string);
    procedure ReplicaTipoEmbalagem(CodEmb: string);
    procedure ReplicaGerUfe(SigUfe: string);
    procedure ReplicaIPI(CodIpi, TipIpi, CodTxf: string);
    procedure ReplicaICM(CodIcm, TipIcm: string);
    procedure ReplicaEstIte(CodEmp, CodClp, CodGru, CodSub, CodPro: string);
    procedure ReplicaUnidade(CodUnd: string);
    procedure ReplicaMarcas(CodMrc: Integer);
    procedure ReplicaGrupo(CodGru: string);
    procedure ReplicaSubGrupo(CodGru, CodSub: string);
    procedure ReplicaTipoItem(CodTip: Integer);
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
    strIPServNFe, strPortaServNFe: string; //variáveis para ServNFe
    CaminhoXml, CaminhoDanfe, CaminhoRetorno: string;

    procedure CarregaSOCKET;
    procedure CarregaIni;

  public
    sCabe: string;
    VCODUSU: integer; {Public declarations}
    VGrupoUsu: Integer;
    function NotaExiste(nronfs: string): Boolean;
    procedure carregaLoginTxt();
    function getServerName: string;
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
  GDataLimite: TDateTime; {Data Limite para Utilização do Software}
  GParLib: string;
  GFprm: string; {Permissão do usuário ativo na transação selecionada}
  GExiFor: string;
  GExiCli: string;
  GExiCom: string;
  GDlog: TDateTime; {Data / hora de login}
  GModu: TModulos; {Módulos habilitados para uso}
  GUsu_Id: integer; {Usuário ativo}
  GsCodCli: integer;
  GUsu_Sn: string; {Senha do Usuario ativo}
  GGus_Id: integer; {Grupo de Usuario ativo}
  GCodCli: integer;
  GSup_Id: integer;
  GCodUsu: string; {Usuário ativo}
  GFonUsu: string;
  GFaxUsu: string;
  GFlgGer: string;
  GParamStr: string;
  GuIdHal: string;
  GEmp_Id: integer; {Empresa ativa}
  GUsu_Nm: string; {login do Usuário Ativo}
  GUsu_Ema: string; {Email do Usuario}
  GTemp: string[40]; {Diretório para gravação de arquivos temporários}
  GCtr_bai, Tecla: string; {Controle da baixa}
  GCgcEmp, GInsEmp, GApeEmp, GRazEmp, GEndEmp, GCidEmp, GUfeEmp, GRefEmp, GFonEmp, GFaxEmp, GCepEmp, GWebEmp, GEmaEmp: string;
  GId_FinUfe: integer;
  GId_FinCie: string;
  GnNavig: Integer; {Quantidade navigator}
  GTmpLog: Integer; {Tempo limite para inatividade do Sistema}
  GTmpVer: Integer; {Tempo limite para inatividade do Sistema}
  GExiNot: string; {Se o Usuario esta ou nao habilitado a Receber Mensagens de Notificações em Projeto}
  GDSNavig: string; {Primeiro navigator - Data source correspondente}
  GVerUsuario: integer; {Verificar se o formulario de Autenticação de Usuario ja esta aberto}
  GCodVen_Id: integer; {Se Usuário Logado Possui Código de Vendedor Ativo}
  GCodRep_Id: integer; {Se Usuário Logado Possui Código de Preposto Ativo}
  GCodAtd_Id: integer; {Se Usuário Logado Possui Código de Atendente Ativo}
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

  Gcx_Emp, Gcx_Cai, Gcx_Ope, Gcx_Sup: integer; {Informações de Usuários Operadores de Caixas}

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

  roleName, fireBird: string; {nome da role Atribuida e versão correntdo Firebird}

const

  GEntrar = 'c:\Emerion\splash.bmp';
  GAnimar = 'c:\Emerion\animar.gif';
  GLogar = 'c:\Emerion\login.bmp';
  GImprimir = 'c:\Emerion\print.bmp';
  GDatabaseName = 'ISade'; {Database de conexão}
  GMensagem = 'Atenção. Ocorreu um problema em relação ao licenciamento do sistema. Por favor entre em contato com o suporte tecnico.';
  GMensagem_0001 = 'Atenção. Ocorreu um problema em relação ao licenciamento do sistema. Por favor entre em contato com o suporte tecnico.';
  GMensagem_0002 = 'Usuario não possui acesso a opcão.';
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
    mensagem := 'Nota já utilizada em ';
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
      quBusca.SQL.Text := ' select ' + Retorna + ' From  ' + Tabela + ' Where 1 = 1 and ' + _and;
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

  if (UpperCase(ExtractFileName(application.exename)) = 'EFATURA.EXE')
    or (UpperCase(ExtractFileName(application.exename)) = 'EFRENTELOJA.EXE') then
  begin
    CarregaIni;
  end;

  GNFeEnvia := '';

  GuIdHal := 'ibsade20'; //MasterGuIdHal;
  GuIdHal := MasterGuIdHal;

    for aux := 0 to ParamCount -1 do
     begin
      if (ParamStr(aux) = 'senhaNova') then
         GuIdHal := 'FgB@8165';
     end;

     if ((DebugHook > 0) and (ParamStr(1) <> 'remoto')) then //remoto
        GuIdHal := 'FgB@8165'
      else
        GuIdHal := 'ibsade20';

      if (ParamStr(1) = 'senhaNova') then
        GuIdHal := 'FgB@8165';

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
      ShowMessage('Diretorio Privado não Pode ser Criado ' + ExtractFilePath(ParamStr(0)) + 'PRIV');

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


  dbMain.Params.Values['PASSWORD'] := 'ibsade20';
  for aux := 0 to 1 do
     begin
      if (UpperCase(ParamStr(aux)) = Uppercase('senhaNova')) then
           dbMain.Params.Values['PASSWORD'] := 'FgB@8165'
     end;

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

        dbMain.Params.Add('BLOBS TO CACHE=-1');

        if Trim(GDirAce) <> '' then
          dbMain.Params.Add('SERVER NAME=' + GDirAce);

        dbMain.Params.Add('USER NAME=SYSDBA');
        //dbMain.Params.Add('PASSWORD=' + 'ibsade20');

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

      if ((DebugHook > 0) and (ParamStr(1) <> 'remoto')) then //remoto
        dbMain.Params.Values['PASSWORD'] := 'FgB@8165'
      else
        dbMain.Params.Values['PASSWORD'] := 'ibsade20';

      if (ParamStr(1) = 'senhaNova') then
        dbMain.Params.Values['PASSWORD'] := 'FgB@8165';
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
    //Informações da empresa Origem
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

    //Informações da empresa Destino
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

    //Quando UFs diferentes verifica se destinatário aceita atualização
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

procedure TfmManGDB.ReplicaProduto(CodClp, CodGru, CodSub, CodPro: string);
var
  SQLProduto: TwwQuery; //Dados dos Produtos
  SQLTemp: TwwQuery;
begin
  try
    try
      DBEmerion1.StartTransaction;
      SQLProduto := TwwQuery.Create(Self);
      SQLTemp := TwwQuery.Create(Self);
      SQLProduto.DatabaseName := 'isade';
      SQLTemp.DataBaseName := 'isade';
      SQLProduto.sql.Text := 'select * from estpro where codclp = ' + QuotedStr(codclp) + ' and codgru = ' + QuotedStr(codgru)
        + ' and codsub = ' + QuotedStr(codsub) + ' and codpro = ' + QuotedStr(codpro) + ' -- ';
      SQLProduto.active := true;

      //Verificando os Dados de Todas as Tabelas Auxiliares
      //Verificando a Categoria
      if not SQLProduto.FieldByName('CODCAT').isNull then
        ReplicaCategoria(SQLProduto.FieldByName('CODCAT').AsInteger);

      //Verificando Unidade de Entrada
      if not SQLProduto.FieldByName('CODUNE').isNull then
        ReplicaUnidade(SQLProduto.FieldByname('CODUNE').AsString);

      //Verificando Unidade de Saída
      if not SQLProduto.FieldByName('CODUNS').isNull then
        ReplicaUnidade(SQLProduto.FieldByname('CODUNS').AsString);

      //Verificando Marca
      if not SQLProduto.FieldByName('CODMRC').isNull then
        ReplicaMarcas(SQLProduto.FieldByname('CODMRC').Value);

      //Verificando Tipo de Item
      if not SQLProduto.FieldByName('CODTIP').isNull then
        ReplicaTipoItem(SQLProduto.FieldByname('Codtip').Value);

      //Verificando Grupo
      ReplicaGrupo(CodGru);

      //Verificando SubGrupo
      ReplicaSubGrupo(Codgru, CodSub);

      //verificando icms de saida
      ReplicaICM(SQLProduto.FieldByName('ICMSAI').AsString, 'Saida');

      //verificando icms de entrada
      ReplicaICM(SQLProduto.FieldByName('ICMENT').AsString, 'Entrada');

      //verificando ipi de entrada
      SQLTEMP.Active := False;
      SQLTemp.SQL.Text := 'Select ipie.codtxf as CODTXF ' +
        'from ' +
        'estpro pro ' +
        'left join estipi ipie on ipie.codipi = pro.ipient and upper(ipie.tipipi) = ' + QuotedStr('ENTRADA') +
        ' where ' +
        'pro.codclp = ' + QuotedStr(SQLProduto.FieldByName('CODCLP').AsString) +
        ' and pro.codgru = ' + QuotedStr(SQLProduto.FieldByName('CODGRU').AsString) +
        ' and pro.codsub = ' + QuotedStr(SQLProduto.FieldByName('CODSUB').AsString) +
        ' and pro.codpro = ' + QuotedStr(SQLProduto.FieldByName('CODPRO').AsString) +
        ' and pro.ipient = ' + QuotedStr(SQLProduto.FieldByName('IPIENT').AsString);
      SQLTEMP.Active := True;
      ReplicaIPI(SQLProduto.FieldByName('IPISAI').AsString, QuotedStr('Entrada'), SQLTemp.FieldByName('CODTXF').AsString);

      //Verificando ipi de saída

      SQLTEMP.Active := False;
      SQLTemp.SQL.Text := 'Select ipis.codtxf as CODTXF ' +
        'from ' +
        'estpro pro ' +
        'left join estipi ipis on ipis.codipi = pro.ipisai and upper(ipis.tipipi) = ' + QuotedStr('SAÍDA') +
        ' where ' +
        ' pro.codclp = ' + QuotedStr(SQLProduto.FieldByName('CODCLP').AsString) +
        ' and pro.codgru = ' + QuotedStr(SQLProduto.FieldByName('CODGRU').AsString) +
        ' and pro.codsub = ' + QuotedStr(SQLProduto.FieldByName('CODSUB').AsString) +
        ' and pro.codpro = ' + QuotedStr(SQLProduto.FieldByName('CODPRO').AsString) +
        ' and pro.ipisai = ' + QuotedStr(SQLProduto.FieldByName('IPISAI').AsString);
      SQLTEMP.Active := True;

      ReplicaIPI(SQLProduto.FieldByName('IPISAI').AsString, QuotedStr('Saida'), SQLTemp.FieldByName('CODTXF').AsString);

      //VERIFICANDO A SUBSTITUIÇÃO TRIBUTÁRIA DE ENTRADA
      ReplicSTR(SQLProduto.FieldByName('CODSTE').AsString, 'Entrada');

      //VERIFICANDO A SUBSTITUIÇÃO TRIBUTÁRIA DE SAída
      ReplicSTR(SQLProduto.FieldByName('CODSTs').AsString, 'Saida');

      //Atualizando Produtos
      if (SQLProduto.SQL.Count > 0) then
      begin

        REPLICA_PRODUTOS.params[0].Value := CodSub;
        REPLICA_PRODUTOS.params[1].Value := CodGru;
        REPLICA_PRODUTOS.params[2].Value := SQLProduto.FieldByName('DSCPRO').AsString;
        REPLICA_PRODUTOS.params[3].Value := SQLProduto.FieldByName('CODPRO').AsString;
        REPLICA_PRODUTOS.params[4].Value := SQLProduto.FieldByName('DSRPRO').AsString;
        REPLICA_PRODUTOS.params[5].Value := SQLProduto.FieldByName('LOCPRO').AsString;

        if (SQLProduto.FieldByName('CODTIP').IsNull) then
          REPLICA_PRODUTOS.params[6].clear
        else
          REPLICA_PRODUTOS.params[6].Value := SQLProduto.FieldByName('CODTIP').Value;

        if (SQLProduto.FieldByName('CODMRC').isnull) then
          REPLICA_PRODUTOS.params[7].clear
        else
          REPLICA_PRODUTOS.params[7].Value := SQLProduto.FieldByName('CODMRC').Value;

        REPLICA_PRODUTOS.params[8].Value := SQLProduto.FieldByName('CODUNE').AsString;
        REPLICA_PRODUTOS.params[9].Value := SQLProduto.FieldByName('CODUNS').AsString;

        if (SQLProduto.FieldByName('CODCAT').isnull) then
          REPLICA_PRODUTOS.params[10].clear
        else
          REPLICA_PRODUTOS.params[10].Value := SQLProduto.FieldByName('CODCAT').Value;

        REPLICA_PRODUTOS.params[11].Value := SQLProduto.FieldByName('SIMPRO').AsString;
        REPLICA_PRODUTOS.params[12].Value := SQLProduto.FieldByName('IDEPRO').AsString;
        REPLICA_PRODUTOS.params[13].Value := SQLProduto.FieldByName('REFPRO').AsString;
        REPLICA_PRODUTOS.params[14].Value := SQLProduto.FieldByName('NUMPRO').AsString;
        REPLICA_PRODUTOS.params[15].Value := SQLProduto.FieldByName('QTEPRO').Value;
        REPLICA_PRODUTOS.params[16].Value := SQLProduto.FieldByName('QTSPRO').Value;

        if (REPLICA_PRODUTOS.params[17].isnull) then
          REPLICA_PRODUTOS.params[17].clear
        else
          REPLICA_PRODUTOS.params[17].Value := SQLProduto.FieldByName('CODCOM').AsString;

        REPLICA_PRODUTOS.params[18].Value := SQLProduto.FieldByName('QTDVOL').Value;
        REPLICA_PRODUTOS.params[19].Value := SQLProduto.FieldByName('QTDEMB').Value;
        REPLICA_PRODUTOS.params[20].Value := SQLProduto.FieldByName('PESCUB').Value;
        REPLICA_PRODUTOS.params[21].Value := SQLProduto.FieldByName('PESLIQ').Value;
        REPLICA_PRODUTOS.params[22].Value := SQLProduto.FieldByName('PESBRT').Value;
        REPLICA_PRODUTOS.params[23].Value := CodClp;
        REPLICA_PRODUTOS.ExecProc;
        ReplicaEstBar(CODCLP, CODGRU, CODSUB, CODPRO);
        DBEmerion1.Commit;

      end;
    except on E: Exception do
      begin
        if DebugHook > 0 then
          fMsg(E.Message, 'I')
        else
          fMsg('Produto Não Replicado', 'I');

        DBEmerion1.Rollback;
      end;
    end;
  finally
    FreeAndNil(SQLTemp);
    FreeAndNil(SQLProduto);
  end;

end;

procedure TfmManGDB.ReplicaCategoria(codCat: integer);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.sql.Text := 'select * from estcat where codcat = ' + QuotedStr(intToStr(codCat));
    sqltemp.active := true;
    if ((session.IsAlias('Emerion_01') = True) and (SQLTEMP.sql.Count > 0)) then
    begin
      REPLIC_CATEGORIAS.Params[0].Value := SQLTemp.FieldByName('CODCAT').Value;
      REPLIC_CATEGORIAS.Params[1].Value := SQLTemp.FieldByName('NOMCAT').AsString;
      REPLIC_CATEGORIAS.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TfmManGDB.ReplicSTR(CodStr, TipStr: string);
var
  SQLTEMP: TwwQuery;
  Replica: string;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.SQL.Text := 'select * from ESTSTR where CODSTR = ' + QuotedStr(CodStr) +
      ' and TIPSTR = ' + QuotedStr(TipStr);
    SQLTEMP.Active := True;

    //Verificando se replica as regras nos parametros
    Replica := fmManGDB.BuscaSimples('ESTPAR', 'REPLICA_REGRAS', ' 1=1 ');
    if Replica = '1' then
    begin
      if ((session.IsAlias('Emerion_01')) and (SQLTEMP.sql.Count > 0)) then
      begin
        //Replicando ESTSTR
        REPLIC_ESTSTR.params[0].value := SQLTemp.FieldByName('CODSTR').AsString;
        REPLIC_ESTSTR.params[1].value := SQLTemp.FieldByName('TIPSTR').AsString;
        REPLIC_ESTSTR.params[2].value := SQLTemp.FieldByName('NOMSTR').AsString;
        REPLIC_ESTSTR.ExecProc;
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TfmManGDB.ReplicaUFE(SigUfe, CodStr, TipStr: string);
var
  Replica: string;
  SQLTEMP: TwwQuery;
  SQLTEMP2: TwwQuery;
begin
  try
    try
      dbEmerion1.Open;

      dbEmerion1.StartTransaction;

      SQLTemp := TwwQuery.Create(Self);
      SQLTemp2 := TwwQuery.Create(Self);
      SQLTemp.DatabaseName := 'isade';
      SQLTemp2.DatabaseName := 'isade';
      SQLTEMP.SQL.Text := 'select * from GERUFE where SIGUFE = ' + QuotedStr(SigUfe);
      SQLTEMP.Active := True;

      //Verificando se replica as regras nos parametros
      Replica := fmManGDB.BuscaSimples('ESTPAR', 'REPLICA_REGRAS', ' 1=1 ');
      if Replica = '1' then
      begin
        if session.IsAlias('Emerion_01') then
        begin
          //Gerufe
          SQLTemp2.Active := False;
          SQLTemp2.SQL.Text := 'select * from ESTUFE where CODSTR = ' + QuotedStr(CodStr) +
            ' and TIPSTR = ' + QuotedStr(TipStr);
          SQLTEMP2.Active := True;

          if SQLTemp2.FieldByName('SIGUFE').IsNull then
          begin
            SQLTemp2.SQL.Text := 'Select * from GERUFE where SIGUFE = ' + QuotedStr(SQLTemp.FieldByName('SIGUFE').AsString);
            SQLTemp2.Active := True;
            if SQLTemp.IsEmpty = false then
            begin
              REPLIC_GERUFE.Params[0].Value := SQLTemp2.fieldbyname('SIGUFE').AsString;
              REPLIC_GERUFE.Params[1].Value := SQLTemp2.fieldbyname('NOMUFE').AsString;
              REPLIC_GERUFE.Params[2].Value := SQLTemp2.fieldbyname('DSCUFE').value;
              REPLIC_GERUFE.Params[3].Value := SQLTemp2.fieldbyname('NROUFE').value;
              REPLIC_GERUFE.Params[4].Value := SQLTemp2.fieldbyname('SUBTRB').AsString;
              REPLIC_GERUFE.Params[5].Value := SQLTemp2.fieldbyname('DSCCOM').value;
              REPLIC_GERUFE.Params[6].Value := SQLTemp2.fieldbyname('QTDICM').value;
              REPLIC_GERUFE.Params[7].Value := SQLTemp2.fieldbyname('SEQICM').value;
              REPLIC_GERUFE.Params[8].Value := SQLTemp2.fieldbyname('FLGTRG').AsString;
              REPLIC_GERUFE.Params[9].Value := SQLTemp2.fieldbyname('QTDPRO').value;
              REPLIC_GERUFE.Params[10].Value := SQLTemp2.fieldbyname('SEQPRO').value;
              REPLIC_GERUFE.ExecProc;
            end;
          end;

          //FINTCL
          SQLTemp.Active := False;
          SQLTemp.SQL.Text := 'select * from ESTUFE where CODSTR = ' + QuotedStr(CodStr) +
            ' and TIPSTR = ' + QuotedStr(TipStr);
          SQLTEMP.Active := True;

          SQLTEMP2.Active := false;
          SQLTemp2.SQL.Text := 'select codtcl, nomtcl from ' +
            ' fintcl tcl inner join estufe ufe on tcl.codtcl = ufe.codtcl ' +
            ' where ufe.sigufe = ' + quotedstr(SigUfe);
          SQLTemp2.active := true;

          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTTXF where CODTXF = ' +
            QuotedStr(SQLTemp.FieldByName('CODTXF').AsString);
          SQLTEMP2.Active := True;
          if (SQLTemp.FieldByName('CODTXF').IsNull = FALSE) then
          begin
            REPLIC_TEXTOFISCAL.Params[0].Value := SQLTemp2.FieldByName('CODTXF').AsString;
            REPLIC_TEXTOFISCAL.Params[1].Value := SQLTemp2.FieldByName('TIPTXF').AsString;
            REPLIC_TEXTOFISCAL.Params[2].Value := SQLTemp2.FieldByName('DSRTXF').AsString;
            REPLIC_TEXTOFISCAL.Params[3].Value := SQLTemp2.FieldByName('DSCTXF').AsString;
            REPLIC_TEXTOFISCAL.ExecProc;
          end;

          //ESTTME
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTTME where CODTME = ' +
            QuotedStr(SQLTEMP.FieldByName('CODTME').ASString);
          SQLTEMP2.Active := True;

          if (SQLTemp.FieldByName('CODTME').IsNull = False) then
          begin
            REPLIC_ESTTME.Params[0].Value := SQLTemp2.FieldByName('CODTME').AsString;
            REPLIC_ESTTME.Params[1].Value := SQLTemp2.FieldByName('NOMTME').AsString;
            REPLIC_ESTTME.ExecProc;
          end;

          //Replicando ESTSTR
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTSTR where CODSTR = ' + QuotedStr(CodStr) + ' and TIPSTR = ' + QuotedStr(TipStr);
          SQLTEMP2.Active := True;

          REPLIC_ESTSTR.params[0].Value := SQLTemp2.FieldByName('CODSTR').AsString;
          REPLIC_ESTSTR.params[1].Value := SQLTemp2.FieldByName('TIPSTR').AsString;
          REPLIC_ESTSTR.params[2].Value := SQLTemp2.FieldByName('NOMSTR').AsString;
          REPLIC_ESTSTR.ExecProc;

          //ESTIPI
          if ((SQLTemp.FieldByName('REGIPI').IsNull = FALSE) and (SQLTemp.FieldByName('TIPIPI').IsNull = FALSE)) then
          begin
            SQLTemp2.Active := False;
            SQLTemp2.sql.text := 'Select * from ESTIPI where CODIPI = ' + QuotedStr(SQLTemp.FieldByName('CODIPI').AsString) + ' and REGIPI = ' +
              QuotedStr(SQLTemp.FieldByName('REGIPI').AsString);
            SQLTemp2.Active := True;
            if not SQLTemp2.IsEmpty then
            begin
              REPLIC_IPI.Params[0].Value := SQLTemp2.fieldbyname('CODIPI').AsString;
              REPLIC_IPI.Params[1].Value := SQLTemp2.fieldbyname('TIPIPI').AsString;
              REPLIC_IPI.Params[2].Value := SQLTemp2.fieldbyname('NOMIPI').AsString;
              REPLIC_IPI.Params[3].Value := SQLTemp2.fieldbyname('REGIPI').AsString;
              REPLIC_IPI.Params[4].Value := SQLTemp2.fieldbyname('TRBIPI').AsString;
              REPLIC_IPI.Params[5].Value := SQLTemp2.fieldbyname('PERIPI').value;
              REPLIC_IPI.Params[6].Value := SQLTemp2.fieldbyname('REDIPI').value;
              REPLIC_IPI.Params[7].Value := SQLTemp2.fieldbyname('RECIPI').value;
              REPLIC_IPI.Params[8].Value := SQLTemp2.fieldbyname('BASIPI').value;
              REPLIC_IPI.Params[9].Value := SQLTemp2.fieldbyname('CLSIPI').AsString;
              REPLIC_IPI.Params[10].Value := SQLTemp2.fieldbyname('PERIMP').value;
              REPLIC_IPI.Params[11].Value := SQLTemp2.fieldbyname('CODTXF').AsString;
              REPLIC_IPI.Params[12].Value := SQLTemp2.fieldbyname('ID_ESTNCM').value;
              REPLIC_IPI.ExecProc;
            end;
          end;

          //ESTICM
          if ((SQLTEMP.FieldByName('REGICM').IsNull = false) and (SQLTEMP.FieldByName('TIPICM').IsNull = false)) then
          begin
            SQLTEMP2.Active := False;
            SQLTEMP2.sql.text := 'Select * from ESTICM where CODICM = ' + QuotedStr(SQLTEMP.FieldByName('REGICM').AsString) + ' and TIPICM = ' +
              QuotedStr(SQLTEMP.FieldByName('TIPICM').AsString);
            SQLTEMP2.Active := True;
            if not SQLTEMP2.IsEmpty then
            begin
              REPLIC_ICM.Params[0].Value := SQLTEMP2.fieldbyname('CODICM').AsString;
              REPLIC_ICM.Params[1].Value := SQLTEMP2.fieldbyname('TIPICM').AsString;
              REPLIC_ICM.Params[2].Value := SQLTEMP2.fieldbyname('NOMICM').AsString;
              REPLIC_ICM.Params[3].Value := SQLTEMP2.fieldbyname('TRBICM').AsString;
              REPLIC_ICM.Params[4].Value := SQLTEMP2.fieldbyname('PERICM').value;
              REPLIC_ICM.Params[5].Value := SQLTEMP2.fieldbyname('REDICM').value;
              REPLIC_ICM.Params[6].Value := SQLTEMP2.fieldbyname('RECICM').value;
              REPLIC_ICM.Params[7].Value := SQLTEMP2.fieldbyname('BASICM').value;
              REPLIC_ICM.Params[8].Value := SQLTEMP2.fieldbyname('INCREV').value;
              REPLIC_ICM.Params[9].Value := SQLTEMP2.fieldbyname('INCFIN').value;
              REPLIC_ICM.Params[10].Value := SQLTEMP2.fieldbyname('ITECON').AsString;
              REPLIC_ICM.Params[11].Value := SQLTEMP2.fieldbyname('CODST1').AsString;
              REPLIC_ICM.Params[12].Value := SQLTEMP2.fieldbyname('CODST2').AsString;
              REPLIC_ICM.ExecProc;
            end;
          end;

          //Replicando ESTSTR
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'Select * from ESTSTR where CODSTR = ' + QuotedStr(CodStr) +
            ' and TIPSTR = ' + QuotedSTR(TipStr);
          SQLTEMP2.Active := True;

          REPLIC_ESTSTR.params[0].Value := SQLTEMP2.FieldByName('CODSTR').AsString;
          REPLIC_ESTSTR.params[1].Value := SQLTEMP2.FieldByName('TIPSTR').AsString;
          REPLIC_ESTSTR.params[2].Value := SQLTEMP2.FieldByName('NOMSTR').AsString;
          REPLIC_ESTSTR.ExecProc;

          SQLTEMP.active := false;
          SQLTEMP.SQL.Text := 'select * from estufe where codstr = ' + quotedstr(CodStr) +
            'and tipstr = ' + quotedstr(tipstr) +
            ' and sigufe = ' + quotedstr(SigUfe);
          SQLTEMP.active := true;

          REPLIC_ESTUFE.Params[0].Value := CodStr;
          REPLIC_ESTUFE.Params[1].Value := TipStr;
          REPLIC_ESTUFE.Params[2].Value := SigUfe;

          if not (SQLTEMP.FieldByName('ICMSUB').isNull) then
            REPLIC_ESTUFE.Params[3].Value := SQLTEMP.FieldByName('ICMSUB').Value
          else
            REPLIC_ESTUFE.Params[3].Clear;

          if not (SQLTEMP.FieldByName('MRGSUB').isNull) then
            REPLIC_ESTUFE.Params[4].Value := SQLTEMP.FieldByName('MRGSUB').Value
          else
            REPLIC_ESTUFE.Params[4].Clear;

          if not (SQLTEMP.FieldByName('BASESB').isNull) then
            REPLIC_ESTUFE.Params[5].Value := SQLTEMP.FieldByName('BASESB').Value
          else
            REPLIC_ESTUFE.Params[5].Clear;

          if not (SQLTEMP.FieldByName('CODCFO').isNull) then
            REPLIC_ESTUFE.Params[6].Value := SQLTEMP.FieldByName('CODCFO').AsString
          else
            REPLIC_ESTUFE.Params[6].Clear;

          if not (SQLTEMP.FieldByName('REGICM').isNull) then
            REPLIC_ESTUFE.Params[7].Value := SQLTEMP.FieldByName('REGICM').AsString
          else
            REPLIC_ESTUFE.Params[7].Clear;

          if not (SQLTEMP.FieldByName('TIPICM').isNull) then
            REPLIC_ESTUFE.Params[8].Value := SQLTEMP.FieldByName('TIPICM').AsString
          else
            REPLIC_ESTUFE.Params[8].Clear;

          if not (SQLTEMP.FieldByName('REGIPI').isNull) then
            REPLIC_ESTUFE.Params[9].Value := SQLTEMP.FieldByName('REGIPI').AsString
          else
            REPLIC_ESTUFE.Params[9].Clear;

          if not (SQLTEMP.FieldByName('TIPIPI').isNull) then
            REPLIC_ESTUFE.Params[10].Value := SQLTEMP.FieldByName('TIPIPI').AsString
          else
            REPLIC_ESTUFE.Params[10].Clear;

          if not (SQLTEMP.FieldByName('CODTXF').isNull) then
            REPLIC_ESTUFE.Params[11].Value := SQLTEMP.FieldByName('CODTXF').AsString
          else
            REPLIC_ESTUFE.Params[11].Clear;

          if not (SQLTEMP.FieldByName('CODTME').isNull) then
            REPLIC_ESTUFE.Params[12].Value := SQLTEMP.FieldByName('CODTME').AsString
          else
            REPLIC_ESTUFE.Params[12].Clear;

          if not (SQLTEMP.FieldByName('DTEENV').isNull) then
            REPLIC_ESTUFE.Params[13].Value := SQLTEMP.FieldByName('DTEENV').AsDateTime
          else
            REPLIC_ESTUFE.Params[13].Clear;

          if not (SQLTEMP.FieldByName('CODTCL').isNull) then
            REPLIC_ESTUFE.Params[14].Value := SQLTEMP.FieldByName('CODTCL').Value
          else
            REPLIC_ESTUFE.Params[14].Clear;

          REPLIC_ESTUFE.ExecProc;

          dbEmerion1.Commit;

        end;
      end;
    except
      dbEmerion1.Rollback;
    end;
  finally
    FreeAndNil(SQLTEMP);
    FreeAndNil(SQLTEMP2);
  end;
end;

procedure TfmManGDB.ReplicaTipoEmbalagem(CodEmb: string);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'select * from ESTEMB where CODEMB = ' + QuotedStr(CodEmb);
    SQLTEMP.Active := True;

    if ((session.IsAlias('Emerion_01') = True) and (SQLTEMP.SQL.Count > 0)) then
    begin
      Replica_tipoEmbalagem.Params[0].Value := SQLTEMP.FieldByName('CODEMB').asString;
      Replica_tipoEmbalagem.Params[1].Value := SQLTEMP.FieldByName('NOMEMB').asString;
      Replica_tipoEmbalagem.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;

end;

procedure TfmManGDB.ReplicaGerUfe(SigUfe: string);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'select * from GERUFE where SIGUFE = ' + QuotedStr(SigUfe);
    SQLTEMP.Active := True;

    if ((session.IsAlias('Emerion_01') = True) and (SQLTEMP.SQL.Count > 0)) then
    begin
      try
        REPLIC_GERUFE.Params[0].value := SQLTEMP.FieldByName('SIGUFE').AsString;
        REPLIC_GERUFE.Params[1].value := SQLTEMP.FieldByName('NOMUFE').AsString;
        REPLIC_GERUFE.Params[2].value := SQLTEMP.FieldByName('DSCUFE').value;
        REPLIC_GERUFE.Params[3].value := SQLTEMP.FieldByName('NROUFE').value;
        REPLIC_GERUFE.Params[4].value := SQLTEMP.FieldByName('SUBTRB').AsString;
        REPLIC_GERUFE.Params[5].value := SQLTEMP.FieldByName('DSCCOM').value;
        REPLIC_GERUFE.Params[6].value := SQLTEMP.FieldByName('QTDICM').value;
        REPLIC_GERUFE.Params[7].value := SQLTEMP.FieldByName('SEQICM').value;
        REPLIC_GERUFE.Params[8].value := SQLTEMP.FieldByName('FLGTRG').AsString;
        REPLIC_GERUFE.Params[9].value := SQLTEMP.FieldByName('QTDPRO').value;
        REPLIC_GERUFE.Params[10].value := SQLTEMP.FieldByName('SEQPRO').value;
        REPLIC_GERUFE.ExecProc;
      except on E: Exception do
          showmessage(E.message);
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;

end;

procedure TfmManGDB.ReplicaIPI(CodIpi, TipIpi, CodTxf: string);
var
  Replica: string;
  SQLTEMP: TwwQuery;
  SQLTEMP2: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTemp2 := TwwQuery.Create(Self);
    SQLTemp2.DatabaseName := 'isade';

    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'select * FROM ESTIPI WHERE CODIPI = ' + QuotedStr(CODIPI) + ' AND TIPIPI = ' + QuotedStr(TIPIPI);
    SQLTEMP.Active := True;

    //Verificando se replica as regras nos parametros
    Replica := fmManGDB.BuscaSimples('ESTPAR', 'REPLICA_REGRAS', ' 1=1 ');
    if Replica = '1' then
    begin
      if ((session.IsAlias('Emerion_01')) and (SQLTEMP.SQL.Count > 0)) then
      begin
        //Chamando procedure de textofiscal
        if SQLTEMP.FieldByName('CODTXF').IsNull = false then
        begin
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'Select * from ESTTXF where CODTXF = ' + QuotedStr(CodTxf);
          SQLTEMP2.Active := True;

          REPLIC_TEXTOFISCAL.Params[0].Value := SQLTEMP2.FieldByName('CODTXF').AsString;
          REPLIC_TEXTOFISCAL.Params[1].Value := SQLTEMP2.FieldByName('TIPTXF').AsString;
          REPLIC_TEXTOFISCAL.Params[2].Value := SQLTEMP2.FieldByName('DSRTXF').AsString;
          REPLIC_TEXTOFISCAL.Params[3].Value := SQLTEMP2.FieldByName('DSCTXF').AsString;
          REPLIC_TEXTOFISCAL.ExecProc;
        end;
        //Chamando a procedure de NCM

        if SQLTEMP.FieldByName('ID_ESTNCM').IsNull = false then
        begin
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTNCM where id_EstNcm = ' + QuotedStr(SQLTEMP.FieldByName('Id_EstNcm').AsString);
          SQLTEMP2.Active := True;

          REPLIC_NCM.Params[0].Value := SQLTEMP2.FieldByName('ID_ESTNCM').Value;
          REPLIC_NCM.Params[1].Value := SQLTEMP2.FieldByName('NOMNCM').AsString;
          REPLIC_NCM.Params[2].Value := SQLTEMP2.FieldByName('ID_ESTSEC').Value;
          REPLIC_NCM.ExecProc;
        end;

        //Chamando procedure de IPI

        REPLIC_IPI.Params[0].Value := SQLTEMP.FieldByName('CODIPI').AsString;

        REPLIC_IPI.Params[1].Value := SQLTEMP.FieldByName('TIPIPI').AsString;

        REPLIC_IPI.Params[2].Value := SQLTEMP.FieldByName('NOMIPI').AsString;

        REPLIC_IPI.Params[3].Value := SQLTEMP.FieldByName('REGIPI').AsString;

        REPLIC_IPI.Params[4].Value := SQLTEMP.FieldByName('TRBIPI').AsString;

        REPLIC_IPI.Params[5].Value := SQLTEMP.FieldByName('PERIPI').Value;

        REPLIC_IPI.Params[6].Value := SQLTEMP.FieldByName('REDIPI').Value;

        REPLIC_IPI.Params[7].Value := SQLTEMP.FieldByName('RECIPI').Value;

        REPLIC_IPI.Params[8].Value := SQLTEMP.FieldByName('BASIPI').Value;

        REPLIC_IPI.Params[9].Value := SQLTEMP.FieldByName('CLSIPI').AsString;

        REPLIC_IPI.Params[10].Value := SQLTEMP.FieldByName('PERIMP').Value;

        REPLIC_IPI.Params[11].Value := SQLTEMP.FieldByName('CODTXF').AsString;

        REPLIC_IPI.Params[12].Value := SQLTEMP.FieldByName('ID_ESTNCM').Value;

        REPLIC_IPI.ExecProc;

      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
    FreeAndNil(SQLTEMP2);
  end;
end;

procedure TfmManGDB.ReplicaICM(CodIcm, TipIcm: string);
var
  Replica: string;
  SQLTEMP: TwwQuery;
  SQLTEMP2: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTemp2 := TwwQuery.Create(Self);
    SQLTemp2.DatabaseName := 'isade';
    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'Select * from ESTICM WHERE CODICM = ' + QuotedStr(codicm) + ' AND TIPICM = ' + QuotedStr(tipicm);
    SQLTEMP.Active := True;

    Replica := fmManGDB.BuscaSimples('ESTPAR', 'REPLICA_REGRAS', ' 1=1 ');
    if Replica = '1' then
    begin
      if session.IsAlias('Emerion_01') then
      begin
        //Verificando ST1
        if SQLTEMP.FieldByName('CODST1').IsNull = false then
        begin
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'Select * from EstSt1 where CodSt1 = ' + QuotedStr(SQLTEMP.FieldByName('CODST1').AsString);
          SQLTEMP2.Active := True;

          REPLIC_ST1.Params[0].Value := SQLTEMP2.FieldByName('CODST1').AsString;
          REPLIC_ST1.Params[1].Value := SQLTEMP2.FieldByName('NOMST1').AsString;
          REPLIC_ST1.ExecProc;
        end;

        //Verificando ST2
        if SQLTEMP.FieldByName('CODST2').IsNull = false then
        begin
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'Select * from EstSt2 where CodSt2 = ' + QuotedStr(SQLTEMP.FieldByName('CODST2').AsString);
          SQLTEMP2.Active := True;
          REPLIC_ST2.Params[0].Value := SQLTEMP2.FieldByName('CODST2').AsString;
          REPLIC_ST2.Params[1].Value := SQLTEMP2.FieldByName('NOMST2').AsString;
          REPLIC_ST2.ExecProc;
        end;

        //Replicando ICMS
        REPLIC_ICM.Params[0].Value := SQLTEMP.FieldByName('CODICM').AsString;
        REPLIC_ICM.Params[1].Value := SQLTEMP.FieldByName('TIPICM').AsString;
        REPLIC_ICM.Params[2].Value := SQLTEMP.FieldByName('NOMICM').AsString;
        REPLIC_ICM.Params[3].Value := SQLTEMP.FieldByName('TRBICM').AsString;
        REPLIC_ICM.Params[4].Value := SQLTEMP.FieldByName('PERICM').value;
        REPLIC_ICM.Params[5].Value := SQLTEMP.FieldByName('REDICM').value;
        REPLIC_ICM.Params[6].Value := SQLTEMP.FieldByName('RECICM').value;
        REPLIC_ICM.Params[7].Value := SQLTEMP.FieldByName('BASICM').value;
        REPLIC_ICM.Params[8].Value := SQLTEMP.FieldByName('INCREV').value;
        REPLIC_ICM.Params[9].Value := SQLTEMP.FieldByName('INCFIN').value;
        REPLIC_ICM.Params[10].Value := SQLTEMP.FieldByName('ITECON').AsString;
        REPLIC_ICM.Params[11].Value := SQLTEMP.FieldByName('CODST1').value;
        REPLIC_ICM.Params[12].Value := SQLTEMP.FieldByName('CODST2').value;
        REPLIC_ICM.ExecProc;
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
    FreeAndNil(SQLTEMP2);
  end;

end;

procedure TfmManGDB.ReplicaUnidade(CodUnd: string);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'Select * from EstUnd where CODUND = ' + QuotedStr(CodUnd);
    SQLTEMP.Active := true;

    if ((session.IsAlias('Emerion_01')) and (SQLTEMP.SQL.Count > 0)) then
    begin
      REPLIC_UNIDADE.Params[0].Value := SQLTEMP.FieldByName('CODUND').AsString;
      REPLIC_UNIDADE.Params[1].Value := SQLTEMP.FieldByName('NOMUND').AsString;
      REPLIC_UNIDADE.ExecProc;
    end;
  finally
    FreeAndNil(SqlTemp);
  end;
end;

procedure TfmManGDB.ReplicaMarcas(CodMrc: Integer);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'Select * from EstMrc where CodMrc = ' + QuotedStr(intToStr(CodMrc));
    SQLTEMP.Active := true;

    if ((session.IsAlias('Emerion_01') = True) and (SQLTEMP.SQL.Count > 0)) then
    begin
      REPLIC_MARCA.Params[0].Value := SQLTEMP.FieldByname('CODMRC').Value;
      REPLIC_MARCA.PARAMS[1].Value := SQLTEMP.FieldByname('NOMMRC').AsString;
      REPLIC_MARCA.ExecProc;
    end;
  finally
    FreeAndNIl(SQLTEMP);
  end;
end;

procedure TfmManGDB.ReplicaGrupo(CodGru: string);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.SQL.Text := 'Select * from EstGru where CodGru = ' + QuotedStr(CodGru);
    SQLTEMP.Active := true;

    if ((session.IsAlias('Emerion_01') = true) and (SQLTEMP.SQL.Count > 0)) then
    begin
      REPLIC_GRUPO.Params[0].Value := SQLTEMP.FieldByName('CODGRU').AsString;
      REPLIC_GRUPO.Params[1].Value := SQLTEMP.FieldByName('NOMGRU').AsString;
      REPLIC_GRUPO.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TfmManGDB.ReplicaSubGrupo(CodGru, CodSub: string);
var
  SQLTEMP: TwwQuery;
begin
  try
    SQLTemp := TwwQuery.Create(Self);
    SQLTemp.DatabaseName := 'isade';
    SQLTEMP.Active := False;
    SQLTEMP.SQL.Text := 'Select * from EstSub where CodGru = ' + QuotedStr(CodGru) +
      ' and CodSub = ' + QuotedStr(CodSub);
    SQLTEMP.Active := true;

    if ((session.IsAlias('Emerion_01') = true) and (SQLTEMP.SQL.Count > 0)) then
    begin
      REPLIC_SUBGRUPO.Params[0].Value := SQLTEMP.FieldByName('CODGRU').AsString;
      REPLIC_SUBGRUPO.Params[1].Value := SQLTEMP.FieldByName('CODSUB').AsString;
      REPLIC_SUBGRUPO.Params[2].Value := SQLTEMP.FieldByName('NOMSUB').AsString;
      REPLIC_SUBGRUPO.Params[3].Value := SQLTEMP.FieldByName('NROSUB').Value;
      REPLIC_SUBGRUPO.Params[4].Value := SQLTEMP.FieldByName('QTDPON').Value;
      REPLIC_SUBGRUPO.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TfmManGDB.ReplicaTipoItem(CodTip: Integer);
var
  SQLTENP: Twwquery;
begin
  try
    SQLTENP := TwwQuery.Create(Self);
    SQLTENP.DataBaseName := 'isade';
    SQLTENP.SQL.Text := 'Select * from esttip where codtip = ' + QuotedStr(intToStr(Codtip));
    SQLTENP.Active := True;
    if session.IsAlias('Emerion_01') then
    begin
      try
        REPLIC_TIPOITENS.params[0].Value := SQLTENP.FieldByName('CODTIP').Value;
        REPLIC_TIPOITENS.Params[1].Value := SQLTENP.FieldByName('NOMTIP').AsString;
        REPLIC_TIPOITENS.ExecProc;
      except on E: Exception do
          showmessage(E.message);
      end;
    end;
  finally
    FreeAndNil(SQLTENP);
  end;
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
      Fmsg('Regras não replicadas', 'I');
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
  //Libera : 'L' Permite todas as Situações cadastradas 'B' diferencia entre Regime normal e Simples Nacional

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

procedure TfmManGDB.ReplicaEstIte(CodEmp, CodClp, CodGru, CodSub,
  CodPro: string);
var
  SQLTEMP: Twwquery;
begin
  try
    if (BuscaSimples('EstPar', 'REPLICA_PRECOS', '1=1') = '1') then
    begin
      SQLTEMP := TwwQuery.Create(Self);
      SQLTEMP.DataBaseName := 'isade';
      SQLTEMP.SQL.Text := 'Select vb1ite, vb2ite, vb3ite, vb4ite, vb5ite, VcrIte, MK1ITE, MK2ITE, MK3ITE, MK4ITE, MK5ITE from estite where' + #13 +
        'CodEmp = ' + codemp + ' And codclp = ' + QuotedStr(codclp) + ' and codgru = ' + QuotedStr(codgru) +
        ' and codsub = ' + QuotedStr(codsub) + ' and codpro = ' + QuotedStr(codpro);
      SQLTEMP.Active := True;
      if session.IsAlias('Emerion_01') then
      begin
        try
          REPLIC_ESTITE.ParamByName('CODEMP').AsInteger := strToInt(CODEMP);
          REPLIC_ESTITE.ParamByName('CODCLP').AsString := CODCLP;
          REPLIC_ESTITE.ParamByName('CODGRU').AsString := CODGRU;
          REPLIC_ESTITE.ParamByName('CODSUB').AsString := CODSUB;
          REPLIC_ESTITE.ParamByName('CODPRO').AsString := CODPRO;
          REPLIC_ESTITE.ParamByName('VB1ITE').AsFloat := SQLTEMP.FieldByName('VB1ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('VB2ITE').AsFloat := SQLTEMP.FieldByName('VB2ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('VB3ITE').AsFloat := SQLTEMP.FieldByName('VB3ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('VB4ITE').AsFloat := SQLTEMP.FieldByName('VB4ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('VB5ITE').AsFloat := SQLTEMP.FieldByName('VB5ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('VcrIte').AsFloat := SQLTEMP.FieldByName('VcrIte').AsFloat;
          REPLIC_ESTITE.ParamByName('MK1ITE').AsFloat := SQLTEMP.FieldByName('MK1ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('MK2ITE').AsFloat := SQLTEMP.FieldByName('MK2ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('MK3ITE').AsFloat := SQLTEMP.FieldByName('MK3ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('MK4ITE').AsFloat := SQLTEMP.FieldByName('MK4ITE').AsFloat;
          REPLIC_ESTITE.ParamByName('MK5ITE').AsFloat := SQLTEMP.FieldByName('MK5ITE').AsFloat;

          REPLIC_ESTITE.ExecProc
        except on E: Exception do
            showmessage(E.message);
        end;
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;

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
      messagebox(0, pchar('Não foi encontrado arquivo CONFIG.INI. Favor verifique e tente novamente.'), 'Emerion', mb_ok + MB_ICONINFORMATION);

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

procedure TfmManGDB.ReplicaEstBar(CodClp, CodGru, CodSub, CodPro: string);
var
  SQLTEMP: TQuery;
begin
  SQLTEMP := TQuery.Create(nil);
  try

    SQLTEMP.Active := False;
    SQLTEMP.DataBaseName := 'Isade';
    SQLTEMP.SQL.Text := ' Select CODCLP,CODGRU,CODSUB,CODPRO,SEQBAR,CODBAR,NROBAR,'
      + ' FLGINT,QTDEMB,TIPEMB,CODEMB,CUBEMB,PESEMB,ALTEMB,LAREMB,COMEMB,PESLIQ,PESBRT '
      + ' From EstBar'
      + ' Where EstBar.CodClp = ' + QuotedStr(CodClp)
      + '   and EstBar.CodGru = ' + QuotedStr(CodGru)
      + '   and EstBar.CodSub = ' + QuotedStr(CodSub)
      + '   and EstBar.CodPro = ' + QuotedStr(CodPro);
    SQLTEMP.Active := True;

    SQLTEMP.first;

    if (session.IsAlias('Emerion_01') = true) then
    begin
      while not SQLTEMP.Eof do
      begin

        ReplicaEstEmb(SQLTEMP.FieldByName('CODEMB').AsString);

        REPLIC_ESTBAR.Params[0].Value := SQLTEMP.FieldByName('CODCLP').Value;
        REPLIC_ESTBAR.Params[1].Value := SQLTEMP.FieldByName('CODGRU').Value;
        REPLIC_ESTBAR.Params[2].Value := SQLTEMP.FieldByName('CODSUB').Value;
        REPLIC_ESTBAR.Params[3].Value := SQLTEMP.FieldByName('CODPRO').Value;
        REPLIC_ESTBAR.Params[4].Value := SQLTEMP.FieldByName('SEQBAR').Value;
        REPLIC_ESTBAR.Params[5].Value := SQLTEMP.FieldByName('CODBAR').Value;
        REPLIC_ESTBAR.Params[6].Value := SQLTEMP.FieldByName('NROBAR').Value;
        REPLIC_ESTBAR.Params[7].Value := SQLTEMP.FieldByName('FLGINT').Value;
        REPLIC_ESTBAR.Params[8].Value := SQLTEMP.FieldByName('QTDEMB').Value;
        REPLIC_ESTBAR.Params[9].Value := SQLTEMP.FieldByName('TIPEMB').Value;
        REPLIC_ESTBAR.Params[10].Value := SQLTEMP.FieldByName('CODEMB').Value;
        REPLIC_ESTBAR.Params[11].Value := SQLTEMP.FieldByName('CUBEMB').Value;
        REPLIC_ESTBAR.Params[12].Value := SQLTEMP.FieldByName('PESEMB').Value;
        REPLIC_ESTBAR.Params[13].Value := SQLTEMP.FieldByName('ALTEMB').Value;
        REPLIC_ESTBAR.Params[14].Value := SQLTEMP.FieldByName('LAREMB').Value;
        REPLIC_ESTBAR.Params[15].Value := SQLTEMP.FieldByName('COMEMB').Value;
        REPLIC_ESTBAR.Params[16].Value := SQLTEMP.FieldByName('PESLIQ').Value;
        REPLIC_ESTBAR.Params[17].Value := SQLTEMP.FieldByName('PESBRT').Value;
        REPLIC_ESTBAR.ExecProc;
        //DBEmerion1.Commit;
        SQLTEMP.Next;

      end;
    end;
  finally
    FreeAndnil(SQLTEMP);
  end;
end;

procedure TfmManGDB.ReplicaEstEmb(CodEmb: string);
var
  SQLTEMP: TQuery;
begin
  SQLTEMP := TQuery.Create(nil);
  try

    SQLTEMP.Active := False;
    SQLTEMP.DataBaseName := 'Isade';
    SQLTEMP.SQL.Text := ' Select CodEmb, NomEmb '
      + ' From ESTEMB'
      + ' Where CodEmb = ' + QuotedStr(CodEmb);
    SQLTEMP.Active := True;

    SQLTEMP.first;

    if ((session.IsAlias('Emerion_01') = true) and (SQLTEMP.SQL.Count > 0)) then
    begin

      REPLIC_ESTEMB.Params[0].Value := SQLTEMP.FieldByName('CODEMB').Value;
      REPLIC_ESTEMB.Params[1].Value := SQLTEMP.FieldByName('NOMEMB').Value;

      REPLIC_ESTEMB.ExecProc;

    end;
  finally
    FreeAndnil(SQLTEMP);
  end;

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

    fmManGDB.dbMain.StartTransaction; {Inicia a Transação}

    try
      begin
        ApplyUpdates; {Tenta aplicar as alterações}
        fmManGDB.dbMain.Commit; {confirma todas as alterações fechando a transação}

        result := True;
      end;
    except
      begin
        fmManGDB.dbMain.Rollback; {desfaz as alterações se acontecer um erro}

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

    fmManGDB.dbMain.StartTransaction; {Inicia a Transação}

    try
      begin
        ApplyUpdates; {Tenta aplicar as alterações}
        fmManGDB.dbMain.Commit; {confirma todas as alterações fechando a transação}

        result := True;
      end;
    except
      begin
        fmManGDB.dbMain.Rollback; {desfaz as alterações se acontecer um erro}

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

  if ((DebugHook > 0) and (ParamStr(1) <> 'remoto')) then //remoto
    dbMain.Params.Values['PASSWORD'] := 'FgB@8165'
  else
    dbMain.Params.Values['PASSWORD'] := 'ibsade20';

  if (ParamStr(1) = 'senhaNova') then
    dbMain.Params.Values['PASSWORD'] := 'FgB@8165';

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

function TfmManGDB.getServerName: string;
begin

end;

end.

