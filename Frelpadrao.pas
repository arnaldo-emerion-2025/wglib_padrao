unit Frelpadrao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppCtrls, ppBands, ppPrnabl, ppClass, ppCache, ppComm, ppProd, ppReport,
  Buttons, StdCtrls, ppVar, ppTypes, Printers, Db, DBTables, ppDB,
  ppDBPipe, ppDBBDE, wwQuery, ppRelatv;

type
  TfmRelPadrao = class(TForm)
    ppReport: TppReport;
    gbParametros: TGroupBox;
    sbPreview: TSpeedButton;
    sbConfig: TSpeedButton;
    sbImprime: TSpeedButton;
    pdDialog: TPrintDialog;
    hbReport: TppHeaderBand;
    dbReport: TppDetailBand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbConfigClick(Sender: TObject);
    procedure sbPreviewClick(Sender: TObject);
    procedure CabPdr(PTitulo1, PTitulo2: string);
    procedure sbImprimeClick(Sender: TObject);
    procedure RelatorioPadrao(PDataSource: TDataSource);
    procedure FormCreate(Sender: TObject);
  private
    aTitulo: array[0..29] of TppLabel;
    aCampo: array[0..29] of TppDBText;
    plReport: TppBDEPipeline;
  end;

var
  fmRelPadrao: TfmRelPadrao;

implementation

uses FPreview, Bbfuncao, ManGDB;

{$R *.DFM}

{*************************************************************************
* Rotina: fim
*************************************************************************}

procedure TfmRelPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

{*************************************************************************
* Rotina: setup
*************************************************************************}

procedure TfmRelPadrao.sbConfigClick(Sender: TObject);
begin
  pdDialog.Execute;
end;

{*************************************************************************
* Rotina: cabeçalho padrão
*************************************************************************}

procedure TfmRelPadrao.CabPdr(PTitulo1, PTitulo2: string);
//var
//  quLogo: TQuery;
begin

  { Logotipo }

{  quLogo := TQuery.Create(Self);
  try
    with quLogo,SQL do begin
      DatabaseName := GDatabaseName;
      UniDirectional := True;
      Text := 'select Logo from Taimagem where Cetb = ' + GEmp_Id;
      Open;
    end;

    with TppImage.Create(ppReport.Owner) do begin
      Band := ppReport.Bands[0];
      Picture.Assign(quLogo.FieldByName('Logo'));
      Height := 14;
      Left := 2;
      Top := 2;
      Width := 26;
      MaintainAspectRatio := True;
      Stretch := True;
    end;
  finally
    FreeAndNil(quLogo);
  end;

}

  { Nome do Sistema }
  with TppLabel.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    Left := 30;
    Top := 2;
    Caption := 'EMERION - CNAB';
    Font.Size := 10;
    Font.Style := [fsBold, fsItalic];
  end;

  { Títulos }
  with TppLabel.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    Left := 30;
    Top := 6;
    Caption := PTitulo1;
    ;
    Font.Size := 14;
    Font.Color := clNavy;
    Font.Style := [fsBold];
  end;
  with TppLabel.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    Left := 30;
    Top := 12;
    Caption := PTitulo2;
    Font.Size := 10;
  end;
  { Linhas }
  with TppLine.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    Height := 2;
    Left := 0;
    Top := 0;
    if (ppReport.PrinterSetup.Orientation = poPortrait) then
      Width := 197
    else
      Width := 285;
    Pen.Width := 1;
  end;
  with TppLine.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    Height := 2;
    Left := 0;
    Top := 18;
    if (ppReport.PrinterSetup.Orientation = poPortrait) then
      Width := 197
    else
      Width := 285;
    Pen.Width := 1;
  end;
  { Data de Emissão }
  with TppLabel.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    if (ppReport.PrinterSetup.Orientation = poPortrait) then
      Left := 158
    else
      Left := 240;
    Top := 2;
    Caption := 'Emissão:';
    Font.Size := 8;
  end;
  with TppSystemVariable.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    if (ppReport.PrinterSetup.Orientation = poPortrait) then
      Left := 170
    else
      Left := 252;
    Top := 2;
    DisplayFormat := 'dd/mm/yyyy (hh:nn)';
    VarType := vtDateTime;
    Font.Size := 8;
  end;
  { Numeração de Página }
  with TppLabel.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    if (ppReport.PrinterSetup.Orientation = poPortrait) then
      Left := 158
    else
      Left := 240;
    Top := 6;
    Caption := 'Página:';
    Font.Size := 8;
  end;
  with TppSystemVariable.Create(ppReport.Owner) do
  begin
    Band := ppReport.Bands[0];
    if (ppReport.PrinterSetup.Orientation = poPortrait) then
      Left := 170
    else
      Left := 252;
    Top := 6;
    DisplayFormat := '0000';
    VarType := vtPageNo;
    Font.Size := 8;
  end;

end;

{*************************************************************************
* Rotina: preview
*************************************************************************}

