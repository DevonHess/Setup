@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@ECHO OFF
CD /D "%~dp0"

CALL Tools\Chocolatey.bat
ECHO:
CALL Tools\Tweak.bat 1
ECHO:
CALL Tools\BackupRestore.bat 4

PAUSE
