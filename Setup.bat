@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0"

ECHO Running Setup Scripts
ECHO:
CALL %~dp0\Tools\Activate.bat
ECHO:
CALL %~dp0\Tools\Tweak.bat 1
ECHO:
CALL %~dp0\Tools\Chocolatey.bat
ECHO:
CALL %~dp0\Tools\BackupRestore.bat 4
ECHO:
ECHO Setup Complete

PAUSE
