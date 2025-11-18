unit ManAtu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxfProgressBar, ExtCtrls, ComCtrls, Db, DBTables, Wwquery;

type
  TfmManAtu = class(TForm)
    GerTab: TwwQuery;
    GerPrc: TwwQuery;
    quSql: TwwQuery;
    qrUsu: TwwQuery;
    GerTabNOMTAB: TStringField;
    GerPrcCODPRC: TStringField;
    ProgressBar: TdxfProgressBar;
    PaintBox: TPaintBox;
    pnNomUsu: TLabel;
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    {Private declarations}
  public
    {Public declarations}
    sEnc: string;
  end;

var
  fmManAtu: TfmManAtu;

implementation

uses dxDemoUtils, Bbmensag, ManPri, ManGDB;

{$R *.DFM}

procedure TfmManAtu.PaintBoxPaint(Sender: TObject);
begin
  with Sender as TPaintBox do
    FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManAtu.FormCreate(Sender: TObject);
begin

  sEnc := 'Nao';

  GerTab.Open;
  GerPrc.Open;

end;

procedure TfmManAtu.FormActivate(Sender: TObject);
var
  QtdReg: integer;
begin

  if fmManPri.PopMenu.AutoPopup then
    fmManPri.PopMenu.AutoPopup := False;

  if sEnc = 'Sim' then
  begin

    with quSql, SQL do
    begin

      Close;
      Text := ' Select Count(*) as QtdReg from rdb$relations Where ((rdb$system_flag = 0) or (rdb$system_flag is null)) and (rdb$view_source is null)';
      Open;

      QtdReg := FieldbyName('QtdReg').AsInteger;

    end;

    with quSql, SQL do
    begin

      Close;
      Text := ' Select Count(*) as QtdReg From rdb$procedures';
      Open;

      QtdReg := QtdReg + FieldbyName('QtdReg').AsInteger;

    end;

    with qrUsu, SQL do
    begin

      Close;
      Text := ' Select * From GerUsu Order by LogUsu';
      Open;

    end;

    while not qrUsu.Eof do
    begin

      if qrUsu.FieldbyName('CodUsu').AsInteger <> 999 then
      begin

        pnNomUsu.Caption := qrUsu.FieldbyName('LogUsu').AsString;

        ProgressBar.Max := QtdReg;

        ProgressBar.Position := 0;

        GerTab.First;

        while not GerTab.Eof do
        begin

          Application.ProcessMessages;

          with quSql, SQL do
          begin

            Close;
            Text := ' Grant ALL on ' + Trim(GerTabNomTab.Value) + ' To ' + Trim(qrUsu.FieldbyName('LogUsu').AsString);
            ExecSQL;

          end;

          GerTab.Next;

          ProgressBar.StepBy(1);

        end;

        GerPrc.First;

        while not GerPrc.Eof do
        begin

          Application.ProcessMessages;

          with quSql, SQL do
          begin

            Close;
            Text := ' Grant Execute on Procedure ' + Trim(GerPrcCodPrc.Value) + ' To ' + Trim(qrUsu.FieldbyName('LogUsu').AsString);
            ExecSQL;

          end;

          GerPrc.Next;

          ProgressBar.StepBy(1);

        end;
      end;

      qrUsu.Next;

    end;
  end;
end;

procedure TfmManAtu.FormShow(Sender: TObject);
begin
  sEnc := 'Sim';
end;

end.
