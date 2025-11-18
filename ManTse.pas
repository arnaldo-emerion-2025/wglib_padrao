unit ManTSe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, hEdits, Buttons, Db, DBTables, Wwquery, ExtCtrls,
  dxCntner, dxEditor, dxEdLib, dxColorEdit;

type
  TfmManTSe = class(TForm)
    quSql: TwwQuery;
    BbCanc: TBitBtn;
    BbConf: TBitBtn;
    PaintBox: TPaintBox;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EdSenha2: TdxColorEdit;
    EdSenha1: TdxColorEdit;
    Image1: TImage;
    procedure BbConfClick(Sender: TObject);
    procedure BbCancClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var
  fmManTSe: TfmManTSe;

implementation

uses Encrypt, Bbmensag, ManGDB;

{$R *.DFM}

procedure TfmManTSe.BbConfClick(Sender: TObject);
var
  Senha1: string;
begin

  with quSql, SQL do
  begin

    Close;
    Text := ' Select CodUsu,LogUsu,SenUsu,CodEmp,CodGus From GerUsu' +
      ' where CodUsu = ''' + IntToStr(GUsu_Id) + '''';
    Open;

  end;

  Senha1 := IBPassword(PChar(EdSenha1.Text));

  if Senha1 = quSQL.FieldByName('SenUsu').AsString then
  begin

    if fMsg('Confirma Alteração', 'S') then
    begin

      with quSql, SQL do
      begin

        Close;
        Text := ' Update GerUsu set SenUsu = :SenUsu, Se2Usu = :Se2Usu' +
          ' Where CodUsu = ''' + IntToStr(GUsu_Id) + '''';

        with Params do
        begin

          params[0].AsString := IBPassword(PChar(EdSenha2.Text));
          params[1].AsString := IBPassword(PChar(EdSenha2.Text));

        end;

        ExecSQL;

      end;

      close;

    end;

  end
  else
    fMsgErro('Senha Anterior Incorreta', EdSenha1);
end;

procedure TfmManTSe.BbCancClick(Sender: TObject);
begin
  close;
end;

procedure TfmManTSe.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
