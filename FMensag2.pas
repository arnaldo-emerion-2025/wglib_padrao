unit FMensag2;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
     StdCtrls, ExtCtrls;

type
  TfmMensag2 = class(TForm)
    Panel1: TPanel;
    meTexto: TMemo;
    sbOk: TBitBtn;
    sbCancela: TBitBtn;
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FResp: Boolean;
  published
    property Resp: Boolean read FResp write FResp;
  end;

var
  fmMensag2: TfmMensag2;

implementation

uses ManGDB;

{$R *.DFM}

procedure TfmMensag2.sbOkClick(Sender: TObject);
begin
  if Tecla <> 'ENTER' then begin
  
     Resp := True;
     close;

  end;   
end;

procedure TfmMensag2.sbCancelaClick(Sender: TObject);
begin
  if Tecla <> 'ENTER' then begin
  
     Resp := False;
     close;

  end;   
end;

procedure TfmMensag2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  
  if key = 32 then begin

     if sbOk.Focused then
        sbok.OnClick(Sender)
     else
        begin   

        if sbCancela.Focused then sbCancela.OnClick(Sender);

     end;
  end;
end;

end.
