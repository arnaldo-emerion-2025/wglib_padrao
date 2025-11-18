unit ManAce;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FPadrao, Db, DBTables, Grids, Wwdbigrd, Wwdbgrid, hGrid, dxCntner, dxEditor,
  dxExEdtr, dxDBEdtr, dxDBELib, Wwquery, StdCtrls, wwdblook, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls, Wwdatsrc, Buttons, dxDBTLCl,
  dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxEdLib;

type
  TfmManAce = class(TfmPadrao)
    DsAce: TDataSource;
    UpAce: TUpdateSQL;
    GerAce: TwwQuery;
    GerAceCODGUS: TIntegerField;
    GerAceCODTRA: TStringField;
    GerAceTIPTRA: TStringField;
    GerAceTIPACE: TStringField;
    GerAceNOMTRA: TStringField;
    GerGUs: TwwQuery;
    GerGUsCODGUS: TIntegerField;
    GerGUsNOMGUS: TStringField;
    dsGus: TwwDataSource;
    GerAceMENTRA: TStringField;
    PaintBox: TPaintBox;
    Label10: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Bevel2: TBevel;
    Bbfechar: TBitBtn;
    BbCancela: TBitBtn;
    Bbgravar: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    grAce: TdxDBGrid;
    grAceTRANSACAO: TdxDBGridColumn;
    grAceTIPACE: TdxDBGridPickColumn;
    Panel4: TPanel;
    grGUs: TdxDBGrid;
    grGUsNOMGUS: TdxDBGridMaskColumn;
    grGUsCODGUS: TdxDBGridMaskColumn;
    GerAceACEDEF: TStringField;
    GerAceSEQTRA: TIntegerField;
    GerAceOUTTRA: TStringField;
    dbRes: TdxDBGraphicEdit;
    dxDBGraphicEdit1: TdxDBGraphicEdit;
    GerAceFLGTRG: TStringField;
    GerAceTRANSACAO: TStringField;
    GerAceTIPOUT: TStringField;
    procedure FormShow(Sender: TObject);
    procedure dsGusDataChange(Sender: TObject; Field: TField);
    procedure GerAceBeforeEdit(DataSet: TDataSet);
    procedure BbgravarClick(Sender: TObject);
    procedure BbCancelaClick(Sender: TObject);
    procedure BbfecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBoxPaint(Sender: TObject);
    procedure DsAceDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
    procedure GerAceTRANSACAOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var

  fmManAce: TfmManAce;

implementation

uses dxDemoUtils, Bbmensag, ManGDB, ManPri;

{$R *.DFM}

procedure TfmManAce.FormShow(Sender: TObject);
begin

  if not fmManGDB.dbMain.InTransaction then
    fmManGDB.dbMain.StartTransaction;

  grGUs.SetFocus;

  GerAce.close;
  GerAce.Params[0].AsString := GModAce;
  GerAce.Params[1].AsInteger := GerGUsCodGUs.Value;
  GerAce.Open;

end;

procedure TfmManAce.dsGusDataChange(Sender: TObject; Field: TField);
var
  CodTra, TipTra: string;
begin
  inherited;
  if GerGUsCodGus.Value <> GerAceCodGus.Value then
  begin

    CodTra := GerAceCodTra.Value;
    TipTra := GerAceTipTra.Value;

    GerAce.Close;
    GerAce.Params[0].AsString := GModAce;
    GerAce.Params[1].AsInteger := GerGUsCodGUs.Value;
    GerAce.Open;

    GerAce.Locate('CodTra;TipTra', VarArrayOf([CodTra, TipTra]), [loPartialKey]);

  end;
end;

procedure TfmManAce.GerAceBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  grGUs.Enabled := False;

  Bbgravar.Enabled := True;
  BbCancela.Enabled := True;

end;

procedure TfmManAce.BbgravarClick(Sender: TObject);
begin
  inherited;
  if Trim(UpperCase(GLibAce)) = 'SIM' then
  begin

    GerAce.ApplyUpdates;

    fmManGDB.dbMain.Commit;

    if not fmManGDB.dbMain.InTransaction then
      fmManGDB.dbMain.StartTransaction;

    Bbgravar.Enabled := False;
    BbCancela.Enabled := False;

    grGUs.Enabled := True;

    grGUs.SetFocus;

  end
  else
    fmsgErro(GMensagem_0001, nil);

end;

procedure TfmManAce.BbCancelaClick(Sender: TObject);
begin
  inherited;

  GerAce.CancelUpdates;

  fmManGDB.dbMain.Rollback;

  if not fmManGDB.dbMain.InTransaction then
    fmManGDB.dbMain.StartTransaction;

  Bbgravar.Enabled := False;
  BbCancela.Enabled := False;

  grGUs.Enabled := True;

  grGUs.SetFocus;

