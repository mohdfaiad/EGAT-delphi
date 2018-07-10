unit FCM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,DW.PushClient,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,System.PushNotification;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);

  private
    FPushClient: TPushClient;
    procedure PushClientChangeHandler(Sender: TObject; AChange: TPushService.TChanges);
    procedure PushClientReceiveNotificationHandler(Sender: TObject; const ANotification: TPushServiceNotification);

  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

const
  cFCMSenderID = '1037658936759';
  cFCMServerKey = 'AIzaSyCRuEMYS7zYnKjTwLHWRS0MJEG8EVbTQ0E';
  cFCMBundleID = 'com.embarcadero.push';

procedure TForm3.FormCreate(Sender: TObject);
begin
  FPushClient := TPushClient.Create;
  FPushClient.GCMAppID := cFCMSenderID;
  FPushClient.ServerKey := cFCMServerKey;
  FPushClient.BundleID := cFCMBundleID;
  FPushClient.UseSandbox := True; // Change this to False for production use!
  FPushClient.OnChange := PushClientChangeHandler;
  FPushClient.OnReceiveNotification := PushClientReceiveNotificationHandler;
  FPushClient.Active := True;
end;

procedure TForm3.PushClientChangeHandler(Sender: TObject; AChange: TPushService.TChanges);
begin
  if TPushService.TChange.DeviceToken in AChange then
  begin
    Memo1.Lines.Add('DeviceID = ' + FPushClient.DeviceID);
    Memo1.Lines.Add('DeviceToken = ' + FPushClient.DeviceToken);
  end;
end;

procedure TForm3.PushClientReceiveNotificationHandler(Sender: TObject; const ANotification: TPushServiceNotification);
begin
  Memo1.Lines.Add('Notification: ' + ANotification.DataObject.ToString);
end;



end.
