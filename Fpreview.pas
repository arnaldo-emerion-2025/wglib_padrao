{******************************************************************************}
{                                                                              }
{  PREVIEW DE RELATÓRIOS                                                       }
{                                                                              }
{******************************************************************************}
unit Fpreview;

interface

uses
  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, ExtCtrls, StdCtrls, Mask, Buttons, ppForms, ppTypes, ppDevice,
  ppViewr, ppFilDev, ppUtils, Dialogs, ppComm, ppProd, ppArchiv, ppRelatv;

type
  TfmPreview = class(TppCustomPreviewer)
    paBarra: TPanel;
    sbPrimeira: TSpeedButton;
    sbAnterior: TSpeedButton;
    sbProxima: TSpeedButton;
    sbUltima: TSpeedButton;
    edPagina: TMaskEdit;
    ppViewer: TppViewer;
    sbPreview: TStatusBar;
    cbZoom: TComboBox;
    sbImpressao: TSpeedButton;
    bbFim: TSpeedButton;
    sdSalva: TSaveDialog;
    odCarrega: TOpenDialog;
    arPreview: TppArchiveReader;
    procedure sbPrimeiraClick(Sender: TObject);
    procedure sbAnteriorClick(Sender: TObject);
    procedure sbProximaClick(Sender: TObject);
    procedure sbUltimaClick(Sender: TObject);
    procedure edPaginaKeyPress(Sender: TObject; var Key: Char);
    procedure ppViewerPageChange(Sender: TObject);
    procedure ppViewerStatusChange(Sender: TObject);
    procedure bbFimClick(Sender: TObject);
    procedure ppViewerPrintStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbZoomChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbImpressaoClick(Sender: TObject);
    procedure bbSalvaClick(Sender: TObject);
    procedure bbCarregaClick(Sender: TObject);
  end;

var
  fmPreview: TfmPreview;

implementation

{$R *.DFM}

uses ppReport;

{*******************************************************************************
* Rotina: Alteração no status de impressão
*******************************************************************************}

procedure TfmPreview.ppViewerPrintStateChange(Sender: TObject);
var
  lPosition: TPoint;
begin

  if ppViewer.Busy then
  begin
    edPagina.Enabled := False;
    paBarra.Cursor := crHourGlass;
    ppViewer.Cursor := crHourGlass;
    sbPreview.Cursor := crHourGlass;
    bbFim.Cursor := crArrow;
    bbFim.Caption := '&Cancela';
  end
  else
  begin
    edPagina.Enabled := True;
    paBarra.Cursor := crDefault;
    ppViewer.Cursor := crDefault;
    sbPreview.Cursor := crDefault;
    bbFim.Cursor := crDefault;
    bbFim.Caption := '&Fim';
  end;

  { Força atualização do cursor }
  GetCursorPos(lPosition);
  SetCursorPos(lPosition.X, lPosition.Y);

end;

{*******************************************************************************
* Rotina: Fim
*******************************************************************************}

procedure TfmPreview.bbFimClick(Sender: TObject);
begin
  if TppReport(ppViewer.Report).Printing then
    ppViewer.Cancel
  else
    Close;
end;

{*******************************************************************************
* Rotina: Barra de status
*******************************************************************************}

procedure TfmPreview.ppViewerStatusChange(Sender: TObject);
begin
  sbPreview.SimpleText := TppViewer(Sender).Status;
end;

{*******************************************************************************
* Rotina: Alteração de página
*******************************************************************************}

procedure TfmPreview.ppViewerPageChange(Sender: TObject);
begin
  edPagina.Text := IntToStr(TppViewer(Sender).AbsolutePageNo);
end;

{*******************************************************************************
* Rotina: Navegação
*******************************************************************************}
{ PRIMEIRA PÁGINA }

procedure TfmPreview.sbPrimeiraClick(Sender: TObject);
begin
  ppViewer.FirstPage;
end;

{ PÁGINA ANTERIOR }

procedure TfmPreview.sbAnteriorClick(Sender: TObject);
begin
  ppViewer.PriorPage;
end;

{ PRÓXIMA PÁGINA }

procedure TfmPreview.sbProximaClick(Sender: TObject);
begin
  ppViewer.NextPage;
end;

{ ÚLTIMA PÁGINA }

procedure TfmPreview.sbUltimaClick(Sender: TObject);
begin
  ppViewer.LastPage;
end;

{*******************************************************************************
* Rotina: Teclado ENTER no Viewer
*******************************************************************************}

procedure TfmPreview.edPaginaKeyPress(Sender: TObject; var Key: Char);
var
  liPage: Longint;
begin
  if (Key = #13) then
  begin
    liPage := StrToInt(edPagina.Text);
    ppViewer.GotoPage(liPage);
  end;
end;

{*******************************************************************************
* Rotina: Liberação de memória do form
*******************************************************************************}

procedure TfmPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{*******************************************************************************
* Rotina: Teclas de movimentação
*******************************************************************************}

procedure TfmPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  //if not(ssCtrl in Shift) then Exit;

  if (key = 39) or (key = 40) then
    ppViewer.NextPage;

  if (key = 37) or (key = 38) then
    ppViewer.PriorPage;

  case Key of
    VK_PRIOR: ppViewer.PriorPage;
    VK_NEXT: ppViewer.NextPage;
    VK_HOME: ppViewer.FirstPage;
    VK_END: ppViewer.LastPage;
  end;
end;

{*******************************************************************************
* Rotina: ZOOM
*******************************************************************************}

procedure TfmPreview.cbZoomChange(Sender: TObject);
const
  iZoom: array[0..5] of Integer = (50, 75, 85, 100, 150, 200);
begin

  with ppViewer do
    case cbZoom.ItemIndex of
      0: ZoomPercentage := iZoom[0];
      1: ZoomPercentage := iZoom[1];
      2: ZoomPercentage := iZoom[2];
      3: ZoomSetting := zs100Percent;
      4: ZoomPercentage := iZoom[4];
      5: ZoomPercentage := iZoom[5];
      6: ZoomSetting := zsPageWidth;
      7: ZoomSetting := zsWholePage;
    end;
end;

{*******************************************************************************
* Rotina: inicialização
*******************************************************************************}

procedure TfmPreview.FormShow(Sender: TObject);
begin

  cbZoom.ItemIndex := 3;

  ppViewer.ZoomSetting := zs100Percent;

  EdPagina.SetFocus;

end;

{*******************************************************************************
* Rotina: impressão
*******************************************************************************}

procedure TfmPreview.sbImpressaoClick(Sender: TObject);
begin
  ppViewer.Print;
end;

{*******************************************************************************
* Rotina: relatórios gerados em disco
*******************************************************************************}

procedure TfmPreview.bbSalvaClick(Sender: TObject);
begin

  { with sdSalva do begin

         InitialDir := ExtractFilePath(Application.ExeName);

         if Execute then

         with TppReport(ppViewer.Report) do begin

              DeviceType := 'ArchiveFile';
              AllowPrintToArchive := True;
              ArchiveFileName := FileName;
              PrintToDevices;
              DeviceType := 'Screen';

         end;
    end; }
end;

procedure TfmPreview.bbCarregaClick(Sender: TObject);
begin
  { with odCarrega do begin
      InitialDir := ExtractFilePath(Application.ExeName);
      if Execute then begin
        arPreview.ArchiveFileName := FileName;
        arPreview.PrintToDevices;
      end;
    end; }
end;

end.
