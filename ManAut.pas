unit ManAut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, FShowpadrao, ExtCtrls, StdCtrls, ComCtrls, Buttons, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxColorDateEdit, Db, DBTables, Wwquery,
  dxfProgressBar, dxColorEdit;

type
  TfmManAut = class(TfmShowPadrao)
    PaintBox: TPaintBox;
    Label1: TLabel;
    quSQL: TwwQuery;
    ProgressBar: TdxfProgressBar;
    EdSeqInf1: TdxColorEdit;
    EdSeqInf2: TdxColorEdit;
    EdSeqInf3: TdxColorEdit;
    EdSeqInf4: TdxColorEdit;
    EdSeqInf5: TdxColorEdit;
    EdSeqInf6: TdxColorEdit;
    Label2: TLabel;
    btnVerificar: TBitBtn;
    EdSeqInf7: TdxColorEdit;
    EdSeqInf8: TdxColorEdit;
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdSeqInf3KeyPress(Sender: TObject; var Key: Char);
    procedure EdSeqInf1KeyPress(Sender: TObject; var Key: Char);
    procedure btnVerificarClick(Sender: TObject);
  private
    { Private declarations }
    DteLic  : TDateTime;
    Sequenc : string;
  public
    { Public declarations }
  end;

var
  fmManAut: TfmManAut;

implementation

uses dxDemoUtils, Bbgeral, Bbfuncao, Bbmensag, ManGDB;

{$R *.DFM}

procedure TfmManAut.PaintBoxPaint(Sender: TObject);
begin
  inherited;
  with Sender as TPaintBox do FillGrayGradientRect(PaintBox.Canvas, PaintBox.ClientRect, PaintBox.Color);
end;

procedure TfmManAut.FormShow(Sender: TObject);
var
  Dia    : string;
  Mes    : string;
  Ano    : string;
  sCarac : array[1..10] of string;
  sValor : string;
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

  DteLic := StrToDate(Dia+'/'+Mes+'/'+Ano);

  sCarac[01] := 'AK';
  sCarac[02] := 'QW';
  sCarac[03] := 'PG';
  sCarac[04] := 'CV';
  sCarac[05] := 'XF';
  sCarac[06] := 'DY';
  sCarac[07] := 'ML';
  sCarac[08] := 'OZ';
  sCarac[09] := 'HT';
  sCarac[10] := 'EB';

  Randomize;
  sValor := fNumZeros(Trim(IntToStr(Random(30000))),5);

  EdSeqInf1.Text := copy(sCarac[StrToInt(copy(sValor,3,1))],1,1);
  EdSeqInf2.Text := copy(sCarac[StrToInt(copy(sValor,4,1))],2,1);
  
  EdSeqInf3.SetFocus;

end;

procedure TfmManAut.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 27 then close;
end;

procedure TfmManAut.EdSeqInf3KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not ( key in [ '0'..'9' ] ) then key := #0;
end;

procedure TfmManAut.EdSeqInf1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not ( key in [ 'A'..'Z' ] ) then key := #0;
end;

procedure TfmManAut.btnVerificarClick(Sender: TObject);
var
  Dia     : string;
  Mes     : string;
  Ano     : string;
  sError  : String;
  i       : integer;
  SeqInf1 : string;
  SeqInf2 : string;
  SeqInf3 : string;
  SeqInf4 : string;
  SeqInf5 : string;
  SeqInf6 : string;
  SeqInf7 : string;
  SeqInf8 : string;
  sCarac  : array[1..10] of string;
  sNumer  : array[1..10] of string;
  sValor  : string;
  DteSer  : TDateTime;
  SeqInf  : string;
