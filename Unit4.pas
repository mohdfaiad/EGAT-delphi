unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  IPPeerClient, REST.Backend.ServiceTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, REST.Backend.Providers,
  REST.Backend.ServiceComponents, REST.Backend.KinveyProvider, FMX.ListView,
  FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl,
  System.Actions, FMX.ActnList,System.Notification,
  REST.Backend.KinveyPushDevice, System.PushNotification,
  REST.Backend.PushTypes, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice,
  FMX.ScrollBox, FMX.Memo, FMX.WebBrowser;

type
  TForm4 = class(TForm)
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    RefreshButton: TButton;
    Edit1: TEdit;
    AddItemButton: TButton;
    ListView1: TListView;
    KinveyProvider1: TKinveyProvider;
    BackendStorage1: TBackendStorage;
    ToolBar2: TToolBar;
    SpeedButton2: TSpeedButton;
    Switch1: TSwitch;
    Memo1: TMemo;
    PushEvents1: TPushEvents;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    ChangeTabAction3: TChangeTabAction;
    TabItem3: TTabItem;
    SpeedButton3: TSpeedButton;
    ToolBar3: TToolBar;
    SpeedButton4: TSpeedButton;
    Label2: TLabel;
    WebBrowser1: TWebBrowser;
    ToolBar4: TToolBar;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    procedure AddItemButtonClick(Sender: TObject);
    procedure ListView1DeletingItem(Sender: TObject; AIndex: Integer;
      var ACanDelete: Boolean);
    procedure RefreshButtonClick(Sender: TObject);
    procedure ListView1DeleteItem(Sender: TObject; AIndex: Integer);
    procedure PushEvents1DeviceRegistered(Sender: TObject);
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure PushEvents1PushReceived(Sender: TObject; const AData: TPushData);
    procedure Edit2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure OpenURL;
  public
    { Public declarations }
    procedure RefreshList;
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.SSW3.fmx ANDROID}

//Web brower
procedure TForm4.OpenURL;
begin
  WebBrowser1.Navigate(Edit2.Text);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
   WebBrowser1.GoBack;
end;

procedure TForm4.Edit2Change(Sender: TObject);
begin
  OpenURL;
end;


//Backend Storage
procedure TForm4.AddItemButtonClick(Sender: TObject);
var
    LJSONObject: TJSONObject;
    LEntity: TBackendEntityValue;
begin
    if Edit1.Text = '' then
      ShowMessage('Please, enter an item.')
    else
      begin
        LJSONObject := TJSONObject.Create;
        LJSONObject.AddPair('item', Edit1.Text);
        BackendStorage1.Storage.CreateObject('ShoppingList', LJSONObject, LEntity);
        ShowMessage('New item created: ' +Edit1.Text);
        LJSONObject.Free;
        Edit1.Text := '';
        RefreshList;
      end

end;


procedure TForm4.ListView1DeleteItem(Sender: TObject; AIndex: Integer);
begin
    RefreshList;
end;

procedure TForm4.ListView1DeletingItem(Sender: TObject; AIndex: Integer;
  var ACanDelete: Boolean);
var
  LQuery: string;
  LJSONArray : TJSONArray;
  LEntities: TArray<TBackendEntityValue>;
begin
  ACanDelete := False;
  LJSONArray := TJSONArray.Create;
  try
    LQuery := Format('query={"item":"%s"}', [(Sender as TListView).Items[AIndex].Text]); // 'query={"item":"%s"}' in Kinvey and 'where={"item":"%s"}' in Parse
    BackendStorage1.Storage.QueryObjects('ShoppingList', [LQuery], LJSONArray, LEntities);
    if (Length(LEntities) > 0) and BackendStorage1.Storage.DeleteObject('ShoppingList', LEntities[0].ObjectID) then
      ACanDelete := True
    else
      ShowMessage ('Item could not be deleted.');
  finally
    LJSONArray.Free;
  end;
end;

procedure TForm4.RefreshButtonClick(Sender: TObject);
begin
  RefreshList;
end;


procedure TForm4.RefreshList;
var
  LJSONArray : TJSONArray;
  LItem: TListViewItem;
  I: Integer;
begin
  LJSONArray := TJSONArray.Create;
  try
    BackendStorage1.Storage.QueryObjects('ShoppingList', [], LJSONArray);
    ListView1.Items.Clear;
    for I := 0 to LJSONArray.Count-1 do
    begin
      LItem := ListView1.Items.Add;
      LItem.Text := (LJSonArray.Items[I].GetValue<string>('item'));
    end;
  finally
    LJSONArray.Free;
  end;
 end;


//Notification
procedure TForm4.PushEvents1DeviceRegistered(Sender: TObject);
begin
  Memo1.Lines.Add('Device Registered' + LineFeed);
end;

procedure TForm4.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
    Memo1.Lines.Add('Device Token Received' + LineFeed);
end;

procedure TForm4.PushEvents1DeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  Memo1.Lines.Add('Device Token Request Failed');
  Memo1.Lines.Add(AErrorMessage + LineFeed);
end;

procedure TForm4.PushEvents1PushReceived(Sender: TObject;
  const AData: TPushData);
var
  NC: TNotificationCenter;
  N: TNotification;
begin
  Memo1.Lines.Add('Push Recieved' + LineFeed);
  Memo1.Lines.Add(AData.Message);
  Memo1.Lines.Add('');
  NC := TNotificationCenter.Create(Nil);
  N := NC.CreateNotification;

  Try
    if NC.Supported then
    begin
      N.Title := 'Delphi.Uz';
      N.AlertBody := AData.Message;
      N.EnableSound := True;
      N.Number := 1;
      NC.ApplicationIconBadgeNumber := 1;
      NC.PresentNotification(N);
    end;
  Finally
    NC.Free;
    N.Free;
  End;
end;


end.
