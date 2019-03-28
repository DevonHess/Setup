@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@ECHO OFF
CD /D "%~dp0"

CALL Chocolatey.bat
CALL Tweak.bat 1
CALL BackupRestore.bat 4

PAUSE
