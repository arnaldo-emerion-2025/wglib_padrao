unit ManEnt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, StdCtrls, ExtCtrls, jpeg, Db, DBTables,
  Wwquery, AdvImage;

type
  TfmManEnt = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    quSql: TwwQuery;
    quSql1: TwwQuery;
    quSql2: TwwQuery;
    dbMain: TDatabase;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var
  fmManEnt: TfmManEnt;

implementation

uses Bbfuncao, Bbmensag, ManGDB, ManBDE;

{$R *.DFM}

procedure TfmManEnt.FormCreate(Sender: TObject);
begin

  Brush.Style := BsClear;

  if not Session.IsAlias('ISade') then begin

     if fMsg('Caminho para os Arquivos não Configurados. Configurar?','S') then begin

        try

           fmManBDE := TfmManBDE.Create(Self);
           fmManBDE.ShowModal;

        finally

           FreeAndNil(fmManBDE);

        end;
        
        if not Session.IsAlias('ISade') then begin

           Application.MessageBox('Caminho de Acesso aos Arquivos não Configurados,'+ #13 +'Acesso as Opções do Sistema não podem ser realizados.','Atenção', MB_OK + MB_ICONINFORMATION);

           Application.Terminate;

        end;

        end
     else
        begin
        Application.Terminate;
     end;
  end;

  Screen.Cursor := crHourglass;

  with dbMain do

       if not Connected then begin

          try
          Connected := True;
          except
             on E: Exception do begin
             fMsg(E.Message,'E');
             Application.Terminate;
          end;

       end;
  end;

  Screen.Cursor := crDefault;

  if not DirectoryExists('C:\Sade') then CreateDir('C:\Sade');
    
  try
    Image1.Picture.LoadFromFile(GEntrar);
  except
    Image1.Picture.Free;
  end;

  {Formato de Datas}
  ShortDateFormat := 'dd/mm/yyyy';
  LongDateFormat  := 'dd/mm/yyyy';

  ShortTimeFormat := 'hh:nn';
  LongTimeFormat  := 'hh:nn';

end;

procedure TfmManEnt.FormShow(Sender: TObject);
var
diasem : string;
dtvenc,dtlanc : TdateTime;
i,diames,difer : integer;
begin

  with quSql,SQL do begin

       Close;
       Text := ' Select * From GerPar';
       Open;
       First;

  end;

  {Lançamento de Titulos Automaticos}

  if not quSql.Eof then begin

     GTmpLog := quSql.FieldbyName('TmpLog').AsInteger;

     {Verifica se a Data da Ultima Atualização no Sistema e Inferior a Data do Sistema
      e se a data se refere a inicio de um novo mes}
     if (Date > quSql.FieldByName('DtAtua').AsDateTime) and (StrToInt(copy(DateToStr(Date),4,02)) <> StrToInt(copy(DateToStr(quSql.FieldByName('DtAtua').AsDateTime),4,02))) then begin

        with quSql,SQL do begin

             Close;
             Text := 'Select * From FinACp';
             Open;
             First;

        end;

        if not quSql.Eof then begin

           Label1.Caption := 'Aguarde. Verificando Lançamento de Titulos...';

           while not quSql.Eof do begin

                 if StrToInt(copy(DateToStr(Date),04,2)) > StrToInt(copy(quSql.FieldbyName('DulACp').AsString,4,2)) then
                    difer := StrToInt(copy(DateToStr(Date),04,2)) - StrToInt(copy(quSql.FieldbyName('DulACp').AsString,4,2))
                 else
                    difer := (StrToInt(copy(DateToStr(Date),04,2)) + 12) - StrToInt(copy(quSql.FieldbyName('DulACp').AsString,4,2));

                 if difer = 0 then difer := 1;

                 for i := 1 to difer do begin

                     quSql1.Close;
                     quSql1.Params.Clear;
                     quSql1.SQL.Clear;
                     quSql1.SQL.Add('Select * from FinACp Where CodEmp = :CodEmp and '+
                                    'NumCpa = :NumCpa and SeqCpa = :SeqCpa');
                     quSql1.Params[0].Name     := 'CodEmp';
                     quSql1.Params[0].DataType := ftString;
                     quSql1.Params[0].Value    := quSql.FieldByName('CodEmp').AsString;
                     quSql1.Params[1].Name     := 'NumCpa';
                     quSql1.Params[1].DataType := ftInteger;
                     quSql1.Params[1].Value    := quSql.FieldByName('NumCpa').AsInteger;
                     quSql1.Params[2].Name     := 'SeqCpa';
                     quSql1.Params[2].DataType := ftInteger;
                     quSql1.Params[2].Value    := quSql.FieldByName('SeqCpa').AsInteger;
                     quSql1.Open;
                     quSql1.First;

                     dtlanc := quSql1.FieldbyName('DulACp').AsDateTime;

                     quSql1.Close;
                     quSql1.Params.Clear;
                     quSql1.SQL.Clear;
                     quSql1.SQL.Add('Select * from FinCpa Where CodEmp = :CodEmp and '+
                                    'NumCpa = :NumCpa and SeqCpa = :SeqCpa');
                     quSql1.Params[0].Name     := 'CodEmp';
                     quSql1.Params[0].DataType := ftString;
                     quSql1.Params[0].Value    := quSql.FieldByName('CodEmp').AsString;
                     quSql1.Params[1].Name     := 'NumCpa';
                     quSql1.Params[1].DataType := ftInteger;
                     quSql1.Params[1].Value    := quSql.FieldByName('NumCpa').AsInteger;
                     quSql1.Params[2].Name     := 'SeqCpa';
                     quSql1.Params[2].DataType := ftInteger;
                     quSql1.Params[2].Value    := quSql.FieldByName('SeqCpa').AsInteger;
                     quSql1.Open;
                     quSql1.First;

                     if not quSql1.Eof then begin

                        if StrToInt(copy(DateToStr(dtlanc),4,2))+1 <= 12 then
                           dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+
                                     fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtlanc),4,2))+1),2)+'/'+
                                     copy(DateToStr(dtlanc),7,4))

                        else
                           dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+'01'+'/'+
                                     IntToStr(StrToInt(copy(DateToStr(dtlanc),7,4))+1));

                       {if (StrToInt(copy(DateToStr(dtlanc),1,2)) < (quSql.FieldByName('VctACp').AsInteger - 1)) or
                           (StrToInt(copy(DateToStr(dtlanc),1,2)) < (quSql.FieldByName('VctACp').AsInteger - 2)) then
                           begin
                           dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+
                                     fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtlanc),4,2))),2)+'/'+
                                     copy(DateToStr(dtlanc),7,4));
                           end
                        else
                           begin
                           if StrToInt(copy(DateToStr(dtlanc),4,2))+1 <= 12 then
                              begin
                              dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+
                                        fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtlanc),4,2))+1),2)+'/'+
                                        copy(DateToStr(dtlanc),7,4));
                              end
                           else
                              begin
                              dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+'01'+'/'+
                                        IntToStr(StrToInt(copy(DateToStr(dtlanc),7,4))+1));
                           end;
                        end;}

                        diames := fUltMes(dtvenc);

                        if quSql.FieldByName('VctACp').AsInteger > Diames then
                           dtvenc := StrToDate(fStrZeros(IntToStr(Diames),2)+'/'+fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtvenc),4,2))),2)+copy(DateToStr(dtvenc),6,5))
                        else
                           dtvenc := StrToDate(fStrZeros(IntToStr(quSql.FieldByName('VctACp').AsInteger),2)+'/'+fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtvenc),4,2))),2)+copy(DateToStr(dtvenc),6,5));

                        if quSql.FieldByName('SitAcp').AsString = 'Modifica Vencimento para a  Sexta-Feira' then begin

                           diasem := fDSemana(dtvenc);

                           if copy(diasem,1,3) = 'Sab' then dtvenc := dtvenc - 1;
                           if copy(diasem,1,3) = 'Dom' then dtvenc := dtvenc - 2;

                        end;

                        if quSql.FieldByName('SitAcp').AsString = 'Modifica Vencimento para a Segunda-Feira' then begin

                           diasem := fDSemana(dtvenc);

                           if copy(diasem,1,3) = 'Sab' then dtvenc := dtvenc + 2;
                           if copy(diasem,1,3) = 'Dom' then dtvenc := dtvenc + 1;

                        end;

                        quSql2.Close;
                        quSql2.Params.Clear;
                        quSql2.SQL.Clear;
                        quSql2.SQL.Add('Select * from FinCpp Where CodEmp = :CodEmp and '+
                                       'NumCpa = :NumCpa and SeqCpa = :SeqCpa and DtvCpp = :DtvCpp');
                        quSql2.Params[0].Name     := 'CodEmp';
                        quSql2.Params[0].DataType := ftString;
                        quSql2.Params[0].Value    := quSql1.FieldByName('CodEmp').AsString;
                        quSql2.Params[1].Name     := 'NumCpa';
                        quSql2.Params[1].DataType := ftInteger;
                        quSql2.Params[1].Value    := quSql1.FieldByName('NumCpa').AsInteger;
                        quSql2.Params[2].Name     := 'SeqCpa';
                        quSql2.Params[2].DataType := ftInteger;
                        quSql2.Params[2].Value    := quSql1.FieldByName('SeqCpa').AsInteger;
                        quSql2.Params[3].Name     := 'DtvCpp';
                        quSql2.Params[3].DataType := ftDateTime;
                        quSql2.Params[3].Value    := dtvenc;
                        quSql2.Open;
                        quSql2.First;

                        if quSql2.Eof then begin

                           quSql2.Close;
                           quSql2.Params.Clear;
                           quSql2.SQL.Clear;
                           quSql2.SQL.Add('Insert Into FinCpp(CodEmp,NumCpa,SeqCpa,NumCpp,PraCpp,'+
                                          'DtvCpp,VlpCpp,CodBan,VjuCpp,VtxCpp,SqpCpp,VppCpp,VjpCpp,'+
                                          'VtpCpp,VdsCpp,TotCpp,VlsCpp,FlpCpp,ObsCpp,FlaCpp) '+
                                          'values(:CodEmp,:NumCpa,:SeqCpa,:NumCpp,:PraCpp,:DtvCpp,'+
                                          ':VlpCpp,:CodBan,:VjuCpp,:VtxCpp,:SqpCpp,:VppCpp,:VjpCpp,'+
                                          ':VtpCpp,:VdsCpp,:TotCpp,:VlsCpp,:FlpCpp,:ObsCpp,:FlaCpp)');
                           quSql2.Params[00].Name     := 'CodEmp';
                           quSql2.Params[00].DataType := ftString;
                           quSql2.Params[00].Value    := quSql1.FieldByName('CodEmp').AsString;
                           quSql2.Params[01].Name     := 'NumCpa';
                           quSql2.Params[01].DataType := ftInteger;
                           quSql2.Params[01].Value    := quSql1.FieldByName('NumCpa').AsInteger;
                           quSql2.Params[02].Name     := 'SeqCpa';
                           quSql2.Params[02].DataType := ftInteger;
                           quSql2.Params[02].Value    := quSql1.FieldByName('SeqCpa').AsInteger;
                           quSql2.Params[03].Name     := 'NumCpp';
                           quSql2.Params[03].DataType := ftInteger;
                           quSql2.Params[03].Value    := quSql1.FieldByName('QtpCpa').AsInteger + 1;
                           quSql2.Params[04].Name     := 'PraCpp';
                           quSql2.Params[04].DataType := ftInteger;
                           quSql2.Params[04].Value    := StrToInt(FloatToStr(dtvenc - quSql1.FieldByName('DteCpa').AsDateTime));
                           quSql2.Params[05].Name     := 'DtvCpp';
                           quSql2.Params[05].DataType := ftDateTime;
                           quSql2.Params[05].Value    := dtvenc;
                           quSql2.Params[06].Name     := 'VlpCpp';
                           quSql2.Params[06].DataType := ftFloat;
                           quSql2.Params[06].Value    := quSql.FieldByName('VlpACp').AsFloat;
                           quSql2.Params[07].Name     := 'CodBan';
                           quSql2.Params[07].DataType := ftInteger;
                           if quSql.FieldByName('CodBan').AsInteger > 0 then
                              quSql2.Params[07].Value := quSql.FieldByName('CodBan').AsInteger
                           else
                              quSql2.Params[07].Value := Null;
                           quSql2.Params[08].Name     := 'VjuCpp';
                           quSql2.Params[08].DataType := ftFloat;
                           quSql2.Params[08].Value    := 0;
                           quSql2.Params[09].Name     := 'VtxCpp';
                           quSql2.Params[09].DataType := ftFloat;
                           quSql2.Params[09].Value    := 0;
                           quSql2.Params[10].Name     := 'SqpCpp';
                           quSql2.Params[10].DataType := ftInteger;
                           quSql2.Params[10].Value    := 0;
                           quSql2.Params[11].Name     := 'VppCpp';
                           quSql2.Params[11].DataType := ftFloat;
                           quSql2.Params[11].Value    := 0;
                           quSql2.Params[12].Name     := 'VjpCpp';
                           quSql2.Params[12].DataType := ftFloat;
                           quSql2.Params[12].Value    := 0;
                           quSql2.Params[13].Name     := 'VtpCpp';
                           quSql2.Params[13].DataType := ftFloat;
                           quSql2.Params[13].Value    := 0;
                           quSql2.Params[14].Name     := 'VdsCpp';
                           quSql2.Params[14].DataType := ftFloat;
                           quSql2.Params[14].Value    := 0;
                           quSql2.Params[15].Name     := 'TotCpp';
                           quSql2.Params[15].DataType := ftFloat;
                           quSql2.Params[15].Value    := 0;
                           quSql2.Params[16].Name     := 'VlsCpp';
                           quSql2.Params[16].DataType := ftFloat;
                           quSql2.Params[16].Value    := 0;
                           quSql2.Params[17].Name     := 'FlpCpp';
                           quSql2.Params[17].DataType := ftString;
                           quSql2.Params[17].Value    := ' ';
                           quSql2.Params[18].Name     := 'ObsCpp';
                           quSql2.Params[18].DataType := ftString;
                           quSql2.Params[18].Value    := ' ';
                           quSql2.Params[19].Name     := 'FlaCpp';
                           quSql2.Params[19].DataType := ftString;
                           quSql2.Params[19].Value    := '*';
                           quSql2.ExecSQL;


                        end;
                     end;
                 end;

                 quSql.Next;

           end;
        end;

        with quSql,SQL do begin

             Close;
             Text := ' Update GerPar Set Dtatua = '''+fDateToSQL(Date)+''', FlgTrg = '''+'*'+'''';
             ExecSQL;

        end;

        end
     else
        begin
        if quSql.FieldByName('DtAtua').AsDateTime > Date then begin

           Label1.Caption := 'Aguarde. Verificando Lançamento de Titulos...';

           if StrToInt(Copy(DateToStr(Date),4,2))+1 <= 12 then
              dtvenc := StrToDate('01'+'/'+fStrZeros(IntToStr(StrToInt(Copy(DateToStr(Date),4,2))+1),2)+'/'+copy(DateToStr(Date),7,4))
           else
              dtvenc := StrToDate('01'+'/'+'01'+'/'+IntToStr(StrToInt(copy(DateToStr(Date),7,4))+1));

           with quSql,SQL do begin

                Close;
                Text := 'Delete From FinCpp '+
                        'Where DtvCpp >= '''+fDateToSQL(dtvenc)+''' and FlaCpp = '''+'*'+''' and '+
                        'not exists(Select * from FinPgp Where FinCpp.CodEmp = FinPgp.CodEmp and '+
                        'FinCpp.NumCpa = FinPgp.NumCpa and FinCpp.SeqCpa = FinPgp.SeqCpa)';
                ExecSQL;

           end;

           with quSql,SQL do begin

                Close;
                Text := ' Update GerPar Set Dtatua = '''+fDateToSQL(Date)+''', FlgTrg = '''+'*'+'''';
                ExecSQL;

           end;

           end
        else
           begin
           if quSql.FieldByName('Dtatua').AsDateTime <> Date then begin

              with quSql,SQL do begin

                   Close;
                   Text := ' Update GerPar Set Dtatua = '''+fDateToSQL(Date)+''', FlgTrg = '''+'*'+'''';
                   ExecSQL;

              end;
           end;
        end;
     end;
  end;

  with quSql,SQL do begin

       Close;
       Text := ' Select * from FinLCp Where QtpLCp > QlcLCp';
       Open;
       First;

  end;

  {Lançamento de Titulos Programados não Finalizados}

  if not quSql.Eof then begin

     Label1.Caption := 'Aguarde. Verificando Titulos Programados...';

     while not quSql.Eof do begin

           difer := quSql.FieldByName('QtpLCp').AsInteger - quSql.FieldByName('QlcLCp').AsInteger;

           for i := 1 to difer do begin

               with quSql1,SQL do begin

                    Close;
                    Text := ' Select * From FinCpp '+
                            ' Where CodEmp = '''+quSql.FieldByName('CodEmp').AsString+''''+
                            '   and NumCpa = '''+IntToStr(quSql.FieldByName('NumCpa').AsInteger)+''''+
                            '   and SeqCpa = '''+IntToStr(quSql.FieldByName('SeqCpa').AsInteger)+''''+
                            ' Order by CodEmp,NumCpa,SeqCpa,NumCpp';
                    Open;
                    Last;

               end;

               if quSql1.FieldbyName('NumCpa').AsInteger > 0 then begin

                  dtlanc := quSql1.FieldbyName('DtvCpp').AsDateTime;

                  with quSql1,SQL do begin

                       Close;
                       Text := ' Select * From FinCpa '+
                               ' Where CodEmp = '''+quSql.FieldByName('CodEmp').AsString+''''+
                               '   and NumCpa = '''+IntToStr(quSql.FieldByName('NumCpa').AsInteger)+''''+
                               '   and SeqCpa = '''+IntToStr(quSql.FieldByName('SeqCpa').AsInteger)+'''';
                       Open;
                       First;

                  end;

                  if not quSql1.Eof then begin

                     if StrToInt(copy(DateToStr(dtlanc),4,2))+1 <= 12 then
                        dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+
                                  fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtlanc),4,2))+1),2)+'/'+
                                  copy(DateToStr(dtlanc),7,4))

                     else
                        dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+'01'+'/'+
                                  IntToStr(StrToInt(copy(DateToStr(dtlanc),7,4))+1));

                    {if (StrToInt(copy(DateToStr(dtlanc),1,2)) < (quSql.FieldbyName('VctLCp').AsInteger - 1)) or
                        (StrToInt(copy(DateToStr(dtlanc),1,2)) < (quSql.FieldbyName('VctLCp').AsInteger - 2)) then
                        begin
                        dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+
                                  fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtlanc),4,2))),2)+'/'+
                                  copy(DateToStr(dtlanc),7,4));
                        end
                     else
                        begin
                        if StrToInt(copy(DateToStr(dtlanc),4,2))+1 <= 12 then
                           begin
                           dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+
                                     fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtlanc),4,2))+1),2)+'/'+
                                     copy(DateToStr(dtlanc),7,4));
                           end
                        else
                           begin
                           dtvenc := StrToDate(copy(DateToStr(Date),1,2)+'/'+'01'+'/'+
                                     IntToStr(StrToInt(copy(DateToStr(dtlanc),7,4))+1));
                        end;
                     end;}

                     diames := fUltMes(dtvenc);

                     if quSql.FieldbyName('VctLCp').AsInteger > Diames then
                        dtvenc := StrToDate(fStrZeros(IntToStr(Diames),2)+'/'+fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtvenc),4,2))),2)+copy(DateToStr(dtvenc),6,5))
                     else
                        dtvenc := StrToDate(fStrZeros(IntToStr(quSql.FieldbyName('VctLCp').AsInteger),2)+'/'+fStrZeros(IntToStr(StrToInt(copy(DateToStr(dtvenc),4,2))),2)+copy(DateToStr(dtvenc),6,5));

                     if quSql.FieldbyName('SitLCp').AsString = 'Modifica Vencimento para a  Sexta-Feira' then begin

                        diasem := fDSemana(dtvenc);

                        if copy(diasem,1,3) = 'Sab' then dtvenc := dtvenc - 1;
                        if copy(diasem,1,3) = 'Dom' then dtvenc := dtvenc - 2;

                     end;

                     if quSql.FieldbyName('SitLCp').AsString = 'Modifica Vencimento para a Segunda-Feira' then begin

                        diasem := fDSemana(dtvenc);

                        if copy(diasem,1,3) = 'Sab' then dtvenc := dtvenc + 2;
                        if copy(diasem,1,3) = 'Dom' then dtvenc := dtvenc + 1;

                     end;

                     diasem := DateToStr(dtvenc);

                     quSql2.Close;
                     quSql2.Params.Clear;
                     quSql2.SQL.Clear;
                     quSql2.SQL.Add('Insert Into FinCpp(CodEmp,NumCpa,SeqCpa,NumCpp,PraCpp,'+
                                    'DtvCpp,VlpCpp,CodBan,VjuCpp,VtxCpp,SqpCpp,VppCpp,VjpCpp,'+
                                    'VtpCpp,VdsCpp,TotCpp,VlsCpp,FlpCpp,ObsCpp,FlaCpp) '+
                                    'values(:CodEmp,:NumCpa,:SeqCpa,:NumCpp,:PraCpp,:DtvCpp,'+
                                    ':VlpCpp,:CodBan,:VjuCpp,:VtxCpp,:SqpCpp,:VppCpp,:VjpCpp,'+
                                    ':VtpCpp,:VdsCpp,:TotCpp,:VlsCpp,:FlpCpp,:ObsCpp,:FlaCpp)');
                     quSql2.Params[00].Name     := 'CodEmp';
                     quSql2.Params[00].DataType := ftString;
                     quSql2.Params[00].Value    := quSql1.FieldByName('CodEmp').AsString;
                     quSql2.Params[01].Name     := 'NumCpa';
                     quSql2.Params[01].DataType := ftInteger;
                     quSql2.Params[01].Value    := quSql1.FieldByName('NumCpa').AsInteger;
                     quSql2.Params[02].Name     := 'SeqCpa';
                     quSql2.Params[02].DataType := ftInteger;
                     quSql2.Params[02].Value    := quSql1.FieldByName('SeqCpa').AsInteger;
                     quSql2.Params[03].Name     := 'NumCpp';
                     quSql2.Params[03].DataType := ftInteger;
                     quSql2.Params[03].Value    := quSql1.FieldByName('QtpCpa').AsInteger + 1;
                     quSql2.Params[04].Name     := 'PraCpp';
                     quSql2.Params[04].DataType := ftInteger;
                     quSql2.Params[04].Value    := StrToInt(FloatToStr(dtvenc - quSql1.FieldByName('DteCpa').AsDateTime));
                     quSql2.Params[05].Name     := 'DtvCpp';
                     quSql2.Params[05].DataType := ftDateTime;
                     quSql2.Params[05].Value    := dtvenc;
                     quSql2.Params[06].Name     := 'VlpCpp';
                     quSql2.Params[06].DataType := ftFloat;
                     quSql2.Params[06].Value    := quSql.FieldByName('VlpLCp').AsFloat;
                     quSql2.Params[07].Name     := 'CodBan';
                     quSql2.Params[07].DataType := ftInteger;
                     if quSql.FieldByName('CodBan').AsInteger > 0 then
                        quSql2.Params[07].Value := quSql.FieldByName('CodBan').AsInteger
                     else
                        quSql2.Params[07].Value := Null;
                     quSql2.Params[08].Name     := 'VjuCpp';
                     quSql2.Params[08].DataType := ftFloat;
                     quSql2.Params[08].Value    := 0;
                     quSql2.Params[09].Name     := 'VtxCpp';
                     quSql2.Params[09].DataType := ftFloat;
                     quSql2.Params[09].Value    := 0;
                     quSql2.Params[10].Name     := 'SqpCpp';
                     quSql2.Params[10].DataType := ftInteger;
                     quSql2.Params[10].Value    := 0;
                     quSql2.Params[11].Name     := 'VppCpp';
                     quSql2.Params[11].DataType := ftFloat;
                     quSql2.Params[11].Value    := 0;
                     quSql2.Params[12].Name     := 'VjpCpp';
                     quSql2.Params[12].DataType := ftFloat;
                     quSql2.Params[12].Value    := 0;
                     quSql2.Params[13].Name     := 'VtpCpp';
                     quSql2.Params[13].DataType := ftFloat;
                     quSql2.Params[13].Value    := 0;
                     quSql2.Params[14].Name     := 'VdsCpp';
                     quSql2.Params[14].DataType := ftFloat;
                     quSql2.Params[14].Value    := 0;
                     quSql2.Params[15].Name     := 'TotCpp';
                     quSql2.Params[15].DataType := ftFloat;
                     quSql2.Params[15].Value    := 0;
                     quSql2.Params[16].Name     := 'VlsCpp';
                     quSql2.Params[16].DataType := ftFloat;
                     quSql2.Params[16].Value    := 0;
                     quSql2.Params[17].Name     := 'FlpCpp';
                     quSql2.Params[17].DataType := ftString;
                     quSql2.Params[17].Value    := ' ';
                     quSql2.Params[18].Name     := 'ObsCpp';
                     quSql2.Params[18].DataType := ftString;
                     quSql2.Params[18].Value    := ' ';
                     quSql2.Params[19].Name     := 'FlaCpp';
                     quSql2.Params[19].DataType := ftString;
                     quSql2.Params[19].Value    := ' ';
                     quSql2.ExecSQL;

                  end;
               end;
           end;

           quSql.Next;

     end;
  end;

  with quSql,SQL do begin

       Close;
       Text := ' Delete from FinLCp Where QtpLCp = QlcLCp';
       ExecSQL;

  end;

  dbMain.Connected := False;

end;

end.
