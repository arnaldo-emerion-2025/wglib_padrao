unit ManMsgSuframa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmMsgSuframa = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    ckCOFINS: TCheckBox;
    ckPIS: TCheckBox;
    ckICMS: TCheckBox;
    ckIPI: TCheckBox;
    Button1: TButton;
    lbValido: TLabel;
    lbNroSuframa: TLabel;
    procedure ckICMSClick(Sender: TObject);
    procedure ckIPIClick(Sender: TObject);
    procedure ckPISClick(Sender: TObject);
    procedure ckCOFINSClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMsgSuframa: TfmMsgSuframa;

implementation

{$R *.DFM}

procedure TfmMsgSuframa.ckICMSClick(Sender: TObject);
begin
  messagebox(handle,'Atenção!!! Será concedido desconto do valor do ICMS no total da Nota.', 'Aviso de SUFRAMA', MB_OK+MB_ICONINFORMATION);
end;

procedure TfmMsgSuframa.ckIPIClick(Sender: TObject);
begin
  messagebox(handle,'Atenção!!! Caso haja tributação de IPI no produto este não será tributado.', 'Aviso de SUFRAMA', MB_OK+MB_ICONINFORMATION);
end;

procedure TfmMsgSuframa.ckPISClick(Sender: TObject);
begin
  messagebox(handle,'Atenção!!! O valor do PIS não será tributado e somente será descontado do valor da Nota se na REGRA DE IPI estiver habilitado o desconto.', 'Aviso de SUFRAMA', MB_OK+MB_ICONINFORMATION);
end;

procedure TfmMsgSuframa.ckCOFINSClick(Sender: TObject);
begin
  messagebox(handle,'Atenção!!! O valor do COFINS não será tributado e somente será descontado do valor da Nota se na REGRA DE IPI estiver habilitado o desconto.', 'Aviso de SUFRAMA', MB_OK+MB_ICONINFORMATION);
end;

end.
