program Project1;

uses
  Forms,
  Fpadrao in 'Fpadrao.pas' {fmPadrao};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmPadrao, fmPadrao);
  Application.Run;
end.
