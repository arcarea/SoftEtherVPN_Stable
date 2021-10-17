SETLOCAL
SET BATCH_FILE_NAME=%0
SET BATCH_DIR_NAME=%0\..
SET NOW_TMP=%time:~0,2%
SET NOW=%date:~0,4%%date:~5,2%%date:~8,2%_%NOW_TMP: =0%%time:~3,2%%time:~6,2%

rem call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"

rem call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"

cd "C:\Program Files (x86)\Microsoft Visual Studio\Installer"
for /f "usebackq tokens=*" %%A IN (`vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) DO @set vcdir=%%A
"%vcdir%\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64


del %BATCH_DIR_NAME%\bin\BuildUtil.exe

C:\windows\Microsoft.NET\Framework\v3.5\MSBuild.exe /toolsversion:3.5 /verbosity:detailed /target:Clean /property:Configuration=Debug "%BATCH_DIR_NAME%\BuildUtil\BuildUtil.csproj"

C:\windows\Microsoft.NET\Framework\v3.5\MSBuild.exe /toolsversion:3.5 /verbosity:detailed /target:Rebuild /property:Configuration=Debug "%BATCH_DIR_NAME%\BuildUtil\BuildUtil.csproj"

cmd /k "%BATCH_DIR_NAME%\bin\BuildUtil.exe /CMD:All"


