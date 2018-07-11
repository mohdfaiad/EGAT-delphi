unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Viewport3D,
  System.Math.Vectors, FMX.Types3D, FMX.Controls3D, FMX.MaterialSources,
  FMX.Objects3D;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Cube1: TCube;
    LightMaterialSource1: TLightMaterialSource;
    Light1: TLight;
    DummyXY: TDummy;
    CameraZ: TCamera;
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);

  private
    FDown: TPointF;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FDown := PointF(X, Y);
end;

procedure TForm1.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if ssLeft in Shift then
  begin
    DummyXY.RotationAngle.X := DummyXY.RotationAngle.X - (Y - FDown.Y);
    DummyXY.RotationAngle.Y := DummyXY.RotationAngle.Y - (X - FDown.X);
    FDown := PointF(X, Y);
  end;
end;

end.
