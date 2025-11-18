unit SadReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxCntner, dxEditor, dxEdLib, StdCtrls, Buttons, dxfLabel, Db,
  DBTables, Wwquery, dxExEdtr, dxDBELib, DrLabel, dxDBColorMemo,
  dxColorEdit;

type
  TfmSadReg = class(TForm)
    Panel1: TPanel;
    bgravar: TBitBtn;
    bcancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EdSeq1: TdxColorEdit;
    EdSeq2: TdxColorEdit;
    EdSeq3: TdxColorEdit;
    EdSeq4: TdxColorEdit;
    EdSeq5: TdxColorEdit;
    EdSen1: TdxColorEdit;
    EdSen2: TdxColorEdit;
    EdSen3: TdxColorEdit;
    EdSen4: TdxColorEdit;
    EdSen5: TdxColorEdit;
    quSql: TwwQuery;
    EdObsCli: TdxDBColorMemo;
    EdMemo: TMemo;
    DRLabel1: TDRLabel;
    DRLabel2: TDRLabel;
    DRLabel3: TDRLabel;
    DRLabel4: TDRLabel;
    Shape1: TShape;
    StoredProc: TStoredProc;
    procedure bcancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure EdSen1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdSen2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdSen3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdSen4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdSen5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DRLabel1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var
  fmSadReg: TfmSadReg;

implementation

uses ShellAPI, Bbgeral, Bbfuncao, Bbmensag, ManGDB;

{$R *.DFM}

procedure TfmSadReg.bcancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfmSadReg.FormShow(Sender: TObject);
var
  sequenc: string;
  cForm: TComponent;
begin

  cForm := FindComponent('fmSadReg');

  if (cForm <> nil) then
  begin

    TForm(cForm).WindowState := wsNormal;
    TForm(cForm).BringToFront;

  end;

  with quSQL, SQL do
  begin

    Close;
    Text := ' Select * From GerPar';
    Open;

  end;

  sequenc := fEnCripto(quSql.FieldbyName('IdePar').AsString, 'D');

  EdSeq1.Text := copy(sequenc, 01, 6);
  EdSeq2.Text := copy(sequenc, 07, 6);
  EdSeq3.Text := copy(sequenc, 13, 6);
  EdSeq4.Text := copy(sequenc, 19, 6);
  EdSeq5.Text := copy(sequenc, 25, 6);

  EdSen1.Text;

end;

procedure TfmSadReg.EdSen1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key <> 13) and (key <> 27) and (key <> 40) and (key <> 38) and (key <> 46) then
  begin

    if Length(Trim(EdSen1.Text)) = 10 then
      EdSen2.SetFocus;

  end;
end;

procedure TfmSadReg.EdSen2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key <> 13) and (key <> 27) and (key <> 40) and (key <> 38) and (key <> 46) then
  begin

    if Length(Trim(EdSen2.Text)) = 10 then
      EdSen3.SetFocus;

  end;
end;

procedure TfmSadReg.EdSen3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key <> 13) and (key <> 27) and (key <> 40) and (key <> 38) and (key <> 46) then
  begin

    if Length(Trim(EdSen3.Text)) = 10 then
      EdSen4.SetFocus;

  end;
end;

procedure TfmSadReg.EdSen4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key <> 13) and (key <> 27) and (key <> 40) and (key <> 38) and (key <> 46) then
  begin

    if Length(Trim(EdSen4.Text)) = 9 then
      EdSen5.SetFocus;

  end;
end;

procedure TfmSadReg.EdSen5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key <> 13) and (key <> 27) and (key <> 40) and (key <> 38) and (key <> 46) then
  begin

    if Length(Trim(EdSen5.Text)) = 10 then
      bgravar.SetFocus;

  end;
end;

procedure TfmSadReg.bgravarClick(Sender: TObject);
var
  ret, rSequenc1, rSequenc2: string;
begin
  if fMsg('Confirma as Informações de No. Serial para o Registro do Software?', 'S') then
  begin

    if Length(Trim(EdSen1.Text)) < 11 then
      fmsgErro('Número Serial Informado Incorreto', EdSen1);
    if Length(Trim(EdSen2.Text)) < 11 then
      fmsgErro('Número Serial Informado Incorreto', EdSen2);
    if Length(Trim(EdSen3.Text)) < 11 then
      fmsgErro('Número Serial Informado Incorreto', EdSen3);
    if Length(Trim(EdSen4.Text)) < 10 then
      fmsgErro('Número Serial Informado Incorreto', EdSen4);
    if Length(Trim(EdSen5.Text)) < 11 then
      fmsgErro('Número Serial Informado Incorreto', EdSen5);

    rSequenc1 := EdSeq1.Text + EdSeq2.Text + EdSeq3.Text + copy(EdSeq4.Text, 1, 9) + EdSeq5.Text;
    rSequenc2 := EdSen1.Text + EdSen2.Text + EdSen3.Text + copy(EdSen4.Text, 1, 9) + EdSen5.Text;

    if not fmManGDB.dbMain.InTransaction then
      fmManGDB.dbMain.StartTransaction;

    with StoredProc do
    begin

      ParamByName('NRSEQ1').AsString := rSequenc1;
      ParamByName('NRSEQ2').AsString := rSequenc2;
      Close;
      Prepare;
      ExecProc;
      Unprepare;

      if ParamByName('RETORNO').Value <> null then
      begin

        ret := UpperCase(ParamByName('RETORNO').Value);

        if ret = 'FLC' then
        begin

          rSequenc2 := fEnCripto(EdSen1.Text + EdSen2.Text + EdSen3.Text + EdSen4.Text + EdSen5.Text, 'C');

          with quSQL, SQL do
          begin

            Close;
            Text := ' Update GerPar Set Flgtrg = ''' + '*' + ''',' +
              '                   FlgSeq = ''' + 'Nao' + ''',' +
              '                   ParLib = ''' + rSequenc2 + '''';
            ExecSQL;

          end;
        end;

        fmManGDB.dbMain.Commit

      end
      else
        fmManGDB.dbMain.Rollback;
    end;

    if ret <> 'FLC' then
    begin

      if ret = 'ER1' then
        fmsgErro('Chave de Identificação Informada Esta Incompleta', EdSen1);
      if ret = 'ER2' then
        fmsgErro('Existem Caracteres Invalidos na Chave de Identificação Informada', EdSen1);
      if ret = 'ER3' then
        fmsgErro('Serial Informado Invalido. Consulte o Administrador do Software', EdSen1);
      if ret = 'ER4' then
        fmsgErro('Serial não Pode ser Confirmado. Consulte o Administrador do Software', EdSen1);

    end
    else
      close;
  end;
end;

procedure TfmSadReg.DRLabel1Click(Sender: TObject);
var
  cEmail, Sequenc: string;
begin

  Sequenc := EdSeq1.Text + '.' + EdSeq2.Text + '.' + EdSeq3.Text + '.' + EdSeq4.Text + '.' + EdSeq5.Text;

  cEMail := 'mailto:' + Trim(DRLabel1.Caption) + ' <' + Trim(DRLabel1.Caption) + '>';

  cEmail := cEmail + '?subject=Registro Emerion&body= Chave de Identificação :' + sequenc;

  ShellExecute(handle, 'Open', PChar(cEmail), '', '', SW_SHOWNORMAL);

end;

procedure TfmSadReg.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