procedure TfmRelPadrao.sbPreviewClick(Sender: TObject);
var
  fmPreview: TfmPreview;
begin
  try

    ppReport.DeviceType := 'Screen';
    fmPreview := TfmPreview.Create(fmRelPadrao);
    fmPreview.ppViewer.Report := ppReport;
    ppReport.PrintToDevices;
    fmPreview.ShowModal;

    if Assigned(ppReport.AfterPrint) then
      ppReport.AfterPrint(Sender);

  finally

    FreeAndNil(fmPreview);

  end;
end;

{*************************************************************************
* Rotina: impressão
*************************************************************************}

procedure TfmRelPadrao.sbImprimeClick(Sender: TObject);
begin
  ppReport.DeviceType := 'Printer';
  ppReport.Print;
end;

{*************************************************************************
* Rotina: geração das colunas do relatório em função do DataSet vinculado
*************************************************************************}

procedure TfmRelPadrao.RelatorioPadrao(PDataSource: TDataSource);
var
  iWtit, iWcam, iLeft, i: Integer;
  nWidth: Double;
  cFonte: TCanvas;
begin

  // Cabeçalho
  fmRelPadrao.Caption := TForm(PDataSource.Owner).Caption;
  CabPdr(TForm(PDataSource.Owner).Caption, '');
  plReport := TppBDEPipeline.Create(ppReport.Owner);
  plReport.DataSource := PDataSource;
  ppReport.DataPipeline := plReport;

  with PDataSource.DataSet do
  begin

    iLeft := 0;
    cFonte := TCanvas.Create;
    cFonte.Handle := GetDC(0);

    for i := 0 to FieldCount - 1 do
    begin

      if (aTitulo[i] <> nil) then
        FreeAndNil(aTitulo[i]);

      if (aCampo[i] <> nil) then
        FreeAndNil(aCampo[i]);

      if Fields[i].Visible then
      begin

        aTitulo[i] := TppLabel.Create(ppReport.Owner);
        with aTitulo[i] do
        begin

          Band := hbReport;
          AutoSize := True;
          Caption := Fields[i].DisplayLabel;
          Left := iLeft;
          Top := 21;
          Alignment := Fields[i].Alignment;
          Font.Name := 'Arial';
          Font.Size := 8;
          Font.Style := [fsUnderline, fsBold];

          // Comprimento em função do fonte usado
          cFonte.Font.Assign(aTitulo[i].Font);
          iWtit := cFonte.TextWidth(aTitulo[i].Caption);

        end;

        aCampo[i] := TppDBText.Create(ppReport.Owner);
        with aCampo[i] do
        begin

          Band := dbReport;
          AutoSize := True;
          DataPipeLine := plReport;
          DataField := Fields[i].FieldName;
          Left := iLeft;
          Top := 0;
          Alignment := Fields[i].Alignment;
          Font.Name := 'Arial';
          Font.Size := 8;
          Font.Style := [];

          // Comprimento em função do fonte usado
          cFonte.Font.Assign(aCampo[i].Font);

          // Campos numéricos
          if (Fields[i] is TNumericField) then
            iWcam := Length(TNumericField(Fields[i]).DisplayFormat) * cFonte.TextWidth('9')
              // Campos data
          else if (Fields[i] is TDateTimeField) then
            iWcam := Length(TDateTimeField(Fields[i]).DisplayFormat) * cFonte.TextWidth('9')
              // Outros campos
          else
            iWcam := Fields[i].DisplayWidth * cFonte.TextWidth('R');

        end;

        // Conversão da largura do campo para centímetros
        nWidth := fMaxI(iWtit, iWcam) / 3.78;

        // Offset para campos alinhados pela direita
        if (Fields[i].Alignment = taRightJustify) then
        begin
          aTitulo[i].Width := nWidth;
          aCampo[i].Width := nWidth;
        end;

        iLeft := iLeft + Round(nWidth) + 2;

      end;
    end;
  end;

end;

{*************************************************************************
* Rotina: inicialização
*************************************************************************}

procedure TfmRelPadrao.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin

  { Inicialização }
  for i := 0 to 29 do
  begin
    aTitulo[i] := nil;
    aCampo[i] := nil;
  end;

  with Self do

    for i := 0 to ComponentCount - 1 do
    begin

      { Ativação automática dos componentes wwQuery: somente com Tag = 0 }
      if (Components[i] is TwwQuery) then
        with TwwQuery(Components[i]) do
          if (Tag = 0) then
          begin

            if Active then
              Close;

            { Verifica se existe parâmetro definido para seleção por código da
              empresa. Se o mesmo estiver definido, o sistema assume a
              empresa ativa para seleção dos dados.
            }
            for j := 0 to ParamCount - 1 do
              if (UpperCase(Params.Items[j].Name) = 'PEMP_ID') then
                //                Params.Items[j].AsFloat := GEmp_Id;
                //                Params.Items[j].AsString := GEmp_Id;
                Params.Items[j].AsString := '';

            Open;

          end;

    end;

  Screen.Cursor := crDefault;

end;

end.
