unit FShowpadrao;

interface

uses
  SysUtils, Messages, Classes, Controls, Forms,
  Wwquery, Wwdbgrid, hGrid, wwriched, wwdblook, hedits, stdCtrls, Wwdatsrc,
  Wwdbcomb, dxExEdtr, dxEdLib, dxDBELib, dxDBGrid, dbTables, ExtCtrls;

type
  TfmShowPadrao = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmShowPadrao: TfmShowPadrao;

implementation

uses hNavigator, ManGDB;

{$R *.DFM}

{*************************************************************************
* Rotina: inicialização dos componentes de acesso ao BD
*************************************************************************}

procedure TfmShowPadrao.FormCreate(Sender: TObject);
var
  j, i: Integer;
begin

  GnNavig := 0; {Controle de navegadores.}

  with Self do
  begin

    for i := 0 to ComponentCount - 1 do
    begin

      if (Components[i] is ThDbNavigator) then
      begin {Permissões da transação}

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

      {Preenche o parametro CODEMP com a empresa ativa NA QUERY}
      if (Components[i] is TwwQuery) then
      begin

        with TwwQuery(Components[i]) do
        begin

          if (Tag = 0) then
          begin

            {if Active then Close;
            { Verifica se existe parâmetro definido para seleção por código da
            empresa. Se o mesmo estiver definido, o sistema assume a
            empresa ativa para seleção dos dados.}

            for j := 0 to ParamCount - 1 do
            begin
              if (UpperCase(Params.Items[j].Name) = 'PCODEMP') then
                Params.Items[j].AsInteger := GEmp_Id;
            end;
          end;
        end;
      end;

      {Preenche o parametro CODEMP com a empresa ativa NA QUERY }
      if (components[i] is ThEditAlfa) then
      begin
        if (UpperCase(components[i].Name) = 'EDPSQCODEMP') then
        begin
          with ThEditAlfa(Components[i]) do
          begin
            Text := IntToStr(GEmp_Id);
          end;
        end;
      end;

      if (components[i] is TEdit) then
      begin
        if (UpperCase(components[i].Name) = 'EDPSQAPEEMP') then
        begin
          with TEdit(Components[i]) do
          begin
            Text := GRazEmp;
          end;
        end;
      end;
    end;

    Tag := GnNavig;

  end;
end;

{*************************************************************************
* Rotina: encerramento do form
*************************************************************************}

procedure TfmShowPadrao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 40) or (key = 38) then
  begin

    if not ((ActiveControl is ThGrid) or (ActiveControl is TwwDbRichEdit) or (ActiveControl is TdxDBPickEdit) or
      (ActiveControl is TComboBox) or (ActiveControl is TwwDBComboBox) or (ActiveControl is TwwDbLookupCombo) or
      (ActiveControl is TdxDBLookupEdit) or (ActiveControl is TdxPickEdit) or (ActiveControl is TdxSpinEdit) or (ActiveControl is TdxDBPickEdit) or
      (ActiveControl is TdxDBSpinEdit) or (ActiveControl is TdxDBMemo) or (ActiveControl is TwwDBGrid) or (ActiveControl is TdxDBGrid)) then
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

procedure TfmShowPadrao.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
  sDs: string;
begin

  if Tag > 0 then
  begin {Se Existem Componentes navigators no Formulario}

    {Se a Tecla foi Pressionada em Algum destes Controles}
    if (ActiveControl is ThGrid) or (ActiveControl is ThDbEdit) or (ActiveControl is ThEditAlfa) or
      (ActiveControl is TwwDbLookupCombo) or (ActiveControl is TwwDBGrid) or (ActiveControl is TdxDBEdit) or (ActiveControl is TdxDBPickEdit) or
      (ActiveControl is TdxDBLookupEdit) or (ActiveControl is TdxDBCurrencyEdit) or (ActiveControl is TdxDBDateEdit) or
      (ActiveControl is TdxDBHyperLinkEdit) or (ActiveControl is TdxEdit) or (ActiveControl is TdxDBMemo) or (ActiveControl is TdxDBGrid) or
      (ActiveControl is TdxDBMaskEdit) then
    begin

      if (key = #1) or (key = #3) or (key = #9) or (key = #5) or (key = #19) or (Key = #2) or (key = #4) then
      begin {Se foi Uma Dessas Teclas a Pressionada}

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

        {Verifica qual NAVIGATOR contém o DSOURCE localizado.}
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

procedure TfmShowPadrao.FormDestroy(Sender: TObject);
var
  i: integer;
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

end;

end.
