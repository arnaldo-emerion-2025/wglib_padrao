unit ManSen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FPadrao, StdCtrls, ExtCtrls, Db, Wwdatsrc, DBTables, Wwquery, Grids, Wwdbigrd,
  Wwdbgrid, hGrid, Buttons, dxCntner, dxEditor, dxExEdtr, dxEdLib, dxDBELib,
  dxColorEdit;

type
  TfmManSen = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    Shape3: TShape;
    BbSair: TBitBtn;
    EdSenUsu: TdxColorEdit;
    quSql: TwwQuery;
    procedure BbSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WMWindowPosChanging(var Msg: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdSenUsuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    {Private declarations}
  public
    {Public declarations}
    tentativas: integer;
    sContinuar: string;
  end;

var
  fmManSen: TfmManSen;

implementation

uses Bbfuncao, BbMensag, ManGDB;

{$R *.DFM}

{*************************************************************************
* Rotina: Evitar Movimentação de Janelas
*************************************************************************}

procedure TfmManSen.WMWindowPosChanging(var Msg: TWMWindowPosChanging);
begin
  with Msg.WindowPos^ do begin

    y := 214; {Top}
    x := 274; {Left}

    Msg.Result := 0;

  end;
end;

procedure TfmManSen.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 27 then Close;
end;

procedure TfmManSen.BbSairClick(Sender: TObject);
begin

  with quSQL, SQL do begin

    Close;
    Text := ' Select Count(*) as Reg From GerUsu' +
      ' where CodUsu = :CodUsu' +
      '   and SenUsu = :SenUsu';

    with Params do begin

      Params[0].AsInteger := GSup_Id;
      Params[1].AsString := EdSenUsu.Text;

    end;

    Open;

  end;

  if quSQL.FieldbyName('Reg').AsInteger > 0 then begin

    sContinuar := 'S';

    Close;

  end
  else
  begin

    tentativas := tentativas + 1;

    if tentativas = 3 then
      Close
    else
      fmsgErro('Senha Informada Incorreta', EdSenUsu);
  end;
end;

procedure TfmManSen.FormCreate(Sender: TObject);
begin

  tentativas := 0;

  sContinuar := 'N';

end;

procedure TfmManSen.FormShow(Sender: TObject);
begin
  EdSenUsu.SetFocus;
end;

procedure TfmManSen.EdSenUsuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 40) or (key = 13) then BbSair.SetFocus;
end;

end.
