unit ManInf;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Db, DBTables, Wwquery, FShowPadrao, jpeg;

type
  TfmManInf = class(TfmShowPadrao)
    pnNomEmp: TLabel;
    pnEndEmp1: TLabel;
    pnEndEmp2: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    pnEmaEmp: TLabel;
    pnWebEmp: TLabel;
    BbSair: TSpeedButton;
    ProgramIcon: TImage;
    PaintBox: TPaintBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    pnFone: TLabel;
    pnFax: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    GerSft: TwwQuery;
    GerSftCODSFT: TIntegerField;
    GerSftNOMSFT: TStringField;
    GerSftAPESFT: TStringField;
    GerSftCEPSFT: TStringField;
    GerSftENDSFT: TStringField;
    GerSftREFSFT: TStringField;
    GerSftNUMSFT: TStringField;
    GerSftBAISFT: TStringField;
    GerSftCIDSFT: TStringField;
    GerSftSIGUFE: TStringField;
    GerSftCGCSFT: TStringField;
    GerSftINSSFT: TStringField;
    GerSftPRTSFT: TStringField;
    GerSftFONSFT: TStringField;
    GerSftPRFSFT: TStringField;
    GerSftFAXSFT: TStringField;
    GerSftEMASFT: TStringField;
    GerSftWEBSFT: TStringField;
    DsSft: TDataSource;
    procedure BbSairClick(Sender: TObject);
    procedure pnEmaEmpClick(Sender: TObject);
    procedure pnWebEmpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmManInf: TfmManInf;

implementation

uses dxDemoUtils, ShellAPI, Bbgeral, ManPri;

{$R *.DFM}

procedure TfmManInf.BbSairClick(Sender: TObject);
begin
  close;
end;

procedure TfmManInf.pnEmaEmpClick(Sender: TObject);
var
  cemail: string;
begin
  inherited;

  cEMail := 'mailto:' + Trim(pnWebEmp.Caption) + ' <' + Trim(pnWebEmp.Caption) + '>';

  ShellExecute(Handle, 'Open', PChar(cEMail), nil, '', sw_ShowNormal);

end;

procedure TfmManInf.pnWebEmpClick(Sender: TObject);
var
  pagina: string;
begin
  inherited;

  pagina := 'http://' + pnWebEmp.Caption;

  ShellExecute(0, nil, PChar(pagina), nil, nil, sw_Normal);

end;

procedure TfmManInf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  fmManPri.PopMenu.AutoPopup := True;

  Action := CaFree;

end;

procedure TfmManInf.FormActivate(Sender: TObject);
begin
  inherited;
  if fmManPri.PopMenu.AutoPopup then
    fmManPri.PopMenu.AutoPopup := False;
end;

procedure TfmManInf.PaintBoxPaint(Sender: TObject);
begin
  with Sender as TPaintBox do
    FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManInf.FormShow(Sender: TObject);
begin
  inherited;

  pnNomEmp.Caption := GerSftNomSft.Value;

  pnEndEmp1.Caption := Trim(GerSftEndSft.Value) + ',' +
    Trim(GerSftNumSft.Value) + ' ' +
    Trim(GerSftRefSft.Value);

  pnEndEmp2.Caption := Trim(GerSftBaiSft.Value) + ' ' +
    Trim(GerSftCidSft.Value) + ' - ' + Trim(GerSftSigUfe.Value);

  if Trim(GerSftCepSft.Value) <> '' then
    pnEndEmp2.Caption := pnEndEmp2.Caption + '  Cep : ' + copy(GerSftCepSft.Value, 1, 5) + '-' + copy(GerSftCepSft.Value, 6, 3);

  pnFone.Caption := '(' + fNumZeros(GerSftPrtSft.Value, 4) + ') ' + GerSftFonSft.Value;

  pnFax.Caption := '(' + fNumZeros(GerSftPrfSft.Value, 4) + ') ' + GerSftFaxSft.Value;

  pnWebEmp.Caption := GerSftWebSft.Value;
  pnEmaEmp.Caption := GerSftEmaSft.Value;

end;

procedure TfmManInf.FormDestroy(Sender: TObject);
begin
  inherited;
  fmManInf := nil;
end;

end.
