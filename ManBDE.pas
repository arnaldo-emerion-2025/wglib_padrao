unit ManBDE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, DBTables, FileCtrl, dxCntner,
  dxEditor, dxEdLib, dxExEdtr, dxColorPickEdit, dxColorEdit;

type
  TfmManBDE = class(TForm)
    Session1: TSession;
    PaintBox: TPaintBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    EdNomArq: TdxColorEdit;
    EdNumTcp: TdxColorEdit;
    EdNomOpe: TdxColorPickEdit;
    bCriar: TBitBtn;
    bCancelar: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BbPesq: TBitBtn;
    OpenDialog1: TOpenDialog;
    Label7: TLabel;
    Label8: TLabel;
    EdNomUsu: TdxColorEdit;
    Label9: TLabel;
    procedure bCancelarClick(Sender: TObject);
    procedure bCriarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure BbPesqClick(Sender: TObject);
  private
    {Private declarations}
  public
    {Public declarations}
    sAlias: string;
  end;

var
  fmManBDE: TfmManBDE;

implementation

uses dxDemoUtils, Bbmensag, IniFiles;

{$R *.DFM}

procedure TfmManBDE.bCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmManBDE.bCriarClick(Sender: TObject);
var
  AliasInfo: TStringList;
  NomArq: string;
  NomUsu: string;
begin

  if EdNomArq.Text <> '' then
  begin

    if Trim(EdNumTcp.Text) <> '' then
      NomArq := Trim(EdNumTcp.Text) + ':' + Trim(EdNomArq.Text)
    else
      NomArq := Trim(EdNomArq.Text);

    if Trim(EdNumTcp.Text) <> '' then
      NomUsu := Trim(EdNumTcp.Text) + ':' + Trim(EdNomUsu.Text)
    else
      NomUsu := Trim(EdNomUsu.Text);

    AliasInfo := TStringList.Create;

    {Apagamos os Alias Antigos}
    Session.DeleteAlias('ISade');
    Session.DeleteAlias('ISadeUsu');

    AliasInfo.Clear;
    AliasInfo.Add('BLOBS TO CACHE=-1');
    AliasInfo.Add('SERVER NAME =' + NomArq);
    AliasInfo.Add('USER NAME =SYSDBA');
    Session.AddAlias('ISade', 'INTRBASE', AliasInfo);

    Session.SaveConfigFile;

    AliasInfo.Clear;
    AliasInfo.Add('BLOBS TO CACHE=-1');
    AliasInfo.Add('SERVER NAME =' + NomUsu);
    AliasInfo.Add('USER NAME =SYSDBA');
    Session.AddAlias('ISadeUsu', 'INTRBASE', AliasInfo);

    Session.SaveConfigFile;

    sAlias := 'S';

    FreeAndNil(AliasInfo);

    close;

  end
  else
    fmsgErro('Campo com Conteudo Invalido', EdNomArq);
end;

procedure TfmManBDE.FormShow(Sender: TObject);
begin
  EdNomOpe.SetFocus;
end;

procedure TfmManBDE.FormCreate(Sender: TObject);
begin
  sAlias := 'N';
end;

procedure TfmManBDE.PaintBoxPaint(Sender: TObject);
begin
  with Sender as TPaintBox do
    FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManBDE.BbPesqClick(Sender: TObject);
var
  i: integer;
  Linha, NomArq: string;
  ArqTexto: TStringList;
begin

  if OpenDialog1.Execute then
    NomArq := OpenDialog1.FileName;

  if Trim(NomArq) <> '' then
  begin

    ArqTexto := TStringList.Create;
    ArqTexto.LoadFromFile(NomArq);

    for i := 0 to ArqTexto.Count - 1 do
    begin

      Linha := ArqTexto[i];

      if pos('SO', Linha) > 0 then
        EdNomOpe.Text := copy(Linha, pos('=', Linha) + 1, 100);

      if pos('IP', Linha) > 0 then
        EdNumTcp.Text := copy(Linha, pos('=', Linha) + 1, 100);

      if pos('BCO', Linha) > 0 then
        EdNomArq.Text := copy(Linha, pos('=', Linha) + 1, 100);

      if pos('USU', Linha) > 0 then
        EdNomUsu.Text := copy(Linha, pos('=', Linha) + 1, 100);

    end;
  end;
end;

end.
