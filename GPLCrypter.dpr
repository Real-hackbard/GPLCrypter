program GPLCrypter;

uses
  Forms,
  Main in 'Main.pas' {FMain},
  GP_Intrf in 'GP_Intrf.pas',
  GP_Wrapper in 'GP_Wrapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
