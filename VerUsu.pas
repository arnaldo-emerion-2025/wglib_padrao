unit VerUsu;

interface

uses
  Windows, Messages, Dialogs, ComCtrls, SysUtils, Db, DBTables,
  StdCtrls, Mask, Controls, ExtCtrls, Classes, Buttons, Forms, hEdits,
  Wwquery, Graphics, AdvImage, dxCntner, dxEditor, dxEdLib, FShowPadrao,
  dxColorEdit;

type
  TfmVerUsu = class(TfmShowPadrao)
    quSql: TwwQuery;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    bConectar: TSpeedButton;
    bCancelar: TSpeedButton;
    Image1: TImage;
    EdUsuario: TdxColorEdit;
    EdSenha: TdxColorEdit;
    procedure bConectarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    {Private declarations}
  public
    function VersaoExe: string;
    {Public declarations}
  end;

var
  fmVerUsu: TfmVerUsu;

implementation

uses Encrypt, Bbgeral, Bbmensag, Bbacesso, Bbfuncao, ManGDB;

{$R *.DFM}

{*************************************************************************
* Rotina: executa login
*************************************************************************}

function TfmVerUsu.VersaoExe: string;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: string;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '\', Buffer, Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d',
        [HiWord(F^.dwFileVersionMs),
        LoWord(F^.dwFileVersionMs),
          HiWord(F^.dwFileVersionLs),
          Loword(F^.dwFileVersionLs)]
          );
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

procedure TfmVerUsu.bConectarClick(Sender: TObject);
var
  Senha: string;
begin

  with quSql, SQL do
  begin

    Close;
    Text := ' Select CodUsu,LogUsu,SenUsu,CodEmp,CodGus From GerUsu' +
      ' where LogUsu = ''' + UpperCase(edUsuario.Text) + '''';
    Open;

  end;

  Senha := IBPassword(PChar(EdSenha.Text));

  if Senha <> quSQL.FieldByName('SenUsu').AsString then
    fMsgErro('Senha Inválida', edSenha)
  else
    close;
end;

procedure TfmVerUsu.bCancelarClick(Sender: TObject);
begin
  if fMsg('               Aplicação sera Finalizada.                           ' +
    ' Todas as Operações em Execução no sistema serão Canceladas. Confirma?', 'S') then
    Application.Terminate
  else
    EdSenha.SetFocus;
end;

procedure TfmVerUsu.FormCreate(Sender: TObject);
var
  pCor: TColor;
  r, Lqtd: integer;
  LCor, Linha: string;
  ArqTexto: TStringList;
begin
  inherited;

  try
    Image1.Picture.LoadFromFile(GLogar);
  except
    Image1.Picture.LoadFromFile('');
  end;

  EdUsuario.Text := LowerCase(GUsu_Nm);

  if FileExists('C:\Emerion\Config.ini') then
  begin

    ArqTexto := TStringList.Create;
    ArqTexto.LoadFromFile('C:\Emerion\Config.ini');

    Lqtd := ArqTexto.Count - 1;

    r := 0;

    while r <= Lqtd do
    begin

      Linha := ArqTexto[r];

      if pos('color', Linha) > 0 then
      begin

        LCor := copy(Linha, pos('=', Linha) + 1, 20);

        r := Lqtd;

      end;

      Inc(r);

    end;

    FreeAndNil(ArqTexto);

    pCor := clAqua;

    if UpperCase(LCor) = 'CLAQUA' then
      pCor := clAqua;
    if UpperCase(LCor) = 'CLBLACK' then
      pCor := clBlack;
    if UpperCase(LCor) = 'CLBLUE' then
      pCor := clBlue;
    if UpperCase(LCor) = 'CLDKGRAY' then
      pCor := clDkGray;
    if UpperCase(LCor) = 'CLFUCHSIA' then
      pCor := clFuchsia;
    if UpperCase(LCor) = 'CLGRAY' then
      pCor := clGray;
    if UpperCase(LCor) = 'CLGREEN' then
      pCor := clGreen;
    if UpperCase(LCor) = 'CLLIME' then
      pCor := clLime;
    if UpperCase(LCor) = 'cLLTGRAY' then
      pCor := clLtGray;
    if UpperCase(LCor) = 'CLMAROON' then
      pCor := clMaroon;
    if UpperCase(LCor) = 'CLNAVY' then
      pCor := clNavy;
    if UpperCase(LCor) = 'CLOLIVE' then
      pCor := clOlive;
    if UpperCase(LCor) = 'CLPURPLE' then
      pCor := clPurple;
    if UpperCase(LCor) = 'CLRED' then
      pCor := clRed;
    if UpperCase(LCor) = 'CLSILVER' then
      pCor := clSilver;
    if UpperCase(LCor) = 'CLTEAL' then
      pCor := clTeal;
    if UpperCase(LCor) = 'CLWHITE' then
      pCor := clWhite;
    if UpperCase(LCor) = 'CLYELLOW' then
      pCor := clYellow;

    Label1.Font.Color := pCor;
    Label2.Font.Color := pCor;
    Label3.Font.Color := pCor;

    bConectar.Font.Color := pCor;
    bCancelar.Font.Color := pCor;

  end;
end;

procedure TfmVerUsu.EdSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 13) or (key = 40) then
    bConectar.OnClick(Sender);
end;

procedure TfmVerUsu.FormShow(Sender: TObject);
begin
  inherited;
  GVerUsuario := 1;
end;

procedure TfmVerUsu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  GVerUsuario := 0;
end;

end.
