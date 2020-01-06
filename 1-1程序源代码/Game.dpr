program Game;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  GameProc in 'GameProc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
