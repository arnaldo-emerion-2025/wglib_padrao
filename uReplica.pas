unit uReplica;

interface

uses
        Windows, Dialogs, SysUtils, Classes, Controls, Wwquery, ManGDB, Forms,
        Db, Bbmensag,

        Bbacesso, FileCtrl, inifiles, RDprint, bbfuncao, Printers, WinSpool, ClipBrd,
  Wwdatsrc, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  ScktComp, ExtCtrls, buttons, ShellApi, DBTables, DBClient, Provider,
  Menus;
        
type
    TReplica = class(TDataModule)
    private
    public
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
        procedure ReplicaTipoItem(CodTip: Integer);
        procedure ReplicaGrupo(CodGru: string);
        procedure ReplicaSubGrupo(CodGru, CodSub: string);
    end;

var
  replicaUnit: TReplica;

implementation

procedure TReplica.ReplicaProduto(CodClp, CodGru, CodSub, CodPro: string);
var
  SQLProduto: TwwQuery; //Dados dos Produtos
  SQLTemp: TwwQuery;
begin
  try
    try
      fmManGDB.DBEmerion1.StartTransaction;
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

      //Verificando Unidade de Sa�da
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

      //Verificando ipi de sa�da

      SQLTEMP.Active := False;
      SQLTemp.SQL.Text := 'Select ipis.codtxf as CODTXF ' +
        'from ' +
        'estpro pro ' +
        'left join estipi ipis on ipis.codipi = pro.ipisai and upper(ipis.tipipi) = ' + QuotedStr('SA�DA') +
        ' where ' +
        ' pro.codclp = ' + QuotedStr(SQLProduto.FieldByName('CODCLP').AsString) +
        ' and pro.codgru = ' + QuotedStr(SQLProduto.FieldByName('CODGRU').AsString) +
        ' and pro.codsub = ' + QuotedStr(SQLProduto.FieldByName('CODSUB').AsString) +
        ' and pro.codpro = ' + QuotedStr(SQLProduto.FieldByName('CODPRO').AsString) +
        ' and pro.ipisai = ' + QuotedStr(SQLProduto.FieldByName('IPISAI').AsString);
      SQLTEMP.Active := True;

      ReplicaIPI(SQLProduto.FieldByName('IPISAI').AsString, QuotedStr('Saida'), SQLTemp.FieldByName('CODTXF').AsString);

      //VERIFICANDO A SUBSTITUI��O TRIBUT�RIA DE ENTRADA
      ReplicSTR(SQLProduto.FieldByName('CODSTE').AsString, 'Entrada');

      //VERIFICANDO A SUBSTITUI��O TRIBUT�RIA DE SA�da
      ReplicSTR(SQLProduto.FieldByName('CODSTs').AsString, 'Saida');

      //Atualizando Produtos
      if (SQLProduto.SQL.Count > 0) then
      begin

        fmManGDB.REPLICA_PRODUTOS.params[0].Value := CodSub;
        fmManGDB.REPLICA_PRODUTOS.params[1].Value := CodGru;
        fmManGDB.REPLICA_PRODUTOS.params[2].Value := SQLProduto.FieldByName('DSCPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[3].Value := SQLProduto.FieldByName('CODPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[4].Value := SQLProduto.FieldByName('DSRPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[5].Value := SQLProduto.FieldByName('LOCPRO').AsString;

        if (SQLProduto.FieldByName('CODTIP').IsNull) then
          fmManGDB.REPLICA_PRODUTOS.params[6].clear
        else
          fmManGDB.REPLICA_PRODUTOS.params[6].Value := SQLProduto.FieldByName('CODTIP').Value;

        if (SQLProduto.FieldByName('CODMRC').isnull) then
          fmManGDB.REPLICA_PRODUTOS.params[7].clear
        else
          fmManGDB.REPLICA_PRODUTOS.params[7].Value := SQLProduto.FieldByName('CODMRC').Value;

        fmManGDB.REPLICA_PRODUTOS.params[8].Value := SQLProduto.FieldByName('CODUNE').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[9].Value := SQLProduto.FieldByName('CODUNS').AsString;

        if (SQLProduto.FieldByName('CODCAT').isnull) then
          fmManGDB.REPLICA_PRODUTOS.params[10].clear
        else
          fmManGDB.REPLICA_PRODUTOS.params[10].Value := SQLProduto.FieldByName('CODCAT').Value;

        fmManGDB.REPLICA_PRODUTOS.params[11].Value := SQLProduto.FieldByName('SIMPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[12].Value := SQLProduto.FieldByName('IDEPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[13].Value := SQLProduto.FieldByName('REFPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[14].Value := SQLProduto.FieldByName('NUMPRO').AsString;
        fmManGDB.REPLICA_PRODUTOS.params[15].Value := SQLProduto.FieldByName('QTEPRO').Value;
        fmManGDB.REPLICA_PRODUTOS.params[16].Value := SQLProduto.FieldByName('QTSPRO').Value;

        if (fmManGDB.REPLICA_PRODUTOS.params[17].isnull) then
          fmManGDB.REPLICA_PRODUTOS.params[17].clear
        else
          fmManGDB.REPLICA_PRODUTOS.params[17].Value := SQLProduto.FieldByName('CODCOM').AsString;

        fmManGDB.REPLICA_PRODUTOS.params[18].Value := SQLProduto.FieldByName('QTDVOL').Value;
        fmManGDB.REPLICA_PRODUTOS.params[19].Value := SQLProduto.FieldByName('QTDEMB').Value;
        fmManGDB.REPLICA_PRODUTOS.params[20].Value := SQLProduto.FieldByName('PESCUB').Value;
        fmManGDB.REPLICA_PRODUTOS.params[21].Value := SQLProduto.FieldByName('PESLIQ').Value;
        fmManGDB.REPLICA_PRODUTOS.params[22].Value := SQLProduto.FieldByName('PESBRT').Value;
        fmManGDB.REPLICA_PRODUTOS.params[23].Value := CodClp;
        fmManGDB.REPLICA_PRODUTOS.ExecProc;
        ReplicaEstBar(CODCLP, CODGRU, CODSUB, CODPRO);
        fmManGDB.DBEmerion1.Commit;

      end;
    except on E: Exception do
      begin
        if DebugHook > 0 then
          fMsg(E.Message, 'I')
        else
          fMsg('Produto N�o Replicado', 'I');

        fmManGDB.DBEmerion1.Rollback;
      end;
    end;
  finally
    FreeAndNil(SQLTemp);
    FreeAndNil(SQLProduto);
  end;

end;

procedure TReplica.ReplicaMarcas(CodMrc: Integer);
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
      fmManGDB.REPLIC_MARCA.Params[0].Value := SQLTEMP.FieldByname('CODMRC').Value;
      fmManGDB.REPLIC_MARCA.PARAMS[1].Value := SQLTEMP.FieldByname('NOMMRC').AsString;
      fmManGDB.REPLIC_MARCA.ExecProc;
    end;
  finally
    FreeAndNIl(SQLTEMP);
  end;
end;

procedure TReplica.ReplicaEstBar(CodClp, CodGru, CodSub, CodPro: string);
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

        fmManGDB.REPLIC_ESTBAR.Params[0].Value := SQLTEMP.FieldByName('CODCLP').Value;
        fmManGDB.REPLIC_ESTBAR.Params[1].Value := SQLTEMP.FieldByName('CODGRU').Value;
        fmManGDB.REPLIC_ESTBAR.Params[2].Value := SQLTEMP.FieldByName('CODSUB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[3].Value := SQLTEMP.FieldByName('CODPRO').Value;
        fmManGDB.REPLIC_ESTBAR.Params[4].Value := SQLTEMP.FieldByName('SEQBAR').Value;
        fmManGDB.REPLIC_ESTBAR.Params[5].Value := SQLTEMP.FieldByName('CODBAR').Value;
        fmManGDB.REPLIC_ESTBAR.Params[6].Value := SQLTEMP.FieldByName('NROBAR').Value;
        fmManGDB.REPLIC_ESTBAR.Params[7].Value := SQLTEMP.FieldByName('FLGINT').Value;
        fmManGDB.REPLIC_ESTBAR.Params[8].Value := SQLTEMP.FieldByName('QTDEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[9].Value := SQLTEMP.FieldByName('TIPEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[10].Value := SQLTEMP.FieldByName('CODEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[11].Value := SQLTEMP.FieldByName('CUBEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[12].Value := SQLTEMP.FieldByName('PESEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[13].Value := SQLTEMP.FieldByName('ALTEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[14].Value := SQLTEMP.FieldByName('LAREMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[15].Value := SQLTEMP.FieldByName('COMEMB').Value;
        fmManGDB.REPLIC_ESTBAR.Params[16].Value := SQLTEMP.FieldByName('PESLIQ').Value;
        fmManGDB.REPLIC_ESTBAR.Params[17].Value := SQLTEMP.FieldByName('PESBRT').Value;
        fmManGDB.REPLIC_ESTBAR.ExecProc;
        //DBEmerion1.Commit;
        SQLTEMP.Next;

      end;
    end;
  finally
    FreeAndnil(SQLTEMP);
  end;
end;

procedure TReplica.ReplicaEstIte(CodEmp, CodClp, CodGru, CodSub,
  CodPro: string);
var
  SQLTEMP: Twwquery;
begin
  try
    if (fmManGDB.BuscaSimples('EstPar', 'REPLICA_PRECOS', '1=1') = '1') then
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
          fmManGDB.REPLIC_ESTITE.ParamByName('CODEMP').AsInteger := strToInt(CODEMP);
          fmManGDB.REPLIC_ESTITE.ParamByName('CODCLP').AsString := CODCLP;
          fmManGDB.REPLIC_ESTITE.ParamByName('CODGRU').AsString := CODGRU;
          fmManGDB.REPLIC_ESTITE.ParamByName('CODSUB').AsString := CODSUB;
          fmManGDB.REPLIC_ESTITE.ParamByName('CODPRO').AsString := CODPRO;
          fmManGDB.REPLIC_ESTITE.ParamByName('VB1ITE').AsFloat := SQLTEMP.FieldByName('VB1ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('VB2ITE').AsFloat := SQLTEMP.FieldByName('VB2ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('VB3ITE').AsFloat := SQLTEMP.FieldByName('VB3ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('VB4ITE').AsFloat := SQLTEMP.FieldByName('VB4ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('VB5ITE').AsFloat := SQLTEMP.FieldByName('VB5ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('VcrIte').AsFloat := SQLTEMP.FieldByName('VcrIte').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('MK1ITE').AsFloat := SQLTEMP.FieldByName('MK1ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('MK2ITE').AsFloat := SQLTEMP.FieldByName('MK2ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('MK3ITE').AsFloat := SQLTEMP.FieldByName('MK3ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('MK4ITE').AsFloat := SQLTEMP.FieldByName('MK4ITE').AsFloat;
          fmManGDB.REPLIC_ESTITE.ParamByName('MK5ITE').AsFloat := SQLTEMP.FieldByName('MK5ITE').AsFloat;

          fmManGDB.REPLIC_ESTITE.ExecProc
        except on E: Exception do
            showmessage(E.message);
        end;
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;

end;

procedure TReplica.ReplicaEstEmb(CodEmb: string);
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

      fmManGDB.REPLIC_ESTEMB.Params[0].Value := SQLTEMP.FieldByName('CODEMB').Value;
      fmManGDB.REPLIC_ESTEMB.Params[1].Value := SQLTEMP.FieldByName('NOMEMB').Value;

      fmManGDB.REPLIC_ESTEMB.ExecProc;

    end;
  finally
    FreeAndnil(SQLTEMP);
  end;

end;

procedure TReplica.ReplicaCategoria(codCat: integer);
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
      fmManGDB.REPLIC_CATEGORIAS.Params[0].Value := SQLTemp.FieldByName('CODCAT').Value;
      fmManGDB.REPLIC_CATEGORIAS.Params[1].Value := SQLTemp.FieldByName('NOMCAT').AsString;
      fmManGDB.REPLIC_CATEGORIAS.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TReplica.ReplicSTR(CodStr, TipStr: string);
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
        fmManGDB.REPLIC_ESTSTR.params[0].value := SQLTemp.FieldByName('CODSTR').AsString;
        fmManGDB.REPLIC_ESTSTR.params[1].value := SQLTemp.FieldByName('TIPSTR').AsString;
        fmManGDB.REPLIC_ESTSTR.params[2].value := SQLTemp.FieldByName('NOMSTR').AsString;
        fmManGDB.REPLIC_ESTSTR.ExecProc;
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TReplica.ReplicaUFE(SigUfe, CodStr, TipStr: string);
var
  Replica: string;
  SQLTEMP: TwwQuery;
  SQLTEMP2: TwwQuery;
begin
  try
    try
      fmManGDB.dbEmerion1.Open;

      fmManGDB.dbEmerion1.StartTransaction;

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
              fmManGDB.REPLIC_GERUFE.Params[0].Value := SQLTemp2.fieldbyname('SIGUFE').AsString;
              fmManGDB.REPLIC_GERUFE.Params[1].Value := SQLTemp2.fieldbyname('NOMUFE').AsString;
              fmManGDB.REPLIC_GERUFE.Params[2].Value := SQLTemp2.fieldbyname('DSCUFE').value;
              fmManGDB.REPLIC_GERUFE.Params[3].Value := SQLTemp2.fieldbyname('NROUFE').value;
              fmManGDB.REPLIC_GERUFE.Params[4].Value := SQLTemp2.fieldbyname('SUBTRB').AsString;
              fmManGDB.REPLIC_GERUFE.Params[5].Value := SQLTemp2.fieldbyname('DSCCOM').value;
              fmManGDB.REPLIC_GERUFE.Params[6].Value := SQLTemp2.fieldbyname('QTDICM').value;
              fmManGDB.REPLIC_GERUFE.Params[7].Value := SQLTemp2.fieldbyname('SEQICM').value;
              fmManGDB.REPLIC_GERUFE.Params[8].Value := SQLTemp2.fieldbyname('FLGTRG').AsString;
              fmManGDB.REPLIC_GERUFE.Params[9].Value := SQLTemp2.fieldbyname('QTDPRO').value;
              fmManGDB.REPLIC_GERUFE.Params[10].Value := SQLTemp2.fieldbyname('SEQPRO').value;
              fmManGDB.REPLIC_GERUFE.ExecProc;
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
            fmManGDB.REPLIC_TEXTOFISCAL.Params[0].Value := SQLTemp2.FieldByName('CODTXF').AsString;
            fmManGDB.REPLIC_TEXTOFISCAL.Params[1].Value := SQLTemp2.FieldByName('TIPTXF').AsString;
            fmManGDB.REPLIC_TEXTOFISCAL.Params[2].Value := SQLTemp2.FieldByName('DSRTXF').AsString;
            fmManGDB.REPLIC_TEXTOFISCAL.Params[3].Value := SQLTemp2.FieldByName('DSCTXF').AsString;
            fmManGDB.REPLIC_TEXTOFISCAL.ExecProc;
          end;

          //ESTTME
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTTME where CODTME = ' +
            QuotedStr(SQLTEMP.FieldByName('CODTME').ASString);
          SQLTEMP2.Active := True;

          if (SQLTemp.FieldByName('CODTME').IsNull = False) then
          begin
            fmManGDB.REPLIC_ESTTME.Params[0].Value := SQLTemp2.FieldByName('CODTME').AsString;
            fmManGDB.REPLIC_ESTTME.Params[1].Value := SQLTemp2.FieldByName('NOMTME').AsString;
            fmManGDB.REPLIC_ESTTME.ExecProc;
          end;

          //Replicando ESTSTR
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTSTR where CODSTR = ' + QuotedStr(CodStr) + ' and TIPSTR = ' + QuotedStr(TipStr);
          SQLTEMP2.Active := True;

          fmManGDB.REPLIC_ESTSTR.params[0].Value := SQLTemp2.FieldByName('CODSTR').AsString;
          fmManGDB.REPLIC_ESTSTR.params[1].Value := SQLTemp2.FieldByName('TIPSTR').AsString;
          fmManGDB.REPLIC_ESTSTR.params[2].Value := SQLTemp2.FieldByName('NOMSTR').AsString;
          fmManGDB.REPLIC_ESTSTR.ExecProc;

          //ESTIPI
          if ((SQLTemp.FieldByName('REGIPI').IsNull = FALSE) and (SQLTemp.FieldByName('TIPIPI').IsNull = FALSE)) then
          begin
            SQLTemp2.Active := False;
            SQLTemp2.sql.text := 'Select * from ESTIPI where CODIPI = ' + QuotedStr(SQLTemp.FieldByName('CODIPI').AsString) + ' and REGIPI = ' +
              QuotedStr(SQLTemp.FieldByName('REGIPI').AsString);
            SQLTemp2.Active := True;
            if not SQLTemp2.IsEmpty then
            begin
              fmManGDB.REPLIC_IPI.Params[0].Value := SQLTemp2.fieldbyname('CODIPI').AsString;
              fmManGDB.REPLIC_IPI.Params[1].Value := SQLTemp2.fieldbyname('TIPIPI').AsString;
              fmManGDB.REPLIC_IPI.Params[2].Value := SQLTemp2.fieldbyname('NOMIPI').AsString;
              fmManGDB.REPLIC_IPI.Params[3].Value := SQLTemp2.fieldbyname('REGIPI').AsString;
              fmManGDB.REPLIC_IPI.Params[4].Value := SQLTemp2.fieldbyname('TRBIPI').AsString;
              fmManGDB.REPLIC_IPI.Params[5].Value := SQLTemp2.fieldbyname('PERIPI').value;
              fmManGDB.REPLIC_IPI.Params[6].Value := SQLTemp2.fieldbyname('REDIPI').value;
              fmManGDB.REPLIC_IPI.Params[7].Value := SQLTemp2.fieldbyname('RECIPI').value;
              fmManGDB.REPLIC_IPI.Params[8].Value := SQLTemp2.fieldbyname('BASIPI').value;
              fmManGDB.REPLIC_IPI.Params[9].Value := SQLTemp2.fieldbyname('CLSIPI').AsString;
              fmManGDB.REPLIC_IPI.Params[10].Value := SQLTemp2.fieldbyname('PERIMP').value;
              fmManGDB.REPLIC_IPI.Params[11].Value := SQLTemp2.fieldbyname('CODTXF').AsString;
              fmManGDB.REPLIC_IPI.Params[12].Value := SQLTemp2.fieldbyname('ID_ESTNCM').value;
              fmManGDB.REPLIC_IPI.ExecProc;
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
              fmManGDB.REPLIC_ICM.Params[0].Value := SQLTEMP2.fieldbyname('CODICM').AsString;
              fmManGDB.REPLIC_ICM.Params[1].Value := SQLTEMP2.fieldbyname('TIPICM').AsString;
              fmManGDB.REPLIC_ICM.Params[2].Value := SQLTEMP2.fieldbyname('NOMICM').AsString;
              fmManGDB.REPLIC_ICM.Params[3].Value := SQLTEMP2.fieldbyname('TRBICM').AsString;
              fmManGDB.REPLIC_ICM.Params[4].Value := SQLTEMP2.fieldbyname('PERICM').value;
              fmManGDB.REPLIC_ICM.Params[5].Value := SQLTEMP2.fieldbyname('REDICM').value;
              fmManGDB.REPLIC_ICM.Params[6].Value := SQLTEMP2.fieldbyname('RECICM').value;
              fmManGDB.REPLIC_ICM.Params[7].Value := SQLTEMP2.fieldbyname('BASICM').value;
              fmManGDB.REPLIC_ICM.Params[8].Value := SQLTEMP2.fieldbyname('INCREV').value;
              fmManGDB.REPLIC_ICM.Params[9].Value := SQLTEMP2.fieldbyname('INCFIN').value;
              fmManGDB.REPLIC_ICM.Params[10].Value := SQLTEMP2.fieldbyname('ITECON').AsString;
              fmManGDB.REPLIC_ICM.Params[11].Value := SQLTEMP2.fieldbyname('CODST1').AsString;
              fmManGDB.REPLIC_ICM.Params[12].Value := SQLTEMP2.fieldbyname('CODST2').AsString;
              fmManGDB.REPLIC_ICM.ExecProc;
            end;
          end;

          //Replicando ESTSTR
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'Select * from ESTSTR where CODSTR = ' + QuotedStr(CodStr) +
            ' and TIPSTR = ' + QuotedSTR(TipStr);
          SQLTEMP2.Active := True;

          fmManGDB.REPLIC_ESTSTR.params[0].Value := SQLTEMP2.FieldByName('CODSTR').AsString;
          fmManGDB.REPLIC_ESTSTR.params[1].Value := SQLTEMP2.FieldByName('TIPSTR').AsString;
          fmManGDB.REPLIC_ESTSTR.params[2].Value := SQLTEMP2.FieldByName('NOMSTR').AsString;
          fmManGDB.REPLIC_ESTSTR.ExecProc;

          SQLTEMP.active := false;
          SQLTEMP.SQL.Text := 'select * from estufe where codstr = ' + quotedstr(CodStr) +
            'and tipstr = ' + quotedstr(tipstr) +
            ' and sigufe = ' + quotedstr(SigUfe);
          SQLTEMP.active := true;

          fmManGDB.REPLIC_ESTUFE.Params[0].Value := CodStr;
          fmManGDB.REPLIC_ESTUFE.Params[1].Value := TipStr;
          fmManGDB.REPLIC_ESTUFE.Params[2].Value := SigUfe;

          if not (SQLTEMP.FieldByName('ICMSUB').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[3].Value := SQLTEMP.FieldByName('ICMSUB').Value
          else
            fmManGDB.REPLIC_ESTUFE.Params[3].Clear;

          if not (SQLTEMP.FieldByName('MRGSUB').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[4].Value := SQLTEMP.FieldByName('MRGSUB').Value
          else
            fmManGDB.REPLIC_ESTUFE.Params[4].Clear;

          if not (SQLTEMP.FieldByName('BASESB').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[5].Value := SQLTEMP.FieldByName('BASESB').Value
          else
            fmManGDB.REPLIC_ESTUFE.Params[5].Clear;

          if not (SQLTEMP.FieldByName('CODCFO').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[6].Value := SQLTEMP.FieldByName('CODCFO').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[6].Clear;

          if not (SQLTEMP.FieldByName('REGICM').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[7].Value := SQLTEMP.FieldByName('REGICM').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[7].Clear;

          if not (SQLTEMP.FieldByName('TIPICM').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[8].Value := SQLTEMP.FieldByName('TIPICM').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[8].Clear;

          if not (SQLTEMP.FieldByName('REGIPI').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[9].Value := SQLTEMP.FieldByName('REGIPI').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[9].Clear;

          if not (SQLTEMP.FieldByName('TIPIPI').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[10].Value := SQLTEMP.FieldByName('TIPIPI').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[10].Clear;

          if not (SQLTEMP.FieldByName('CODTXF').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[11].Value := SQLTEMP.FieldByName('CODTXF').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[11].Clear;

          if not (SQLTEMP.FieldByName('CODTME').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[12].Value := SQLTEMP.FieldByName('CODTME').AsString
          else
            fmManGDB.REPLIC_ESTUFE.Params[12].Clear;

          if not (SQLTEMP.FieldByName('DTEENV').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[13].Value := SQLTEMP.FieldByName('DTEENV').AsDateTime
          else
            fmManGDB.REPLIC_ESTUFE.Params[13].Clear;

          if not (SQLTEMP.FieldByName('CODTCL').isNull) then
            fmManGDB.REPLIC_ESTUFE.Params[14].Value := SQLTEMP.FieldByName('CODTCL').Value
          else
            fmManGDB.REPLIC_ESTUFE.Params[14].Clear;

          fmManGDB.REPLIC_ESTUFE.ExecProc;

          fmManGDB.dbEmerion1.Commit;

        end;
      end;
    except
      fmManGDB.dbEmerion1.Rollback;
    end;
  finally
    FreeAndNil(SQLTEMP);
    FreeAndNil(SQLTEMP2);
  end;
end;

procedure TReplica.ReplicaTipoEmbalagem(CodEmb: string);
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
      fmManGDB.Replica_tipoEmbalagem.Params[0].Value := SQLTEMP.FieldByName('CODEMB').asString;
      fmManGDB.Replica_tipoEmbalagem.Params[1].Value := SQLTEMP.FieldByName('NOMEMB').asString;
      fmManGDB.Replica_tipoEmbalagem.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;

end;

procedure TReplica.ReplicaGerUfe(SigUfe: string);
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
        fmManGDB.REPLIC_GERUFE.Params[0].value := SQLTEMP.FieldByName('SIGUFE').AsString;
        fmManGDB.REPLIC_GERUFE.Params[1].value := SQLTEMP.FieldByName('NOMUFE').AsString;
        fmManGDB.REPLIC_GERUFE.Params[2].value := SQLTEMP.FieldByName('DSCUFE').value;
        fmManGDB.REPLIC_GERUFE.Params[3].value := SQLTEMP.FieldByName('NROUFE').value;
        fmManGDB.REPLIC_GERUFE.Params[4].value := SQLTEMP.FieldByName('SUBTRB').AsString;
        fmManGDB.REPLIC_GERUFE.Params[5].value := SQLTEMP.FieldByName('DSCCOM').value;
        fmManGDB.REPLIC_GERUFE.Params[6].value := SQLTEMP.FieldByName('QTDICM').value;
        fmManGDB.REPLIC_GERUFE.Params[7].value := SQLTEMP.FieldByName('SEQICM').value;
        fmManGDB.REPLIC_GERUFE.Params[8].value := SQLTEMP.FieldByName('FLGTRG').AsString;
        fmManGDB.REPLIC_GERUFE.Params[9].value := SQLTEMP.FieldByName('QTDPRO').value;
        fmManGDB.REPLIC_GERUFE.Params[10].value := SQLTEMP.FieldByName('SEQPRO').value;
        fmManGDB.REPLIC_GERUFE.ExecProc;
      except on E: Exception do
          showmessage(E.message);
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;

end;

procedure TReplica.ReplicaIPI(CodIpi, TipIpi, CodTxf: string);
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

          fmManGDB.REPLIC_TEXTOFISCAL.Params[0].Value := SQLTEMP2.FieldByName('CODTXF').AsString;
          fmManGDB.REPLIC_TEXTOFISCAL.Params[1].Value := SQLTEMP2.FieldByName('TIPTXF').AsString;
          fmManGDB.REPLIC_TEXTOFISCAL.Params[2].Value := SQLTEMP2.FieldByName('DSRTXF').AsString;
          fmManGDB.REPLIC_TEXTOFISCAL.Params[3].Value := SQLTEMP2.FieldByName('DSCTXF').AsString;
          fmManGDB.REPLIC_TEXTOFISCAL.ExecProc;
        end;
        //Chamando a procedure de NCM

        if SQLTEMP.FieldByName('ID_ESTNCM').IsNull = false then
        begin
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'select * from ESTNCM where id_EstNcm = ' + QuotedStr(SQLTEMP.FieldByName('Id_EstNcm').AsString);
          SQLTEMP2.Active := True;

          fmManGDB.REPLIC_NCM.Params[0].Value := SQLTEMP2.FieldByName('ID_ESTNCM').Value;
          fmManGDB.REPLIC_NCM.Params[1].Value := SQLTEMP2.FieldByName('NOMNCM').AsString;
          fmManGDB.REPLIC_NCM.Params[2].Value := SQLTEMP2.FieldByName('ID_ESTSEC').Value;
          fmManGDB.REPLIC_NCM.ExecProc;
        end;

        //Chamando procedure de IPI

        fmManGDB.REPLIC_IPI.Params[0].Value := SQLTEMP.FieldByName('CODIPI').AsString;
        fmManGDB.REPLIC_IPI.Params[1].Value := SQLTEMP.FieldByName('TIPIPI').AsString;
        fmManGDB.REPLIC_IPI.Params[2].Value := SQLTEMP.FieldByName('NOMIPI').AsString;
        fmManGDB.REPLIC_IPI.Params[3].Value := SQLTEMP.FieldByName('REGIPI').AsString;
        fmManGDB.REPLIC_IPI.Params[4].Value := SQLTEMP.FieldByName('TRBIPI').AsString;
        fmManGDB.REPLIC_IPI.Params[5].Value := SQLTEMP.FieldByName('PERIPI').Value;
        fmManGDB.REPLIC_IPI.Params[6].Value := SQLTEMP.FieldByName('REDIPI').Value;
        fmManGDB.REPLIC_IPI.Params[7].Value := SQLTEMP.FieldByName('RECIPI').Value;
        fmManGDB.REPLIC_IPI.Params[8].Value := SQLTEMP.FieldByName('BASIPI').Value;
        fmManGDB.REPLIC_IPI.Params[9].Value := SQLTEMP.FieldByName('CLSIPI').AsString;
        fmManGDB.REPLIC_IPI.Params[10].Value := SQLTEMP.FieldByName('PERIMP').Value;
        fmManGDB.REPLIC_IPI.Params[11].Value := SQLTEMP.FieldByName('CODTXF').AsString;
        fmManGDB.REPLIC_IPI.Params[12].Value := SQLTEMP.FieldByName('ID_ESTNCM').Value;
        fmManGDB.REPLIC_IPI.ExecProc;

      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
    FreeAndNil(SQLTEMP2);
  end;
end;

procedure TReplica.ReplicaICM(CodIcm, TipIcm: string);
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

          fmManGDB.REPLIC_ST1.Params[0].Value := SQLTEMP2.FieldByName('CODST1').AsString;
          fmManGDB.REPLIC_ST1.Params[1].Value := SQLTEMP2.FieldByName('NOMST1').AsString;
          fmManGDB.REPLIC_ST1.ExecProc;
        end;

        //Verificando ST2
        if SQLTEMP.FieldByName('CODST2').IsNull = false then
        begin
          SQLTEMP2.Active := False;
          SQLTEMP2.SQL.Text := 'Select * from EstSt2 where CodSt2 = ' + QuotedStr(SQLTEMP.FieldByName('CODST2').AsString);
          SQLTEMP2.Active := True;
          fmManGDB.REPLIC_ST2.Params[0].Value := SQLTEMP2.FieldByName('CODST2').AsString;
          fmManGDB.REPLIC_ST2.Params[1].Value := SQLTEMP2.FieldByName('NOMST2').AsString;
          fmManGDB.REPLIC_ST2.ExecProc;
        end;

        //Replicando ICMS
        fmManGDB.REPLIC_ICM.Params[0].Value := SQLTEMP.FieldByName('CODICM').AsString;
        fmManGDB.REPLIC_ICM.Params[1].Value := SQLTEMP.FieldByName('TIPICM').AsString;
        fmManGDB.REPLIC_ICM.Params[2].Value := SQLTEMP.FieldByName('NOMICM').AsString;
        fmManGDB.REPLIC_ICM.Params[3].Value := SQLTEMP.FieldByName('TRBICM').AsString;
        fmManGDB.REPLIC_ICM.Params[4].Value := SQLTEMP.FieldByName('PERICM').value;
        fmManGDB.REPLIC_ICM.Params[5].Value := SQLTEMP.FieldByName('REDICM').value;
        fmManGDB.REPLIC_ICM.Params[6].Value := SQLTEMP.FieldByName('RECICM').value;
        fmManGDB.REPLIC_ICM.Params[7].Value := SQLTEMP.FieldByName('BASICM').value;
        fmManGDB.REPLIC_ICM.Params[8].Value := SQLTEMP.FieldByName('INCREV').value;
        fmManGDB.REPLIC_ICM.Params[9].Value := SQLTEMP.FieldByName('INCFIN').value;
        fmManGDB.REPLIC_ICM.Params[10].Value := SQLTEMP.FieldByName('ITECON').AsString;
        fmManGDB.REPLIC_ICM.Params[11].Value := SQLTEMP.FieldByName('CODST1').value;
        fmManGDB.REPLIC_ICM.Params[12].Value := SQLTEMP.FieldByName('CODST2').value;
        fmManGDB.REPLIC_ICM.ExecProc;
      end;
    end;
  finally
    FreeAndNil(SQLTEMP);
    FreeAndNil(SQLTEMP2);
  end;

end;

procedure TReplica.ReplicaUnidade(CodUnd: string);
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
      fmManGDB.REPLIC_UNIDADE.Params[0].Value := SQLTEMP.FieldByName('CODUND').AsString;
      fmManGDB.REPLIC_UNIDADE.Params[1].Value := SQLTEMP.FieldByName('NOMUND').AsString;
      fmManGDB.REPLIC_UNIDADE.ExecProc;
    end;
  finally
    FreeAndNil(SqlTemp);
  end;
end;

procedure TReplica.ReplicaTipoItem(CodTip: Integer);
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
        fmManGDB.REPLIC_TIPOITENS.params[0].Value := SQLTENP.FieldByName('CODTIP').Value;
        fmManGDB.REPLIC_TIPOITENS.Params[1].Value := SQLTENP.FieldByName('NOMTIP').AsString;
        fmManGDB.REPLIC_TIPOITENS.ExecProc;
      except on E: Exception do
          showmessage(E.message);
      end;
    end;
  finally
    FreeAndNil(SQLTENP);
  end;
end;

procedure TReplica.ReplicaGrupo(CodGru: string);
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
      fmManGDB.REPLIC_GRUPO.Params[0].Value := SQLTEMP.FieldByName('CODGRU').AsString;
      fmManGDB.REPLIC_GRUPO.Params[1].Value := SQLTEMP.FieldByName('NOMGRU').AsString;
      fmManGDB.REPLIC_GRUPO.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

procedure TReplica.ReplicaSubGrupo(CodGru, CodSub: string);
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
      fmManGDB.REPLIC_SUBGRUPO.Params[0].Value := SQLTEMP.FieldByName('CODGRU').AsString;
      fmManGDB.REPLIC_SUBGRUPO.Params[1].Value := SQLTEMP.FieldByName('CODSUB').AsString;
      fmManGDB.REPLIC_SUBGRUPO.Params[2].Value := SQLTEMP.FieldByName('NOMSUB').AsString;
      fmManGDB.REPLIC_SUBGRUPO.Params[3].Value := SQLTEMP.FieldByName('NROSUB').Value;
      fmManGDB.REPLIC_SUBGRUPO.Params[4].Value := SQLTEMP.FieldByName('QTDPON').Value;
      fmManGDB.REPLIC_SUBGRUPO.ExecProc;
    end;
  finally
    FreeAndNil(SQLTEMP);
  end;
end;

end.
