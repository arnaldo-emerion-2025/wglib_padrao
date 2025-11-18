unit FMensag;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TfmMensag = class(TForm)
    Panel1: TPanel;
    imIcone: TImage;
    meTexto: TMemo;
    sbOk: TBitBtn;
    sbCancela: TBitBtn;
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FResp: Boolean;
  public
    sFocus: integer;
  published
    property Resp: Boolean read FResp write FResp;
  end;

var
  fmMensag: TfmMensag;

implementation

{$R *.DFM}

procedure TfmMensag.sbOkClick(Sender: TObject);
begin
  Resp := True;
  close;
end;

procedure TfmMensag.sbCancelaClick(Sender: TObject);
begin
  Resp := False;
  close;
end;

procedure TfmMensag.FormShow(Sender: TObject);
begin
  if sFocus = 1 then
    sbCancela.SetFocus;
end;

end.
