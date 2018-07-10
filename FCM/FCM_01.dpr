program FCM_01;

uses
  System.StartUpCopy,
  FMX.Forms,
  FCM in 'FCM.pas' {Form3},
  DW.PushClient in 'FCM\DW.PushClient.pas',
  DW.RegisterFCM in 'FCM\DW.RegisterFCM.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
