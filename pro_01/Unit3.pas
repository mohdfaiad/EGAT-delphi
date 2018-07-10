unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls;

type
  TForm3 = class(TForm)
    DateEdit1: TDateEdit;
    procedure DateEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TForm3.DateEdit1Change(Sender: TObject);
begin
  ShowMessage(FormatDateTime('dddddd', DateEdit1.Date));
end;

end.
