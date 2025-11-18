unit Fpadrao;

interface

uses
  Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  Wwquery, Wwdbgrid, hGrid, wwriched, wwdblook, hedits, stdCtrls, Wwdatsrc,
  Wwdbcomb, dxExEdtr, dxEdLib, dxDBELib, dxDBGrid, dbTables, Db, Hnavspeed, DBGrids;

type
  TfmPadrao = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CentralizaForm;
    procedure FormShow(Sender: TObject);
    procedure AbreDataSet;
  private
    {Private declarations}

    procedure AplicPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  public
    {Public declarations}
  end;

var
  fmPadrao: TfmPadrao;

implementation

uses hNavigator, ManGDB, ManPri;

{$R *.DFM}

{*************************************************************************
* Rotina: inicialização dos componentes de acesso ao BD
*************************************************************************}

procedure TfmPadrao.FormCreate(Sender: TObject);
var
  i: Integer;
begin

  DecimalSeparator := ',';
  ThousandSeparator := '.';
  LongDateFormat := 'dd/MM/yyyy';
  ShortDateFormat := 'dd/MM/yyyy';

  AbreDataSet;
  GnNavig := 0; // Controle de navegadores.
  with Self do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is ThDbNavigator) then
      begin // Permissões da transação
        Inc(GnNavig);
        with ThDbNavigator(Components[i]) do
        begin
          Permissao := GFprm;
          Liberado := GLibAce;
          DatabaseName := GDatabaseName;
          DataSource.AutoEdit := False;
          if (copy(Permissao, 2, 1) = 'S') then
            DataSource.AutoEdit := True;
          GDSNavig := DataSource.Name;
        end;
      end;
      if (Components[i] is ThDBNavSpeed) then
      begin // Permissões da transação
        Inc(GnNavig);
        with ThDBNavSpeed(Components[i]) do
        begin
          Permissao := GFprm;
          Liberado := GLibAce;
          DatabaseName := GDatabaseName;
          DataSource.AutoEdit := False;
          if (copy(Permissao, 2, 1) = 'S') then
            DataSource.AutoEdit := True;
          GDSNavig := DataSource.Name;
        end;
      end;
    end;
    Tag := GnNavig;
  end;

end;

{*************************************************************************
* Rotina: encerramento do form
*************************************************************************}

procedure TfmPadrao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 40) or (key = 38) then
  begin

    if not ((ActiveControl is ThGrid) or (ActiveControl is TwwDbRichEdit) or (ActiveControl is TdxDBPickEdit) or
      (ActiveControl is TComboBox) or (ActiveControl is TwwDBComboBox) or (ActiveControl is TwwDbLookupCombo) or
      (ActiveControl is TdxDBLookupEdit) or (ActiveControl is TdxPickEdit) or (ActiveControl is TdxSpinEdit) or
      (ActiveControl is TdxDBPickEdit) or (ActiveControl is TdxDBSpinEdit) or (ActiveControl is TdxDBMemo) or
      (ActiveControl is TwwDBGrid) or (ActiveControl is TdxDBGrid) or (ActiveControl is TDBGrid)) then
    begin

      if key = 40 then
        Perform(Wm_NextDlgCtl, 0, 0)
      else
        Perform(Wm_NextDlgCtl, 1, 0);

    end;

  end
  else
  begin

    if not ((ActiveControl is TdxDBMemo)) then
    begin

      if key = 13 then
        Perform(Wm_NextDlgCtl, 0, 0)

    end;
  end;




end;

procedure TfmPadrao.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
  sDs: string;
