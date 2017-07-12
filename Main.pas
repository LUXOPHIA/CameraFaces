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
    _Frame  :TocvBitmap1;
    ///// メソッド
    procedure ShowDetect;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses ocv.imgproc_c;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowDetect;
var
   I :Integer;
begin
     _Frame.CopyTo( Image1.Bitmap );

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
     _Camera := TocvCamera.Create( 0, 320, 240 );

     _Detect := THaarCascade.Create( '..\..\_LIBRARY\LUXOPHIA\LUX.Vision.OpenCV\'
                                   + '：Laex\Delphi-OpenCV\resource\facedetectxml\'
                                   + 'haarcascade_frontalface_default.xml' );

     with _Camera do
     begin
          _Frame := TocvBitmap1.Create( FrameWidth, FrameHeight );

          Image1.Bitmap.SetSize( FrameWidth, FrameHeight );
     end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Frame.DisposeOf;

     _Detect.DisposeOf;

     _Camera.DisposeOf;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     _Camera.QueryFrame;

     _Frame.CopyFrom( _Camera.Frame );

     _Detect.Search( _Frame );

     ShowDetect;
end;

end. //######################################################################### ■