end;

procedure TfmManAce.BbfecharClick(Sender: TObject);
begin
  inherited;

  if GerAce.State <> dsBrowse then
    GerAce.CancelUpdates;

  Close;

end;

procedure TfmManAce.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  fmManGDB.dbMain.Rollback;

  Action := CaFree;

end;

procedure TfmManAce.PaintBoxPaint(Sender: TObject);
begin
  inherited;
  with Sender as TPaintBox do
    FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManAce.DsAceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (GerAceCODTRA.Value = 'bRetornar') or (GerAceCODTRA.Value = 'bLiberar') or (GerAceCODTRA.Value = 'bVisualizar') then
  begin
    grAceTIPACE.Items.Clear;
    grAceTipAce.Items.Add('0-Negado');
    grAceTipAce.Items.Add('8-Livre');
  end
  else
  begin
    grAceTipAce.Items.Clear;
    grAceTipAce.Items.Add('0-Negado');
    grAceTipAce.Items.Add('1-Inserir');
    grAceTipAce.Items.Add('2-Inserir e Alterar');
    grAceTipAce.Items.Add('3-Inserir e Excluir');
    grAceTipAce.Items.Add('4-Alterar');
    grAceTipAce.Items.Add('5-Alterar e Excluir');
    grAceTipAce.Items.Add('6-Somente Leitura');
    grAceTipAce.Items.Add('7-Excluir');
    grAceTipAce.Items.Add('8-Livre');
  end;
  {  if Trim(GerAceCodTra.Value) <> '' then begin

       if GerAceMenTra.Value = '*' then begin

          grAceTipAce.Items.Clear;

          if GerAceAceDef.Value = '*' then
             grAceTipAce.Items.Add('8-Livre')
          else
             begin

             grAceTipAce.Items.Add('0-Negado');
             grAceTipAce.Items.Add('8-Livre');

          end;

          end
       else
          begin

          if Trim( GerAceOutTra.Value ) <> '' then begin

             grAceTipAce.Items.Clear;
             grAceTipAce.Items.Add(GerAceTipAce.Value);

             end
          else
             begin

             grAceTipAce.Items.Clear;
             grAceTipAce.Items.Add('0-Negado');
             grAceTipAce.Items.Add('1-Inserir');
             grAceTipAce.Items.Add('2-Inserir e Alterar');
             grAceTipAce.Items.Add('3-Inserir e Excluir');
             grAceTipAce.Items.Add('4-Alterar');
             grAceTipAce.Items.Add('5-Alterar e Excluir');
             grAceTipAce.Items.Add('6-Somente Leitura');
             grAceTipAce.Items.Add('7-Excluir');
             grAceTipAce.Items.Add('8-Livre');

          end;
       end;
     end;}
end;

procedure TfmManAce.FormDestroy(Sender: TObject);
begin
  inherited;
  fmManAce := nil;
end;

procedure TfmManAce.GerAceTRANSACAOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  Modulo: string;
begin
  inherited;

  if Trim(GerAceTipOut.Value) <> '' then
  begin

    if Trim(GerAceTipOut.Value) = 'PCP' then
      Modulo := ' ( PCP )';
    if Trim(GerAceTipOut.Value) = 'CFG' then
      Modulo := ' ( Geral )';
    if Trim(GerAceTipOut.Value) = 'FAT' then
      Modulo := ' ( Fatura )';
    if Trim(GerAceTipOut.Value) = 'CMP' then
      Modulo := ' ( Compras )';
    if Trim(GerAceTipOut.Value) = 'EST' then
      Modulo := ' ( Estoque )';
    if Trim(GerAceTipOut.Value) = 'REL' then
      Modulo := ' ( Gerencia )';
    if Trim(GerAceTipOut.Value) = 'COB' then
      Modulo := ' ( Cobranca )';
    if Trim(GerAceTipOut.Value) = 'EXP' then
      Modulo := ' ( Expedicao )';
    if Trim(GerAceTipOut.Value) = 'PED' then
      Modulo := ' ( Comercial )';
    if Trim(GerAceTipOut.Value) = 'ROM' then
      Modulo := ' ( Romaneios )';
    if Trim(GerAceTipOut.Value) = 'FIN' then
      Modulo := ' ( Financeiro )';
    if Trim(GerAceTipOut.Value) = 'LOJ' then
      Modulo := ' ( Frente Loja )';

    Text := GerAceNomTra.Value + Modulo;

  end
  else
    Text := GerAceNomTra.Value;

end;

end.
