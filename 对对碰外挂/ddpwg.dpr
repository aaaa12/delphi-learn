program ddpwg;

uses
  Forms,
  main in 'main.pas' {MainForm},
  GamePrc in 'GamePrc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
