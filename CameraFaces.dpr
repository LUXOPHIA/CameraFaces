﻿program CameraFaces;

uses
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  LUX.Vision.OpenCV in '_LIBRARY\LUX.idea\» Vision\» OpenCV\LUX.Vision.OpenCV.pas',
  LUX.Vision.OpenCV.Capture in '_LIBRARY\LUX.idea\» Vision\» OpenCV\LUX.Vision.OpenCV.Capture.pas',
  LUX.Vision.OpenCV.Detect in '_LIBRARY\LUX.idea\» Vision\» OpenCV\LUX.Vision.OpenCV.Detect.pas',
  ocv.core.types_c in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.core.types_c.pas',
  ocv.core_c in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.core_c.pas',
  ocv.highgui_c in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.highgui_c.pas',
  ocv.imgproc.types_c in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.imgproc.types_c.pas',
  ocv.imgproc_c in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.imgproc_c.pas',
  ocv.lib in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.lib.pas',
  ocv.objdetect_c in '_LIBRARY\LUX.idea\» Vision\» OpenCV\› Laex\Delphi-OpenCV\source\ocv.objdetect_c.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.