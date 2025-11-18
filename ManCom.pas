unit ManCom;

interface

uses
  SysUtils, Classes, Controls, Forms, Graphics,
  Fpadrao, ExtCtrls, Wwdbigrd, Wwdbgrid, hGrid, dxCntner, dxExEdtr,
  dxEdLib, dxDBELib, Db, Wwdatsrc, DBTables, Wwquery, dxEditor, StdCtrls,
  dxDBColorCurrencyEdit, dxDBColorEdit, Grids;

type
  TfmManCom = class(TfmPadrao)
    PaintBox: TPaintBox;
    grPro: TdxDBGraphicEdit;
    grCom: ThGrid;
    FinCom: TwwQuery;
    FinComCODCOM: TStringField;
    FinComPERCOM: TFloatField;
    DsCom: TwwDataSource;
    EdCodCom: TdxDBColorEdit;
    EdPerCom: TdxDBColorCurrencyEdit;
    FinComSEQCOM: TIntegerField;
    FinComFLGTRG: TStringField;
    UpCom: TUpdateSQL;
    quSQL: TwwQuery;
    dxDBGraphicEdit1: TdxDBGraphicEdit;
    Panel3: TPanel;
    Label1: TLabel;
    procedure PaintBoxPaint(Sender: TObject);
    procedure grComKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FinComNewRecord(DataSet: TDataSet);
    procedure EdCodComExit(Sender: TObject);
    procedure EdPerComExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    {Private declarations}
    pSaida: string;
  public
    {Public declarations}
  end;

var
  fmManCom: TfmManCom;

implementation

uses dxDemoUtils, Bbmensag, ManGDB;

{$R *.DFM}

procedure TfmManCom.PaintBoxPaint(Sender: TObject);
begin
  inherited;
  with Sender as TPaintBox do
    FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManCom.grComKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  SeqCom: integer;
begin
  if key = 13 then
  begin {Tecla - ENTER}

    EdPerCom.Enabled := True;

    EdPerCom.Font.Style := [];

    EdPerCom.SetFocus;

  end;

  if key = 40 then
  begin {Tecla - Seta para Baixo}

    with quSQL, SQL do
    begin

      Close;
      Text := ' Select Count(*) as Reg From FinCom';
      Open;

    end;

    if FinComSeqCom.Value = quSQL.FieldbyName('Reg').AsInteger then
    begin

      if Trim(UpperCase(GLibAce)) = 'SIM' then
        FinCom.Append
      else
        fmsgErro(GMensagem, nil);

    end;
  end;

  if key = 46 then
  begin {Tecla - DEL}

    if Trim(UpperCase(GLibAce)) = 'SIM' then
    begin

      if FinComSeqCom.Value > 0 then
      begin

        try

          SeqCom := FinComSeqCom.Value;

          FinCom.Delete;

          FinCom.ApplyUpdates;

          FinCom.Close;
          FinCom.Open;

          with quSQL, SQL do
          begin

            Close;
            Text := ' Select Count(*) as Reg From FinCom';
            Open;

          end;

          if SeqCom < quSQL.FieldbyName('Reg').AsInteger then
            FinCom.Locate('SeqCom', VarArrayOf([SeqCom]), [LoPartialKey])
          else
          begin

            if quSQL.FieldbyName('Reg').AsInteger = 0 then
              FinCom.Append
            else
              FinCom.Last;

          end;

        except

          FinCom.CancelUpdates;

          grCom.SetFocus;

        end;
      end;

    end
    else
      fmsgErro(GMensagem, nil);

  end;
end;

procedure TfmManCom.FinComNewRecord(DataSet: TDataSet);
begin
  inherited;

  FinCom.DisableControls;

  with quSQL, SQL do
  begin

    Close;
    Text := ' Select Count(*) as Reg From FinCom';
    Open;

  end;

  FinComPerCom.Value := 0;
  FinComFlgTrg.Value := ' ';
  FinComSeqCom.Value := quSQL.FieldbyName('Reg').AsInteger;

  FinCom.EnableControls;

  grCom.Enabled := False;

  EdCodCom.Enabled := True;
  EdPerCom.Enabled := True;

  EdCodCom.Font.Style := [];
  EdPerCom.Font.Style := [];

  EdCodCom.SetFocus;

end;

procedure TfmManCom.EdCodComExit(Sender: TObject);
var
  saida: boolean;
