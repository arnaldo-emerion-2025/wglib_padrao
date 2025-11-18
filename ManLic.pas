unit ManLic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FShowpadrao, ExtCtrls, StdCtrls, ComCtrls, Buttons, dxCntner, dxEditor,
  dxExEdtr, dxEdLib, dxColorDateEdit, Db, DBTables, Wwquery, dxfProgressBar;

type
  TfmManLic = class(TfmShowPadrao)
    PaintBox: TPaintBox;
    Label1: TLabel;
    EdDteLic: TdxColorDateEdit;
    bIncluir: TSpeedButton;
    quSQL: TwwQuery;
    ProgressBar: TdxfProgressBar;
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bIncluirClick(Sender: TObject);
  private
    { Private declarations }
    DteLic  : TDateTime;
    Sequenc : string;
  public
    { Public declarations }
  end;

var
  fmManLic: TfmManLic;

implementation

uses dxDemoUtils, Bbgeral, Bbfuncao, Bbmensag, ManGDB;

{$R *.DFM}

procedure TfmManLic.PaintBoxPaint(Sender: TObject);
begin
  inherited;
  with Sender as TPaintBox do FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManLic.FormShow(Sender: TObject);
var
  Dia     : string;
  Mes     : string;
  Ano     : string;
begin
  inherited;

  with quSQL,SQL do begin

       Close;
       Text := ' Select * From GerPar';
       Open;

       Sequenc := fEnCripto(FieldbyName('ParLib').AsString,'D');

  end;

  Dia := fNumZeros(FloatToStr(StrToInt(copy(Sequenc,11,01)+copy(Sequenc,22,01)+copy(Sequenc,33,01))/8),2);
  Mes := fNumZeros(FloatToStr(StrToInt(copy(Sequenc,42,01)+copy(Sequenc,54,01))/8),2);
  Ano := fNumZeros(FloatToStr(StrToInt(copy(Sequenc,13,01)+copy(Sequenc,09,02)+copy(Sequenc,01,02))/3),4);

  ProgressBar.Max := StrToInt(FloatToStr(StrToDate(Dia+'/'+Mes+'/'+Ano))) - 39000;

  with quSQL,SQL do begin

       Close;
       Text := ' Select Cast('+ QuotedStr('Today') +' as Date) as DteSer From rdb$database';
       Open;

       ProgressBar.Position := StrToInt(FloatToStr(FieldbyName('DteSer').AsDateTime)) - 39000;

  end;

  DteLic := StrToDate(Dia+'/'+Mes+'/'+Ano);

  EdDteLic.Date := DteLic;

  EdDteLic.SetFocus;

end;

procedure TfmManLic.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 27 then close;
end;

procedure TfmManLic.bIncluirClick(Sender: TObject);
var
  Dia : string;
  Mes : string;
  Ano : string;
begin
  inherited;
  if EdDteLic.Date > 0 then begin

     if EdDteLic.Date <> DteLic then begin

        Dia := fNumZeros(IntToStr(StrToInt(copy(FormatDateTime('dd/mm/yyyy',EdDteLic.Date),1,2)) * 8),3);
        Mes := fNumZeros(IntToStr(StrToInt(copy(FormatDateTime('dd/mm/yyyy',EdDteLic.Date),4,2)) * 8),2);
        Ano := fNumZeros(IntToStr(StrToInt(copy(FormatDateTime('dd/mm/yyyy',EdDteLic.Date),7,4)) * 3),5);

        Sequenc := copy(Ano,04,02) +
                   copy(Sequenc,03,06) +
                   copy(Ano,02,02) +
                   copy(Dia,01,01) +
                   copy(Sequenc,12,01) +
                   copy(Ano,01,01) +
                   copy(Sequenc,14,08) +
                   copy(Dia,02,01) +
                   copy(Sequenc,23,10) +
                   copy(Dia,03,01) +
                   copy(Sequenc,34,08) +
                   copy(Mes,01,01) +
                   copy(Sequenc,43,11) +
                   copy(Mes,02,01) +
                   copy(Sequenc,55,18);

        Dia := fNumZeros(FloatToStr(StrToInt(copy(Sequenc,11,01)+copy(Sequenc,22,01)+copy(Sequenc,33,01))/8),2);
        Mes := fNumZeros(FloatToStr(StrToInt(copy(Sequenc,42,01)+copy(Sequenc,54,01))/8),2);
        Ano := fNumZeros(FloatToStr(StrToInt(copy(Sequenc,13,01)+copy(Sequenc,09,02)+copy(Sequenc,01,02))/3),4);

        Sequenc := fEnCripto(copy(Sequenc,1,42)+'L'+copy(Sequenc,44,11),'C');

        with quSQL,SQL do begin

             Close;
             Text := ' Update GerPar Set Flgtrg = '+ QuotedStr('*') + ',' +
                     '                   ParLib = '+ QuotedStr(Sequenc);
             ExecSQL;

        end;

        fmsg('Novo Licenciamento gerado com Sucesso.','I');

        GLibAce := 'Sim';
        
        Close;

        end
     else
        close;
        
     end
  else
     fmsgErro('Campo de preenchimento obrigatorio não informado.',EdDteLic);
end;

end.
