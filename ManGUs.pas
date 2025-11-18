unit ManGUs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Fpadrao, hNavigator, ExtCtrls, DBTables, Db, Wwdatsrc, Wwquery, StdCtrls,
  Mask, DBCtrls, hEdits, Grids, Wwdbigrd, Wwdbgrid, hGrid, ComCtrls,
  wwdblook, Buttons, hSpeedButtonsADCLI, AlignEdit, ppBands, ppVar,
  ppCtrls, ppPrnabl, ppClass, ppProd, ppReport, ppDB, ppComm, ppRelatv,
  ppCache, ppDBPipe, dxDBELib, dxCntner, dxEditor, dxEdLib, dxDBColorEdit,
  dxColorEdit;

type
  TfmManGus = class(TfmPadrao)
    GerGus: TwwQuery;
    dsGus: TwwDataSource;
    upGus: TUpdateSQL;
    quSql: TwwQuery;
    GerGusNOMGUS: TStringField;
    GerGusCODGUS: TIntegerField;
    plOcoCr1: TppDBPipeline;
    ppReport1: TppReport;
    hbReport: TppHeaderBand;
    ppShape5: TppShape;
    ppImage1: TppImage;
    ppDesEmp4: TppLabel;
    ppDesEmp3: TppLabel;
    ppDesEmp2: TppLabel;
    ppDesEmp1: TppLabel;
    QrTitulo: TppLabel;
    ppLine7: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    dbReport: TppDetailBand;
    ppCodGus: TppLabel;
    ppNomGus: TppLabel;
    ppFooterBand1: TppFooterBand;
    ppShape2: TppShape;
    ppLabel29: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel30: TppLabel;
    pcGUs: TPageControl;
    pcPag1: TTabSheet;
    Panel2: TPanel;
    Shape6: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label10: TLabel;
    Shape4: TShape;
    Label3: TLabel;
    Shape5: TShape;
    Shape11: TShape;
    Label4: TLabel;
    Label12: TLabel;
    EdPsqCodGUs: TdxColorEdit;
    rgOrdem: TRadioGroup;
    rgBusca: TRadioGroup;
    Bbselecionar: TBitBtn;
    Panel3: TPanel;
    grGUs: ThGrid;
    EdPsqNomGUs: TdxColorEdit;
    pcPag2: TTabSheet;
    Panel4: TPanel;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    Label7: TLabel;
    Label9: TLabel;
    EdNomGUs: TdxDBColorEdit;
    EdCodGUs: TdxDBColorEdit;
    nvGUs: ThDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure GerGusNewRecord(DataSet: TDataSet);
    procedure GerGusBeforeDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure hbReportBeforePrint(Sender: TObject);
    procedure dbReportBeforePrint(Sender: TObject);
    procedure pcPag1Show(Sender: TObject);
    procedure pcPag2Show(Sender: TObject);
    procedure BbselecionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    {Private declarations}
  public
    {Public declarations}
    sBase, sFiltro, sOrdem : string;
  end;

var
  fmManGus: TfmManGus;

implementation

uses Bbgeral, Bbacesso, BbMensag, ManGDB, ManPri;

{$R *.DFM}

procedure TfmManGus.FormCreate(Sender: TObject);
begin
  inherited;
  sBase := 'select * from GerGUs ';
end;

procedure TfmManGus.GerGusNewRecord(DataSet: TDataSet);
begin
  inherited;

  if copy(GFprm,1,1) <> 'S' then Abort;

  PcGUs.ActivePage := pcPag2;

  if GerGUs.State <> dsInsert then GerGUs.Insert;

  EdNomGus.Setfocus;

end;

procedure TfmManGus.GerGusBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if GerGusCodGus.Value = 1 then fmsgErro('Grupo não Pode ser Excluido', Nil);
  if GerGusCodGus.Value = GGUs_Id then fmsgErro('Grupo não Pode ser Excluido', Nil);
end;

procedure TfmManGus.FormShow(Sender: TObject);
begin
  inherited;

  pcGUs.ActivePage := pcPag1;

  EdPsqCodGUs.SetFocus;

end;

procedure TfmManGus.hbReportBeforePrint(Sender: TObject);
begin
  inherited;
  
  ppDesEmp1.Caption := GApeEmp;
  ppDesEmp2.Caption := GRazEmp;
  ppDesEmp3.Caption := GEndEmp;
  ppDesEmp4.Caption := GRefEmp;

  try
    ppImage1.Picture.LoadFromFile(GImprimir);
  except
    ppImage1.Picture.LoadFromFile('');
  end;
end;

procedure TfmManGus.dbReportBeforePrint(Sender: TObject);
begin
  inherited;
  ppCodGus.Caption := PreString(IntToStr(GerGusCodGus.Value),7);
  ppNomGus.Caption := GerGusNomGus.Value;
end;

procedure TfmManGus.pcPag1Show(Sender: TObject);
begin
  inherited;
  EdPsqCodGus.SetFocus;
end;

procedure TfmManGus.pcPag2Show(Sender: TObject);
begin
  inherited;
  EdNomGus.SetFocus;
end;

procedure TfmManGus.BbselecionarClick(Sender: TObject);
begin
  inherited;

  sFiltro := '';

  {Ordem}
  case rgOrdem.ItemIndex of
       0: sOrdem := ' order by CodGus';
       1: sOrdem := ' order by DesGus';
  end;

  if (EdpsqCodGus.Text <> '') then sFiltro := ' where CodGus = '''+ EdpsqCodGus.Text +'''';
  if (EdpsqCodGus.Text <> '') then sOrdem  := ' order by CodGus';

  if Rgbusca.ItemIndex = 0 then
     begin

     if (EdpsqNomGus.Text <> '') then sFiltro := ' where NomGus LIKE '''+ EdpsqNomGus.Text +'%''';
     if (EdpsqNomGus.Text <> '') then sOrdem  := ' order by NomGus';

     end
  else
     begin

     if (EdpsqCodGus.Text <> '') then sFiltro := ' where CodGus = ''' + EdpsqCodGus.Text + '''';
     if (EdpsqCodGus.Text <> '') then sOrdem  := ' order by CodGus';
     if (EdpsqNomGus.Text <> '') then sFiltro := ' where NomGus LIKE ''%' + EdpsqNomGus.Text + '%''';
     if (EdpsqNomGus.Text <> '') then sOrdem  := ' order by NomGus';

  end;

  with GerGus,SQL do begin

       Close;
       Text := sBase + sFiltro + sOrdem;
       Open;

  end;
end;

procedure TfmManGus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := CaFree;
end;

procedure TfmManGus.FormDestroy(Sender: TObject);
begin
  inherited;

  fmManGUs.Release;

  fmManGUs := Nil;

end;

end.
