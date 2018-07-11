unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Platform, FMX.PhoneDialer,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    lblCarrierName: TLabel;
    lblISOCountryCode: TLabel;
    btnGetCarrierInfo: TButton;
    Label1: TLabel;
    edtTelephoneNumber: TEdit;
    btnMakeCall: TButton;
    procedure btnGetCarrierInfoClick(Sender: TObject);
    procedure btnMakeCallClick(Sender: TObject);
  private
  PhoneDialerService: IFMXPhoneDialerService;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Form1: TForm1;

implementation
constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, IInterface(PhoneDialerService));
end;
{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.iPhone.fmx IOS}

procedure TForm1.btnGetCarrierInfoClick(Sender: TObject);
begin
  { test whether the PhoneDialer services are supported on your device }
  if Assigned(PhoneDialerService) then
  begin
    { if yes, then update the labels with the retrieved information }
    lblCarrierName.Text := 'Carrier Name:  '  + PhoneDialerService.GetCarrier.GetCarrierName;
    lblISOCountryCode.Text := 'ISO Country Code: ' + PhoneDialerService.GetCarrier.GetIsoCountryCode;
  end;
end;

procedure TForm1.btnMakeCallClick(Sender: TObject);
begin
  { test whether the PhoneDialer services are supported on your device }
  if Assigned(PhoneDialerService) then
  begin
    { if the Telephone Number is entered in the edit box then make the call, else
      display an error message }
    if edtTelephoneNumber.Text <> '' then
      PhoneDialerService.Call(edtTelephoneNumber.Text)
    else
    begin
      ShowMessage('Please type-in a telephone number.');
      edtTelephoneNumber.SetFocus;
    end;
  end;
end;

end.
