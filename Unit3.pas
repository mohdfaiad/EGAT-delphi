unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Notification, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm3 = class(TForm)
    NotificationCenter1: TNotificationCenter;
    SetNumber: TButton;
    procedure SetNumberClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.SetNumberClick(Sender: TObject);

       var
  MyNotification: TNotification;
begin
  // Create an instance of TNotification
  MyNotification := NotificationCenter1.CreateNotification;
  try
      // --- your code goes here ---
      // Set the icon or notification number
      MyNotification.Number :=18;
      // Set the alert message
      MyNotification.AlertBody := 'Delphi for your mobile device is here!';
      // Note: You must send the notification to the notification center for the Icon Badge Number to be displayed.
      NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

end.