begin
  inherited;
  if (Trim(EdSeqInf1.Text) <> '') and
     (Trim(EdSeqInf2.Text) <> '') and
     (Trim(EdSeqInf3.Text) <> '') and
     (Trim(EdSeqInf4.Text) <> '') and
     (Trim(EdSeqInf5.Text) <> '') and
     (Trim(EdSeqInf6.Text) <> '') and
     (Trim(EdSeqInf7.Text) <> '') and
     (Trim(EdSeqInf8.Text) <> '') then begin

     Dia := EdSeqInf3.Text + EdSeqInf4.Text;
     Mes := EdSeqInf5.Text + EdSeqInf6.Text;

     sError := 'Nao';
     
     with quSQL,SQL do begin

          Close;
          Text := ' Select Cast('+ QuotedStr('Today') +' as Date) as DteSer From rdb$database';
          Open;

          DteSer := StrToDate(FieldbyName('DteSer').AsString);

     end;

     if (StrToFloat(Dia)/2) <> StrToFloat(copy(FormatDateTime('dd/mm/yyyy',DteSer),1,2)) then sError := 'Sim';
     if (StrToFloat(Mes)/2) <> StrToFloat(copy(FormatDateTime('dd/mm/yyyy',DteSer),4,2)) then sError := 'Sim';

     Label2.Visible := True;

     ProgressBar.Visible := True;

     btnVerificar.Enabled := False;

     ProgressBar.Max := 10000;

     ProgressBar.Position := 0;

     SeqInf1 := EdSeqInf1.Text;
     SeqInf2 := EdSeqInf2.Text;
     SeqInf3 := EdSeqInf3.Text;
     SeqInf4 := EdSeqInf4.Text;
     SeqInf5 := EdSeqInf5.Text;
     SeqInf6 := EdSeqInf6.Text;
     SeqInf7 := EdSeqInf7.Text;
     SeqInf8 := EdSeqInf8.Text;

     EdSeqInf1.Clear;
     EdSeqInf2.Clear;
     EdSeqInf3.Clear;
     EdSeqInf4.Clear;
     EdSeqInf5.Clear;
     EdSeqInf6.Clear;
     EdSeqInf7.Clear;
     EdSeqInf8.Clear;

     sCarac[01] := 'AK';
     sCarac[02] := 'QW';
     sCarac[03] := 'PG';
     sCarac[04] := 'CV';
     sCarac[05] := 'XF';
     sCarac[06] := 'DY';
     sCarac[07] := 'ML';
     sCarac[08] := 'OZ';
     sCarac[09] := 'HT';
     sCarac[10] := 'EB';

     sNumer[01] := '5793';
     sNumer[02] := '3798';
     sNumer[03] := '3590';
     sNumer[04] := '2810';
     sNumer[05] := '5616';
     sNumer[06] := '3541';
     sNumer[07] := '1234';
     sNumer[08] := '4321';
     sNumer[09] := '5678';
     sNumer[10] := '5158';

     try

        for i := 1 to 10000 do begin

            Randomize;
            sValor := fNumZeros(Trim(IntToStr(Random(50000))),5);

            EdSeqInf1.Text := copy(sCarac[StrToInt(copy(sValor,3,1))],1,1);
            EdSeqInf2.Text := copy(sCarac[StrToInt(copy(sValor,4,1))],2,1);

            Randomize;
            sValor := FNumZeros(Trim(IntToStr(Random(40000))),5);

            EdSeqInf3.Text := copy(sNumer[StrToInt(copy(sValor,3,1))],1,1);
            EdSeqInf4.Text := copy(sNumer[StrToInt(copy(sValor,4,1))],2,1);

            Randomize;
            sValor := FNumZeros(Trim(IntToStr(Random(80000))),5);

            EdSeqInf5.Text := copy(sNumer[StrToInt(copy(sValor,3,1))],1,1);
            EdSeqInf6.Text := copy(sNumer[StrToInt(copy(sValor,4,1))],2,1);

            Randomize;
            sValor := FNumZeros(Trim(IntToStr(Random(30000))),5);

            EdSeqInf7.Text := copy(sNumer[StrToInt(copy(sValor,3,1))],1,1);
            EdSeqInf8.Text := copy(sNumer[StrToInt(copy(sValor,4,1))],2,1);

            ProgressBar.StepBy(1);

            Application.ProcessMessages;

        end;

     finally

        Label2.Visible := False;

        ProgressBar.Visible := False;

        ProgressBar.Position := 0;

        btnVerificar.Enabled := True;

     end;

     if sError = 'Nao' then begin

        DteLic := DteLic + 35;

        Dia := fNumZeros(IntToStr(StrToInt(copy(FormatDateTime('dd/mm/yyyy',DteLic),1,2)) * 8),3);
        Mes := fNumZeros(IntToStr(StrToInt(copy(FormatDateTime('dd/mm/yyyy',DteLic),4,2)) * 8),2);
        Ano := fNumZeros(IntToStr(StrToInt(copy(FormatDateTime('dd/mm/yyyy',DteLic),7,4)) * 3),5);

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

        Sequenc := fEnCripto(copy(Sequenc,1,42)+'L'+copy(Sequenc,44,11),'C');

        with quSQL,SQL do begin

             Close;
             Text := ' Update GerPar Set Flgtrg = '+ QuotedStr('*') + ',' +
                     '                   ParLib = '+ QuotedStr(Sequenc);
             ExecSQL;

        end;

        SeqInf := fEnCripto(SeqInf1+SeqInf2+SeqInf3+SeqInf4+SeqInf5+SeqInf6+SeqInf7+SeqInf8,'C');

        with quSQL,SQL do begin

             Close;
             Text := ' Insert Into GerLib(Id_GerLib,DteLib,HreLib,Id_GerUsu,DteLic,SeqInf)'+
                     '             Values(:Id_GerLib,:DteLib,:HreLib,:Id_GerUsu,:DteLic,:SeqInf)';

             with Params do begin

                  Params[00].AsInteger  := 1;
                  Params[01].AsDateTime := date;
                  Params[02].AsString   := TimeToStr(Time);
                  Params[03].AsInteger  := GUsu_Id;
                  Params[04].AsDateTime := DteLic;
                  Params[05].AsString   := SeqInf;

             end;

             ExecSQL;

        end;

        EdSeqInf1.Clear;
        EdSeqInf2.Clear;
        EdSeqInf3.Clear;
        EdSeqInf4.Clear;
        EdSeqInf5.Clear;
        EdSeqInf6.Clear;
        
        fmsg('Novo Licenciamento gerado com Sucesso.','I');

        GLibAce := 'Sim';

        Close;

        end
     else
        begin

        EdSeqInf1.Text := SeqInf1;
        EdSeqInf2.Text := SeqInf2;
        EdSeqInf3.Text := SeqInf3;
        EdSeqInf4.Text := SeqInf4;
        EdSeqInf5.Text := SeqInf5;
        EdSeqInf6.Text := SeqInf6;

        fmsgErro('Numero de autorização informado esta incorreto.',EdSeqInf3);

     end;

     end
  else
     begin

     if Trim(EdSeqInf3.Text) = '' then fmsgErro('Campo de preenchimento obrigatorio não informado.',EdSeqInf3);
     if Trim(EdSeqInf4.Text) = '' then fmsgErro('Campo de preenchimento obrigatorio não informado.',EdSeqInf4);
     if Trim(EdSeqInf5.Text) = '' then fmsgErro('Campo de preenchimento obrigatorio não informado.',EdSeqInf5);
     if Trim(EdSeqInf6.Text) = '' then fmsgErro('Campo de preenchimento obrigatorio não informado.',EdSeqInf6);
     if Trim(EdSeqInf7.Text) = '' then fmsgErro('Campo de preenchimento obrigatorio não informado.',EdSeqInf7);
     if Trim(EdSeqInf8.Text) = '' then fmsgErro('Campo de preenchimento obrigatorio não informado.',EdSeqInf8);

  end;
end;

end.
