program BaaSUsers;

uses
  System.StartUpCopy,
  FMX.Forms,
  BaaS in 'BaaS.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
