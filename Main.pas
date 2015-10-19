unit Main;

interface //#################################################################### ■

uses
  System.Types, System.UITypes, System.Classes, System.SysUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Objects, FMX.Media, FMX.Graphics,
  FMX.StdCtrls, FMX.Controls.Presentation,
  LUX.Vision.OpenCV, LUX.Vision.OpenCV.Capture, LUX.Vision.OpenCV.Detect;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Camera :TocvCamera;
    _Detect :THaarCascade;
    _Image  :TocvBitmap4;
    ///// メソッド
    procedure ShowDetect;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowDetect;
var
   I :Integer;
begin
     _Camera.Frame.CopyTo( _Image );

     _Image.CopyTo( Image1.Bitmap );

     with Image1.Bitmap.Canvas do
     begin
          BeginScene;

          with Stroke do
          begin
               Color     := TAlphaColorRec.Red;
               Thickness := 2;
          end;

          with _Detect do
          begin
               for I := 0 to FaceN-1 do DrawEllipse( TRectF.Create( Box[ I ] ), 1 );
          end;

          EndScene;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Camera := TocvCamera.Create( 0 );

     _Detect := THaarCascade.Create( '..\..\_DATA\Cascade\Haar\haarcascade_frontalface_default.xml' );

     with _Camera do
     begin
          _Image := TocvBitmap4.Create( FrameWidth, FrameHeight );

          Image1.Bitmap.SetSize( FrameWidth, FrameHeight );
     end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Image.Free;

     _Detect.Free;

     _Camera.Free;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     _Camera.QueryFrame;

     _Detect.Search( _Camera.Frame );

     ShowDetect;
end;

end. //######################################################################### ■