begin

  if Tag > 0 then
  begin // Se Existem Componentes navigators no Formulario //

    // Se a Tecla foi Pressionada em Algum destes Controles //
    if (ActiveControl is ThGrid) or (ActiveControl is ThDbEdit) or (ActiveControl is ThEditAlfa) or
      (ActiveControl is TwwDbLookupCombo) or (ActiveControl is TwwDBGrid) or (ActiveControl is TdxDBEdit) or (ActiveControl is TdxDBPickEdit) or
      (ActiveControl is TdxDBLookupEdit) or (ActiveControl is TdxDBCurrencyEdit) or (ActiveControl is TdxDBDateEdit) or
      (ActiveControl is TdxDBHyperLinkEdit) or (ActiveControl is TdxEdit) or (ActiveControl is TdxDBMemo) or (ActiveControl is TdxDBGrid) or
      (ActiveControl is TdxDBMaskEdit) then
    begin

      if (key = #1) or (key = #3) or (key = #9) or (key = #5) or (key = #19) or (Key = #2) or (key = #4) then
      begin // Se foi Uma Dessas Teclas a Pressionada //

        if (ActiveControl is TdxDBHyperLinkEdit) then
        begin

          with TdxDBHyperLinkEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBBlobEdit) then
        begin

          with TdxDBBlobEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBDateEdit) then
        begin

          with TdxDBDateEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBCurrencyEdit) then
        begin

          with TdxDBCurrencyEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBLookupEdit) then
        begin

          with TdxDBLookupEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBPickEdit) then
        begin

          with TdxDBPickEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBEdit) then
        begin

          with TdxDBEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBMaskEdit) then
        begin

          with TdxDBMaskEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TdxDBMemo) then
        begin

          with TdxDBMemo(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is ThGrid) then
        begin

          with ThGrid(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is TwwDBGrid) then
        begin

          with TwwDBGrid(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;

        end

        else if (ActiveControl is ThDbEdit) then
        begin

          with ThDbEdit(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;
        end

        else if (ActiveControl is TwwDbLookupCombo) then
        begin
          with TwwDbLookupCombo(ActiveControl) do
          begin
            sDs := datasource.Name;
          end;
        end

        else if (ActiveControl is ThEditAlfa) or (ActiveControl is TdxEdit) then
        begin

          sDs := GDSNavig;

        end;

        // Verifica qual NAVIGATOR contém o DSOURCE localizado. //
        for i := 0 to ComponentCount - 1 do
        begin

          if (Components[i] is ThDbNavigator) then
          begin

            with ThDbNavigator(Components[i]) do
            begin

              if datasource.Name = sDs then
              begin

                if not Salvar then
                begin

                  if (hNavigator.nbExclui in EnabledButtons) and (Key = #5) then
                    SBExcluiClick(Sender);

                  if (hNavigator.nbInclui in EnabledButtons) and (Key = #9) then
                    SBIncluiClick(Sender);

                  exit;

                end
                else
                begin

                  if (hNavigator.nbSalva in EnabledButtons) and (Key = #19) then
                    SBSalvaClick(Sender);

                  exit;

                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfmPadrao.FormActivate(Sender: TObject);
begin
  if Assigned(fmManPri) then
  begin
    if fmManPri.PopMenu.AutoPopup then
      fmManPri.PopMenu.AutoPopup := False;
  end;
end;

procedure TfmPadrao.FormDestroy(Sender: TObject);
var
  i: Integer;
begin

  with Self do
  begin

    for i := 0 to ComponentCount - 1 do
    begin

      if (Components[i] is TwwQuery) then
      begin

        if Assigned(TwwQuery(Components[i])) then
        begin

          with TwwQuery(Components[i]) do
          begin

            if Active then
              Active := False;

          end;
        end;
      end;

      if (Components[i] is TQuery) then
      begin

        if Assigned(TQuery(Components[i])) then
        begin

          with TQuery(Components[i]) do
          begin

            if Active then
              Active := False;

          end;
        end;
      end;
    end;
  end;

  GnNavig := 0; // Controle Tem Navegador
  GDSNavig := ''; // Informa o nome do data Source do primeiro NAVIGATOR.

  if Assigned(fmManPri) then
    fmManPri.PopMenu.AutoPopup := True;

end;

procedure TfmPadrao.CentralizaForm;
var
  x, y: Integer;
begin
  if Self.FormStyle = fsMDIChild then
  begin
    X := (Application.MainForm.Width - (Self.Width + 30)) div 2;
    Y := (Application.MainForm.Height - (Self.Height + 90)) div 2;
  end
  else
  begin
    X := (Screen.Width - (Self.Width)) div 2;
    Y := (Screen.Height - (Self.Height)) div 2;
  end;
  if (X < 0) or (X + Self.Width > Application.MainForm.Width) then
    X := 0;
  if (Y < 0) or (Y + Self.Height > Application.MainForm.Height) then
    Y := 0;
  SetBounds(X, Y, Self.Width, Self.Height);
end;

procedure TfmPadrao.FormShow(Sender: TObject);
begin
  CentralizaForm;
end;

procedure TfmPadrao.AbreDataSet;
var
  intCont, i: integer;
begin
  intcont := Self.ComponentCount;

  for i := 0 to intCont - 1 do
  begin
    try
      if self.Components[i].tag <> 99 then
      begin

        if ((UpperCase(self.Components[i].Name) <> 'QUSQL') and (UpperCase(self.Components[i].Name) <> 'QUSQL1') and (UpperCase(self.Components[i].Name) <> 'QUSQL2') and
          (UpperCase(self.Components[i].Name) <> 'QUSQL3')) then
        begin
          if self.Components[i] is TwwQuery then
          begin
            Twwquery(self.Components[i]).active := True;
          end;
          if ((UpperCase(self.Components[i].Name) <> 'QUSQL') and (UpperCase(self.Components[i].Name) <> 'QUSQL1') and (UpperCase(self.Components[i].Name) <> 'QUSQL2') and
            (UpperCase(self.Components[i].Name) <> 'QUSQL3')) then
            if self.Components[i] is TQuery then
            begin
              TQuery(self.Components[i]).active := True;
            end;
        end;
      end;
    except
    end;
  end;
end;

procedure TfmPadrao.AplicPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  showmessage(e.Message);
end;

end.

