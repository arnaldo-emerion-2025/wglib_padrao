unit FMsgConf;

interface

uses Sysutils, WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, dxCntner, dxEditor, dxEdLib;

type
  TfmMsgConf = class(TForm)
    Panel1: TPanel;
    imIcone: TImage;
    meTexto: TMemo;
    sbOk: TBitBtn;
    EdResp: TEdit;
    Label1: TLabel;
    procedure sbOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FResp: string;
  published
    property Resp: string read FResp write FResp;
  end;

var
  fmMsgConf: TfmMsgConf;

implementation

uses Bbmensag;

{$R *.DFM}

procedure TfmMsgConf.sbOkClick(Sender: TObject);
begin

  ActiveControl := nil;

  if (UpperCase(EdResp.Text) = 'SIM') or (UpperCase(EdResp.Text) = 'NAO') then
  begin

    Resp := UpperCase(EdResp.Text);

    close;

  end
  else
    EdResp.SetFocus;
end;

procedure TfmMsgConf.FormShow(Sender: TObject);
begin
  EdResp.SetFocus;
end;

end.
