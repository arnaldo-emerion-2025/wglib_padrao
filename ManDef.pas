unit ManDef;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxfProgressBar, ExtCtrls, ComCtrls, Db, DBTables, Wwquery;

type
  TfmManDef = class(TForm)
    Panel1: TPanel;
    Label4: TLabel;
    PB5: TdxfProgressBar;
    GerAce: TwwQuery;
    GerAceCODTRA: TStringField;
    GerAceTIPACE: TStringField;
    GerAceCODGUS: TIntegerField;
    GerAceTIPTRA: TStringField;
    procedure ConsAce;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    programa, result: string;
    {Private declarations}
  public
    {Public declarations}
  end;

var
  fmManDef: TfmManDef;

implementation

uses ManGDB, ManPri;

{$R *.DFM}

procedure TfmManDef.ConsAce;
begin
  try
    GerAce.Locate('CODGUS;CODTRA;TIPTRA', VarArrayOf([GGus_Id, programa, GModAce]), [LoPartialKey]);
    if copy(programa, 1, 3) <> 'ABE' then
    begin
      if (GGus_Id <> 1) and (GUsu_Id <> 1) and (GUsu_Id <> 999) then
      begin

        if (GerAceCODGUS.Value = GGus_Id) and (GerAceCODTRA.Value = programa) and (GerAceTIPTRA.Value = GModAce) then
        begin

          if Trim(GerAceTIPACE.Value) <> '' then
          begin

            if Trim(GerAceTIPACE.Value) <> '0-Negado' then
              Result := 'S'
            else
              Result := 'N';

          end
          else
            Result := 'N';

        end
        else
          Result := 'N';

      end
      else
        Result := 'S';

    end
    else
      Result := 'S';
  except
    showmessage(programa);
  end;
end;

procedure TfmManDef.FormShow(Sender: TObject);
var
  i, j, l, m, n, o: integer;
begin

  if fmManPri.mmMenu.Items.Count > 0 then
  begin

    PB5.Max := fmManPri.mmMenu.Items.Count - 1;

    PB5.Position := 0;

    for i := 0 to fmManPri.mmMenu.Items.Count - 1 do
    begin

      if fmManPri.mmMenu.Items[i].Count > 0 then
      begin

        result := 'N';

        programa := fmManPri.mmMenu.Items[i].Name;

        consace;

        if result = 'S' then
        begin

          fmManPri.mmMenu.Items[i].Enabled := True;

          for j := 0 to fmManPri.mmMenu.Items[i].Count - 1 do
          begin

            if fmManPri.mmMenu.Items[i].Items[j].Count > 0 then
            begin

              result := 'N';

              programa := fmManPri.mmMenu.Items[i].Items[j].Name;

              consace;

              if Result = 'S' then
              begin

                fmManPri.mmMenu.Items[i].Items[j].Enabled := True;

                for l := 0 to fmManPri.mmMenu.Items[i].Items[j].Count - 1 do
                begin

                  if fmManPri.mmMenu.Items[i].Items[j].Items[l].Count > 0 then
                  begin

                    result := 'N';

                    programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Name;

                    consace;

                    if Result = 'S' then
                    begin

                      fmManPri.mmMenu.Items[i].Items[j].Items[l].Enabled := True;

                      for m := 0 to fmManPri.mmMenu.Items[i].Items[j].Items[l].Count - 1 do
                      begin

                        if fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Count > 0 then
                        begin

                          result := 'N';

                          programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Name;

                          consace;

                          if Result = 'S' then
                          begin

                            fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Enabled := True;

                            for n := 0 to fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Count - 1 do
                            begin

                              if fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Count > 0 then
                              begin

                                result := 'N';

                                programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Name;

                                consace;

                                if Result = 'S' then
                                begin

                                  fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Enabled := True;

                                  for o := 0 to fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Count - 1 do
                                  begin

                                    if fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Items[o].Count = 0 then
                                    begin

                                      result := 'N';

                                      programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Items[o].Name;

                                      consace;

                                      if Result = 'S' then
                                        fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Items[o].Enabled := True
                                      else
                                        fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Items[o].Enabled := False;
                                    end;
                                  end;

                                end
                                else
                                  fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Enabled := False;

                              end
                              else
                              begin

                                result := 'N';

                                programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Name;

                                consace;

                                if Result = 'S' then
                                  fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Enabled := True
                                else
                                  fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Items[n].Enabled := False;

                              end;
                            end;

                          end
                          else
                            fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Enabled := False;

                        end
                        else
                        begin

                          result := 'N';

                          programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Name;

                          consace;

                          if Result = 'S' then
                            fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Enabled := True
                          else
                            fmManPri.mmMenu.Items[i].Items[j].Items[l].Items[m].Enabled := False;
                        end;
                      end;

                    end
                    else
                      fmManPri.mmMenu.Items[i].Items[j].Items[l].Enabled := False;

                  end
                  else
                  begin

                    result := 'N';

                    programa := fmManPri.mmMenu.Items[i].Items[j].Items[l].Name;

                    consace;

                    if Result = 'S' then
                      fmManPri.mmMenu.Items[i].Items[j].Items[l].Enabled := True
                    else
                      fmManPri.mmMenu.Items[i].Items[j].Items[l].Enabled := False;
                  end;
                end;

              end
              else
                fmManPri.mmMenu.Items[i].Items[j].Enabled := False;

            end
            else
            begin

              result := 'N';

              programa := fmManPri.mmMenu.Items[i].Items[j].Name;

              consace;

              if Result = 'S' then
                fmManPri.mmMenu.Items[i].Items[j].Enabled := True
              else
                fmManPri.mmMenu.Items[i].Items[j].Enabled := False;
            end;
          end;

        end
        else
          fmManPri.mmMenu.Items[i].Enabled := False;

      end
      else
      begin

        result := 'N';

        programa := fmManPri.mmMenu.Items[i].Name;

        consace;

        if Result = 'S' then
          fmManPri.mmMenu.Items[i].Enabled := True
        else
          fmManPri.mmMenu.Items[i].Enabled := False;

      end;

      if i > 0 then
        PB5.StepBy(1);

    end;
  end;
end;

procedure TfmManDef.FormCreate(Sender: TObject);
begin

  GerAce.Close;
  GerAce.Params[0].AsInteger := GGus_Id;
  GerAce.Params[1].AsString := GModAce;
  GerAce.Open;

end;

end.