begin
  inherited;
  if (Tecla <> 'ESC') and (Tecla <> 'UP') then
  begin

    if not EdCodCom.Focused then
      saida := True
    else
      saida := False;

    if saida then
    begin

      if pSaida = 'Sim' then
      begin

        if FinCom.State <> dsBrowse then
        begin

          if Trim(FinComCodCom.Value) = '' then
            fmsgErro('Campo de Preenchimento Obrigatorio não Informado.', EdCodCom);

        end
        else
        begin

          if EdCodCom.Enabled then
          begin

            if Trim(FinComCodCom.Value) = '' then
              fmsgErro('Campo de Preenchimento Obrigatorio não Informado.', EdCodCom);

          end;
        end;
      end;
    end;

  end
  else
  begin

    if Tecla = 'UP' then
    begin

      with quSQL, SQL do
      begin

        Close;
        Text := ' Select Count(*) as QtdReg From FinCom';
        Open;

      end;

      if quSQL.FieldbyName('QtdReg').AsInteger > 0 then
      begin

        pSaida := 'Nao';

        EdCodCom.Enabled := False;
        EdPerCom.Enabled := False;

        EdCodCom.Font.Style := [fsBold];
        EdPerCom.Font.Style := [fsBold];

        if FinCom.State <> dsBrowse then
          FinCom.CancelUpdates
        else
        begin

          if not FinCom.Bof then
            FinCom.Prior;

        end;

        pSaida := 'Sim';

        grCom.Enabled := True;

        grCom.SetFocus;

      end
      else
        EdCodCom.SetFocus;
    end;
  end;
end;

procedure TfmManCom.EdPerComExit(Sender: TObject);
var
  SeqCom: integer;
begin
  inherited;
  if (Tecla = 'TAB') or (Tecla = 'ENTER') or (Tecla = 'DOWN') then
  begin

    if FinCom.State <> dsBrowse then
    begin

      if FinCom.State = dsInsert then
      begin

        try

          FinCom.ApplyUpdates;

          FinCom.Close;
          FinCom.Open;

          FinCom.Append;

        except

          FinCom.Edit;

        end;

        EdCodCom.SetFocus;

      end
      else
      begin

        try

          SeqCom := FinComSeqCom.Value;

          FinCom.ApplyUpdates;

          FinCom.Close;
          FinCom.Open;

          FinCom.Locate('SeqCom', SeqCom, []);

          with quSQL, SQL do
          begin

            Close;
            Text := ' Select Count(*) as Reg From FinCom';
            Open;

          end;

          if FinComSeqCom.Value = quSQL.FieldbyName('Reg').AsInteger then
            FinCom.Append
          else
          begin

            FinCom.Next;

            pSaida := 'Nao';

            EdCodCom.Enabled := False;
            EdPerCom.Enabled := False;

            EdCodCom.Font.Style := [fsBold];
            EdPerCom.Font.Style := [fsBold];

            pSaida := 'Sim';

            grCom.Enabled := True;

            grCom.SetFocus;

          end;

        except

          FinCom.Edit;

          EdCodCom.SetFocus;

        end;
      end;

    end
    else
    begin

      pSaida := 'Nao';

      EdCodCom.Enabled := False;
      EdPerCom.Enabled := False;

      EdCodCom.Font.Style := [fsBold];
      EdPerCom.Font.Style := [fsBold];

      pSaida := 'Sim';

      grCom.Enabled := True;

      grCom.SetFocus;

    end;
  end;
end;

procedure TfmManCom.FormShow(Sender: TObject);
begin
  inherited;
  grCom.SetFocus;
end;

procedure TfmManCom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := CaFree;
end;

procedure TfmManCom.FormDestroy(Sender: TObject);
begin
  inherited;
  fmManCom := nil;
end;

procedure TfmManCom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 27 then
  begin

    if EdCodCom.Enabled then
    begin

      if FinCom.State <> dsBrowse then
        FinCom.CancelUpdates;

      pSaida := 'Nao';

      EdCodCom.Enabled := False;
      EdPerCom.Enabled := False;

      EdCodCom.Font.Style := [fsBold];
      EdPerCom.Font.Style := [fsBold];

      pSaida := 'Sim';

      grCom.Enabled := True;

      grCom.SetFocus;

    end
    else
      close;
  end;
end;

procedure TfmManCom.FormCreate(Sender: TObject);
begin
  inherited;
  pSaida := 'Sim';
end;

end.
